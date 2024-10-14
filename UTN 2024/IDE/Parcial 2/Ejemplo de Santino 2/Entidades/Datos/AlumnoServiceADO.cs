using Cataldi.Entidades;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class AlumnoServiceADO
    {
        

        public IEnumerable<Alumno> GetAll()
        {
            var alumnos = new List<Alumno>();
            using (var context = new AlumnoContextADO())
            using (var connection = context.GetConnection())
            {
                connection.Open();
                string query = "SELECT Dni, ApellidoNombre, Email, FechaNacimiento, Id, NotaPromedio FROM Alumnos";
                using (SqlCommand cmd = new SqlCommand(query, connection))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var alumno = new Alumno
                        {
                            Dni = reader.GetString(0), // Asegúrate de que esto sea la columna correcta
                            ApellidoNombre = reader.GetString(1),
                            Email = reader.GetString(2),
                            FechaNacimiento = reader.GetDateTime(3), // Cambia 8 por 3 según el ejemplo
                            Id = reader.GetInt32(4), // Cambia 0 por 4
                            NotaPromedio = reader.GetDecimal(5) // Cambia 10 por 5
                        };
                        while (reader.Read())
                        alumnos.Add(alumno);
                    }
                }
            }

            return alumnos;
        }

        public void Add(Alumno alumno)
        {
            using (var context = new AlumnoContextADO())
            using (var connection = context.GetConnection())
            {
                connection.Open();
                using (var command = new SqlCommand("INSERT INTO Alumnos (Dni, ApellidoNombre, Email, FechaNacimiento, NotaPromedio) VALUES (@Dni, @ApellidoNombre, @Email, @FechaNacimiento, @NotaPromedio)", connection))
                {
                    command.Parameters.AddWithValue("@Dni", alumno.Dni);
                    command.Parameters.AddWithValue("@ApellidoNombre", alumno.ApellidoNombre);
                    command.Parameters.AddWithValue("@Email", alumno.Email);
                    command.Parameters.AddWithValue("@FechaNacimiento", alumno.FechaNacimiento);
                    command.Parameters.AddWithValue("@NotaPromedio", alumno.NotaPromedio);
                    command.ExecuteNonQuery();
                }
            }
        }

        public void Update(Alumno alumno)
        {
            using (var context = new AlumnoContextADO())
            using (var connection = context.GetConnection())
            {
                connection.Open();
                using (var command = new SqlCommand("UPDATE Alumnos SET Dni = @Dni, ApellidoNombre = @ApellidoNombre, Email = @Email, FechaNacimiento = @FechaNacimiento, NotaPromedio = @NotaPromedio WHERE Id = @Id", connection))
                {
                    command.Parameters.AddWithValue("@Dni", alumno.Dni);
                    command.Parameters.AddWithValue("@ApellidoNombre", alumno.ApellidoNombre);
                    command.Parameters.AddWithValue("@Email", alumno.Email);
                    command.Parameters.AddWithValue("@FechaNacimiento", alumno.FechaNacimiento);
                    command.Parameters.AddWithValue("@NotaPromedio", alumno.NotaPromedio);
                    command.Parameters.AddWithValue("@Id", alumno.Id);
                    command.ExecuteNonQuery();
                }
            }
        }

        public Alumno? Get(int id)
        {
            using (var context = new AlumnoContextADO())
            using (var connection = context.GetConnection())
            {
                connection.Open();
                using (var command = new SqlCommand("SELECT * FROM Alumnos WHERE Id = @Id", connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Alumno
                            {
                                Dni = reader.GetString(0),
                                ApellidoNombre = reader.GetString(1),
                                Email = reader.GetString(2),
                                FechaNacimiento = reader.GetDateTime(3),
                                Id = reader.GetInt32(4),
                                NotaPromedio = reader.GetDecimal(5)
                            };
                        }
                    }
                }
            }
            return null; // Retorna null si no se encuentra el alumno
        }

        public void Delete(int id)
        {
            using (var context = new AlumnoContextADO())
            using (var connection = context.GetConnection())
            {
                connection.Open();
                using (var command = new SqlCommand("DELETE FROM Alumnos WHERE Id = @Id", connection))
                {
                    command.Parameters.AddWithValue("@Id", id);
                    command.ExecuteNonQuery();
                }
            }
        }



    }


}
