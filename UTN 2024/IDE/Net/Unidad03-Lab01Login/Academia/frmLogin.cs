namespace Academia
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            if (this.txtUsername.Text == "Admin" && this.txtPassword.Text == "admin") 
            {
                this.DialogResult = DialogResult.OK;
            }
            else
            {
                MessageBox.Show("Usuario y/o contraseña incorrectos.", "Login"
                    , MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void lnkForgottenPassword_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            MessageBox.Show("Es usted un usuario muy descuidado, haga memoria", "Olvide mi contraseña", 
                MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        }
    }
}
