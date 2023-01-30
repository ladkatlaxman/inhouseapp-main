<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WayBillInvoice.aspx.cs" Inherits="WayBillInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>WAYBILL INVOICES</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
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
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_Select" runat="server" CssClass="label labelColor">SELECT</asp:Label>
                            <asp:DropDownList ID="cmbCustomers" runat="server" CssClass="formDisplay input-sm cmbCustomers">
                            </asp:DropDownList>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="btnShowInvoice" runat="server" Text="SHOW INVOICE" CssClass="btn btn-info largeButtonStyle btnShowInvoice" OnClick="btnShowInvoice_Click">SHOW INVOICE</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="btnCreateInvoice" runat="server" Text="CREATE INVOICE" CssClass="btn btn-info largeButtonStyle btnCreateInvoice" OnClick="btnCreateInvoice_Click">CREATE INVOICE</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel-body"> 
            <div class="form-horizontal" role="form"> 
                <div class="form-group"> 
                    <asp:GridView ID="gvInvoiceGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" Visible="true" RowStyle-CssClass="gvItemStyle"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false"/> 
                    </asp:GridView> 
                </div> 
            </div> 
        </div> 
    </div> 
</asp:Content> 
