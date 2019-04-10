using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class NotificacaoData : Conexao
    {
        public NotificacaoData(string strConexao) : base(strConexao) { }

        // -------------------------------------------------------------------------

        //      INSERIR NOTIFICACAO                     OK
        public bool InserirNotificacao(Notificacao notificacao)
        {
            //declara a transacao 
            SqlTransaction tran = null;

            bool ok = false;

            try
            {
                //abrir a conexao com o BD
                //AbrirConexao();
                //inicia a transacao
                tran = Cnn.BeginTransaction();
                //tran = Cnn.BeginTransaction();
                //intancia o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //comando sql
                Cmd.CommandText = "insert into notificacoes values (@id_parada, @id_funcionario, @pessoa, @datahora, @descricao, @confir)"; //comando que deve executar no banco

                if(notificacao.Paradas == null)
                {
                    Cmd.Parameters.AddWithValue("@id_parada", Convert.DBNull); 
                }
                else
                {
                    Cmd.Parameters.AddWithValue("@id_parada", notificacao.Paradas.ID_PARADA); 
                }
                
                Cmd.Parameters.AddWithValue("@id_funcionario", notificacao.Funcionarios.ID_Funcionario);
                Cmd.Parameters.AddWithValue("@pessoa", notificacao.Pessoas.Id);
                Cmd.Parameters.AddWithValue("@datahora", notificacao.Data);
                Cmd.Parameters.AddWithValue("@descricao", notificacao.Descricao);
                Cmd.Parameters.AddWithValue("@confir", notificacao.Msglida);

                //envia para o banco
                Cmd.ExecuteNonQuery();

                //commit na transacao
                tran.Commit();
                return ok = true;
            }
            catch (Exception e)
            {
                tran.Rollback();
                Console.WriteLine(e.Message);
            }
            return ok;
        }

        // -------------------------------------------------------------------------

        //      OBTER NOTIFICAÇÃO PELO ID DA PARADA     OK
        public Notificacao ObterNoticacao(int id)
        {
            Notificacao notificacao = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from notificacoes where ID_NOTICACAO = @id";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    notificacao = new Notificacao();
                    Parada parada = new Parada();
                    Pessoa pessoa = new Pessoa();
                    Funcionario funcionario = new Funcionario();

                    int? testee = null;

                    if (Dr.IsDBNull(1))
                    {
                        parada.ID_PARADA = testee.GetValueOrDefault();
                    }
                    else
                    {
                        parada.ID_PARADA = Dr.GetInt32(1);
                    }
                    funcionario.ID_Funcionario = Dr.GetInt32(2);
                    pessoa.Id = Dr.GetInt32(3);
                    notificacao.Pessoas = pessoa;
                    notificacao.Data = Dr.GetDateTime(4);
                    notificacao.Descricao = Dr.GetInt32(5);
             
                    notificacao.Paradas = parada;
                    notificacao.Funcionarios = funcionario;

                    // validação da msg lida ou nao
                    int teste;
                    teste = Dr.GetInt32(5);
                    if(teste == 1)
                    {
                        notificacao.Msglida = true;
                        //msg lida
                    }
                    else
                    {
                        notificacao.Msglida = false;
                        // nao lido
                    }

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return notificacao;
        }


        //      OBTER A ULTIMA NOTIFICACAO  ------------ SEM USO !!!!!!!!!!!!!!!!!!!!
        public Notificacao ObterUltimaNotificacao(int id)
        {
            Notificacao notificacao = new Notificacao();
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;

                //comando para busca ultima notificacao
                Cmd.CommandText = @"select top 1 ID_NOTICACAO,PARADA_ID, FUNCIONARIO_ID, PESSOA_ID,DATA_NOT,DESCRICAO,CONFLEITURA 
                                    from 
	                                    notificacoes 
                                    where 
	                                    PESSOA_ID = @id 
                                    order by DATA_NOT desc";

                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@id", id);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    notificacao = new Notificacao();

                    Funcionario funcionario = new Funcionario();
                    Parada parada = new Parada();

                    notificacao.ID_notificacao = Dr.GetInt32(0);
                    //parada
                    int? testee = null;

                    if (Dr.IsDBNull(1))
                    {
                        parada.ID_PARADA = testee.GetValueOrDefault();
                        notificacao.Paradas = parada;
                    }
                    else
                    {
                        parada.ID_PARADA = Dr.GetInt32(1);
                        notificacao.Paradas = parada;
                    }
                    notificacao.Data = Dr.GetDateTime(1);
                    notificacao.Descricao = Dr.GetInt32(2);

                    parada.ID_PARADA = Dr.GetInt32(4);
                    funcionario.ID_Funcionario = Dr.GetInt32(5);

                    notificacao.Paradas = parada;
                    notificacao.Funcionarios = funcionario;

                    // validação da msg lida ou nao
                    int teste;
                    teste = Dr.GetInt32(3);
                    if (teste == 1)
                    {
                        notificacao.Msglida = true;
                        //msg lida
                    }
                    else
                    {
                        notificacao.Msglida = false;
                        // nao lido
                    }

                }
                else
                {
                    notificacao = null;
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return notificacao;
        }

        // -------------------------------------------------------------------------

        //      ATUALIZAR CONFIRMAÇÃO DE LEITURA
        public bool AtualizarConf(Notificacao notificacao)
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
                Cmd.CommandText = @"update notificacoes set CONFLEITURA = @conf where ID_NOTICACAO = @id";

                int msg;
                if(notificacao.Msglida == true)
                {
                    //msg lida
                    msg = 1;
                }
                else
                {
                    //msg NAO lida
                    msg = 0;
                }

                //atribui valor a variavel
                Cmd.Parameters.AddWithValue("@conf", msg);
                Cmd.Parameters.AddWithValue("@id", notificacao.ID_notificacao);

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

        //      LISTA NOTIFICAÇÃO                       OK
        public List<Notificacao> ListaNotificacao(int id)
        {
            List<Notificacao> lista = new List<Notificacao>();

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select ID_NOTICACAO, DATA_NOT, CONFLEITURA 
                                        from 
	                                        pessoas p, 
	                                        notificacoes n 
                                        where 
	                                        p.ID = @id and 
	                                        n.PESSOA_ID = @id and 
	                                        p.ID = n.PESSOA_ID
                                        order by data_not desc";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                Notificacao notificacao;

                while (Dr.Read())
                {
                    notificacao = new Notificacao();

                    notificacao.ID_notificacao = Dr.GetInt32(0);
                    notificacao.Data = Dr.GetDateTime(1);

                    //validaçao msg lida ou nao
                    int teste = Dr.GetInt32(2);
                    
                    if(teste == 1)
                    {
                        notificacao.Msglida = true;
                    }
                    else
                    {
                        notificacao.Msglida = false;
                    }                 
                    lista.Add(notificacao);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return lista;
        }


        // -------------------------------------------------------------------------

        //      CONTAR NOTIFICACOES DO FUNCIONARIO

        public int SomaNotificacao(int id)
        {
            List<Parada> lista = null;
            int somapesquisa = 0;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select COUNT(ID) TOTALNOTIFICACAO 
                                        from 
	                                        pessoas p, 
	                                        funcionarios f, 
	                                        pesquisas pe 
                                        where 
	                                        p.ID = @id and 
	                                        f.PESSOA_ID = p.ID and 
	                                        f.ID_FUNCIONARIO = pe.FUNCIONARIO_ID and
	                                        pe.STATUS_PES = 1";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                lista = new List<Parada>();

                if (Dr.Read())
                {
                    somapesquisa = Dr.GetInt32(0);
                }
            }
            catch { }
            return somapesquisa;
        }

    }
}
