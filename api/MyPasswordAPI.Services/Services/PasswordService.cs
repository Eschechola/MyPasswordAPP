using MyPasswordAPI.Infrastructure.Data.Repositories;

namespace MyPasswordAPI.Services.Services
{
    public class PasswordService
    {
        private readonly PasswordRepository _passwordRepository;

        public PasswordService(PasswordRepository passwordRepository)
        {
            _passwordRepository = passwordRepository;
        }
    }
}
