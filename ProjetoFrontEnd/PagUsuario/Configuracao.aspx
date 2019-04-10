<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Configuracao.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.configuracao" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script  type="text/javascript">
        var url = window.location.href;
        var url_atual = url.split("msg")[1];

        if (url_atual == 0) {
            window.alert("Atualizações efetuadas com suceso!");
            window.location.href = "http://localhost:35192/PagUsuario/configuracao.aspx";
        }
        else if (url_atual == 1){
            window.alert("Erro, ao realizar a atulização!");
            window.location.href = "http://localhost:35192/PagUsuario/configuracao.aspx";
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
    
    <div class="container-fluid branco">
        <div class="row text-right col-md-11 col-xs-12">
            <a href="EditarDados.aspx" class="editarperfil">
                <asp:Label ID="lbleditareper" runat="server" Text="Editar perfil"></asp:Label>
            </a>
        </div>
    </div>

    <div class="row" style="margin-left:20%; margin-top:10px;">
        <table style="width: 900px" class="table-hover table-bordered">
            <tr>
                <td class="editarperfil">Nome</td>
                <td><asp:Label runat="server" ID="lblnome" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr>
                <td class="editarperfil">RG</td>
                <td><asp:Label runat="server" ID="lblrg" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr>
                <td class="editarperfil">Cidade</td>
                <td><asp:Label runat="server" ID="lblcidade" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr>
                <td class="editarperfil">E-mail</td>
                <td><asp:Label runat="server" ID="lblemail" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr>
                <td class="editarperfil">Placa</td>
                <td><asp:Label runat="server" ID="lblplaca" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr>
                <td class="editarperfil">Saldo</td>
                <td><asp:Label runat="server" ID="lblsaldo" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr class="success">
                <td class="editarperfil">Total de paradas</td>
                <td><asp:Label runat="server" ID="lblparadas" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
            <tr class="danger">
                <td class="editarperfil">Total de infrações</td>
                <td><asp:Label runat="server" ID="lblinfracao" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label></td>
            </tr>
        </table>
    </div>
    <br />

    <div class="row centralizar center-block text-center">
        <a href="Compra.aspx" >
            <h1 class="tabelafunc hidden-sm hidden-xs">
                Adquira mais créditos!!
            </h1>
            <h4 class="tabelafunc hidden-md hidden-lg">
                Adquira mais créditos!!
            </h4>
        </a>
    </div>


<%--    <div class="col-md-offset-5 col-xs-offset-3 paddingleft">
        <asp:Table ID="Table1" runat="server" BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" CssClass="teste">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server" CssClass="tabeladados bordadireita">
                    Nome
                </asp:TableCell>
                <asp:TableCell runat="server" Width="5px"></asp:TableCell>
                <asp:TableCell runat="server">

                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell runat="server" CssClass="tabeladados bordadireita">
                    RG
                </asp:TableCell>
                <asp:TableCell runat="server" Width="5px"></asp:TableCell>
                <asp:TableCell runat="server">

                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell runat="server" CssClass="tabeladados bordadireita">
                    Cidade
                </asp:TableCell>
                <asp:TableCell runat="server" Width="5px"></asp:TableCell>
                <asp:TableCell runat="server">

                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell runat="server" CssClass="tabeladados bordadireita">
                    E-mail
                </asp:TableCell>
                <asp:TableCell runat="server" Width="5px"></asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:Label runat="server" ID="txtemail" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell runat="server" CssClass="tabeladados bordadireita">
                    Placa
                </asp:TableCell>
                <asp:TableCell runat="server" Width="5px"></asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:Label runat="server" ID="txtplaca1" Text="" CssClass="tabeladados" Font-Size="25px"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>--%>

    <% } %>
</asp:Content>
