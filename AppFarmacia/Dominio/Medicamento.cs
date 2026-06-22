using System;

namespace Dominio
{
    public class Medicamento
    {
        public long IdMedicamento { get; set; }
        public string Nombre { get; set; }
        public string Laboratorio { get; set; }
        public string PrincipioActivo { get; set; }
        public int StockActual { get; set; }
        public int StockMinimo { get; set; }
        public decimal PrecioCosto { get; set; }
        public decimal PrecioVentaSinIva { get; set; }
        public decimal PrecioVentaConIva { get; set; }
        public bool RequiereReceta { get; set; }
    }
}
