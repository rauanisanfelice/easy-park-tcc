<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.Menu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <% if (Session["login"] == null) { %>
        <br /><br /><br /><br /><br /><br />
        <h3 class="text-center center-block" style="color:red; font-style:italic;">Você não está logado, portanto não pode ver este conteúdo!</h3>
        <br /><br /><br />
        <div class="text-center center-block">
            <asp:Button ID="Button1" runat="server" Text="Página inicial" CssClass="btnfun btnbusca" Width="150px" OnClick="Button1_Click"/>
        </div>
    <% } else { %>

        <div class="container-fluid">

           <%-- TAMANHO PEQUENOOOOO--%>
            <div id="TamanhoPequeno" class="hidden-md hidden-lg">
                <%--COMPRA / ESTACIONE--%>
                <div class="row branco" runat="server">

                    <div class="col-xs-6 col-xs-6">
                        <a href="Compra.aspx">
                            <img class="menuimg" src="../res/img/Compra.png" />
                        </a>
                    </div>
                    <div class="col-xs-2">
                        <a href="Estacione.aspx">
                            <img class="menuimg" src="../res/img/Estacione.png" />
                        </a>
                    </div>
                </div>

                <%--NOTIFICAÇÃO / HISTORICO--%>
                <div class="row branco" runat="server">

                    <div class="col-xs-6">
                        <a href="historico.aspx">
                            <img class="menuimg" src="../res/img/historico.png"/>
                        </a>
                    </div>
                    <div class="col-xs-2">
                        <a href="historico.aspx">
                            <asp:Image ID="notifica" runat="server"  ImageUrl="~/res/img/notificacao.png" Visible="true" CssClass="menuimg"/>
                            <asp:Image ID="notificaatencao" runat="server" ImageUrl="~/res/img/notificacaoAtencao.png" Visible="false"  CssClass="menuimg"/>
                        </a>
                    </div>
                </div>

                <%--INFORMAÇÕES / CONFIGURAÇÕES--%>
                <div class="row branco" runat="server">

                    <div class="col-xs-6">
                        <a href="Informacoes.aspx">
                            <img class="menuimg" src="../res/img/informacoes.png" />
                        </a>
                    </div>
                    <div class="col-xs-2">
                        <a href="configuracao.aspx">
                            <img class="menuimg" src="../res/img/Configuracao.png" />
                        </a>
                    </div>
                </div>
            </div>


            <div id="TamanhoMedio" class="hidden-sm hidden-xs">
                <%-- COMPRA / ESTACIONE / HISTORICO--%>
                <div class="row branco" runat="server">
                    <%-- COMPRA --%>
                    <div class="col-xs-offset-2 col-xs-3">
                        <a href="Compra.aspx">
                            <img class="menuimg" src="../res/img/Compra.png" />
                        </a>
                    </div>
                    <%-- ESTACIONE --%>
                    <div class="col-xs-3">
                        <a href="Estacione.aspx">
                            <img class="menuimg" src="../res/img/Estacione.png" />
                        </a>
                    </div>
                    <%-- HISTORICO --%>
                    <div class="col-xs-3">
                        <a href="historico.aspx">
                            <img class="menuimg" src="../res/img/Historico.png" />
                        </a>
                    </div>
                </div>

                <%--NOTIFICAÇÃO / INFORMAÇÕES / CONFIGURAÇÕES --%>
                <div class="row branco" runat="server">
                    <%-- NOTIFICAÇÃO --%>
                    <div class="col-xs-offset-2 col-xs-3">
                        <a href="notificacoe.aspx">
                            <asp:Image ID="notificaatencao1" runat="server"  ImageUrl="~/res/img/notificacaoAtencao.png" Visible="false" CssClass="menuimg"/>
                            <asp:Image ID="notifica1" runat="server" ImageUrl="~/res/img/notificacao.png" Visible="true" CssClass="menuimg"/>
                        </a>
                    </div>
                    <%-- INFORMAÇÕES --%>
                    <div class="col-xs-3">
                        <a href="Informacoes.aspx">
                            <img class="menuimg" src="../res/img/informacoes.png" />
                        </a>
                    </div>
                    <%-- CONFIGURAÇÕES --%>
                    <div class="col-xs-3">
                        <a href="configuracao.aspx">
                            <img class="menuimg" src="../res/img/Configuracao.png" />
                        </a>
                    </div>
                </div>
            </div>

        </div>
    <% } %>
</asp:Content>
