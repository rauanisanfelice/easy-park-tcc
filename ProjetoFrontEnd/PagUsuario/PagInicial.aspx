<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="PagInicial.aspx.cs" Inherits="ProjetoFrontEnd.cadastro.pagInicial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script  type="text/javascript">
        var url = window.location.href;
        var url_atual = url.split("msg")[1];

        if (url_atual == 0) {
            window.alert("Cadastro efetuado com suceso! Por favor confirmar seu e-mail antes de realizar o login!!");
            window.location.href = "http://localhost:35192/PagUsuario/PagInicial.aspx";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    
    <div style="background: url('../res/img/fundowebinicial.png'); width:100%; height: 100%; min-height:750px !important;">

        <br /><br />
        
        <%--Imagem Logo--%>
        <div class="row">
            <img src="../res/img/logo1.png" class=" hidden-sm hidden-md hidden-lg center-block centralizar text-center" style="width: 150px; height: 150px;;"/>
            <img src="../res/img/logo1.png" class=" hidden-xs hidden-lg center-block centralizar text-center" style="width: 250px; height: 250px;"/>
            <img src="../res/img/logo1.png" class=" hidden-xs hidden-sm hidden-md center-block centralizar text-center" style="width: 350px; height: 350px;"/>
        </div>

        <br /><br />
        <div class="row">
            <div class="center-block centralizar text-center">
                <asp:Label ID="lbleasypark" runat="server" CssClass="txtcenter center-block centralizar text-center" Text="Easy Park"></asp:Label>
            </div>
        </div>
        <br />
    </div>

    <%-- txtoque1 --%>
    <div style="" class="">
        <a href="Oquee.aspx" style="text-decoration:none;" class="txtoque1 navbar navbar-fixed-bottom">                        
            <asp:Label ID="lbloque" runat="server" Text="O que é Easy Park?"></asp:Label>
        </a>
    </div>

</asp:Content>
