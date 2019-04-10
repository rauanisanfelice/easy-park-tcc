<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Informacoes.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.Informacoes" %>
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

        <div class="container-fluid branco altura" runat="server">

            <br /><br />

            <div class="row center-block text-center">       
                <div class="row col-md-12 col-xs-12">
                    <asp:Label ID="lblinformacoes" runat="server" Text="Horário de funcionamento" CssClass="txtinformacao"></asp:Label>
                </div>

                <div class="row col-md-12 col-xs-12">
                    <asp:Label ID="Label1" runat="server" Text="Segunda à Sexta" CssClass="txtinfo1"></asp:Label>
                </div>
                <div class="row col-md-12 col-xs-12">
                    <asp:Label ID="Label3" runat="server" Text="08:00 às 18:00" CssClass="txtinfo2"></asp:Label>
                </div>

                <div class="row col-md-12 col-xs-12">
                    <asp:Label ID="Label2" runat="server" Text="Sábados" CssClass="txtinfo1"></asp:Label>
                </div>
                <div class="row col-md-12 col-xs-12">
                    <asp:Label ID="Label4" runat="server" Text="08:00 às 12:00" CssClass="txtinfo2"></asp:Label>
                </div>     
            </div> 
            
            <img src="../res/img/informacoesdoep.png" class="center-block text-center" style="height:100%;width:100%; "/>
              
        </div>
    <% } %>
</asp:Content>
