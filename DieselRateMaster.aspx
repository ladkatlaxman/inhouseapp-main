<%@ Page Title="Diesel Rate" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="DieselRateMaster.aspx.cs" Inherits="DieselRateMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />

    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_DieselRateDetails" AssociatedUpdatePanelID="UpdatePanel_DieselRateDetails" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_View_Searching" AssociatedUpdatePanelID="UpdatePanel_View_Searching" runat="server" DisplayAfter="0">
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
                <a data-toggle="tab" href="#FuelDetails" class="nav-link active tabfont">FUEL DETAILS</a>
            </li>
            <li class="nav-item">
                <a data-toggle="tab" href="#View" class="nav-link tabfont">VIEW</a>
            </li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <div id="AlertNotification"></div>
            <!-------------------------------------------------------------------------FUEL DETAILS ----------------------------------------------------------------------->
            <div id="FuelDetails" class="tab-pane active">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel_DieselRateDetails" runat="server">
                        <ContentTemplate>
                            <div class="panel panelTop">
                                <div class="panel-heading panelHead">
                                    <b>DIESEL RATE DETAILS</b>
                                </div>

                                <div class="panel-body labelColor">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label><span class="required">*</span>
                                                    <asp:DropDownList ID="Ddl_State" runat="server" CssClass="formDisplay Ddl_State" OnSelectedIndexChanged="Ddl_State_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label><span class="required">*</span>
                                                    <asp:DropDownList ID="Ddl_District" runat="server" CssClass="formDisplay Ddl_District">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_FuelType" runat="server" CssClass="label labelColor">FUEL TYPE</asp:Label><span class="required">*</span>
                                                    <asp:DropDownList ID="Ddl_FuelType" runat="server" CssClass="formDisplay Ddl_FuelType">
                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                        <asp:ListItem>PETROL</asp:ListItem>
                                                        <asp:ListItem>DIESEL</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_FuelDate" runat="server" CssClass="label labelColor">FUEL DATE</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_FuelDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FuelDate" type="date"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="CFTValue" runat="server">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_FuelPrice" runat="server" CssClass="label labelColor">FUEL PRICE</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_FuelPrice" runat="server" CssClass="form-control input-sm Txt_FuelPrice NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return validateNumericValueWithDot(event)" TabIndex="4"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4 "></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-lg"></div>
                                                    <asp:LinkButton CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" ID="Button_Submit1" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateDieselRateDetails()) {return false;};" TabIndex="5" OnClick="Button_Submit1_Click">SUBMIT <i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-lg"></div>
                                                    <asp:LinkButton CssClass="btn btn-info Btn_Reset largeButtonStyle" ID="Btn_Reset" runat="server" TabIndex="6" OnClick="Btn_Reset_Click">RESET <i class="fa fa-refresh"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>                           
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Ddl_State" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="Btn_Reset" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>

                </div>
            </div>
            <!-------------------------------------------------------------------------VIEW DETAILS ----------------------------------------------------------------------->
            <div id="View" class="tab-pane">
                <div class="panel panelTop" runat="server">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel_View_Searching" runat="server">
                            <ContentTemplate>
                                <div class="panel-heading panelView">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-lg-1 col-xl-3 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor">STATE</asp:Label><span class="required">*</span>
                                                    <asp:DropDownList ID="Ddl_SearchState" runat="server" CssClass="formDisplay" OnSelectedIndexChanged="Ddl_SearchState_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor">DISTRICT</asp:Label><span class="required">*</span>
                                                    <asp:DropDownList ID="Ddl_SearchDistrict" runat="server" CssClass="formDisplay">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_SearchFuelDate" runat="server" CssClass="label labelColor">FUEL DATE</asp:Label>
                                                    <asp:TextBox ID="Txt_SearchFuelDate" runat="server" TextMode="Date" Style="text-transform: uppercase;" CssClass="form-control input-sm" TabIndex="52"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4 col-lg-5 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle" Text="SEARCH" TabIndex="54" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" id="ViewData" runat="server">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <asp:GridView ID="GV_FuelPrice" runat="server" DataKeyNames="fuelPriceID" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="GV_FuelPrice_Sorting" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="GV_FuelPrice_PageIndexChanging" SortedAscendingCellStyle-CssClass="" PagerSettings-Mode="NumericFirstLast">
                                                <Columns>                                                 
                                                    <asp:BoundField DataField="fuelPriceID">
                                                        <HeaderStyle CssClass="hidden" />
                                                        <ItemStyle CssClass="hidden" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="districtID">
                                                        <HeaderStyle CssClass="hidden" />
                                                        <ItemStyle CssClass="hidden" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="districtName" HeaderText="DISTRICT NAME" SortExpression="districtName">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fuelType" HeaderText="FUEL TYPE" SortExpression="fuelType">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fuelDate" HeaderText="FUEL DATE" SortExpression="fuelDate">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fuelPrice" HeaderText="FUEL PRICE" SortExpression="fuelPrice">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Left" CssClass="gridviewPagingStyle" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Ddl_SearchState" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>               
            </div>
        </div>


    </div>
    <script src="Validation/Val_DieselRate.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

