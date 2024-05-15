namespace DentalOffice.WinFormsUI.Forms.Treatments
{
    partial class frmTreatments
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
            this.dgvTreatments = new System.Windows.Forms.DataGridView();
            this.Id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TreatmentName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Price = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TimeRequiredInMinutes = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.txtName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnSearch = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvTreatments)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvTreatments
            // 
            this.dgvTreatments.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvTreatments.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Id,
            this.TreatmentName,
            this.Price,
            this.TimeRequiredInMinutes});
            this.dgvTreatments.Location = new System.Drawing.Point(14, 184);
            this.dgvTreatments.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.dgvTreatments.Name = "dgvTreatments";
            this.dgvTreatments.RowHeadersWidth = 51;
            this.dgvTreatments.RowTemplate.Height = 25;
            this.dgvTreatments.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvTreatments.Size = new System.Drawing.Size(887, 400);
            this.dgvTreatments.TabIndex = 0;
            this.dgvTreatments.CellMouseDoubleClick += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dgvTreatments_CellMouseDoubleClick);
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
            // Name
            // 
            this.TreatmentName.DataPropertyName = "Name";
            this.TreatmentName.HeaderText = "Name";
            this.TreatmentName.MinimumWidth = 6;
            this.TreatmentName.Name = "Name";
            this.TreatmentName.Width = 125;
            // 
            // Price
            // 
            this.Price.DataPropertyName = "Price";
            this.Price.HeaderText = "Price";
            this.Price.MinimumWidth = 6;
            this.Price.Name = "Price";
            this.Price.Width = 125;
            // 
            // TimeRequiredInMinutes
            // 
            this.TimeRequiredInMinutes.DataPropertyName = "TimeRequiredInMinutes";
            this.TimeRequiredInMinutes.HeaderText = "Duration in minutes";
            this.TimeRequiredInMinutes.MinimumWidth = 6;
            this.TimeRequiredInMinutes.Name = "TimeRequiredInMinutes";
            this.TimeRequiredInMinutes.Width = 125;
            // 
            // txtName
            // 
            this.txtName.Location = new System.Drawing.Point(14, 73);
            this.txtName.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.txtName.Name = "txtName";
            this.txtName.Size = new System.Drawing.Size(275, 27);
            this.txtName.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 49);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(49, 20);
            this.label1.TabIndex = 2;
            this.label1.Text = "Name";
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(800, 141);
            this.btnSearch.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(101, 35);
            this.btnSearch.TabIndex = 3;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(14, 156);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(350, 20);
            this.label2.TabIndex = 4;
            this.label2.Text = "*Double click on cells for opening treatment details";
            // 
            // frmTreatments
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(914, 600);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtName);
            this.Controls.Add(this.dgvTreatments);
            this.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.Name = "frmTreatments";
            this.Text = "Treatments";
            this.Load += new System.EventHandler(this.frmTreatments_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvTreatments)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DataGridView dgvTreatments;
        private TextBox txtName;
        private Label label1;
        private Button btnSearch;
        private DataGridViewTextBoxColumn Id;
        private DataGridViewTextBoxColumn TreatmentName;
        private DataGridViewTextBoxColumn Price;
        private DataGridViewTextBoxColumn TimeRequiredInMinutes;
        private Label label2;
    }
}