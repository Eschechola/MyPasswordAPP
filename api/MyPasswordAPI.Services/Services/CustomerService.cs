using MyPasswordAPI.Infrastructure.Data.Interfaces;
using MyPasswordAPI.Services.Interfaces;

namespace MyPasswordAPI.Services.Services
{
    public class CustomerService : ICustomerService
    {
        private readonly ICustomerRepository _customerRepository;

        public CustomerService(ICustomerRepository customerRepository)
        {
            _customerRepository = customerRepository;
        }
    }
}
