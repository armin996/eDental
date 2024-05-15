using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.WinFormsUI.APIServices;

namespace DentalOffice.WinFormsUI.Forms.Appointments
{
    public partial class frmAppointmentDetails : Form
    {
        private readonly int? _id;
        private readonly BaseAPIService<int, AppointmentDto, AppointmentSearchRequestDto> _apiService = new("appointments");
        private readonly BaseAPIService<int, DentistDto, DentistSearchRequestDto> _dentistApiService = new("dentists");
        private readonly BaseAPIService<int, TreatmentDto, TreatmentSearchRequestDto> _treatmentApiService = new("treatments");
        private readonly BaseAPIService<int, UserDto, UserSearchRequestDto> _userApiService = new("users");
        private readonly ComboBoxHelper comboBoxHelper = new();
        private AppointmentDto _request = new();

        public frmAppointmentDetails(int? id)
        {
            InitializeComponent();
            _id = id;
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            AppointmentDto _request = new()
            {
                Start = dtPicStart.Value,
                DentistId = comboBoxHelper.GetIdFromComboBox(cmbDentist.SelectedValue).Value,
                TreatmentId = comboBoxHelper.GetIdFromComboBox(cmbTreatment.SelectedValue).Value,
                UserId = comboBoxHelper.GetIdFromComboBox(cmbClients.SelectedValue).Value
            };

            var pickedTreatment = await _treatmentApiService.GetById<TreatmentDto>(_request.TreatmentId.Value);
            _request.TreatmentName = pickedTreatment.Name;
            var pickedDentist = await _dentistApiService.GetById<DentistDto>(_request.DentistId.Value);
            _request.DentistFullName = pickedDentist.FullName;
            var pickedUser = await _userApiService.GetById<UserDto>(_request.UserId.Value);
            _request.ClientFullName = pickedUser.FullName;

            if (pickedTreatment is not null)
            {
                _request.End = _request.Start.AddMinutes(double.Parse(pickedTreatment.TimeRequiredInMinutes.ToString()));
            }

            if (_id is not null)
            {
                _request.Id = _id.Value;
                var updatedAppointment = await _apiService.Update<AppointmentDto>(_request.Id, _request);

                if (updatedAppointment is not null)
                {
                    MessageBox.Show("Appointment data successfully updated!");
                    this.Hide();
                }
            }
            else
            {
                var addedAppointment = await _apiService.Insert<AppointmentDto>(_request);

                if (addedAppointment is not null)
                {
                    MessageBox.Show("Appointment successfully added!");
                    this.Hide();
                }
            }
        }

        private async Task LoadTreatments()
        {
            cmbTreatment.DataSource = await _treatmentApiService.GetAll<List<TreatmentDto>>();
            cmbTreatment.DisplayMember = "Name";
            cmbTreatment.ValueMember = "Id";

            await LoadClients();
        }

        private async Task LoadClients()
        {
            UserSearchRequestDto searchRequest = new()
            {
                FirstName = string.Empty,
                LastName = string.Empty,
                Username = string.Empty,
                Email = string.Empty,
                Phone = string.Empty,
                Gender = null,
                Role = Enums.Role.Client
            };

            cmbClients.DataSource = await _userApiService.GetFilteredData<List<UserDto>>(searchRequest);
            cmbClients.DisplayMember = "FullName";
            cmbClients.ValueMember = "Id";

            if(_id != null)
            {
                _request = await _apiService.GetById<AppointmentDto>((int)_id);

                if (_request != null)
                {
                    dtPicStart.Value = _request.Start;
                    cmbClients.SelectedValue = _request.UserId;
                    cmbDentist.SelectedValue = _request.DentistId;
                    cmbTreatment.SelectedValue = _request.TreatmentId;
                }
                else
                {
                    MessageBox.Show("Appointmen can't be found!");
                }
            }

        }

        private async Task LoadDentists()
        {
            cmbDentist.DataSource = await _dentistApiService.GetAll<List<DentistDto>>();
            cmbDentist.DisplayMember = "FullName";
            cmbDentist.ValueMember = "Id";

            await LoadTreatments();
        }

        private async void frmAppointmentDetails_Load(object sender, EventArgs e)
        {
            await LoadDentists();
        }

        private void dtPicStart_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (dtPicStart.Value == dtPicStart.MinDate)
            {
                errorProvider.SetError(dtPicStart, "Required");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(dtPicStart, null);
            }
        }
    }
}
