<%@ Page Title="" Language="C#" MasterPageFile="~/SemEdit.Master" AutoEventWireup="true" CodeBehind="CadastroUsu.aspx.cs" Inherits="ProjetoFrontEnd.cadastro.CadastroUsu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Cadastro</title>

    <script src="../res/js/mascaras.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="azul" runat="server">
        <%--BARRA INICIAL--%> 
        <div class="row" runat="server">
            <div class="col-md-1 col-xs-offset-2 col-xs-2">
                <a href="PagInicial.aspx">
                    <img src="../res/img/logo1.png" class="imglogo text-center"/>
                </a>
            </div>
            <div class="col-md-3 col-md-offset-1 borda" runat="server" style="margin-top: 30px;">
                <h1 class="cadastro">Cadastro</h1>
                <h2 class="preencha">Preencha seus dados</h2>
            </div>
        </div>
    </div>

    <div class="form-group branco tamanhobranco">
        <div class="container-fluid branco tamanhobranco" runat="server">

            <br />
            <asp:Panel ID="cadastro" runat="server" DefaultButton="confirmar">  
                <div style="width:50%" class="text-center center-block">
                    <%--Campo NOME--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblnome" runat="server" Text="Nome Completo *"></asp:Label>
                        <br />
                        <asp:TextBox ID="nome" runat="server" CssClass="text"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator2" 
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
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator1" 
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
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator3" 
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
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator4" 
                            runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                            ControlToValidate="email" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <%--Campo PLACA--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblplaca1" runat="server"  Text="Placa *"></asp:Label>
                        <br />
                        <asp:TextBox ID="txtplaca1" CssClass="text" runat="server" MaxLength="8" onkeyup="mascara(this, event)" onfocus="moveToEnd(this)" onclick="moveToEnd(this)" ></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator5" 
                            runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                            ControlToValidate="txtplaca1" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>


                    <%--Campo SENHA--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblsenha" runat="server"  Text="Senha *"></asp:Label>
                        <br />
                        <asp:TextBox ID="senha" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>
                        <br />
                        <asp:Label ID="minimo" runat="server" Text="Mínimo 5 caracteres" Font-Size="Small"></asp:Label>
                        <br />  
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator6" 
                            runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" 
                            ControlToValidate="senha" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                        <br />
                    </div>
                    <br />
                    <%--Campo CONFIRMAR SENHA--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblconf" runat="server" Text="Confirmar Senha *"></asp:Label>
                        <br />
                        <asp:TextBox ID="confsenha" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>
                        <br />
                        <asp:CompareValidator ValidationGroup="grupousu" ID="CompareValidator1" 
                            runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Senhas não conferem" 
                            ControlToValidate="senha" ControlToCompare="confsenha" Operator="Equal" ForeColor="Red" 
                            Font-Size="Small" Font-Italic="true"></asp:CompareValidator>
                    </div>
                </div>
            </asp:Panel>

            <br />

            <div class="center-block text-center">
                <asp:Panel ID="pnlerro" runat="server" CssClass="alert alert-danger text-center center-block" Visible ="false" Width="60%">           
                    <asp:Label ID="lblerroplaca" runat="server"  visible="false" Text="Tamanho do campo Placa está incorreto!"></asp:Label><br />
                    <asp:Label ID="lblerrorg"    runat ="server" visible="false" Text="Tamanho do campo RG está incorreto!"></asp:Label><br />
                    <asp:Label ID="lblerrosenha" runat="server"  visible="false" Text="A senha deve ser maior ou igual do que 5 caracteres"></asp:Label>
                </asp:Panel>
            </div>

            <br />

            <%--Campo BOTAO CONFIRMAR--%>
            <div class="row paddingri" runat="server">
                <div class="col-md-12 col-xs-12" style="text-align: center;" runat="server">
                    <asp:Button ID="confirmar" causesvalidation="true" validationgroup="grupousu" runat="server" Text="Confirmar" CssClass="btnconfirmarr" OnClick="confirmar_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
