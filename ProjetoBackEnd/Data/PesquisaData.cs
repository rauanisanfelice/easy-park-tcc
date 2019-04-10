using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class PesquisaData : Conexao
    {
        public PesquisaData(string strConexao) : base(strConexao) { }

        // -------------------------------------------------------------------------

        //      INSERIR PESQUISA                       
        public void InserirPesquisa(Pesquisa pesquisa)
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
                Cmd.CommandText = @"insert into pesquisas values (@veiculo, @parada, @funcionario, @status);" +
                                    "select @@IDENTITY from pesquisas;";

                Cmd.Parameters.AddWithValue("@veiculo", pesquisa.Id_Veiculo.Id_veiculo);
                if (pesquisa.ID_Parada == null)
                {
                    Cmd.Parameters.AddWithValue("@parada", Convert.DBNull);
                }
                else
                {
                    Cmd.Parameters.AddWithValue("@parada", pesquisa.ID_Parada.ID_PARADA); //@placa vai armazenar oque o usuario digitar na tela
                }

                Cmd.Parameters.AddWithValue("@funcionario", pesquisa.ID_Funcionario.ID_Funcionario);
                Cmd.Parameters.AddWithValue("@status", pesquisa.Status_pes);

                pesquisa.ID_pesquisas = Convert.ToInt32(Cmd.ExecuteScalar());

                //commit na transacao
                tran.Commit();

            }
            catch (Exception e)
            {
                //desfaz a transacao
                tran.Rollback();
                Console.WriteLine(e.Message);
            }
        }

        // -------------------------------------------------------------------------

        //      EDITAR PESQUISA
        public bool EditarPesquisa(Pesquisa pesquisa)
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
                Cmd.CommandText = @"update pesquisas set STATUS_PES = @status WHERE ID_PESQUISA = @idpesquisa";

                //atribui valores para as variaveis
                Cmd.Parameters.AddWithValue("@status", pesquisa.Status_pes);
                Cmd.Parameters.AddWithValue("@idpesquisa", pesquisa.ID_pesquisas);

                //executa
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

        //      CONTAR PESQUISAS DO FUNCIONARIO

        public int SomaPesquisa (int id)
        {
            int somapesquisa = 0;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select COUNT(ID_PESQUISA) PESQUISAS from pesquisas p , funcionarios f, pessoas pe where f.ID_FUNCIONARIO = p.FUNCIONARIO_ID and f.PESSOA_ID = pe.ID and pe.ID = @id";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    somapesquisa = Dr.GetInt32(0);
                }
            }
            catch { }
            return somapesquisa;
        }

        // -------------------------------------------------------------------------

        //      QAUNTIDADES DO STATUS DA PARADA POR FUNCIONARIO

        public int SomaStatus(int id, int status)
        {
            int somastatus = 0;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"Select COUNT(STATUS_PES) TOTAL FROM pesquisas pe, funcionarios f, pessoas p where STATUS_PES = @status and pe.FUNCIONARIO_ID = f.ID_FUNCIONARIO and p.ID = f.PESSOA_ID and p.ID = @id";

                Cmd.Parameters.AddWithValue("@id", id);
                Cmd.Parameters.AddWithValue("@status", status);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    somastatus = Dr.GetInt32(0);
                }
            }
            catch { }
            return somastatus;
        }

    }
}
