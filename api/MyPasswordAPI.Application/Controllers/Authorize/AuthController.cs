using System;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MyPasswordAPI.Application.Controllers.Base;
using MyPasswordAPI.Application.Helpers;
using MyPasswordAPI.Application.ViewModels;
using MyPasswordAPI.Domain.DTO;
using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Services.Interfaces;

namespace MyPasswordAPI.Application.Controllers.Authorize
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : BaseController
    {
        private readonly IMapper _mapper;
        private readonly IConfiguration _configuration;
        private readonly ICustomerService _customerService;

        public AuthController(
            IMapper mapper,
            IConfiguration configuration,
            ICustomerService customerService): base(configuration)
        {
            _mapper = mapper;
            _configuration = configuration;
            _customerService = customerService;
        }

        [HttpPost]
        [Route("login")]
        public IActionResult Login([FromBody]LoginViewModel login)
        {
            try
            {
                var customer = _customerService.GetByEmail(login.Email);

                //verifica se o email informado existe
                if (customer == null)
                    return BadRequest(new ResultViewModel
                    {
                        Message = "Usuário e/ou senha está(ão) inválido(s).",
                        Success = false,
                        Data = null
                    });

                //verifica se a senha está válida
                if(login.Password != customer.Password)
                    return BadRequest(new ResultViewModel
                    {
                        Message = "Usuário e/ou senha está(ão) inválido(s).",
                        Success = false,
                        Data = null
                    });

                //retorna usuário logado junto com seu token
                return Ok(new ResultViewModel
                {
                    Message = "Login realizado com sucesso.",
                    Success = true,
                    Data = new
                    {
                        Id = customer.Id,
                        Name = customer.Name,
                        Email = customer.Email,
                        Password = customer.Password,
                        Token = TokenHelper.GenerateToken(customer.Name, customer.Email, _configuration["TokenKey"]),
                        TokenExpireDate = DateTime.Now.AddHours(23)
                    }
                });
            }
            catch (Exception)
            {
                return InternalServerError;
            }
        }
    }
}
