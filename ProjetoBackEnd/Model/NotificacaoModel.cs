using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class NotificacaoModel
    {
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public NotificacaoModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //      INSERIR NOTIFICACAO

        public bool InserirNotificacao(Notificacao notificacao)
        {
            using (NotificacaoData data = new NotificacaoData(strConexao))
            {
                return data.InserirNotificacao(notificacao);
            }
        }

        //      OBTER NOTIFICAÇÃO ------------ SEM USO !!!!!!!!!!!!!!!!!!!!

        public Notificacao ObterNoticacao(int id)
        {
            using (NotificacaoData data = new NotificacaoData(strConexao))
            {
                return data.ObterNoticacao(id);
            }
        }

        //      OBTER ULTIMA NOTIFICAÇÃO

        public Notificacao ObterUltimaNotificacao(int id)
        {
            using (NotificacaoData data = new NotificacaoData(strConexao))
            {
                return data.ObterUltimaNotificacao(id);
            }
        }


        //      LISTA NOTIFICAÇÃO

        public List<Notificacao> ListaNotificacao(int id)
        {
            using (NotificacaoData data = new NotificacaoData(strConexao))
            {
                return data.ListaNotificacao(id);
            }
        }


        //      ATUALIZA CONFIRMAÇÃO DE LEITURA

        public bool AtualizarConf(Notificacao notificacao)
        {
            using (NotificacaoData data = new NotificacaoData(strConexao))
            {
                return data.AtualizarConf(notificacao);
            }
        }

        //      SOMATORIA DE NOTIFICAÇÕES DO FUNCIONARIO
        public int SomaNotificacao(int id)
        {
            using (NotificacaoData data = new NotificacaoData(strConexao))
            {
                return data.SomaNotificacao(id);
            }
        }

    }
}
