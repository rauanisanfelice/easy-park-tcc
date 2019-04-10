using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;

namespace ProjetoFrontEnd.cadastro
{
    public partial class EditarDados : System.Web.UI.Page
    {

        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;

                PessoaModel pmodel = new PessoaModel(strConexao);
                LoginModel lmodel = new LoginModel(strConexao);
                VeiculoModel vmodel = new VeiculoModel(strConexao);

                Session["login"] = login;

                if (login == null)
                {

                }
                else
                {
                    int id = login.Id;

                    //
                    Pessoa pessoa = pmodel.ObtemPessoa(id);

                    nome.Text = pessoa.Nome.ToString();
                    rg.Text = pessoa.Rg.ToString();
                    cidade.Text = pessoa.Cidade.ToString();

                    //
                    ProjetoBackEnd.Entity.Login pegalogin = lmodel.ObterLogin(id);

                    email.Text = pegalogin.Email.ToString();

                    //
                    Veiculo veiculo = vmodel.ObterVeiculo(id);

                    placa.Text = veiculo.Placa.ToString();

                    codigo.Value = pessoa.Id.ToString();

                    lblsenha.Text = "Digite sua senha nova";
                    lblconfsenha.Text = "Confirmar senha";
                }
            }
        }

        protected void salvar_Click(object sender, EventArgs e)
        {
            PessoaModel pmodel = new PessoaModel(strConexao);
            LoginModel lmodel = new LoginModel(strConexao);
            VeiculoModel vmodel = new VeiculoModel(strConexao);

            ProjetoBackEnd.Entity.Login addlogin = Session["login"] as ProjetoBackEnd.Entity.Login;

            string msg = "";

            addlogin = lmodel.ObterLogin(int.Parse(codigo.Value));

            int contplaca = placa.Text.Length;
            int contrg = rg.Text.Length;
            int contsenha = senha.Text.Length;

            lblerrorg.Visible = false;
            lblerroplaca.Visible = false;
            lblerrosenha.Visible = false;

            if (contplaca == 8 && contsenha >= 5 && contrg == 12)
            {
                addlogin.Nome = nome.Text;
                addlogin.Rg = rg.Text;
                addlogin.Cidade = cidade.Text;
                addlogin.Senha = senha.Text;
                addlogin.Email = email.Text;
                addlogin.Id = int.Parse(codigo.Value);

                Veiculo addplaca = new Veiculo();

                addplaca.Logins = new ProjetoBackEnd.Entity.Login();
                addplaca.Logins.Id_login = addlogin.Id;
                addplaca.Placa = placa.Text;

                bool testepessoa  = pmodel.EditarPessoa(addlogin);
                bool testeveiculo =  vmodel.EditarVeiculo(addplaca);
                
                if (testepessoa == true && testeveiculo == true)
                {
                    //cadastro realizado com sucesso
                    msg = "0";
                }
                else
                {
                    msg = "1";
                }

                Session["login"] = addlogin;

                Response.Redirect("../PagUsuario/Configuracao.aspx?msg" + msg);
            }
            if (contplaca < 8)
            {
                pnlerro.Visible = true;
                lblerroplaca.Visible = true;
            }
            if (contsenha < 5)
            {
                pnlerro.Visible = true;
                lblerrosenha.Visible = true;
            }
            if (contrg < 12)
            {
                pnlerro.Visible = true;
                lblerrorg.Visible = true;
            }

        }

        protected void cancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Configuracao.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}