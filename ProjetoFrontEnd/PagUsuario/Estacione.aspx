<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Estacione.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.Estacione" %>
<%@ Register Src="~/CountDown.ascx" TagPrefix="uc1" TagName="countdown" %>

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
          
        <div class="container-fluid" runat="server">

            <div class="row col-md-offset-3 col-md-9 altura" style="font-size: 13px;">
                <br />
                <h5>
                    Para Estacionar escolha um périodo de tempo.
                    <br />

                </h5>
                <br />           
            </div>


            <div class="row branco">
                <asp:RadioButtonList ID="rblist1" ValidationGroup="chkbox" runat="server" CssClass="altura RadioButton1 col-md-offset-3 col-md-3 col-xs-offset-1 col-xs-11">
                    <asp:ListItem>R$01,50 - 01:00 - 1 Hora</asp:ListItem>
                    <asp:ListItem>R$02,00 - 01:30 - 1 Hora e 30 minutos</asp:ListItem>
                    <asp:ListItem>R$02,50 - 02:00 - 2 Horas</asp:ListItem>
                    <asp:ListItem>R$03,00 - 02:30 - 2 Horas e 30 minutos</asp:ListItem>
                    <asp:ListItem>R$03,50 - 03:00 - 3 Horas</asp:ListItem>
                </asp:RadioButtonList>
                    
            </div>

            <div class="row">
                <asp:RequiredFieldValidator CssClass="col-md-offset-3" ValidationGroup="chkbox" ID="RequiredFieldValidator1" runat="server" Font-Italic="true" Text="Por favor, selecione um valor!" ControlToValidate="rblist1" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
            </div>


            <div class="row fonte">
                <div class="col-md-offset-3 col-md-3 col-xs-offset-3">
                    <asp:Label ID="lblplaca" runat="server" Text="" CssClass=""></asp:Label>
                </div>
                <div class="col-xs-offset-3">
                    <asp:Label runat="server" ID="lblsaldo" Text="" CssClass=""></asp:Label>
                </div>
            </div>

            <div class="row">
                <asp:Label ID="lblerro" runat="server" Text="Você não possui saldo suficiente para realizar esta compra!" Visible="false" Font-Size="Medium" Font-Bold="true" Font-Italic="true" CssClass="text-center text-danger col-md-12 col-xs-12"></asp:Label>
            </div>
            <div class="row">                
                <asp:Button runat="server" id="btnEstacionar" CausesValidation="true" ValidationGroup="chkbox" Text="Estacionar" CssClass="btnconfirmarr col-xs-offset-3 col-xs-6" OnClick="btnEstacionar_Click"/>
            </div>
            
            <div class="text-center center-block chk nomeperfil" style=" font-size:x-large !important; font-weight:bold">
                <uc1:countdown ID="countDown1" runat="server" />
            </div>


            <div class="row centralizar center-block text-center" style="margin-top:-20px">
                <a href="Compra.aspx" >
                    <h1 class="hidden-sm hidden-xs">
                        Adquira mais créditos!!
                    </h1>
                    <h4 class="hidden-md hidden-lg">
                        Adquira mais créditos!!
                    </h4>
                </a>
            </div>

            <br /><br />
            
            <div class="center-block text-center">
                <asp:Panel ID="pnlerro" runat="server" CssClass="alert alert-danger text-center center-block" Visible ="false" Width="60%">           
                    <asp:Label ID="lblerrofiscal" runat="server"  visible="false" Text="Erro ao realizar a parada"></asp:Label><br />
                </asp:Panel>
            </div>

        </div>
    <% } %>
</asp:Content>
