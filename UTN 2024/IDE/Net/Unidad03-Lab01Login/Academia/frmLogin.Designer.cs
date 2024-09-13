namespace Academia
{
    partial class frmLogin
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            lblGreeting = new Label();
            lblUsername = new Label();
            lblPassword = new Label();
            txtUsername = new TextBox();
            txtPassword = new TextBox();
            btnSubmit = new Button();
            lnkForgottenPassword = new LinkLabel();
            SuspendLayout();
            // 
            // lblGreeting
            // 
            lblGreeting.AutoSize = true;
            lblGreeting.Location = new Point(85, 37);
            lblGreeting.Name = "lblGreeting";
            lblGreeting.Size = new Size(229, 30);
            lblGreeting.TabIndex = 0;
            lblGreeting.Text = "¡Bienvenido al Sistema!\r\nPor favor digite su información de Ingreso\r\n";
            lblGreeting.TextAlign = ContentAlignment.MiddleCenter;
            // 
            // lblUsername
            // 
            lblUsername.AutoSize = true;
            lblUsername.Location = new Point(39, 93);
            lblUsername.Name = "lblUsername";
            lblUsername.Size = new Size(113, 15);
            lblUsername.TabIndex = 1;
            lblUsername.Text = "Nombre de Usuario:";
            // 
            // lblPassword
            // 
            lblPassword.AutoSize = true;
            lblPassword.Location = new Point(82, 142);
            lblPassword.Name = "lblPassword";
            lblPassword.Size = new Size(70, 15);
            lblPassword.TabIndex = 2;
            lblPassword.Text = "Contraseña:";
            // 
            // txtUsername
            // 
            txtUsername.Location = new Point(162, 90);
            txtUsername.Name = "txtUsername";
            txtUsername.Size = new Size(210, 23);
            txtUsername.TabIndex = 3;
            // 
            // txtPassword
            // 
            txtPassword.Location = new Point(162, 139);
            txtPassword.Name = "txtPassword";
            txtPassword.PasswordChar = '*';
            txtPassword.Size = new Size(210, 23);
            txtPassword.TabIndex = 4;
            // 
            // btnSubmit
            // 
            btnSubmit.Location = new Point(297, 182);
            btnSubmit.Name = "btnSubmit";
            btnSubmit.Size = new Size(75, 23);
            btnSubmit.TabIndex = 5;
            btnSubmit.Text = "Ingresar";
            btnSubmit.UseVisualStyleBackColor = true;
            btnSubmit.Click += btnSubmit_Click;
            // 
            // lnkForgottenPassword
            // 
            lnkForgottenPassword.AutoSize = true;
            lnkForgottenPassword.Location = new Point(39, 228);
            lnkForgottenPassword.Name = "lnkForgottenPassword";
            lnkForgottenPassword.Size = new Size(119, 15);
            lnkForgottenPassword.TabIndex = 6;
            lnkForgottenPassword.TabStop = true;
            lnkForgottenPassword.Text = "Olvide mi contraseña";
            lnkForgottenPassword.LinkClicked += lnkForgottenPassword_LinkClicked;
            // 
            // frmLogin
            // 
            AcceptButton = btnSubmit;
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(414, 263);
            Controls.Add(lnkForgottenPassword);
            Controls.Add(btnSubmit);
            Controls.Add(txtPassword);
            Controls.Add(txtUsername);
            Controls.Add(lblPassword);
            Controls.Add(lblUsername);
            Controls.Add(lblGreeting);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "frmLogin";
            StartPosition = FormStartPosition.CenterParent;
            Text = "Ingreso";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label lblGreeting;
        private Label lblUsername;
        private Label lblPassword;
        private TextBox txtUsername;
        private TextBox txtPassword;
        private Button btnSubmit;
        private LinkLabel lnkForgottenPassword;
    }
}
