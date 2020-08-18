using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Infrastructure.Data.Interfaces
{
    public interface ICustomerRepository : IBaseRepository<Customer>
    {
        Customer GetByEmail(string email);
    }
}
