using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class GraficoData : Conexao
    {
        public GraficoData(string strConexao) : base(strConexao) { }

        // -------------------------------------------------------------------------

        //      OBTER DADOS
        public Grafico ObterArrecadacao(Grafico grafico)
        {
            DateTime hoje = DateTime.Now;
            DateTime minima = DateTime.MinValue;

            DateTime teste = minima.AddHours(1);

            if (grafico.Ano == minima && grafico.Mes == minima)
            {             
                // OK !!!!
                #region NÃO FEZ A PESQUISA
                try
                {
                    Cmd = new SqlCommand();
                    Cmd.Connection = Cnn;

                    int i;
                    string coluna = "", tabela = "";
                    for (i = 0; i <= 3; i ++)
                    {
                        // DECIDE QUAL TABELA BUSCAR O VALOR
                        switch (i)
                        {
                            case 0:
                                coluna = "DATA_PARA";
                                tabela = "paradas";

                                string ano = hoje.Date.Year.ToString();
                                
                                Cmd.Parameters.AddWithValue("@ano", ano);
                                Cmd.Parameters.AddWithValue("@coluna", coluna);

                                break;
                            case 1:
                                coluna = "DATA_NOT";
                                tabela = "notificacoes";
                                break;
                            case 2:
                                coluna = "DATA_COMP";
                                tabela = "compras";
                                break;
                            case 3:
                                string hojeano = hoje.Year.ToString();
                                Cmd.Parameters.AddWithValue("@an", hojeano);
                                break;
                        }

                        // VERIFICA SE FAZ A SOMATORIA OU ARMAZENA OS DADOS
                        if( i == 3)
                        {
                            Cmd.CommandText = @"select SUM(VALOR) as SOMA from compras where convert(varchar(4), DATA_COMP, 111) = @an";

                            Dr = Cmd.ExecuteReader();
                        }
                        else
                       {                  
                           string anoteste = tabela + " where convert(varchar(4), "+ coluna +", 111) = @ano";

                            Cmd.CommandText = @"select COUNT(" + coluna + ") AS DATA from " + anoteste;

                            Dr = Cmd.ExecuteReader();
                        }                   

                        // PROCESSO DE SALVAR OS DADOS
                        if (Dr.Read())
                        {
                            switch (i)
                            {
                                case 0:
                                    grafico.Q_Parada = Dr.GetInt32(0);
                                    break;
                                case 1:
                                    grafico.Q_Notificacao = Dr.GetInt32(0);
                                    break;
                                case 2:
                                    grafico.Q_Compra = Dr.GetInt32(0);
                                    break;
                                case 3:
                                    grafico.T_Arrecadado = Dr.GetDecimal(0);
                                    break;
                            }
                        }
                        Dr.Close();
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
                #endregion
            }
            else if (grafico.Ano != minima && grafico.Mes != minima && grafico.Mes.Hour != teste.Hour)
            {
                // OK !!
                #region RESULTADOS DO MES ESCOLHIDO DE QUAL ANO
                try
                {
                    Cmd = new SqlCommand();
                    Cmd.Connection = Cnn;

                    int mes = grafico.Mes.Month;
                    string ano = grafico.Ano.Year.ToString();

                    int i;
                    string coluna = "", tabela = "";
                    for (i = 0; i <= 3; i++)
                    {
                        // DECIDE QUAL TABELA BUSCAR O VALOR
                        switch (i)
                        {
                            case 0:
                                coluna = "DATA_PARA";
                                tabela = "paradas";
                                break;
                            case 1:
                                coluna = "DATA_NOT";
                                tabela = "notificacoes";
                                break;
                            case 2:
                                coluna = "DATA_COMP";
                                tabela = "compras";
                                break;
                            case 3:
                                break;
                        }

                        // VERIFICA SE FAZ A SOMATORIA OU ARMAZENA OS DADOS
                        if (i == 3)
                        {
                            Cmd.CommandText = "select SUM(VALOR) as SOMA from " + tabela + " where convert(varchar(4), " + coluna + ", 111) = " + ano + " and Datepart(MONTH, " + coluna + ")  = " + mes;

                            Dr = Cmd.ExecuteReader();
                        }
                        else
                        {
                            Cmd.CommandText = "select COUNT(" + coluna + ") AS MES from " + tabela + " where convert(varchar(4), " + coluna + ", 111) = " + ano + " and Datepart(MONTH, " + coluna + ")  = " + mes;
                                
                            Dr = Cmd.ExecuteReader();                           
                        }

                        // PROCESSO DE SALVAR OS DADOS
                        if (Dr.Read())
                        {
                            switch (i)
                            {
                                case 0:
                                    grafico.Q_Parada = Dr.GetInt32(0);
                                    break;
                                case 1:
                                    grafico.Q_Notificacao = Dr.GetInt32(0);
                                    break;
                                case 2:
                                    grafico.Q_Compra = Dr.GetInt32(0);
                                    break;
                                case 3:
                                    if (Dr.IsDBNull(0))
                                    {
                                        grafico.T_Arrecadado = 0;
                                    }
                                    else
                                    {
                                        grafico.T_Arrecadado = Dr.GetDecimal(0);
                                    }
                                    
                                    break;
                            }
                        }
                        Dr.Close();
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
                #endregion
            }
            else if (grafico.Ano == minima.AddHours(1) && grafico.Mes == minima)
            {
                // OK !!
                #region RESUMO DE TODOS OS ANOS
                try
                {
                    Cmd = new SqlCommand();
                    Cmd.Connection = Cnn;

                    int i;
                    string coluna = "", tabela = "";
                    for (i = 0; i <= 3; i++)
                    {
                        // DECIDE QUAL TABELA BUSCAR O VALOR
                        switch (i)
                        {
                            case 0:
                                coluna = "DATA_PARA";
                                tabela = "paradas";
                                break;
                            case 1:
                                coluna = "DATA_NOT";
                                tabela = "notificacoes";
                                break;
                            case 2:
                                coluna = "DATA_COMP";
                                tabela = "compras";
                                break;
                            case 3:
                                break;
                        }

                        // VERIFICA SE FAZ A SOMATORIA OU ARMAZENA OS DADOS
                        if (i == 3)
                        {
                            Cmd.CommandText = @"select SUM(VALOR) as SOMA from compras";

                            Dr = Cmd.ExecuteReader();
                        }
                        else
                        {
                            Cmd.CommandText = @"select COUNT(" + coluna + ") AS DATA from " + tabela;

                            Dr = Cmd.ExecuteReader();
                        }

                        // PROCESSO DE SALVAR OS DADOS
                        if (Dr.Read())
                        {
                            switch (i)
                            {
                                case 0:
                                    grafico.Q_Parada = Dr.GetInt32(0);
                                    break;
                                case 1:
                                    grafico.Q_Notificacao = Dr.GetInt32(0);
                                    break;
                                case 2:
                                    grafico.Q_Compra = Dr.GetInt32(0);
                                    break;
                                case 3:
                                    grafico.T_Arrecadado = Dr.GetDecimal(0);
                                    break;
                            }
                        }
                        Dr.Close();
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
                #endregion
            }
            else if (grafico.Ano.Year != teste.Year)
            {
                #region RESULTADOS DO RESUMO DE UM ANO
                try
                {
                    Cmd = new SqlCommand();
                    Cmd.Connection = Cnn;

                    int mes = grafico.Mes.Month;
                    string ano = grafico.Ano.Year.ToString();

                    int i;
                    string coluna = "", tabela = "";
                    for (i = 0; i <= 3; i++)
                    {
                        // DECIDE QUAL TABELA BUSCAR O VALOR
                        switch (i)
                        {
                            case 0:
                                coluna = "DATA_PARA";
                                tabela = "paradas";
                                break;
                            case 1:
                                coluna = "DATA_NOT";
                                tabela = "notificacoes";
                                break;
                            case 2:
                                coluna = "DATA_COMP";
                                tabela = "compras";
                                break;
                            case 3:
                                break;
                        }

                        // VERIFICA SE FAZ A SOMATORIA OU ARMAZENA OS DADOS
                        if (i == 3)
                        {
                            Cmd.CommandText = "select SUM(VALOR) as SOMA from " + tabela + " where convert(varchar(4), " + coluna + ", 111) = " + ano;

                            Dr = Cmd.ExecuteReader();
                        }
                        else
                        {
                            Cmd.CommandText = "select COUNT(" + coluna + ") AS MES from " + tabela + " where convert(varchar(4), " + coluna + ", 111) = " + ano;

                            Dr = Cmd.ExecuteReader();
                        }

                        // PROCESSO DE SALVAR OS DADOS
                        while (Dr.Read())
                        {
                            switch (i)
                            {
                                case 0:
                                    grafico.Q_Parada = Dr.GetInt32(0);
                                    break;
                                case 1:
                                    grafico.Q_Notificacao = Dr.GetInt32(0);
                                    break;
                                case 2:
                                    grafico.Q_Compra = Dr.GetInt32(0);
                                    break;
                                case 3:
                                    grafico.T_Arrecadado = Dr.GetDecimal(0);
                                    break;
                            }
                        }
                        Dr.Close();
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
                #endregion
            }

            return grafico;
        }

        // -------------------------------------------------------------------------

        //      LISTA FUNCIONARIO
        public List<Grafico> ListaAnosGrafico()
        {
            List<Grafico> anos = null;

            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select DATA_PARA from paradas order by DATA_PARA";

                Dr = Cmd.ExecuteReader();

                anos = new List<Grafico>();

                DateTime ultimoano = DateTime.MinValue;

                while (Dr.Read())
                {
                    Grafico grafico = new Grafico();
                   
                    grafico.ValidacaoAno = Dr.GetDateTime(0);

                    if(grafico.ValidacaoAno.Year != ultimoano.Year)
                    {
                        ultimoano = grafico.ValidacaoAno;
                        anos.Add(grafico);
                    }  
                }
            }
            catch { }
            return anos;
        }     
    }
}
