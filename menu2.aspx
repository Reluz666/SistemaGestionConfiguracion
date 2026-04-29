<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PaginaMaestra.master" CodeFile="menu2.aspx.cs" Inherits="menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function MostrarMensaje() {
            var mensaje = document.getElementById('<%=__mensaje.ClientID %>').value;
            if (mensaje != "") {
                alert(mensaje);
                if (document.getElementById('<%=__pagina.ClientID %>').value != "")
                    location.href = document.getElementById('<%=__pagina.ClientID %>').value;
            }
        }

        function window_load() {
            MostrarMensaje()
        }

        function Confirmar(men) {
            if (!confirm(men))
                return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div style="margin-top: 10px" class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
            

                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <!-- MOSTRAR MENSAJE CUANDO HAY UPDATEPANEL -->
                            <script type="text/javascript">
                                Sys.Application.add_load(MostrarMensaje);
                            </script>
                            
                 
                            <div>
                                <asp:HiddenField ID="__mensaje" runat="server" />
                                <asp:HiddenField ID="__pagina" runat="server" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
         
        </div>
    </form>
</asp:Content>