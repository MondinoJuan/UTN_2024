using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    class AlumnoContextADO : DbContext
    {

        
        private readonly string _connectionString = @"Server=(localdb)\MSSQLLocalDB;Initial Catalog=AlumnoDb";

        public SqlConnection GetConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}

