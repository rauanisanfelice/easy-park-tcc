<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="VendaParada.aspx.cs" Inherits="ProjetoFrontEnd.PagFuncionario.VendaParada" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <% if (Session["func"] == null)
    { %>
        <br /><br /><br /><br /><br /><br />
        <h3 class="text-center center-block" style="color:red; font-style:italic;">Você não está logado, portanto não pode ver este conteúdo!</h3>
        <br /><br /><br />
        <div class="text-center center-block">
            <asp:Button ID="Button1" runat="server" Text="Página inicial" CssClass="btnfun btnbusca" Width="150px" OnClick="Button1_Click"/>
        </div>

    <% } else { %>
    <script src="../res/js/mascaras.js"></script>
    <div class="container-fluid" runat="server">
        <asp:Panel id="venda" runat="server" DefaultButton="btnEstacionar">
            <div class="row">
                <div class="center-block" style="margin-top: 3%">
                    <asp:RadioButtonList ID="rblist1" ValidationGroup="chkbox" runat="server" CssClass="altura RadioButton1 col-md-offset-4 col-xs-offset-1 col-md-offset-5">
                        <asp:ListItem>R$01,50 - 01:00 - 1 Hora</asp:ListItem>
                        <asp:ListItem>R$02,00 - 01:30 - 1 Hora e 30 minutos</asp:ListItem>
                        <asp:ListItem>R$02,50 - 02:00 - 2 Horas</asp:ListItem>
                        <asp:ListItem>R$03,00 - 02:30 - 2 Horas e 30 minutos</asp:ListItem>
                        <asp:ListItem>R$03,50 - 03:00 - 3 Horas</asp:ListItem>
                    </asp:RadioButtonList> 
                </div>
                
            </div>
            <div class="row">
                <asp:RequiredFieldValidator CssClass="center-block text-center" ValidationGroup="chkbox" ID="RequiredFieldValidator1" 
                    runat="server" Text="Por favor, selecione um valor!" ControlToValidate="rblist1" 
                    ForeColor="Red" Font-Italic="true" Font-Size="Medium"></asp:RequiredFieldValidator>
            </div>

            <div class="row fonte center-block text-center">          
                <div class="">
                    <asp:Label ID="Label1" runat="server" Text="Placa"></asp:Label>
                    <asp:TextBox ID="txtplaca" runat="server" placeholder="Ex: AAA-1234" onkeyup="mascara(this, event)" onfocus="moveToEnd(this)" onclick="moveToEnd(this)" CssClass="pesquisa" style="margin-left:0px!important; width:150px !important; padding-left:10px;"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="center-block text-center" ValidationGroup="chkbox" ID="RequiredFieldValidator3" 
                        runat="server" Text="Por favor, digite uma placa!" ControlToValidate="txtplaca" 
                        ForeColor="Red" Font-Italic="true" Font-Size="Medium"></asp:RequiredFieldValidator>
                </div>          
            </div>
         </asp:Panel>
        <div class="row">                
            <asp:Button runat="server" id="btnEstacionar" CausesValidation="true" ValidationGroup="chkbox" Text="Estacionar" CssClass="btnconfirmarr text-center center-block" OnClick="btnEstacionar_Click"/>
        </div>

        <asp:Panel ID="PanelSucesso" runat="server" CssClass="alert alert-success text-center center-block" Visible ="false" Width="500px">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <span class="sr-only">Sucesso:</span>       
                Parada realizada com sucesso!!
        </asp:Panel>

        <asp:Panel ID="Panelerro" runat="server" CssClass="alert alert-danger text-center center-block" Visible ="false" Width="500px">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <span class="sr-only">Erro:</span>       
                Erro! Usuário não pode realizar uma parada.        
        </asp:Panel>
    </div>
    <% } %>
</asp:Content>
