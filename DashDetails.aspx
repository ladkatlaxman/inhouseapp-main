<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="DashDetails.aspx.cs" Inherits="DashDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel-body">
        <div class="form-horizontal" role="form">
            <div class="row">
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                    <h2><asp:Label ID="lblReportName" runat="server" Text="" Font-Bold="true"></asp:Label></h2> 
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                    <h2><asp:Label ID="lblBranchName" runat="server" Text="" Font-Bold="true"></asp:Label></h2> 
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                    <div class="form-control-sm"></div>
                    <asp:LinkButton ID="btnExport" runat="server"  CssClass="btn btn-info largeButtonStyle btnExport" OnClick="btnExport_Click">EXCEL</asp:LinkButton>
                    <div class="form-control-sm"></div>
                </div>
            </div>
            <div class="form-group">
                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                </asp:GridView>
            </div>
            <div class="row">
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                    <h3><asp:Label ID="lblDockets" runat="server" Text="Waybill Details" Font-Bold="true"></asp:Label></h3> 
                </div>
            </div>
            <div class="form-group">
                <asp:GridView ID="gvSecondGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                </asp:GridView>
            </div>
            <div class="form-group">
                <asp:GridView ID="gvThirdGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

