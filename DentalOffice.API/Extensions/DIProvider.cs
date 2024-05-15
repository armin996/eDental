using DentalOffice.API.Events.Handlers;
using DentalOffice.API.Security;
using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Entities.dbContext;
using DentalOffice.Entities.dbEntities;
using DentalOffice.MessageQueue.Config;
using DentalOffice.MessageQueue.Events;
using DentalOffice.MessageQueue.Models;
using DentalOffice.MessageQueue.Services;
using DentalOffice.Repositories.Interfaces;
using DentalOffice.Repositories.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;

namespace DentalOffice.API.Extensions
{
    public static class DIProvider
    {
        public static void AddPersistence(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddOptions();
            services.AddDbContext<AppDbContext>(options => options.UseNpgsql(configuration.GetConnectionString("dbConnection")));
            services.Configure<RabbitMQConfiguration>(configuration.GetSection("RabbitMQConfiguration"));
            services.AddSignalR(opt =>
            {
                opt.EnableDetailedErrors = true;
            });
            var simpleCheck = configuration.GetSection("RabbitMQConfiguration").Value;

        }

        public static void RegisterEventHandlers(this WebApplication app)
        {
            var scope = app.Services.CreateScope();
            var eventHandler = scope.ServiceProvider.GetRequiredService<IEventHandler>();
            var msgService = scope.ServiceProvider.GetRequiredService<IMessagingService>();
            msgService.ReceiveMessage<PaymentCreatedEvent>(eventHandler.CreatedPaymentEventHandler);
        }
        public static void RegisterServices(this IServiceCollection services)
        {
            services.AddScoped<IBaseRepository<int, AppointmentDto, AppointmentSearchRequestDto, Appointment>, AppointmentRepository>();
            services.AddScoped<IBaseRepository<int, DentistDto, DentistSearchRequestDto, Dentist>, DentistRepository>();
            services.AddScoped<IBaseRepository<int, DentistOfficeDto, object, DentistOffice>, BaseRepository<int, DentistOfficeDto, object, DentistOffice>>();
            services.AddScoped<IBaseRepository<int, PaymentDto, PaymentSearchRequestDto, Payment>, PaymentRepository>();
            services.AddScoped<IBaseRepository<int, RatingDto, RatingSearchRequestDto, Rating>, RatingRepository>();
            services.AddScoped<IBaseRepository<int, TreatmentDto, TreatmentSearchRequestDto, Treatment>, TreatmentRepository>();
            services.AddScoped<IBaseRepository<int, UserDto, UserSearchRequestDto, User>, UserRepository>();
            services.AddScoped<IAuthRepository, AuthRepository>();
            services.AddScoped<IRecommendationRepository, RecommendationRepository>();
            services.AddSingleton<IConnectionProvider, ConnectionProvider>();
            services.AddSingleton<IMessagingService, MessagingService>();
            services.AddScoped<IEventHandler,DentalOffice.API.Events.Handlers.EventHandler>();
        }

        public static void AddBasicAuth(this IServiceCollection services)
        {
            services.AddAuthentication("BasicAuthentication")
                    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
        }
    }
}
