namespace DentalOffice.WinFormsUI.Forms.Ratings
{
    partial class frmRatings
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
            this.dgvRatings = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Rate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Comment = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DentistFullName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ClientFullName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Date = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmbDentists = new System.Windows.Forms.ComboBox();
            this.cmbClients = new System.Windows.Forms.ComboBox();
            this.btnSearch = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvRatings)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvRatings
            // 
            this.dgvRatings.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvRatings.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Rate,
            this.Comment,
            this.DentistFullName,
            this.ClientFullName,
            this.Date});
            this.dgvRatings.Location = new System.Drawing.Point(14, 145);
            this.dgvRatings.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgvRatings.Name = "dgvRatings";
            this.dgvRatings.RowHeadersWidth = 51;
            this.dgvRatings.RowTemplate.Height = 25;
            this.dgvRatings.Size = new System.Drawing.Size(887, 439);
            this.dgvRatings.TabIndex = 0;
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
            // Rate
            // 
            this.Rate.DataPropertyName = "Rate";
            this.Rate.HeaderText = "Rate";
            this.Rate.MinimumWidth = 6;
            this.Rate.Name = "Rate";
            this.Rate.Width = 125;
            // 
            // Comment
            // 
            this.Comment.DataPropertyName = "Comment";
            this.Comment.HeaderText = "Comment";
            this.Comment.MinimumWidth = 6;
            this.Comment.Name = "Comment";
            this.Comment.Width = 125;
            // 
            // DentistFullName
            // 
            this.DentistFullName.DataPropertyName = "DentistFullName";
            this.DentistFullName.HeaderText = "Dentist";
            this.DentistFullName.MinimumWidth = 6;
            this.DentistFullName.Name = "DentistFullName";
            this.DentistFullName.Width = 125;
            // 
            // ClientFullName
            // 
            this.ClientFullName.DataPropertyName = "ClientFullName";
            this.ClientFullName.HeaderText = "Client";
            this.ClientFullName.MinimumWidth = 6;
            this.ClientFullName.Name = "ClientFullName";
            this.ClientFullName.Width = 125;
            // 
            // Date
            // 
            this.Date.DataPropertyName = "Date";
            this.Date.HeaderText = "Date";
            this.Date.MinimumWidth = 6;
            this.Date.Name = "Date";
            this.Date.Width = 125;
            // 
            // cmbDentists
            // 
            this.cmbDentists.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbDentists.FormattingEnabled = true;
            this.cmbDentists.Location = new System.Drawing.Point(23, 41);
            this.cmbDentists.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbDentists.Name = "cmbDentists";
            this.cmbDentists.Size = new System.Drawing.Size(177, 28);
            this.cmbDentists.TabIndex = 1;
            // 
            // cmbClients
            // 
            this.cmbClients.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbClients.FormattingEnabled = true;
            this.cmbClients.Location = new System.Drawing.Point(274, 41);
            this.cmbClients.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbClients.Name = "cmbClients";
            this.cmbClients.Size = new System.Drawing.Size(177, 28);
            this.cmbClients.TabIndex = 2;
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(815, 89);
            this.btnSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(86, 31);
            this.btnSearch.TabIndex = 3;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(24, 16);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 20);
            this.label1.TabIndex = 4;
            this.label1.Text = "Dentist";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(277, 16);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(47, 20);
            this.label2.TabIndex = 5;
            this.label2.Text = "Client";
            // 
            // frmRatings
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(914, 600);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.cmbClients);
            this.Controls.Add(this.cmbDentists);
            this.Controls.Add(this.dgvRatings);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmRatings";
            this.Text = "Ratings";
            this.Load += new System.EventHandler(this.frmRatings_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvRatings)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DataGridView dgvRatings;
        private ComboBox cmbDentists;
        private ComboBox cmbClients;
        private Button btnSearch;
        private Label label1;
        private Label label2;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn Rate;
        private DataGridViewTextBoxColumn Comment;
        private DataGridViewTextBoxColumn DentistFullName;
        private DataGridViewTextBoxColumn ClientFullName;
        private DataGridViewTextBoxColumn Date;
    }
}