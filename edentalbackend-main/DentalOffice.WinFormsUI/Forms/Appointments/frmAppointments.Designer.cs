namespace DentalOffice.WinFormsUI.Forms.Appointments
{
    partial class frmAppointments
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
            this.dgvAppointments = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Start = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.End = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DentistFullName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TreatmentName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ClientFullName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmbDentists = new System.Windows.Forms.ComboBox();
            this.cmbTreatments = new System.Windows.Forms.ComboBox();
            this.dtPicStart = new System.Windows.Forms.DateTimePicker();
            this.dtPicEnd = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.btnSearch = new System.Windows.Forms.Button();
            this.cmbClients = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAppointments)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvAppointments
            // 
            this.dgvAppointments.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvAppointments.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Start,
            this.End,
            this.DentistFullName,
            this.TreatmentName,
            this.ClientFullName});
            this.dgvAppointments.Location = new System.Drawing.Point(14, 200);
            this.dgvAppointments.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgvAppointments.Name = "dgvAppointments";
            this.dgvAppointments.RowHeadersWidth = 51;
            this.dgvAppointments.RowTemplate.Height = 25;
            this.dgvAppointments.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvAppointments.Size = new System.Drawing.Size(878, 384);
            this.dgvAppointments.TabIndex = 0;
            this.dgvAppointments.CellMouseDoubleClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dgvAppointments_CellMouseDoubleClick);
            // 
            // Id
            // 
            this.Id.DataPropertyName = "Id";
            this.Id.HeaderText = "Id";
            this.Id.MinimumWidth = 6;
            this.Id.Name = "Id";
            this.Id.Visible = false;
            this.Id.Width = 125;
            // 
            // Start
            // 
            this.Start.DataPropertyName = "Start";
            this.Start.HeaderText = "Start";
            this.Start.MinimumWidth = 6;
            this.Start.Name = "Start";
            this.Start.Width = 125;
            // 
            // End
            // 
            this.End.DataPropertyName = "End";
            this.End.HeaderText = "End";
            this.End.MinimumWidth = 6;
            this.End.Name = "End";
            this.End.Width = 125;
            // 
            // DentistFullName
            // 
            this.DentistFullName.DataPropertyName = "DentistFullName";
            this.DentistFullName.HeaderText = "Dentist";
            this.DentistFullName.MinimumWidth = 6;
            this.DentistFullName.Name = "DentistFullName";
            this.DentistFullName.Width = 125;
            // 
            // TreatmentName
            // 
            this.TreatmentName.DataPropertyName = "TreatmentName";
            this.TreatmentName.HeaderText = "Treatment";
            this.TreatmentName.MinimumWidth = 6;
            this.TreatmentName.Name = "TreatmentName";
            this.TreatmentName.Width = 125;
            // 
            // ClientFullName
            // 
            this.ClientFullName.DataPropertyName = "ClientFullName";
            this.ClientFullName.HeaderText = "Client";
            this.ClientFullName.MinimumWidth = 6;
            this.ClientFullName.Name = "ClientFullName";
            this.ClientFullName.Width = 125;
            // 
            // cmbDentists
            // 
            this.cmbDentists.FormattingEnabled = true;
            this.cmbDentists.Location = new System.Drawing.Point(514, 36);
            this.cmbDentists.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbDentists.Name = "cmbDentists";
            this.cmbDentists.Size = new System.Drawing.Size(219, 28);
            this.cmbDentists.TabIndex = 1;
            // 
            // cmbTreatments
            // 
            this.cmbTreatments.FormattingEnabled = true;
            this.cmbTreatments.Location = new System.Drawing.Point(753, 36);
            this.cmbTreatments.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbTreatments.Name = "cmbTreatments";
            this.cmbTreatments.Size = new System.Drawing.Size(138, 28);
            this.cmbTreatments.TabIndex = 2;
            // 
            // dtPicStart
            // 
            this.dtPicStart.Location = new System.Drawing.Point(14, 36);
            this.dtPicStart.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtPicStart.Name = "dtPicStart";
            this.dtPicStart.Size = new System.Drawing.Size(228, 27);
            this.dtPicStart.TabIndex = 3;
            // 
            // dtPicEnd
            // 
            this.dtPicEnd.Location = new System.Drawing.Point(263, 36);
            this.dtPicEnd.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dtPicEnd.Name = "dtPicEnd";
            this.dtPicEnd.Size = new System.Drawing.Size(228, 27);
            this.dtPicEnd.TabIndex = 4;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 12);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(74, 20);
            this.label1.TabIndex = 5;
            this.label1.Text = "Start date";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(263, 12);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(68, 20);
            this.label2.TabIndex = 6;
            this.label2.Text = "End date";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(514, 12);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(56, 20);
            this.label3.TabIndex = 7;
            this.label3.Text = "Dentist";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(753, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(76, 20);
            this.label4.TabIndex = 8;
            this.label4.Text = "Treatment";
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(806, 161);
            this.btnSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(86, 31);
            this.btnSearch.TabIndex = 9;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // cmbClients
            // 
            this.cmbClients.FormattingEnabled = true;
            this.cmbClients.Location = new System.Drawing.Point(14, 96);
            this.cmbClients.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbClients.Name = "cmbClients";
            this.cmbClients.Size = new System.Drawing.Size(228, 28);
            this.cmbClients.TabIndex = 10;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(14, 72);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(47, 20);
            this.label5.TabIndex = 11;
            this.label5.Text = "Client";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(14, 172);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(317, 20);
            this.label6.TabIndex = 12;
            this.label6.Text = "*Double click for opening appointment details";
            // 
            // frmAppointments
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(914, 600);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.cmbClients);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dtPicEnd);
            this.Controls.Add(this.dtPicStart);
            this.Controls.Add(this.cmbTreatments);
            this.Controls.Add(this.cmbDentists);
            this.Controls.Add(this.dgvAppointments);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmAppointments";
            this.Text = "Appointments";
            this.Load += new System.EventHandler(this.frmAppointments_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvAppointments)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DataGridView dgvAppointments;
        private ComboBox cmbDentists;
        private ComboBox cmbTreatments;
        private DateTimePicker dtPicStart;
        private DateTimePicker dtPicEnd;
        private Label label1;
        private Label label2;
        private Label label3;
        private Label label4;
        private Button btnSearch;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn Start;
        private DataGridViewTextBoxColumn End;
        private DataGridViewTextBoxColumn DentistFullName;
        private DataGridViewTextBoxColumn TreatmentName;
        private DataGridViewTextBoxColumn ClientFullName;
        private ComboBox cmbClients;
        private Label label5;
        private Label label6;
    }
}