using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class ParadaModel
    {
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public ParadaModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //      INSERIR COMPRA
        public bool InserirParadas(Parada paradas)
        {
            using (ParadaData data = new ParadaData(strConexao))
            {
                return data.InserirParadas(paradas);
            }
        }


        // -------------------------------------------------------------------------

        //      OBTER PARADA pelo ID_parada

        public Parada ObteridParada(int id)
        {
            using (ParadaData data = new ParadaData(strConexao))
            {
                return data.ObteridParada(id);
            }
        }

        // -------------------------------------------------------------------------

        //      OBTER ULTIMA PARADA 

        public Parada ObterUltimaParada(int id)
        {
            using (ParadaData data = new ParadaData(strConexao))
            {
                return data.ObterUltimaParada(id);
            }
        }

        // -------------------------------------------------------------------------

        //      VERIFICAR SE PARADA POSSUI NOTIFICACAO

        public bool verificaParada(int id)
        {
            using (ParadaData data = new ParadaData(strConexao))
            {
                return data.verificaParada(id);
            }
        }

        // -------------------------------------------------------------------------

        //      OBTER DADOS DE PARADA

        public List<Parada> ListaParadaUsuario(int id)
        {
            using (ParadaData data = new ParadaData(strConexao))
            {
                return data.ListaParadaUsuario(id);
            }
        }

        // -------------------------------------------------------------------------

        //      PESQUISAR PARADA PELA DATA

        public List<Parada> ListaPesquisa(string pesquisadata, int idveiculo)
        {
            using (ParadaData data = new ParadaData(strConexao))
            {
                return data.ListaPesquisa(pesquisadata, idveiculo);
            }
        }


    }
}
