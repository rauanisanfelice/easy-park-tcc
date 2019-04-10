using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Pesquisa
    {
        public int ID_pesquisas { get; set; }
        public Funcionario ID_Funcionario { get; set; }
        public Veiculo Id_Veiculo { get; set; }
        public Parada ID_Parada { get; set; }
        public int Status_pes { get; set; }

        public Pesquisa() { }

        public Pesquisa(int id_pesquisa, Funcionario funcionario, Veiculo veiculo, Parada parada, int status_pes)
        {
            ID_Funcionario = funcionario;
            Id_Veiculo = veiculo;
            ID_Parada = parada;
            Status_pes = status_pes;
        }
     }
}
