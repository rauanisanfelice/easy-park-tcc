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
    public partial class notificacoe : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            NotificacaoModel nomodel = new NotificacaoModel(strConexao);

            if (login == null)
            {

            }
            else
            {
                int id = login.Id;

                listanotificacao.DataSource = nomodel.ListaNotificacao(id);
                int qtd = nomodel.ListaNotificacao(id).Count;

                if (listanotificacao.DataSource == null || qtd == 0)
                {
                    lblatencao.Visible = true;
                }
                else
                {
                    listanotificacao.DataBind();
                    lblatencao.Visible = false;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void listanotificacao_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}