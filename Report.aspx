<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link href="bootstrap(11)1087px/css/bootstrap.css" rel="stylesheet" />

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="panel panelTop">
                <div class="panel-heading panelHead" style="font-weight:bold" runat="server" id="HeaderName">
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <asp:GridView ID="GV_CustomerList" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                         <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                         <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="customerName" HeaderText="NAME">
                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" CssClass="gvItemStyle"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ContactNo" HeaderText="CONTACT NO">
                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="locPincode" HeaderText="PINCODE">
                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="areaName" HeaderText="AREA">
                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" CssClass="gvItemStyle"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Address" HeaderText="ADDRESS">
                                        <HeaderStyle  HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle  HorizontalAlign="Left" CssClass="gvItemStyle"/>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cityName" HeaderText="CITY">
                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" CssClass="gvItemStyle"/>
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
