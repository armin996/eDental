namespace DentalOffice.WinFormsUI.Forms.Payments
{
    partial class frmPayments
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
            this.dgvPayments = new System.Windows.Forms.DataGridView();
            this.txtPaymentIntent = new System.Windows.Forms.TextBox();
            this.cmbTreatments = new System.Windows.Forms.ComboBox();
            this.cmbClients = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.btnSearch = new System.Windows.Forms.Button();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Date = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Amount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TreatmentName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Client = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PaymentIntent = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgvPayments)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvPayments
            // 
            this.dgvPayments.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvPayments.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.Date,
            this.Amount,
            this.TreatmentName,
            this.Client,
            this.PaymentIntent});
            this.dgvPayments.Location = new System.Drawing.Point(14, 161);
            this.dgvPayments.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgvPayments.Name = "dgvPayments";
            this.dgvPayments.RowHeadersWidth = 51;
            this.dgvPayments.RowTemplate.Height = 25;
            this.dgvPayments.Size = new System.Drawing.Size(887, 409);
            this.dgvPayments.TabIndex = 0;
            // 
            // txtPaymentIntent
            // 
            this.txtPaymentIntent.Location = new System.Drawing.Point(478, 43);
            this.txtPaymentIntent.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtPaymentIntent.Name = "txtPaymentIntent";
            this.txtPaymentIntent.Size = new System.Drawing.Size(226, 27);
            this.txtPaymentIntent.TabIndex = 2;
            // 
            // cmbTreatments
            // 
            this.cmbTreatments.FormattingEnabled = true;
            this.cmbTreatments.Location = new System.Drawing.Point(24, 43);
            this.cmbTreatments.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbTreatments.Name = "cmbTreatments";
            this.cmbTreatments.Size = new System.Drawing.Size(138, 28);
            this.cmbTreatments.TabIndex = 4;
            // 
            // cmbClients
            // 
            this.cmbClients.FormattingEnabled = true;
            this.cmbClients.Location = new System.Drawing.Point(237, 43);
            this.cmbClients.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.cmbClients.Name = "cmbClients";
            this.cmbClients.Size = new System.Drawing.Size(188, 28);
            this.cmbClients.TabIndex = 5;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(24, 12);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(76, 20);
            this.label2.TabIndex = 7;
            this.label2.Text = "Treatment";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(237, 12);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(47, 20);
            this.label3.TabIndex = 8;
            this.label3.Text = "Client";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(478, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(103, 20);
            this.label4.TabIndex = 9;
            this.label4.Text = "PaymentIntent";
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(815, 109);
            this.btnSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(86, 31);
            this.btnSearch.TabIndex = 10;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
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
            // Date
            // 
            this.Date.DataPropertyName = "Date";
            this.Date.HeaderText = "Date";
            this.Date.MinimumWidth = 6;
            this.Date.Name = "Date";
            this.Date.Width = 125;
            // 
            // Amount
            // 
            this.Amount.DataPropertyName = "Amount";
            this.Amount.HeaderText = "Amount";
            this.Amount.MinimumWidth = 6;
            this.Amount.Name = "Amount";
            this.Amount.Width = 125;
            // 
            // TreatmentName
            // 
            this.TreatmentName.DataPropertyName = "TreatmentName";
            this.TreatmentName.HeaderText = "Treatment";
            this.TreatmentName.MinimumWidth = 6;
            this.TreatmentName.Name = "TreatmentName";
            this.TreatmentName.Width = 125;
            // 
            // Client
            // 
            this.Client.DataPropertyName = "Client";
            this.Client.HeaderText = "Client";
            this.Client.MinimumWidth = 6;
            this.Client.Name = "Client";
            this.Client.Width = 125;
            // 
            // PaymentIntent
            // 
            this.PaymentIntent.DataPropertyName = "PaymentIntent";
            this.PaymentIntent.HeaderText = "PaymentIntent";
            this.PaymentIntent.MinimumWidth = 6;
            this.PaymentIntent.Name = "PaymentIntent";
            this.PaymentIntent.Width = 125;
            // 
            // frmPayments
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(914, 600);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cmbClients);
            this.Controls.Add(this.cmbTreatments);
            this.Controls.Add(this.txtPaymentIntent);
            this.Controls.Add(this.dgvPayments);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmPayments";
            this.Text = "Payments";
            this.Load += new System.EventHandler(this.frmPayments_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvPayments)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DataGridView dgvPayments;
        private TextBox txtPaymentIntent;
        private ComboBox cmbTreatments;
        private ComboBox cmbClients;
        private Label label2;
        private Label label3;
        private Label label4;
        private Button btnSearch;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn Date;
        private DataGridViewTextBoxColumn Amount;
        private DataGridViewTextBoxColumn TreatmentName;
        private DataGridViewTextBoxColumn Client;
        private DataGridViewTextBoxColumn CardNumber;
        private DataGridViewTextBoxColumn PaymentIntent;
    }
}