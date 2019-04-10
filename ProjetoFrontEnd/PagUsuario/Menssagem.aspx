<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="Menssagem.aspx.cs" Inherits="ProjetoFrontEnd.PagUsuario.Menssagem" %>
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

            <asp:Table ID="tblnotif" runat="server" CssClass="">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>
                        <asp:Label ID="Label1" runat="server" Text="Dados da notificação." CssClass="txtcon visible-md visible-lg visible-sm"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text="Notificação." CssClass="txtcon visible-xs"></asp:Label>       
                    </asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="lblnom" runat="server" Text="Data:" CssClass="txtconte"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="lbldata" runat="server" Text="" CssClass=""></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="lblci" runat="server" Text="Hora:" CssClass="txtconte"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="lblhora" runat="server" Text="" CssClass=""></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="lblr" runat="server" Text="Descrição:" CssClass="txtconte"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="lbldesc" runat="server" Text="" CssClass=""></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>

            <%-- DADOS DA PARADA  --%>

            <asp:Table ID="tblparada" runat="server" CssClass="">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>
                        <asp:Label ID="Label3" runat="server" Text="Descrição da parada." CssClass="txtcon visible-md visible-lg visible-sm"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Text="Parada." CssClass="txtcon visible-xs"></asp:Label>
                    </asp:TableHeaderCell>
                </asp:TableHeaderRow>

                <%--  --%>
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
                        <asp:Label ID="lbldatapara" runat="server" Text="" CssClass=""></asp:Label>
                    </asp:TableCell>         
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="lblcom" runat="server" Text="Horas:" CssClass="txtconte"></asp:Label>
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
                        <asp:Label ID="lblhorapara" runat="server" Text="" CssClass=""></asp:Label>
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

            </asp:Table>
            <br />

            <asp:Button ID="btnvoltar" runat="server" Text="Voltar" CssClass="btnfun center-block" OnClick="btnvoltar_Click" />

            <br />
        </div>
    <% } %>
</asp:Content>
