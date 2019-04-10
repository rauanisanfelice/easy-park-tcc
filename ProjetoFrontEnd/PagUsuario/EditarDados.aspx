<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="EditarDados.aspx.cs" Inherits="ProjetoFrontEnd.cadastro.EditarDados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Edição de cadastro</title>
    <script src="../res/js/mascaras.js"></script>

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

    <asp:HiddenField ID="codigo" runat="server" />

    <asp:Panel ID="panelcadastro" runat="server" DefaultButton="salvar">  
        
        <div style="width:50%" class="text-center center-block">
            <%--Campo NOME--%>
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblnome" runat="server" Text="Nome Completo *"></asp:Label>
                <br />
                <asp:TextBox ID="nome" runat="server" CssClass="text"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator7" 
                    runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                    ControlToValidate="nome" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
            </div>

            <%--Campo RG--%>
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblrg" runat="server" Text="RG *"></asp:Label>
                <br />
                <asp:TextBox ID="rg" CssClass="text" runat="server" MaxLength="12" onkeypress="return Mascara(this, Rg)"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator8" 
                    runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                    ControlToValidate="rg" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
            </div>

            <%--Campo CIDADE--%> 
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblcidade" runat="server" Text="Cidade *"></asp:Label>
                <br />
                <asp:TextBox ID="cidade" CssClass="text" runat="server"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator9" 
                    runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                    ControlToValidate="cidade" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
            </div>

            <%--Campo EMAIL--%>
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblemail" runat="server" Text="E-mail *"></asp:Label>
                <br />
                <asp:TextBox ID="email" CssClass="text" runat="server" AutoCompleteType="Email" TextMode="Email"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator10" 
                    runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório"
                    ControlToValidate="email" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
            </div>

            <%--Campo PLACA--%>
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblplaca" runat="server"  Text="Placa *"></asp:Label>
                <br />
                <asp:TextBox ID="placa" CssClass="text" runat="server" MaxLength="8" onkeyup="mascara(this, event)" onfocus="moveToEnd(this)" onclick="moveToEnd(this)" ></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator11" 
                    runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                    ControlToValidate="placa" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
            </div>


            <%--Campo SENHA--%>
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblsenha" runat="server"  Text="Senha *"></asp:Label>
                <br />
                <asp:TextBox ID="senha" CssClass="text" runat="server" ValidationExpression="^\d{6}$" TextMode="Password"></asp:TextBox>
                <br />
                <asp:Label ID="minimo" runat="server" Text="Mínimo 5 caracteres" Font-Size="Small"></asp:Label>
                <br />  
                <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator12" 
                    runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                    ControlToValidate="senha" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
            </div>
            
            <br />  

            <%--Campo CONFIRMAR SENHA--%>
            <div class="rowl text-left" runat="server" style="height:75px !important;">
                <br />
                <asp:Label ID="lblconfsenha" runat="server" Text="Confirmar Senha *"></asp:Label>
                <br />
                <asp:TextBox ID="confsenha" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>
                <br />
                <asp:CompareValidator ValidationGroup="grupousu" ID="CompareValidator2" runat="server" 
                    ErrorMessage="O campo descrição é obrigatório" Text="Senhas não conferem" 
                    ControlToValidate="senha" ControlToCompare="confsenha" Operator="Equal" ForeColor="Red" 
                    Font-Size="Small" Font-Italic="true"></asp:CompareValidator>
            </div>
        </div>

        <br />

         <div class="center-block text-center">
            <asp:Panel ID="pnlerro" runat="server" CssClass="alert alert-danger text-center center-block" Visible ="false" Width="60%">             
                <asp:Label ID="lblerroplaca" runat="server"  visible="false" Text="Tamanho do campo Placa está incorreta!"></asp:Label><br />
                <asp:Label ID="lblerrorg"    runat ="server" visible="false" Text="Tamanho do campo RG está incorreto!"></asp:Label><br />
                <asp:Label ID="lblerrosenha" runat="server"  visible="false" Text="A senha deve ser maior do que 5 caracteres"></asp:Label>
            </asp:Panel>
        </div>

        <br />
        <%--Campo CAMPOS OBRIGATORIOS--%>
        <div class="row paddingri" runat="server">
            <asp:Label ID="lblcampo" runat="server" CssClass="col-md-2 col-xs-2" placeholder="(*) Campos de preenchimento obrigatório"></asp:Label>
        </div>

        <%--Campo BOTAO SALVAR--%>
        <div class="row paddingri" runat="server">

            <div class="col-md-12 col-xs-12" style="text-align: center;" runat="server">
                <asp:Button ID="salvar" runat="server" Text="Salvar" validationgroup="grupousu" CssClass="btnadd btnfun"
                        OnClick="salvar_Click" />
                <asp:Button ID="cancelar" runat="server" Text="Cancelar" CssClass="btnfun" OnClick="cancelar_Click" />
            </div>
        </div>
    </asp:Panel>
    

    <% } %>
</asp:Content>
