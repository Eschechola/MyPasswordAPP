using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Services.Interfaces
{
    public interface ICustomerService
    {
        Customer Insert(Customer customer);
        Customer GetByEmail(string email);
    }
}
