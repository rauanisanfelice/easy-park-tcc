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
    public partial class Compra : System.Web.UI.Page
    {

        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            LoginModel lmodel = new LoginModel(strConexao);

            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

            if (login == null)
            {

            }
            else
            {
                login = lmodel.ObterLogin(login.Id);
                //mostra agora o saldo da pessoa
                lblsaldo.Text = login.Saldo.ToString();
            }
        }

        DateTime thisDay = DateTime.Now;

        protected void btn5_Click(object sender, EventArgs e)
        {
            LoginModel lmodel = new LoginModel(strConexao);
            CompraModel comodel = new CompraModel(strConexao);

            ProjetoBackEnd.Entity.Login addlogin = Session["login"] as ProjetoBackEnd.Entity.Login;

            addlogin = lmodel.ObterLogin(addlogin.Id);
                        
            // ATUALIZA SALDO
            addlogin.Saldo = addlogin.Saldo + 5;

            lmodel.AtualizarSaldo(addlogin);

            // adicionar compra
            ProjetoBackEnd.Entity.Compra compra = new ProjetoBackEnd.Entity.Compra();

            compra.Logins = new ProjetoBackEnd.Entity.Login();
            compra.Logins.Id_login = addlogin.Id_login;
            compra.Valor = 5;
            compra.Data_comp = thisDay;
            compra.Hora = thisDay;           

            // REALIZA A COMPRA
            comodel.InserirCompra(compra);

            // ATUALIZA SESSION
            Session["login"] = addlogin;
            //
            Response.Redirect("../PagUsuario/Compra.aspx?pnl1");
        }

        protected void btn10_Click(object sender, EventArgs e)
        {
            LoginModel lmodel = new LoginModel(strConexao);
            CompraModel comodel = new CompraModel(strConexao);

            ProjetoBackEnd.Entity.Login addlogin = Session["login"] as ProjetoBackEnd.Entity.Login;

            addlogin = lmodel.ObterLogin(addlogin.Id);

            // ATUALIZA SALDO
            addlogin.Saldo = addlogin.Saldo + 10;

            lmodel.AtualizarSaldo(addlogin);

            // adicionar compra
            ProjetoBackEnd.Entity.Compra compra = new ProjetoBackEnd.Entity.Compra();

            compra.Logins = new ProjetoBackEnd.Entity.Login();
            compra.Logins.Id_login = addlogin.Id_login;
            compra.Valor = 10;
            compra.Data_comp = thisDay;
            compra.Hora = thisDay;

            // REALIZA A COMPRA
            comodel.InserirCompra(compra);

            // ATUALIZA SESSION
            Session["login"] = addlogin;

            Response.Redirect("../PagUsuario/Compra.aspx?pnl1");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            LoginModel lmodel = new LoginModel(strConexao);
            CompraModel comodel = new CompraModel(strConexao);

            ProjetoBackEnd.Entity.Login addlogin = Session["login"] as ProjetoBackEnd.Entity.Login;

            addlogin = lmodel.ObterLogin(addlogin.Id);

            // ATUALIZA SALDO
            addlogin.Saldo = addlogin.Saldo + 20;

            lmodel.AtualizarSaldo(addlogin);

            // adicionar compra
            ProjetoBackEnd.Entity.Compra compra = new ProjetoBackEnd.Entity.Compra();

            compra.Logins = new ProjetoBackEnd.Entity.Login();
            compra.Logins.Id_login = addlogin.Id_login;
            compra.Valor = 20;
            compra.Data_comp = thisDay;
            compra.Hora = thisDay;

            // REALIZA A COMPRA
            comodel.InserirCompra(compra);

            // ATUALIZA SESSION
            Session["login"] = addlogin;

            Response.Redirect("../PagUsuario/Compra.aspx?pnl1");      
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}