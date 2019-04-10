using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class VeiculoModel
    {
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public VeiculoModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //      INSERIR VEICULO    

        public void InserirVeiculos(Veiculo veiculo)
        {
            using (VeiculoData data = new VeiculoData(strConexao))
            {
                data.InserirVeiculos(veiculo);
            }
        }


        //      EDITAR VEICULO

        public bool EditarVeiculo(Veiculo veiculo)
        {
            using (VeiculoData data = new VeiculoData(strConexao))
            {
                return data.EditarVeiculo(veiculo);
            }
        }


        //      OBTER VEICULO PLACA

        public Veiculo ObterVeiculo(string placa)
        {
            using (VeiculoData data = new VeiculoData(strConexao))
            {
                return data.ObterVeiculo(placa);
            }
        }

        //      OBTER VEICULO ID da pessoa

        public Veiculo ObterVeiculo(int id)
        {
            using (VeiculoData data = new VeiculoData(strConexao))
            {
                return data.ObterVeiculo(id);
            }
        }

        //      OBTER VEICULO ID do veiculo

        public Veiculo ObteridVeiculo(int id)
        {
            using (VeiculoData data = new VeiculoData(strConexao))
            {
                return data.ObteridVeiculo(id);
            }
        }

        //      PEGA PLACA DO VEICULO E VERIFICA SE JA REALIZOU PARADA  
        public bool ValidaPlaca (string placa)
        {
            using (VeiculoData data = new VeiculoData(strConexao))
            {
                return data.ValidaPlaca(placa);
            }
        }
    }
}
