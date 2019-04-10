using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Model;
using ProjetoBackEnd.Entity;
using System.Configuration;

using System.Net;
using System.Net.Mail;

namespace ProjetoFrontEnd.PagUsuario
{
    public partial class Recuperar : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["StringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void tbnrecuperar_Click(object sender, EventArgs e)
        {
            PessoaModel pmodel = new PessoaModel(strConexao);

            Pessoa pessoa = pmodel.RecuperarSenha(txtemail.Text);

            if(pessoa.Senha != null)
            {
                //string email = "Sua senha é: " + senha + " Seu e-mail é: " + txtemail.Text;

                string email = "<br /><h4 style='margin-left:20%;'> Olá  <b>" + pessoa.Nome + ",</ b></ h4 ><h4 style='margin-left:20%;'> Recebemos uma solicitação de senha para o e - mail <b >" + txtemail.Text + "</b></h4><h4 style='margin-left:20%;'> Sua senha é:<b >" + pessoa.Senha + "</ b></ h4 ><br /><br /><br /><hr style='border:solid 1px #f77e2d; width: 50%; margin-left:25%;' /><h2 style='text-align:center'> Dúvidas ? Entre em contaro conosco!</ h2 ><h2 style='color: #f77e2d; text-align:center' > easyparkrotativo@gmail.com </ h2 >";

                MailMessage mail = new MailMessage();

                mail.From = new MailAddress("de@gmail.com");
                mail.To.Add(txtemail.Text); // para
                mail.Subject = "Recuperação de senha"; // assunto
                mail.Body = email; // mensagem
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

                Response.Redirect("PagInicial.aspx");
            }
            else
            {
                Panelerro.Visible = true;
            }

        }

        protected void btnvoltar_Click(object sender, EventArgs e)
        {
            Response.Redirect("PagInicial.aspx");
        }
    }
}