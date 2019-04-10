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
    public partial class configuracao : System.Web.UI.Page
    {

        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            LoginModel lmodel =     new LoginModel(strConexao);
            VeiculoModel vmodel =   new VeiculoModel(strConexao);
            ParadaModel pamodel = new ParadaModel(strConexao);
            NotificacaoModel nomodel = new NotificacaoModel(strConexao);

            if (login == null)
            {

            }
            else
            {
                lblnome.Text = login.Nome.ToString();
                lblrg.Text = login.Rg.ToString();
                lblcidade.Text = login.Cidade.ToString();

                ProjetoBackEnd.Entity.Login pegalogin = lmodel.ObterLogin(login.Id);

                lblemail.Text = pegalogin.Email.ToString();

                Veiculo veiculo = vmodel.ObterVeiculo(login.Id);

                lblplaca.Text = veiculo.Placa.ToString();
                lblsaldo.Text = "R$" + pegalogin.Saldo.ToString();

                int parada = pamodel.ListaParadaUsuario(login.Id).Count();
                lblparadas.Text = parada.ToString();

                int notificacao = nomodel.ListaNotificacao(login.Id).Count();
                lblinfracao.Text = notificacao.ToString();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}