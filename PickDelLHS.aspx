<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PickDelLHS.aspx.cs" Inherits="PickDelLHS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function clr() {
            $('#<%=Txt_NewVehicleNoDigit2.ClientID%>').val('');
        }

        function pageLoad() {
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                var $target = $(e.target);
                if ($target.parent().hasClass('disabled')) {
                    return false;
                }
            });
            $(".next-step").click(function (e) {
                var $active = $('.nav-tabs li.active');
                $active.next().removeClass('disabled');
                if ($active.next().attr('id') == $('[id*=UploadDocument]').attr('id')) {
                    $('[id*=hfLastStep]').val('true');
                }
                nextTab($active);                                                                   /////////// Open if not working properly //////////////
                return false;
            });

            //$('#butEdit_CustomerDataton').submit(function () {
            //    $("#myTab").tabs({
            //        active: $("#home")
            //    });
            //});

            //$(".first-tab").click(function (e) {
            //    var $active=$('')
            //    });

            $(".prev-step").click(function (e) {
                var $active = $('.nav-tabs li.active');
                prevTab($active);
                return false;
            });

            var tabId = '';
            $('[id*=myTab] li').each(function () {
                if ($('[id*=hfTabs]').val() != '') {

                    if ($(this).attr('id') == $('[id*=hfTabs]').val()) {
                        $(this).attr('class', 'active');
                        var tabpaneId = $(this).find('a').attr('href').split('#')[1];
                        $('.tab-pane').each(function () {
                            if ($(this).attr('id') == tabpaneId) {
                                $(this).attr('class', 'tab-pane active');
                            }
                            else {
                                $(this).attr('class', 'tab-pane');
                            }
                        });
                    }
                    else {
                        if ($('[id*=UploadDocument]').attr('id') == $(this).attr('id')) {
                            if ($('[id*=hfLastStep]').val() == 'true') {
                                $(this).attr('class', '');
                            }
                        } else {
                            $(this).attr('class', '');
                        }
                    }
                }
            });

            $('.maintainTab').click(function () {
                $('[id*=hfTabs]').val($(this).closest('li').attr('id'));

            });
        }

        function nextTab(elem) {
            $(elem).next().find('a[data-toggle="tab"]').click();
            $('[id*=hfTabs]').val($(elem).next().attr('id'));

        }
        function prevTab(elem) {
            $(elem).prev().find('a[data-toggle="tab"]').click();
            $('[id*=hfTabs]').val($(elem).prev().attr('id'));
        }

        function mapVehicle(VehicleRequestID) {
            window.open("MapWithClickablePushpins.aspx?VehicleRequestID=" + VehicleRequestID, "_blank");
        }
    </script>
    <link href="css/AlertNotification.css" rel="stylesheet" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_VehicleHiringDetail" AssociatedUpdatePanelID="UpdatePanel_VehicleHiringDetail" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Account" AssociatedUpdatePanelID="UpdatePanel_Account" runat="server" DisplayAfter="0">
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
        <!---Update Progress 3 ---->
        <asp:UpdateProgress ID="UpdateProgress_StaffDetails" AssociatedUpdatePanelID="UpdatePanel_StaffDetails" runat="server" DisplayAfter="0">
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
        <!---Update Progress 4 ---->
        <asp:UpdateProgress ID="UpdateProgress_PickUpDetails" AssociatedUpdatePanelID="UpdatePanel_PickUpDetails" runat="server" DisplayAfter="0">
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
        <!---Update Progress 5 ---->
        <asp:UpdateProgress ID="UpdateProgress_PickUpWaybillDetails" AssociatedUpdatePanelID="UpdatePanel_PickUpWaybillDetails" runat="server" DisplayAfter="0">
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
        <!---Update Progress 6 ---->
        <asp:UpdateProgress ID="UpdateProgress_VehicleHiringView" AssociatedUpdatePanelID="UpdatePanel_VehicleHiringView" runat="server" DisplayAfter="0">
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
        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#home" class="nav-link active tabfont">VEHICLE HIRING REQUEST</a>
                </li>
                <li id="PickUpDetail" runat="server" class="nav-item">
                    <a data-toggle="tab" href="#Pickup_Tab" class="nav-link tabfont">PICKUP DETAIL</a>
                </li>
                <li id="PickUpWaybillDetail" runat="server" class="nav-item">
                    <a data-toggle="tab" href="#PickupWaybill_Tab" class="nav-link tabfont">PICKUP WAYBILL DETAIL</a>
                </li>
                <li id="DeliveryDetail" runat="server" class="nav-item">
                    <a data-toggle="tab" href="#Delivery_Tab" class="nav-link tabfont">DELIVERY DETAIL</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View_Tab" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--==============================================Pickup/Delivery Request Detail=======================================================================-->
                <div id="home" class="tab-pane active">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>VEHICLE HIRING REQUEST</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <asp:UpdatePanel ID="UpdatePanel_VehicleHiringDetail" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_VehicleNo" runat="server" CssClass="label labelColor">VEHICLE NO</asp:Label><span class="required">*</span>
                                                    <div class="row">
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                            <asp:TextBox ID="Txt_NewVehicleNoAlpha1" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha1" placeholder="MH" Style="width: 45px; text-transform: uppercase;" onkeypress="return onlyAlphaValue()" onchange="clr()" MaxLength="2" TabIndex="1"></asp:TextBox><%--onkeypress="return checkNum()"--%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                            <asp:HiddenField ID="HiddenField_Txt_NewVehicleNoDigit1" runat="server" />
                                                            <asp:TextBox ID="Txt_NewVehicleNoDigit1" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_NewVehicleNoDigit1" placeholder="12" Style="width: 45px; text-transform: uppercase;" MaxLength="2" onkeypress="return validateNumericValue(event)" onchange="clr()" TabIndex="2"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                            <asp:TextBox ID="Txt_NewVehicleNoAlpha2" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha2" placeholder="EK" Style="width: 45px; text-transform: uppercase;" onkeypress="return onlyAlphaValue()" onchange="clr()" MaxLength="2" TabIndex="3"></asp:TextBox><%--onkeypress="return checkNum()"--%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                            <asp:HiddenField ID="HiddenField_Txt_NewVehicleNoDigit2" runat="server" />
                                                            <asp:TextBox ID="Txt_NewVehicleNoDigit2" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoDigit2" placeholder="1234" Style="width: 50px; text-transform: uppercase;" MaxLength="4" onkeypress="return validateNumericValue(event)" AutoPostBack="true" OnTextChanged="Txt_NewVehicleNoDigit2_TextChanged" TabIndex="4"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_VendorName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label>
                                                    <asp:TextBox ID="Txt_VendorName" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VendorName" onkeypress="return onlyAlphaValue()"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_VehicleCategory" runat="server" CssClass="label labelColor">VEHICLE CATEGORY</asp:Label>
                                                    <asp:TextBox ID="Txt_VehicleCategory" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VehicleCategory" onkeypress="return onlyAlphaValue()"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_VehicleType" runat="server" CssClass="label labelColor">VEHICLE TYPE</asp:Label>
                                                    <asp:TextBox ID="Txt_VehicleType" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VehicleType" onkeypress="return onlyAlphaValue()"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_NoOfLabour" runat="server" CssClass="label labelColor">NO OF LABOURS</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_NoOfLabour" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_NoOfLabour" Text="0" onkeypress="return validateNumericValue(event)" TabIndex="5"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_HiringDate" runat="server" CssClass="label labelColor">VEHICLE HIRING DATE</asp:Label>
                                                    <asp:TextBox ID="Txt_HiringDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_HiringDate" TabIndex="6"></asp:TextBox>
                                                </div>
                                               <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_Route" runat="server" CssClass="label labelColor">ROUTE</asp:Label>
                                                    <asp:DropDownList ID="Ddl_Route" runat="server" CssClass="formDisplay input-sm Ddl_Route" TabIndex="7">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_ReasonForVehicle" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                                    <asp:TextBox ID="Txt_ReasonForVehicle" runat="server" Style="text-transform: uppercase;" TabIndex="7" CssClass="form-control input-sm Txt_ReasonForVehicle" Placeholder="Give Reason for Vehicle Request" TextMode="MultiLine"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="Txt_NewVehicleNoDigit1" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Txt_NewVehicleNoDigit2" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="panel-heading panelHead">
                            <b>ACCOUNT DETAIL</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel_Account" runat="server">
                                        <ContentTemplate>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_accountCode" runat="server" CssClass="label labelColor">ACCOUNT CODE</asp:Label>
                                                          <asp:HyperLink ID="hl_RateType" runat="server" NavigateUrl="~/ReportData.aspx?value=VEHICLERATETYPE" Target="_blank">List</asp:HyperLink>
                                                        <asp:TextBox ID="Txt_AccountCode" runat="server" AutoCompleteType="Disabled" Style="text-transform: uppercase;" TabIndex="8" CssClass="form-control input-sm Txt_AccountCode" onchange="ReadDataonchange('Txt_AccountCode', 'hfAccountName','', 'PickDelLHS.aspx/getRateType');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfAccountName" runat="server" />
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Charges" runat="server" CssClass="label labelColor">CHARGES</asp:Label>
                                                        <asp:TextBox ID="Txt_Charges" runat="server" TabIndex="9" CssClass="form-control input-sm Txt_Charges"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                                        <asp:TextBox ID="Txt_Remark" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm" TabIndex="10" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="hfAddAccount" runat="server" Value="" />
                                                        <asp:LinkButton ID="Btn_AddAccount" runat="server" CssClass="btn btn-info buttonStyle2 Btn_AddAccount" UseSubmitBehavior="false" OnClientClick="if (!validateAccount()) {return false;};" OnClick="Btn_AddAccount_Click" TabIndex="11">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" id="AccountDetails" runat="server">
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                                    </div>
                                                    <asp:GridView ID="GV_Account" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="SR.NO">
                                                                <ItemTemplate>
                                                                    <%#Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="AccountID" HeaderText="ID">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="AccountName" HeaderText="ACCOUNT NAME">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Charges" HeaderText="CHARGES">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Remark" HeaderText="REMARK">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="Btn_AddAccount" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                        <div class="panel-heading panelHead">
                            <b>STAFF DETAIL</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel_StaffDetails" runat="server">
                                        <ContentTemplate>
                                            <div class="form-group" id="staffDetail" runat="server">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_StaffType" runat="server" CssClass="label labelColor">STAFF TYPE</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_StaffType" runat="server" CssClass="formDisplay input-sm Ddl_StaffType" AutoPostBack="true" OnSelectedIndexChanged="Ddl_StaffType_SelectedIndexChanged" TabIndex="12">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem Selected="True">DRIVER</asp:ListItem>
                                                            <asp:ListItem>PICKUP PERSON</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Name" runat="server" CssClass="label labelColor">NAME</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_DriverName" runat="server" CssClass="formDisplay input-sm Ddl_DriverName" AutoPostBack="true" OnSelectedIndexChanged="Ddl_DriverName_SelectedIndexChanged" TabIndex="13">
                                                        </asp:DropDownList>

                                                        <asp:DropDownList ID="ddl_PickPersonName" runat="server" CssClass="formDisplay input-sm ddl_PickPersonName" AutoPostBack="true" OnSelectedIndexChanged="ddl_PickPersonName_SelectedIndexChanged" TabIndex="6" Visible="false">
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_ContactNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label>
                                                        <asp:TextBox ID="Txt_ContactNo" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_ContactNo" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="hfButtonAdd" runat="server" Value="" />
                                                        <asp:LinkButton ID="Button_Add" runat="server" CssClass="btn btn-info buttonStyle2 Btn_VehicleDetailsSave" UseSubmitBehavior="false" OnClientClick="if (!validatePickDelLHSStaff()) {return false;};" OnClick="Button_Add_Click" TabIndex="14">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" id="StaffDetails" runat="server">
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                                    </div>
                                                    <asp:GridView ID="GV_StaffDetail" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="SR.NO">
                                                                <ItemTemplate>
                                                                    <%#Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="StaffType" HeaderText="STAFF TYPE">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="DriverID" HeaderText="DRIVER ID">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PickUpPersonID" HeaderText="PICKUP PERSON ID">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="StaffName" HeaderText="STAFF NAME">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="StaffContactNo" HeaderText="STAFF CONTACT NO">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="15" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validatePickDelLHS()) {return false;};" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>

                                                    <%--OnClientClick="if (!validatePickDelLHS()) {return false;} else{ __doPostBack('this.name','');};"--%>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:LinkButton ID="Btn_Reset" runat="server" CssClass="btn btn-info largeButtonStyle" TabIndex="16" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="Ddl_StaffType" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="Button_Submit" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--==============================================Pickup Request List=======================================================================-->

                <div id="Pickup_Tab" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>ATTACHED PICKUP REQUEST LIST</b>
                        </div>
                        <div class="panel-body labelColor">

                            <div class="form-horizontal" role="form">
                                <asp:UpdatePanel ID="UpdatePanel_PickUpDetails" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group" id="AlreadyAdd" runat="server" visible="false">
                                            <asp:GridView ID="GV_AlreadyAdd" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <%-- <asp:BoundField DataField="pickupID" HeaderText="PICKUP ID">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden" />
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="PickType" HeaderText="PICKUP TYPE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustContactNo" HeaderText="CONSIGNOR CONTACT NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustTelephone" HeaderText="CONSIGNOR TELEPHONE NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickPINCode" HeaderText="CONSIGNOR PINCODE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pickupArea" HeaderText="CONSIGNOR AREA">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickAddress" HeaderText="CONSIGNOR ADDRESS">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div class="form-group" id="PickUpTab" runat="server" visible="false">
                                            <asp:GridView ID="GV_PickUpDetail" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="CheckSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="SellectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="pickupID" HeaderText="PICKUP ID">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickType" HeaderText="PICKUP TYPE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustContactNo" HeaderText="CONSIGNOR CONTACT NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustTelephone" HeaderText="CONSIGNOR TELEPHONE NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickPINCode" HeaderText="CONSIGNOR PINCODE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pickupArea" HeaderText="CONSIGNOR AREA">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickAddress" HeaderText="CONSIGNOR ADDRESS">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div class="form-group" id="PickUpErrorMassage" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-1 col-lg-1"></div>
                                                <div class="col-sm-11 col-md-11 col-lg-11">
                                                    <asp:Label ID="PickUpError" runat="server" Text="This Vehicle Not Used For Pickup" Style="color: red;"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" id="Pickup_NoDataFound" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-1 col-lg-1"></div>
                                                <div class="col-sm-11 col-md-11 col-lg-11">
                                                    <asp:Label ID="Pickup_NoData" runat="server" Text="No Pickup"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="form-group" id="PickUpSubmit" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Button_Submit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <%--OnClientClick="if (!validatePickDelLHS()) {return false;} else{ __doPostBack('this.name','');};"--
                                            </div>
                                        </div>--%>
                                    </ContentTemplate>
                                    <Triggers>
                                        <%--  <asp:AsyncPostBackTrigger ControlID="Button_Submit" EventName="Click" />--%>
                                    </Triggers>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                    </div>
                </div>

                <!--==============================================Pickup Request List=======================================================================-->

                <div id="PickupWaybill_Tab" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>ATTACHED PICKUP WAYBILL LIST</b>
                        </div>
                        <div class="panel-body labelColor">

                            <div class="form-horizontal" role="form">
                                <asp:UpdatePanel ID="UpdatePanel_PickUpWaybillDetails" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group" id="PickUpWaybillTab" runat="server" visible="false">
                                            <asp:GridView ID="GV_PickUpWaybillDetail" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="CheckWaybillSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="CheckWaybillSelectAll_CheckedChanged" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="WaybillId" HeaderText="WAYBILL ID" SortExpression="WaybillId">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="WaybillNo" HeaderText="WAYBILL NO" SortExpression="WaybillNo">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickDate" HeaderText="WAYBILL DATE" SortExpression="PickDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME" SortExpression="CustName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ConsigneeName" HeaderText="CONSIGNEE NAME" SortExpression="ConsigneeName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div class="form-group" id="Div3" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-1 col-lg-1"></div>
                                                <div class="col-sm-11 col-md-11 col-lg-11">
                                                    <asp:Label ID="Label3" runat="server" Text="This Vehicle Not Used For Pickup" Style="color: red;"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" id="Div4" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-1 col-lg-1"></div>
                                                <div class="col-sm-11 col-md-11 col-lg-11">
                                                    <asp:Label ID="Label4" runat="server" Text="No Pickup"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="form-group" id="PickUpSubmit" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Button_Submit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <%--OnClientClick="if (!validatePickDelLHS()) {return false;} else{ __doPostBack('this.name','');};"--
                                            </div>
                                        </div>--%>
                                    </ContentTemplate>
                                    <Triggers>
                                        <%--  <asp:AsyncPostBackTrigger ControlID="Button_Submit" EventName="Click" />--%>
                                    </Triggers>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                    </div>
                </div>

                <!--==============================================Delivery Request List=======================================================================-->
                <div id="Delivery_Tab" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>ATTACHED DELIVERY WAYBILL LIST</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <asp:UpdatePanel ID="UpdatePanel_DeliveryWaybills" runat="server">
                                    <ContentTemplate>
                                        <%--<div class="form-group" id="Div1" runat="server" visible="false">
                                            <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%-- <asp:BoundField DataField="pickupID" HeaderText="PICKUP ID">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden" />
                                                    </asp:BoundField>--%
                                                    <asp:BoundField DataField="PickType" HeaderText="PICKUP TYPE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustContactNo" HeaderText="CONSIGNOR CONTACT NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustTelephone" HeaderText="CONSIGNOR TELEPHONE NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickPINCode" HeaderText="CONSIGNOR PINCODE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pickupArea" HeaderText="CONSIGNOR AREA">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickAddress" HeaderText="CONSIGNOR ADDRESS">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>--%>
                                        <div class="form-group" id="DeliveryTab" runat="server" visible="false">
                                            <asp:GridView ID="GV_DeliveryWaybill" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="CheckSelectAllWaybill" runat="server" AutoPostBack="true" OnCheckedChanged="CheckSelectAllWaybill_CheckedChanged" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="CheckBox_Waybill" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="WaybillId" HeaderText="WAYBILL ID">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="WaybillNo" HeaderText="WAYBILL NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustContactNo" HeaderText="CONSIGNOR CONTACT NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ConsigneeName" HeaderText="CONSIGNEE NAME">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ConsigneeContactNo" HeaderText="CONSIGNEE CONTACT NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DelPINCode" HeaderText="CONSIGNEE PINCODE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DelArea" HeaderText="CONSIGNEE AREA">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DelAddress" HeaderText="CONSIGNEE ADDRESS">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PaymentMode" HeaderText="PAYMENT MODE">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                        <div class="form-group" id="DeliveryErrorMassage" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-1 col-lg-1"></div>
                                                <div class="col-sm-11 col-md-11 col-lg-11">
                                                    <asp:Label ID="Label1" runat="server" Text="This Vehicle Not Used For Delivery" Style="color: red;"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group" id="Delivery_NoDataFound" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-1 col-lg-1"></div>
                                                <div class="col-sm-11 col-md-11 col-lg-11">
                                                    <asp:Label ID="Label2" runat="server" Text="No Delivery"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- <div class="form-group" id="DeliverySubmit" runat="server" visible="false">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_DeliverySubmit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" OnClick="Btn_DeliverySubmit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <%--OnClientClick="if (!validatePickDelLHS()) {return false;} else{ __doPostBack('this.name','');};"--
                                            </div>
                                        </div>--%>
                                    </ContentTemplate>
                                    <Triggers>
                                        <%--                                        <asp:AsyncPostBackTrigger ControlID="Button_Submit" EventName="Click" />--%>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
                <!--==============================================View Data=======================================================================-->
                <div id="View_Tab" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>VIEW DATA</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <asp:UpdatePanel ID="UpdatePanel_VehicleHiringView" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <asp:GridView ID="GV_PickDelView" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <%--  <asp:TemplateField HeaderText="VIEW DATA">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="ViewData_Edit" runat="server" CommandArgument='<%#Eval("VehicleRequestID")%>' OnClick="ViewData_Edit_Click">EDIT</asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="VIEW">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnk_VehicleRequestID" runat="server" OnClientClick='<%#Eval("VehicleRequestID","javascript:mapVehicle({0});")%>' Text='VIEW'></asp:LinkButton>
                                                            <%-- <asp:HyperLink runat="server" data-toggle="modal" data-target="#modalForViewData" NavigateUrl='<%#Eval("waybillID","javascript:return YourFunction(\"{0}\");")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>' />--%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="sessionDetail.UserBranch" HeaderText="BRANCH NAME" SortExpression="sessionDetail.UserBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="hiringDate" HeaderText="HIRING DATE" SortExpression="hiringDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO" SortExpression="VehicleNo">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Mpin" HeaderText="M-PIN" SortExpression="Mpin">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="totalAttachPickup" HeaderText="ATTACH TOTAL PICKUP" SortExpression="totalAttachPickup">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="totalAttachWaybill" HeaderText="ATTACH TOTAL WAYBILL" SortExpression="totalAttachWaybill">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Status" HeaderText="STATUS" SortExpression="Status">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="sessionDetail.CreationDateTime" HeaderText="CREATION DATETIME" SortExpression="sessionDetail.CreationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers></Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="FJS_File/PickupRequestCRMBranch.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Val_PickDelLHS.js"></script>
    <script type="text/javascript">
        function getConfirmation() {
            var retVal = confirm("Are you sure you want to Approve this Vehicle?");
            if (retVal == true) {
                SetTarget();
                return true;
            } else
                return false;
        }
        function SetTarget() { document.forms[0].target = "_blank"; }
    </script>
    <%--<script type="text/javascript">
        function AddRow() {
            var i = 0;
            console.log(i);
            //Reference the GridView.
            var gridView = document.getElementById("<%=Gv_StaffDetail.ClientID %>");
            i = 1;
            console.log(gridView);
            console.log(i);
            //Reference the TBODY tag.
            var tbody = gridView.getElementsByTagName("tbody")[0];
            console.log(tbody);

            //Reference the first row.
            var row = tbody.getElementsByTagName("tr")[1];
            console.log(row);

            //Check if row is dummy, if yes then remove.
            if (row.getElementsByTagName("td")[0].innerHTML.replace(/\s/g, '') == "") {
                tbody.removeChild(row);
            }

            //Clone the reference first row.
            row = row.cloneNode(true);
            var staffTypeId = document.getElementById("<%=Ddl_StaffType.ClientID %>");
            var StaffType = staffTypeId.options[staffTypeId.selectedIndex].text;
            console.log(StaffType);
            if (StaffType == 'DRIVER') {
                console.log(StaffType);

                SetValue(row, 1, "StaffType", StaffType);
                //Add the Name value to first cell.
                var txtName = document.getElementById("<%=Txt_DriverName.ClientID %>");
                console.log(txtName);
                SetValue(row, 2, "StaffName", txtName);

                //Add the Country value to second cell.
                var txtContactNo = document.getElementById("<%=Txt_DriverContactNo.ClientID %>");
                console.log(txtContactNo);
                SetValue(row, 3, "StaffContactNo", txtContactNo);
            }
            else if (StaffType == 'PICKUP PERSON') {
                console.log(StaffType);

                SetValue(row, 1, "StaffType", StaffType);
                //Add the Name value to first cell.
                var txtName = document.getElementById("<%=Txt_PickPersonName.ClientID %>");
                console.log(txtName);
                SetValue(row, 2, "StaffName", txtName);

                //Add the Country value to second cell.
                var txtContactNo = document.getElementById("<%=Txt_PickPersonContactNo.ClientID %>");
                console.log(txtName);
                SetValue(row, 3, "StaffContactNo", txtContactNo);
            }

            //Add the row to the GridView.
        tbody.appendChild(row);
        return false;
    };

    function SetValue(row, index, name, textbox) {
        //Reference the Cell and set the value.
        row.cells[index].innerHTML = textbox.value;

        //Create and add a Hidden Field to send value to server.
        var input = document.createElement("input");
        input.type = "hidden";
        input.name = name;
        input.value = textbox.value;
        row.cells[index].appendChild(input);

        //Clear the TextBox.
        textbox.value = "";
    }
    </script>--%>
</asp:Content>

