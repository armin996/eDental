using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Entities.dbEntities;
using DentalOffice.MessageQueue.Events;
using DentalOffice.MessageQueue.Services;
using DentalOffice.Repositories.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DentalOffice.PaymentAPI.Controllers
{
    [Route("api/payments"), Authorize]
    [ApiController]
    public class PaymentsController : BaseController<int, PaymentDto, PaymentSearchRequestDto, Payment>
    {
        private readonly IMessagingService messagingService;
        public PaymentsController(IBaseRepository<int, PaymentDto, PaymentSearchRequestDto, Payment> repository, IMessagingService messagingService) : base(repository)
        {
            this.messagingService = messagingService;
        }
        public override async Task<IActionResult> Create([FromBody] PaymentDto model)
        {
            try
            {
                var result = await _repository.Create(model);

                if (result is not null)
                {
                    PaymentCreatedEvent paymentCreatedEvent = new()
                    {
                        PaymentId = result.Id,
                        Date = result.Date,
                        Amount = result.Amount,
                        AppointmentId = result.AppointmentId,
                        UserId = result.UserId,
                    };
                    //notify admin that the payment has been done 
                    messagingService.SendMessage(paymentCreatedEvent);
                    return Ok(result);
                }

            }
            catch (Exception ex)
            {
                return BadRequest();

            }
            return BadRequest();
        }
    }
}
