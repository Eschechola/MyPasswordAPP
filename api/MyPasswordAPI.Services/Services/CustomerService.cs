using MyPasswordAPI.Domain.Entities;
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

        public Customer GetByEmail(string email)
        {
            return _customerRepository.GetByEmail(email);
        }

        public Customer Insert(Customer customer)
        {
            return _customerRepository.Insert(customer);
        }
    }
}
