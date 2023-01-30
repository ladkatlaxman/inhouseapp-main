<%@ Page Title="Driver Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Driver_Master.aspx.cs" Inherits="OPERATIONS_DriverMaster" %>

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Driver_Details" AssociatedUpdatePanelID="UpdatePanel_Driver_Details" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Driver_Details_Button" AssociatedUpdatePanelID="UpdatePanel_Driver_Details_Button" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Upload_Documents" AssociatedUpdatePanelID="UpdatePanel_Upload_Documents" runat="server" DisplayAfter="0">
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

        <!---Update Progress 5 ---->
        <asp:UpdateProgress ID="UpdateProgress_View" AssociatedUpdatePanelID="UpdatePanel_View" runat="server" DisplayAfter="0">
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
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#DriverDetails" class="nav-link active tabfont">DRIVER DETAILS</a>
                </li>
                <li class="nav-item disabled">
                    <a data-toggle="tab" href="#UploadDoc" class="nav-link tabfont">UPLOAD DOCUMENTS</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#ViewDetails" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--=========================================================================Driver Details==========================================================================-->
                <div id="DriverDetails" class="tab-pane active">

                    <div id="Driver" runat="server">
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>DRIVER DETAILS</b>
                                <div style="text-align: right" runat="server" id="dateTime" visible="false">
                                    <asp:Label ID="Lbl_CurrentDateTime" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="panel-body labelColor">


                                <div class="form-horizontal" role="form">

                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_Driver_Details" runat="server">
                                            <ContentTemplate>

                                                <div class="form-group">
                                                    <div class="row">
                                                        <%-- <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_DriverCode" runat="server" CssClass="label labelColor">DRIVER CODE</asp:Label>
                                        <asp:TextBox ID="Txt_DriverCode" runat="server" CssClass="form-control input-sm" Text="Auto" ReadOnly="true"></asp:TextBox>
                                    </div>--%>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DriverName" runat="server" CssClass="label labelColor">DRIVER NAME</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_DriverName" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_DriverName FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="1"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DriverContactNo" runat="server" CssClass="label labelColor">DRIVER CONTACT NO.</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_DriverContactNo" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_DriverContactNo FirstNoSpaceAndZero" placeholder="+91" MaxLength="10" MinLength="10" onkeypress="return validateNumericValue(event)" TabIndex="2"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DriverEmailId" runat="server" CssClass="label labelColor">EMAIL ID</asp:Label>
                                                            <asp:TextBox ID="Txt_DriverEmailId" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_DriverEmailId" onkeypress="return checkEmailId()" TabIndex="3"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>                                                       
                                                            <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="ddl_State" runat="server" CssClass="formDisplay ddl_state">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                            </asp:DropDownList>

                                                            <!----DropDown Start----->
                                                            <%--<img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                        <asp:TextBox ID="Txt_State" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" Text="SELECT" CssClass="form-control Txt_State" TabIndex="4"></asp:TextBox>

                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_State" runat="server" Enabled="true" TargetControlID="Txt_State"
                                            PopupControlID="Panel_State" OffsetY="38" OffsetX="-2">
                                        </ajaxToolkit:PopupControlExtender>

                                        <asp:Panel ID="Panel_State" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto"
                                            BackColor="#ffffff" Style="display: none;">

                                            <div runat="server" class="ddlSearchTextBox">
                                                <asp:TextBox ID="Txt_State_Search" runat="server" onchange="Txt_State_Search()" Style="text-transform: uppercase" placeholder="Search" 
                                                    CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="5"
                                                    AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_State_Search_TextChanged"></asp:TextBox>
                                            </div>

                                            <div runat="server" class="ddlDropDownList">
                                                <asp:RadioButtonList ID="RadioButtonList_State" runat="server" onclick="RadioButtonList_State()" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_State_SelectedIndexChanged" TabIndex="6">
                                                </asp:RadioButtonList>                                                                                              
                                            </div>
                                        </asp:Panel>--%>
                                                            <!----DropDown End----->

                                                        </div>



                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">CITY</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_City" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_City FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="7"></asp:TextBox>

                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DriverPincode" runat="server" CssClass="label labelColor">PINCODE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_Pincode" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_Pincode" MaxLength="6" onkeypress="return validateNumericValue(event)" TabIndex="8"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DriverAddress" runat="server" CssClass="label labelColor">DRIVER ADDRESS</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_DriverAddress" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_DriverAddress FirstNoSpaceAndZero" TextMode="MultiLine" TabIndex="9"></asp:TextBox>
                                                            '                  
                                                        </div>


                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_BelongToBranch_Search" runat="server" />
                                                            <asp:HiddenField ID="HiddenField_RadioButtonList_BelongToBranch" runat="server" />

                                                            <asp:Label ID="Lbl_BelongToBranch" runat="server" CssClass="label labelColor">BELONG TO BRANCH</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="ddl_BelongToBranch" runat="server" CssClass="formDisplay ddl_BelongToBranch">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <!----DropDown Start----->
                                                            <%-- <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                        <asp:TextBox ID="Txt_BelongToBranch" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" Text="SELECT" placeholder="SELECT" CssClass="form-control Txt_BelongToBranch" TabIndex="10"></asp:TextBox>

                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_BelongToBranch" runat="server" Enabled="true" TargetControlID="Txt_BelongToBranch"
                                            PopupControlID="Panel_BelongToBranch" OffsetY="38" OffsetX="-2">
                                        </ajaxToolkit:PopupControlExtender>

                                        <asp:Panel ID="Panel_BelongToBranch" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto"
                                            BackColor="#ffffff" Style="display: none;">

                                            <div runat="server" class="ddlSearchTextBox">
                                                <asp:TextBox ID="Txt_BelongToBranch_Search" runat="server" onchange="Txt_BelongToBranch_Search()" Style="text-transform: uppercase" placeholder="Search" 
                                                    CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="11"
                                                    AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_BelongToBranch_Search_TextChanged"></asp:TextBox>
                                            </div>

                                            <div runat="server" class="ddlDropDownList">
                                                <asp:RadioButtonList ID="RadioButtonList_BelongToBranch" runat="server" onclick="RadioButtonList_BelongToBranch()" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_BelongToBranch_SelectedIndexChanged" TabIndex="12">
                                                </asp:RadioButtonList>                                                                                              
                                            </div>
                                        </asp:Panel>--%>
                                                            <!----DropDown End----->
                                                        </div>
                                                    </div>
                                                </div>

                                            </ContentTemplate>
                                            <Triggers>
                                                <%--  <asp:AsyncPostBackTrigger ControlID="RadioButtonList_State" EventName="SelectedIndexChanged"/>--%>
                                                <%-- <asp:PostBackTrigger ControlID="RadioButtonList_State" />      --%>
                                                <%--<asp:AsyncPostBackTrigger ControlID="Txt_State_Search" EventName="TextChanged"/>--%>
                                                <%--<asp:AsyncPostBackTrigger ControlID="RadioButtonList_BelongToBranch" EventName="SelectedIndexChanged"/>
                                        <asp:AsyncPostBackTrigger ControlID="Txt_BelongToBranch_Search" EventName="TextChanged"/>--%>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>

                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_Driver_Details_Button" runat="server">
                                            <ContentTemplate>

                                                <div class="form-group">

                                                    <div class="row">
                                                        <div class=" col-sm-1 col-md-3 col-lg-4"></div>

                                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Tab1Save" runat="server" />
                                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Save" ID="Button_Tab1Save" runat="server" Text="SAVE" UseSubmitBehavior="false" TabIndex="13" OnClientClick="if (!validateDriverDetails()) {return false;};" OnClick="Button_Tab1Save_Click">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                        </div>

                                                        <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>

                                                            <asp:HiddenField ID="HiddenField_Btn_Reset" runat="server" />
                                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_Reset" runat="server" Text="RESET" OnClientClick="Btn_Reset()" TabIndex="14" OnClick="Btn_Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton runat="server" ID="Btn_Next" TabIndex="15" CssClass="btn btn-info largeButtonStyle">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>

                                                        </div>
                                                    </div>
                                                </div>

                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Button_Tab1Save" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Btn_Reset" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Btn_Next" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>

                                </div>


                            </div>
                        </div>
                    </div>
                </div>
                <!--=====================================================Upload Documents Details============================================================================-->
                <div id="UploadDoc" class="tab-pane">

                    <div>
                        <asp:UpdatePanel ID="UpdatePanel_Upload_Documents" runat="server">
                            <ContentTemplate>

                                <div class="panel panelTop">
                                    <!--================================Driver Documents===========================================================================================================-->
                                    <div class="panel-heading panelHead">
                                        <b>DRIVER DOCUMENTS</b>
                                    </div>

                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_LicenceId" runat="server" CssClass="label labelColor">LICENCE NO</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_LicenceId" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_LicenceId" MaxLength="13" Style="text-transform: uppercase;" onkeypress="return checkAlphaNumeric()" TabIndex="16"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_LicenceValidDateFrom" runat="server" CssClass="label labelColor">LICENCE VALID DATE FROM</asp:Label>
                                                        <asp:TextBox ID="Txt_LicenceValidDateFrom" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_LicenceValidDateFrom" type="date" TabIndex="17"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Txt_LicenceValidDateTo" runat="server" />
                                                        <asp:Label ID="Lbl_LicenceValidDateTo" runat="server" CssClass="label labelColor">LICENCE VALID DATE TO</asp:Label>
                                                        <asp:TextBox ID="Txt_LicenceValidDateTo" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_LicenceValidDateTo" onchange="Txt_LicenceValidDateTo()" type="date" OnTextChanged="Txt_LicenceValidDateTo_TextChanged" AutoPostBack="true" TabIndex="18"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Driver_LicenceNo_Uploader" runat="server" InsertText="Upload" OnFileUploaded="Driver_LicenceNo_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton8" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Driver_LicenceNo_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Driver_LicenceNo_Uploader_UploadComplete" TabIndex="19" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Driver_LicenceNo_Label" runat="server" Text=""></asp:Label>--%>
                                                        <a id="Driver_LicenceNo_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>

                                                        <asp:Label ID="Lbl_PanCardNo" runat="server" CssClass="label labelColor">PANCARD NO</asp:Label>
                                                        <asp:TextBox ID="Txt_PanCardNo" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_PanCardNo" MaxLength="10" Style="text-transform: uppercase;" onkeypress="return checkAlphaNumeric()" TabIndex="20"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Driver_PanCard_Uploader" runat="server" InsertText="Upload" OnFileUploaded="Driver_PanCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="Btn_Upload" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Driver_PanCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Driver_PanCard_Uploader_UploadComplete" TabIndex="21" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Driver_PanCard_Label" runat="server" Text=""></asp:Label>--%>
                                                        <a id="Driver_PanCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_AdharcardNo" runat="server" CssClass="label labelColor">AADHAARCARD NO</asp:Label>
                                                        <asp:TextBox ID="Txt_AdharcardNo" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_AdharcardNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="22"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Driver_AadhaarCard_Uploader" runat="server" InsertText="Upload" OnFileUploaded="Driver_AadhaarCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton4" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Driver_AadhaarCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete3" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Driver_AadhaarCard_Uploader_UploadComplete" TabIndex="23" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Driver_AadhaarCard_Label" runat="server" Text=""></asp:Label>--%>
                                                        <a id="Driver_AadhaarCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--=====================================End Driver Documents==============================================-->

                                    <div class="form-group">
                                        <div class="row">
                                            <div class=" col-sm-3 col-md-3 col-lg-4  "></div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_DocPrev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="24"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                <%--<button type="button" class="btn btn-info  prev-step largeButtonStyle"><i class="fa fa-arrow-circle-left"></i>PREV</button>--%>
                                            </div>
                                            <div class=" col-sm-2 col-md-3 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_Submit1" runat="server" />
                                                <asp:LinkButton Class="btn btn-info largeButtonStyle" ID="Button_Submit1" runat="server" TabIndex="25" OnClick="Button_Submit1_Click" OnClientClick="ShowProgress();">SUBMIT <i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>

                                                <asp:HiddenField ID="HiddenField_Btn_DocReset" runat="server" />
                                                <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_DocReset" runat="server" TabIndex="26" OnClientClick="Btn_DocReset()" OnClick="Btn_DocReset_Click">RESET <i class="fa fa-refresh "></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Btn_DocPrev" />
                                <%--<asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click"/>--%>
                                <asp:PostBackTrigger ControlID="Button_Submit1" />
                                <asp:AsyncPostBackTrigger ControlID="Btn_DocReset" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
                <!--================================================End Upload Documents Details============================================================================-->
                <!--========================================================================Searching Parameters=================================================================-->
                <div id="ViewDetails" class="tab-pane">

                    <div>
                        <asp:UpdatePanel ID="UpdatePanel_ViewDetails" runat="server">
                            <ContentTemplate>

                                <div class="panel panelTop" runat="server">
                                    <div class="panel-heading panelView">

                                        <div>
                                            <asp:UpdatePanel ID="UpdatePanel_View" runat="server">
                                                <ContentTemplate>

                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-md-2 col-lg-3"></div>
                                                            <%--<input onclick="" onchange=""/>--%>
                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <asp:HiddenField ID="HiddenField_Txt_SearchDriverName_Search" runat="server" />
                                                                <asp:HiddenField ID="HiddenField_RadioButtonList_SearchDriverName" runat="server" />

                                                                <asp:Label ID="Lbl_SearchablrDriverName" runat="server" CssClass="label labelColor">DRIVER NAME</asp:Label>

                                                                <asp:DropDownList ID="Ddl_SearchablrDriverName" runat="server" CssClass="formDisplay" TabIndex="14">
                                                                </asp:DropDownList>
                                                                <!----DropDown Start----->
                                                                <%--  <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                <asp:TextBox ID="Txt_SearchDriverName" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" CssClass="form-control Txt_SearchDriverName" Text="SELECT" TabIndex="27"></asp:TextBox>

                                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchDriverName" runat="server" Enabled="true" TargetControlID="Txt_SearchDriverName"
                                                                    PopupControlID="Panel_SearchDriverName" OffsetY="38" OffsetX="-2">
                                                                </ajaxToolkit:PopupControlExtender>

                                                                <asp:Panel ID="Panel_SearchDriverName" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                    BackColor="#ffffff" Style="display: none;">

                                                                    <div runat="server" class="ddlSearchTextBoxInherit">
                                                                        <asp:TextBox ID="Txt_SearchDriverName_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="28"
                                                                            AutoCompleteType="Disabled" AutoPostBack="true" onchange="Txt_SearchDriverName_Search()" OnTextChanged="Txt_SearchDriverName_Search_TextChanged"></asp:TextBox>
                                                                    </div>

                                                                    <div runat="server" class="ddlDropDownListInherit">
                                                                        <asp:RadioButtonList ID="RadioButtonList_SearchDriverName" runat="server" onclick="RadioButtonList_SearchDriverName()" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_SearchDriverName_SelectedIndexChanged" TabIndex="29">
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </asp:Panel>--%>
                                                                <!----DropDown End----->

                                                            </div>
                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-lg"></div>
                                                                <div class="form-control-lg"></div>
                                                                <div class="form-control-sm"></div>
                                                                <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                                 <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click" TabIndex="30" Text="SEARCH">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </ContentTemplate>
                                                <Triggers>
                                                    <%-- <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchDriverName" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchDriverName_Search" EventName="TextChanged" />--%>
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-4 col-lg-5 ">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="panel-body" id="Search_DriverDetails_View" runat="server">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <asp:GridView ID="gridViewDriver" runat="server" DataKeyNames="driverID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewDriver_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewDriver_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                              
                                                               <asp:LinkButton ID="editDriverDetails" runat="server" OnClick="editDriverDetails_Click" CommandArgument='<%#Eval("driverID") %>' ToolTip="Edit"><i style="font-size: 18px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                               
                                                                            
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/>
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                        </asp:TemplateField>

                                                        <asp:BoundField DataField="driverID" HeaderText="DRIVER ID" SortExpression="driverID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="driverName" HeaderText="DRIVER NAME" SortExpression="driverName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="driverContactNo" HeaderText="DRIVER CONTACT NO" SortExpression="driverContactNo">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="driverEmailID" HeaderText="DRIVER EMAILID" SortExpression="driverEmailID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="stateName" HeaderText="STATE" SortExpression="stateName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="pinCode" HeaderText="PINCODE" SortExpression="pinCode">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="cityName" HeaderText="CITY NAME" SortExpression="cityName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="address" HeaderText="ADDRESS" SortExpression="address">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="branchName" HeaderText="BELONG TO BRANCH" SortExpression="branchName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceNo" HeaderText="LICENCE NO" SortExpression="licenceNo">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceValidFromDate" HeaderText="LICENCE VALID FROM DATE" SortExpression="licenceValidFromDate">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceValidToDate" HeaderText="LICENCE VALID TO DATE" SortExpression="licenceValidToDate">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="panCardNo" HeaderText="PANCARD NO" SortExpression="panCardNo">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="aadharCardNo" HeaderText="AADHARCARD NO" SortExpression="aadharCardNo">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceFileName" HeaderText="LICENCE FILE" SortExpression="licenceFileName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="panCardFileName" HeaderText="PANCARD FILE" SortExpression="panCardFileName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="aadharCardFileName" HeaderText="AADHAR CARD FILE" SortExpression="aadharCardFileName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UserBranch" HeaderText="USER BRANCH" SortExpression="UserBranch">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                    </Columns>

                                                    <HeaderStyle HorizontalAlign="Center" />

                                                </asp:GridView>

                                            <%--    <asp:GridView ID="GV_Export" runat="server" DataKeyNames="driverID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">
                                                    <Columns>
                                                        <asp:BoundField DataField="driverNo" HeaderText="DRIVER CODE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="driverName" HeaderText="DRIVER NAME">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="driverContactNo" HeaderText="DRIVER CONTACT NO">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="driverEmailID" HeaderText="DRIVER EMAILID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="pincode" HeaderText="PINCODE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="state" HeaderText="STATE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="city" HeaderText="CITY">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="address" HeaderText="ADDRESS">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="belongToBranch" HeaderText="BELONG TO BRANCH">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceNo" HeaderText="LICENCE NO">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceValidFromDate" HeaderText="LICENCE VALID FROM DATE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceValidToDate" HeaderText="LICENCE VALID TO DATE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="panCardNo" HeaderText="PANCARD NO">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="aadharCardNo" HeaderText="AADHARCARD NO">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="licenceFileName" HeaderText="LICENCE FILE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="panCardFileName" HeaderText="PANCARD FILE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="aadharCardFileName" HeaderText="AADHAR CARD FILE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <%--  <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" >
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                    </asp:BoundField>-%>
                                                        <asp:BoundField DataField="username" HeaderText="USERNAME">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:GridView>--%>
                                            </div>
                                        </div>
                                        <div id="printPage">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                    <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" OnClick="btn_ExporttoExcel_Click" Text="Export To Excel" TabIndex="31" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                    </div>
                                                    <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="Print" TabIndex="32" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                                <asp:PostBackTrigger ControlID="btn_ExporttoExcel" />
                            </Triggers>
                        </asp:UpdatePanel>
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


    <%--Driver Form Validation--%>
    <script src="Validation/Val_DriverMaster.js"></script>


    <script type="text/javascript">
        function uploaderror() {
            alert("sonme error occured while uploading file!");
        }
    </script>

    <%-- Customer Documents --%>
    <script type="text/javascript">
        function uploadcomplete(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Driver_LicenceNo_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete2(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Driver_PanCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete3(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Driver_AadhaarCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //window.open('FileUpload/' + Imagename);
        }
    </script>

    <script type="text/javascript">
        function ShowProgress() {
            document.getElementById('<% Response.Write(UpdateProgress_Upload_Documents.ClientID); %>').style.display = "inline";
        }
    </script>


    <script>

        function Txt_State_Search() {
            $('[id*=HiddenField_Txt_State_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_State_Search]').val());
        }

        function RadioButtonList_State() {
            $('[id*=HiddenField_RadioButtonList_State]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_State]').val());
        }



        function Txt_BelongToBranch_Search() {
            $('[id*=HiddenField_Txt_BelongToBranch_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_BelongToBranch_Search]').val());
        }

        function RadioButtonList_BelongToBranch() {
            $('[id*=HiddenField_RadioButtonList_BelongToBranch]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_BelongToBranch]').val());
        }


        function Tab1Save() {
            $('[id*=HiddenField_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Tab1Save]').val());
        }

        function Btn_Reset() {
            $('[id*=HiddenField_Btn_Reset]').val("1");
            console.log($('[id*=HiddenField_Btn_Reset]').val());
        }

        function Txt_LicenceValidDateTo() {
            $('[id*=HiddenField_Txt_LicenceValidDateTo]').val("1");
            console.log($('[id*=HiddenField_Txt_LicenceValidDateTo]').val());
        }


        function Submit1() {
            $('[id*=HiddenField_Submit1]').val("1");
            console.log($('[id*=HiddenField_Submit1]').val());
        }

        function Btn_DocReset() {
            $('[id*=HiddenField_Btn_DocReset]').val("1");
            console.log($('[id*=HiddenField_Btn_DocReset]').val());
        }


        function Txt_SearchDriverName_Search() {
            $('[id*=HiddenField_Txt_SearchDriverName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchDriverName_Search]').val());
        }

        function RadioButtonList_SearchDriverName() {
            $('[id*=HiddenField_RadioButtonList_SearchDriverName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchDriverName]').val());
        }

        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }

    </script>

</asp:Content>

