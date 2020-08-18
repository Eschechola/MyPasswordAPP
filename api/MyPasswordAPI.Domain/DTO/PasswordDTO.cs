namespace MyPasswordAPI.Domain.DTO
{
    public class PasswordDTO
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public string Title { get; set; }
        public string Value { get; set; }
    }
}
