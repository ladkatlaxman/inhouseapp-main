<%@ Page Title="Vehicle Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Vehicle_Master.aspx.cs" Inherits="OPERATIONS_VehicleMaster" %>

<%--<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>--%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <script type="text/javascript">

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
    </script>

    <style type="text/css">
        .ajax__fileupload_dropzone {
            display: none;
        }
    </style>
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>

        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Vehicle_Details" AssociatedUpdatePanelID="UpdatePanel_Vehicle_Details" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Supporting_Details" AssociatedUpdatePanelID="UpdatePanel_Supporting_Details" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_ViewDetails" AssociatedUpdatePanelID="UpdatePanel_ViewDetails" runat="server" DisplayAfter="0">
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

        <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Inherit" EnableCdn="true"></asp:ScriptManager>

        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#VehicleDetails" class="nav-link active tabfont">VEHICLE MASTER</a>
                </li>
                <li class="nav-item disabled">
                    <a data-toggle="tab" href="#SupportingDetails" class="nav-link tabfont">SUPPORTING DETAIL</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--=============================================================Vehicle Details==================================================================-->
                <div id="VehicleDetails" class="tab-pane active">
                    <div id="Vehicle" runat="server">
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>VEHICLE DETAIL</b>
                            </div>

                            <div>
                                <asp:UpdatePanel ID="UpdatePanel_Vehicle_Details" runat="server">
                                    <ContentTemplate>
                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_VehicleNo" runat="server" CssClass="label labelColor">VEHICLE NO</asp:Label><span class="required">*</span>

                                                            <div class="row">
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha1" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha1" placeholder="MH" Style="width: 45px; text-transform: uppercase;" onkeypress="return checkNum()" MaxLength="2" TabIndex="1"></asp:TextBox><%--onkeypress="return checkNum()"--%>
                                                                </div>
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:HiddenField ID="HiddenField_Txt_NewVehicleNoDigit1" runat="server" />
                                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit1" runat="server" onchange="Txt_NewVehicleNoDigit1()" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_NewVehicleNoDigit1" placeholder="12" Style="width: 45px; text-transform: uppercase;" MaxLength="2" AutoPostBack="true" OnTextChanged="Txt_NewVehicleNoDigit1_TextChanged" TabIndex="2"></asp:TextBox>
                                                                </div>
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha2" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha2" placeholder="EK" Style="width: 45px; text-transform: uppercase;" onkeypress="return checkNum()" MaxLength="2" TabIndex="3"></asp:TextBox><%--onkeypress="return checkNum()"--%>
                                                                </div>
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:HiddenField ID="HiddenField_Txt_NewVehicleNoDigit2" runat="server" />
                                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit2" runat="server" onchange="Txt_NewVehicleNoDigit2()" CssClass="form-control input-sm Txt_NewVehicleNoDigit2" placeholder="1234" Style="width: 50px; text-transform: uppercase;" MaxLength="4" onkeypress="return validateNumericValue(event)" AutoPostBack="true" OnTextChanged="Txt_NewVehicleNoDigit2_TextChanged" TabIndex="4"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_VehicleCategory" runat="server" CssClass="label labelColor">VEHICLE CATEGORY</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_VehicleCategory" runat="server" Style="text-transform: uppercase;" class="formDisplay Ddl_VehicleCategory" AutoPostBack="true" OnSelectedIndexChanged="Ddl_VehicleCategory_SelectedIndexChanged" TabIndex="5">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem Selected="True">FIXED</asp:ListItem>
                                                                <asp:ListItem>MARKET</asp:ListItem>
                                                                <asp:ListItem>OWNED</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="TransporterName" runat="server">
                                                            <div class="row">

                                                                <div class="col-sm-11 col-md-11 col-lg-10 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:HiddenField ID="HiddenField_Txt_Transportername_Search" runat="server" />
                                                                    <asp:HiddenField ID="HiddenField_RadioButtonList_Transportername" runat="server" />

                                                                    <asp:Label ID="Lbl_TransporterName" runat="server" CssClass="label labelColor">TRANSPORTER NAME</asp:Label><span class="required">*</span>
                                                                    <asp:DropDownList ID="Ddl_TransporterName" runat="server" Style="text-transform: uppercase;" CssClass="formDisplay Ddl_TransporterName" TabIndex="6">
                                                                    </asp:DropDownList>

                                                                    <%--  <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                    <asp:TextBox ID="Txt_Transportername" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_Transportername" TabIndex="5"></asp:TextBox>

                                                                    <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_Transportername" runat="server" Enabled="true" TargetControlID="Txt_Transportername"
                                                                        PopupControlID="Panel_Transportername" OffsetY="38" OffsetX="-2">
                                                                    </ajaxToolkit:PopupControlExtender>

                                                                    <asp:Panel ID="Panel_Transportername" runat="server" CssClass="form-control " Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                        BackColor="#ffffff" Style="display: none;">

                                                                        <div runat="server" class="ddlSearchTextBox">
                                                                            <asp:TextBox ID="Txt_Transportername_Search" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="6"
                                                                                AutoCompleteType="Disabled" AutoPostBack="true" onchange="Txt_Transportername_Search()" onkeypress="return onlyAlphaValue()" Style="text-transform: uppercase; width: 90%;" OnTextChanged="Txt_Transportername_Search_TextChanged"></asp:TextBox>
                                                                        </div>
                                                                        <div runat="server" class="ddlDropDownList">
                                                                            <asp:RadioButtonList ID="RadioButtonList_Transportername" runat="server" onclick="RadioButtonList_Transportername()" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_Transportername_SelectedIndexChanged" TabIndex="7">
                                                                            </asp:RadioButtonList>
                                                                        </div>
                                                                    </asp:Panel>--%>
                                                                </div>
                                                                <div class="col-sm-0.5 col-md-0.5">
                                                                    <div class="form-control-static"></div>
                                                                    <asp:ImageButton ID="Btn_AddNewTransporter" runat="server" ImageUrl="~/images/add.png" ToolTip="Create New Transporter" OnClick="Btn_AddNewTransporter_Click" TabIndex="7" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_LinkButton_VehicleHiringType_Submit" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField_select_all_VehicleHiringType" runat="server" Value="" />

                                                            <asp:Label ID="Lbl_VehicleHiringType" runat="server" CssClass="label labelColor">VEHICLE HIRING TYPE</asp:Label><span class="required">*</span>
                                                            <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <%-- NOT EDITABLE TEXTBOX AND DISPLAY SELECTED VALUE --%>
                                                            <asp:TextBox ID="Txt_VehicleHiringType" runat="server" Style="background-color: white; text-transform: uppercase;" ReadOnly="true" TabIndex="8" AutoCompleteType="Disabled" placeholder="SELECT VEHICLE HIRING TYPE" CssClass="form-control input-sm Txt_VehicleHiringType"></asp:TextBox>
                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_VehicleUsedFor" runat="server" Enabled="true" TargetControlID="Txt_VehicleHiringType" PopupControlID="Panel_VehicleHiringType" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>
                                                            <asp:Panel ID="Panel_VehicleHiringType" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto" BackColor="#ffffff" Style="display: none;">
                                                                <div runat="server" class="ddlSearchTextBox">
                                                                    <%-- SUBMIT BUTTON --%>
                                                                    <asp:LinkButton ID="LinkButton_VehicleHiringType_Submit" runat="server" ToolTip="Submit" TabIndex="11" OnClientClick="LinkButton_VehicleHiringType_Submit()" OnClick="LinkButton_VehicleHiringType_Submit_Click"><%--
                                                                                                                                                                                        OnTextChanged="Txt_AttachWaybillNo_Search_TextChanged" onchange="Txt_AttachWaybillNo_Search()"                                                                                                                             --%>
                                                                                <img src="images/submit.png" style="height:18px;" class="searchSubmitButtonMultiDropDown" /></asp:LinkButton>
                                                                     <asp:TextBox ID="Txt_Search_EmpBelongToBranch" runat="server" Style="text-transform: uppercase;" TabIndex="3" placeholder="SEARCH" CssClass="form-control input-sm FirstNoSpaceAndZero txtSearchMultiDropDown"
                                                                    AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                                    <%-- SELECT ALL CHECKBOX --%>
                                                                    <asp:CheckBox ID="select_all_VehicleHiringType" runat="server" Width="190px" style="font-size:11px;color:black" AutoPostBack="true" TabIndex="9" Text="SELECT ALL" onchange="select_all_VehicleHiringType()" OnCheckedChanged="select_all_VehicleHiringType_CheckedChanged" />

                                                                    <%-- DISPLAY VALUE FROM DATABASE --%>
                                                                    <asp:CheckBoxList ID="CheckBoxList_VehicleHiringType" runat="server" style="font-size:11px;color:black" TabIndex="10">
                                                                        <asp:ListItem>ROUTE</asp:ListItem>
                                                                        <asp:ListItem>PICKUP</asp:ListItem>
                                                                        <asp:ListItem>DELIVERY</asp:ListItem>
                                                                    </asp:CheckBoxList>
                                                                </div>

                                                            </asp:Panel>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_VehicleType_Search" runat="server" />
                                                            <asp:HiddenField ID="HiddenField_RadioButtonList_VehicleType" runat="server" />

                                                            <asp:Label ID="Lbl_VehicleType" runat="server" CssClass="label labelColor">VEHICLE TYPE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_VehicleType" runat="server" Style="text-transform: uppercase;" CssClass="formDisplay Ddl_VehicleType" TabIndex="12">
                                                            </asp:DropDownList>
                                                            <%--  <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <asp:TextBox ID="Txt_VehicleType" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_VehicleType" TabIndex="11"></asp:TextBox>

                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_VehicleType" runat="server" Enabled="true" TargetControlID="Txt_VehicleType"
                                                                PopupControlID="Panel_VehicleType" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>

                                                            <asp:Panel ID="Panel_VehicleType" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                                BackColor="#ffffff" Style="display: none;">

                                                                <div runat="server" class="ddlSearchTextBox">
                                                                    <asp:TextBox ID="Txt_VehicleType_Search" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="12"
                                                                        AutoCompleteType="Disabled" AutoPostBack="true" onchange="Txt_VehicleType_Search()" onkeypress="return checkAlphaNumericWithSpace()" Style="text-transform: uppercase;" OnTextChanged="Txt_VehicleType_Search_TextChanged"></asp:TextBox>
                                                                </div>
                                                                <div runat="server" class="ddlDropDownList">
                                                                    <asp:RadioButtonList ID="RadioButtonList_VehicleType" runat="server" onclick="RadioButtonList_VehicleType()" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_VehicleType_SelectedIndexChanged" TabIndex="13">
                                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </asp:Panel>--%>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        </div>


                                                    </div>
                                                </div>
                                                <!---Buttons --->
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class=" col-sm-3 col-md-3 col-lg-4  "></div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Tab1Save" runat="server" />
                                                            <asp:LinkButton ID="Button_Tab1Save" runat="server" CssClass="btn btn-info largeButtonStyle Btn_VehicleDetailsSave" UseSubmitBehavior="false" OnClientClick="if (!validateVehicleDetails()) {return false;} else{ __doPostBack('this.name','');};" OnClick="Button_Tab1Save_Click" TabIndex="16">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>

                                                            <asp:HiddenField ID="HiddenField_Btn_VehicleReset" runat="server" />
                                                            <asp:LinkButton ID="Btn_VehicleReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="Btn_VehicleReset()" OnClick="Btn_VehicleReset_Click" TabIndex="17">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_VehicleNext" runat="server" CssClass="btn btn-info largeButtonStyle" TabIndex="18">NEXT&nbsp;<i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!---Buttons End--->
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="Txt_NewVehicleNoDigit2" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Txt_NewVehicleNoDigit1" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Ddl_VehicleCategory" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Btn_AddNewTransporter" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="Button_Tab1Save" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="Btn_VehicleReset" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="Btn_VehicleNext" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>

                <!--==============================================End Vehicle Information=======================================================================-->
                <!--=========================================================Start Supporting Details=================================================================-->
                <div id="SupportingDetails" class="tab-pane">
                    <div id="Supporting" runat="server">
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>SUPPORTING  DETAIL</b>
                            </div>

                            <div>
                                <asp:UpdatePanel ID="UpdatePanel_Supporting_Details" runat="server">
                                    <ContentTemplate>
                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Permit_No" runat="server" CssClass="label labelColor">NATIONAL PERMIT NO</asp:Label>
                                                            <asp:TextBox ID="Txt_Permit_No" runat="server" Style="text-transform: uppercase;" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_Permit_No" TabIndex="26"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_PermitDateValidFrom" runat="server" CssClass="label labelColor">PERMIT DATE VALID FROM</asp:Label>
                                                            <asp:TextBox ID="Txt_PermitDateValidFrom" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm" type="date" TabIndex="27"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_PermitDateValidUpto" runat="server" />
                                                            <asp:Label ID="Lbl_PermitDateValidUpto" runat="server" CssClass="label labelColor">PERMIT DATE VALID UPTO</asp:Label>
                                                            <asp:TextBox ID="Txt_PermitDateValidUpto" runat="server" onchange="Txt_PermitDateValidUpto()" Style="text-transform: uppercase;" CssClass="form-control input-sm" type="date" OnTextChanged="Txt_PermitDateValidUpto_TextChanged" AutoPostBack="true" TabIndex="28"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <ajaxToolkit:AjaxFileUpload ID="Vehicle_NationalPermitNo_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Vehicle_NationalPermitNo_Uploader_UploadComplete" TabIndex="29" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <a id="Vehicle_NationalPermitNo_Label" runat="server" target="_blank"></a>
                                                        </div>
                                                    </div>
                                                    <div class="row">

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">

                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_InsNo" runat="server" CssClass="label labelColor">INSURENCE NO</asp:Label>
                                                            <asp:TextBox ID="Txt_InsNo" runat="server" Style="text-transform: uppercase;" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_InsNo" TabIndex="30"></asp:TextBox>

                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_InsDateValidFrom" runat="server" CssClass="label labelColor">INS. DATE VALID FROM</asp:Label>
                                                            <asp:TextBox ID="Txt_InsDateValidFrom" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InsDateValidFrom" type="date" TabIndex="31"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_InsDateValidUpto" runat="server" />
                                                            <asp:Label ID="Lbl_InsDateValidUpto" runat="server" CssClass="label labelColor"> INS. DATE VALID UPTO</asp:Label>
                                                            <asp:TextBox ID="Txt_InsDateValidUpto" runat="server" onchange="Txt_InsDateValidUpto()" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InsDateValidUpto" type="date" OnTextChanged="Txt_InsDateValidUpto_TextChanged" AutoPostBack="true" TabIndex="32"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>

                                                            <ajaxToolkit:AjaxFileUpload ID="Vehicle_InsuranceNo_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Vehicle_InsuranceNo_Uploader_UploadComplete" TabIndex="33" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <a id="Vehicle_InsuranceNo_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>

                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lb_PUCNo" runat="server" CssClass="label labelColor">PUC NO.</asp:Label>
                                                            <asp:TextBox ID="Txt_PUCNo" runat="server" Style="text-transform: uppercase;" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_PUCNo" TabIndex="34"></asp:TextBox>

                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_PUCDateValidFrom" runat="server" CssClass="label labelColor"> PUC DATE VALID FROM</asp:Label>
                                                            <asp:TextBox ID="Txt_PUCDateValidFrom" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PUCDateValidFrom" type="date" TabIndex="35"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_PUCDateValidUpto" runat="server" />
                                                            <asp:Label ID="Lbl_PUCDateValidUpto" runat="server" CssClass="label labelColor">PUC DATE VALID UPTO</asp:Label>
                                                            <asp:TextBox ID="Txt_PUCDateValidUpto" runat="server" onchange="Txt_PUCDateValidUpto()" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PUCDateValidUpto" type="date" OnTextChanged="Txt_PUCDateValidUpto_TextChanged" AutoPostBack="true" TabIndex="36"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>

                                                            <ajaxToolkit:AjaxFileUpload ID="Vehicle_PUC_No_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete3" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Vehicle_PUC_No_Uploader_UploadComplete" TabIndex="37" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <a id="Vehicle_PUC_No_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">

                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_FitnessCertificateNo" runat="server" CssClass="label labelColor"> FITNESS CERTIFICATE NO</asp:Label>
                                                            <asp:TextBox ID="Txt_FitnessCertificateNo" runat="server" Style="text-transform: uppercase;" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_FitnessCertificateNo" TabIndex="38"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_FitnessChkDateValidFrom" runat="server" CssClass="label labelColor">FITNESS CER. VALID FROM</asp:Label>
                                                            <asp:TextBox ID="Txt_FitnessChkDateValidFrom" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FitnessChkDateValidFrom" type="date" TabIndex="39"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_FitnessChkDateValidUpto" runat="server" />
                                                            <asp:Label ID="Lbl_FitnessChkDateValidUpto" runat="server" CssClass="label labelColor"> FITNESS CER. VALID UPTO</asp:Label>
                                                            <asp:TextBox ID="Txt_FitnessChkDateValidUpto" runat="server" onchange="Txt_FitnessChkDateValidUpto()" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FitnessChkDateValidUpto" type="date" OnTextChanged="Txt_FitnessChkDateValidUpto_TextChanged" AutoPostBack="true" TabIndex="40"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <ajaxToolkit:AjaxFileUpload ID="Vehicle_FitneesCertificateNo_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete4" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                TabIndex="41" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <a id="Vehicle_FitneesCertificateNo_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!---Buttons --->
                                        <div class="form-group">
                                            <div class="row">

                                                <div class=" col-sm-3 col-md-3 col-lg-4  "></div>

                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_SupportingPrev" runat="server" CssClass="btn btn-info  prev-step largeButtonStyle" TabIndex="42"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-3 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Submit1" runat="server" />
                                                    <asp:LinkButton ID="Button_Submit1" runat="server" CssClass="btn btn-info largeButtonStyle Btn_StaffSubmit" UseSubmitBehavior="false" OnClientClick="ShowProgress();" TabIndex="43">SUBMIT&nbsp; <i class="fa fa-save"></i></asp:LinkButton>
                                                </div>

                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>

                                                    <asp:HiddenField ID="HiddenField_Btn_SupportingReset" runat="server" />
                                                    <asp:LinkButton ID="Btn_SupportingReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="Btn_SupportingReset()" OnClick="Btn_SupportingReset_Click" TabIndex="44">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                        <!---Buttons End-->
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="Txt_PermitDateValidUpto" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Txt_InsDateValidUpto" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Txt_PUCDateValidUpto" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Txt_FitnessChkDateValidUpto" EventName="TextChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="Btn_SupportingPrev" />
                                        <asp:PostBackTrigger ControlID="Button_Submit1" />
                                        <asp:AsyncPostBackTrigger ControlID="Btn_SupportingReset" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>

                        </div>
                    </div>
                </div>
                <!--=====================================End Supporting Details================================================================================-->

                <!--=====================================Searching Parameter==========================================================================-->
                <div id="View" class="tab-pane">
                    <div id="hideshow" runat="server">
                        <div class="panel panelTop" runat="server">

                            <div>
                                <asp:UpdatePanel ID="UpdatePanel_ViewDetails" runat="server">
                                    <ContentTemplate>
                                        <div class="panel-heading panelView">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-lg-1 col-xl-3 "></div>
                                                     
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_SearchCategory" runat="server" CssClass="label labelColor">CATEGORY</asp:Label>
                                                            <asp:DropDownList ID="Ddl_SearchCategory" runat="server" class="formDisplay" TabIndex="51">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>FIXED</asp:ListItem>
                                                                <asp:ListItem>MARKET</asp:ListItem>
                                                                <asp:ListItem>OWNED</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">                                                          
                                                            <div class="form-control-lg"></div>
                                                            <div class="form-control-lg"></div>
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                            <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClientClick="Btn_Search()" Text="SEARCH" TabIndex="54" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                        </div>
                                                        <%--<div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                                        <asp:TextBox ID="Txt_FromDate" runat="server" TextMode="Date" CssClass="form-control" TabIndex="52"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                                        <asp:TextBox ID="Txt_ToDate" runat="server" TextMode="Date" CssClass="form-control" TabIndex="53"></asp:TextBox>
                                    </div>--%>
                                                    </div>

                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" id="ViewData" runat="server">

                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">

                                                    <asp:GridView ID="GV_VehicleMaster" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="GV_VehicleMaster_Sorting" AutoGenerateColumns="false" AllowPaging="true" SortedAscendingCellStyle-CssClass="" DataKeyNames="vehicleID" PagerSettings-Mode="NumericFirstLast">

                                                        <Columns>
                                                            <asp:TemplateField HeaderText="ACTION">
                                                                <ItemTemplate>
                                                                   
                                                                  <asp:LinkButton ID="Edit_Data" runat="server" CommandArgument='<%#Eval("vehicleID")%>' OnClick="Edit_Data_Click"><i class="fa fa-pencil" style="font-size:18px; color:darkblue"></i></asp:LinkButton>
                                                                            
                                                                </ItemTemplate>
                                                                 <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                                 <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="vehicleID" HeaderText="VEHICLE ID" SortExpression="vehicleID">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="vehicleNo" HeaderText="VEHICLE NO" SortExpression="vehicleNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="vehicleCategory" HeaderText="VEHICLE CATEGORY" SortExpression="vehicleCategory">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="vendorName" HeaderText="TRANSPORTER NAME" SortExpression="vendorName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="useForRoute" HeaderText="USED FOR ROUTE" SortExpression="useForRoute">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="useForPickup" HeaderText="USED FOR PICKUP" SortExpression="useForPickup">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="useForDelivery" HeaderText="USED FOR DELIVERY" SortExpression="useForDelivery">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VehicleType" HeaderText="VEHICLE TYPE" SortExpression="VehicleType">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitNo" HeaderText="PERMIT NO" SortExpression="permitNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitValidFromDate" HeaderText="PERMIT VALID FROM DATE" SortExpression="permitValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitValidToDate" HeaderText="PERMIT VALID TO DATE" SortExpression="permitValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceNo" HeaderText="INSURANCE NO" SortExpression="insuranceNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceValidFromDate" HeaderText="INSURANCE VALID FROM DATE" SortExpression="insuranceValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceValidToDate" HeaderText="INSURANCE VALID TO DATE" SortExpression="insuranceValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucNo" HeaderText="PUC NO" SortExpression="pucNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucValidFromDate" HeaderText="PUC VALID FROM DATE" SortExpression="pucValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucValidToDate" HeaderText="PUC VALID TO DATE" SortExpression="pucValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateNo" HeaderText="FITNESS CERTIFICATE NO" SortExpression="fitnessCertificateNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateValidFromDate" HeaderText="FITNESS CERTIFICATE VALID FROM DATE" SortExpression="fitnessCertificateValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateValidToDate" HeaderText="FITNESS CERTIFICATE VALID TO ATE" SortExpression="fitnessCertificateValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitFileName" HeaderText="PERMIT FILENAME" SortExpression="permitFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceFileName" HeaderText="INSURANCE FILENAME" SortExpression="insuranceFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucFileName" HeaderText="PUC FILENAME" SortExpression="pucFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateFileName" HeaderText="FITNESS CERTIFICATE FILENAME" SortExpression="fitnessCertificateFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="branchName" HeaderText="USER BRANCH" SortExpression="branchName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                        </Columns>

                                                        <PagerStyle HorizontalAlign="Left" CssClass="gridviewPagingStyle" />
                                                    </asp:GridView>


                                                    <asp:GridView ID="GV_Export" runat="server" AutoGenerateColumns="false" DataKeyNames="vehicleID" Visible="false">

                                                        <Columns>

                                                            <asp:BoundField DataField="vehicleNo" HeaderText="VEHICLE NO" SortExpression="vehicleNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="vehicleCategory" HeaderText="VEHICLE CATEGORY" SortExpression="vehicleCategory">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="vendorName" HeaderText="TRANSPORTER NAME" SortExpression="vendorName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="useForRoute" HeaderText="USED FOR ROUTE" SortExpression="useForRoute">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="useForPickup" HeaderText="USED FOR PICKUP" SortExpression="useForPickup">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="useForDelivery" HeaderText="USED FOR DELIVERY" SortExpression="useForDelivery">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="VehicleType" HeaderText="VEHICLE TYPE" SortExpression="VehicleType">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitNo" HeaderText="PERMIT NO" SortExpression="permitNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitValidFromDate" HeaderText="PERMIT VALID FROM DATE" SortExpression="permitValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitValidToDate" HeaderText="PERMIT VALID TO DATE" SortExpression="permitValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceNo" HeaderText="INSURANCE NO" SortExpression="insuranceNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceValidFromDate" HeaderText="INSURANCE VALID FROM DATE" SortExpression="insuranceValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceValidToDate" HeaderText="INSURANCE VALID TO DATE" SortExpression="insuranceValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucNo" HeaderText="PUC NO" SortExpression="pucNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucValidFromDate" HeaderText="PUC VALID FROM DATE" SortExpression="pucValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucValidToDate" HeaderText="PUC VALID TO DATE" SortExpression="pucValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateNo" HeaderText="FITNESS CERTIFICATE NO" SortExpression="fitnessCertificateNo">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateValidFromDate" HeaderText="FITNESS CERTIFICATE VALID FROM DATE" SortExpression="fitnessCertificateValidFromDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateValidToDate" HeaderText="FITNESS CERTIFICATE VALID TO ATE" SortExpression="fitnessCertificateValidToDate">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permitFileName" HeaderText="PERMIT FILENAME" SortExpression="permitFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="insuranceFileName" HeaderText="INSURANCE FILENAME" SortExpression="insuranceFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="pucFileName" HeaderText="PUC FILENAME" SortExpression="pucFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fitnessCertificateFileName" HeaderText="FITNESS CERTIFICATE FILENAME" SortExpression="fitnessCertificateFileName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="branchName" HeaderText="USER BRANCH" SortExpression="branchName">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                        </Columns>

                                                        <PagerStyle HorizontalAlign="Left" CssClass="gridviewPagingStyle" />
                                                    </asp:GridView>


                                                </div>
                                            </div>

                                            <div id="printPage">
                                                <div class="form-group">

                                                    <div class="row">
                                                        <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                        <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                            <asp:ImageButton ID="btn_ExporttoExcel" runat="server" CssClass="btn" Text="EXPORT TO EXCEL" ImageUrl="images/excel.png" ToolTip="Export To Excel" TabIndex="55"></asp:ImageButton>
                                                        </div>

                                                        <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                            <asp:ImageButton ID="Btn_Printbtn" runat="server" CssClass="fa fa-print" Text="PRINT" ImageUrl="images/Print.png" ToolTip="Print" TabIndex="56"></asp:ImageButton>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>

                </div>
                <!--======================================================End Searching==============================================================================-->
            </div>

        </div>
    </div>


    <!--===========================================================Driver Details==================================================================================-->
    <!-- The Modal -->
    <%--<div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">

            <!--Modal Content-->
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title labelcolor">New Driver</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>

                                <asp:Label ID="Lbl_PopDriverName" runat="server" CssClass="label labelColor">Driver Name</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_PopDriverName" runat="server" CssClass="form-control Txt_PopDriverName" onkeypress="return checkNumAlpha()"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>

                                <asp:Label ID="Lbl_PopDriverContactNo" runat="server" CssClass="label labelColor">Contact No</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_PopDriverContactNo" runat="server" CssClass="form-control Txt_PopDriverContactNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_DriverIssuingState" runat="server" CssClass="label labelColor">Issuing State</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_DriverIssuingState" runat="server" CssClass="form-control selectpicker Ddl_DriverIssuingState" data-live-search="true">
                                    <asp:ListItem>Select...</asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="row">
                                    <div class="col-sm-10 col-md-10 col-lg-10 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_PopLicenceNo" runat="server" CssClass="label labelColor">Licence No</asp:Label><span class="required">*</span>
                                        <asp:TextBox ID="Txt_PopLicenceNo" runat="server" CssClass="form-control input-sm Txt_PopLicenceNo"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-0 col-md-0">
                                        <div class="form-control-static"></div>
                                        <asp:ImageButton ID="Img_UploadLicence" runat="server" OnClientClick="return clk();" ImageUrl="~/images//UploadDoc4.png" />
                                        <asp:Image ID="Img_UploadSuccessfully" runat="server" Visible="false" src="../images/true.png" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>

                                <asp:Label ID="Lbl_LicenceValidFromDate" runat="server" CssClass="label labelColor">Valid From Date</asp:Label>
                                <asp:TextBox ID="Txt_LicenceValidFromDate" type="date" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>

                                <asp:Label ID="Lbl_LicenceValidToDate" runat="server" CssClass="label labelColor">Valid From To Date</asp:Label>
                                <asp:TextBox ID="Txt_LicenceValidToDate" Type="date" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <div class="form-group">
                        <div class="row">
                            <div class="<%--col-sm-1 col-md-2 col-lg-3   "></div>
                            <div class=" col-sm-3 col-md-2 col-lg-2">
                                <div class="form-control-sm"></div>
                                <asp:Button ID="Btn_SubmitDriver" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateDriverDetails()) {return false;} else{ __doPostBack('this.name','');};" CssClass="btn btn-info buttonStyle Btn_SubmitDriver" Text="Submit"></asp:Button>
                            </div>

                            <div class=" col-sm-3 col-md-2 col-lg-2">
                                <div class="form-control-sm"></div>

                                <asp:Button ID="Btn_CloseDriver" runat="server" CssClass="btn btn-info buttonStyle" Text="Close" data-dismiss="modal"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>--%>
    <!--=================================================== End Driver Popup Modal===============================================================-->
    <!--=======================================================popup modal of Owner========================================================================================-->
    <!-- Modal -->
    <%--    <div class="modal fade" id="Owner" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title labelcolor">Owner Details</h4>
                </div>

                <!-- Modal body -->
                <div class="modal-body">


                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PopOwnerName" runat="server" CssClass="label labelColor">Owner Name</asp:Label><span class="required">*</span>

                                <asp:TextBox ID="Txt_PopOwnerName" runat="server" CssClass="form-control input-sm Txt_PopOwnerName" onkeypress="return checkNumAlpha()"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PopOwnerContactNo" runat="server" CssClass="label labelColor">Owner Contact No</asp:Label><span class="required">*</span>

                                <asp:TextBox ID="Txt_PopOwnerContactNo" runat="server" CssClass="form-control input-sm Txt_PopOwnerContactNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="form-group">
                            <div class="row">
                                <div class="<%--col-sm-1 col-md-2 col-lg-3   "></div>
                                <div class=" col-sm-3 col-md-2 col-lg-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Button ID="Btn_SubmitOwnerDetails" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateOwnerDetails()) {return false;} else{ __doPostBack('this.name','');};" CssClass="btn btn-info buttonStyle Btn_SubmitOwnerDetails" Text="Submit"></asp:Button>
                                </div>
                                <div class=" col-sm-3 col-md-2 col-lg-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Button ID="Btn_CloseOwnerDetails" runat="server" CssClass="btn btn-info buttonStyle" data-dismiss="modal" Text="Close"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>--%>
    <!--=================================================== End Owner Popup Modal===============================================================-->

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->


    <script>
        function vehicle() {
            $('[href="#VehicleDetails"]').tab('show');
        }
        function supporting() {
            $('[href="#SupportingDetails"]').tab('show');
        }
        function staff() {
            $('[href="#StaffDetails"]').tab('show');
        }
    </script>

    <script src="Validation/Val_Vehicle.js"></script>

    <script type="text/javascript">
        function uploaderror() {
            alert("sonme error occured while uploading file!");
        }
    </script>


    <script type="text/javascript">
        function uploadcomplete(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Vehicle_NationalPermitNo_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete2(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Vehicle_InsuranceNo_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete3(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Vehicle_PUC_No_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete4(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Vehicle_FitneesCertificateNo_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }
    </script>

    <script type="text/javascript">
        function ShowProgress() {
            document.getElementById('<% Response.Write(UpdateProgress_Supporting_Details.ClientID); %>').style.display = "inline";
        }
    </script>

    <script src="js/AlertNotifictaion.js"></script>

    <script>



        function Txt_NewVehicleNoDigit1() {
            $('[id*=HiddenField_Txt_NewVehicleNoDigit1]').val("1");
            console.log($('[id*=HiddenField_Txt_NewVehicleNoDigit1]').val());
        }

        function Txt_NewVehicleNoDigit2() {
            $('[id*=HiddenField_Txt_NewVehicleNoDigit2]').val("1");
            console.log($('[id*=HiddenField_Txt_NewVehicleNoDigit2]').val());
        }

        function Txt_Transportername_Search() {
            $('[id*=HiddenField_Txt_Transportername_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_Transportername_Search]').val());
        }

        function RadioButtonList_Transportername() {
            $('[id*=HiddenField_RadioButtonList_Transportername]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_Transportername]').val());
        }

        function LinkButton_VehicleHiringType_Submit() {
            $('[id*=HiddenField_LinkButton_VehicleHiringType_Submit]').val("1");
            console.log($('[id*=HiddenField_LinkButton_VehicleHiringType_Submit]').val());
        }

        function select_all_VehicleHiringType() {
            $('[id*=HiddenField_select_all_VehicleHiringType]').val("1");
            console.log($('[id*=HiddenField_select_all_VehicleHiringType]').val());
        }

        function Txt_VehicleType_Search() {
            $('[id*=HiddenField_Txt_VehicleType_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_VehicleType_Search]').val());
        }

        function RadioButtonList_VehicleType() {
            $('[id*=HiddenField_RadioButtonList_VehicleType]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_VehicleType]').val());
        }

        function Tab1Save() {
            $('[id*=HiddenField_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Tab1Save]').val());
        }

        function Btn_VehicleReset() {
            $('[id*=HiddenField_Btn_VehicleReset]').val("1");
            console.log($('[id*=HiddenField_Btn_VehicleReset]').val());
        }

        function Txt_Vehicle_Owner_Search() {
            $('[id*=HiddenField_Txt_Vehicle_Owner_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_Vehicle_Owner_Search]').val());
        }
        function RadioButtonList_Vehicle_Owner() {
            $('[id*=HiddenField_RadioButtonList_Vehicle_Owner]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_Vehicle_Owner]').val());
        }

        function Tab2Save() {
            $('[id*=HiddenField_Tab2Save]').val("1");
            console.log($('[id*=HiddenField_Tab2Save]').val());
        }
        function Btn_StaffReset() {
            $('[id*=HiddenField_Btn_StaffReset]').val("1");
            console.log($('[id*=HiddenField_Btn_StaffReset]').val());
        }

        function Txt_PermitDateValidUpto() {
            $('[id*=HiddenField_Txt_PermitDateValidUpto]').val("1");
            console.log($('[id*=HiddenField_Txt_PermitDateValidUpto]').val());
        }

        function Txt_InsDateValidUpto() {
            $('[id*=HiddenField_Txt_InsDateValidUpto]').val("1");
            console.log($('[id*=HiddenField_Txt_InsDateValidUpto]').val());
        }

        function Txt_PUCDateValidUpto() {
            $('[id*=HiddenField_Txt_PUCDateValidUpto]').val("1");
            console.log($('[id*=HiddenField_Txt_PUCDateValidUpto]').val());
        }

        function Txt_FitnessChkDateValidUpto() {
            $('[id*=HiddenField_Txt_FitnessChkDateValidUpto]').val("1");
            console.log($('[id*=HiddenField_Txt_FitnessChkDateValidUpto]').val());
        }

        function Submit1() {
            $('[id*=HiddenField_Submit1]').val("1");
            console.log($('[id*=HiddenField_Submit1]').val());
        }

        function Btn_SupportingReset() {
            $('[id*=HiddenField_Btn_SupportingReset]').val("1");
            console.log($('[id*=HiddenField_Btn_SupportingReset]').val());
        }

        function Txt_SearchVehicleNo_Search() {
            $('[id*=HiddenField_Txt_SearchVehicleNo_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchVehicleNo_Search]').val());
        }

        function RadioButtonList_SearchVehicleNo() {
            $('[id*=HiddenField_RadioButtonList_SearchVehicleNo]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchVehicleNo]').val());
        }

        function Txt_SearchTransporterName_Search() {
            $('[id*=HiddenField_Txt_SearchTransporterName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchTransporterName_Search]').val());
        }

        function RadioButtonList_SearchTransporterName() {
            $('[id*=HiddenField_RadioButtonList_SearchTransporterName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchTransporterName]').val());
        }

        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }

    </script>

</asp:Content>

