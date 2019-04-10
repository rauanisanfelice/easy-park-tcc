<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Historico.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.historico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../res/js/mascaras.js"></script>
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

        <div class="container-fluid branco">

            <%--ABA DE PESQUISA--%>
            <asp:Panel id="pesquisa" runat="server" DefaultButton="btnpesquisar">
                <div class="row branco">
                    <div class=" text-center">
                        <asp:TextBox ID="txtpesquisa1" runat="server" CssClass="pesquisa1 imgpesquisa" onkeypress="return Mascara(this, Data)" 
                            placeholder="Ex: 02/02/2012" MaxLength="10"></asp:TextBox>                       
                        <asp:Button ID="btnpesquisar" runat="server" Text="Pesquisar" OnClick="btnpesquisar_Click" CssClass="btnfun btnbusca" Width="100px"/>
                        <asp:Button ID="btnlimpar" runat="server" Text="Limpar" OnClick="btnlimpar_Click" CssClass="btnfun btnbusca " Width="100px"/>
                    </div>
                </div>
            </asp:Panel>
            <div class="row  text-center center-block">
                <div class="btn-group" role="group" aria-label="...">
                    <asp:Button ID="tbnparadas" runat="server" Text="Paradas" CssClass="btn btn-default btnsair historico" Width="170px" OnClick="tbnparadas_Click"/>
                    <asp:Button ID="tblcompras" runat="server" Text="Compras" CssClass="btn btn-default btnsair historico" Width="170px" OnClick="tblcompras_Click"/>
                </div>
            </div>
            
            <div class="text-right alinhamentdi" style="margin-right: 16%; margin-top: 10px;">
                <asp:Label ID="lbltotal" runat="server" Font-Size="Medium" ForeColor="Black" Font-Bold="true" Text=""></asp:Label>
            </div>
            
            <br /><br />

            <asp:Repeater ID="listahistorico" runat="server" OnItemCommand="listahistorico_ItemCommand">
                <HeaderTemplate>
                    <div class="row text-center">
                        <asp:Label ID="lblatencao" runat="server" Text="Histórico de paradas" CssClass="txtinfo margem"></asp:Label>
                    </div>
                    <br /><br />
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="row branco">
                        <div class="row altura col-md-offset-2">                            
                            <%--DATA--%>
                            <asp:Label ID="lbldata" runat="server" Text="" CssClass="margem col-xm-12 txthist"
                                    ViewStateMode="Inherit">Data:<%# ((ProjetoBackEnd.Entity.Parada)Container.DataItem).DATA_PARA.ToShortDateString() %> </asp:Label>
                        </div>
                        <div class="row altura col-md-offset-2">
                            <%--HORA INICIAL DA PARADA--%>
                            <asp:Label ID="Label1" runat="server" Text="" CssClass="col-md-offset-5 margem col-xm-12 txthist"
                                ViewStateMode="Inherit">Hora inicial:<%# ((ProjetoBackEnd.Entity.Parada)Container.DataItem).DATA_PARA.ToShortTimeString() %> </asp:Label>                                                
                        </div>    
                        <div class="row altura col-md-offset-2">
                        <%-- MOSTRA DETALHES --%>
                            <asp:HyperLink ID="hplExibir" CssClass="col-md-offset-5 margem col-xm-12 txthist" runat="server" 
                                NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "ID_PARADA", "Detalheshisotico.aspx?ID_PARADA={0}") %>'>Exibir mais detalhes</asp:HyperLink>         
                        </div>
                        <%--DIVIDE--%>
                        <div class="row branco col-md-12">
                            <hr class="separar"/>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate></FooterTemplate>
            </asp:Repeater>
        </div>

    <br /> <br /> <br /> <br />

    <asp:Label ID="lblnada" runat="server" CssClass="text-center center-block" Text="Não possui paradas" Font-Size="X-Large" ForeColor="Black" Font-Italic="true" Visible="false"></asp:Label>
    <% } %>
</asp:Content>
