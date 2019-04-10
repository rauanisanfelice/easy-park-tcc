using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class CompraModel
    {
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public CompraModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //      INSERIR COMPRA
        public void InserirCompra(Compra compra)
        {
            using (CompraData data = new CompraData(strConexao))
            {
                data.InserirCompra(compra);
            }
        }

        //      OBTER COMPRA
        public Compra ObterCompra(int id)
        {
            using (CompraData data = new CompraData(strConexao))
            {
                return data.ObterCompra(id);
            }
        }

        //      OBTER COMPRA
        public Compra Obteraarrecadacao()
        {
            using (CompraData data = new CompraData(strConexao))
            {
                return data.Obteraarrecadacao();
            }
        }

        //      LISTA COMPRA
        public List<Compra> ListaCompra(int id)
        {
            using (CompraData data = new CompraData(strConexao))
            {
                return data.ListaCompra(id);
            }
        }

        //      LISTA DE PESQUISA COMPRAS
        public List<Compra> PesquisaCompra(string pesquisadata, int id)
        {
            using (CompraData data = new CompraData(strConexao))
            {
                return data.PesquisaCompra(pesquisadata, id);
            }
        }
    }
}
