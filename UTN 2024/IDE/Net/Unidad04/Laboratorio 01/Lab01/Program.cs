using System;
using System.IO;
using System.Xml;
internal class Program
{
    private static void Main(string[] args)
    {
        //Escribir();

        //Leer();

        //Console.WriteLine("Presone cualquier tecla para continuar... ");
        //Console.ReadKey();


        Console.WriteLine("Presione una tecla para generar el archivo agendaXML con los datos de agenda.txt");
        Console.ReadKey();
        EscribirXML();
        Console.WriteLine("Archivo generado correctamente, presione una tecla para ver su contenido");
        Console.ReadKey();
        Console.WriteLine();
        LeerXML();
        Console.ReadKey();




    }

    private static void Leer()
    {
        StreamReader lector = File.OpenText("agenda.txt");
        string linea;

        do
        {
            linea = lector.ReadLine();
            if (linea != null)
            {
                string[] valores = linea.Split(';');
                Console.WriteLine("{0}\t {1}\t {2}\t {3}\t", valores[0], valores[1], valores[2], valores[3]);
            }

        } while (linea != null);

        lector.Close();
    }


    private static void Escribir()
    {

        StreamWriter escritor = File.AppendText("agenda.txt");
        Console.WriteLine("Ingrese nuevos contactos");
        string rta = "S";

        while (rta == "S")
        {
            Console.Write("Ingrese nombre: ");
            string nombre = Console.ReadLine();
            Console.WriteLine();

            Console.Write("Ingrese apellido: ");
            string apellido = Console.ReadLine();
            Console.WriteLine();

            Console.Write("Ingrese email: ");
            string email = Console.ReadLine();
            Console.WriteLine();

            Console.Write("Ingrese telefono: ");
            string telefono = Console.ReadLine();
            Console.WriteLine();
            Console.WriteLine();

            escritor.WriteLine(nombre + ";" + apellido + ";" + email + ";" + telefono);


            Console.Write("Desea ingresar otro contacto? (S/N)");
            rta = Console.ReadLine();

        }

        escritor.Close();


    }


    public static void EscribirXML()
    {
        XmlTextWriter escritorXML = new XmlTextWriter("agenda.txt", null);
        escritorXML.Formatting = Formatting.Indented;
        escritorXML.WriteStartDocument(true);
        escritorXML.WriteStartElement("Document Element");

        StreamReader lector = File.OpenText("agenda.txt");
        string linea;

        do
        {
            linea = lector.ReadLine();  

            if (linea != null)
                    {
                string[] valores = linea.Split(";");
                escritorXML.WriteStartElement("contactos");
                escritorXML.WriteStartElement("nombre");
                escritorXML.WriteValue(valores[0]);
                escritorXML.WriteEndElement(); //cerramos el tag de nombre
                escritorXML.WriteStartElement ("apellido");
                escritorXML.WriteValue(valores[1]);
                escritorXML.WriteEndElement(); //cerramos el tag de apellido
                escritorXML.WriteStartElement("email");
                escritorXML.WriteValue(valores[2]);
                escritorXML.WriteEndElement(); //cerramos el tag de email
                escritorXML.WriteStartElement ("telefono");
                escritorXML.WriteValue(valores[3]);
                escritorXML.WriteEndElement(); //cerramos el tag de telefono
                escritorXML.WriteEndElement(); // cerramos el tag de contactos
            }
        
        } while (linea != null);

        escritorXML.WriteEndElement();
        escritorXML.WriteEndDocument(); 
        escritorXML.Close();

        lector.Close();


    }


    public static void LeerXML()
    {
        XmlTextReader lectorXML = new XmlTextReader("agendaxml.txt");

        string tagAnterior = "";
        while (lectorXML.Read())
        {
            if(lectorXML.NodeType == XmlNodeType.Element)
            {
                tagAnterior = lectorXML.Name;
            }
            else if (lectorXML.NodeType == XmlNodeType.Text)
            {
                Console.WriteLine(tagAnterior + ": " + lectorXML.Value);
            }
        }

        lectorXML.Close();  
    }




}


        
