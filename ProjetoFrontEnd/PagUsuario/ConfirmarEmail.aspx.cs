using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using ProjetoBackEnd.Data;
using ProjetoBackEnd.Model;
using System.Configuration;

namespace ProjetoFrontEnd.PagUsuario
{
    public partial class ConfirmarEmail : System.Web.UI.Page
    {
        string strConexao = ConfigurationManager.ConnectionStrings["stringConexao"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void confirmar_Click(object sender, EventArgs e)
        {
            LoginModel lmodel = new LoginModel(strConexao);
            bool verifica;

            if (Request.QueryString["msg"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["msg"].ToString());

                verifica = lmodel.AtualizarConf(id);
                if(verifica == true)
                {
                    Response.Redirect("PagInicial.aspx");
                }
                else
                {
                    pnlerro.Visible = true;
                }
            }
        }
    }
}