using MyPasswordAPI.Domain.Enums;
using System.Collections.Generic;

namespace MyPasswordAPI.Domain.Entities
{
    public class Customer : Base
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public CustomerType Type { get; set; }

        public List<Password> Passwords { get; set; }
    }
}
