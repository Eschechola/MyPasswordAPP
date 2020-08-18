using System;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MyPasswordAPI.Application.Controllers.Base;
using MyPasswordAPI.Application.ViewModels;
using MyPasswordAPI.Domain.DTO;
using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Domain.Validators;
using MyPasswordAPI.Services.Interfaces;

namespace MyPasswordAPI.Application.Controllers
{

    [Authorize]
    [ApiController]
    [Route("/api/password")]
    public class PasswordController : BaseController
    {
        private readonly IMapper _mapper;
        private readonly IConfiguration _configuration;
        private readonly IPasswordService _passwordService;

        public PasswordController(
            IMapper mapper,
            IConfiguration configuration,
            IPasswordService passwordService): base(configuration)
        {
            _mapper = mapper;
            _configuration = configuration;
            _passwordService = passwordService;
        }

        [HttpPost]
        [Route("insert")]
        public IActionResult InsertPassword([FromBody]PasswordDTO passwordDTO)
        {
            try
            {
                var password = _mapper.Map<Password>(passwordDTO);

                var passwordValidator = new PasswordValidator();
                var entityErrors = passwordValidator.Validate(password);

                if (entityErrors.Errors.Count > 0)
                    return BadRequest(new ResultViewModel("Corrija os campos inválidos e tente novamente.", false, entityErrors.Errors));

                var passwordInserted = _passwordService.Insert(password);

                return Ok(new ResultViewModel
                {
                   Message = "Senha inserida com sucesso.",
                   Success = true,
                   Data = passwordInserted
                });

            }
            catch (Exception)
            {
                return InternalServerError;
            }
        }

        [HttpGet]
        [Route("get-all/{userID}")]
        public IActionResult GetAllCustomerPasswords(int userID = 0)
        {
            try
            {
                if (userID == 0)
                    return BadRequest(new ResultViewModel
                    {
                        Message = "Insira um ID de usuário válido.",
                        Success = false,
                        Data = null
                    });

                var customerPasswords = _passwordService.GetAllFromCustomer(userID);

                return Ok(new ResultViewModel
                {
                    Message = "Senhas encontradas com sucesso.",
                    Success = true,
                    Data = customerPasswords
                });
            }
            catch (Exception)
            {
                return InternalServerError;
            }
        }
    }
}
