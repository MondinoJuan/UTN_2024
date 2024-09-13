using Clases2;

internal class Program
{
    private static void Main(string[] args)
    {
        B b = new B();
        A a = b;
        a.F();
        b.F();
        a.G();
        b.G();

        Console.ReadKey();

    }
}