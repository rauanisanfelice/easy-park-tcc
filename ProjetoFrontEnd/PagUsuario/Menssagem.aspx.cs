using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;
using System.Configuration;

namespace ProjetoFrontEnd.PagUsuario
{
    public partial class Menssagem : System.Web.UI.Page
    {

        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            if (login == null)
            {

            }
            else
            {
                if (Request.QueryString["ID_notificacao"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["ID_notificacao"].ToString());

                    Parada parada = new Parada();
                    Notificacao notificacao = new Notificacao();
                    Veiculo veiculo = new Veiculo();

                    ParadaModel pamodel = new ParadaModel(strConexao);
                    NotificacaoModel nomodel = new NotificacaoModel(strConexao);
                    VeiculoModel vmodel = new VeiculoModel(strConexao);

                    // OBTER DADOS
                    notificacao = nomodel.ObterNoticacao(id);
                    parada = pamodel.ObteridParada(notificacao.Paradas.ID_PARADA);
                    if (parada != null)
                    {
                        veiculo = vmodel.ObteridVeiculo(parada.ID_VEICULO);
                    }


                    // MOSTRAR DADOS DA NOTIFICAÇÃO
                    lbldata.Text = notificacao.Data.ToShortDateString();
                    lblhora.Text = notificacao.Data.ToShortTimeString();

                    // LEGENDA PARA AS DESCRIÇOES DAS NOTIFICAÇOES 
                    // 1 - O USUARIO NÃO POSSUE CADASTRO
                    // 2 - O HORARIO DA PARADA JA TERMINOU
                    // 3 - O HORARIO DA PARADA ACABOU DE TERMINAR
                    // 4 - O VEICULO NAO REALIZOU A PARADA NO DIA DA PESQUISA
                    // 5 - O USUARIO NÃO REALIZOU A PARADA
                    switch (notificacao.Descricao)
                    {
                        case 1:
                            lbldesc.Text = "ERRO, USUARIO NAO POSSUI CADASTRO!";
                            break;
                        case 2:
                            lbldesc.Text = "Seu veiculo foi notificado por causa que seu horário da parada ja terminou!";
                            break;
                        case 3:
                            lbldesc.Text = "Seu veiculo foi notificado por causa que seu horário da parada ja terminou!";
                            break;
                        case 4:
                            lbldesc.Text = "Seu veiculo foi notificado por causa que não foi realizado uma parada no dia da notificação!";
                            break;
                        case 5:
                            lbldesc.Text = "Seu veiculo foi notificado por causa que não foi realizado uma parada!";
                            break;
                    }

                    if (parada != null)
                    {
                        // MOSTRAR DADOS DA PARADA
                        lblplaca.Text = veiculo.Placa.ToString();
                        lbldatapara.Text = parada.DATA_PARA.ToShortDateString();
                        lblhorapara.Text = parada.DATA_PARA.ToShortTimeString();

                        //mostrar hora final e a quantidade de horas compradas
                        DateTime horafinal = new DateTime();
                        int horas = 0;
                        int minutos = 0;

                        switch (parada.QTD_HORA)
                        {
                            case 1:
                                lblcompra.Text = "1 Hora";
                                horas = 1;
                                minutos = 0;
                                break;
                            case 15:
                                lblcompra.Text = "1 Hora e 30 minutos";
                                horas = 1;
                                minutos = 30;
                                break;
                            case 2:
                                lblcompra.Text = "2 Horas";
                                horas = 2;
                                minutos = 0;
                                break;
                            case 25:
                                lblcompra.Text = "2 Horas e 30 minutos";
                                horas = 2;
                                minutos = 30;
                                break;
                            case 3:
                                lblcompra.Text = "3 Horas";
                                horas = 3;
                                minutos = 0;
                                break;
                        }

                        // HORA QUE TERMINA A PARADA
                        horafinal = parada.DATA_PARA.AddHours(horas).AddMinutes(minutos);
                        lblfinal.Text = horafinal.ToShortTimeString();
                    }
                    else
                    {
                        lblplaca.Text = "Não foi realizada uma parada.";
                    }
                    // ATUALIZA OS DADOS DA NOTIFICAÇÃO
                    notificacao.Msglida = true;
                    notificacao.ID_notificacao = id;
                    nomodel.AtualizarConf(notificacao);
                }
                else
                {

                }
            }
        }

        protected void btnvoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/Notificacoe.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}