using Clases1;
internal class Program
{
    private static void Main(string[] args)
    {
        
        A instanciaDeA = new A("increible");

        B instanciaDeB = new B();

        instanciaDeA.MostrarNombre();

        instanciaDeB.MostrarNombre();


        instanciaDeA.M1();
        instanciaDeA.M2();
        instanciaDeA.M3();

        instanciaDeB.M1();
        instanciaDeB.M2();
        instanciaDeB.M3();
        instanciaDeB.M4();




    }
}