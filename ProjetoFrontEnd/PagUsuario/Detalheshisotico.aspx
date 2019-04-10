<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Detalheshisotico.aspx.cs" Inherits="ProjetoFrontEnd.PagUsuario.detalheshisotico" %>
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
    <div class="fundoconf col-md-offset-2 col-lg-8 col-xs-offset-1 col-xs-10">
        <asp:Table ID="tblconf" runat="server" CssClass="">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell>
                    <asp:Label ID="Label1" runat="server" Text="Detalhes do histórico." CssClass="txtcon visible-md visible-lg visible-sm"></asp:Label>
                    <asp:Label ID="Label2" runat="server" Text="Detalhes." CssClass="txtcon visible-xs"></asp:Label>       
                </asp:TableHeaderCell>
            </asp:TableHeaderRow>            

            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblpla" runat="server" Text="Placa:" CssClass="txtconte"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblplaca" runat="server" Text="" CssClass=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblda" runat="server" Text="Data:" CssClass="txtconte"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lbldata" runat="server" Text="" CssClass=""></asp:Label>
                </asp:TableCell>         
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblcom" runat="server" Text="Horas compradas:" CssClass="txtconte"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblcompra" runat="server" Text="" CssClass=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblho" runat="server" Text="Hora inicial:" CssClass="txtconte"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblhora" runat="server" Text="" CssClass=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblfin" runat="server" Text="Hora final:" CssClass="txtconte"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblfinal" runat="server" Text="" CssClass=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow>
                <asp:TableCell>
                    <asp:Label ID="lblstatus" runat="server" Text="Status:" CssClass="txtconte"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/res/img/010_x-128.png" Visible="false" Width="20px" Height="20px" />
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/res/img/011_yes-128.png" Visible="false" Width="20px" Height="20px"/>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>

        <asp:Button ID="btnconfirmar" runat="server" Text="Voltar" CssClass="btnfun center-block" BorderColor="#67b1d6" ForeColor="#67b1d6" OnClick="btnconfirmar_Click" />
        
        <br />
    </div>
    <% } %>
</asp:Content>
