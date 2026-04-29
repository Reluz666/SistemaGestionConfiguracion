<!--Modificado en Reque el dia 04/03/2023 por el Ing. Jose Secundino Alvites Rodas-->
<%@ Page Language="C#" Debug="true" AutoEventWireup="true" CodeFile="Reporte.aspx.cs" Inherits="Reportes_Default" %>

<%--<%@ Register assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>--%>

<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="frmReporteador" runat="server">
    <div>
    
        <%--<CR:CrystalReportViewer ID="crvReporte" runat="server" AutoDataBind="True" 
            GroupTreeImagesFolderUrl="" Height="50px" ToolbarImagesFolderUrl="" 
            ToolPanelWidth="200px" Width="100%" />--%>
        <CR:CrystalReportViewer ID="crvReporte" runat="server" AutoDataBind="true" ToolPanelView="None" />
    </div>
    </form>
</body>
</html>
