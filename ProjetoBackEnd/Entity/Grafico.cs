using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBackEnd.Entity
{
    public class Grafico
    {
        //declara as propriedades
        public int Q_Parada { get; set; }
        public int Q_Notificacao { get; set; }
        public int Q_Compra { get; set; }
        public decimal T_Arrecadado { get; set; }
        public DateTime Ano { get; set; }
        public DateTime Mes { get; set; }
        public DateTime ValidacaoAno { get; set; }

        //contrutor
        public Grafico() { }

        public Grafico(int q_parada, int q_notificacao, int q_compra, decimal t_arrecadadode, DateTime ano, DateTime mes, DateTime validacaoano) 
        {
            Q_Parada = q_parada;
            Q_Notificacao = q_notificacao;
            Q_Compra = q_compra;
            T_Arrecadado = t_arrecadadode;
            Ano = ano;
            Mes = mes;
            ValidacaoAno = validacaoano;
        }

    }
}
