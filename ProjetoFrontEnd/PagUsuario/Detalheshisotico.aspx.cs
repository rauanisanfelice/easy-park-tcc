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
    public partial class detalheshisotico : System.Web.UI.Page
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
                if (Request.QueryString["ID_PARADA"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["ID_PARADA"].ToString());

                    ParadaModel pamodel = new ParadaModel(strConexao);
                    VeiculoModel vemodel = new VeiculoModel(strConexao);

                    Parada parada = new Parada();
                    Veiculo veiculo = new Veiculo();

                    parada = pamodel.ObteridParada(id);
                    veiculo = vemodel.ObteridVeiculo(parada.ID_VEICULO);

                    DateTime horafinal = new DateTime();
                    int horas = 0;
                    int minutos = 0;

                    lblplaca.Text = veiculo.Placa;
                    lbldata.Text = parada.DATA_PARA.ToShortDateString();
                    lblhora.Text = parada.DATA_PARA.ToShortTimeString();

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

                    //STATUS DA PARADA!!!!
                    bool verificação = pamodel.verificaParada(id);

                    if (verificação == true)
                    {
                        Image1.Visible = true;
                        Image2.Visible = false;
                    }
                    else
                    {
                        Image1.Visible = false;
                        Image2.Visible = true;
                    }
                }
                else if (Request.QueryString["ID_COMPRA"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["ID_COMPRA"].ToString());

                    CompraModel compmodel = new CompraModel(strConexao);
                    Compra compra = new Compra();

                    compra = compmodel.ObterCompra(id);

                    lblpla.Text = "Valor comprado: ";
                    lblda.Text = "Data da compra: ";
                    lblcom.Text = "Hora da compra: ";
                    lblho.Visible = false;
                    lblhora.Visible = false;
                    lblfin.Visible = false;
                    lblfinal.Visible = false;
                    lblstatus.Visible = false;

                    lblplaca.Text = "R$" + compra.Valor.ToString();
                    lbldata.Text = compra.Data_comp.ToShortDateString();
                    lblcompra.Text = compra.Hora.ToShortTimeString();
                }
            }
        }

        protected void btnconfirmar_Click(object sender, EventArgs e)
        {
            if(Request.QueryString["ID_PARADA"] != null)
            {
                Response.Redirect("Historico.aspx");
            }
            else if(Request.QueryString["ID_COMPRA"] != null)
            {
                Response.Redirect("HistoricoCompras.aspx");
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}