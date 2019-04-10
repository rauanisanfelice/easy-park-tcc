using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;
using System.Configuration;


namespace ProjetoFrontEnd
{
    public partial class ControleLogin : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ProjetoBackEnd.Entity.Login login = Session["login"] as ProjetoBackEnd.Entity.Login;
            Funcionario funcionario = Session["func"] as Funcionario;
            Pessoa pessoa = Session["adm"] as Pessoa;

            if (login != null)
            {
                //  USUARIO
                PanelNaoLogado1.Visible = false;
                panelLogado.Visible = true;
                pnladm.Visible = false;
                PanelFuncionario.Visible = false;
            }
            else if(funcionario != null)
            {
                //  FUNCIONARIO 
                PanelNaoLogado1.Visible = false;
                panelLogado.Visible = false;
                pnladm.Visible = false;
                PanelFuncionario.Visible = true;
            }
            else if (pessoa != null)
            {
                //  ADM
                PanelNaoLogado1.Visible = false;
                panelLogado.Visible = false;
                pnladm.Visible = true;
                PanelFuncionario.Visible = false;
            }
            else
            {
                //  NÃO LOGADO
                PanelNaoLogado1.Visible = true;
                panelLogado.Visible = false;
                pnladm.Visible = false;
                PanelFuncionario.Visible = false;
            }            
        }

        protected void inscrever_Click(object sender, EventArgs e)
        {
            Response.Redirect("CadastroUsu.aspx");
        }


        protected void btnentrar_Click(object sender, EventArgs e)
        {
            string strCnn = ConfigurationManager.ConnectionStrings["stringConexao"].ConnectionString;

            LoginModel model = new LoginModel(strCnn);
            FuncionarioModel fmodel = new FuncionarioModel(strCnn);
            PessoaModel pmodel = new PessoaModel(strCnn);

            //verifica se exite algum login
            ProjetoBackEnd.Entity.Login login = model.ObterLogin(txtusuario.Text, txtsenha.Text);
            Funcionario funcio = fmodel.ObterFuncionario(txtusuario.Text, txtsenha.Text);
            Pessoa pesso = pmodel.ObtemPessoaLogin(txtusuario.Text, txtsenha.Text);


            // login cliente
            if (login != null)
            {   
                if(login.Confirmacao == 1)
                {
                    Session["login"] = login;
                    Response.Redirect("Menu.aspx");
                }
                else
                {
                    lblinvalido.Visible = true;
                    lblinvalido.Text = "Por favor confirmar seu e-mail!!";
                }
                
            }
            // login funcionario
            else if (funcio != null)
            {
                Session["func"] = funcio;
                Response.Redirect("../PagFuncionario/BuscaPlaca.aspx");
            }
            //login adm TESSSSSSSSSSSSSSTE
            else if (pesso != null)
            {
                Session["adm"] = pesso;
                Response.Redirect("../PagADM/PagADM.aspx");
            }
            else
            {
                lblinvalido.Visible = true;
            }
        }

        protected void btnsair_Click(object sender, EventArgs e)
        {
            //sair da seção
            Session.Remove("login");
            Session.Remove("func");
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Session.Remove("adm");
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }

        protected void btnconfirmar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Recuperar.aspx");
        }

        protected void pesquisar_Click(object sender, EventArgs e)
        {
            Response.Redirect("BuscaPlaca.aspx");
        }
        protected void comprar_Click(object sender, EventArgs e)
        {
            Response.Redirect("VendaParada.aspx");
        }
        protected void sairfun_Click(object sender, EventArgs e)
        {
            Session.Remove("func");
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}