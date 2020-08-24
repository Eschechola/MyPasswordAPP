using Microsoft.IdentityModel.Tokens;
using MyPasswordAPI.Domain.Entities;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace MyPasswordAPI.Application.Helpers
{
    public static class TokenHelper
    {
        public static string GenerateToken(string name, string email, string secretKey)
        {
            var tokenHandler = new JwtSecurityTokenHandler();

            var key = Encoding.ASCII.GetBytes(secretKey);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, name),
                    new Claim(ClaimTypes.Email, email),
                    new Claim(ClaimTypes.Role, "Customer")
                }),
                Expires = DateTime.UtcNow.AddHours(24),

                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);

            return tokenHandler.WriteToken(token);
        }
    }
}
