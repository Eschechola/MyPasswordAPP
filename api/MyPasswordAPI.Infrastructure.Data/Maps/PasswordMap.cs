using Microsoft.EntityFrameworkCore;
using MyPasswordAPI.Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace MyPasswordAPI.Infrastructure.Data.Maps
{
    public class PasswordMap : IEntityTypeConfiguration<Password>
    {
        public void Configure(EntityTypeBuilder<Password> builder)
        {
            builder.ToTable("passwords");

            builder.HasKey(x => x.Id);
            builder.Property(x => x.Id)
                .UseIdentityColumn();

            builder.Property(x => x.FkIdCustomer)
                .IsRequired()
                .HasColumnType("int");

            builder.Property(x => x.Title)
                .IsRequired()
                .HasMaxLength(40)
                .HasColumnType("varchar(40)");

            builder.Property(x => x.Value)
                .IsRequired()
                .HasMaxLength(2147483647)
                .HasColumnType("varchar(MAX)");
        }
    }
}
