using DentalOffice.MessageQueue.Config;
using Newtonsoft.Json;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;

namespace DentalOffice.MessageQueue.Services
{
    public class MessagingService : IMessagingService
    {
        private readonly IConnectionProvider _connectionProvider;
        private IModel channel;


        public MessagingService(IConnectionProvider connectionProvider)
        {
            _connectionProvider = connectionProvider;
        }

        public void SendMessage<T>(T message)
        {
            var queueName = typeof(T).Name;
            var serializedMessage = JsonConvert.SerializeObject(message);
            SendMessage(queueName, serializedMessage);
        }

        private void SendMessage(string queueName, string message)
        {
            channel = _connectionProvider.GetConnection().CreateModel();
                channel.QueueDeclare(queue: queueName,
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                var body = Encoding.UTF8.GetBytes(message);

                channel.BasicPublish(exchange: "",
                                     routingKey: queueName,
                                     basicProperties: null,
                                     body: body);
        }

        public void ReceiveMessage<T>(Func<string, Task> asyncMessageHandler)
        {
            var queueName = typeof(T).Name;
            ReceiveMessage(queueName, asyncMessageHandler.Invoke);
        }

        private void ReceiveMessage(string queueName, Func<string, Task> asyncMessageHandler)
        {

            channel = _connectionProvider.GetConnection().CreateModel();
            channel.QueueDeclare(queue: queueName,
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);

            var consumer = new AsyncEventingBasicConsumer(channel);
            consumer.Received += async (model, ea) =>
            {
                var body = ea.Body.ToArray();
                var message = Encoding.UTF8.GetString(body);
                await asyncMessageHandler.Invoke(message);
            };

            channel.BasicConsume(queue: queueName,
                                 autoAck: true,
                                 consumer: consumer);

        }
    }

}
