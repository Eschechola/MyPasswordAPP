using System;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MyPasswordAPI.Application.ViewModels;
using MyPasswordAPI.Domain.DTO;
using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Domain.Validators;
using MyPasswordAPI.Services.Interfaces;

namespace MyPasswordAPI.Application.Controllers
{

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
            catch (Exception ex)
            {
                return ErrorReturn;
            }
        }
    }
}
