using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Context;
using MyPasswordAPI.Infrastructure.Data.Interfaces;

namespace MyPasswordAPI.Infrastructure.Data.Repositories
{
    public class PasswordRepository : BaseRepository<Password>, IPasswordRepository
    {
        private readonly MyPasswordContext _context;

        public PasswordRepository(MyPasswordContext context) : base(context)
        {
            _context = context;
        }
    }
}
