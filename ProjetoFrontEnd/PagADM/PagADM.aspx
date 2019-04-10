<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="PagADM.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.PagADM" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
 
    <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
    <script src="http://cdn.oesmith.co.uk/morris-0.4.1.min.js"></script>
    <link href="../res/css/morris.css" rel="stylesheet" />

    <script type="text/javascript">

<%--    var x1 = document.getElementById('<%= hddparadas.ClientID %>');
        var x2 = document.getElementById('<%= hddinfracao.ClientID %>');--%>

        var url = window.location.href;
        var url_atual = url.split("?")[1];
        var listaDeParametros = url_atual.split("&");
        

        var hash = {}
        for(var i = 0; i < listaDeParametros.length; i++){
            var parametro = listaDeParametros[i].split("=");
            var chave = parametro[0];
            var valor = parametro[1];
            hash[chave] = valor;
        }

        $(document).ready(function () {
            Morris.Bar({
                element: 'bar-example',
                data: [
                            { x: 'Paradas',     y: hash["qtdpar"] },
                            { x: 'Infrações',   y: hash["qtdinfra"] },
                ],
                xkey: 'x',
                ykeys: ['y'],
                labels: ['Total'],
                resize: 'true',
                hideHover: 'auto',
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <% if (Session["adm"] == null)
       { %>
        <br /><br /><br /><br /><br /><br />
        <h3 class="text-center center-block" style="color:red; font-style:italic;">Você não está logado, portanto não pode ver este conteúdo!</h3>
        <br /><br /><br />
        <div class="text-center center-block">
            <asp:Button ID="Button1" runat="server" Text="Página inicial" CssClass="btnfun btnbusca" Width="150px" OnClick="Button1_Click"/>
        </div>
    <% } else { %>
        <div class="container-fluid">
            <br />
            <asp:Label ID="lblescolha" runat="server" Text="Por favor escolha um ano e um mês." CssClass="col-md-offset-1 col-xs-offset-1"></asp:Label>
            <br /><br />
            <%--CONTROLE DOS GRÁFICOS--%>
            <div class="row">

                <div class="col-md-5">
                    <%--ANO--%>
                    <div class="col-md-offset-2 col-md-3 col-sm-offset-1 col-sm-3 col-xs-offset-2 col-xs-3">
                        <div class="dropdown" role="group">

                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                ANO
                                <span class="caret"></span>
                            </button>

                            <ul class="dropdown-menu">
                                <li><asp:Button ID="btnresumo" runat="server" Text="Dados de todos os anos" CssClass="sair" OnClick="resumo_Click"/></li>
                                <li>
                                    <asp:Repeater ID="listaanos" runat="server">
                                        <ItemTemplate>
                                            <a href="/PagADM/PagADM.aspx?qtdpar=-1&qtdinfra=-1&ANO=<%# ((ProjetoBackEnd.Entity.Grafico)Container.DataItem).ValidacaoAno.Year %>&MES=-1"> 
                                                <%# ((ProjetoBackEnd.Entity.Grafico)Container.DataItem).ValidacaoAno.Year %> </a>                  
        
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <%--MES--%>
                    <div class="col-md-3 col-sm-2">
                        <div class="dropdown" role="group">
                    
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            MÊS
                            <span class="caret"></span>
                        </button>

                        <ul class="dropdown-menu">
                            <li><asp:Button ID="brnresumo1" runat="server" Text="Dados de todos os mês" CssClass="sair" OnClick="resumomes_Click"/></li>
                            <li><asp:Button ID="btnjaneiro" runat="server" Text="Janeiro" CssClass="sair" OnClick="jan_Click"/></li>
                            <li><asp:Button ID="btnfevereiro" runat="server" Text="Fevereiro" CssClass="sair" OnClick="fev_Click"/></li>
                            <li><asp:Button ID="btnmarco" runat="server" Text="Março" CssClass="sair" OnClick="mar_Click"/></li>
                            <li><asp:Button ID="btnabril" runat="server" Text="Abril" CssClass="sair" OnClick="abr_Click"/></li>
                            <li><asp:Button ID="btnmaio" runat="server" Text="Maio" CssClass="sair" OnClick="mai_Click"/></li>
                            <li><asp:Button ID="btnjunho" runat="server" Text="Junho" CssClass="sair" OnClick="jun_Click"/></li>
                            <li><asp:Button ID="btnjulho" runat="server" Text="Julho" CssClass="sair" OnClick="jul_Click"/></li>
                            <li><asp:Button ID="btnagosto" runat="server" Text="Agosto" CssClass="sair" OnClick="ago_Click"/></li>
                            <li><asp:Button ID="btnsetembro" runat="server" Text="Setembro" CssClass="sair" OnClick="set_Click"/></li>
                            <li><asp:Button ID="btnoutubro" runat="server" Text="Outubro" CssClass="sair" OnClick="out_Click"/></li>
                            <li><asp:Button ID="btnnovembro" runat="server" Text="Novembro" CssClass="sair" OnClick="nov_Click"/></li>
                            <li><asp:Button ID="btndezembro" runat="server" Text="Dezembro" CssClass="sair" OnClick="dez_Click"/></li>
                        </ul>
                    </div>
                    </div>
                </div>
 
                <%-- DETALHES SOBRE A ESCOLHA DO USUÁRIO --%>
                <div class="col-md-5 col-xs-offset-1">
                    <asp:Label ID="lbll" runat="server" Text="Ano selecionado:" CssClass="col-md-offset-1"></asp:Label>
                    <asp:Label ID="lblAnoSelecionado" runat="server" Text="" CssClass=""></asp:Label>
                    <asp:Label ID="lblll" runat="server" Text="Mês selecionado:" CssClass="col-md-offset-1"></asp:Label>
                    <asp:Label ID="lblMesSelecionado" runat="server" Text="" CssClass=""></asp:Label>
                </div>
            </div>

            <%--GRÁFICOS E TABELA DE DADOS--%>
            <div class="row">
                <%--GRÁFICO MORRIS--%>
                <div id="bar-example" class="col-md-4 col-md-offset-1 col-xs-offset-1 col-xs-11" style="height: 450px"></div>

                <asp:HiddenField ID="hddparadas" runat="server"  />
                <asp:HiddenField ID="hddinfracao" runat="server" />

                <%--TABELA DOS DADOS--%>
                <div class="col-md-3 col-xs-12 col-xs-offset-3" style="margin-top: 6%">
                    <asp:Table ID="tblFuncionario" runat="server" BorderColor="Black"> 
                        <asp:TableRow runat="server">
                            <asp:TableCell BorderWidth="1" CssClass="espacotabela">1- Total de paradas:</asp:TableCell>
                            <asp:TableCell BorderWidth="1" CssClass="text-center margemtexto" ID="qtdparadas" Text=""></asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow runat="server" ID="row1">
                            <asp:TableCell BorderWidth="1" CssClass="espacotabela">2- Total de infrações:</asp:TableCell>
                            <asp:TableCell BorderWidth="1" CssClass="text-center margemtexto" ID="qtdinfra" Text=""></asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow runat="server" ID="TableRow1">
                            <asp:TableCell BorderWidth="1" CssClass="espacotabela">3- Parada/Infração: </asp:TableCell>
                            <asp:TableCell BorderWidth="1" CssClass="text-center margemtexto" ID="qtdresult" Text=""></asp:TableCell>
                        </asp:TableRow>

                        <asp:TableRow runat="server" ID="TableRow2">
                            <asp:TableCell BorderWidth="1" CssClass="espacotabela">4- Total arrecadado: </asp:TableCell>
                            <asp:TableCell BorderWidth="1" CssClass="text-center margemtexto" ID="qtdarrecadado" Text=""></asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </div>
        </div>
    <% } %>

</asp:Content>


