namespace MyPasswordAPI.Domain.Entities
{
    public class Password : Base
    {
        public int FkIdCustomer { get; set; }
        public string Title { get; set; }
        public string Value { get; set; }
        public Customer Customer { get; set; }
    }
}
