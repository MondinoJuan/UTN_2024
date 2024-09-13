using System;

namespace Clases
{
    public class A
    {
        //Atributos
        string _nomInst;

        //Constructor
        public A()
        {
            _nomInst = "Instancia sin nombre.";
        }

        public A(string nombre)
        {
            _nomInst = nombre;
        }

        //Propiedad
        public string NombreInstancia
        {
            get { return _nomInst; }
            set { _nomInst = value; }
        }

        //Método
        public void MostrarNombre()
        {
            Console.WriteLine(_nomInst);
        }

        public void M1()
        {
            Console.WriteLine("M1");
        }

        public void M2()
        {
            Console.WriteLine("M2");
        }

        public void M3()
        {
            Console.WriteLine("M3");
        }
    }


}
