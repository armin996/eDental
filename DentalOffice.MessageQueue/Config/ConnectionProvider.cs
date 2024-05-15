using DentalOffice.MessageQueue.Models;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;

namespace DentalOffice.MessageQueue.Config
{
    public class ConnectionProvider : IConnectionProvider
    {
        private readonly ConnectionFactory _connectionFactory;
        private IConnection _connection;

        public ConnectionProvider(IOptions<RabbitMQConfiguration> configuration)
        {
            _connectionFactory = new ConnectionFactory { HostName = configuration.Value.Host,
                                                         Port = configuration.Value.Port,
                                                         UserName = configuration.Value.User, 
                                                         Password = configuration.Value.Password };
        }

        public IConnection GetConnection()
        {
            if (_connection == null || !_connection.IsOpen)
            {
                _connectionFactory.DispatchConsumersAsync = true;
                _connection = _connectionFactory.CreateConnection();
            }
            return _connection;
        }
    }
}
