<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="AppFarmacia.Compras" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12 mb-4">
            <h2 class="fw-bold text-dark border-bottom pb-2">Gestión de Stock / Abastecimiento</h2>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white fw-bold">Registrar Compra / Ingreso de Stock</div>
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
                            <label class="form-label fw-bold">Proveedor (Obligatorio)</label>
                            <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Medicamento (Buscador Autocomplete - Obligatorio)</label>
                            <asp:TextBox ID="txtMedicamento" runat="server" CssClass="form-control" placeholder="Escriba para buscar por nombre..." list="medicamentosList"></asp:TextBox>
                            <datalist id="medicamentosList">
                                <asp:Repeater ID="rptMedicamentos" runat="server">
                                    <ItemTemplate>
                                        <option value='<%# Eval("Display") %>'></option>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </datalist>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Cantidad de Unidades (Obligatorio)</label>
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" placeholder="Ej: 50"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Precio Unitario de Costo ($ - Obligatorio)</label>
                            <asp:TextBox ID="txtPrecioCosto" runat="server" CssClass="form-control" placeholder="Ej: 550.00"></asp:TextBox>
                        </div>
                        <div class="col-md-12 text-end mt-4">
                            <asp:Button ID="btnIngresar" runat="server" Text="Registrar Ingreso de Stock" CssClass="btn btn-primary btn-lg px-5" OnClick="btnIngresar_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
