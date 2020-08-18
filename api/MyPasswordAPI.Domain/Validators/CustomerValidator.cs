using FluentValidation;
using MyPasswordAPI.Domain.Entities;

namespace MyPasswordAPI.Domain.Validators
{
    public class CustomerValidator : AbstractValidator<Customer>
    {
        public CustomerValidator()
        {
            RuleFor(v => v.Name)
                .NotNull()
                .WithMessage("* O Nome do usuário não pode ser nulo.")

                .NotEmpty()
                .WithMessage("* O Nome do usuário não pode ser vazio.")
                
                .MinimumLength(3)
                .WithMessage("* O Nome deve ter no mínimo 3 caracteres.")
                
                .MaximumLength(40)
                .WithMessage("* O Nome deve ter no máximo 40 caracteres.");


            RuleFor(v => v.Email)
                .NotNull()
                .WithMessage("* O Email do usuário não pode ser nulo.")

                .NotEmpty()
                .WithMessage("* O Email do usuário não pode ser vazio.")

                .MinimumLength(10)
                .WithMessage("* O Email deve ter no mínimo 3 caracteres.")

                .MaximumLength(180)
                .WithMessage("* O Email deve ter no máximo 180 caracteres.")

                .Matches(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$")
                .WithMessage("* O Email digitado não é válido.");


            RuleFor(v => v.Password)
                .NotNull()
                .WithMessage("* A Senha do usuário não pode ser nula.")

                .NotEmpty()
                .WithMessage("* A Senha do usuário não pode ser vazia.")


                .MinimumLength(6)
                .WithMessage("* A Senha deve ter no mínimo 6 caracteres.")

                .MaximumLength(180)
                .WithMessage("* A Senha deve ter no máximo 180 caracteres.");


            RuleFor(v => v.Type)
                .NotNull()
                .WithMessage("* O Tipo de usuário não pode ser nulo.")

                .NotEmpty()
                .WithMessage("* O Tipo de usuário não pode ser vazio.");
        }
    }
}
