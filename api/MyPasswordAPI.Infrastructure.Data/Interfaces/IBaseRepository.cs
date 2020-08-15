using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Infrastructure.Data.Interfaces
{
    public interface IBaseRepository<T> where T : Base
    {
        T Insert(T obj);
        T Update(T obj);
        void Delete(int id);
        T Get(int id);
    }
}
