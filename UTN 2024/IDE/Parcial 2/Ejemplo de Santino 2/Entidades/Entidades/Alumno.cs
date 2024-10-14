namespace Cataldi.Entidades
{
    public class Alumno
    {
   
        string _dni;

        public string ApellidoNombre { get; set; }

        public string Dni
        {
            get { return this._dni; }
            set { this._dni = value; }
        }
        public int Edad {
            get { 
                
                
                int edad = DateTime.Today.Year - this.FechaNacimiento.Year; 
                if (DateTime.Today.AddYears(-edad) < this.FechaNacimiento)
                {
                    edad--;
                }
                return edad;
            
            }

        }
        public string Email { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public int Id { get; set; }
        public decimal NotaPromedio { get; set; }

        public Alumno() { }
        public Alumno(string dni, string apellidoNombre, string email, DateTime fechaNacimiento, int id, decimal notaPromedio) {
            
            this.Dni = dni;
            this.ApellidoNombre = apellidoNombre;
            this.Email = email;
            this.FechaNacimiento = fechaNacimiento;
            this.Id = id;
            this.NotaPromedio = notaPromedio;
        }





    }
}
