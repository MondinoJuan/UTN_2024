using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

namespace BaseDeDatos
{
    public class Adaptador
    {
        private SqlConnection sqlCon;
        const string claveConexionDefecto = "CadenaDeConexionLocal";

        public SqlConnection SqlCon
        {
            get
            {
                return sqlCon;
            }

            set
            {
                sqlCon = value;
            }
        }

        protected void AbrirConexion()
        {
            string cadenaConexion = ConfigurationManager.ConnectionStrings[claveConexionDefecto].ConnectionString;
            SqlCon = new SqlConnection(cadenaConexion);
            SqlCon.Open();
        }

        protected void CerrarConexion()
        {
            SqlCon.Close();
            SqlCon = null;
        }
    }
}