<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="FuncionarioControle.aspx.cs" Inherits="ProjetoFrontEnd.Paginas.FuncionarioControle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script  type="text/javascript">

        var url = window.location.href;
        var url_atual = url.split("msg")[1];


        if (url_atual == 0) {
            window.alert("Cadastro efetuado com suceso!");
            window.location.href = "http://localhost:35192/PagADM/FuncionarioControle.aspx";
        }
        else if (url_atual == 1){
            window.alert("Erro, funcionário ja existe!");
            window.location.href = "http://localhost:35192/PagADM/FuncionarioControle.aspx";
        }
        else if (url_atual == 2){
            window.alert("Usuário deletado com sucesso!");
            window.location.href = "http://localhost:35192/PagADM/FuncionarioControle.aspx";
        }
        else if (url_atual == 3) {
            window.alert("Erro ao deletar usuário!");
            window.location.href = "http://localhost:35192/PagADM/FuncionarioControle.aspx";
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

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

        <div class="container-fluid">

            <%--ABA DE PESQUISA--%>
            <asp:Panel ID="busca" runat="server" DefaultButton="btnpesquisar">
                <div class="row branco">
                    <div>
                        <asp:TextBox ID="txtpesquisa" runat="server" CssClass="pesquisa imgpesquisa" placeholder="Ex: José Alvares"></asp:TextBox>
                        <asp:Button ID="btnpesquisar" runat="server" Text="Pesquisar" OnClick="btnpesquisar_Click" CssClass="btnfun btnbusca" Width="100px"/>
                        <asp:Button ID="btnlimpar" runat="server" Text="Limpar" OnClick="btnlimpar_Click" CssClass="btnfun btnbusca" Width="100px" />
                    </div>
                </div>
            </asp:Panel>

            <div>
                <asp:Button ID="btnADD" runat="server" Text="Adicionar" CssClass="btnadd btnfun" OnClick="btnADD_Click" />

                <asp:Label ID="lblquantidade" runat="server" Text="Quantidade de Funcionários: " CssClass="col-md-offset-7 col-xs-offset-4"></asp:Label>

                <asp:Label ID="lblqtd" runat="server" Font-Size="17px" Text="" CssClass=""></asp:Label>
            </div>
            <%--            <div class="row col-md-offset-4">
                <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Selecione os funcionários que deseja deletar."
                    ClientValidationFunction="Validate" ForeColor="Red" CssClass="text-center"></asp:CustomValidator>
            </div>--%>

            <br />

            <div class="row">
                <asp:Repeater ID="listafuncionarios" runat="server">
                    <HeaderTemplate>
                        <table id="tblfuncionario" class="table table-hover table-responsive">
                            <tr>
                                <th class="espacotabela">ID</th>
                                <th class="espacotabela">Nome completo</th>
                                <th class="espacotabela">Rg</th>
                                <th class="espacotabela">Cidade</th>
                                <th class="espacotabela">Fiscal</th>
                                <th class="espacotabela">Setor</th>
                                <th class="espacotabela">Exibir</th>
                            </tr>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem,"ID") %>
                                <asp:HiddenField ID="HiddenField1" Value='<%# DataBinder.Eval(Container.DataItem,"ID") %>' runat="server" />

                            </td>
                            <td><%# DataBinder.Eval(Container.DataItem,"NOME")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem,"RG")%> </td>
                            <td><%# DataBinder.Eval(Container.DataItem,"CIDADE") %></td>
                            <td><%# DataBinder.Eval(Container.DataItem,"FISCAL") %></td>
                            <td><%# DataBinder.Eval(Container.DataItem,"SETOR") %> </td>
                            <td>
                                <asp:HyperLink ID="hplExibir" runat="server" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "ID", "DadosUsuario.aspx?ID={0}") %>'>Exibir</asp:HyperLink>
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

            </div>
        </div>
    <% } %>  
</asp:Content>
