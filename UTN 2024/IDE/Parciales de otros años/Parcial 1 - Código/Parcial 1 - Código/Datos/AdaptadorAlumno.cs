using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entidades;
using System.Data;
using System.Data.SqlClient;

namespace BaseDeDatos
{
    public class AdaptadorAlumno : Adaptador
    {
        public List<Alumno> TraerTodos()
        {
            List<Alumno> alumnos = new List<Alumno>();
            try
            {
                this.AbrirConexion();
                SqlCommand cmdPersonas = new SqlCommand("select * from personas", SqlCon);
                SqlDataReader drAlumnos = cmdPersonas.ExecuteReader();
                while (drAlumnos.Read())
                {
                    Alumno per = new Alumno();
                    per.Id = (int)drAlumnos["id_persona"];
                    per.ApellidoNombre = (string)drAlumnos["apellido"];
                    per.Email = (string)drAlumnos["email"];
                    per.Dni = (string)drAlumnos["telefono"];
                    per.FechaNacimiento = (DateTime)drAlumnos["fecha_nac"];
                    alumnos.Add(per);
                }
                drAlumnos.Close();
                return alumnos;
            }
            catch (Exception ex)
            {
                Exception excepcion = new Exception("Error al traer todas las personas", ex);
                throw excepcion;
            }
            finally
            {
                CerrarConexion();
            }
        }

        public Alumno TraerUno(int id)
        {
            Alumno alumno = new Alumno();
            try
            {
                this.AbrirConexion();
                SqlCommand cmdPersonas = new SqlCommand("select * from personas where id_persona=@id", SqlCon);
                cmdPersonas.Parameters.Add("@id", SqlDbType.Int).Value = id;
                SqlDataReader drAlumnos = cmdPersonas.ExecuteReader();
                while (drAlumnos.Read())
                {
                    alumno.Id = (int)drAlumnos["id_persona"];
                    alumno.ApellidoNombre = (string)drAlumnos["apellido"];
                    alumno.Email = (string)drAlumnos["email"];
                    alumno.FechaNacimiento = (DateTime)drAlumnos["fecha_nac"];
                }
                drAlumnos.Close();
                return alumno;
            }
            //catch (Exception ex)
            //{
            //    Exception excepcion = new Exception("Error al traer todas las personas", ex);
            //    throw excepcion;
            //}
            finally
            {
                CerrarConexion();
            }
        }
    }
}