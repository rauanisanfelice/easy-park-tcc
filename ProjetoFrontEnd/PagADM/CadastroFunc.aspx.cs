using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;

namespace ProjetoFrontEnd.Paginas
{
    public partial class CadastroFunc : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void confirmarfun_Click(object sender, EventArgs e)
        {
            //declara um objeto produto
            PessoaModel pModel = new PessoaModel(strConexao);
            FuncionarioModel fmodel = new FuncionarioModel(strConexao);
            Pessoa administrador = Session["adm"] as Pessoa;

            if (administrador == null)
            {

            }
            else
            {
                string msg = "";

                int contfiscal  = fiscalfun.Text.Length;
                int contsetor   = setorfunc.Text.Length;
                int contrg      = rgfuncionario.Text.Length;
                int contsenha   = senhafun.Text.Length;

                lblerrofiscal.Visible   = false;
                lblerrosetor.Visible    = false;
                lblerrorg.Visible       = false;              
                lblerrosenha.Visible    = false;

                if (contfiscal == 4 && contsetor == 4 && contsenha >= 5 && contrg == 12)
                {
                    Funcionario funcionario = new Funcionario();
                    funcionario.Nome = nomefun.Text;
                    funcionario.Rg = rgfuncionario.Text;
                    funcionario.Cidade = cidadefunc.Text;
                    funcionario.Senha = senhafun.Text;

                    funcionario.Fiscal = Int32.Parse(fiscalfun.Text);
                    funcionario.Setor = Int32.Parse(setorfunc.Text);

                    int fis = Convert.ToInt32(fiscalfun.Text);

                    // verifica se ja exite o numero fiscal
                    bool verifica = fmodel.ObterFiscal(fis);

                    if (verifica == false)
                    {
                        //  ADD USUARIO NOVO
                        pModel.InserirPessoa(funcionario);
                        msg = "0";
                        Response.Redirect("FuncionarioControle.aspx?msg" + msg);
                    }
                    else
                    {
                        msg = "1";
                        Response.Redirect("CadastroFunc.aspx?msg" + msg);
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
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}