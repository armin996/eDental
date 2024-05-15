namespace DentalOffice.MessageQueue.Events
{
    public class CheckDentistOfferTreatmentEvent
    {
        public int UserId { get; set; }
        public int TreatmentId { get; set; }
    }
}
