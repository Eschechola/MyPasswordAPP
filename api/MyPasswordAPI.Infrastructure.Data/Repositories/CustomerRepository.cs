using System.Linq;
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

        public Customer GetByEmail(string email)
        {
            var allCustomers = from cst in _context.Customers

                               where
                                cst.Email == email.ToLower()

                               select cst;

            return allCustomers.ToList().FirstOrDefault();
        }
    }
}
