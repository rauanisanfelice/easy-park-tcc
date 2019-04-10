<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="CadastroFunc.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.CadastroFunc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <script src="../res/js/mascaras.js"></script>

    <%-- MUDAR AQUI A SESSA PARA ADM --%>

    <%-- ATENÇÃO  --%>

    <% if (Session["adm"] == null)
       { %>
        <br /><br /><br /><br /><br /><br />
        <h3 class="text-center center-block" style="color:red; font-style:italic;">Você não está logado, portanto não pode ver este conteúdo!</h3>
        <br /><br /><br />
        <div class="text-center center-block">
            <asp:Button ID="Button1" runat="server" Text="Página inicial" CssClass="btnfun btnbusca" Width="150px" OnClick="Button1_Click"/>
        </div>
       
    <% } else { %>
        <div class="form-group branco tamanhobranco">
            <br />
            <asp:Panel ID="cadastro" runat="server" DefaultButton="confirmarfun">
                <div class="text-center center-block" style="width: 50%;">
                    <%--Campo NOME--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblnome" runat="server" Text="Nome Completo *"></asp:Label>
                        <br />
                        <asp:TextBox ID="nomefun" runat="server" CssClass="text"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator1" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" ControlToValidate="nomefun" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <%--Campo RG--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblrg" runat="server" Text="RG *"></asp:Label>
                        <br />
                        <asp:TextBox ID="rgfuncionario" CssClass="text" runat="server" MaxLength="12" onkeypress="return Mascara(this, Rg)"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator2" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" ControlToValidate="rgfuncionario" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <%--Campo CIDADE--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblcidade" runat="server" Text="Cidade *"></asp:Label>
                        <br />
                        <asp:TextBox ID="cidadefunc" CssClass="text" runat="server"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator3" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" ControlToValidate="cidadefunc" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <%--Campo FISCAL--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblfiscal" runat="server" Text="Fiscal *"></asp:Label>
                        <br />
                        <asp:TextBox ID="fiscalfun" CssClass="text" runat="server" MaxLength="4" onkeypress="return Mascara(this, Integer)"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator4" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" ControlToValidate="fiscalfun" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <%--Campo SETOR--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblsetor" runat="server" Text="Setor *"></asp:Label>
                        <br />
                        <asp:TextBox ID="setorfunc" CssClass="text" runat="server" MaxLength="4" onkeypress="return Mascara(this, Integer)"></asp:TextBox>
                        <br />
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator5" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" ControlToValidate="setorfunc" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <%--Campo SENHA--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblsenha" runat="server" Text="Senha *"></asp:Label>
                        <br />
                        <asp:TextBox ID="senhafun" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>
                        <br />
                        <asp:Label ID="minimo" runat="server" Text="Mínimo 5 caracteres" Font-Size="Small"></asp:Label>
                        <br />  
                        <asp:RequiredFieldValidator ValidationGroup="grupousu" ID="RequiredFieldValidator6" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Campo obrigatório" ControlToValidate="senhafun" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:RequiredFieldValidator>
                    </div>

                    <br /> 

                    <%--Campo CONFIRMAR SENHA--%>
                    <div class="rowl text-left" runat="server" style="height:75px !important;">
                        <br />
                        <asp:Label ID="lblconf" runat="server" Text="Confirmar Senha *"></asp:Label>
                        <br />
                        <asp:TextBox ID="confsenhafun" CssClass="text" runat="server" TextMode="Password"></asp:TextBox>
                        <br />
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="O campo descrição é obrigatório" Text="Senhas não conferem" ControlToValidate="senhafun" ControlToCompare="confsenhafun" Operator="Equal" ForeColor="Red" Font-Size="Small" Font-Italic="true"></asp:CompareValidator>
                    </div>
                </div>
            </asp:Panel>

            <br />

            <div class="center-block text-center">
                <asp:Panel ID="pnlerro" runat="server" CssClass="alert alert-danger text-center center-block" Visible ="false" Width="60%">           
                    <asp:Label ID="lblerrofiscal" runat="server"  visible="false" Text="Tamanho do campo Fiscal está incorreta!"></asp:Label><br />
                    <asp:Label ID="lblerrosetor" runat="server"  visible="false"  Text="Tamanho do campo Setor está incorreta!"></asp:Label><br />
                    <asp:Label ID="lblerrorg"    runat ="server" visible="false"  Text="Tamanho do campo RG está incorreto!"></asp:Label><br />
                    <asp:Label ID="lblerrosenha" runat="server"  visible="false"  Text="A senha deve ser maior do que 5 caracteres"></asp:Label>
                </asp:Panel>
            </div>

            <br />

            <%--Campo BOTAO CONFIRMAR--%>
            <div class="row paddingri" runat="server">

                <div class="col-md-12 col-xs-12" style="text-align: center;" runat="server">
                    <asp:Button ID="confirmarfun" runat="server" Text="Confirmar" CssClass="btnconfirmarr" OnClick="confirmarfun_Click" ValidationGroup="grupousu"/>
                </div>
            </div>
        </div>

    <% } %>

</asp:Content>
