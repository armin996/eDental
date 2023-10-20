namespace DentalOffice.WinFormsUI.Forms.Appointments
{
    partial class frmAppointmentDetails
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dtPicStart = new System.Windows.Forms.DateTimePicker();
            this.cmbDentist = new System.Windows.Forms.ComboBox();
            this.cmbTreatment = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.btnSave = new System.Windows.Forms.Button();
            this.cmbClients = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.errorProvider = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).BeginInit();
            this.SuspendLayout();
            // 
            // dtPicStart
            // 
            this.dtPicStart.CustomFormat = "";
            this.dtPicStart.Location = new System.Drawing.Point(49, 81);
            this.dtPicStart.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtPicStart.MinDate = new System.DateTime(2023, 1, 1, 0, 0, 0, 0);
            this.dtPicStart.Name = "dtPicStart";
            this.dtPicStart.Size = new System.Drawing.Size(228, 27);
            this.dtPicStart.TabIndex = 0;
            this.dtPicStart.Value = new System.DateTime(2023, 1, 1, 0, 0, 0, 0);
            this.dtPicStart.Validating += new System.ComponentModel.CancelEventHandler(this.dtPicStart_Validating);
            // 
            // cmbDentist
            // 
            this.cmbDentist.FormattingEnabled = true;
            this.cmbDentist.Location = new System.Drawing.Point(51, 188);
            this.cmbDentist.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbDentist.Name = "cmbDentist";
            this.cmbDentist.Size = new System.Drawing.Size(226, 28);
            this.cmbDentist.TabIndex = 2;
            // 
            // cmbTreatment
            // 
            this.cmbTreatment.FormattingEnabled = true;
            this.cmbTreatment.Location = new System.Drawing.Point(421, 80);
            this.cmbTreatment.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbTreatment.Name = "cmbTreatment";
            this.cmbTreatment.Size = new System.Drawing.Size(226, 28);
            this.cmbTreatment.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(50, 56);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 20);
            this.label1.TabIndex = 4;
            this.label1.Text = "Date";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(421, 56);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(76, 20);
            this.label3.TabIndex = 6;
            this.label3.Text = "Treatment";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(51, 164);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(56, 20);
            this.label4.TabIndex = 7;
            this.label4.Text = "Dentist";
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(665, 452);
            this.btnSave.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(122, 45);
            this.btnSave.TabIndex = 8;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // cmbClients
            // 
            this.cmbClients.FormattingEnabled = true;
            this.cmbClients.Location = new System.Drawing.Point(421, 188);
            this.cmbClients.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbClients.Name = "cmbClients";
            this.cmbClients.Size = new System.Drawing.Size(226, 28);
            this.cmbClients.TabIndex = 9;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(421, 164);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(47, 20);
            this.label5.TabIndex = 10;
            this.label5.Text = "Client";
            // 
            // errorProvider
            // 
            this.errorProvider.ContainerControl = this;
            // 
            // frmAppointmentDetails
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoValidate = System.Windows.Forms.AutoValidate.Disable;
            this.ClientSize = new System.Drawing.Size(914, 600);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.cmbClients);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cmbTreatment);
            this.Controls.Add(this.cmbDentist);
            this.Controls.Add(this.dtPicStart);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmAppointmentDetails";
            this.Text = "Appointment details";
            this.Load += new System.EventHandler(this.frmAppointmentDetails_Load);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DateTimePicker dtPicStart;
        private ComboBox cmbDentist;
        private ComboBox cmbTreatment;
        private Label label1;
        private Label label3;
        private Label label4;
        private Button btnSave;
        private ComboBox cmbClients;
        private Label label5;
        private ErrorProvider errorProvider;
    }
}