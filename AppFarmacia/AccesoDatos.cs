using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace AppFarmacia
{
    public class AccesoDatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public AccesoDatos()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DB_Farmacia"]?.ConnectionString 
                ?? "server=.\\SQLEXPRESS; database=BD2_TPI_G43; integrated security=true";
            conexion = new SqlConnection(connectionString);
            comando = new SqlCommand();
        }

        public SqlDataReader Lector
        {
            get { return lector; }
        }

        public DataTable ObtenerTabla(string query, List<SqlParameter> parametros = null)
        {
            DataTable tabla = new DataTable();
            try
            {
                if (conexion.State != ConnectionState.Open)
                    conexion.Open();

                using (SqlCommand cmd = new SqlCommand(query, conexion))
                {
                    if (parametros != null)
                        cmd.Parameters.AddRange(parametros.ToArray());

                    using (SqlDataAdapter adaptador = new SqlDataAdapter(cmd))
                    {
                        adaptador.Fill(tabla);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new Exception("Error al obtener datos: " + ex.Message, ex);
            }
            finally
            {
                if (conexion.State == ConnectionState.Open)
                    conexion.Close();
            }
            return tabla;
        }

        public void EjecutarSP(string nombreSP, List<SqlParameter> parametros = null)
        {
            try
            {
                if (conexion.State != ConnectionState.Open)
                    conexion.Open();

                using (SqlCommand cmd = new SqlCommand(nombreSP, conexion))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (parametros != null)
                        cmd.Parameters.AddRange(parametros.ToArray());

                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message, ex);
            }
            finally
            {
                if (conexion.State == ConnectionState.Open)
                    conexion.Close();
            }
        }
    }
}
