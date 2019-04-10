<%@ Page Title="" Language="C#" MasterPageFile="~/SemEdit.Master" AutoEventWireup="true" CodeBehind="Recuperar.aspx.cs" Inherits="ProjetoFrontEnd.PagUsuario.Recuperar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="container-fluid" style="width: 95%">
        <br /><br />
        <div class="center-block jumbotron" style="padding-left: 10%;">
            <h2>Recuperação de senha.</h2>
            <h4>Por favor, digite seu e-mail abaixo.</h4>

            <asp:Panel ID="recuperar" runat="server" DefaultButton="tbnrecuperar">
                <asp:TextBox ID="txtemail" runat="server" TextMode="Email" CssClass="txtlogin" Width="250px"></asp:TextBox>  
                <br />
                <asp:RequiredFieldValidator  ID="RequiredFieldValidator2" runat="server" ErrorMessage="O campo é obrigatório" 
                    Text="Campo obrigatório" ControlToValidate="txtemail" ForeColor="Red" Font-Size="Small" 
                    Font-Italic="true"></asp:RequiredFieldValidator>
                <br />
                <asp:Button ID="tbnrecuperar" CssClass="btn btn-danger" runat="server" Text="Recuperar" OnClick="tbnrecuperar_Click" />
                <asp:Button ID="btnvoltar" CssClass="btn btn-default" runat="server" Text="Voltar" OnClick="btnvoltar_Click" />
            </asp:Panel>
            <br /><br />

            <asp:Panel ID="Panelerro" runat="server" CssClass="alert alert-danger" Visible ="false">
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Error:</span>
                E-mail inválido.
            </asp:Panel>
        </div>
    </div>
</asp:Content>
