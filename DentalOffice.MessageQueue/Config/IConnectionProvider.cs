using RabbitMQ.Client;

namespace DentalOffice.MessageQueue.Config
{
    public interface IConnectionProvider
    {
        IConnection GetConnection();
    }
}
