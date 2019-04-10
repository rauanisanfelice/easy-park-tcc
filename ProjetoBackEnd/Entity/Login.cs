using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Login : Pessoa //herda de pessoa
    {
        //propriedades
        public int Id_login {get; set; }
        public string Email { get; set; }
        public decimal Saldo { get; set; }
        public int Confirmacao { get; set; }
        

        //contrutor
        public Login() { }

        public Login(int id_login, string email, decimal saldo, int confirmacao, int id, string nome, string cidade, string senha, string rg)
            : base(id, nome, cidade, senha, rg)
        {
            Id_login = id_login;
            Email = email;
            Saldo = saldo;
            Confirmacao = confirmacao;
        }

    }
}
