<%@ Page Title="Company Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Company_Master.aspx.cs" Inherits="OPERATIONS_CompanyMaster" %>

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
        <asp:UpdateProgress ID="UpdateProgress_Company_Details" AssociatedUpdatePanelID="UpdatePanel_Company_Details" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Company_Details_Button" AssociatedUpdatePanelID="UpdatePanel_Company_Details_Button" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_GridView" AssociatedUpdatePanelID="UpdatePanel_GridView" runat="server" DisplayAfter="0">
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
                    <a data-toggle="tab" href="#CompanyDetails" class="nav-link active tabfont">COMPANY DETAILS</a>
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

                <!--=========================================================================Company  Details==========================================================================-->
                <div id="CompanyDetails" class="tab-pane active">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>COMPANY DETAILS</b>
                            <div style="text-align: right" runat="server" id="dateTime" visible="false">
                                <asp:Label ID="Lbl_CurrentDateTime" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">

                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel_Company_Details" runat="server">
                                        <ContentTemplate>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CompanyCode" runat="server" CssClass="label labelColor">COMPANY CODE</asp:Label>
                                                        <asp:TextBox ID="Txt_ComapnyCode" runat="server" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CompanyName" runat="server" CssClass="label labelColor">COMPANY NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CompanyName" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_CompanyName FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="1"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OwnerName" runat="server" CssClass="label labelColor">OWNER NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_OwnerName" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_OwnerName FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="2"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OwnerContactNo" runat="server" CssClass="label labelColor">OWNER CONTACT NO</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_OwnerContactNo" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_OwnerContactNo FirstNoSpaceAndZero" MaxLength="10" placeholder="+91" TextMode="Phone" onkeypress="return validateNumericValue(event)" TabIndex="3"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_EmailId" runat="server" CssClass="label labelColor">EMAIL ID</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_EmailId" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_EmailId" onkeypress="return checkEmailId()" TabIndex="4"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PinCode" runat="server" CssClass="label labelColor">PINCODE</asp:Label><span class="required">*</span>
                                                        <asp:HiddenField ID="HiddenField_PinCode" runat="server"/>
                                                        <asp:HiddenField ID="HiddenField_PinCode_Search" runat="server" Value="" />

                                                        <%--<asp:DropDownList ID="DDL_PinCode" runat="server" CssClass="form-control selectpicker DDL_PinCode" AutoPostBack="true" OnSelectedIndexChanged="DDL_PinCode_SelectedIndexChanged" data-live-search="true" TabIndex="5">
                                        <asp:ListItem>SELECT</asp:ListItem>
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>--%>
                                                        <!----DropDown Start----->
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_PinCode" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" Text="SELECT" TabIndex="5" CssClass="form-control Txt_PinCode"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_PinCode" runat="server" Enabled="true" TargetControlID="Txt_PinCode"
                                                            PopupControlID="Panel_PinCode" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_PinCode" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <%--<input type="text" onfocus="" onchange=""/>--%>
                                                            <div runat="server" class="ddlSearchTextBox">
                                                                <asp:TextBox ID="Txt_PinCode_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="6"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" MaxLength="6" onchange="Search_Pincode_Radiobuttonlist()" onkeypress="return validateNumericValue(event)" OnTextChanged="Txt_PinCode_Search_TextChanged"></asp:TextBox>
                                                            </div>
                                                            
                                                            <div runat="server" class="ddlDropDownList">
                                                                <asp:RadioButtonList ID="RadioButtonList_PinCode" runat="server" AutoPostBack="true" onclick="Pincode_Radiobuttonlist()" OnSelectedIndexChanged="RadioButtonList_PinCode_SelectedIndexChanged" TabIndex="7">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>
                                                        <!----DropDown End----->
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                        <asp:TextBox ID="Txt_State" runat="server" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                                        <asp:TextBox ID="Txt_District" runat="server" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Taluka" runat="server" CssClass="label labelColor">TALUKA</asp:Label>
                                                        <asp:TextBox ID="Txt_Taluka" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="8"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                                        <asp:TextBox ID="Txt_City" runat="server" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="Demo_AREA" runat="server">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Demo_AREA" runat="server" CssClass="label labelColor">AREA</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_Demo_Area" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT"
                                                            CssClass="form-control Txt_Area focusArea" onfocus="myFunction(this)" TabIndex="10"></asp:TextBox>

                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " runat="server" id="Area" visible="false">
                                                        <div class="row">
                                                            <div class="col-sm-11 col-md-11 col-lg-10">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_Area" runat="server" CssClass="label labelColor">AREA</asp:Label><span class="required">*</span>
                                                                <asp:HiddenField ID="HiddenField_Area" runat="server" Value="" />
                                                                <asp:HiddenField ID="HiddenField_Area_Search" runat="server" Value="" />

                                                                <%--  <asp:DropDownList ID="Ddl_Area" runat="server" CssClass="form-control selectpicker Ddl_Area" data-live-search="true" AutoPostBack="true" OnSelectedIndexChanged="Ddl_Area_SelectedIndexChanged" TabIndex="7">
                                                <asp:ListItem>SELECT</asp:ListItem>         
                                                <asp:ListItem></asp:ListItem>               
                                            </asp:DropDownList>--%>
                                                                <!----DropDown Start----->
                                                                <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                <asp:TextBox ID="Txt_Area" runat="server" Style="background-color: white;text-transform: uppercase" ReadOnly="true" AutoCompleteType="Disabled" Text="SELECT"
                                                                    CssClass="form-control Txt_Area" TabIndex="9"></asp:TextBox>

                                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_Area" runat="server" Enabled="true" TargetControlID="Txt_Area"
                                                                    PopupControlID="Panel_Area" OffsetY="38" OffsetX="-2">
                                                                </ajaxToolkit:PopupControlExtender>

                                                                <asp:Panel ID="Panel_Area" runat="server" CssClass="form-control" Height="140px" Width="110%" Direction="LeftToRight" ScrollBars="Auto"
                                                                    BackColor="#ffffff" Style="display: none;">

                                                                    <%--<input type="text" onclick="" onchange=""/>--%>
                                                                    <div runat="server" class="ddlSearchTextBox">
                                                                        <asp:TextBox ID="Txt_Area_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="10"
                                                                            AutoCompleteType="Disabled" AutoPostBack="true" onchange="Search_Area_Radiobuttonlist()" onkeypress="return onlyAlphaValue()" OnTextChanged="Txt_Area_Search_TextChanged"></asp:TextBox>
                                                                    </div>

                                                                    <div runat="server" class="ddlDropDownList">
                                                                        <asp:RadioButtonList ID="RadioButtonList_Area" runat="server" onclick="Area_Radiobuttonlist()" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_Area_SelectedIndexChanged" TabIndex="11">
                                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </asp:Panel>
                                                                <!----DropDown End----->
                                                            </div>
                                                            <div class="col-sm-0.5 col-md-0.5 ">
                                                                <div class="form-control-static"></div>
                                                                <asp:ImageButton ID="Img_AddArea" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#smallModal" Visible="false" ImageUrl="~/images//add.png" TabIndex="12" ToolTip="Create New Area" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CompanyAddress" runat="server" CssClass="label labelColor">COMPANY ADDRESS</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CompanyAddress" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_CompanyAddress FirstNoSpaceAndZero" TextMode="MultiLine" TabIndex="13"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                                        <asp:TextBox ID="Txt_Remark" runat="server" AutoComplete="off" CssClass="form-control input-sm FirstNoSpaceAndZero" Style="text-transform: uppercase" TextMode="MultiLine" TabIndex="14"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>


                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="RadioButtonList_PinCode" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="Txt_PinCode_Search" EventName="TextChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="RadioButtonList_Area" EventName="SelectedIndexChanged" />
                                            <%--<asp:PostBackTrigger ControlID="RadioButtonList_Area" />--%>
                                            <asp:AsyncPostBackTrigger ControlID="Txt_Area_Search" EventName="TextChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>

                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel_Company_Details_Button" runat="server">
                                        <ContentTemplate>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                    <%--<input type="button" onsubmit="" onmousedown=""/>      onclick="Tab1Save()"  --%>
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Tab1Save" runat="server" Value="" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Save" ID="Button_Tab1Save" runat="server" Text="SAVE" OnClick="Button_Tab1Save_Click" UseSubmitBehavior="false" OnClientClick="if (!validateCompanyDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="15">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>

                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Reset" runat="server" Value="" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_Reset" runat="server" Text="RESET" TabIndex="16" OnClientClick="Tab1Reset()" OnClick="Btn_Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                    </div>
                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:LinkButton runat="server" ID="Btn_Next" CssClass="btn btn-info largeButtonStyle" TabIndex="17">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                        <%-- <button type="button" runat="server" id="Btn_Next" class="btn btn-info next-step smallButtonStyle1">Next <i class="fa fa-arrow-circle-right"></i></button>--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <!---Buttons End--->

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
                <!--===============================================================Upload Documents==========================================================-->
                <div id="UploadDoc" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>UPLOAD DOCUMENTS</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">

                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel_Upload_Documents" runat="server">
                                        <ContentTemplate>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CompanyGSTCertificates" runat="server" CssClass="label labelColor">GST CERTIFICATE(NO)</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CompanyGSTCertificates" AutoComplete="off" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CompanyGSTCertificates" onkeypress="return checkAlphaNumeric()" TabIndex="18" MaxLength="15"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<CuteWebUI:Uploader ID="Company_GST_Uploader" runat="server" InsertText="Upload" OnFileUploaded="Company_GST_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Company_GST_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Company_GST_Uploader_UploadComplete" TabIndex="19" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Company_GST_Label" runat="server" Text=""></asp:Label>--%>
                                                        <a id="Company_GST_Label" runat="server" target="_blank"></a>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CompanyCIN" runat="server" CssClass="label labelColor">CIN</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CompanyCIN" runat="server" Style="text-transform: uppercase;" AutoComplete="off" CssClass="form-control input-sm Txt_CompanyCIN" onkeypress="return checkAlphaNumeric()" TabIndex="20" MaxLength="21"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<CuteWebUI:Uploader ID="Company_CIN_Uploader" runat="server" InsertText="Upload" OnFileUploaded="Company_CIN_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Company_CIN_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Company_CIN_Uploader_UploadComplete" TabIndex="21" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Company_CIN_Label" runat="server" Text=""></asp:Label>--%>
                                                        <a id="Company_CIN_Label" runat="server" target="_blank"></a>
                                                    </div>
                                                </div>

                                            </div>



                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <%--<button type="button" class="btn btn-info  prev-step largeButtonStyle"><i class="fa fa-arrow-circle-left"></i>PREV</button>--%>
                                                        <asp:LinkButton ID="Btn_DocumentPrev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="22"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Submit1" runat="server" Value="" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle Button_Submit1" ID="Button_Submit1" runat="server" Text="SUBMIT" UseSubmitBehavior="false" OnClientClick="if (!validateCompanyDocDetails()) {return false;} else{ __doPostBack('this.name','');};" OnClick="Button_Submit1_Click" TabIndex="23">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>

                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_DocReset" runat="server" Value="" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_DocReset" runat="server" OnClientClick="FinalReset()" Text="RESET" TabIndex="24" OnClick="Btn_DocReset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                    </div>

                                                </div>
                                            </div>


                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="Btn_DocumentPrev" />
											<asp:PostBackTrigger ControlID="Button_Submit1" />
                                            <%--<asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click" />--%>
                                            <asp:AsyncPostBackTrigger ControlID="Btn_DocReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!--=======================================================End Upload Documents===========================================================-->

                <!--=============================================== Searching Parameters============================================-->
                <div id="ViewDetails" class="tab-pane">

                    <div>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>

                                <div class="panel panelTop" runat="server">
                                    <div class="panel-heading panelView">

                                        <div>
                                            <asp:UpdatePanel ID="UpdatePanel_ViewDetails" runat="server">

                                                <ContentTemplate>

                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-0 col-md-0 col-lg-2 "></div>
                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_SearchCompanyName" runat="server" CssClass="label labelColor">COMPANY NAME</asp:Label>
                                                                <asp:HiddenField ID="HiddenField_SearchCompanyName" runat="server" />
                                                                <asp:HiddenField ID="HiddenField_SearchCompanyName_Search" runat="server" />
                                                                <!----DropDown Start----->
                                                                <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                <asp:TextBox ID="Txt_SearchCompanyName" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" TabIndex="25" CssClass="form-control Txt_PinCode" Text="SELECT"></asp:TextBox>

                                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchCompanyName" runat="server" Enabled="true" TargetControlID="Txt_SearchCompanyName"
                                                                    PopupControlID="Panel_SearchCompanyName" OffsetY="38" OffsetX="-2">
                                                                </ajaxToolkit:PopupControlExtender>

                                                                <asp:Panel ID="Panel_SearchCompanyName" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                    BackColor="#ffffff" Style="display: none;">

                                                                    <div runat="server" class="ddlSearchTextBoxInherit">
                                                                        <asp:TextBox ID="Txt_SearchCompanyName_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="26"
                                                                            AutoCompleteType="Disabled" AutoPostBack="true" onchange="View_Search_CompanyName_Radiobuttonlist()" OnTextChanged="Txt_SearchCompanyName_Search_TextChanged"></asp:TextBox>
                                                                    </div>
                                                                    
                                                                    
                                                                    
                                                                    <div runat="server" class="ddlDropDownListInherit">
                                                                        <asp:RadioButtonList ID="RadioButtonList_SearchCompanyName" runat="server" Style="font-size: 12px;" onclick="View_CompanyName_Radiobuttonlist()" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_SearchCompanyName_SelectedIndexChanged" TabIndex="27">
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </asp:Panel>
                                                                <!----DropDown End----->
                                                                <%-- <asp:DropDownList ID="Ddl_SearchCompanyName" runat="server" CssClass="form-control selectpicker" data-show-subtext="true" data-live-search="true" TabIndex="14">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>--%>
                                                            </div>

                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_SearchState" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                                <asp:HiddenField ID="HiddenField_SearchState" runat="server" />
                                                                <asp:HiddenField ID="HiddenField_SearchState_Search" runat="server" />
                                                                <!----DropDown Start----->
                                                                <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                <asp:TextBox ID="Txt_SearchState" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" Text="SELECT" TabIndex="28" CssClass="form-control Txt_PinCode"></asp:TextBox>

                                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchState" runat="server" Enabled="true" TargetControlID="Txt_SearchState"
                                                                    PopupControlID="Panel_SearchState" OffsetY="38" OffsetX="-2">
                                                                </ajaxToolkit:PopupControlExtender>

                                                                <asp:Panel ID="Panel_SearchState" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                    BackColor="#ffffff" Style="display: none;">

                                                                    <div runat="server" class="ddlSearchTextBoxInherit">
                                                                        <asp:TextBox ID="Txt_SearchState_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="29"
                                                                            AutoCompleteType="Disabled" AutoPostBack="true" onchange="View_Search_StateName_Radiobuttonlist()" OnTextChanged="Txt_SearchState_Search_TextChanged"></asp:TextBox>
                                                                    </div>
                                                                          
                                                                    
                                                                    <div runat="server" class="ddlDropDownListInherit">
                                                                        <asp:RadioButtonList ID="RadioButtonList_SearchState" runat="server" Style="font-size: 12px;" AutoPostBack="true" onclick="View_StateName_Radiobuttonlist()" OnSelectedIndexChanged="RadioButtonList_SearchState_SelectedIndexChanged" TabIndex="30">
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </asp:Panel>
                                                                <!----DropDown End----->
                                                                <%--<asp:DropDownList ID="Ddl_SearchState" runat="server" CssClass="form-control selectpicker" data-show-subtext="true" data-live-search="true" TabIndex="15">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>--%>
                                                            </div>
                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_SearchCity" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                                                <asp:HiddenField ID="HiddenField_SearchCity" runat="server" />
                                                                <asp:HiddenField ID="HiddenField_SearchCity_Search" runat="server" />
                                                                <!----DropDown Start----->
                                                                <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                <asp:TextBox ID="Txt_SearchCity" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" Text="SELECT" TabIndex="31" CssClass="form-control Txt_PinCode"></asp:TextBox>

                                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchCity" runat="server" Enabled="true" TargetControlID="Txt_SearchCity"
                                                                    PopupControlID="Panel_SearchCity" OffsetY="38" OffsetX="-2">
                                                                </ajaxToolkit:PopupControlExtender>

                                                                <asp:Panel ID="Panel_SearchCity" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                    BackColor="#ffffff" Style="display: none;">

                                                                    <div runat="server" class="ddlSearchTextBoxInherit">
                                                                        <asp:TextBox ID="Txt_SearchCity_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="32"
                                                                            AutoCompleteType="Disabled" AutoPostBack="true" onchange="View_Search_CityName_Radiobuttonlist()" OnTextChanged="Txt_SearchCity_Search_TextChanged"></asp:TextBox>
                                                                    </div>
                                                                          
                                                                    <%--<input onchange="" onclick=""/>--%>
                                                                    <div runat="server" class="ddlDropDownListInherit">
                                                                        <asp:RadioButtonList ID="RadioButtonList_SearchCity" runat="server" Style="font-size: 12px;" AutoPostBack="true" onclick="View_CityName_Radiobuttonlist()" OnSelectedIndexChanged="RadioButtonList_SearchCity_SelectedIndexChanged" TabIndex="33">
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </asp:Panel>
                                                                <!----DropDown End----->
                                                                <%-- <asp:DropDownList ID="Ddl_SearchCity" runat="server" CssClass="form-control selectpicker" data-show-subtext="true" data-live-search="true" TabIndex="16">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>--%>
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
                                                                <asp:HiddenField ID="HiddenField_Search" runat="server" />
                                                                <asp:Button CssClass="btn btn-info largeButtonStyle" ID="Btn_Search" runat="server" OnClientClick="ViewSearch()" Text="SEARCH" TabIndex="34" OnClick="Btn_Search_Click"></asp:Button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchCompanyName" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchCompanyName_Search" EventName="TextChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchState" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchState_Search" EventName="TextChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchCity" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchCity_Search" EventName="TextChanged" />

                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>

                                    </div>
                                    <!-------->
                                    <div class="panel-body" id="Search_CompanyDetails_View" runat="server">

                                        <div>
                                            <asp:UpdatePanel ID="UpdatePanel_GridView" runat="server">
                                                <ContentTemplate>

                                                    <div class="form-horizontal" role="form">


                                                        <div class="form-group">
                                                            <div>
                                                                <asp:GridView ID="gridViewCompany" runat="server" DataKeyNames="companyID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewCompany_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewCompany_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="ACTION">
                                                                            <ItemTemplate>
                                                                                <table>
                                                                                    <tr>

                                                                                        <td>
                                                                                            <ul class="list-inline pull-right">
                                                                                                <li>
                                                                                                     <asp:HiddenField ID="HiddenField_editCompanyDetails" runat="server" Value="" />
                                                                                                    <asp:LinkButton ID="editCompanyDetails" runat="server" OnClientClick="EditCompanyDetails()" OnClick="editCompanyDetails_Click" CommandArgument='<%#Eval("companyNo") %>' ToolTip="Edit"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton></li>

                                                                                            </ul>
                                                                                        </td>
                                                                                             
                                                                                        <td>
                                                                                            <span onclick="return confirm('Are you sure you want to delete this record')">
                                                                                                <asp:HiddenField ID="HiddenField_Delete_Data1" runat="server" Value="" />
                                                                                                <asp:LinkButton ID="Delete_Data1" runat="server" OnClientClick="Delete_Data()" OnClick="Delete_Data1_Click" ToolTip="Delete"><i style="font-size: 25px; color:red" class="fa fa-trash"></i></asp:LinkButton>
                                                                                        </td>

                                                                                    </tr>
                                                                                </table>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                            <ItemStyle />
                                                                        </asp:TemplateField>

                                                                        <asp:BoundField DataField="companyNo" HeaderText="COMPANY CODE" SortExpression="companyNo">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="companyName" HeaderText="COMPANY NAME" SortExpression="companyName">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ownerName" HeaderText="OWNER NAME" SortExpression="ownerName">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ownerContactNo" HeaderText="OWNER CONTACT NO" SortExpression="ownerContactNo">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="emailID" HeaderText="EMAIL" SortExpression="emailID">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>

                                                                        <asp:BoundField DataField="pincode" HeaderText="PINCODE" SortExpression="pincode">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="state" HeaderText="STATE" SortExpression="state">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="district" HeaderText="DISTRICT" SortExpression="district">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="taluka" HeaderText="TALUKA" SortExpression="taluka">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="city" HeaderText="CITY" SortExpression="city">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="area" HeaderText="AREA" SortExpression="area">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="companyAddress" HeaderText="COMPANY ADDRESS" SortExpression="companyAddress">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="remark" HeaderText="REMARK" SortExpression="remark">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="GST_CertificateNo" HeaderText="GST CERTIFICATE NO" SortExpression="GST_CertificateNo">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="cin" HeaderText="CIN" SortExpression="cin">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>

                                                                        <asp:BoundField DataField="GSTFileName" HeaderText="GST FILE" SortExpression="GSTFileName">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="CINFileName" HeaderText="CIN FILE" SortExpression="CINFileName">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" Visible="false" SortExpression="employeeNo">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="username" HeaderText="USERNAME" SortExpression="username">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>

                                                                    </Columns>

                                                                    <HeaderStyle HorizontalAlign="Center" />

                                                                </asp:GridView>


                                                                <asp:GridView ID="GV_Export" runat="server" DataKeyNames="companyID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">
                                                                    <Columns>


                                                                        <asp:BoundField DataField="companyNo" HeaderText="COMPANY CODE">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="companyName" HeaderText="COMPANY NAME">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ownerName" HeaderText="OWNER NAME">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="ownerContactNo" HeaderText="OWNER CONTACT NO">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="emailID" HeaderText="EMAIL">
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
                                                                        <asp:BoundField DataField="district" HeaderText="DISTRICT">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="taluka" HeaderText="TALUKA">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="city" HeaderText="CITY">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="area" HeaderText="AREA">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="companyAddress" HeaderText="COMPANY ADDRESS">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="remark" HeaderText="REMARK">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="GST_CertificateNo" HeaderText="GST CERTIFICATE NO">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="cin" HeaderText="CIN">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>

                                                                        <asp:BoundField DataField="GSTFileName" HeaderText="GST FILE">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="CINFileName" HeaderText="CIN FILE">
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>
                                                                        <%-- <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" >
                                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                        </asp:BoundField>--%>
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

                                                                </asp:GridView>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="printPage">
                                                        <div class="form-group">
                                                            <div class="row">
                                                                <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                                <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                                    <asp:HiddenField ID="HiddenField_ExporttoExcel" runat="server" Value="" />
                                                                    <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" OnClick="btn_ExporttoExcel_Click" runat="server" Text="EXPORT TO EXCEL" TabIndex="35" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                                </div>
                                                                <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                                    <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="PRINT" TabIndex="36" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btn_ExporttoExcel" />

                                                </Triggers>
                                            </asp:UpdatePanel>
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
                <!--=============================================== End Comapny Details============================================-->
            </div>


        </div>
    </div>

    <!-- small modal -->
    <div class="modal" id="smallModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title labelColor" id="myModalLabel">AREA CREATION</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                            <div class="col-sm-6 col-md-9 col-lg-9 ">

                                <asp:Label ID="Label1" runat="server" CssClass="label labelColor labelColor">AREA NAME</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_AreaNamePopup" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_popArea FirstNoSpaceAndZero" onkeypress="return checkAlpha(event)"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-1 col-md-1 col-lg-1"></div>
                    <div class=" col-sm-3 col-md-2 col-lg-3">
                        <asp:HiddenField ID="HiddenField_SubmitArea_Popup" runat="server" Value="" />
                        <asp:Button ID="Btn_SubmitArea" runat="server" OnClick="Btn_SubmitArea_Click" OnClientClick="if (!validateAreaDetails()) {return false;} else{ __doPostBack('this.name','');};" CssClass="btn btn-info largeButtonStyle Btn_SubmitArea" Text="SUBMIT"></asp:Button>

                    </div>
                    <div class="col-sm-1 col-md-1 col-lg-1"></div>
                    <div class="col-sm-3 col-md-2 col-lg-3">
                        <asp:Button ID="Btn_Close" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                    </div>
                </div>
                <asp:Label ID="lblmsg" runat="server"></asp:Label>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for New Area Creation====================================================-->
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="Validation/Val_CompanyMaster.js"></script>

    <script type="text/javascript">
        function uploaderror() {
            alert("sonme error occured while uploading file!");
        }
    </script>

    <%-- Upload Documents --%>
    <script type="text/javascript">
        function uploadcomplete(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Company_GST_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete2(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Company_CIN_Label.ClientID%>");
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
    <script src="js/AlertNotifictaion.js"></script>
    <script type="text/javascript">
        
        function Pincode_Radiobuttonlist() {
                $('[id*=HiddenField_PinCode]').val("1");
                console.log($('[id*=HiddenField_PinCode]').val());
        }
        function Search_Pincode_Radiobuttonlist() {
            $('[id*=HiddenField_PinCode_Search]').val("1");
            console.log($('[id*=HiddenField_PinCode_Search]').val());
        }
        
        function Area_Radiobuttonlist() {
            $('[id*=HiddenField_Area]').val("1");
            console.log($('[id*=HiddenField_Area]').val());
        }           
        function Search_Area_Radiobuttonlist() {
            $('[id*=HiddenField_Area_Search]').val("1");
            console.log($('[id*=HiddenField_Area_Search]').val());
        }
        
        function Tab1Save() {
            $('[id*=HiddenField_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Tab1Save]').val());
         }
        function Tab1Reset() {
            $('[id*=HiddenField_Reset]').val("1");
            console.log($('[id*=HiddenField_Reset]').val());
        }
        function FinalSubmit() {
            $('[id*=HiddenField_Submit1]').val("1");
            console.log($('[id*=HiddenField_Submit1]').val());
            }    
        function FinalReset() {
            $('[id*=HiddenField_DocReset]').val("1");
            console.log($('[id*=HiddenField_DocReset]').val());
           }


        function View_CompanyName_Radiobuttonlist() {
            $('[id*=HiddenField_SearchCompanyName]').val("1");
            console.log($('[id*=HiddenField_SearchCompanyName]').val());
            }
        function View_Search_CompanyName_Radiobuttonlist() {
            $('[id*=HiddenField_SearchCompanyName_Search]').val("1");
            console.log($('[id*=HiddenField_SearchCompanyName_Search]').val());
        }
        
        function View_StateName_Radiobuttonlist() {
            $('[id*=HiddenField_SearchState]').val("1");
            console.log($('[id*=HiddenField_SearchState]').val());
        }
        function View_Search_StateName_Radiobuttonlist() {
            $('[id*=HiddenField_SearchState_Search]').val("1");
            console.log($('[id*=HiddenField_SearchState_Search]').val());
            }
        
        function View_CityName_Radiobuttonlist() {
            $('[id*=HiddenField_SearchCity]').val("1");
            console.log($('[id*=HiddenField_SearchCity]').val());
        }
        function View_Search_CityName_Radiobuttonlist() {
            $('[id*=HiddenField_SearchCity_Search]').val("1");
            console.log($('[id*=HiddenField_SearchCity_Search]').val());
            }
        

        function ViewSearch() {
            $('[id*=HiddenField_Search]').val("1");
            console.log($('[id*=HiddenField_Search]').val());
            }
        function EditCompanyDetails() {
            $('[id*=HiddenField_editCompanyDetails]').val("1");
            console.log($('[id*=HiddenField_editCompanyDetails]').val());
        }
        function Delete_Data() {
            $('[id*=HiddenField_Delete_Data1]').val("1");
            console.log($('[id*=HiddenField_Delete_Data1]').val());
        }
        function SubmitArea_Popup() {
            $('[id*=HiddenField_SubmitArea_Popup]').val("1");
            console.log($('[id*=HiddenField_SubmitArea_Popup]').val());
        }
        
    </script>
    
    

    <%--<script>
        function focusValueChange() {
                $('[id*=HiddenField_PinCode]').val("1");
                console.log($('[id*=HiddenField_PinCode]').val());
           }
    </script>--%>

</asp:Content>

