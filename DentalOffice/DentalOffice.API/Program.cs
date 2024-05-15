using DentalOffice.API.Extensions;
using DentalOffice.API.Helper;
using DentalOffice.API.HubConnection;
using DentalOffice.Entities.dbContext;
using DentalOffice.Mapper;
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddAutoMapper(typeof(Mapper));
builder.Services.AddPersistence(builder.Configuration);
builder.Services.RegisterServices();
builder.Services.AddBasicAuth();
builder.Services.AddCors(setup => setup.AddPolicy(name: "allowAllPolicy", policy => policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));
var app = builder.Build();

app.RegisterEventHandlers();

SeedDatabase();

void SeedDatabase()
{
    using (var scope = app.Services.CreateScope())
    {
        try
        {
            var scopedContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
            DbSeed.SeedDB(scopedContext);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
else
{
    app.UseHsts();
}
app.UseCors("allowAllPolicy");
app.UseAuthentication();
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.MapHub<PaymentHub>("/payments");
app.Run();

