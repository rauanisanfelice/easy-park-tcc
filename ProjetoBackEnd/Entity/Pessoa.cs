using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Pessoa
    {
        //declaração das propriedades

        public int Id { get; set; }
        public string Nome { get; set; }
        public string Cidade { get; set; }
        public string Senha { get; set; }
        public string Rg { get; set; }


        // TIPO - LEGENDA
        // 1 - ADM
        // 2 - FUNCIONARIO
        // 3 - CLIENTE

        //contrutor
        public Pessoa(int id, string nome, string cidade, string senha, string rg)
        {
            //propriedades recebe o parametro
            Id = id;
            Nome = nome;
            Cidade = cidade;
            Senha = senha;
            Rg = rg;
        }

        public Pessoa() { }
    }
}
