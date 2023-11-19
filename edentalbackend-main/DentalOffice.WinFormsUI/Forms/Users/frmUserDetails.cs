using DentalOffice.Dtos;
using DentalOffice.Dtos.SearchRequests;
using DentalOffice.Enums;
using DentalOffice.WinFormsUI.APIServices;
using System.Data;

namespace DentalOffice.WinFormsUI.Forms.Users
{
    public partial class frmUserDetails : Form
    {
        private readonly BaseAPIService<int, UserDto, UserSearchRequestDto> _apiService = new("users");
        private readonly int _id = 0;
        private ComboBoxHelper comboBoxHelper = new();
        private UserDto _request = new();
        public frmUserDetails(int id)
        {
            InitializeComponent();
            _id = id;
        }

        private async void frmUserDetails_Load(object sender, EventArgs e)
        {
            var roles = Enum.GetValues(typeof(Role)).Cast<Role>().Select(r => new { Value = r, Title = string.Format("-->{0}<--", r) }).ToList();

            cmbRole.DataSource = roles;
            cmbRole.ValueMember = "Value";
            cmbRole.DisplayMember = "Text";

            var genders = Enum.GetValues(typeof(Gender)).Cast<Gender>().Select(g => new { Value = g, Title = string.Format("-->{0}<--", g) }).ToList();

            cmbGender.DataSource = genders;
            cmbGender.ValueMember = "Value";
            cmbGender.DisplayMember = "Text";

            _request = await _apiService.GetById<UserDto>(_id);

            if (_request is not null)
            {
                txtFirstName.Text = _request.FirstName;
                txtLastName.Text = _request.LastName;
                txtEmail.Text = _request.Email;
                txtPhone.Text = _request.Phone;
                txtUsername.Text = _request.Username;
                txtAddress.Text = _request.Address;
                cmbGender.SelectedValue = _request.Gender;
                cmbRole.SelectedValue = _request.Role;
            }
            else
            {
                MessageBox.Show("User can't be found!");
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                _request.FirstName = txtFirstName.Text;
                _request.LastName = txtLastName.Text;
                _request.Email = txtEmail.Text;
                _request.Phone = txtPhone.Text;
                _request.Username = txtUsername.Text;
                _request.Address = txtAddress.Text;
                _request.Gender = (Gender)cmbGender.SelectedValue;
                _request.Role = (Role)cmbRole.SelectedValue;

                var updatedUser = await _apiService.Update<UserDto>(_id, _request);

                if (updatedUser is not null)
                {
                    MessageBox.Show("User successfully updated!");
                    this.Hide();
                }
                else
                {
                    MessageBox.Show("User can't be updated!");
                    this.Hide();
                }
            }
        }

        private void txtFirstName_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                errorProvider.SetError(txtFirstName, "First name is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtFirstName, null);
            }
        }

        private void txtLastName_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                errorProvider.SetError(txtLastName, "Last name is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtLastName, null);
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

        private void txtUsername_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {
                errorProvider.SetError(txtUsername, "Username is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(txtUsername, null);
            }
        }

        private void cmbGender_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {

            if (cmbGender.SelectedValue == null)
            {
                errorProvider.SetError(cmbGender, "Gender is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(cmbGender, null);
            }
        }

        private void cmbRole_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (cmbRole.SelectedValue == null)
            {
                errorProvider.SetError(cmbRole, "Role is required.");
                e.Cancel = true;
            }
            else
            {
                errorProvider.SetError(cmbRole, null);
            }
        }
    }
}
