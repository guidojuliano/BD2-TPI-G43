using System;

namespace Dominio
{
    public class Venta
    {
        public long IdVenta { get; set; }
        public long? IdCliente { get; set; }
        public long IdEmpleado { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
        public string Observaciones { get; set; }
    }
}
