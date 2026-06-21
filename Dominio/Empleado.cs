using System;

namespace Dominio
{
    public class Empleado
    {
        public long IdEmpleado { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public int IdRol { get; set; }
        public string Usuario { get; set; }
        public string ContrasenaHash { get; set; }
    }
}
