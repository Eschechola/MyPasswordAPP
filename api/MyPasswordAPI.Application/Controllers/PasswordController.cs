using System;
using Microsoft.AspNetCore.Mvc;

namespace MyPasswordAPI.Application.Controllers
{
    [Route("/api/password")]
    public class PasswordController : Controller
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok();
        }


        [HttpPost]
        public IActionResult Insert()
        {
            return Ok();
        }

        [HttpPut]
        public IActionResult Update()
        {
            return Ok();
        }

        [HttpDelete]
        public IActionResult Delete()
        {
            return Ok();
        }
    }
}
