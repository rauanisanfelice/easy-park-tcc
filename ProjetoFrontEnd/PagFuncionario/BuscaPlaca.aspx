<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="BuscaPlaca.aspx.cs" Inherits="ProjetoFrontEnd.PagFuncionario.BuscaPlaca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <script src="../res/js/mascaras.js"></script>
    <script src="../res/js/jquery.maskedinput-1.1.1.js"></script>

    <script src="maskedinput.js" type="text/javascript"></script>
    <script src="../res/js/jquery-2.2.1.min.js"></script>
    <script src="../res/js/jquery-2.2.1.js"></script>

    <script  type="text/javascript">
        var url = window.location.href;
        var url_atual = url.split("msg")[1];

        if (url_atual == 0) {
            window.alert("Notificação efetuada com suceso!");
            window.location.href = "http://localhost:35192/PagFuncionario/BuscaPlaca.aspx";
        }
        else if (url_atual == 1){
            window.alert("Erro, por favor notificar os administradores.");
            window.location.href = "http://localhost:35192/PagFuncionario/BuscaPlaca.aspx";
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <% if (Session["func"] == null)
       { %>
        <br /><br /><br /><br /><br /><br />
        <h3 class="text-center center-block" style="color:red; font-style:italic;">Você não está logado, portanto não pode ver este conteúdo!</h3>
        <br /><br /><br />
        <div class="text-center center-block">
            <asp:Button ID="Button1" runat="server" Text="Página inicial" CssClass="btnfun btnbusca" Width="150px" OnClick="Button1_Click1"/>
        </div>
    <% } else { %>

    <%--ABA DE PESQUISA--%>
    <asp:Panel ID="pesquisa" runat="server" DefaultButton="btnpesquisar">
        <div class="row text-center">
            <asp:TextBox ID="txtplaca" runat="server" CssClass="pesquisa imgpesquisa" placeholder="Ex: QQQ-0000" onkeyup="mascara(this, event)" 
                onfocus="moveToEnd(this)" onclick="moveToEnd(this)" MaxLength="8" onkeypress="return Mascara(this, Placa)"></asp:TextBox>
            <asp:Button ID="btnpesquisar" runat="server" Text="Pesquisar" OnClick="btnpesquisar_Click" CssClass="btnfun btnbusca" Width="110px"/>
        </div>
    </asp:Panel>


    <div style="width:80%; margin-left:10%">
        <table class="table table-striped">
            <tr>
                <th class="espacotabela">Nome completo</th>
                <th class="espacotabela">Rg</th>
                <th class="espacotabela">Cidade</th>
                <th class="espacotabela">Placa</th>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblnome" runat="server" Text=""></asp:Label>        
                </td>
                <td>
                    <asp:Label ID="lblrg" runat="server" Text=""></asp:Label>          
                </td>
                <td>
                    <asp:Label ID="lblcidade" runat="server" Text=""></asp:Label>           
                </td>
                <td>
                    <asp:Label ID="lblplaca" runat="server" Text=""></asp:Label>        
                </td>  
            </tr>
        </table>
    </div>

    <br />

    <h3 style="margin-left:10%;">Dados da parada</h3>
    <div style="width:80%; margin-left:10%">
        <table class="table table-striped">
            <tr>
                <th class="espacotabela">Data</th>
                <th class="espacotabela">Hora de inicio da parada</th>
                <th class="espacotabela">Hora de termino da parada</th>
                <th class="espacotabela">Hora comprada</th>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbldata" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblhorainicioparada" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblfinalparada" runat="server" Text=""></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblhora" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <br />

    <div class="container-fluid">
        <div class="row">
            <asp:Label ID="lblerro" runat="server" Text="" Visible="false" Font-Size="X-Large" Font-Bold="true" CssClass="text-center text-danger col-md-12 col-xs-12"></asp:Label>
        </div>
        <div class="row">
            <asp:Button ID="btnotificar" runat="server" Text="Notificar" Visible="false" OnClick="Button1_Click" CssClass="alert-danger col-md-offset-5 col-xs-offset-4 btnnotificar" />
        </div>
    </div>
        
    <% } %>
</asp:Content>
