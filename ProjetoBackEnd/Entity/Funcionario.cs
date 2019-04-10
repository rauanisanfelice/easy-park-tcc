using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Funcionario : Pessoa //herda de pessoa
    {
        //declara as propriedades
        public int ID_Funcionario { get; set; }
        public int Fiscal { get; set; }
        public int Setor { get; set; }
        public bool Busca { get; set; }
        public int Status_fun { get; set; }

        //contrutor
        public Funcionario() { }

        public Funcionario(int id_funcionario, int fiscal, int setor, bool busca, int status_fun, int id, string nome, string cidade, string senha, string rg) 
            : base (id, nome, cidade, senha, rg)
        {
            ID_Funcionario = id_funcionario;
            Fiscal = fiscal;
            Setor = setor;
            Busca = busca;
            Status_fun = status_fun;
        }
        

    }
}
