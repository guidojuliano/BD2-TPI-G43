using System;

namespace AppFarmacia
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarReportes();
            }
        }

        private void CargarReportes()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                dgvStockBajo.DataSource = datos.ObtenerTabla("SELECT * FROM Vista_StockBajo");
                dgvStockBajo.DataBind();

                dgvVentasMes.DataSource = datos.ObtenerTabla("SELECT * FROM Vista_VentasMes");
                dgvVentasMes.DataBind();

                dgvTopMedicamentos.DataSource = datos.ObtenerTabla("SELECT * FROM Vista_TopMedicamentos");
                dgvTopMedicamentos.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al cargar reportes: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }
    }
}
