<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Compra.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.Compra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var url = window.location.href;
        var url_atual = url.split("pnl")[1];

        if (url_atual == 1) {
            window.alert("Parabéns, sua compra foi realizada com sucesso!");
            window.location.href = "http://localhost:35192/PagUsuario/Compra.aspx";
        }
    </script>

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
        <%--<iframe src="../botaocompra.html"></iframe>--%>

    <asp:HiddenField ID="codigo" runat="server" />

    <div class="row ">
        <h1 class="text-info text-center centralizar center-block hidden-sm hidden-xs">Realize a compra de créditos para efetuar a parada!</h1>
        <h3 class="text-info text-center centralizar center-block hidden-md hidden-lg">Realize a compra de créditos para efetuar a parada!</h3>
    </div>

    <div class="text-center centralizar center-block">
        <h4>
            Seu saldo é de R$:
            <asp:Label ID="lblsaldo" runat="server" Text=""></asp:Label>
        </h4>

    </div>

<%--    <iframe name="pag" src="PagSeguro.html" style="height:630px" FRAMEBORDER="0"></iframe>--%>

    <div class="container-fluid text-center">
        <div class="row">
            <asp:Label ID="Label4" runat="server" Text="Compra de R$ 5,00 de créditos"></asp:Label>

            <asp:Button ID="lbl5" runat="server" Text="Comprar R$ 5,00" OnClick="btn5_Click"  CssClass="btnconfirmarr" Width="250px"/>
        </div>
        <div class="row">
            <asp:Label ID="lbl10" runat="server" Text="Compra de R$10,00 de créditos"></asp:Label>

            <asp:Button ID="btn10" runat="server" Text="Comprar R$10,00" OnClick="btn10_Click"  CssClass="btnconfirmarr" Width="250px" />
        </div>
        <div class="row">
            <asp:Label ID="lbl20" runat="server" Text="Compra de R$20,00 de créditos"></asp:Label>

            <asp:Button ID="btn20" runat="server" Text="Comprar R$20,00" OnClick="Button2_Click"   CssClass="btnconfirmarr" Width="250px"/>
        </div>

    </div>
    <% } %>
</asp:Content>
