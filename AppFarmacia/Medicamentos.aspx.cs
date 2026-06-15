using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace AppFarmacia
{
    public partial class Medicamentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Buscar("");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            Buscar(txtBuscar.Text.Trim());
        }

        private void Buscar(string termino)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                List<SqlParameter> parametros = new List<SqlParameter>
                {
                    new SqlParameter("@TerminoBusqueda", termino)
                };

                DataTable tabla = datos.ObtenerTabla("EXEC sp_BuscarMedicamento @TerminoBusqueda", parametros);
                dgvMedicamentos.DataSource = tabla;
                dgvMedicamentos.DataBind();

                pnlVacio.Visible = (tabla.Rows.Count == 0);
                dgvMedicamentos.Visible = (tabla.Rows.Count > 0);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al buscar: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}
