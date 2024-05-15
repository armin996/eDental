#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
COPY **/Images/*.jpg /app/Images/
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
ARG BUILD_CONFIGURATION=Release
COPY ["DentalOffice.AppointmentsAPI/DentalOffice.PaymentAPI.csproj", "DentalOffice.AppointmentsAPI/"]
COPY ["DentalOffice.MessageQueue/DentalOffice.MessageQueue.csproj", "DentalOffice.MessageQueue/"]
COPY ["DentalOffice.Dtos/DentalOffice.Dtos.csproj", "DentalOffice.Dtos/"]
COPY ["DentalOffice.Enums/DentalOffice.Enums.csproj", "DentalOffice.Enums/"]
COPY ["DentalOffice.Entities/DentalOffice.Entities.csproj", "DentalOffice.Entities/"]
COPY ["DentalOffice.Mapper/DentalOffice.Mapper.csproj", "DentalOffice.Mapper/"]
COPY ["DentalOffice.Repositories/DentalOffice.Repositories.csproj", "DentalOffice.Repositories/"]
RUN dotnet restore "./DentalOffice.AppointmentsAPI/DentalOffice.PaymentAPI.csproj"
COPY . .
WORKDIR "/src/DentalOffice.AppointmentsAPI"
RUN dotnet build "./DentalOffice.PaymentAPI.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
RUN dotnet publish "./DentalOffice.PaymentAPI.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DentalOffice.PaymentAPI.dll"]