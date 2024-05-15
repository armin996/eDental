using DentalOffice.API.HubConnection;
using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Entities.dbEntities;
using DentalOffice.Enums;
using DentalOffice.MessageQueue.Events;
using DentalOffice.Repositories.Interfaces;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
//using Newtonsoft.Json;
namespace DentalOffice.API.Events.Handlers
{
    /// <summary>
    /// This is a helper class which will isolate event handlers functions for cleaner code
    /// </summary>
    public class EventHandler : IEventHandler
    {
        private readonly IBaseRepository<int, AppointmentDto, AppointmentSearchRequestDto, Appointment> appointmentRepository;
        private readonly IBaseRepository<int, PaymentDto, PaymentSearchRequestDto, Payment> paymentRepository;
        private readonly IBaseRepository<int, TreatmentDto, TreatmentSearchRequestDto, Treatment> treatmentRepository;
        private readonly IBaseRepository<int, UserDto, UserSearchRequestDto, User> userRepository;
        private readonly IHubContext<PaymentHub> hubContext;

        public EventHandler(
            IBaseRepository<int, TreatmentDto, TreatmentSearchRequestDto, Treatment> treatmentRepository,
            IBaseRepository<int, UserDto, UserSearchRequestDto, User> userRepository,
            IBaseRepository<int, PaymentDto, PaymentSearchRequestDto, Payment> paymentRepository,
            IBaseRepository<int, AppointmentDto, AppointmentSearchRequestDto, Appointment> appointmentRepository,IHubContext<PaymentHub> hubContext)
        {
            this.treatmentRepository=treatmentRepository;
            this.userRepository = userRepository;
            this.appointmentRepository = appointmentRepository;
            this.paymentRepository = paymentRepository;
            this.hubContext=hubContext;
        }
        public async Task CreatedPaymentEventHandler(string message)
        {
            PaymentCreatedEvent @event = JsonConvert.DeserializeObject<PaymentCreatedEvent>(message);
            AppointmentDto? appointment = await appointmentRepository.GetById(@event.AppointmentId);
            if (appointment is not null)
            {
                appointment.AppointmentStatus = AppointmentStatus.Paid;
                var result = await appointmentRepository.Update(appointment.Id, appointment);
                var payment = await paymentRepository.GetById(@event.PaymentId);
                payment.Client = (await userRepository.GetById(payment.UserId)).FullName;
                payment.TreatmentName = (await treatmentRepository.GetById(appointment.TreatmentId.Value)).Name;
                if (payment is not null && result is not null)
                {
                    await hubContext.Clients.All.SendAsync("paymentNotification", payment);
                }
            }
        }
    }
}
