<%@ Page Title="" Language="C#" MasterPageFile="~/SemEdit.Master" AutoEventWireup="true" CodeBehind="ConfirmarEmail.aspx.cs" Inherits="ProjetoFrontEnd.PagUsuario.ConfirmarEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="container-fluid">
        
        <br /><br />
        <asp:Panel ID="pnlconfirmar" runat="server">
            <br /><br /><br /><br />
            <div class="jumbotron text-center center-block" style="width: 55%">
                Obrigado por fazer o cadastro no Easy Park!
                <br />
                Confirme seu e-mail para realizar suas paradas.
                <br /><br />
                <asp:Button ID="btnconfirmar" runat="server" Text="Confirmar" CssClass="btn btn-success"  OnClick="confirmar_Click"/>

                <asp:Panel ID="pnlerro" runat="server" class="alert alert-danger" Visible="false">
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <span class="sr-only">Erro:</span>
                    Erro ao confirmar o e-mail!
                </asp:Panel>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
