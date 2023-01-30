<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WayBillInvoices.aspx.cs" Inherits="WayBillInvoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>LIST OF WAYBILLS CREATED</b>
        </div>
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
            <div class="form-control-sm"></div>
            <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
            <asp:TextBox ID="Txt_FromDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FromDate"></asp:TextBox>
        </div>
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
            <div class="form-control-sm"></div>
            <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
            <asp:TextBox ID="Txt_ToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox>
        </div>
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
            <div class="form-control-lg"></div>
            <div class="form-control-lg"></div>
            <div class="form-control-sm"></div>
            <asp:LinkButton ID="Btn_Search" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click">GET LIST</asp:LinkButton>
        </div>
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
            <div class="form-control-lg"></div>
            <div class="form-control-lg"></div>
            <div class="form-control-sm"></div>
            <asp:LinkButton ID="btnExport" runat="server"  CssClass="btn btn-info largeButtonStyle btnExport" OnClick="btnExport_Click">EXCEL</asp:LinkButton>
        </div>

        <div class="form-group">
            <div class="form-horizontal" role="form">
                <div class="form-control-sm">&nbsp;</div>
                <div class="form-control-sm">&nbsp;</div>
                <div class="form-control-sm">&nbsp;</div>
                <div class="form-control-sm">&nbsp;</div>
                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast"> 
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

