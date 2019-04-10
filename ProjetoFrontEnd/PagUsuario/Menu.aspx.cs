using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Entity;
using System.Configuration;
using ProjetoBackEnd.Model;


namespace ProjetoFrontEnd.Paginas
{
    public partial class Menu : System.Web.UI.Page
    {
        //recupera a string de conexao do arquivo web.config
        string strConexao = ConfigurationManager.ConnectionStrings["stringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            NotificacaoModel nomodel = new NotificacaoModel(strConexao);
            bool notificacao = false;

            if (login == null)
            {

            }
            else
            {
                int id = login.Id;
                List<Notificacao> lista = nomodel.ListaNotificacao(id);

                for (int i = 0; nomodel.ListaNotificacao(id).Count > i; i++)
                {
                    Notificacao notificac = new Notificacao();

                    notificac = lista[i];


                    if (notificac.Msglida == false)
                    {
                        notificacao = true;
                    }
                }


                if (notificacao == false)
                {
                    // MSG LIDA
                    notificaatencao.Visible = false;
                    notificaatencao1.Visible = false;

                    notifica.Visible = true;
                    notifica1.Visible = true;
                }
                else
                {
                    // MSG NAO LIDA
                    notificaatencao.Visible = true;
                    notificaatencao1.Visible = true;

                    notifica.Visible = false;
                    notifica1.Visible = false;
                }
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}