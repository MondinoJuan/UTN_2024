using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Jugada
{
    public class Jugada
    {
        public int Numero {  get; set; }
        public Jugada(int maxNumero)
        {
            Random rnd = new Random();
            Numero = rnd.Next(maxNumero);
        }

    }
}
