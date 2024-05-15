namespace DentalOffice.MessageQueue.Events
{
    public class PaymentCreatedEvent
    {
        public int AppointmentId { get; set; }
        public int PaymentId { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
        public int UserId { get; set; }
    }
}
