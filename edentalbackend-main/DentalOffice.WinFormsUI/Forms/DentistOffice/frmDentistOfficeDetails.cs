using DentalOffice.Dtos;
using DentalOffice.WinFormsUI.APIServices;

namespace DentalOffice.WinFormsUI.Forms.DentistOffice
{
    public partial class frmDentistOfficeDetails : Form
    {
        private readonly BaseAPIService<int, DentistOfficeDto, object> _apiService = new("dentistoffices");
        private List<DentistOfficeDto> _dentistOffices = new();
        private bool _isUpdate = false;

        public frmDentistOfficeDetails()
        {
            InitializeComponent();
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                DentistOfficeDto _request = new()
                {
                    Name = txtName.Text,
                    Address = txtAddress.Text,
                    Email = txtEmail.Text,
                    Phone = txtPhone.Text,
                    Description = txtDescription.Text
                };

                if (_isUpdate)
                {
                    _request.Id = _dentistOffices.First().Id;
                    var dentistOffice = await _apiService.Update<DentistOfficeDto>(_request.Id, _request);

                    if (dentistOffice is not null)
                    {
                        MessageBox.Show("Dentist office data successfully updated!");
                        this.Hide();
                    }
                }
                else
                {
                    var dentistOffice = await _apiService.Insert<DentistOfficeDto>(_request);

                    if (dentistOffice is not null)
                    {
                        MessageBox.Show("Dentist office data successfully added!");
                        this.Hide();
                    }
                }
            }
        }

        private async void frmDentistOfficeDetails_Load(object sender, EventArgs e)
        {
            _dentistOffices = await _apiService.GetAll<List<DentistOfficeDto>>(null);

            if (_dentistOffices.Any())
                _isUpdate = true;

            if (_isUpdate)
            {
                txtName.Text = _dentistOffices[0].Name;
                txtAddress.Text = _dentistOffices[0].Address;
                txtEmail.Text = _dentistOffices[0].Email;
                txtPhone.Text = _dentistOffices[0].Phone;
                txtDescription.Text = _dentistOffices[0].Description;
            }
        }

        private void txtName_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                errorProvider.SetError(txtName, "Name is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtName, null);
            }
        }

        private void txtAddress_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                errorProvider.SetError(txtAddress, "Address is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtAddress, null);
            }
        }

        private void txtEmail_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text) && !IsValidEmail(txtEmail.Text))
            {
                errorProvider.SetError(txtEmail, "Invalid email format.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtEmail, null);
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private void txtPhone_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                errorProvider.SetError(txtPhone, "Phone is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtPhone, null);
            }
        }

        private void txtDescription_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDescription.Text))
            {
                errorProvider.SetError(txtDescription, "Description is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtDescription, null);
            }
        }
    }
}
