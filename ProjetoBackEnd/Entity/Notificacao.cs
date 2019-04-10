using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Notificacao
    {
        //propriedades
        public int ID_notificacao { get; set; }
        public Funcionario Funcionarios { get; set; }
        public Parada Paradas { get; set; }
        public Pessoa Pessoas { get; set; }
        public DateTime Data { get; set; }
        public int Descricao { get; set; }
        public bool Msglida { get; set; }

        /*
            CONFLEITURA 1 e 2 
            1 = true LIDO A MSG
            2 = false NÂO LIDO A MSG
        */

        //construtor
        public Notificacao() { }

        public Notificacao(int id_notificacao, Parada paradas, Funcionario funcionarios, Pessoa pessoas, DateTime data, int descricao, bool msglida)
        {
            ID_notificacao = id_notificacao;
            Paradas = paradas;
            Funcionarios = funcionarios;
            Pessoas = pessoas;
            Data = data;
            Descricao = descricao;
            Msglida = msglida;
        }
    }
}
