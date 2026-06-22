<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AppFarmacia.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="p-5 mb-4 bg-dark text-white rounded-3">
                <div class="container-fluid py-5">
                    <h1 class="display-5 fw-bold">Sistema de Gestión de Farmacia</h1>
                    <p class="col-md-8 fs-4">Plataforma integrada para el control de inventario, facturación de caja y auditoría de recetas de obras sociales en tiempo real.</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-4">
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title fw-bold text-primary">Catálogo</h5>
                    <p class="card-text text-muted">Búsqueda rápida de productos y medicamentos en la base de datos de la farmacia.</p>
                    <a href="Medicamentos.aspx" class="btn btn-outline-primary">Ver Catálogo</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title fw-bold text-success">Punto de Venta</h5>
                    <p class="card-text text-muted">Registro y facturación de operaciones comerciales a clientes mutulizados o consumidor final.</p>
                    <a href="Ventas.aspx" class="btn btn-outline-success">Nueva Venta</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title fw-bold text-danger">Panel de Control</h5>
                    <p class="card-text text-muted">Estadísticas comerciales, alerta de reposición de medicamentos y rendimiento de vendedores.</p>
                    <a href="Reportes.aspx" class="btn btn-outline-danger">Ver Panel</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
