using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class LoginData : PessoaData
    {
        public LoginData(string strConexao) : base(strConexao) { }

        // -------------------------------------------------------------------------

        //      OBTER LOGIN DADOS DO LOGIN
        public Login ObterLogin(int id)
        {
            Login login = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, logins l where p.ID = l.PESSOA_ID and l.PESSOA_ID = @id";

                Cmd.Parameters.AddWithValue("@id", id);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    //instancia o objeto cliente
                    login = new Login();

                    login.Id = Dr.GetInt32(0);
                    login.Nome = Dr.GetString(1);
                    login.Rg = Dr.GetString(2);
                    login.Cidade = Dr.GetString(3);
                    login.Id_login = Dr.GetInt32(5);
                    login.Email = Dr.GetString(6);
                    login.Saldo = Dr.GetDecimal(8);
                    login.Confirmacao = Dr.GetInt32(7);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return login;
        }                   //      OK

        // -------------------------------------------------------------------------

        //      OBTER LOGIN DADOS PARA REALIZAR LOGIN
        public Login ObterLogin(string email, string senha)
        {
            Login login = null;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, logins l where p.ID = l.PESSOA_ID and l.EMAIL = @email and p.SENHA = @senha";

                Cmd.Parameters.AddWithValue("@email", email);
                Cmd.Parameters.AddWithValue("@senha", senha);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    //instancia o objeto cliente
                    login = new Login();
                    login.Id = Dr.GetInt32(0);
                    login.Nome = Dr.GetString(1);
                    login.Rg = Dr.GetString(2);
                    login.Cidade = Dr.GetString(3);
                    login.Id_login = Dr.GetInt32(5);
                    login.Email = Dr.GetString(6);
                    login.Confirmacao = Dr.GetInt32(7);
                    login.Saldo = Dr.GetDecimal(8);
                    
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return login;
        }                   //      OK


        // -------------------------------------------------------------------------

        //      ATUALIZAR SALDO
        public bool AtualizarSaldo(Login login)
        {
            //objeto conexao
            //Connection conexao = new Connection();
            //declara a transacao
            SqlTransaction tran = null;

            //variavel para o retorno
            bool ok = false;

            try
            {
                //abrir a conexao
                //AbrirConexao();
                //inicar a transacao
                tran = Cnn.BeginTransaction();
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //comando sql
                Cmd.CommandText = @"update logins set SALDO = @saldo where PESSOA_ID = @id";
                
                //atribui valor a variavel
                Cmd.Parameters.AddWithValue("@saldo", login.Saldo);
                Cmd.Parameters.AddWithValue("@id", login.Id);

                Cmd.ExecuteNonQuery();
                //encerra a transacao
                tran.Commit();

                //altera o retorno
                ok = true;
            }
            catch { }
            return ok;
        }

        // -------------------------------------------------------------------------

        //      MUDA O STATUS DA CONFIRMAÇÃO DO E-MAIL DO USUÁRIO
        public bool AtualizarConf(int id)
        {
            //objeto conexao
            //Connection conexao = new Connection();
            //declara a transacao
            SqlTransaction tran = null;

            //variavel para o retorno
            bool ok = false;

            try
            {
                //abrir a conexao
                //AbrirConexao();
                //inicar a transacao
                tran = Cnn.BeginTransaction();
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //comando sql
                Cmd.CommandText = @"update logins set CONFIRMACAO = " + 1 + " where PESSOA_ID = @id";

                //atribui valor a variavel
                Cmd.Parameters.AddWithValue("@id", id);

                Cmd.ExecuteNonQuery();
                //encerra a transacao
                tran.Commit();

                //altera o retorno
                ok = true;
            }
            catch { }
            return ok;
        }

        // -------------------------------------------------------------------------

        //      VERIFICA E-MAIL SE JA EXISTE
        public bool VerificaEmail(string email)
        {
            //objeto conexao
            //Connection conexao = new Connection();
            //declara a transacao
            SqlTransaction tran = null;

            //variavel para o retorno
            bool ok = false;

            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //comando sql
                Cmd.CommandText = @"select EMAIL from logins where email = @email";

                //atribui valor a variavel
                Cmd.Parameters.AddWithValue("@email", email);

                Dr = Cmd.ExecuteReader();

                if(Dr.Read())
                {                    
                    string emailvalidacao = Dr.GetString(0);

                    if(emailvalidacao != null)
                    {
                        ok = true;
                    }
                    else
                    {
                        ok = false;
                    }
                }

                //encerra a transacao
            }
            catch { }
            return ok;
        }


    }
}
