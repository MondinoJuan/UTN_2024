using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class Alumno
    {
        string apellidoNombre, dni, email;
        int id;
        DateTime fechaNacimiento;
        decimal notaPromedio;

        public Alumno()
        {
            //Constructor sin parámetros
        }

        public Alumno(string AyN, string denei, string emailIng, int ide, DateTime fechaNac, decimal prome)
        {
            this.ApellidoNombre = AyN;
            this.Dni = denei;
            this.Email = emailIng;
            this.Id = ide;
            this.FechaNacimiento = fechaNac;
            this.NotaPromedio = prome;
        }

        public string ApellidoNombre
        {
            get
            {
                return apellidoNombre;
            }

            set
            {
                apellidoNombre = value;
            }
        }

        public string Dni
        {
            get
            {
                return dni;
            }

            set
            {
                dni = value;
            }
        }
 
        public int Edad
        {
            get
            {
                DateTime hoy = DateTime.Today;
                int edad = hoy.Year - FechaNacimiento.Year;
                if (hoy < FechaNacimiento.AddYears(edad)) edad--;
                return edad;
            }
        }

        public string Email
        {
            get
            {
                return email;
            }

            set
            {
                email = value;
            }
        }

        public DateTime FechaNacimiento
        {
            get
            {
                return fechaNacimiento;
            }

            set
            {
                fechaNacimiento = value;
            }
        }

        public int Id
        {
            get
            {
                return id;
            }

            set
            {
                id = value;
            }
        }

        public decimal NotaPromedio
        {
            get
            {
                return notaPromedio;
            }

            set
            {
                notaPromedio = value;
            }
        }
    }
}
