using MyPasswordAPI.Domain.Entities;
using System.Collections.Generic;

namespace MyPasswordAPI.Services.Interfaces
{
    public interface IPasswordService
    {
        Password Insert(Password password);
        IList<Password> GetAllFromCustomer(int userID);
        void Delete(int id);
    }
}
