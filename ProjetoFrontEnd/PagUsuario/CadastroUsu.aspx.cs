using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Model;

using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.IO;

using System.Text;

namespace ProjetoFrontEnd.cadastro
{
    public partial class CadastroUsu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void confirmar_Click(object sender, EventArgs e)
        {
            //recupera a string de conexao do arquivo web.config
            string strConexao = ConfigurationManager.ConnectionStrings["stringConexao"].ConnectionString;

            //declara um objeto produto
            PessoaModel pModel = new PessoaModel(strConexao);
            LoginModel lmodel = new LoginModel(strConexao);
            ProjetoBackEnd.Entity.Login login = Session["pessoa"] as ProjetoBackEnd.Entity.Login;
            Veiculo veiculo = new Veiculo();

            string msg = "";
            bool tela = false;

            int contplaca = txtplaca1.Text.Length;
            int contrg = rg.Text.Length;
            int contsenha = senha.Text.Length;

            lblerrorg.Visible    = false;
            lblerroplaca.Visible = false;
            lblerrosenha.Visible = false;

            if (contplaca == 8 && contsenha >= 5 && contrg == 12)
            {
                login = new ProjetoBackEnd.Entity.Login();
                //preenche o objeto login
                login.Email = email.Text;
                login.Nome = nome.Text;
                login.Rg = rg.Text;
                login.Cidade = cidade.Text;
                login.Senha = senha.Text;

                veiculo = new Veiculo();

                bool teste = lmodel.VerificaEmail(email.Text);
                if (teste == false)
                {
                    login = (ProjetoBackEnd.Entity.Login)pModel.InserirPessoa(login);
                    if (login != null)
                    {
                        //Cadastro efetuado com sucesso!
                        msg = "0";
                        tela = true;
                        enviaremail(login);
                    }
                    else
                    {
                        //Erro ao cadastrar o usuário.
                        pnlerro.Visible         = true;
                        lblerroplaca.Text = "Erro ao cadastrar usuário.";
                        lblerrorg.Visible       = false;
                        lblerrosenha.Visible    = false;
                        tela                    = false;
                    }

                    //  ADICIONAR VEICULO
                    VeiculoModel vModel = new VeiculoModel(strConexao);
                    veiculo.Placa = txtplaca1.Text;
                    veiculo.Logins = login;

                    //adicionar veiculo
                    vModel.InserirVeiculos(veiculo);

                    if (veiculo == null)
                    {
                        //Erro ao cadastrar o veiculo.
                        pnlerro.Visible         = true;
                        lblerroplaca.Text = "Erro ao cadastrar usuário.";
                        lblerrorg.Visible       = false;
                        lblerrosenha.Visible    = false;
                        tela                    = false;
                    }

                    if (tela == true)
                    {
                        Response.Redirect("PagInicial.aspx?msg" + msg);
                    }
                    else { }
                }
                else
                {
                    pnlerro.Visible = true;
                    lblerroplaca.Text = "Erro!! Já existe este e-mail.";
                    lblerroplaca.Visible = true;
                    lblerrorg.Visible = false;
                    lblerrosenha.Visible = false;
                }
            }
            if (contplaca < 8)
            {
                pnlerro.Visible         = true;
                lblerroplaca.Visible    = true;
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

        protected void enviaremail(ProjetoBackEnd.Entity.Login login)
        {
            MailMessage mail = new MailMessage();
            Image teste = new Image();
            teste.ImageUrl = "";
            //string emailenviar = teste + "Easy park. Para confirmar seu cadastro acesse o link: http://localhost:35192/PagUsuario/ConfirmarEmail.aspx?msg=" + login.Id;

            int id = login.Id;

            string emailcorpo = @"<div style = 'background-color:#67b1d6; 
                                                width:100%;
                                                height: 100%/;'>
                                    <div>
                                       <h4 style='text-align: center; height:65%; margin-top: 70px; color: white;font - family: Arial, 'Times New Roman'; text - align: center; display: block; margin - right: auto; margin - left: auto; '>Easy park é um sistema que propõe uma maior facilidade e conforto ao usuário nos estacionamentos rotativos de sua cidade, também tirando a dependência dos funcionários para compra de suas horas e trazendo mais opções para o pagamento.</ h4 ></ div ></ div ><div style = '   margin-top:60px; margin-left: 110px; margin-bottom:60px;'><h3>Para confirmar seu cadastro, basta clicar<a href = 'http://localhost:35192/PagUsuario/ConfirmarEmail.aspx?msg=" + id + "' style = 'text-decoration:none; color: orangered;' > aqui.</a></h3></div>";


            mail.From = new MailAddress("de@gmail.com");
            mail.To.Add(email.Text); // para
            mail.Subject = "Confirmação do e-mail"; // assunto
            mail.Body = emailcorpo; // mensagem
            mail.IsBodyHtml = true;

            using (var smtp = new SmtpClient("smtp.gmail.com"))
            {
                smtp.EnableSsl = true; // GMail requer SSL
                smtp.Port = 587;       // porta para SSL
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network; // modo de envio
                smtp.UseDefaultCredentials = false; // vamos utilizar credencias especificas

                // seu usuário e senha para autenticação
                smtp.Credentials = new NetworkCredential("easyparkrotativo@gmail.com", "758976ra*");

                // envia o e-mail 
                try
                {
                    smtp.Send(mail);

                }
                catch (Exception ex)
                {
                    smtp.Send(mail);
                }
            }
        }
    }
}