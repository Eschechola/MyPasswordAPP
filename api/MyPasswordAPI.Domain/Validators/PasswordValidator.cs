using FluentValidation;
using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Domain.Validators
{
    public class PasswordValidator: AbstractValidator<Password>
    {
        public PasswordValidator()
        {
            RuleFor(v => v.CustomerId)
                .NotNull()
                .WithMessage("O ID do usuário não pode ser nulo.");

            RuleFor(v => v.Title)
                .NotNull()
                .WithMessage("O Título da senha não pode ser nulo.")

                .NotEmpty()
                .WithMessage("O Título da senha não pode ser vazio.")
                
                .MinimumLength(3)
                .WithMessage("O Título da senha deve ter entre 3 e 40 caracteres")

                .MaximumLength(40)
                .WithMessage("O Título da senha deve ter entre 3 e 40 caracteres");


            RuleFor(v => v.Value)
                .NotNull()
                .WithMessage("O Valor da senha não pode ser nulo.")

                .NotEmpty()
                .WithMessage("O Valor da senha não pode ser vazio.")

                .MinimumLength(3)
                .WithMessage("O Valor da senha deve ter entre 3 e 400 caracteres")

                .MaximumLength(400)
                .WithMessage("O Valor da senha deve ter entre 3 e 400 caracteres");
        }
    }
}
