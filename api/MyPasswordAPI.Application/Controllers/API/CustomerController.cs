using System;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MyPasswordAPI.Application.Controllers.Base;
using MyPasswordAPI.Application.ViewModels;
using MyPasswordAPI.Domain.DTO;
using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Domain.Validators;
using MyPasswordAPI.Services.Interfaces;

namespace MyPasswordAPI.Application.Controllers.API
{
    [ApiController]
    [Route("/api/customer")]
    public class CustomerController : BaseController
    {
        private readonly IMapper _mapper;
        private readonly IConfiguration _configuration;
        private readonly ICustomerService _customerService;

        public CustomerController(
            IMapper mapper,
            IConfiguration configuration,
            ICustomerService customerService) : base(configuration)
        {
            _mapper = mapper;
            _configuration = configuration;
            _customerService = customerService;
        }

        [HttpPost]
        [Route("insert")]
        public IActionResult InsertCustomer([FromBody]CustomerDTO customerDTO)
        {
            try
            {
                var customer = _mapper.Map<Customer>(customerDTO);

                var customerValidator = new CustomerValidator();
                var entityErrors = customerValidator.Validate(customer);

                if (entityErrors.Errors.Count > 0)
                    return BadRequest(new ResultViewModel("Corrija os campos inválidos e tente novamente.", false, entityErrors.Errors));

                var customerExists = _customerService.GetByEmail(customer.Email);

                if (customerExists != null)
                    return BadRequest(new ResultViewModel("O email está associado a outra conta.", false, null));

                var customerInserted = _customerService.Insert(customer);

                return Ok(new ResultViewModel
                {
                    Message = "Usuário inserido com sucesso.",
                    Success = true,
                    Data = customerInserted
                });
            }
            catch (Exception)
            {
                return InternalServerError;
            }
        }
    }
}
