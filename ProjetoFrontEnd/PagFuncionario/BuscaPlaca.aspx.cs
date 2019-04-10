using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Model;
using System.Configuration;
using ProjetoBackEnd.Entity;

namespace ProjetoFrontEnd.PagFuncionario
{
    public partial class BuscaPlaca : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            PessoaModel pmodel = new PessoaModel(strConexao);
            ParadaModel pamodel = new ParadaModel(strConexao);

            Veiculo veiculo = Session["veiculopes"] as Veiculo;
            Pessoa pessoa = Session["pessoapes"] as Pessoa;
            Parada parada = Session["ultimaparada"] as Parada;
            Funcionario funcionario = Session["func"] as Funcionario;
            Notificacao notifica = new Notificacao();

            // LEGENDA PARA AS DESCRIÇOES DAS NOTIFICAÇOES 
            // 1 - O USUARIO NÃO POSSUE CADASTRO
            // 2 - O HORARIO DA PARADA JA TERMINOU
            // 3 - O HORARIO DA PARADA ACABOU DE TERMINAR
            // 4 - O VEICULO NAO REALIZOU A PARADA NO DIA DA PESQUISA
            // 5 - O USUARIO NÃO REALIZOU A PARADA


            // ERRO NO COMNADO DO BANCO QUANDO BUSCA UMA PLACA QUANDO NAO POSSUI PARADA, O RESULTADO EH A ULTIMA PARADA NAO EQUIVALENTE AO ID DA PLACA

            // valores para calcular hora final
            DateTime horafinal = new DateTime();
            int horas = 0;
            int minutos = 0;

            btnotificar.Visible = false;          
    
            if(funcionario == null)
            {
                lblerro.Visible = true;
                lblerro.Text = "Digite uma placa para realizar a busca!";
            }
            else
            {
                if (pessoa != null) // REALIZOU A PESQUISA E MOSTRA OS DADOS DO USUARIO
                {
                    lblnome.Text = pessoa.Nome;
                    lblrg.Text = pessoa.Rg;
                    lblcidade.Text = pessoa.Cidade;
                    lblplaca.Text = veiculo.Placa;
                }
                else if (funcionario.Busca == true) //BUSCA REALIZADA E NÃO ENCONTROU USUARIO NO BANCO
                {
                    lblerro.Visible = true;
                    lblerro.Text = "Usuário não registrado no sistema, notificar a policia militar para realização da multa!";
                    funcionario.Busca = false;
                    notifica.Descricao = 1;
                }
                else // NAO REALIZOU PESQUISA
                {
                    lblerro.Visible = true;
                    lblerro.Text = "Digite uma placa para realizar a busca!";                 
                }

                //
                if (parada != null) //REALIZOU PESQUISA E ENCONTROU A ULTIMA PARADA
                {
                    lbldata.Text = parada.DATA_PARA.ToShortDateString();
                    lblhorainicioparada.Text = parada.DATA_PARA.ToShortTimeString();

                    switch (parada.QTD_HORA)
                    {
                        case 1:
                            lblhora.Text = "1 Hora";
                            horas = 1;
                            minutos = 0;
                            break;
                        case 15:
                            lblhora.Text = "1 Hora e 30 minutos";
                            horas = 1;
                            minutos = 30;
                            break;
                        case 2:
                            lblhora.Text = "2 Horas";
                            horas = 2;
                            minutos = 0;
                            break;
                        case 25:
                            lblhora.Text = "2 Horas e 30 minutos";
                            horas = 2;
                            minutos = 30;
                            break;
                        case 3:
                            lblhora.Text = "3 Horas";
                            horas = 3;
                            minutos = 0;
                            break;
                    }

                    // HORA QUE TERMINA A PARADA
                    horafinal = parada.DATA_PARA.AddHours(horas).AddMinutes(minutos);
                    lblfinalparada.Text = horafinal.ToShortTimeString();

                    // VALIDAÇÃO DA PARADA E NOTIFICAÇÕES DE INFRAÇÕES
                    DateTime hoje = DateTime.Now;

                    #region VALIDAÇÃO DA PARADA E NOTIFICAÇÕES DE INFRAÇÕES

                    if (parada.DATA_PARA.ToShortDateString() == hoje.ToShortDateString()) // o dia atual É igual AO dia da parada
                    {
                        // COMPARA A HORA DE AGORA COM A HORA INICIAL DA PARADA
                        int resultado = DateTime.Compare(hoje, parada.DATA_PARA);

                        if (resultado < 0)
                        {
                            // PRIMEIRA DATA É MAIS ANTIGA
                            // ERRO!
                            // A DATA DE HJ É MAIS ANTIGA QUE A DATA DA PARADA = IMPOSSIVEL!!
                            lblerro.Visible = true;
                            lblerro.Text = "ERRO NO SISTEMA DE BUSCA. POR FAVOR NOTIFICAR OS ADMINISTRADORES!";
                        }
                        else if (resultado == 0)
                        {
                            // DATA IGUAIS
                            // CORRETO !

                            lblerro.Visible = true;
                            lblerro.Text = "O veiculo esta estacionado corretamente!";
                        }
                        else
                        {
                            // PRIMEIRA DATA É MAIS NOVA
                            // DATA DE HOJE É MAIS NOVA QUE A DATA DA PARADA.

                            // COMPARA A HORA DE AGORA COM A HORA FINAL DA PARADA
                            int resultadofinal = DateTime.Compare(horafinal, hoje);

                            if (resultadofinal < 0)
                            {
                                // PRIMEIRA DATA É MAIS ANTIGA
                                // NOTIFICAR
                                // HORA FINAL DA PARADA JA PASSOU DA HORA ATUAL

                                lblerro.Visible = true;
                                btnotificar.Visible = true;
                                lblerro.Text = "Horário da parada ja terminou!";
                                notifica.Descricao = 2;
                            }
                            else if (resultadofinal == 0)
                            {
                                // DATA IGUAIS
                                // NOTIFICAR
                                // HORARIO DA PARADA ACABOU DE TERMINAR

                                lblerro.Visible = true;
                                btnotificar.Visible = true;
                                lblerro.Text = "Horário da parada ja terminou!";
                                notifica.Descricao = 3;
                            }
                            else
                            {
                                // PRIMEIRA DATA É MAIS NOVA
                                //CORRETO

                                lblerro.Visible = true;
                                lblerro.Text = "O veiculo esta estacionado corretamente!";
                            }
                        }
                    }
                    else // o dia autal é diferente da parada
                    {
                        lblerro.Visible = true;
                        btnotificar.Visible = true;
                        lblerro.Text = "Este veiculo não realizou parada neste dia!";
                        notifica.Descricao = 4;
                    }

                    #endregion

                }
                else if (funcionario.Busca == true && parada == null) // REALIZOU A PESUQISA E NAO ENCONTROU PARADA
                {
                    lblerro.Visible = true;
                    btnotificar.Visible = true;
                    lblerro.Text = "Placa não possui paradas.";
                    notifica.Descricao = 5;
                }
                else // NAO REALIZOU A PESQUISA
                {
                }

                //recebe o erro da Parada
                Session["notifica"] = notifica;
            }        
        }

        protected void btnpesquisar_Click(object sender, EventArgs e)
        {
            VeiculoModel vmodel = new VeiculoModel(strConexao);
            PessoaModel pmodel = new PessoaModel(strConexao);
            ParadaModel pamodel = new ParadaModel(strConexao);
            PesquisaModel pemodel = new PesquisaModel(strConexao);

            Veiculo veiculo = new Veiculo();
            Pessoa pessoa = new Pessoa();
            Parada parada = new Parada();
            Pesquisa pesquisa = new Pesquisa();
            Funcionario funcionario = Session["func"] as Funcionario;

            Session["pessoapes"] = null;
            Session["veiculopes"] = null;
            Session["ultimaparada"] = null;

            veiculo.Placa = txtplaca.Text;

            pessoa = pmodel.BuscaPlaca(veiculo.Placa);

            Session["pessoapes"] = pessoa;

            if(pessoa != null)
            {
                veiculo = vmodel.ObterVeiculo(pessoa.Id);

                if (veiculo != null)
                {
                    Session["veiculopes"] = veiculo;

                    // realizar lista paradas
                    parada = pamodel.ObterUltimaParada(pessoa.Id);

                    Session["ultimaparada"] = parada;
                }
                else
                {
                    // NÃO EXITE VEICULO
                }

                //insere pesquisa
                pesquisa.ID_Funcionario = funcionario;
                pesquisa.ID_Parada = parada;
                pesquisa.Id_Veiculo = veiculo;

                if(parada == null){}
                else
                {
                    pesquisa = Pesquisa_status(pesquisa);                
                }
                pemodel.InserirPesquisa(pesquisa);
                Session["pesquisa"] = pesquisa;
            }
            else
            {
                // NÃO EXITE PESSOA
            }

            funcionario.Busca = true;
            Session["func"] = funcionario;

            Response.Redirect("../PagFuncionario/BuscaPlaca.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if(lblnome == null || lblcidade == null)
            {
                lblnome.Text = "Por favor, realize uma busca antes de notificar.";
            }
            else
            {
                Response.Redirect("Confirmacao.aspx");
            }
        }

        protected Pesquisa Pesquisa_status(Pesquisa pesquisa)
        {
            DateTime hoje = DateTime.Now;
            DateTime horafinal = new DateTime();

            int horas = 0;
            int minutos = 0;

            switch (pesquisa.ID_Parada.QTD_HORA)
            {
                case 1:
                    lblhora.Text = "1 Hora";
                    horas = 1;
                    minutos = 0;
                    break;
                case 15:
                    lblhora.Text = "1 Hora e 30 minutos";
                    horas = 1;
                    minutos = 30;
                    break;
                case 2:
                    lblhora.Text = "2 Horas";
                    horas = 2;
                    minutos = 0;
                    break;
                case 25:
                    lblhora.Text = "2 Horas e 30 minutos";
                    horas = 2;
                    minutos = 30;
                    break;
                case 3:
                    lblhora.Text = "3 Horas";
                    horas = 3;
                    minutos = 0;
                    break;
            }

            // HORA QUE TERMINA A PARADA
            horafinal = pesquisa.ID_Parada.DATA_PARA.AddHours(horas).AddMinutes(minutos);
            lblfinalparada.Text = horafinal.ToShortTimeString();


            // COMPARA A HORA DE AGORA COM A HORA INICIAL DA PARADA
            int resultado = DateTime.Compare(hoje, pesquisa.ID_Parada.DATA_PARA);

            if (resultado < 0)
            {
                // PRIMEIRA DATA É MAIS ANTIGA
                // ERRO!
                // A DATA DE HJ É MAIS ANTIGA QUE A DATA DA PARADA = IMPOSSIVEL!!
                pesquisa.Status_pes = 3;
            }
            else if (resultado == 0)
            {
                // DATA IGUAIS
                // CORRETO !
                pesquisa.Status_pes = 2;
            }
            else
            {
                // PRIMEIRA DATA É MAIS NOVA
                // DATA DE HOJE É MAIS NOVA QUE A DATA DA PARADA.

                // COMPARA A HORA DE AGORA COM A HORA FINAL DA PARADA
                int resultadofinal = DateTime.Compare(horafinal, hoje);

                if (resultadofinal < 0)
                {
                    // PRIMEIRA DATA É MAIS ANTIGA
                    // NOTIFICAR
                    // HORA FINAL DA PARADA JA PASSOU DA HORA ATUAL
                    pesquisa.Status_pes = 0;

                }
                else if (resultadofinal == 0)
                {
                    // DATA IGUAIS
                    // NOTIFICAR
                    // HORARIO DA PARADA ACABOU DE TERMINAR
                    pesquisa.Status_pes = 0;
                }
                else
                {
                    // PRIMEIRA DATA É MAIS NOVA
                    //CORRETO
                    pesquisa.Status_pes = 2;
                }
            }
            return pesquisa;
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            Response.Redirect("../PagUsuario/PagInicial.aspx");
        }
    }
}