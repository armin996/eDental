namespace DentalOffice.Dtos.SearchRequests
{
    public record PaymentSearchRequestDto
    {
        public int? UserId { get; set; } = null;
        public int? TreatmentId { get; set; } = null;
        public string? PaymentIntent { get; set; }
    }
}
