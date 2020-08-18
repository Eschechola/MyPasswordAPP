using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Interfaces;
using MyPasswordAPI.Services.Interfaces;
using System.Collections.Generic;

namespace MyPasswordAPI.Services.Services
{
    public class PasswordService : IPasswordService
    {
        private readonly IPasswordRepository _passwordRepository;

        public PasswordService(IPasswordRepository passwordRepository)
        {
            _passwordRepository = passwordRepository;
        }

        public IList<Password> GetAllFromCustomer(int userID)
        {
            return _passwordRepository.GetAllFromCustomer(userID);
        }

        public Password Insert(Password password)
        {
            return _passwordRepository.Insert(password);
        }
    }
}
