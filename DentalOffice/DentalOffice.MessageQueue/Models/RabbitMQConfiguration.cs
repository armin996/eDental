﻿namespace DentalOffice.MessageQueue.Models
{
    public class RabbitMQConfiguration
    {
        public string Host { get; set; }
        public int Port { get; set; }
        public string User { get; set; }
        public string Password { get; set; }
    }
}
