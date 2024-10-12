namespace Escritorio
{
    partial class Lista
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
            label1SeleccionarAlumno = new Label();
            button1MostrarAlumno = new Button();
            comboBoxAlumnos = new ComboBox();
            SuspendLayout();
            // 
            // label1SeleccionarAlumno
            // 
            label1SeleccionarAlumno.AutoSize = true;
            label1SeleccionarAlumno.Location = new Point(124, 101);
            label1SeleccionarAlumno.Name = "label1SeleccionarAlumno";
            label1SeleccionarAlumno.Size = new Size(168, 25);
            label1SeleccionarAlumno.TabIndex = 1;
            label1SeleccionarAlumno.Text = "Seleccionar Alumno";
            label1SeleccionarAlumno.Click += label1_Click;
            // 
            // button1MostrarAlumno
            // 
            button1MostrarAlumno.Location = new Point(563, 100);
            button1MostrarAlumno.Name = "button1MostrarAlumno";
            button1MostrarAlumno.Size = new Size(112, 34);
            button1MostrarAlumno.TabIndex = 2;
            button1MostrarAlumno.Text = "Mostrar";
            button1MostrarAlumno.UseVisualStyleBackColor = true;
            button1MostrarAlumno.Click += button1_Click;
            // 
            // comboBoxAlumnos
            // 
            comboBoxAlumnos.FormattingEnabled = true;
            comboBoxAlumnos.Location = new Point(323, 101);
            comboBoxAlumnos.Name = "comboBoxAlumnos";
            comboBoxAlumnos.Size = new Size(182, 33);
            comboBoxAlumnos.TabIndex = 3;
            // 
            // Lista
            // 
            AutoScaleDimensions = new SizeF(10F, 25F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(800, 450);
            Controls.Add(comboBoxAlumnos);
            Controls.Add(button1MostrarAlumno);
            Controls.Add(label1SeleccionarAlumno);
            Name = "Lista";
            Text = "Form2";
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion
        private Label label1SeleccionarAlumno;
        private Button button1MostrarAlumno;
        private ComboBox comboBoxAlumnos;
    }
}