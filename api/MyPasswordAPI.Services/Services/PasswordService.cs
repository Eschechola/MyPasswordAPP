using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Interfaces;
using MyPasswordAPI.Services.Interfaces;

namespace MyPasswordAPI.Services.Services
{
    public class PasswordService : IPasswordService
    {
        private readonly IPasswordRepository _passwordRepository;

        public PasswordService(IPasswordRepository passwordRepository)
        {
            _passwordRepository = passwordRepository;
        }

        public Password Insert(Password password)
        {
            return _passwordRepository.Insert(password);
        }
    }
}
