<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehicleExpenses.aspx.cs" Inherits="VehicleExpenses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>LIST OF VEHICLE TRIPS</b>
        </div>
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
                <asp:Label ID="Label3" runat="server" CssClass="label labelColor">VEHICLE NO</asp:Label> 
                <asp:TextBox ID="txtVehicleNo" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox> 
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label2" runat="server" CssClass="label labelColor" EnableViewState="true">VEHICLE TYPE</asp:Label>
                <asp:DropDownList ID="ddlVehicleType" runat="server" CssClass="formDisplay input-sm ddlVehicleType">
                    <asp:ListItem Value="" Text="ALL"></asp:ListItem>
                    <asp:ListItem Value="OWNED"  Text="OWNED"></asp:ListItem>
                    <asp:ListItem Value="FIXED"  Text="FIXED"></asp:ListItem>
                    <asp:ListItem Value="MARKET" Text="MARKET"></asp:ListItem>
                </asp:DropDownList> 
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label1" runat="server" CssClass="label labelColor" EnableViewState="true">ROUTE TYPE</asp:Label>
                <asp:DropDownList ID="ddlRouteType" runat="server" CssClass="formDisplay input-sm ddlRouteType">
                    <asp:ListItem Value="" Text="ALL"></asp:ListItem>
                    <asp:ListItem Value="RT" Text="TRANSHIPMENT"></asp:ListItem>
                    <asp:ListItem Value="PD" Text="PICK UP / DELIVERY"></asp:ListItem>
                </asp:DropDownList> 
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                <div class="form-control-sm"></div>
                <asp:Label ID="lblBranch" runat="server" CssClass="label labelColor" EnableViewState="true">BRANCH</asp:Label>
                <asp:DropDownList ID="cmbBranchList" runat="server" CssClass="formDisplay input-sm cmbBranchList"></asp:DropDownList> 
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="Btn_Search" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click">GET LIST</asp:LinkButton>
            </div>
        </div>
        <div class="row" style="overflow: scroll;">
            <div class="form-horizontal" role="form">
                <div class="form-control-sm">&nbsp;</div>
                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast" OnRowDataBound="gvFirstGrid_RowDataBound"> 
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="VehicleRequestId" HeaderText="Vehicle Request Id" Visible="false" />
                        <asp:BoundField DataField="BranchName" HeaderText="BRANCH" Visible="false">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO" Visible="false">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
			<asp:TemplateField HeaderText="Vehicle No">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkBtnEdit" runat="server" Target="_blank" Text='<%# Eval("VehicleNo") %>'></asp:HyperLink> 
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:BoundField DataField="HiringDate" HeaderText="DATE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="Category" HeaderText="CATEGORY">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="RouteName" HeaderText="ROUTE">
                            <HeaderStyle HorizontalAlign="Left" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="VendorName" HeaderText="VENDOR">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="TripStartDate" HeaderText="START DATE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="tripStartTime" HeaderText="START TIME">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="TripEndDate" HeaderText="END DATE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="TripEndTime" HeaderText="END TIME">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="Duration" HeaderText="DURATION(HRS)">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="startKM" HeaderText="Start Reading">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="endKM" HeaderText="End Reading">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="distance" HeaderText="Distance">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="actualweight" HeaderText="Actual Weight">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="chargedweight" HeaderText="Charged Weight">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="FUEL(DIESEL)" HeaderText="FUEL(DIESEL)">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="FUEL(CNG)" HeaderText="FUEL(CNG)">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="FAST TAG" HeaderText="FAST TAG">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="CASH TOLL" HeaderText="CASH TOLL">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="ADBLUE" HeaderText="ADBLUE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="REPAIR" HeaderText="REPAIR">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="MAINTENANCE" HeaderText="MAINTENANCE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="FINE" HeaderText="FINE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="POLICE" HeaderText="POLICE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="OTHER" HeaderText="OTHER">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Left" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

