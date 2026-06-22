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
            if (!IsPostBack)
            {
                CargarMedicamentos();
                CalcularPrecioFinal();
            }
        }

        protected void txtIdCliente_TextChanged(object sender, EventArgs e)
        {
            CalcularPrecioFinal();
        }

        protected void txtMedicamento_TextChanged(object sender, EventArgs e)
        {
            CalcularPrecioFinal();
        }

        private void CargarMedicamentos()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                System.Data.DataTable tabla = datos.ObtenerTabla(@"
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

        private void CalcularPrecioFinal()
        {
            long idMedicamento = ObtenerIdMedicamentoSeleccionado();
            if (idMedicamento == 0)
            {
                txtPrecioCobrado.Text = "";
                pnlReceta.Visible = false;
                return;
            }

            decimal precioConIva = 0;
            bool requiereReceta = false;

            AccesoDatos datos = new AccesoDatos();
            try
            {
                string queryMed = "SELECT Precio_venta_con_iva, Requiere_receta FROM Medicamentos WHERE Id_medicamento = @IdMedicamento";
                List<SqlParameter> paramsMed = new List<SqlParameter> {
                    new SqlParameter("@IdMedicamento", idMedicamento)
                };
                System.Data.DataTable tablaMed = datos.ObtenerTabla(queryMed, paramsMed);
                if (tablaMed.Rows.Count > 0)
                {
                    precioConIva = Convert.ToDecimal(tablaMed.Rows[0]["Precio_venta_con_iva"]);
                    requiereReceta = Convert.ToBoolean(tablaMed.Rows[0]["Requiere_receta"]);
                }
            }
            catch (Exception ex)
            {
                lblMensajeError.Text = "Error al obtener precio del medicamento: " + ex.Message;
                pnlMensajeError.Visible = true;
                return;
            }

            pnlReceta.Visible = requiereReceta;

            decimal descuentoPorcentaje = 0;
            string infoCliente = "Cliente: Consumidor Final (Sin Obra Social)";

            if (!string.IsNullOrEmpty(txtIdCliente.Text))
            {
                long idCliente;
                if (long.TryParse(txtIdCliente.Text, out idCliente))
                {
                    try
                    {
                        string queryCli = "SELECT C.Nombre + ' ' + C.Apellido AS NombreCompleto, OS.Nombre AS ObraSocialNombre, OS.Descuento_general FROM Clientes C LEFT JOIN ObrasSociales OS ON C.Id_obra_social = OS.Id_obra_social WHERE C.Id_cliente = @IdCliente";
                        List<SqlParameter> paramsCli = new List<SqlParameter> {
                            new SqlParameter("@IdCliente", idCliente)
                        };
                        System.Data.DataTable tablaCli = datos.ObtenerTabla(queryCli, paramsCli);
                        if (tablaCli.Rows.Count > 0)
                        {
                            string nombreCliente = tablaCli.Rows[0]["NombreCompleto"].ToString();
                            object OSName = tablaCli.Rows[0]["ObraSocialNombre"];
                            object OSDesc = tablaCli.Rows[0]["Descuento_general"];

                            if (OSName != DBNull.Value && OSDesc != DBNull.Value)
                            {
                                descuentoPorcentaje = Convert.ToDecimal(OSDesc);
                                infoCliente = string.Format("Cliente: {0} - Obra Social: {1} ({2}% Descuento)", nombreCliente, OSName, descuentoPorcentaje);
                            }
                            else
                            {
                                infoCliente = string.Format("Cliente: {0} (Sin Obra Social)", nombreCliente);
                            }
                        }
                        else
                        {
                            infoCliente = "Cliente no encontrado (Se cobrara como Consumidor Final)";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMensajeError.Text = "Error al buscar cliente: " + ex.Message;
                        pnlMensajeError.Visible = true;
                    }
                }
                else
                {
                    infoCliente = "Codigo de cliente invalido";
                }
            }

            lblDetalleCliente.Text = infoCliente;

            decimal precioFinal = precioConIva * (1 - (descuentoPorcentaje / 100));
            txtPrecioCobrado.Text = precioFinal.ToString("F2");
        }

        protected void btnVender_Click(object sender, EventArgs e)
        {
            pnlMensajeExito.Visible = false;
            pnlMensajeError.Visible = false;

            long idMedicamento = ObtenerIdMedicamentoSeleccionado();

            if (string.IsNullOrEmpty(txtIdEmpleado.Text) || 
                idMedicamento == 0 || 
                string.IsNullOrEmpty(txtCantidad.Text) || 
                string.IsNullOrEmpty(txtPrecioCobrado.Text))
            {
                lblMensajeError.Text = "Por favor, complete todos los campos obligatorios.";
                pnlMensajeError.Visible = true;
                return;
            }

            if (pnlReceta.Visible)
            {
                if (string.IsNullOrEmpty(txtMedicoPrescriptor.Text) || string.IsNullOrEmpty(txtFechaEmision.Text))
                {
                    lblMensajeError.Text = "Por favor, complete los datos de la receta (Medico y Fecha).";
                    pnlMensajeError.Visible = true;
                    return;
                }
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
                    new SqlParameter("@IdMedicamento", idMedicamento),
                    new SqlParameter("@Cantidad", Convert.ToInt32(txtCantidad.Text)),
                    new SqlParameter("@PrecioUnitarioCobrado", Convert.ToDecimal(txtPrecioCobrado.Text)),
                    new SqlParameter("@Observaciones", string.IsNullOrEmpty(txtObservaciones.Text) ? (object)DBNull.Value : txtObservaciones.Text)
                };

                if (pnlReceta.Visible)
                {
                    parametros.Add(new SqlParameter("@MedicoPrescriptor", txtMedicoPrescriptor.Text));
                    parametros.Add(new SqlParameter("@FechaEmisionReceta", Convert.ToDateTime(txtFechaEmision.Text)));
                    parametros.Add(new SqlParameter("@RecetaObservaciones", string.IsNullOrEmpty(txtRecetaObservaciones.Text) ? (object)DBNull.Value : txtRecetaObservaciones.Text));
                }
                else
                {
                    parametros.Add(new SqlParameter("@MedicoPrescriptor", DBNull.Value));
                    parametros.Add(new SqlParameter("@FechaEmisionReceta", DBNull.Value));
                    parametros.Add(new SqlParameter("@RecetaObservaciones", DBNull.Value));
                }

                datos.EjecutarSP("sp_RegistrarVenta", parametros);

                lblMensajeExito.Text = "la venta se registro con exito en el sistema.";
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
            txtMedicamento.Text = "";
            txtCantidad.Text = "";
            txtPrecioCobrado.Text = "";
            txtObservaciones.Text = "";
            txtMedicoPrescriptor.Text = "";
            txtFechaEmision.Text = "";
            txtRecetaObservaciones.Text = "";
            pnlReceta.Visible = false;
            lblDetalleCliente.Text = "Cliente: Consumidor Final (Sin Obra Social)";
        }
    }
}
