using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Alumno2
    {
        private string _dni;
        public string NombreyApellido { get; set; }
        public int Id { get; set; }
        public string Email { get; set; }
        public string Direccion { get; set; }

        public DateTime FechaNacimiento { get; set; }

        public string Dni
        {
            get { return _dni; }
            set { this._dni = value; }
        }

        public int Edad
        {
            get { 
                int edad = this.FechaNacimiento.Year - DateTime.Today.Year;
                if (this.FechaNacimiento > DateTime.Today.AddYears(-this.FechaNacimiento.Year))
                {
                    edad--;
                }
                return edad;

            }
        }


    }
}
