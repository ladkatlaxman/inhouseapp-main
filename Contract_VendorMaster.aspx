<%@ Page Title="" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Contract_VendorMaster.aspx.cs" Inherits="Contract_VendorMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hfTabs" Value="" runat="server" />
    <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_VendorCustomer" AssociatedUpdatePanelID="UpdatePanel_VendorCustomer" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div id="overlay">
                <div id="modalprogress">
                    <div id="theprogress">
                        <img src="images/dots-4.gif" />
                    </div>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <!---Update Progress 2 ---->
    <asp:UpdateProgress ID="UpdateProgress_View_Search" AssociatedUpdatePanelID="UpdatePanel_View_Search" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div id="overlay">
                <div id="modalprogress">
                    <div id="theprogress">
                        <img src="images/dots-4.gif" />
                    </div>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" id="myTab">
        <li class="nav-item">
            <a data-toggle="tab" href="#BasicDetails" class="nav-link active tabfont">CONTRACT DETAILS</a>
        </li>
        <%--  <li class="nav-item disabled">
            <a data-toggle="tab" id="Tab_GeoScope" href="#GeoScope" class="nav-link tabfont">GEO SCOPE</a>
        </li>--%>
        <li class="nav-item">
            <a data-toggle="tab" href="#View" class="nav-link tabfont">VIEW</a>
        </li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
        <div id="AlertNotification"></div>
        <!--================================================Basic  Details===============================================================-->
        <div id="BasicDetails" class="tab-pane active">
            <asp:UpdatePanel ID="UpdatePanel_VendorCustomer" runat="server">
                <ContentTemplate>
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>VENDOR CONTRACT DETAILS</b>
                        </div>
                        <asp:Label ID="lblVendorId" runat="server" CssClass="label labelColor" Visible="false"></asp:Label>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PartyName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_VendorName" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_VendorName" Style="text-transform: uppercase;" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_VendorName','hfVendorName','','Contract_VendorMaster.aspx/getVendorName');" TabIndex="1"></asp:TextBox>
                                            <asp:HiddenField ID="hfVendorName" runat="server" />
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Vendors" runat="server" CssClass="label labelColor">VENDOR TYPE</asp:Label>
                                            <asp:TextBox ID="Txt_VendorType" runat="server" CssClass="form-control input-sm" ReadOnly="true" Text="AUTO"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PartyContact" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label>
                                            <asp:TextBox ID="Txt_PartyContact" runat="server" CssClass="form-control input-sm" ReadOnly="true" Text="AUTO"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_BelongToBranch" runat="server" CssClass="label labelColor">BELONG TO BRANCH</asp:Label>
                                            <asp:TextBox ID="Txt_BelongToBranch" runat="server" CssClass="form-control input-sm" ReadOnly="true" Text="AUTO"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_FromDate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_FromDate" TabIndex="2"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ToDate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_ToDate" TabIndex="3"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_signingDate" runat="server" CssClass="label labelColor">SIGNING DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_signingDate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_signingDate" TabIndex="4"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_CurrentDieselRate" runat="server" CssClass="label labelColor">BASE DIESEL RATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_CurrentDieselRate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_CurrentDieselRate" TabIndex="5"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_MinFreight" runat="server" CssClass="label labelColor">MINIMUM FREIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_MinFreight" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_MinFreight" onkeypress="return validateNumericValue(event)" TabIndex="6"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-4  "></div>
                                        <div class=" col-sm-2 col-md-3 col-lg-1 col-xl-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_Submit" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateContractDetails()) {return false;};" TabIndex="7" OnClick="Btn_Submit_Click">SUBMIT <i class="fa fa-save"></i> </asp:LinkButton>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_ResetGeoScope" runat="server" TabIndex="8" OnClick="Btn_ResetGeoScope_Click">RESET <i class="fa fa-refresh"></i> </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel-heading panelHead">
                            <asp:Label ID="lblContractId" runat="server" CssClass="label labelColor" Visible="false"></asp:Label>
                            <b>CONTRACT CONDITIONS</b>
                        </div>
                        <div class="panel-body ">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Condition" runat="server" CssClass="label labelColor labelColor">CONDITION</asp:Label>
                                            <asp:DropDownList ID="Ddl_Condition" runat="server" CssClass="formDisplay Ddl_Condition" TabIndex="9" AutoPostBack="false">
                                                <asp:ListItem Value="PERKM">PER KM</asp:ListItem>
						                        <asp:ListItem Value="PERKMROUTE">PER KM(ROUTE)</asp:ListItem>
                                                <asp:ListItem Value="PERKG">PER KG</asp:ListItem>
                                                <asp:ListItem Value="PERKGROUTE">PER KG(ROUTE)</asp:ListItem>
						                        <asp:ListItem Value="PERKGRANGE">PER KG(RANGE)</asp:ListItem>
                                                <asp:ListItem Value="PERBOX">PER BOX(QTY)</asp:ListItem>
                                                <asp:ListItem Value="PERQTY">PER DOCKET</asp:ListItem>
                                                <asp:ListItem Value="FIXPUDEL">FIXED (PER PICKUP DELIVERY TRIP)</asp:ListItem>
                                                <asp:ListItem Value="FIXROUTE">FIXED (PER ROUTE)</asp:ListItem>
                                                <asp:ListItem Value="FIXPERDAY">FIXED (PER DAY)</asp:ListItem>
                                                <asp:ListItem Value="FIXPERMONTH">FIXED (PER MONTH)</asp:ListItem>
                                                <asp:ListItem Value="ODACHARGES">ODA CHARGES</asp:ListItem>
						                        <asp:ListItem Value="ODAPERKGRANGE">ODA CHARGES (KM RANGE)</asp:ListItem>
                                                <asp:ListItem Value="LOADFIX">LOADER CHARGES (FIXED)</asp:ListItem>
                                                <asp:ListItem Value="LOADPERKG">LOADER CHARGES (PER KG)</asp:ListItem>
                                                <asp:ListItem Value="LOADPERQTY">LOADER CHARGES (PER ITEM QTY)</asp:ListItem>
                                                <asp:ListItem Value="FIXKMRANGE">FIXED (KM RANGE)</asp:ListItem>
                                                <asp:ListItem Value="FIXKGRANGE">FIXED (KG RANGE)</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="divRoute">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label1" runat="server" CssClass="label labelColor labelColor">ROUTE</asp:Label>
                                            <asp:DropDownList ID="Ddl_Route" runat="server" CssClass="formDisplay Ddl_Route" TabIndex="10">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="divValue">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_RouteValue" runat="server" class="label labelColor labelColor">VALUE</asp:Label>
                                            <asp:TextBox ID="Txt_RouteValue" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_RouteValue" onkeypress="return checkDecimalNumeric(event)" TabIndex="9"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="divFrom">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label2" runat="server" class="label labelColor labelColor">FROM</asp:Label>
                                            <asp:TextBox ID="txtFromKMS" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_RouteValue" onkeypress="return validateNumericValue(event)" TabIndex="11"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="divTo">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label3" runat="server" class="label labelColor labelColor">TO</asp:Label>
                                            <asp:TextBox ID="txtToKMS" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_RouteValue" onkeypress="return validateNumericValue(event)" TabIndex="12"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label4" runat="server" class="label labelColor labelColor">MINIMUM</asp:Label>
                                            <asp:TextBox ID="txtMinimum" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm txtMinimum" onkeypress="return checkDecimalNumeric(event)" TabIndex="13"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="hfAddAccount" runat="server" Value="" />
                                            <asp:LinkButton ID="Btn_Add" runat="server" CssClass="btn btn-info buttonStyle2 Btn_Add" UseSubmitBehavior="false" OnClientClick="if (!validateRouteGeoDetails()) {return true;};" OnClick="Btn_Add_Click" TabIndex="14">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" id="GVDiv" runat="server">
                                    <div class="row">
                                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                        </div>
                                        <asp:GridView ID="GV_RouteDetails" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="true">
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Ddl_Condition" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
        <!--==============================================View Details=======================================================================-->
        <div id="View" class="tab-pane">
            <asp:UpdatePanel ID="UpdatePanel_View_Search" runat="server">
                <ContentTemplate>
                         <div class="panel panelTop" runat="server">
                <div class="panel-heading panelView">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-2 col-lg-3 "></div>

                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_SearchVendorTypes" runat="server" CssClass="label labelColor">VENDOR TYPES</asp:Label>
                                <asp:DropDownList ID="Ddl_SearchVendorTypes" runat="server" CssClass="formDisplay input-sm" TabIndex="1">
                                    <asp:ListItem>TRANSPORTER</asp:ListItem>
                                    <asp:ListItem>HOUSEKEEPING</asp:ListItem>
                                    <asp:ListItem>LABOUR CONTRACTORS</asp:ListItem>
                                    <asp:ListItem>STATIONARY PROVIDERS</asp:ListItem>
                                    <asp:ListItem>HARDWARE/IT PROVIDERS</asp:ListItem>
                                    <asp:ListItem>PETTY SUPPLIERS</asp:ListItem>
                                    <asp:ListItem>OTHERS</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_SearchPartyName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label>
                                <asp:TextBox ID="Txt_SearchPartyName" runat="server" CssClass="form-control input-sm" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="51"></asp:TextBox>
                                <%--  <asp:DropDownList ID="Ddl_SearchPartyName" runat="server" CssClass="formDisplay input-sm" data-live-search="true" TabIndex="58">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                </asp:DropDownList>--%>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_SearchStatus" runat="server" CssClass="label labelColor">STATUS</asp:Label>
                                <asp:DropDownList ID="Ddl_SearchStatus" runat="server" CssClass="formDisplay" TabIndex="52">
                                    <asp:ListItem>ACTIVE</asp:ListItem>
                                    <asp:ListItem>INACTIVE</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4 col-lg-5 ">
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <div class="form-control-sm"></div>
                                <div class="form-control-sm"></div>
                                <asp:Button CssClass="btn btn-info largeButtonStyle" ID="Btn_Search" runat="server" Text="SEARCH" OnClick="Btn_Search_Click" TabIndex="60"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <asp:GridView ID="gridViewVendorContract" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                <Columns>
                                    <asp:TemplateField HeaderText="ACTION">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEditVendorContract" runat="server" CommandArgument='<%#Eval("contractID") %>' ToolTip="Edit" OnClick="lnkEditVendorContract_Click"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton> 
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="contractNo" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="CONTRACT NO">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="vendorName" HeaderText="VENDOR NAME" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="vendorType" HeaderText="VENDOR TYPE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="fromDate" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FROM">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="toDate" HeaderText="TO" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="contractStatus" HeaderText="STATUS" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="signingDate" HeaderText="SIGN DATE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="branchName" HeaderText="BELONG TO BRANCH" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="baseDieselRate" HeaderText="BASE DIESEL RATE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="minimumFreight" HeaderText="MIN FREIGHT" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="onPickup" HeaderText="PICKUP" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="pickupValue" HeaderText="PICKUP VALUE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Username" HeaderText="USER NAME">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <!--==============================================End View=======================================================================-->
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <%-- <script src="Validation/Val_ContractMaster.js"></script>--%>
    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Contract_VendorMaster.js"></script>
    <script type="text/javascript">
        function funNumber(a) {
            if (a.value > 100) {
                a.value = a.value.substring(0, 2);
                return true;
            }
            else {
                if (event.keyCode >= 48 && event.keyCode <= 57) {
                    return true;
                }
                else if (event.keyCode == 46) {
                }
                else {
                    event.returnValue = false;
                    return false;
                }
            }
        }

        BindControls(); 
        function BindControls() {
            $(document).ready(function () {
                $('#<%=Ddl_Condition.ClientID%>').change(function () { // When the value changes 
                    //alert('here'); 
                    var value = $(this).val();
                    $('#divValue').show();
                    $('#divRoute').hide();
                    $('#divFrom').hide();
                    $('#divTo').hide();

                    if (value == 'FIXKMRANGE' || value == 'FIXKGRANGE' || value == 'PERKGRANGE' || value == 'ODAPERKGRANGE') { // Show/hide from to values 
                        $('#divValue').show();
                        $('#divFrom').show();
                        $('#divTo').show();
                    }
                    if (value == 'FIXROUTE' || value == 'PERKMROUTE' || value == 'PERKGROUTE') { // Show/hide routes 
                        $('#divRoute').show();
                    }
                }).change();
            });
        }

        var req = Sys.WebForms.PageRequestManager.getInstance();
        req.add_endRequest(function () {
            BindControls();
        });
    </script>
</asp:Content> 
