using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class CompraData : Conexao
    {
        public CompraData(string strConexao) : base(strConexao) { }

        // -------------------------------------------------------------------------

        //      INSERIR COMPRA
        public void InserirCompra(Compra compra)
        {
            //declara a transacao 
            SqlTransaction tran = null;

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
                Cmd.CommandText = "insert into compras values (@login, @valor, @data, @hora)"; //comando que deve executar no banco
                                                                //valor, descrição, data, hora, token

                int idlogin = compra.Logins.Id_login;

                Cmd.Parameters.AddWithValue("@login", idlogin);
                Cmd.Parameters.AddWithValue("@valor", compra.Valor); //@valor vai armazenar oque o usuario digitar na tela
                Cmd.Parameters.AddWithValue("@data", compra.Data_comp);
                Cmd.Parameters.AddWithValue("@hora", compra.Hora);


                //envia para o banco
                Cmd.ExecuteNonQuery();

                //commit na transacao
                tran.Commit();


            }
            catch (Exception e)
            {
                tran.Rollback();
                Console.WriteLine(e.Message);
            }
        }

        // -------------------------------------------------------------------------

        //      OBTER COMPRA
        public Compra ObterCompra(int id)
        {
            Compra compra = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from compras where ID_COMPRA = @id";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    compra = new Compra();

                    compra.Valor = Dr.GetDecimal(2);
                    compra.Data_comp = Dr.GetDateTime(3);
                    compra.Hora = Dr.GetDateTime(4);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return compra;
        }


        // -------------------------------------------------------------------------

        //      OBTER arrecadações
        public Compra Obteraarrecadacao()
        {
            Compra compra = null;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"SELECT SUM(VALOR) FROM compras";

                Dr = Cmd.ExecuteReader();

                while (Dr.Read())
                {
                    compra = new Compra();
                    compra.Valor = Dr.GetDecimal(0);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return compra;
        }

        // -------------------------------------------------------------------------

        //      LISTA COMPRA
        public List<Compra> ListaCompra(int id)
        {
            List<Compra> lista = new List<Compra>();

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from compras where LOGIN_ID = @id order by DATA_COMP desc";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                Compra compra;

                while (Dr.Read())
                {
                    compra = new Compra();
                    compra.Id = Dr.GetInt32(0);
                    compra.Valor = Dr.GetDecimal(2);
                    compra.Data_comp = Dr.GetDateTime(3);
                    compra.Hora = Dr.GetDateTime(4);

                    lista.Add(compra);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return lista;
        }

        // -------------------------------------------------------------------------

        //      LISTA DE PESQUISA COMPRAS
        public List<Compra> PesquisaCompra(string pesquisadata, int id)
        {
            List<Compra> lista = new List<Compra>();

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;

                String sql = "select * from compras where convert(varchar(10), DATA_COMP , 103) = @data and LOGIN_ID = @id order by DATA_COMP desc";  // pesquisa somente pela DATA

                Cmd.Parameters.AddWithValue("@data", pesquisadata);
                Cmd.Parameters.AddWithValue("@id", id);

                Cmd.CommandText = sql;

                Dr = Cmd.ExecuteReader();
                Compra compra;

                while (Dr.Read())
                {
                    compra = new Compra();
                    compra.Valor        = Dr.GetDecimal(2);
                    compra.Data_comp    = Dr.GetDateTime(3);
                    compra.Hora         = Dr.GetDateTime(4);
                    lista.Add(compra);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return lista;
        }

    }
}
