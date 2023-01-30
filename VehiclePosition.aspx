<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehiclePosition.aspx.cs" Inherits="VehiclePosition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>CUSTOMER INVOICE</b>
        </div>
        <div class="panel-body labelColor"> 
            <div class="form-group"> 
                <div class="row" id="SearchingParam" runat="server"> 
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <asp:Label ID="lblVehiclNo" runat="server" CssClass="label labelColor">VEHICLE NUMBER : </asp:Label> 
                    </div> 
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 "> 
                        <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="form-control input-sm txtVehicleNo" Style="text-transform: uppercase;" AutoCompleteType="Disabled" onkeypress="return checkNumAlpha()"></asp:TextBox> 
                    </div> 
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnGetVehicleDetails" Text="Get Vehicle Details" runat="server" OnClick="btnGetVehicleDetails_Click" /> 
                    </div>
                </div> 
                <div class="form-horizontal" role="form" id="divVehicles" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:GridView ID="gvVehicleList" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                    <Columns>
                        <asp:BoundField DataField="branchName" HeaderText="Branch" /> 
                        <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No" /> 
                        <asp:BoundField DataField="hiringDate" HeaderText="Hiring Date" /> 
                        <asp:BoundField DataField="routeName" HeaderText="Route Name" /> 
                        <asp:BoundField DataField="CurrentBranch" HeaderText="Current Branch" /> 
                        <asp:BoundField DataField="Status" HeaderText="Status" /> 
                        <asp:BoundField DataField="Remark" HeaderText="Remark" /> 
                        <asp:BoundField DataField="latitude" HeaderText="Branch Latitude" /> 
                        <asp:BoundField DataField="longitude" HeaderText="Branch Longitude" /> 
                        <asp:BoundField DataField="distance" HeaderText="Distance" /> 
			<asp:BoundField DataField="vehicleReqType" HeaderText="type" /> 
			<asp:BoundField DataField="routeId" HeaderText="RouteId" /> 
                    </Columns>
                    </asp:GridView>
                </div>
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server"> 
                    <div class="row" id="Div1" runat="server"> 
                        <asp:Label ID="lblLatitude" runat="server" CssClass="label labelColor"></asp:Label> 
                    </div> 
                    <div class="row" id="Div2" runat="server"> 
                        <asp:Label ID="lblLongitude" runat="server" CssClass="label labelColor"></asp:Label> 
                    </div>
                    <div class="row" id="Div3" runat="server"> 
                        <asp:Label ID="lblAddress" runat="server" CssClass="label labelColor"></asp:Label> 
                    </div>
                    <div class="row" id="Div4" runat="server"> 
                        <asp:Label ID="lblDateTime" runat="server" CssClass="label labelColor"></asp:Label> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>