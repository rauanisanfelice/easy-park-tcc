using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

namespace ProjetoBackEnd.Data
{
    class Conexao : IDisposable
    {
        //interfase 
        public SqlConnection Cnn { get; set; } // objeto que recebe a conexao ( nome da maquina e o entedeço de IP) | execução

        public SqlCommand Cmd { get; set; } // reponsavel por executar os comandos na conexão |  coamndo

        public SqlDataReader Dr { get; set; } //armazenar o mesmo dado da consulta | resultado


        //realiza a conexão
        //contrutor da cclasse conexao
        public Conexao(string strConexao) //informações do banco 
        {
            try
            {
                //estabelecer a conexao

                Cnn = new SqlConnection(); //atribiu a sitrng a conexao
                Cnn.ConnectionString = strConexao; // atribui a string com a conexao do CN
                Cnn.Open();

            }
            catch {  }
        }

        public void Dispose()
        {
            try
            {
                Cnn.Close();
            }
            catch  {   }
        }
    }
}
