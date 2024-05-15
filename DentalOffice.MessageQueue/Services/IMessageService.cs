namespace DentalOffice.MessageQueue.Services
{
    public interface IMessagingService
    {
        void SendMessage<T>(T message);
        void ReceiveMessage<T>(Func<string, Task> asyncMessageHandler);
    }
}
