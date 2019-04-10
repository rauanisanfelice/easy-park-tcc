using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ProjetoBackEnd.Entity;
using ProjetoBackEnd.Data;

namespace ProjetoBackEnd.Model
{
    public class GraficoModel
    {
        //  ATRIBUTO
        private string strConexao;

        //  CONSTRUTOR
        public GraficoModel(string strConexao)
        {
            this.strConexao = strConexao;
        }

        // -------------------------------------------------------------------------

        //      INSERIR COMPRA
        public Grafico ObterArrecadacao(Grafico grafico)
        {
            using (GraficoData data = new GraficoData(strConexao))
            {
                return data.ObterArrecadacao(grafico);
            }
        }

        // -------------------------------------------------------------------------

        //      LISTA FUNCIONARIO

        public List<Grafico> ListaAnosGrafico()
        {
            using (GraficoData data = new GraficoData(strConexao))
            {
                return data.ListaAnosGrafico();
            }
        }

    }
}
