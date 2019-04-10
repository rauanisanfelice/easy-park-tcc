using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class ParadaData : Conexao
    {
        public ParadaData(string strConexao) : base(strConexao) { }

        // -------------------------------------------------------------------------

        //      INSERIR PARADA
        public bool InserirParadas(Parada paradas)
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
                Cmd.CommandText = "insert into paradas values (@id_veiculo, @data_para, @qtd_hora)"; //comando que deve executar no banco
                //valor, descrição, data, hora, token

                Cmd.Parameters.AddWithValue("@id_veiculo", paradas.ID_VEICULO); //@hora_para vai armazenar oque o usuario digitar na tela
                Cmd.Parameters.AddWithValue("@data_para", paradas.DATA_PARA);
                Cmd.Parameters.AddWithValue("@qtd_hora",  paradas.QTD_HORA);

                //envia para o banco
                Cmd.ExecuteNonQuery();

                //commit na transacao
                tran.Commit();
                ok = true;
            }
            catch (Exception e)
            {
                tran.Rollback();
                Console.WriteLine(e.Message);
            }
            return ok;
        }


        // -------------------------------------------------------------------------

        //      OBTER PARADA PELO ID DA PARADA
        public Parada ObteridParada(int id)
        {
            Parada parada = null;
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;

                //comando para deletar um cliente
                Cmd.CommandText = @"select * from paradas where ID_PARADA = @idparada";

                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@idparada", id);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    parada = new Parada();
                    parada.ID_VEICULO = Dr.GetInt32(1);
                    parada.DATA_PARA = Dr.GetDateTime(2);
                    parada.QTD_HORA = Dr.GetInt32(3);
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return parada;
        }

        // -------------------------------------------------------------------------

        //      OBTER ULTIMA PARADA 
        public Parada ObterUltimaParada(int id)
        {
            Parada parada = new Parada();
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;

                //comando para busca ultima parada
                Cmd.CommandText = @"select TOP 1 ID_PARADA, ID_VEICULO, DATA_PARA,QTD_HORA 
                                    from pessoas pe, veiculos v, paradas p 
                                    where pe.ID = v.LOGIN_ID and v.ID_VEICULO = p.VEICULO_ID and pe.ID = @id ORDER BY DATA_PARA desc";

                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@id", id);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if(Dr.Read())
                {
                    parada = new Parada();
                    parada.ID_PARADA = Dr.GetInt32(0);
                    parada.ID_VEICULO = Dr.GetInt32(1);
                    parada.DATA_PARA = Dr.GetDateTime(2);
                    parada.QTD_HORA = Dr.GetInt32(3);
                }
                else
                {
                    parada = null;
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return parada;
        }

        // -------------------------------------------------------------------------

        //      OBTER NOTIFICACAO 
        public bool verificaParada(int id)
        {
            bool ok = false;
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;

                //comando para busca ultima parada
                Cmd.CommandText = @"select * from paradas pa, notificacoes n where pa.ID_PARADA = n.PARADA_ID and pa.ID_PARADA = @id";

                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@id", id);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    ok = true;
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return ok;
        }


        // -------------------------------------------------------------------------

        public List<Parada> ListaPesquisa(string pesquisadata, int idveiculo)
        {
            List<Parada> lista = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from paradas where convert(varchar(10), DATA_PARA, 103) =  @DATA and VEICULO_ID = @idveiculo order by DATA_PARA desc";

                //atribui valor para @DATA
                Cmd.Parameters.AddWithValue("@DATA", pesquisadata);
                Cmd.Parameters.AddWithValue("@idveiculo", idveiculo);

                Dr = Cmd.ExecuteReader();

                lista = new List<Parada>();

                while (Dr.Read())
                {
                    Parada parada = new Parada();

                    parada.ID_VEICULO = Dr.GetInt32(1);
                    parada.DATA_PARA = Dr.GetDateTime(2);
                    parada.QTD_HORA = Dr.GetInt32(3);

                    lista.Add(parada);
                }
            }
            catch { }
            return lista;
        }

        // -------------------------------------------------------------------------

        //      BUSCA DAS PARADAS DE UM USUARIO ATRAVES DO ID DE LOGIN DO VEICULO

        public List<Parada> ListaParadaUsuario(int id)
        {
            List<Parada> lista = null;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select ID_PARADA,ID_VEICULO, DATA_PARA, QTD_HORA from 
                                    pessoas p, veiculos v, paradas pa 
                                    where v.LOGIN_ID = p.ID and pa.VEICULO_ID = v.ID_VEICULO and v.LOGIN_ID = @id order by DATA_PARA desc";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                lista = new List<Parada>();

                while (Dr.Read())
                {
                    Parada parada = new Parada();

                    parada.ID_PARADA = Dr.GetInt32(0);
                    parada.ID_VEICULO = Dr.GetInt32(1);
                    parada.DATA_PARA = Dr.GetDateTime(2);
                    parada.QTD_HORA = Dr.GetInt32(3);

                    lista.Add(parada);
                }
            }
            catch { }
            return lista;
        }
    }
}
