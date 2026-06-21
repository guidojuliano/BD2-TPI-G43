using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Servicio;
using Dominio;

namespace AppFarmacia
{
    public partial class Ventas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnVender_Click(object sender, EventArgs e)
        {
            pnlMensajeExito.Visible = false;
            pnlMensajeError.Visible = false;

            if (string.IsNullOrEmpty(txtIdEmpleado.Text) || 
                string.IsNullOrEmpty(txtIdMedicamento.Text) || 
                string.IsNullOrEmpty(txtCantidad.Text) || 
                string.IsNullOrEmpty(txtPrecioCobrado.Text))
            {
                lblMensajeError.Text = "Por favor, complete todos los campos obligatorios.";
                pnlMensajeError.Visible = true;
                return;
            }

            AccesoDatos datos = new AccesoDatos();
            try
            {
                object idClienteVal = string.IsNullOrEmpty(txtIdCliente.Text) 
                    ? (object)DBNull.Value 
                    : Convert.ToInt64(txtIdCliente.Text);

                List<SqlParameter> parametros = new List<SqlParameter>
                {
                    new SqlParameter("@IdCliente", idClienteVal),
                    new SqlParameter("@IdEmpleado", Convert.ToInt64(txtIdEmpleado.Text)),
                    new SqlParameter("@IdMedicamento", Convert.ToInt64(txtIdMedicamento.Text)),
                    new SqlParameter("@Cantidad", Convert.ToInt32(txtCantidad.Text)),
                    new SqlParameter("@PrecioUnitarioCobrado", Convert.ToDecimal(txtPrecioCobrado.Text)),
                    new SqlParameter("@Observaciones", string.IsNullOrEmpty(txtObservaciones.Text) ? (object)DBNull.Value : txtObservaciones.Text)
                };

                datos.EjecutarSP("sp_RegistrarVenta", parametros);

                lblMensajeExito.Text = "¡La venta se registró con éxito en el sistema!";
                pnlMensajeExito.Visible = true;

                LimpiarFormulario();
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error al registrar venta: " + ex.Message;
                pnlMensajeError.Visible = true;
            }
        }

        private void LimpiarFormulario()
        {
            txtIdCliente.Text = "";
            txtIdEmpleado.Text = "";
            txtIdMedicamento.Text = "";
            txtCantidad.Text = "";
            txtPrecioCobrado.Text = "";
            txtObservaciones.Text = "";
        }
    }
}
