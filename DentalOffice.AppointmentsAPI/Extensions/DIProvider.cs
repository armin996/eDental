using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Entities.dbContext;
using DentalOffice.Entities.dbEntities;
using DentalOffice.MessageQueue.Config;
using DentalOffice.MessageQueue.Services;
using DentalOffice.PaymentAPI.Security;
using DentalOffice.Repositories.Interfaces;
using DentalOffice.Repositories.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;

namespace DentalOffice.PaymentAPI.Extensions
{
    public static class DIProvider
    {
        public static void AddPersistence(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<AppDbContext>(options => options.UseNpgsql(configuration.GetConnectionString("dbConnection")));
        }

        public static void RegisterServices(this IServiceCollection services)
        {
            services.AddScoped<IConnectionProvider, ConnectionProvider>();
            services.AddScoped<IMessagingService, MessagingService>();
            services.AddScoped<IAuthRepository, AuthRepository>();
            //services.AddScoped<IBaseRepository<int, AppointmentDto, AppointmentSearchRequestDto, Appointment>, AppointmentRepository>();
            services.AddScoped<IBaseRepository<int, PaymentDto, PaymentSearchRequestDto, Payment>, PaymentRepository>();
            //services.AddScoped<IBaseRepository<int, RatingDto, RatingSearchRequestDto, Rating>, RatingRepository>();
            //services.AddScoped<IBaseRepository<int, TreatmentDto, TreatmentSearchRequestDto, Treatment>, TreatmentRepository>();
            //services.AddScoped<IRecommendationRepository, RecommendationRepository>();
        }

        public static void AddBasicAuth(this IServiceCollection services)
        {
            services.AddAuthentication("BasicAuthentication")
                    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
        }
    }
}
