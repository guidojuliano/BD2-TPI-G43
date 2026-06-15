<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Medicamentos.aspx.cs" Inherits="AppFarmacia.Medicamentos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12 mb-4">
            <h2 class="fw-bold text-dark border-bottom pb-2">Buscador del Catálogo de Medicamentos</h2>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="input-group">
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control form-control-lg" placeholder="Buscar por Nombre, Laboratorio o Principio Activo..."></asp:TextBox>
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary btn-lg" OnClick="btnBuscar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white fw-bold">Resultados de Búsqueda</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <asp:GridView ID="dgvMedicamentos" runat="server" CssClass="table table-hover table-striped mb-0 align-middle"></asp:GridView>
                    </div>
                    <asp:Panel ID="pnlVacio" runat="server" Visible="false" CssClass="p-4 text-center text-muted">
                        No se encontraron medicamentos para el término de búsqueda ingresado.
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
