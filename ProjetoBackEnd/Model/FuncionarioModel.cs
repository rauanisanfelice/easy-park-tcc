using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class FuncionarioModel
    {  
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public FuncionarioModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //  OBTER DADOS DO FUNCIONARIO

        public Funcionario ObterFuncionario(int id)
        {
            using (FuncionarioData data = new FuncionarioData(strConexao))
            {
                return data.ObterFuncionario(id);
            }
        }

        // -------------------------------------------------------------------------

        //  OBTER DADOS DO FUNCIONARIO

        public bool ObterFiscal(int fiscal)
        {
            using (FuncionarioData data = new FuncionarioData(strConexao))
            {
                return data.ObterFiscal(fiscal);
            }
        }

        //      OBTER DADOS PARA EFETUA LOGIN DO FUNCIONARIO

        public Funcionario ObterFuncionario(string fiscal, string senha)
        {
            using (FuncionarioData data = new FuncionarioData(strConexao))
            {
                return data.ObterFuncionario(fiscal, senha);
            }
        }

        //      LISTA FUNCIONARIO

        public List<Funcionario> ListaFuncionario()
        {
            using (FuncionarioData data = new FuncionarioData(strConexao))
            {
                return data.ListaFuncionario();
            }
        }

        //      PESQUISA DE FUNCIONARIO E LISTAGEM

        public List<Funcionario> ListaBuscaFuncionario(string nome)
        {
            using (FuncionarioData data = new FuncionarioData(strConexao))
            {
                return data.ListaBuscaFuncionario(nome);
            }
        }

        //      DELETA FUNCIONARIO

        public bool DeletarFuncionario(int id)
        {
            using (FuncionarioData data = new FuncionarioData(strConexao))
            {
                return data.deletarfuncionario(id);
            }
        }
    }
}
