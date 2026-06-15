<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="AppFarmacia.Ventas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12 mb-4">
            <h2 class="fw-bold text-dark border-bottom pb-2">Punto de Venta / Facturación</h2>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white fw-bold">Registrar Operación de Caja</div>
                <div class="card-body">
                    <asp:Panel ID="pnlMensajeExito" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
                        <asp:Label ID="lblMensajeExito" runat="server"></asp:Label>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </asp:Panel>

                    <asp:Panel ID="pnlMensajeError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show" role="alert">
                        <asp:Label ID="lblMensajeError" runat="server"></asp:Label>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </asp:Panel>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Código de Cliente</label>
                            <asp:TextBox ID="txtIdCliente" runat="server" CssClass="form-control" placeholder="Dejar vacío para Consumidor Final"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Código de Vendedor / Cajero (Obligatorio)</label>
                            <asp:TextBox ID="txtIdEmpleado" runat="server" CssClass="form-control" placeholder="Ej: 3"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Código de Medicamento (Obligatorio)</label>
                            <asp:TextBox ID="txtIdMedicamento" runat="server" CssClass="form-control" placeholder="Ej: 1"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Cantidad de Unidades (Obligatorio)</label>
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" placeholder="Ej: 2"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-bold">Precio Unitario Final Cobrado ($ - Obligatorio)</label>
                            <asp:TextBox ID="txtPrecioCobrado" runat="server" CssClass="form-control" placeholder="Ej: 1450.00"></asp:TextBox>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label fw-bold">Observaciones de la Operación</label>
                            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Opcional..."></asp:TextBox>
                        </div>
                        <div class="col-md-12 text-end mt-4">
                            <asp:Button ID="btnVender" runat="server" Text="Facturar y Registrar" CssClass="btn btn-success btn-lg px-5" OnClick="btnVender_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
