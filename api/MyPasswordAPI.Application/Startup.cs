using System;
using AutoMapper;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using MyPasswordAPI.Domain.DTO;
using MyPasswordAPI.Domain.Entities;
using MyPasswordAPI.Infrastructure.Data.Context;
using MyPasswordAPI.Infrastructure.Data.Interfaces;
using MyPasswordAPI.Infrastructure.Data.Repositories;
using MyPasswordAPI.Services.Interfaces;
using MyPasswordAPI.Services.Services;

namespace MyPasswordAPI.Application
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            #region Services

            services.AddScoped<IPasswordService, PasswordService>();
            services.AddScoped<ICustomerService, CustomerService>();

            #endregion

            #region Repositories

            services.AddScoped<IPasswordRepository, PasswordRepository>();
            services.AddScoped<ICustomerRepository, CustomerRepository>();

            #endregion

            #region Databases

            services.AddDbContext<MyPasswordContext>(options => 
                options.UseSqlServer(Configuration["ConnectionStrings:SqlServer"]));

            #endregion

            #region AutoMapper

            var autoMapperConfig = new MapperConfiguration(cfg =>
            {
                cfg.CreateMap<Password, PasswordDTO>().ReverseMap();
                cfg.CreateMap<Customer, CustomerDTO>().ReverseMap();
            });

            services.AddSingleton(autoMapperConfig.CreateMapper());

            #endregion

            #region Swagger Config

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "MyPassword",
                    Version = "v1",
                    Description = "API do aplicativo MyPassword!",
                    Contact = new OpenApiContact
                    {
                        Name = "MyPasswordAPP Developers",
                        Email = "lucas.eschechola@outlook.com",
                        Url = new Uri("https://eschechola.com.br")
                    },
                });
            });

            #endregion

            services.AddControllers();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger();
            app.UseSwaggerUI(c => {
                c.SwaggerEndpoint("../swagger/v1/swagger.json", "MyPasswordAPI v1.0");
            });

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
