using MyPasswordAPI.Infrastructure.Data.Repositories;

namespace MyPasswordAPI.Services.Services
{
    public class CustomerService
    {
        private readonly CustomerRepository _customerRepository;

        public CustomerService(CustomerRepository customerRepository)
        {
            _customerRepository = customerRepository;
        }
    }
}
