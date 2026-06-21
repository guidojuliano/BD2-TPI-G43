using System;

namespace Dominio
{
    public class Receta
    {
        public long IdReceta { get; set; }
        public long IdVenta { get; set; }
        public long? IdCliente { get; set; }
        public string MedicoPrescriptor { get; set; }
        public DateTime FechaEmision { get; set; }
        public string Observaciones { get; set; }
    }
}
