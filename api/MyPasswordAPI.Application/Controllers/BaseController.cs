using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using MyPasswordAPI.Application.ViewModels;

namespace MyPasswordAPI.Application.Controllers
{
    [ApiController]
    public class BaseController : Controller
    {
        private readonly IConfiguration _configuration;
        public readonly ObjectResult ErrorReturn;

        public BaseController(IConfiguration configuration)
        {
            _configuration = configuration;
            
            ErrorReturn = StatusCode(
                StatusCodes.Status500InternalServerError, new ResultViewModel
                {
                    Message = _configuration["ErrorObject:Message"],
                    Success = bool.Parse(_configuration["ErrorObject:Success"]),
                    Data = _configuration["ErrorObject:Data"]
                });   
        }
    }
}
