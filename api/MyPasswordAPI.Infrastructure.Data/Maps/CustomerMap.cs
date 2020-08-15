using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Infrastructure.Data.Maps
{
    public class CustomerMap : IEntityTypeConfiguration<Customer>
    {
        public void Configure(EntityTypeBuilder<Customer> builder)
        {
            builder.ToTable("customers");

            builder.HasKey(x => x.Id);
            builder.Property(x => x.Id)
                .UseIdentityColumn();

            builder.Property(x => x.Name)
                .IsRequired()
                .HasMaxLength(40)
                .HasColumnType("varchar(40)");

            builder.Property(x => x.Email)
                .IsRequired()
                .HasMaxLength(180)
                .HasColumnType("varchar(180)");

            builder.Property(x => x.Password)
                .IsRequired()
                .HasMaxLength(180)
                .HasColumnType("varchar(180)");

            builder.Property(x => x.Type)
                .IsRequired()
                .HasColumnType("tinyint");
        }
    }
}
