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
    public partial class HistoricoCompras : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            CompraModel compmodel = new CompraModel(strConexao);

            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            if (login == null)
            {

            }
            else
            {
                ParadaModel pamodel = new ParadaModel(strConexao);

                listacompras.DataSource = compmodel.ListaCompra(login.Id_login);
                int teste = compmodel.ListaCompra(login.Id_login).Count;

                if (teste == 0)
                {
                    lblnada.Visible = true;
                }
                else
                {
                    listacompras.DataBind();
                    lbltotal.Text = "Total de compras: " + teste;
                }
            }


        }
        protected void tbnparadas_Click(object sender, EventArgs e)
        {
            Response.Redirect("Historico.aspx");
        }

        protected void tblcompras_Click(object sender, EventArgs e)
        {
            Response.Redirect("HistoricoCompras.aspx");
        }

        protected void btnpesquisa_Click(object sender, EventArgs e)
        {
            CompraModel comodel = new CompraModel(strConexao);
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;
            int id = login.Id;

            listacompras.DataSource = comodel.PesquisaCompra(txtpesquisa.Text, id);
            listacompras.DataBind();

            int teste = comodel.PesquisaCompra(txtpesquisa.Text, id).Count;
            lbltotal.Text = "Total de compras: " + teste;
        }

        protected void btnlimpa_Click(object sender, EventArgs e)
        {
            Response.Redirect("HistoricoCompras.aspx");
        }

        protected void listacompras_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}