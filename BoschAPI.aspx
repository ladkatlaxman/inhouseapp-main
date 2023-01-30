<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/AdminMasterPage.master"  CodeFile="BoschAPI.aspx.cs" Inherits="BoschAPI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>CUSTOMER INVOICE</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" id="SearchingParam" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="lblBoschCustomer" runat="server" CssClass="label labelColor">BOSCH UPDATES</asp:Label>
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:DropDownList ID="ddlBosch" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnUpdate" Text="Update Status" runat="server" OnClick="btnUpdate_Click"/> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnUploadEPod" Text="Upload EPOD" runat="server" OnClick="btnUploadEPod_Click"/> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnLogin" Text="Login" runat="server" OnClick="btnLogin_Click"/> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblError" runat="server" CssClass="bdc-red-400"></asp:Label>
                    </div>
                </div>
                <div class="row" id="divCriteria" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="dtFrom" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FromDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="dtTill" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnGetWayBills" Text="Get Waybills List" runat="server" OnClick="btnGetWayBills_Click"/> 
                    </div>
                </div>
                <div class="row" id="div1" runat="server">
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
                        <asp:Label ID="lblStatement" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                </div>
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                        <Columns>
                        <asp:BoundField DataField="WayBillNo" HeaderText="WayBill No">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Status" HeaderText="Status">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BranchName" HeaderText="Branch">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="WayBillDate" HeaderText="Way Bill Date">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DelDate" HeaderText="Delivery Date">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="valueChargedWt" HeaderText="Weight">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="itemQty" HeaderText="No of Packages">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="WayBillEDDDate" HeaderText="EDD">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer Name">
	                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
	                        <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>





