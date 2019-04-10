using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;

namespace ProjetoFrontEnd.PagADM
{
    public partial class DadosUsuario : System.Web.UI.Page
    {

        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            FuncionarioModel model = new FuncionarioModel(strConexao);
            PesquisaModel pesmodel = new PesquisaModel(strConexao);
            NotificacaoModel nomodel = new NotificacaoModel(strConexao);
            Pessoa administrador = Session["adm"] as Pessoa;

            if (administrador == null)
            {

            }
            else
            {
                
                if (Request.QueryString["ID"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["ID"].ToString());

                    Funcionario funcionario = model.ObterFuncionario(id);

                    //MOSTRA OS DADOS DO FUNCIONARIO
                    fiscalfun.Text = funcionario.Fiscal.ToString();
                    setorfunc.Text = funcionario.Setor.ToString();
                    nomefun.Text = funcionario.Nome.ToString();
                    rgfuncionario.Text = funcionario.Rg.ToString();
                    cidadefunc.Text = funcionario.Cidade.ToString();

                    // MOSTRA TOTAL DE PESQUISAS DO FUNCIONARIO
                    int totalpesqui = pesmodel.SomaPesquisa(id);
                    lbltotalpesquisa.Text = totalpesqui.ToString();

                    // MOSTRA TOTAL DE NOTIFICACOES DO FUNCIONARIO
                    int totalnotificacao = nomodel.SomaNotificacao(id);
                    lblnotificacao.Text = totalnotificacao.ToString();

                    // MOSTRA TOTAL DE PESQUISAS IRREGULARES QUE NAO FOI FEITA A NOTIFICAÇÃO
                    int totalnaonotificado = pesmodel.SomaStatus(id, 0);
                    lblnaonotificado.Text = totalnaonotificado.ToString();

                    int totalparadaok = pesmodel.SomaStatus(id, 2);
                    lblparadaok.Text = totalparadaok.ToString();

                }
                else
                {

                }
            }
        }

        protected void confirmarfun_Click(object sender, EventArgs e)
        {
            //declara um objeto produto
            PessoaModel pModel = new PessoaModel(strConexao);
            FuncionarioModel fmodel = new FuncionarioModel(strConexao);

            string msg = "";

            int contfiscal  = Request.Params["ctl00$body$fiscalfun"].Length;
            int contsetor   = Request.Params["ctl00$body$setorfunc"].Length;
            int contrg      = Request.Params["ctl00$body$rgfuncionario"].Length;
            int contsenha   = Request.Params["ctl00$body$senhafun"].Length;

            lblerrofiscal.Visible   = false;
            lblerrosetor.Visible    = false;
            lblerrorg.Visible       = false;
            lblerrosenha.Visible    = false;

            if (contfiscal == 4 && contsetor == 4 && contsenha >= 5 && contrg == 12)
            {

            Funcionario funcionario = new Funcionario();
            funcionario.Nome    = Request.Params["ctl00$body$nomefun"];
            funcionario.Rg      = Request.Params["ctl00$body$rgfuncionario"];
            funcionario.Cidade  = Request.Params["ctl00$body$cidadefunc"];
            funcionario.Senha   = Request.Params["ctl00$body$senhafun"];

            funcionario.Fiscal = Int32.Parse(Request.Params["ctl00$body$fiscalfun"]);
            funcionario.Setor  = Int32.Parse(Request.Params["ctl00$body$setorfunc"]);



            if (Request.QueryString["ID"] != null)
            {
                funcionario.ID_Funcionario = Convert.ToInt32(Request.QueryString["ID"].ToString());

                //verificacao do numero do fiscal se existe um igual
                bool verifica = fmodel.ObterFiscal(funcionario.Fiscal);

                if (verifica == false)
                {
                    // erro funcionário ja existe
                    msg = "1";

                    Response.Redirect("CadastroFunc.aspx?msg" + msg);
                }
                else
                {
                    pModel.EditarPessoa(funcionario);
                    // cadastro efetuado com suceso 
                    msg = "0";

                    Response.Redirect("FuncionarioControle.aspx?msg" + msg);
                }
            }
            else
            {
                int fis = Convert.ToInt32(fiscalfun.Text);

                // verifica se ja exite o numero fiscal
                bool verifica = fmodel.ObterFiscal(fis);

                if (verifica == false)
                {
                    // cadastro efetuado com suceso 
                    pModel.InserirPessoa(funcionario);
                    msg = "0";

                    Response.Redirect("FuncionarioControle.aspx?msg" + msg);
                }
                else
                {
                    // erro funcionário ja existe
                    msg = "1";

                    Response.Redirect("CadastroFunc.aspx?msg" + msg);
                }
            }
            }
            if (contfiscal < 4 || contfiscal > 4)
            {
                pnlerro.Visible = true;
                lblerrofiscal.Visible = true;
            }
            if (contsetor < 4 || contsetor > 4)
            {
                pnlerro.Visible = true;
                lblerrosetor.Visible = true;
            }
            if (contrg < 12)
            {
                pnlerro.Visible = true;
                lblerrorg.Visible = true;
            }
            if (contsenha < 5)
            {
                pnlerro.Visible = true;
                lblerrosenha.Visible = true;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }

        protected void btndeletar_Click(object sender, EventArgs e)
        {

        }

        protected void confdeletar_Click(object sender, EventArgs e)
        {
            FuncionarioModel fmodel = new FuncionarioModel(strConexao);
            Funcionario funcionario = new Funcionario();

            funcionario.ID_Funcionario = Convert.ToInt32(Request.QueryString["ID"].ToString());

            int id = funcionario.ID_Funcionario;

            bool teste = fmodel.DeletarFuncionario(id);

            if (teste == true)
            {
                // Usuário deletado com sucesso!
                string msg = "2";
                Response.Redirect("FuncionarioControle.aspx?msg" + msg);

            }
            else
            {
                // Erro ao deletar usuário!
                string msg = "3";
                Response.Redirect("DadosUsuario.aspx?msg" + msg);
            }
        }

        protected void voltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FuncionarioControle.aspx");
        }
    }
}