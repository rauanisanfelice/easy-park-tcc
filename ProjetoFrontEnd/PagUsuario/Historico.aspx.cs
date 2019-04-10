using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;
using System.Configuration;

namespace ProjetoFrontEnd.Paginas
{
    public partial class historico : System.Web.UI.Page
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
                ParadaModel pamodel = new ParadaModel(strConexao);

                listahistorico.DataSource = pamodel.ListaParadaUsuario(login.Id_login);
                int teste = pamodel.ListaParadaUsuario(login.Id_login).Count;

                if (teste == 0)
                {
                    lblnada.Visible = true;
                }
                else
                {
                    listahistorico.DataBind();

                    int total = pamodel.ListaParadaUsuario(login.Id_login).Count;

                    lbltotal.Text = "Total de paradas: " + total;
                }
            }
        }


        protected void btnpesquisar_Click(object sender, EventArgs e)
        {
            ParadaModel pamodel = new ParadaModel(strConexao);
            VeiculoModel vmodel = new VeiculoModel(strConexao);
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            Veiculo veiculo = vmodel.ObterVeiculo(login.Id);

            listahistorico.DataSource = pamodel.ListaPesquisa(txtpesquisa1.Text, veiculo.Id_veiculo);
            listahistorico.DataBind();

            int total = pamodel.ListaPesquisa(txtpesquisa1.Text, veiculo.Id_veiculo).Count;
            lbltotal.Text = "Total de paradas: " + total;
        }
        protected void btnlimpar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Historico.aspx");
        }

        protected void listahistorico_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void mostraplaca1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void tbnparadas_Click(object sender, EventArgs e)
        {
            Response.Redirect("historico.aspx");
        }

        protected void tblcompras_Click(object sender, EventArgs e)
        {
            Response.Redirect("HistoricoCompras.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}