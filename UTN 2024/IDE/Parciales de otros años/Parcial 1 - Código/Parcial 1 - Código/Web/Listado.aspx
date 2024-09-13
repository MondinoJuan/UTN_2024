<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listado.aspx.cs" Inherits="Web.Listado" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Parcial PC - .NET</title>
    <link rel="stylesheet" type="text/css" href="estilo.css" media="screen" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="divAgarraElEstilo">
        <asp:GridView ID="gridViewAlumno" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="ID Alumno" DataField="Id"/>
                <asp:BoundField HeaderText="Alumno" DataField="ApellidoNombre" />
                <asp:BoundField HeaderText="Correo-E" DataField="Email" />
                <asp:BoundField HeaderText="Edad" DataField="Edad" />
                <asp:BoundField HeaderText="DNI" DataField="Dni" />
                <asp:BoundField HeaderText="Fecha nacimiento" DataField="FechaNacimiento" DataFormatString="{0:d}" />
            </Columns>
        </asp:GridView>
        </div>
    </div>
    </form>
</body>
</html>
