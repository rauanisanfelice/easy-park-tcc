using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;
using System.Configuration;

namespace ProjetoFrontEnd.PagFuncionario
{
    public partial class Confirmacao : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Pessoa pessoa = Session["pessoapes"] as Pessoa;
            Veiculo veiculo = Session["veiculopes"] as Veiculo;
            Parada parada = Session["ultimaparada"] as Parada;
            Funcionario funcionario = Session["func"] as Funcionario;

            if (funcionario == null)
            {
            }
            else
            {
                lblnome.Text = pessoa.Nome;
                lblcidade.Text = pessoa.Cidade;
                lblrg.Text = pessoa.Rg;
                lblplaca.Text = veiculo.Placa;
                if (parada == null)
                {
                    lbldata.Text = "Este veiculo não possui parada.";
                    lblhora.Visible = false;
                }
                else
                {
                    lbldata.Text = parada.DATA_PARA.ToShortDateString();
                    lblhora.Text = parada.DATA_PARA.ToShortTimeString();

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
                    horafinal = parada.DATA_PARA.AddHours(horas).AddMinutes(minutos);
                    lblfinal.Text = horafinal.ToShortTimeString();
                }
            }
        }

        protected void btnconfirmar_Click(object sender, EventArgs e)
        {
            Parada par = Session["ultimaparada"] as Parada;
            Funcionario fun = Session["func"] as Funcionario;
            Notificacao notifica = Session["notifica"] as Notificacao;
            Pesquisa pesquisa = Session["pesquisa"] as Pesquisa;
            Pessoa pessoa = Session["pessoapes"] as Pessoa;

            PesquisaModel pemodel = new PesquisaModel(strConexao);

            Notificacao notificacao = new Notificacao();
            Parada parada = new Parada();

            DateTime agora = DateTime.Now;

            NotificacaoModel nomodel = new NotificacaoModel(strConexao);

            notificacao.Funcionarios = fun;
            notificacao.Paradas = par;
            notificacao.Pessoas = pessoa;
            notificacao.Data = agora;
            notificacao.Descricao = notifica.Descricao;
            notifica.Msglida = false;

            // INSERE NOTIFICAÇÃO
            bool validacao = nomodel.InserirNotificacao(notificacao);

            //MUDA STATUS DA PESQUISA
            pesquisa.Status_pes = 1;
            pemodel.EditarPesquisa(pesquisa);

            // limpa as sessões
            Session.Remove("pessoapes");
            Session.Remove("veiculopes");
            Session.Remove("ultimaparada");

            int msg = 0;
            if (validacao == true)
            {
                // Deu certo. Adicionou com sucesso a notificação
            }
            else
            {
                // ERRO. nâo addicionou
                msg = 1;
            }

            Response.Redirect("BuscaPlaca.aspx?msg" + msg);

            // LEGENDA PARA AS DESCRIÇOES DAS NOTIFICAÇOES 
            // 1 - O USUARIO NÃO POSSUE CADASTRO
            // 2 - O HORARIO DA PARADA JA TERMINOU
            // 3 - O HORARIO DA PARADA ACABOU DE TERMINAR
            // 4 - O VEICULO NAO REALIZOU A PARADA NO DIA DA PESQUISA
            // 5 - O USUARIO NÃO REALIZOU A PARADA
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}