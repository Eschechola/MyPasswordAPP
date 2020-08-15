using Microsoft.EntityFrameworkCore;
using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Maps;

namespace MyPasswordAPI.Infrastructure.Data.Context
{
    public class MyPasswordContext : DbContext
    {
        public MyPasswordContext(DbContextOptions<MyPasswordContext> options) : base(options)
        {}

        public DbSet<Customer> Customers { get; set; }
        public DbSet<Password> Passwords { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            
            builder.ApplyConfiguration(new PasswordMap());

            builder.ApplyConfiguration(new CustomerMap());

            builder.Entity<Customer>()
                .HasIndex(c => c.Email)
                .IsUnique();

            builder.Entity<Customer>()
                .HasMany(p => p.Passwords)
                .WithOne(c => c.Customer)
                .IsRequired();
        }
    }
}
