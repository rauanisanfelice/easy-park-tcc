<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ControlLogin.ascx.cs" Inherits="ProjetoFrontEnd.ControleLogin" %>

<link href="res/css/bootstrap.css" rel="stylesheet" />

<asp:Panel ID="panelLogado" runat="server" CssClass="">
    <div class="row azul" runat="server">
        <div class="col-md-1 col-xs-offset-2 col-xs-2">
            <a href="Menu.aspx">
                <img src="../res/img/logo1.png" class="imglogo text-center"/>
            </a>
        </div>
        <div class="col-md-3 col-md-offset-1 hidden-xs borda" runat="server">
            <asp:Label ID="lblmenucontrole" runat="server" Text="Easy Park" CssClass="cadastro"></asp:Label>
        </div>
        <div class="col-md-2 col-xs-offset-2 col-xs-4">
            <asp:Button ID="btnsair" runat="server" Text="Sair" OnClick="btnsair_Click" CssClass="btnsair margemdireita"/>
        </div>
    </div>
</asp:Panel>

<asp:Panel ID="PanelFuncionario" runat="server" CssClass="center-block text-center">
    <div class="row azul" runat="server" style="width:100%">
        <div class="btn-group" role="group" aria-label="..." style="margin-bottom:20px; margin-top: -40px !important;">
            <asp:Button ID="btnpesquisa" CssClass="btn btn-default btnsair" Width="150px" runat="server" Text="Pesquisar"   OnClick="pesquisar_Click" />
            <asp:Button ID="btncompra"   CssClass="btn btn-default btnsair" Width="150px" runat="server" Text="Venda"     OnClick="comprar_Click" />
            <asp:Button ID="btnsairrr"   CssClass="btn btn-default btnsair" Width="150px" runat="server" Text="Sair"        OnClick="sairfun_Click" />
        </div> 
    </div> 
</asp:Panel>

<asp:Panel ID="PanelNaoLogado1" runat="server" BackImageUrl="~/res/img/fundowebinicial.png">

    <div class="col-lg-offset-1 col-lg-5 col-sm-5 col-xs-offset-2">
        <asp:Button ID="inscrever" runat="server" Text="Inscrever-se" CssClass="btnn" OnClick="inscrever_Click" />
    </div>

    <div class="col-lg-offset-3 col-lg-2 col-xs-offset-2">
        <!-- Button trigger modal -->
        <button type="button" class="btnn" style="color: #67b1d6" data-toggle="modal" data-target="#myModal">
            Entrar
        </button>

        <!-- Modal -->
        <asp:Panel runat="server" ID="login" DefaultButton="Button1">
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 500px;">
                    <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Entrar</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <%--Letra--%>
                            <asp:Label ID="Label1" runat="server" Text="E-mail" CssClass="espaco login"></asp:Label>

                            <%--TexBox--%>
                            <asp:TextBox ID="txtusuario" runat="server" CssClass="txtlogin" TextMode="SingleLine" Width="350px"></asp:TextBox>
                        </div>   
                        <div class="row">
                            <%--Validação--%> 
                            <asp:RequiredFieldValidator validationgroup="PersonalInfoGroup" ID="RequiredFieldValidator2" CssClass="alerta" runat="server" ErrorMessage="Preencha os campos" Text="Campo obrigatório!" ControlToValidate="txtusuario" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                        </div>                  
                        <div class="row">
                            <%--Letra--%>
                            <asp:Label ID="Label2" runat="server" Text="Senha" CssClass="espaco login"></asp:Label>

                            <%--TexBox--%>
                            <asp:TextBox ID="txtsenha" runat="server" CssClass="txtlogin" TextMode="Password" Width="350px"></asp:TextBox>
                        </div>
                        <div class="row">               
                            <%--Validação--%>
                            <asp:RequiredFieldValidator validationgroup="PersonalInfoGroup" ID="RequiredFieldValidator4" CssClass="alerta" runat="server" ErrorMessage="Preencha os campos" Text="Campo obrigatório!" ControlToValidate="txtsenha" ForeColor="Red" Font-Size="Small"></asp:RequiredFieldValidator>
                            <br />
                        </div>
                        <div class="row">
                            <asp:Label ID="lblinvalido" runat="server" Text="Usuário ou senha inválida!" CssClass="alerta" ForeColor="Red" Font-Size="Small" Visible="false"></asp:Label>
                        </div>
                        <br />
                    </div>
                    <div class="modal-footer" style="margin-top:-20px;">
                       <%--ESQUECEU A SENHA--%>
                        <asp:Button ID="btnconfirmar" runat="server" Text="Recuperar senha" CssClass="btn btn-warning" OnClick="btnconfirmar_Click" />
                        <%--ENTRAR--%>
                        <asp:Button ID="Button1" runat="server" causesvalidation="true" validationgroup="PersonalInfoGroup" Text="Entrar" CssClass="btn btn-info botaoentrar" OnClick="btnentrar_Click" />
                    </div>
                </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Panel>


<asp:Panel ID="pnladm" runat="server" CssClass="azul">
    <br />

    <div class="row" style="width:100%; margin-bottom:-20px;">
        <div style="float: left; margin-left: 10%; margin-top:-30px;">
            <a href="../PagADM/PagADM.aspx" style="text-decoration: none;">
                <h3 class="painel hidden-xs">Painel Administrativo</h3>
                <h5 class="painel hidden-sm hidden-md hidden-lg">Painel Administrativo</h5>
            </a>
        </div>

        <div style="float: right; margin-right: 10%; margin-top:-30px;">
             <div class="dropdown">
                <button class="btn btnfun btnbusca dropdown-toggle" type="button" style="width:100px;" id="dropdownMenu2" data-toggle="dropdown">Menu
                <span class="caret"></span></button>

                <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                    <li>
                        <a href="../PagADM/PagADM.aspx">Estatísticas</a>
                    </li>
                    <li>
                        <a href="../PagADM/FuncionarioControle.aspx">Funcionários</a>
                    </li>
                    <li>
                        <asp:Button ID="btnsairr" runat="server" Text="Sair" OnClick="Button2_Click" CssClass="sair" />
                    </li>
                </ul>
            </div>
        </div>
       
    </div> 
    <br />
</asp:Panel>