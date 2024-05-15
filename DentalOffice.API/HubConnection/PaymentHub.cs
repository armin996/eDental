using DentalOffice.Dtos;
using Microsoft.AspNetCore.SignalR;

namespace DentalOffice.API.HubConnection
{
    public class PaymentHub : Hub
    {
        public async Task SendPaymentInfo(PaymentDto payment)
        {
            await Clients.All.SendAsync("payments_notification", payment);
        }
    }
}
