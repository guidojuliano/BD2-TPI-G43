using System;

namespace Dominio
{
    public class Cliente
    {
        public long IdCliente { get; set; }
        public string DNI { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public int? IdObraSocial { get; set; }
    }
}
