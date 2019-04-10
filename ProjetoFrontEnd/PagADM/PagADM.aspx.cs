using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Model;
using ProjetoBackEnd.Entity;
using System.Configuration;

namespace ProjetoFrontEnd.Paginas
{
    public partial class PagADM : System.Web.UI.Page
    {

        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            GraficoModel gmodel = new GraficoModel(strConexao);
            ParadaModel pamodel = new ParadaModel(strConexao);
            NotificacaoModel nomodel = new NotificacaoModel(strConexao);
            Pessoa administrador = Session["adm"] as Pessoa;

            if (administrador == null)
            {

            }
            else
            {
                CompraModel cmodel = new CompraModel(strConexao);

                Grafico grafico = new Grafico();

                listaanos.DataSource = gmodel.ListaAnosGrafico();
                listaanos.DataBind();

                if (Request.QueryString["qtdpar"] == null && Request.QueryString["qtdinfra"] == null && Request.QueryString["ANO"] == null && Request.QueryString["MES"] == null)
                {
                    //busca do mês atual
                    //primeira vez que entra no site
                    DateTime atual = DateTime.Now;
                    lblAnoSelecionado.Text = atual.Year.ToString();
                    lblMesSelecionado.Text = atual.Month.ToString();
                    Response.Redirect("PagADM.aspx?ANO=" + lblAnoSelecionado.Text + "&MES=" + lblMesSelecionado.Text, true);
                }
                else if (Request.QueryString["qtdpar"] != null && Request.QueryString["MES"] == "-1" && Request.QueryString["qtdpar"] == "-1" && Request.QueryString["qtdinfra"] == "-1")
                {
                    int ano = Convert.ToInt32(Request.QueryString["ANO"].ToString());

                    ano = ano - 1;
                    grafico.Ano = grafico.Ano.AddYears(ano);
                    grafico = gmodel.ObterArrecadacao(grafico);

                    Response.Redirect("PagADM.aspx?qtdpar=" + grafico.Q_Parada + "&qtdinfra=" + grafico.Q_Notificacao + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);

                }
                else if (Request.QueryString["qtdpar"] == null && Request.QueryString["qtdinfra"] == null ||
                    Request.QueryString["qtdpar"] == "-1" && Request.QueryString["qtdinfra"] == "-1" ||
                    Request.QueryString["qtdpar"] == "-1" && Request.QueryString["qtdinfra"] == "-2" &&
                    Request.QueryString["ANO"] != null && Request.QueryString["MES"] != null)
                {
                    int ano = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                    int mes = Convert.ToInt32(Request.QueryString["MES"].ToString());

                    if (Request.QueryString["qtdinfra"] != null)
                    {
                        string infr = Convert.ToString(Request.QueryString["qtdinfra"].ToString());
                        if (infr == "-2")
                        {
                            DateTime resumo2 = DateTime.MinValue;
                            grafico.Mes = resumo2.AddDays(20);
                            ano = ano - 1;
                            grafico.Ano = grafico.Ano.AddYears(ano);

                            grafico = Busca(grafico);

                            Response.Redirect("PagADM.aspx?qtdpar=" + grafico.Q_Parada + "&qtdinfra=" + grafico.Q_Notificacao + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=-2", true);
                        }
                        else
                        {
                            ano = ano - 1;
                            mes = mes - 1;
                            grafico.Ano = grafico.Ano.AddYears(ano);
                            grafico.Mes = grafico.Mes.AddMonths(mes);
                        }
                    }
                    else
                    {
                        ano = ano - 1;
                        mes = mes - 1;
                        grafico.Ano = grafico.Ano.AddYears(ano);
                        grafico.Mes = grafico.Mes.AddMonths(mes);
                    }
                    grafico = Busca(grafico);

                    Response.Redirect("PagADM.aspx?qtdpar=" + grafico.Q_Parada + "&qtdinfra=" + grafico.Q_Notificacao + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);

                }
                else if (Request.QueryString["qtdpar"] != null && 
                    Request.QueryString["qtdinfra"] != null && 
                    Request.QueryString["ANO"] != null && 
                    Request.QueryString["MES"] != null && 
                    Request.QueryString["ANO"] != "-2" && 
                    Request.QueryString["MES"] != "-2")
                {
                    int qtdpara = Convert.ToInt32(Request.QueryString["qtdpar"].ToString());
                    int qtdinf = Convert.ToInt32(Request.QueryString["qtdinfra"].ToString());
                    int ano = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                    string mes = Convert.ToString(Request.QueryString["MES"].ToString());
                    int mes1 = Convert.ToInt32(Request.QueryString["MES"].ToString());


                    ano = ano - 1;
                    if (mes == "-2")
                    {
                        DateTime resumo2 = DateTime.MinValue;
                        grafico.Mes = resumo2.AddDays(20);
                    }
                    else
                    {
                        mes1 = mes1 - 1;
                        grafico.Mes = grafico.Mes.AddMonths(mes1);
                    }
                    grafico.Ano = grafico.Ano.AddYears(ano);
                    grafico = Busca(grafico);
                    MostrarAno(grafico);
                }
                else if (Request.QueryString["ANO"] == "-2" && Request.QueryString["MES"] == "-2")
                {
                    DateTime resumo = DateTime.MinValue.AddHours(1);
                    DateTime resumo2 = DateTime.MinValue;

                    grafico.Ano = resumo;
                    grafico.Mes = resumo2;

                    grafico = Busca(grafico);
                    lblAnoSelecionado.Text = "Resumo de Todos os anos";
                    lbll.Visible = false;
                    lblMesSelecionado.Visible = false;
                    lblll.Visible = false;
                }
                else if (Request.QueryString["ANO"] != null && Request.QueryString["MES"] == "-2")
                {
                    int ano = Convert.ToInt32(Request.QueryString["ANO"].ToString());                    
                    int mes = 1;

                    ano = ano - 1;
                    mes = mes - 1;

                    grafico.Mes = grafico.Mes.AddMonths(mes);
                    grafico.Mes = grafico.Mes.AddHours(5);
                    grafico.Ano = grafico.Ano.AddYears(ano);

                    grafico = Busca(grafico);
                    MostrarAno(grafico);
                }
            }
        }

        protected void resumo_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();

            DateTime resumo = DateTime.MinValue.AddHours(1);
            DateTime resumo2 = DateTime.MinValue;

            grafico.Ano = resumo;
            grafico.Mes = resumo2;

            grafico = Busca(grafico);

            Response.Redirect("PagADM.aspx?qtdpar=" + grafico.Q_Parada + "&qtdinfra=" + grafico.Q_Notificacao + "&ANO=-2&MES=-2", true);
        }
        // BOTOES DOS ANOS

        #region ONCLICK BOTOES MESES
        protected void resumomes_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());

                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {     
                grafico.Ano = atual;
            }

            grafico.Mes = resumo2.AddHours(1);
            Busca(grafico);

            lblAnoSelecionado.Text = "Resumo do ano " + grafico.Ano.Year;
            lbll.Visible = false;
            lblMesSelecionado.Visible = false;
            lblll.Visible = false;

        }
        protected void jan_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());

                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {            
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddDays(20);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-2" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void fev_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(1);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void mar_Click(object sender, EventArgs e)
        {                    
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(2);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void abr_Click(object sender, EventArgs e)
        {
            Grafico grafico     = new Grafico();
            DateTime resumo2    = DateTime.MinValue;
            DateTime atual      = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes     = resumo2.AddMonths(3);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void mai_Click(object sender, EventArgs e)
        {
            Grafico grafico     = new Grafico();
            DateTime resumo2    = DateTime.MinValue;
            DateTime atual      = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }

            grafico.Mes     = resumo2.AddMonths(4);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void jun_Click(object sender, EventArgs e)
        {
            Grafico grafico     = new Grafico();
            DateTime resumo2    = DateTime.MinValue;
            DateTime atual  = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes     = resumo2.AddMonths(5);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void jul_Click(object sender, EventArgs e)
        {
            Grafico grafico     = new Grafico();
            DateTime resumo2    = DateTime.MinValue;
            DateTime atual      = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(6);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void ago_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(7);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void set_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(8);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void out_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(9);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void nov_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(10);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        protected void dez_Click(object sender, EventArgs e)
        {
            Grafico grafico = new Grafico();
            DateTime resumo2 = DateTime.MinValue;
            DateTime atual = DateTime.Now;

            if (Request.QueryString["ANO"] != null && Request.QueryString["ANO"] != "-1" && Request.QueryString["ANO"] != "-2")
            {
                int TESTE = Convert.ToInt32(Request.QueryString["ANO"].ToString());
                TESTE = TESTE - 1;
                grafico.Ano = grafico.Ano.AddYears(TESTE);
            }
            else
            {
                grafico.Ano = atual;
            }
            grafico.Mes = resumo2.AddMonths(11);
            Response.Redirect("PagADM.aspx?qtdpar=" + "-1" + "&qtdinfra=" + "-1" + "&ANO=" + grafico.Ano.Year.ToString() + "&MES=" + grafico.Mes.Month.ToString(), true);
        }
        #endregion

        protected Grafico Busca(Grafico grafico)
        {
            // DECLARAÇÃO DO MODEL
            GraficoModel gmodel = new GraficoModel(strConexao);

            // REALIZA A BUSCA DAS QUANTIDADES             
            grafico = gmodel.ObterArrecadacao(grafico);

            //Mostra valores na tabela e no grafico da PARADAS
            qtdparadas.Text     = grafico.Q_Parada.ToString();
            hddparadas.Value    = grafico.Q_Parada.ToString();

            //Mostra valores na tabela e no grafico da NOTIFICAÇÕES
            qtdinfra.Text       = grafico.Q_Notificacao.ToString();
            hddinfracao.Value   = grafico.Q_Notificacao.ToString();

            //Mostra QTD ARRECADADO
            qtdarrecadado.Text = "R$" + grafico.T_Arrecadado.ToString();

            decimal result;

            if (grafico.Q_Parada == 0 && grafico.Q_Notificacao == 0 || grafico.Q_Parada != 0 && grafico.Q_Notificacao == 0 || grafico.Q_Parada == 0 && grafico.Q_Notificacao != 0)
            {
                result = 0;
                qtdresult.Text = result.ToString();
            }
            else
            {
                result = (decimal)grafico.Q_Notificacao / (decimal)grafico.Q_Parada;
                qtdresult.Text = result.ToString("0.###");
            }
            return grafico;
        }

        protected void MostrarAno(Grafico grafico)
        {
            lbll.Visible                = true;
            lblMesSelecionado.Visible   = true;
            lblll.Visible               = true;
            lblAnoSelecionado.Text = grafico.Ano.Year.ToString();
            lblMesSelecionado.Text = grafico.Mes.Month.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}