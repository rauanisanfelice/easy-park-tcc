using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class PesquisaModel
    {
         //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public PesquisaModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        public void InserirPesquisa(Pesquisa pesquisa)
        {
            using (PesquisaData data = new PesquisaData(strConexao))
            {
                data.InserirPesquisa(pesquisa);
            }
        }

        // -------------------------------------------------------------------------

        public bool EditarPesquisa(Pesquisa pesquisa)
        {
            using (PesquisaData data = new PesquisaData(strConexao))
            {
                return data.EditarPesquisa(pesquisa);
            }
        }

        //      SOMA QUATIDADE DE PESQUISAS POR FUNCIONARIO
        public int SomaPesquisa(int id)
        {
            using (PesquisaData data = new PesquisaData(strConexao))
            {
                return data.SomaPesquisa(id);
            }
        }

        //      SOMA QUATIDADE DE STATUS POR FUNCIONARIO
        public int SomaStatus(int id, int status)
        {
            using (PesquisaData data = new PesquisaData(strConexao))
            {
                return data.SomaStatus(id, status);
            }
        }
    }
}
