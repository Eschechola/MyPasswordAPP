using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Context;
using MyPasswordAPI.Infrastructure.Data.Interfaces;

namespace MyPasswordAPI.Infrastructure.Data.Repositories
{
    public class CustomerRepository : BaseRepository<Customer>, ICustomerRepository
    {
        private readonly MyPasswordContext _context;

        public CustomerRepository(MyPasswordContext context): base(context)
        {
            _context = context;
        }
    }
}
