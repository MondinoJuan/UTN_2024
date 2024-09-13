using System;

namespace Clases1
{
    public class A
    {
        public string NombreInstancia {  get; private set; }  

        public A() 
        {
            this.NombreInstancia = "Instancia Sin Nombre";
        }

        public A(string value)
        {
            this.NombreInstancia = value;
        }

        public void MostrarNombre()
        {
            Console.WriteLine($"Nombre de la Instancia: {this.NombreInstancia}");
        }

        public void M1()
        {
            Console.WriteLine("El metodo M1 fue llamado");
        }

        public void M2()
        {
            Console.WriteLine("El metodo M2 fue llamado");
        }

        public void M3()
        {
            Console.WriteLine("El metodo M3 fue llamado");
        }


    }
}
