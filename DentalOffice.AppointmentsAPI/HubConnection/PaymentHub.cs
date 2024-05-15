using DentalOffice.Dtos;
using Microsoft.AspNetCore.SignalR;

namespace DentalOffice.PaymentAPI.HubConnection
{
    public class PaymentHub: Hub
    {
        public async Task SendPaymentInfo(PaymentDto payment)
        {
            await Clients.All.SendAsync("paymentsNotification", payment);
        }
    }
}
