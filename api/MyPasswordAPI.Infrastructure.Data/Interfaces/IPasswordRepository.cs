using MyPasswordAPI.Domain.Entities;
using System.Collections.Generic;

namespace MyPasswordAPI.Infrastructure.Data.Interfaces
{
    public interface IPasswordRepository : IBaseRepository<Password>
    {
        IList<Password> GetAllFromCustomer(int userID);
    }
}
