using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class PessoaModel
    {
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public PessoaModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //  INSERIR
        public Pessoa InserirPessoa(Pessoa pessoa)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.InserirPessoa(pessoa);
            }
        }

        //  RECUPERAR SENHA
        public Pessoa RecuperarSenha(string email)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.RecuperarSenha(email);
            }
        }

        //  EDITAR
        public bool EditarPessoa(Pessoa pessoa)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.EditarPessoa(pessoa);
            }
        }

        //  EXCLUIR
        public bool ExcluirPessoa(Pessoa pessoa)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.ExcluirPessoa(pessoa);
            }
        }

        //  OBTER
        public Pessoa ObtemPessoa(int id)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.ObtemPessoa(id);
            }
        }


        //  OBTER loggin
        public Pessoa ObtemPessoaLogin(string nome, string senha)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.ObtemPessoaLogin(nome, senha);
            }
        }


        //  BUSCAR DADOS PESSOA PELA PLACA
        public Pessoa BuscaPlaca(string placa)
        {
            using (PessoaData data = new PessoaData(strConexao))
            {
                return data.BuscaPlaca(placa);
            }
        }

    }
}
