<%@ Page Title="" Language="C#" MasterPageFile="~/Pdv.Master" AutoEventWireup="true" CodeBehind="DadosUsuario.aspx.cs" Inherits="ProjetoFrontEnd.PagADM.DadosUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <script src="../res/js/mascaras.js"></script>

     <% if (Session["adm"] == null)
       { %>
        <br /><br /><br /><br /><br /><br />
        <h3 class="text-center center-block" style="color:red; font-style:italic;">Você não está logado, portanto não pode ver este conteúdo!</h3>
        <br /><br /><br />
        <div class="text-center center-block">
            <asp:Button ID="Button1" runat="server" Text="Página inicial" CssClass="btnfun btnbusca" Width="150px" OnClick="Button1_Click"/>
        </div>
    <% } else { %>

        <table style="width: 100%;">
            <tr>               
                <td style="padding-left: 10%; width: 65%" class="margin">
                    <asp:Panel runat="server" ID="dados" DefaultButton="confirmarfun">
                        <asp:Label ID="lblnome" runat="server" CssClass="" Text="Nome Completo *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="nomefun" runat="server" CssClass="text1"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="grupofun" runat="server" ErrorMessage="O campo nome é obrigatório" Text="Campo obrigatório" ControlToValidate="nomefun" ForeColor="Red" Font-Size="Small" Font-Italic="True"></asp:RequiredFieldValidator>
                            </div>
                
                            <asp:Label ID="lblrg" runat="server" CssClass="" Text="RG *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="rgfuncionario" CssClass="text1" runat="server" MaxLength="12" onkeypress="return Mascara(this, Rg)"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="grupofun" runat="server" ErrorMessage="O campo RG é obrigatório" Text="Campo obrigatório" ControlToValidate="rgfuncionario" ForeColor="Red" Font-Size="Small" Font-Italic="True"></asp:RequiredFieldValidator>
                            </div>
                
                            <asp:Label ID="lblcidade" runat="server" CssClass="" Text="Cidade *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="cidadefunc" CssClass="text1" runat="server" AutoCompleteType="HomeStreetAddress"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="grupofun" runat="server" ErrorMessage="O campo cidade é obrigatório" Text="Campo obrigatório" ControlToValidate="cidadefunc" ForeColor="Red" Font-Size="Small" Font-Italic="True"></asp:RequiredFieldValidator>
                            </div>
                         
                            <asp:Label ID="lblfiscal" runat="server" CssClass="" Text="Fiscal *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="fiscalfun" CssClass="text1" runat="server" TextMode="Number"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="grupofun" runat="server" ErrorMessage="O campo fiscal é obrigatório" Text="Campo obrigatório" ControlToValidate="fiscalfun" ForeColor="Red" Font-Size="Small" Font-Italic="True"></asp:RequiredFieldValidator>
                            </div>
                
                            <asp:Label ID="lblsetor" runat="server" CssClass="" Text="Setor *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="setorfunc" CssClass="text1" runat="server" TextMode="Number"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="grupofun" runat="server" ErrorMessage="O campo setor é obrigatório" Text="Campo obrigatório" ControlToValidate="setorfunc" ForeColor="Red" Font-Size="Small" Font-Italic="True"></asp:RequiredFieldValidator>
                            </div>
                              
                            <asp:Label ID="lblsenha" runat="server" CssClass="" Text="Nova senha *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="senhafun" CssClass="text1" runat="server" TextMode="Password"></asp:TextBox>
                                <br />
                                <asp:Label ID="minimo" runat="server" Text="Mínimo 5 caracteres" Font-Size="Small"></asp:Label>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="grupofun" runat="server" ErrorMessage="O campo senha é obrigatório" Text="Campo obrigatório" ControlToValidate="senhafun" ForeColor="Red" Font-Size="Small" Font-Italic="True"></asp:RequiredFieldValidator>
                            </div>
                            
                            <br />
                            
                            <asp:Label ID="lblconf" runat="server" CssClass="" Text="Confirmar Senha *"></asp:Label>

                            <div class="" runat="server">
                                <asp:TextBox ID="confsenhafun" CssClass="text1" runat="server" TextMode="Password"></asp:TextBox>
                                <br />
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="grupofun" ErrorMessage="O campo confirmar senha é obrigatório" Text="Senhas não conferem" ControlToValidate="senhafun" ControlToCompare="confsenhafun" Operator="Equal" ForeColor="Red" Font-Size="Small" Font-Italic="True" EnableClientScript="true"></asp:CompareValidator>
                            </div>            
           
                            <asp:Label ID="blblnomefun" runat="server" Text=""></asp:Label> 
                    </asp:Panel>                
                </td>
           
            <td style="width: 35%">
                <h2>Total</h2>
                <table style="width: 90%;" class="table table-hover table-responsive table-bordered">
                    <tr class="active">
                        <td>Pesquisas realizadas</td>
                        <td><asp:Label ID="lbltotalpesquisa" runat="server" Text="" CssClass="center-block text-center"></asp:Label></td>                     
                    </tr>
                    <tr class="warning">
                        <td>Notificações efetuadas</td>
                        <td><asp:Label ID="lblnotificacao" runat="server" Text="" CssClass="center-block text-center"></asp:Label></td>
                    </tr>
                    <tr class="danger">
                        <td>Paradas irregulares não notificadas</td>
                        <td><asp:Label ID="lblnaonotificado" runat="server" Text="" CssClass="center-block text-center"></asp:Label></td>
                    </tr>
                    <tr class="success">
                        <td>Paradas regulares</td>                            
                        <td><asp:Label ID="lblparadaok" runat="server" Text="" CssClass="center-block text-center"></asp:Label></td>
                    </tr>
                </table>                 
            </td>
        </tr>
    </table>    

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
        
        <div class=" center-block text-center" runat="server">
            <asp:Button ID="confirmarfun" runat="server" Text="Confirmar" ValidationGroup="grupofun" CssClass="btnadd btnfun" OnClick="confirmarfun_Click"/>
            <button type="button" class="btnfun" data-toggle="modal" data-target="#myModal" >
                Deletar
            </button>
            <asp:Button runat="server" ID="voltar"  text="Voltar" CssClass="btnvoltar" OnClick="voltar_Click" />
        </div>
        <div class="modal fade" id="myModal" tabindex="" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Deletar funcionário</h4>
                    </div>
                    <div class="modal-body">
                        Você tem certeza que deseja deletar este funcionário?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <asp:Button runat="server" ID="confdeletar" Text="Deletar" CssClass="btn btn-danger" OnClick="confdeletar_Click" />                      
                    </div>
                </div>
                </div>
            </div>   
        </div>        
    <% } %>

</asp:Content>
