using System.Runtime.CompilerServices;
using System;

namespace Persona
{
    public class Persona : IDisposable
    {
        protected string? _nombre;
        protected string? _apellido;
        protected int _edad;
        protected int _dni;

        public string Nombre
        {
            get
            {
                return _nombre;
            }
            set
            {
                _nombre = value;
            }
        }
        public string Apellido
        {
            get
            {
                return _apellido;
            }
            set
            {
                _apellido = value;
            }
        }
        public int Edad
        {
            get
            {
                return _edad;
            }
            set
            {
                _edad = value;
            }
        }
        public int DNI {
            get 
            {
                return _dni;
            }
            set 
            {
                _dni = value;
            } 
        }
    
    
        public Persona(string aName, string aSurnname, int anAge, int aDNI)
        {
            this.Nombre = aName;
            this.Apellido = aSurnname;
            this.Edad = anAge;  
            this.DNI = aDNI;

            Console.WriteLine("Se creo el Objeto");
            
        }

        public void Dispose()
        {
            Console.WriteLine("Destructor Llamado");
            

            GC.SuppressFinalize(this);
        }

        ~Persona()
        {
            Dispose();
        }


        public string GetFullName()
        {
            return ($"{this.Nombre} {this.Apellido}");
        }

        public int GetAge()
        {
            return this.Edad;
        }

    }
}
