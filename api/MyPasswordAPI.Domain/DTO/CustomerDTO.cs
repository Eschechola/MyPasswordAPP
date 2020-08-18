using MyPasswordAPI.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace MyPasswordAPI.Domain.DTO
{
    public class CustomerDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public CustomerType Type { get; set; }
    }
}
