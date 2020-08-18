using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Services.Interfaces
{
    public interface IPasswordService
    {
        Password Insert(Password password);
    }
}
