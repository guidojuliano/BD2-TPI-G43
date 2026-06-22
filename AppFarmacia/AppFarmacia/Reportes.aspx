<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="AppFarmacia.Reportes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12 mb-4">
            <h2 class="fw-bold text-dark border-bottom pb-2">Panel de Estadísticas y Control de Inventario</h2>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-5">
            <div class="card shadow-sm border-danger">
                <div class="card-header bg-danger text-white fw-bold">Medicamentos Críticos a Reponer (Stock Bajo Mínimo)</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="dgvStockBajo" runat="server" CssClass="table table-hover table-striped mb-0 align-middle" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="Id_medicamento" HeaderText="ID" />
                                <asp:BoundField DataField="Nombre" HeaderText="Medicamento" />
                                <asp:BoundField DataField="Laboratorio" HeaderText="Laboratorio" />
                                <asp:BoundField DataField="Principio_activo" HeaderText="Principio Activo" />
                                <asp:BoundField DataField="Stock_actual" HeaderText="Stock Actual" />
                                <asp:BoundField DataField="Stock_minimo" HeaderText="Stock Mínimo" />
                                <asp:BoundField DataField="Precio_venta_con_iva" HeaderText="Precio Con IVA" DataFormatString="{0:C2}" HtmlEncode="false" />
                                <asp:TemplateField HeaderText="Requiere Receta">
                                    <ItemTemplate>
                                        <%# Convert.ToBoolean(Eval("Requiere_receta")) ? "Sí" : "No" %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-5">
            <div class="card shadow-sm border-primary">
                <div class="card-header bg-primary text-white fw-bold">Rendimiento y Facturación por Vendedor</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="dgvVentasMes" runat="server" CssClass="table table-hover table-striped mb-0 align-middle" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="Id_empleado" HeaderText="ID" />
                                <asp:BoundField DataField="Nombre_empleado" HeaderText="Nombre" />
                                <asp:BoundField DataField="Apellido_empleado" HeaderText="Apellido" />
                                <asp:BoundField DataField="Rol_empleado" HeaderText="Rol" />
                                <asp:BoundField DataField="Anio" HeaderText="Año" />
                                <asp:BoundField DataField="Mes" HeaderText="Mes" />
                                <asp:BoundField DataField="Cantidad_ventas" HeaderText="Ventas Realizadas" />
                                <asp:BoundField DataField="Total_facturado" HeaderText="Total Facturado" DataFormatString="{0:C2}" HtmlEncode="false" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 mb-5">
            <div class="card shadow-sm border-success">
                <div class="card-header bg-success text-white fw-bold">Medicamentos de Mayor Demanda (Top 10)</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="dgvTopMedicamentos" runat="server" CssClass="table table-hover table-striped mb-0 align-middle" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="Id_medicamento" HeaderText="ID" />
                                <asp:BoundField DataField="Nombre_medicamento" HeaderText="Medicamento" />
                                <asp:BoundField DataField="Laboratorio" HeaderText="Laboratorio" />
                                <asp:BoundField DataField="Principio_activo" HeaderText="Principio Activo" />
                                <asp:BoundField DataField="Cantidad_total_vendida" HeaderText="Cantidad Vendida" />
                                <asp:BoundField DataField="Facturacion_total" HeaderText="Total Recaudado" DataFormatString="{0:C2}" HtmlEncode="false" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
