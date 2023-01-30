<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SendUserReports.aspx.cs" Inherits="SendUserReports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="gvUserGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
