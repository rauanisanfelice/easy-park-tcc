using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class FuncionarioData : PessoaData
    {
        public FuncionarioData(string strConexao) : base(strConexao) { }

        //                          OK
        // -------------------------------------------------------------------------

        //      OBTER DADOS DO FUNCIONARIO
        public Funcionario ObterFuncionario(int id)
        {
            Funcionario funcionario = null;
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, funcionarios f where p.id = f.PESSOA_ID and p.ID = @id and STATUS_FUN = 1";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    funcionario = new Funcionario();

                    funcionario.Id = Dr.GetInt32(0);
                    funcionario.Nome = Dr.GetString(1);
                    funcionario.Rg = Dr.GetString(2);
                    funcionario.Cidade = Dr.GetString(3);
                    funcionario.ID_Funcionario = Dr.GetInt32(5);
                    funcionario.Setor = Dr.GetInt32(7);
                    funcionario.Fiscal = Dr.GetInt32(8);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return funcionario;
        }           

        // -------------------------------------------------------------------------

        //      OBTER DADOS DO FISCAL
        public bool ObterFiscal(int fiscal)
        {
            bool ok = false;
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select FISCAL from funcionarios where FISCAL = @fiscal  and STATUS_FUN = 1";

                Cmd.Parameters.AddWithValue("@fiscal", fiscal);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    Funcionario funcionario = new Funcionario();
                    funcionario.Fiscal = Dr.GetInt32(0);

                    if(funcionario.Fiscal == fiscal)
                    {
                        ok = true;
                    }
                    else
                    {
                        ok = false;
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return ok;
        }

        // -------------------------------------------------------------------------

        //      OBTER DADOS PARA EFETUA LOGIN DO FUNCIONARIO
        public Funcionario ObterFuncionario(string fiscal, string senha)
        {
            Funcionario funcionario = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, funcionarios f where f.PESSOA_ID = p.ID and p.SENHA = @senha and f.FISCAL = @fiscal  and STATUS_FUN = 1";

                Cmd.Parameters.AddWithValue("@senha", senha);
                Cmd.Parameters.AddWithValue("@fiscal", fiscal);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    funcionario = new Funcionario();

                    funcionario.Id = Dr.GetInt32(0);
                    funcionario.Nome = Dr.GetString(1);
                    funcionario.Rg = Dr.GetString(2);
                    funcionario.Cidade = Dr.GetString(3);
                    funcionario.ID_Funcionario = Dr.GetInt32(5);
                    funcionario.Setor = Dr.GetInt32(7);
                    funcionario.Fiscal = Dr.GetInt32(8);
                    funcionario.Busca = false;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return funcionario;
        }

        // -------------------------------------------------------------------------

        //      LISTA FUNCIONARIO
        public List<Funcionario> ListaFuncionario()
        {
            List<Funcionario> lista = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, funcionarios f where p.ID = f.PESSOA_ID and f.STATUS_FUN = 1";

                Dr = Cmd.ExecuteReader();

                lista = new List<Funcionario>();


                while (Dr.Read())
                {
                    Funcionario funcionario = new Funcionario();

                    funcionario.Id = Dr.GetInt32(0);
                    funcionario.Nome = Dr.GetString(1);
                    funcionario.Rg = Dr.GetString(2);
                    funcionario.Cidade = Dr.GetString(3);
                    funcionario.ID_Funcionario = Dr.GetInt32(5);
                    funcionario.Setor = Dr.GetInt32(7);
                    funcionario.Fiscal = Dr.GetInt32(8);

                    lista.Add(funcionario);
                }
            }
            catch { }
            return lista;
        }

        // -------------------------------------------------------------------------

        //      LISTA PESQUISA FUNCIONARIO
        public List<Funcionario> ListaBuscaFuncionario(string nome)
        {
            List<Funcionario> lista = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, funcionarios f where p.ID = f.PESSOA_ID and NOME like '" + nome + "%'  and STATUS_FUN = 1";

                Cmd.Parameters.AddWithValue("@nome", nome);

                Dr = Cmd.ExecuteReader();

                lista = new List<Funcionario>();


                while (Dr.Read())
                {
                    Funcionario funcionario = new Funcionario();

                    funcionario.Id = Dr.GetInt32(0);
                    funcionario.Nome = Dr.GetString(1);
                    funcionario.Rg = Dr.GetString(2);
                    funcionario.Cidade = Dr.GetString(3);
                    funcionario.ID_Funcionario = Dr.GetInt32(5);
                    funcionario.Setor = Dr.GetInt32(7);
                    funcionario.Fiscal = Dr.GetInt32(8);

                    lista.Add(funcionario);
                }
            }
            catch { }
            return lista;
        }


        // -------------------------------------------------------------------------

        //      DELETAR FUNCIONARIO
        public bool deletarfuncionario(int id)
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
                Cmd.CommandText = "update funcionarios set STATUS_FUN = 0 where PESSOA_ID = @id"; //comando que deve executar no banco


                //atribui valores para as variaveis
                Cmd.Parameters.AddWithValue("@id", id);

                //executa
                Cmd.ExecuteNonQuery();

                //encerra a transacao
                tran.Commit();
                //altera o retorno
                ok = true;
            }
            catch (Exception e)
            {
                //desfaz a transacao
                tran.Rollback();
                Console.WriteLine(e.Message);
            }
            return ok;
        }

    }
}
