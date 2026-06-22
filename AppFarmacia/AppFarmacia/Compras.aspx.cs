using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Servicio;

namespace AppFarmacia
{
    public partial class Compras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProveedores();
                CargarMedicamentos();
            }
        }

        private void CargarProveedores()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                DataTable tabla = datos.ObtenerTabla("SELECT Id_proveedor, Razon_social FROM Proveedores ORDER BY Razon_social ASC");
                ddlProveedor.Items.Clear();
                ddlProveedor.Items.Add(new System.Web.UI.WebControls.ListItem("-- Seleccionar Proveedor --", ""));
                foreach (DataRow row in tabla.Rows)
                {
                    ddlProveedor.Items.Add(new System.Web.UI.WebControls.ListItem(row["Razon_social"].ToString(), row["Id_proveedor"].ToString()));
                }
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error al cargar proveedores: " + ex.Message;
                pnlMensajeError.Visible = true;
            }
        }

        private void CargarMedicamentos()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                DataTable tabla = datos.ObtenerTabla(@"
                    SELECT 
                        Nombre + ' (' + Principio_activo + ' - ' + Laboratorio + ') [ID: ' + CAST(Id_medicamento AS VARCHAR) + ']' AS Display 
                    FROM Medicamentos 
                    ORDER BY Nombre ASC");
                rptMedicamentos.DataSource = tabla;
                rptMedicamentos.DataBind();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error al cargar medicamentos: " + ex.Message;
                pnlMensajeError.Visible = true;
            }
        }

        private long ObtenerIdMedicamentoSeleccionado()
        {
            string texto = txtMedicamento.Text;
            if (string.IsNullOrEmpty(texto)) return 0;

            int startIndex = texto.LastIndexOf("[ID: ");
            if (startIndex == -1) return 0;

            int endIndex = texto.LastIndexOf("]");
            if (endIndex == -1 || endIndex <= startIndex) return 0;

            string idStr = texto.Substring(startIndex + 5, endIndex - (startIndex + 5));
            long id;
            if (long.TryParse(idStr, out id))
            {
                return id;
            }
            return 0;
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            pnlMensajeExito.Visible = false;
            pnlMensajeError.Visible = false;

            long idMedicamento = ObtenerIdMedicamentoSeleccionado();

            if (ddlProveedor.SelectedIndex <= 0 ||
                idMedicamento == 0 ||
                string.IsNullOrEmpty(txtCantidad.Text) ||
                string.IsNullOrEmpty(txtPrecioCosto.Text))
            {
                lblMensajeError.Text = "Por favor, complete todos los campos obligatorios.";
                pnlMensajeError.Visible = true;
                return;
            }

            AccesoDatos datos = new AccesoDatos();
            try
            {
                List<SqlParameter> parametros = new List<SqlParameter>
                {
                    new SqlParameter("@IdProveedor", Convert.ToInt64(ddlProveedor.SelectedValue)),
                    new SqlParameter("@IdPedido", DBNull.Value),
                    new SqlParameter("@IdMedicamento", idMedicamento),
                    new SqlParameter("@Cantidad", Convert.ToInt32(txtCantidad.Text)),
                    new SqlParameter("@PrecioCosto", Convert.ToDecimal(txtPrecioCosto.Text))
                };

                datos.EjecutarSP("sp_IngresarStock", parametros);

                lblMensajeExito.Text = "El ingreso de stock se registro correctamente y se actualizaron las alertas correspondientes.";
                pnlMensajeExito.Visible = true;

                LimpiarFormulario();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error al registrar ingreso de stock: " + ex.Message;
                pnlMensajeError.Visible = true;
            }
        }

        private void LimpiarFormulario()
        {
            ddlProveedor.SelectedIndex = 0;
            txtMedicamento.Text = "";
            txtCantidad.Text = "";
            txtPrecioCosto.Text = "";
        }
    }
}
