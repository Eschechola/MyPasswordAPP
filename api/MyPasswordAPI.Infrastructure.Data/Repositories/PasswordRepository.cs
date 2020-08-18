using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Context;
using MyPasswordAPI.Infrastructure.Data.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace MyPasswordAPI.Infrastructure.Data.Repositories
{
    public class PasswordRepository : BaseRepository<Password>,  IPasswordRepository
    {
        private readonly MyPasswordContext _context;

        public PasswordRepository(MyPasswordContext context) : base(context)
        {
            _context = context;
        }

        public IList<Password> GetAllFromCustomer(int userID)
        {
            var allPasswords = from pwd in _context.Passwords

                               where
                                userID == pwd.CustomerId

                               select pwd;

            return allPasswords.ToList();
        }
    }
}
