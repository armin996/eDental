using AutoMapper;
using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Entities.dbContext;
using DentalOffice.Entities.dbEntities;
using Microsoft.EntityFrameworkCore;

namespace DentalOffice.Repositories.Services
{
    public class PaymentRepository : BaseRepository<int, PaymentDto, PaymentSearchRequestDto, Payment>
    {
        private readonly AppDbContext _context;
        private readonly IMapper _mapper;

        public PaymentRepository(AppDbContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public override async Task<List<PaymentDto>> GetAll(PaymentSearchRequestDto? searchRequest)
        {
            var payments = _context.Payments.Include(p => p.User).Include(p=> p.Appointment).Select(p => new Payment
            {
                Id = p.Id,
                Amount = p.Amount,
                Date = p.Date,
                UserId = p.UserId,
                PaymentIntent = p.PaymentIntent,
                Client = p.User.FirstName + " " + p.User.LastName,
            }).AsQueryable();


            //if (searchRequest.TreatmentId is not null && searchRequest.TreatmentId is not 0)
            //    payments = payments.Where(p => p.TreatmentId == searchRequest.TreatmentId);

            if (searchRequest.UserId is not null && searchRequest.UserId is not 0)
                payments = payments.Where(p => p.UserId == searchRequest.UserId);

            if (!string.IsNullOrWhiteSpace(searchRequest.PaymentIntent))
                payments = payments.Where(p => p.PaymentIntent == searchRequest.PaymentIntent);

            return _mapper.Map<List<PaymentDto>>(await payments.ToListAsync());
        }
    }
}
