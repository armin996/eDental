namespace DentalOffice.API.Events.Handlers
{
    public interface IEventHandler
    {
        Task CreatedPaymentEventHandler(string message);
    }
}
