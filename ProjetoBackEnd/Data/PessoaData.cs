using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using System.Data.SqlClient;


namespace ProjetoBackEnd.Data
{
    class PessoaData : Conexao
    {
        public PessoaData(string strConexao) : base(strConexao) { }

        //                              OK                
        // -------------------------------------------------------------------------

        //      INSERIR PESSOA
        public Pessoa InserirPessoa(Pessoa pessoa)
        {
            //declara a transacao 
            Pessoa res = null;
            SqlTransaction tran = null;

            try
            {
                //abrir a conexao com o BD
                //AbrirConexao();
                //inicia a transacao
                tran = Cnn.BeginTransaction();
                //tran = Cnn.BeginTransaction();
                //intancia o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //comando sql
                Cmd.CommandText =
                         @"IF (@nome) = ''
                            BEGIN
                                insert into pessoas values (null, null, null, null)
	                            select @@IDENTITY from pessoas	                            
                            END
                            ELSE
	                            insert into pessoas values (@nome, @rg,	@cidade, @senha)
	                            select @@IDENTITY from pessoas
                            GO";

                Cmd.Parameters.AddWithValue("@nome", pessoa.Nome); //@nome vai armazenar oque o usuario digitar na tela
                Cmd.Parameters.AddWithValue("@rg", pessoa.Rg);
                Cmd.Parameters.AddWithValue("@cidade", pessoa.Cidade);
                Cmd.Parameters.AddWithValue("@senha", pessoa.Senha);

                //recebe o codigo de usuario cadastrado
                pessoa.Id = Convert.ToInt32(Cmd.ExecuteScalar());


                // verifica se eh um LOGIN
                if (pessoa is Login)
                {
                    //"ve" o usuario como cliente
                    Login login = pessoa as Login;
                    //comando para inserir em cliente
                    Cmd.CommandText =
                @"insert into logins values (@id, @email, @saldo, @conf);";

                    //atribui valor as variaveis
                    Cmd.Parameters.AddWithValue("@id", login.Id);
                    Cmd.Parameters.AddWithValue("@email", login.Email);
                    Cmd.Parameters.AddWithValue("@saldo", login.Saldo);
                    Cmd.Parameters.AddWithValue("@conf", 0);
                    //executa o comando sql
                    Cmd.ExecuteNonQuery();
                }
                //verifica se e uma instancia de FUNCIONARIO
                else if (pessoa is Funcionario)
                {
                    //"ve" o usuario como vendedor
                    Funcionario funcionario = pessoa as Funcionario;
                    //comando para inserir um vendedor
                    Cmd.CommandText =
                        @"insert into funcionarios values (@id, @setor, @fiscal, 1);";
                    //adiciona valor as variaveis
                    Cmd.Parameters.AddWithValue("@id", funcionario.Id); 
                    Cmd.Parameters.AddWithValue("@setor", funcionario.Setor); //@setor vai armazenar oque o usuario digitar na tela
                    Cmd.Parameters.AddWithValue("@fiscal", funcionario.Fiscal);
                    //executa o comando
                    Cmd.ExecuteNonQuery();
                }
                //commit na transacao
                tran.Commit();

                res = pessoa;
            }
            catch
            {
                //desfaz a transacao
                tran.Rollback();
            }
            return res;

        }  

        // -------------------------------------------------------------------------

        // -------------------------------------------------------------------------

        //      OBTER LOGIN DADOS DO LOGIN
        public Pessoa RecuperarSenha(string email)
        {

            Pessoa pessoa = new Pessoa();
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select SENHA, NOME from logins l, pessoas p where EMAIL = @email and l.PESSOA_ID = p.ID";

                Cmd.Parameters.AddWithValue("@email", email);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    pessoa.Senha = Dr.GetString(0);
                    pessoa.Nome = Dr.GetString(1);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return pessoa;
        }

        //      EDITAR PESSOA
        public bool EditarPessoa(Pessoa pessoa)
        {

            //objeto conexao
            //Connection conexao = new Connection();
            //declara a transacao
            SqlTransaction tran = null;

            //variavel para o retorno
            bool ok = false;

            try
            {
                //abrir a conexao
                //AbrirConexao();
                //inicar a transacao
                tran = Cnn.BeginTransaction();
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //comando sql
                Cmd.CommandText = @"update pessoas set NOME = @nome, RG = @rg, CIDADE = @cidade, SENHA = @senha where ID = @id;";

                //atribui valores para as variaveis
                Cmd.Parameters.AddWithValue("@nome", pessoa.Nome);
                Cmd.Parameters.AddWithValue("@rg", pessoa.Rg);
                Cmd.Parameters.AddWithValue("@cidade", pessoa.Cidade);
                Cmd.Parameters.AddWithValue("@senha", pessoa.Senha);
                if (pessoa.Id == 0)
                {
                    Funcionario funcionario = pessoa as Funcionario;
                    int id = funcionario.ID_Funcionario;
                    Cmd.Parameters.AddWithValue("id", id);
                }
                else
                {
                    Cmd.Parameters.AddWithValue("@id", pessoa.Id);
                }
                

                //executa
                Cmd.ExecuteNonQuery();


                //verifica a intancia do objeto LOGIN
                if (pessoa is Login)
                {
                    //"ve" o objeto usuario como cliente
                    Login login = pessoa as Login;
                    login.Id = pessoa.Id;
                    //comando sql para cliente
                    Cmd.CommandText = @"update logins set EMAIL = @email where PESSOA_ID = @id_login;";

                    //atribui valor a variavel
                    Cmd.Parameters.AddWithValue("@id_login", login.Id);
                    Cmd.Parameters.AddWithValue("@email", login.Email);

                    //executa o comando
                    Cmd.ExecuteNonQuery();
                }
                //verifica se e intancia de FUNCIONARIO
                else if (pessoa is Funcionario)
                {
                    //"ve" o objeto usuario como vendedor
                    Funcionario funcionario = pessoa as Funcionario;
                    //comando sql de vendedor
                    Cmd.CommandText = @"update funcionarios set FISCAL = @fiscal, SETOR = @setor where PESSOA_ID = @id_funci;";
                    //atribui valor as variaveis
                    Cmd.Parameters.AddWithValue("@fiscal", funcionario.Fiscal);
                    Cmd.Parameters.AddWithValue("@setor", funcionario.Setor);
                    Cmd.Parameters.AddWithValue("@id_funci", funcionario.Id);
                    //executa o comando sql
                    Cmd.ExecuteNonQuery();
                }

                //encerra a transacao
                tran.Commit();

                //altera o retorno
                ok = true;
            }
            catch {  }
            return ok;
        } 

        // -------------------------------------------------------------------------

        //      EXCLUIR PESSOA
        public bool ExcluirPessoa(Pessoa pessoa)
        {
            //objeto conexao
            //Connection conexao = new Connection();
            //declara a transacao
            SqlTransaction tran = null;

            //variavel para o retorno
            bool ok = false;

            try
            {
                //abre a conexao
                //AbrirConexao();
                //inicia a transacao
                tran = Cnn.BeginTransaction();
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;
                //atribui a transacao ao command
                Cmd.Transaction = tran;
                //verifica a instancia do objeto usuario

                if (pessoa is Login)
                {
                    //comando para deletar um cliente
                    Cmd.CommandText = @"delete from logins where PESSOA_ID = @id_login;";
                }
                //verifica se e vendedor
                else if (pessoa is Funcionario)
                {
                    //comando para deletar vendedor
                    Cmd.CommandText = @"delete from funcionarios where PESSOA_ID = @id_funci;";
                }
                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@id", pessoa.Id);


                //executa o comando sql
                Cmd.ExecuteNonQuery();
                //comando para deletar usuario
                Cmd.CommandText = @"delete from pessoas where ID = @id;";


                //atribui valor a @codigo
                Cmd.Parameters.AddWithValue("id", pessoa.Id);

                Cmd.ExecuteNonQuery();

                //encerra a transacao
                tran.Commit();

                ok = true;
            }
            catch
            {
                //desfaz a transacao
                tran.Rollback();
            }
            return ok;
        }           

        // -------------------------------------------------------------------------

        //      Obter PESSOA
        public Pessoa ObtemPessoa(int id)
        {
            Pessoa pessoa = null;
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;

                //comando para deletar um cliente
                Cmd.CommandText = @"select * from pessoas where ID = @id";

                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@id", id);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if(Dr.Read())
                {
                    pessoa = new Pessoa();
                    pessoa.Id = Dr.GetInt32(0);
                    pessoa.Nome = Dr.GetString(1);
                    pessoa.Rg = Dr.GetString(2);
                    pessoa.Cidade = Dr.GetString(3);

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return pessoa;

        }

        // -------------------------------------------------------------------------

        //      Obter PESSOA
        public Pessoa ObtemPessoaLogin(string nome, string senha)
        {
            Pessoa pessoa = null;
            try
            {
                //declara o command
                Cmd = new SqlCommand();
                //atribui a conexao ao command
                Cmd.Connection = Cnn;

                //comando para deletar um cliente
                Cmd.CommandText = @"select * from pessoas where NOME = @nome and SENHA = @senha";

                //atribui valor para @id
                Cmd.Parameters.AddWithValue("@nome", nome);
                Cmd.Parameters.AddWithValue("@senha", senha);

                //executa o comando sql
                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    pessoa = new Pessoa();
                    pessoa.Id = Dr.GetInt32(0);
                    pessoa.Nome = Dr.GetString(1);
                    pessoa.Rg = Dr.GetString(2);
                    pessoa.Cidade = Dr.GetString(3);

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return pessoa;

        }


        // -------------------------------------------------------------------------

        //      BUSCA PLACA TESTE
        public Pessoa BuscaPlaca(string placa)
        {
            Pessoa pessoa = null;
            try
            {
                Cmd = new SqlCommand();
                Cmd.Connection = Cnn;
                Cmd.CommandText = @"select * from pessoas p, logins l, veiculos v where p.ID = l.PESSOA_ID and l.PESSOA_ID =v.LOGIN_ID and v.PLACA = @placa";

                Cmd.Parameters.AddWithValue("@placa", placa);

                Dr = Cmd.ExecuteReader();

                if (Dr.Read())
                {
                    pessoa = new Pessoa();
                    pessoa.Id = Dr.GetInt32(0);
                    pessoa.Nome = Dr.GetString(1);
                    pessoa.Rg = Dr.GetString(2);
                    pessoa.Cidade = Dr.GetString(3);
                    
                }
                else
                {
                    pessoa = null;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return pessoa;
        }

        // -------------------------------------------------------------------------

        private Pessoa PessoaByDr(SqlDataReader Dr)
        {
            Pessoa pessoa = new Pessoa();
            pessoa.Nome = Dr.GetString(1);
            pessoa.Rg = Dr.GetString(2);
            pessoa.Cidade = Dr.GetString(3);

            return pessoa;
        }  
    }
}
