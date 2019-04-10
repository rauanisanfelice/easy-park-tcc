using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Compra
    {
        //propriedades
        public Login Logins { get; set; }
        public int Id { get; set; }
        public decimal Valor { get; set; }
        public DateTime Data_comp { get; set; }
        public DateTime Hora { get; set; }


        public Compra() { }

        public Compra(Login logins, int id, decimal valor, DateTime data_comp, DateTime hora)
        {
            Logins = logins; 
            Id = id;
            Valor = valor;
            Data_comp = data_comp;
            Hora = hora;
        }

    }
}
