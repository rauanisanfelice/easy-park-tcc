using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class VeiculoData : Conexao
    {

        public VeiculoData(string strConexao) : base(strConexao) { }


        // -------------------------------------------------------------------------

        //      INSERIR VEICULO                         
        public void InserirVeiculos(Veiculo veiculo)
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
                Cmd.CommandText = @"insert into veiculos values (@id_login, @placa)";

                Cmd.Parameters.AddWithValue("@id_login", veiculo.Logins.Id);
                Cmd.Parameters.AddWithValue("@placa", veiculo.Placa); //@placa vai armazenar oque o usuario digitar na tela

                //envia para o banco
                Cmd.ExecuteNonQuery();

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

        //      EDITAR VEICULO
        public bool EditarVeiculo(Veiculo veiculo)
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
                Cmd.CommandText = "update veiculos set PLACA = @placa where LOGIN_ID = @login_id"; //comando que deve executar no banco


                //atribui valores para as variaveis
                Cmd.Parameters.AddWithValue("@login_id", veiculo.Logins.Id_login);
                Cmd.Parameters.AddWithValue("@placa", veiculo.Placa);

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


        // -------------------------------------------------------------------------

        //      OBTER VEICULO PELA PLACA
        public Veiculo ObterVeiculo(string placa)
        {
            Veiculo veiculo = null;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from veiculos where PLACA = @placa";

                Cmd.Parameters.AddWithValue("@placa", placa);

                Dr = Cmd.ExecuteReader();

                //erro algum campo vazio
                if (Dr.Read())
                {
                    veiculo = new Veiculo();
                    veiculo.Id_veiculo      = Dr.GetInt32(0);
                    veiculo.Logins.Id_login = Dr.GetInt32(1);
                    veiculo.Placa           = Dr.GetString(2);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return veiculo;
        }

        // -------------------------------------------------------------------------

        //      OBTER VEICULO pelo id da pessoa
        public Veiculo ObterVeiculo(int id)
        {
            Veiculo veiculo = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from veiculos where LOGIN_ID = @id";

                Cmd.Parameters.AddWithValue("@id", id);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    veiculo = new Veiculo();
                    veiculo.Id_veiculo = Dr.GetInt32(0);
                    veiculo.Placa = Dr.GetString(2);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return veiculo;
        }

        // -------------------------------------------------------------------------

        //      OBTER VEICULO pelo id do veiculo 
        public Veiculo ObteridVeiculo(int id)
        {
            Veiculo veiculo = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from veiculos where ID_VEICULO = @idveiculo";

                Cmd.Parameters.AddWithValue("@idveiculo", id);

                Dr = Cmd.ExecuteReader();

                //erro algum campo vazio
                if (Dr.Read())
                {
                    veiculo = new Veiculo();
                    Login login = new Login();
                    login.Id_login = Dr.GetInt32(1);
                    veiculo.Logins = login;
                    veiculo.Placa = Dr.GetString(2);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return veiculo;
        }

        // -------------------------------------------------------------------------

        //      PEGA PLACA DO VEICULO E VERIFICA SE JA REALIZOU PARADA  

        public bool ValidaPlaca(string placa)
        {
            bool ok = false;
            int horas = 0;
            int minutos = 0;

            DateTime horafinal = new DateTime();
            Parada parada = new Parada();

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select top 1 DATA_PARA, QTD_HORA from veiculos v, paradas p where v.ID_VEICULO = p.VEICULO_ID and PLACA = @placa order by DATA_PARA desc";

                Cmd.Parameters.AddWithValue("@placa", placa);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    if (Dr.IsDBNull(0))
                    {
                        // pode retornar zero
                        ok = true;
                    }
                    else
                    {
                        // pega os valores
                        parada.DATA_PARA = Dr.GetDateTime(0);
                        parada.QTD_HORA = Dr.GetInt32(1);


                        switch (parada.QTD_HORA)
                        {
                            case 1:
                                horas = 1;
                                minutos = 0;
                                break;
                            case 15:
                                horas = 1;
                                minutos = 30;
                                break;
                            case 2:
                                horas = 2;
                                minutos = 0;
                                break;
                            case 25:
                                horas = 2;
                                minutos = 30;
                                break;
                            case 3:
                                horas = 3;
                                minutos = 0;
                                break;
                        }

                        // HORA QUE TERMINA A PARADA
                        horafinal = parada.DATA_PARA.AddHours(horas).AddMinutes(minutos);

                        // VALIDAÇÃO DA PARADA E NOTIFICAÇÕES DE INFRAÇÕES
                        DateTime hoje = DateTime.Now;

                        #region VALIDAÇÃO DA PARADA E NOTIFICAÇÕES DE INFRAÇÕES

                        if (parada.DATA_PARA.ToShortDateString() == hoje.ToShortDateString()) // o dia atual É igual AO dia da parada
                        {
                            // COMPARA A HORA DE AGORA COM A HORA INICIAL DA PARADA
                            int resultado = DateTime.Compare(hoje, parada.DATA_PARA);

                            if (resultado < 0)
                            {
                                // PRIMEIRA DATA É MAIS ANTIGA
                                // ERRO!
                                // A DATA DE HJ É MAIS ANTIGA QUE A DATA DA PARADA = IMPOSSIVEL!!
                                ok = true;
                            }
                            else if (resultado == 0)
                            {
                                // DATA IGUAIS
                                ok = false;
                            }
                            else
                            {
                                // PRIMEIRA DATA É MAIS NOVA
                                // DATA DE HOJE É MAIS NOVA QUE A DATA DA PARADA.

                                // COMPARA A HORA DE AGORA COM A HORA FINAL DA PARADA
                                int resultadofinal = DateTime.Compare(horafinal, hoje);

                                if (resultadofinal < 0)
                                {
                                    // PRIMEIRA DATA É MAIS ANTIGA
                                    // HORA FINAL DA PARADA JA PASSOU DA HORA ATUAL
                                    ok = true;
                                }
                                else if (resultadofinal == 0)
                                {
                                    // DATA IGUAIS
                                    // HORARIO DA PARADA ACABOU DE TERMINAR
                                    ok = true;
                                }
                                else
                                {
                                    // PRIMEIRA DATA É MAIS NOVA
                                    //CORRETO
                                    ok = false;
                                }
                            }
                        }
                        else // o dia autal é diferente da parada
                        {
                            ok = true;
                        }
                        #endregion
                    }
                }
                else
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
    }
}
