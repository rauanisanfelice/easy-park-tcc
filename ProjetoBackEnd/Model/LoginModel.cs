using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class LoginModel
    {

        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public LoginModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------


        //      OBTER LOGIN DADOS DO LOGIN
        public Login ObterLogin(int id)
        {
            using (LoginData data = new LoginData(strConexao))
            {
                return data.ObterLogin(id);
            }
        }

        //      OBTER LOGIN DADOS PARA REALIZAR LOGIN
        public Login ObterLogin(string email, string senha)
       {
           using (LoginData data = new LoginData(strConexao))
           {
               return data.ObterLogin(email, senha);
           }
       }

        //      ATUALIZA O SALDO DO LOGIN
        public bool AtualizarSaldo(Login login)
        {
            using (LoginData data = new LoginData(strConexao))
            {
                return data.AtualizarSaldo(login);
            }
        }

        //      ATUALIZA A CONFIRMAÇÃO DA CONTA
        public bool AtualizarConf(int id)
        {
            using (LoginData data = new LoginData(strConexao))
            {
                return data.AtualizarConf(id);
            }
        }

        //      VERIFICA SE JA EXISTE O E-MAIL NO BANCO
        public bool VerificaEmail(string email)
        {
            using (LoginData data = new LoginData(strConexao))
            {
                return data.VerificaEmail(email);
            }
        }
    }
}
