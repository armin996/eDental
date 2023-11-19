using DentalOffice.Dtos;
using Flurl.Http;

namespace DentalOffice.WinFormsUI.APIServices
{
    internal class AuthAPIService
    {
        private readonly string _route = string.Empty;
        public AuthAPIService(string route)
        {
            _route = route;
        }

        public async Task<UserDto> Login(UserLoginDto request)
        {
            var url = $"{Properties.Settings.Default.APIurl}/{_route}/login";
            try
            {
                return await url.PostJsonAsync(request).ReceiveJson<UserDto>();
            }
            catch (FlurlHttpException ex)
            {
                return  new UserDto { Id = 0 };
            }        
        }

        public async Task<UserDto> Register(UserDto request)
        {
            var url = $"{Properties.Settings.Default.APIurl}/{_route}/register";
            return await url.PostJsonAsync(request).ReceiveJson<UserDto>();
        }
    }
}
