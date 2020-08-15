using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Context;

namespace MyPasswordAPI.Infrastructure.Data.Repositories
{
    public class BaseRepository<T> where T : Base 
    {
        private readonly MyPasswordContext _context;

        public BaseRepository(MyPasswordContext context)
        {
            _context = context;
        }

        public virtual T Insert(T obj)
        {
            _context.Add(obj);
            _context.SaveChanges();

            return obj;
        }

        public virtual T Update(T obj)
        {
            _context.Update(obj);
            _context.SaveChanges();

            return obj;
        }

        public virtual void Delete(int id)
        {
            var obj = Get(id);

            _context.Set<T>().Remove(obj);
            _context.SaveChanges();
        }

        public virtual T Get(int id)
        {
            return _context.Set<T>().Find(id);
        }
    }
}
