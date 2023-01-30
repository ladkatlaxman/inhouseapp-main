<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="CustomerInvoice.aspx.cs" Inherits="CustomerInvoice" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField runat="server" ID="hdInvoiceId" />
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>CUSTOMER INVOICE</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" id="SearchingParam" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Lbl_SearchCustName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label>
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:TextBox ID="Txt_SearchCustName" runat="server" CssClass="form-control input-sm Txt_SearchCustName" Style="text-transform: uppercase;" AutoCompleteType="Disabled" onkeypress="return checkNumAlpha()"></asp:TextBox>
                            <asp:HiddenField ID="hfSearchCustName" runat="server" /> 
                            <asp:HiddenField ID="hfCustomerAddress" runat="server" /> 
                            <asp:HiddenField ID="hfCustomerStatecode" runat="server" /> 
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="LblBranch" runat="server" CssClass="label labelColor">BRANCH</asp:Label>
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:TextBox ID="txtBranchName" runat="server" CssClass="form-control input-sm txtBranchName" Style="text-transform: uppercase;" AutoCompleteType="Disabled" onkeypress="return checkNumAlpha()"></asp:TextBox>
                        <asp:HiddenField ID="hfBranchAddress" runat="server" /> 
			            <asp:HiddenField ID="hfBranchId" runat="server" />
                        <asp:HiddenField ID="hfBranchStateCode" runat="server" /> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnInvoiceHeader"   Text="Invoice"  runat="server" OnClick="btnInvoiceHeader_Click"/> 
                        <asp:Button ID="btnInvoiceWayBills" Text="WayBills" runat="server" OnClick="btnInvoiceWaybill_Click" Visible="true"/> 
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnExcel" Text="Excel" runat="server" OnClick="btnExcel_Click" Visible="false"/> 
                    </div>
                </div>
                <div class="row" id="divCriteria" runat="server">
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
                </div>
                <div class="row" id="divInvoiceButtons" runat="server">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1"></div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnGetWayBills" Text="Get Unbilled Waybills" runat="server" OnClick="btnGetWayBills_Click" /> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnCalculate" Text="Calculate Invoice Values" runat="server" OnClick="btnCalculate_Click" /> 
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="LblInvoiceno" runat="server" CssClass="label labelColor">INVOICE NO</asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:TextBox ID="txtInvoiceNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtInvoiceNo"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label6" runat="server" CssClass="label labelColor">DATE</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:TextBox ID="txtInvoiceDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtInvoiceDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnSaveInvoiceValues" Text="Save Invoice" runat="server" OnClick="btnSaveInvoiceValues_Click" /> 
                    </div>
                </div>
                <div class="row" id="divSummaries" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor right">Total Weight: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblWeight" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label2" runat="server" CssClass="label labelColor right">Total Value: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblValue" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label3" runat="server" CssClass="label labelColor">CGST: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblCGST" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label5" runat="server" CssClass="label labelColor">SGST: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblSGST" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label7" runat="server" CssClass="label labelColor">IGST: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblIGST" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label4" runat="server" CssClass="label labelColor">Total Invoice: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblTotalInvoice" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                </div>
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast" OnRowDataBound="gvFirstGrid_RowDataBound"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

