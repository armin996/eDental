﻿namespace DentalOffice.Dtos.SearchRequests
{
    public class DentistSearchRequestDto
    {
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Phone { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string SearchTerm { get; set; } = string.Empty;
    }
}
