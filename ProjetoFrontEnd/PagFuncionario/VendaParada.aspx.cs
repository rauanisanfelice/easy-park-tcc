using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;
using System.Configuration;
using System.Threading;


namespace ProjetoFrontEnd.PagFuncionario
{
    public partial class VendaParada : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Funcionario funcionario = Session["func"] as Funcionario;

            if (funcionario == null)
            {
            }
            else
            {
                if (Request.QueryString["msg"] != null)
                {
                    PanelSucesso.Visible = true;
                }
            }
        }

        protected void btnEstacionar_Click(object sender, EventArgs e)
        {
            Funcionario funcionario = Session["func"] as Funcionario;
            VeiculoModel vemodel = new VeiculoModel(strConexao);
            ParadaModel pamodel = new ParadaModel(strConexao);
            CompraModel comodel = new CompraModel(strConexao);
            PessoaModel pmodel = new PessoaModel(strConexao);
            ProjetoBackEnd.Entity.Login login = new ProjetoBackEnd.Entity.Login();
            Compra compra = new Compra();
            Parada parada = new Parada();     
            Veiculo veiculo = new Veiculo();
            DateTime Atual = DateTime.Now;

            // DEIXA TODOS OS PAINEIS INVISIVEIS
            Panelerro.Visible       = false;
            PanelSucesso.Visible    = false;

            // VERIFICA SE A PLACA PODE REALIZAR UMA PARADA
            bool validacao = vemodel.ValidaPlaca(txtplaca.Text);


            if (validacao == false)
            {
                // NÃO pode
                Panelerro.Visible = true;
            }
            else
            {
                // Pode realizar parada 

                #region QTD DE HORA ESCOLHIDA
                int hora = 0;
                decimal valor = 0;
                switch (rblist1.SelectedIndex)
                {
                    case 0:
                        hora = 1;
                        valor = 1.5m;
                        break;
                    case 1:
                        hora = 15;
                        valor = 2.0m;
                        break;
                    case 2:
                        hora = 2;
                        valor = 2.5m;
                        break;
                    case 3:
                        hora = 25;
                        valor = 3.0m;
                        break;
                    case 4:
                        hora = 3;
                        valor = 3.5m;
                        break;
                }
                #endregion

                //  INSRE VALORES EM LOGIN
                login.Email = "";
                login.Nome = "";
                login.Rg = "";
                login.Cidade = "";
                login.Senha = "";
                //  INSERE LOGIN NULL
                login = (ProjetoBackEnd.Entity.Login)pmodel.InserirPessoa(login);

                // INSERE DADOS EM VEICULO
                veiculo.Logins = login;
                veiculo.Placa = txtplaca.Text;
                // INSERE PLACA DE VEICULO
                vemodel.InserirVeiculos(veiculo);

                //  OBTEM ID DO VEICULO
                veiculo = vemodel.ObterVeiculo(veiculo.Placa);

                //  ADD DADOS A PARADA
                parada.ID_VEICULO = veiculo.Id_veiculo;
                parada.QTD_HORA = hora;
                parada.DATA_PARA = Atual;
                //  INSERE PARADA
                pamodel.InserirParadas(parada);

                login.Id_login = login.Id;

                //  INSERE DADOS EM COMPRA
                compra.Logins = login;
                compra.Hora = Atual;
                compra.Data_comp = Atual;
                compra.Valor = valor;
                //  INSERE COMPRA
                comodel.InserirCompra(compra);

                //  COMPRA REALIZADA COM SUCESSO         
                string msg = "1";
                Response.Redirect("VendaParada.aspx?msg=" + msg);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}