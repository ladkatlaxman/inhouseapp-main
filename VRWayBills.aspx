<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VRWayBills.aspx.cs" Inherits="VRWayBills" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel-heading panelHead"  runat="server" id="HeaderName">
        <b>WAYBILL EXPENSES</b>
    </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" id="divCustomerName" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor">CUSTOMER NAME : </asp:Label>
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:Label ID="lblCustomer" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                </div>
                <div class="row" id="divVendorName" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Lbl_SearchVendorName" runat="server" CssClass="label labelColor">VENDOR NAME : </asp:Label> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:Label ID="lblVendorName" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                </div>
                <div class="row" id="divVehicle" runat="server"> 
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label4" runat="server" CssClass="label labelColor">VEHICLE NO : </asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:Label ID="lblVehicleNo" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label7" runat="server" CssClass="label labelColor">HIRING DATE : </asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:Label ID="lblHiringDate" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label6" runat="server" CssClass="label labelColor">ROUTE : </asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:Label ID="lblRoute" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                </div> 
                <div class="row" id="divDates" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="Txt_FromDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FromDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="Txt_ToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                    </div>
                </div>
                <div class="row" id="divSummariesTwo" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label2" runat="server" CssClass="label labelColor right">Total Billing : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblBilling" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label3" runat="server" CssClass="label labelColor">Total Freight : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="lblFreight" runat="server" CssClass="label labelColor"></asp:Label> 
                    </div> 
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="Label5" runat="server" CssClass="label labelColor">Difference : </asp:Label> 
                    </div> 
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="lblDifference" runat="server" CssClass="label labelColor"></asp:Label> 
                    </div> 
                </div>
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" 
                        RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast" > 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                    </asp:GridView>
                </div>
            </div>
        </div>

</asp:Content>

