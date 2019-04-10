using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Veiculo
    {
        //propriedades
        public Login Logins { get; set; }
        public int Id_veiculo { get; set; }
        public string Placa { get; set; }

        //contrutor
        public Veiculo() { }

        public Veiculo(Login logins, int id_veiculo, string placa)
        {
            Logins = logins;
            Id_veiculo = id_veiculo;
            Placa = placa;
        }
    
    }
}
