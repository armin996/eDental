using System.ComponentModel.DataAnnotations.Schema;

namespace DentalOffice.Entities.dbEntities
{
    public class Payment
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
        public int UserId { get; set; }
        public User User { get; set; }
        public int AppointmentId { get; set; }
        public Appointment Appointment { get; set; }
        public string PaymentIntent { get; set; }
        [NotMapped]
        public string DentistId { get; set; }
        [NotMapped]
        public string Client { get; set; }
        [NotMapped]
        public string TreatmentName { get; set; }
    }
}
