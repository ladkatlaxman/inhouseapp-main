<%@ Page Title="Party Vendor Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Party_VendorCreation.aspx.cs" Inherits="OPERATIONS_party_master_VendorCreation" %>

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

    <%--  <script>                    // To Hide Drop Zone In Ajax File Upload
        document.getElementsByClassName("ajax__fileupload_dropzone")[0].style.display = "none";
        $(".ajax__fileupload_dropzone").hide();
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>

        <script>
            $(document).ready(function () {
                $("[id*=Ddl_Area]").change(function () {
                    console.log("In On Change", $("[id*=Ddl_Area]").val());
                    $("[id*=hfArea]").val($("[id*=Ddl_Area]").val());
                    console.log($("[id*=hfArea]").val());
                    return false;
                });
            });
        </script>

        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 6 ---->
        <asp:UpdateProgress ID="UpdateProgress_VendorDetails" AssociatedUpdatePanelID="UpdatePanel_VendorDetails" runat="server" DisplayAfter="0">
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

        <!---Update Progress 7 ---->
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

        <!---Update Progress 8 ---->
        <asp:UpdateProgress ID="UpdateProgress_View_GridView" AssociatedUpdatePanelID="UpdatePanel_View_GridView" runat="server" DisplayAfter="0">
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
                    <a data-toggle="tab" href="#VendorDetails" class="nav-link active tabfont">VENDOR CREATION DETAIL</a>
                </li>
                <li class="nav-item disabled">
                    <a data-toggle="tab" href="#UploadDoc" class="nav-link tabfont">UPLOAD DOCUMENT</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>

                <!--================================================Vendor Creation Details===============================================================-->
                <div id="VendorDetails" class="tab-pane active">
                    <div id="Vendor_Tab" runat="server">
                        <div class="panel panelTop">

                            <asp:UpdatePanel ID="UpdatePanel_VendorDetails" runat="server">
                                <ContentTemplate>

                                    <div class="panel-heading panelHead">
                                        <b>VENDOR CREATION DETAIL</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorType" runat="server" CssClass="label labelColor"> VENDOR TYPES </asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_VendorType" runat="server" CssClass="formDisplay input-sm Ddl_Vendors" TabIndex="1">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem Selected="True">TRANSPORTER</asp:ListItem>
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
                                                        <asp:HiddenField ID="HiddenField_Txt_VendorName" runat="server" Value="" />
                                                        <asp:Label ID="Lbl_VendorName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_VendorName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_VendorName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="2"></asp:TextBox><%--AutoPostBack="true" OnTextChanged="Txt_CompanyName_TextChanged"--%>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorContactNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_VendorContactNo" runat="server" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_VendorContactNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)" TabIndex="3"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Pincode" runat="server" CssClass="label labelColor">PIN CODE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Pincode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Pincode" onkeypress="return validateNumericValue(event)" MaxLength="6" onchange="ReadDataonchange('Txt_Pincode','hfPincode','Ddl_Area','Party_CustomerCreation.aspx/getPincode');" TabIndex="4"></asp:TextBox>
                                                        <asp:HiddenField ID="hfPincode" runat="server" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                        <asp:TextBox ID="Txt_State" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_State" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                                        <asp:TextBox ID="Txt_District" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_District" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                                        <asp:TextBox ID="Txt_City" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_City" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " runat="server">
                                                        <div class="row">
                                                            <div class="col-sm-11 col-md-11 col-lg-10">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_Area" runat="server" CssClass="label labelColor">AREA</asp:Label><span class="required">*</span>
                                                                <asp:DropDownList ID="Ddl_Area" runat="server" CssClass="formDisplay input-sm Ddl_Area" TabIndex="5">
                                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hfArea" runat="server" />
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorBillingAddress" runat="server" CssClass="label labelColor">BILLING ADDRESS</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_VendorBillingAddress" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_VendorBillingAddress FirstNoSpaceAndZero" TextMode="MultiLine" TabIndex="6"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_BranchName" runat="server" CssClass="label labelColor">BRANCH</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_BranchName" runat="server" CssClass="formDisplay input-sm Ddl_BranchName" TabIndex="7">
                                                        </asp:DropDownList>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorCategory" runat="server" CssClass="label labelColor">CATEGORY</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_VendorCategory" runat="server" CssClass="formDisplay Ddl_VendorCategory" TabIndex="8">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>INDIVIDUAL</asp:ListItem>
                                                            <asp:ListItem>FIRM/COMPANY</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-heading panelHead">
                                        <b>OWNER PERSON DETAIL</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <asp:Label ID="Lbl_OwnerId" runat="server" CssClass="label labelColor" Visible="false"></asp:Label>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OwnerPersonName" runat="server" CssClass="label labelColor">OWNER NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_OwnerPersonName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_OwnerPersonName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="9"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OwnerPersonContactNo" runat="server" Text="Type" CssClass="label labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_OwnerPersonContactNo" runat="server" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_OwnerPersonPhoneNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)" TabIndex="10"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="row">
                                                            <div class="col-sm-11 col-md-11 col-lg-10">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_OwnerPersonEmailId" runat="server" CssClass="label labelColor">EMAIL ID</asp:Label>
                                                                <asp:TextBox ID="Txt_OwnerPersonEmailId" runat="server" CssClass="form-control input-sm Txt_OwnerPersonEmailId" onkeypress="return checkEmailId()" TabIndex="11"></asp:TextBox>
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
                                                        <asp:HiddenField ID="HiddenField_Button_Tab1Save" runat="server" Value="" />
                                                        <asp:LinkButton ID="Button_Tab1Save" runat="server" CssClass="btn btn-info largeButtonStyle Btn_VendorSave" UseSubmitBehavior="false" OnClientClick="if (!validateVendorDetails()) {return false;} else{ __doPostBack('this.name','');};" OnClick="Button_Tab1Save_Click" TabIndex="12">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>

                                                        <asp:HiddenField ID="HiddenField_Btn_ResetVendorCreation" runat="server" Value="" />
                                                        <asp:LinkButton ID="Btn_ResetVendorCreation" runat="server" OnClientClick="Btn_ResetVendorCreation()" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_ResetVendorCreation_Click" TabIndex="14">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:LinkButton ID="Btn_VendorNext" runat="server" CssClass="btn btn-info next-step largeButtonStyle" TabIndex="13">NEXT&nbsp;<i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                        <%--<asp:LinkButton ID="Btn_VendorNext" runat="server" class="btn btn-info next-step largeButtonStyle" TabIndex="11" OnClick="Btn_VendorNext_Click"></asp:LinkButton>--%>
                                                        <%--                                            <button type="button" id="Btn_VendorNext" runat="server" class="btn btn-info next-step smallButtonStyle1">Next <i class="fa fa-arrow-circle-right"></i></button>--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <!---Buttons End--->
                                        </div>
                                    </div>
                                    

                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Button_Tab1Save" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_ResetVendorCreation" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
                <!--=======================================================End Vendor Creation Details===============================================-->

                <!--================================================Upload Documents Details============================================================================-->
                <div id="UploadDoc" class="tab-pane">
                    <div class="panel panelTop">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_Upload_Documents" runat="server">
                                <ContentTemplate>

                                    <!--=================================Vendor Documents==============================================-->
                                    <div class="panel-heading panelHead">
                                        <b>VENDOR DOCUMENTS</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorPanCardNo" runat="server" CssClass="label labelColor">PANCARD NO</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_VendorPanCardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_VendorPanCardNo" MaxLength="10" onkeypress="return checkAlphaNumeric()" TabIndex="41"></asp:TextBox>

                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Vendor_PanCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Vendor_PanCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>

                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="Btn_Upload" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Vendor_PanCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Vendor_PanCard_Uploader_UploadComplete" TabIndex="42" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Vendor_PanCard_Label" Style="text-transform: uppercase;" runat="server"></asp:Label>--%>
                                                        <a id="Vendor_PanCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorAadhaarCardNo" runat="server" CssClass="label labelColor">AADHARCARD NO</asp:Label>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_VendorAadhaarCardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_VendorAadhaarCardNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="43"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Vendor_AadhaarCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Vendor_AadhaarCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton1" runat="server" UseSubmitBehavior="false"  TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Vendor_AadhaarCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Vendor_AadhaarCard_Uploader_UploadComplete" TabIndex="44" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Vendor_AadhaarCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Vendor_AadhaarCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Vendor_GSTCertificates_Label" runat="server" CssClass="label labelColor">GST CERTIFICATE</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_VendorGSTCertificates" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_VendorGSTCertificates" onkeypress="return checkAlphaNumeric()" MaxLength="15" TabIndex="45"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <%--<CuteWebUI:Uploader ID="Vendor_GST_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Vendor_GST_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton2" runat="server" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>
                                                        <ajaxToolkit:AjaxFileUpload ID="Vendor_GST_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete3" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Vendor_GST_Uploader_UploadComplete" TabIndex="46" />
                                                    </div>
                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Vendor_GST_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Vendor_GST_Label" runat="server" target="_blank"></a>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_VendorCIN" runat="server" CssClass="label labelColor">CIN</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_VendorCIN" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_VendorCIN" onkeypress="return checkAlphaNumeric()" MaxLength="21" TabIndex="47"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>
                                                        <%--<CuteWebUI:Uploader ID="Vendor_CIN_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Vendor_CIN_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton3" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>
                                                        <ajaxToolkit:AjaxFileUpload ID="Vendor_CIN_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete4" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Vendor_CIN_Uploader_UploadComplete" TabIndex="48" />
                                                    </div>
                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Vendor_CIN_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Vendor_CIN_Label" runat="server" target="_blank"></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--=====================================End Vendor Documents==============================================-->
                                    <!--=====================================Owner Person Documents==============================================-->

                                    <div class="panel-heading panelHead">
                                        <b>OWNER PERSON DOCUMENTS</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OwnerPersonPanCardNo" runat="server" CssClass="label labelColor">PANCARD NO</asp:Label>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_OwnerPersonPanCardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_OwnerPersonPanCardNo" MaxLength="10" onkeypress="return checkAlphaNumeric()" TabIndex="49"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Owner_PanCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Owner_PanCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton4" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Owner_PanCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete5" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Owner_PanCard_Uploader_UploadComplete" TabIndex="50" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Owner_PanCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Owner_PanCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OwnerAdharcardNo" runat="server" CssClass="label labelColor">AADHARCARD NO</asp:Label>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_OwnerAdharcardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_OwnerAdharcardNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="51"></asp:TextBox>


                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Owner_AadhaarCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Owner_AadhaarCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton5" runat="server" UseSubmitBehavior="false" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Owner_AadhaarCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete6" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Owner_AadhaarCard_Uploader_UploadComplete" TabIndex="52" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Owner_AadhaarCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Owner_AadhaarCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">

                                            <div class=" col-sm-3 col-md-3 col-lg-4  "></div>

                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_DocumentPrev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="61"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                <%--<button type="button" class="btn btn-info  prev-step smallButtonStyle"><i class="fa fa-arrow-circle-left"></i>Prev</button>--%>
                                            </div>
                                            <div class=" col-sm-2 col-md-3 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_Button_Submit1" runat="server" Value="" />
                                                <%--OnClientClick="if (!validateDocumentsDetails()) {return false;} else{ __doPostBack('this.name','');};"--%>
                                                <asp:LinkButton ID="Button_Submit1" runat="server" Class="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClick="Button_Submit1_Click" OnClientClick="Button_Submit1()" TabIndex="62">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <!--------Please Apply OnClientClick on Submit Button----------->


                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>

                                                <asp:HiddenField ID="HiddenField_Btn_DocumentReset" runat="server" Value="" />
                                                <asp:LinkButton ID="Btn_DocumentReset" runat="server" OnClientClick="Btn_DocumentReset()" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_DocumentReset_Click" TabIndex="63">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                            </div>


                                        </div>
                                    </div>


                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Btn_DocumentPrev" />
                                    <%--<asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click"/>--%>
                                    <asp:PostBackTrigger ControlID="Button_Submit1" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_DocumentReset" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                </div>
                <!--================================================End Upload Documents Details============================================================================-->
                <!--==============================================View Details=======================================================================-->
                <div id="View" class="tab-pane">
                    <div class="panel panelTop">
                        <div>

                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>

                                    <div class="panel-heading panelView">
                                        <div class="form-horizontal" role="form">
                                            <div>
                                                <asp:UpdatePanel ID="UpdatePanel_View" runat="server">
                                                    <ContentTemplate>

                                                        <div class="form-group">
                                                            <div class="row">

                                                                <div class="col-sm-0 col-md-0 col-lg-2 "></div>

                                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:Label ID="Lbl_SearchVendorTypes" runat="server" CssClass="label labelColor">VENDOR TYPES</asp:Label>
                                                                    <asp:DropDownList ID="Ddl_SearchVendorTypes" runat="server" CssClass="formDisplay" TabIndex="64">
                                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                                        <asp:ListItem>TRANSPORTER</asp:ListItem>
                                                                        <asp:ListItem>HOUSEKEEPING</asp:ListItem>
                                                                        <asp:ListItem>LABOUR CONTRACTORS</asp:ListItem>
                                                                        <asp:ListItem>STATIONARY PROVIDERS</asp:ListItem>
                                                                        <asp:ListItem>HARDWARE/IT PROVIDERS </asp:ListItem>
                                                                        <asp:ListItem>PETTY SUPPLIERS</asp:ListItem>
                                                                        <asp:ListItem>OTHERS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>

                                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:Label ID="Lbl_SearchVendorName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label>
                                                                     <asp:TextBox ID="Txt_SearchVendorName" runat="server" CssClass="form-control input-sm" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="47"></asp:TextBox>
                                                                   <%-- <asp:DropDownList ID="Ddl_SearchVendorName" runat="server" CssClass="formDisplay" TabIndex="49">
                                                                    </asp:DropDownList>--%>
                                                                </div>

                                                             <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-lg"></div>
                                                                    <div class="form-control-lg"></div>
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" Value="" />
                                                                    <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="Btn_Search()" Text="SEARCH" OnClick="Btn_Search_Click" TabIndex="74">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
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
                                    <div class="panel-body" id="ViewData" runat="server" visible="false">

                                        <div>
                                            <asp:UpdatePanel ID="UpdatePanel_View_GridView" runat="server">

                                                <ContentTemplate>

                                                    <div class="form-horizontal" role="form">
                                                        <div class="form-group">
                                                            <asp:GridView ID="GV_PartyVendorMaster" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false" DataKeyNames="vendorID" AllowSorting="true" OnSorting="GV_PartyVendorMaster_Sorting" AllowPaging="true" PageSize="10" OnPageIndexChanging="GV_PartyVendorMaster_PageIndexChanging" PagerSettings-Mode="NumericFirstLast">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>

                                                                            <asp:LinkButton ID="Edit_Data" runat="server" CommandArgument='<%# Eval("vendorID") %>' OnClick="Edit_Data_Click"><i class="fa fa-pencil" style="font-size:18px; color:darkblue"></i></asp:LinkButton>

                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:TemplateField>

                                                                    <asp:BoundField DataField="vendorID" HeaderText="VENDOR ID" SortExpression="vendorID">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="vendorType" HeaderText="VENDOR TYPE" SortExpression="vendorType">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="vendorName" HeaderText="VENDOR NAME" SortExpression="vendorName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="vendorContactNo" HeaderText="VENDOR CONTACT NO" SortExpression="vendorContactNo">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="locPincode" HeaderText="PINCODE" SortExpression="locPincode">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="areaName" HeaderText="AREA" SortExpression="areaName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="billingAddress" HeaderText="BILLING ADDRESS" SortExpression="billingAddress">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="branchName" HeaderText="BRANCH NAME" SortExpression="branchName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="category" HeaderText="CATEGORY" SortExpression="category">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OwnerName" HeaderText="OWNER NAME" SortExpression="OwnerName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OwnerContactNo" HeaderText="OWNER CONTACT NO" SortExpression="OwnerContactNo">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OwnerEmailID" HeaderText="OWNER EMAILID" SortExpression="OwnerEmailID">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="UserBranch" HeaderText="USER BRANCH" SortExpression="UserBranch">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <PagerSettings Mode="NumericFirstLast" />
                                                            </asp:GridView>



                                                            <asp:GridView ID="GV_Export" runat="server" AutoGenerateColumns="false" DataKeyNames="vendorID" Visible="false">
                                                                <Columns>

                                                                    <asp:BoundField DataField="vendorType" HeaderText="VENDOR TYPE" SortExpression="vendorType">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="vendorName" HeaderText="VENDOR NAME" SortExpression="vendorName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="vendorContactNo" HeaderText="VENDOR CONTACT NO" SortExpression="vendorContactNo">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="locPincode" HeaderText="PINCODE" SortExpression="locPincode">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="areaName" HeaderText="AREA" SortExpression="areaName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="billingAddress" HeaderText="BILLING ADDRESS" SortExpression="billingAddress">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="branchName" HeaderText="BRANCH NAME" SortExpression="branchName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="category" HeaderText="CATEGORY" SortExpression="category">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OwnerName" HeaderText="OWNER NAME" SortExpression="OwnerName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OwnerContactNo" HeaderText="OWNER CONTACT NO" SortExpression="OwnerContactNo">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="OwnerEmailID" HeaderText="OWNER EMAILID" SortExpression="OwnerEmailID">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>                                                                
                                                                    <asp:BoundField DataField="UserBranch" HeaderText="USER BRANCH" SortExpression="UserBranch">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <PagerSettings Mode="NumericFirstLast" />
                                                            </asp:GridView>
                                                        </div>
                                                    </div>

                                                    <div id="printPage">
                                                        <div class="form-group">

                                                            <div class="row">
                                                                <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                                <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                                    <asp:ImageButton ID="btn_ExporttoExcel" runat="server" CssClass="btn" Text="Export To Excel" OnClick="btn_ExporttoExcel_Click" ImageUrl="images/excel.png" ToolTip="Export To Excel" TabIndex="75"></asp:ImageButton>
                                                                </div>

                                                                <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                                    <asp:ImageButton ID="Btn_Printbtn" runat="server" CssClass="fa fa-print" Text="Print" ImageUrl="images/Print.png" ToolTip="Print" TabIndex="76"></asp:ImageButton>
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


                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                </div>
                <!--==============================================End View=======================================================================-->
            </div>
        </div>
    </div>
    <!--================================================PopUp Window for New AreaCreation============================================================================-->
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

                                <asp:Label ID="Lbl_popArea" runat="server" CssClass="label labelColor labelColor">AREA NAME</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_popArea" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_popArea FirstNoSpaceAndZero" onkeypress="return checkAlpha(event)" TabIndex="55"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                    <div class=" col-sm-3 col-md-2 col-lg-3">
                        <asp:Button ID="Btn_PopupAreaSubmit" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validatePopupAreaDetails()) {return false;} else{ __doPostBack('this.name','');};" CssClass="btn btn-info largeButtonStyle Btn_PopupAreaSubmit" Text="SUBMIT" OnClick="Btn_PopupAreaSubmit_Click" TabIndex="56"></asp:Button>

                    </div>
                    <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                    <div class="col-sm-3 col-md-2 col-lg-3">
                        <asp:Button ID="Btn_PopupAreaClose" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal" TabIndex="57"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for New Area Creation====================================================-->
    <!-----------PopUp End------------->

    <%--<!---------------------------- Email ID Modal ---------------------------->
    <!-- Modal -->
    <div class="modal fade" id="emailModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title labelcolor">Party Email Id</h4>

                </div>

                <!-- Modal body -->
                <div class="modal-body">



                    <div class="form-group">
                        <div class="row">


                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PopPartyName" runat="server" CssClass="label labelColor">Name</asp:Label>
                                <asp:TextBox ID="Txt_PopPartyName" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PartyEmailId1" runat="server" CssClass="label labelColor">Party Email Id 1</asp:Label>
                                <asp:TextBox ID="Txt_PartyEmailId1" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PopPartyName2" runat="server" CssClass="label labelColor">Name</asp:Label>
                                <asp:TextBox ID="Txt_PopPartyName2" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                            </div>

                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PartyEmailId2" runat="server" CssClass="label labelColor">Party Email Id 2</asp:Label>
                                <asp:TextBox ID="Txt_PartyEmailId2" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">


                        <div class=" col-md-2 col-lg-3   "></div>
                        <div class=" col-sm-3 col-md-2 col-lg-2">
                            <div class="form-control-sm"></div>
                            <asp:Button ID="Btn_EmailSubmit" runat="server" CssClass="btn btn-info" Text="Submit"></asp:Button>
                        </div>
                        <div class=" col-sm-3 col-md-2 col-lg-2">
                            <div class="form-control-sm"></div>
                            <asp:Button ID="btn_EmailClose" runat="server" CssClass="btn btn-info " data-dismiss="modal" Text="Close"></asp:Button>
                        </div>

                    </div>

                </div>


            </div>
        </div>
    </div>
    <!---End Modal--------------------------------->--%>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->

    <script src="js/AlertNotifictaion.js"></script>
    <script src="FJS_File/PartyCustomer.js"></script>

    <script>
        function vendor() {
            $('[href="#VendorDetails"]').tab('show');
        }

        function owner() {
            $('[href="#OwnerPerson"]').tab('show');
        }

        function firstline() {
            $('[href="#FirstLine"]').tab('show');
        }

        function secondline() {
            $('[href="#SecondLine"]').tab('show');
        }

    </script>

    <script src="Validation/Val_Party_VendorMaster.js"></script>

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
            var LinkBtn = document.getElementById("<%=Vendor_PanCard_Label.ClientID%>");
                LinkBtn.innerHTML = Imagename;
                LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
                //  window.open('FileUpload/' + Imagename);
            }

            function uploadcomplete2(sender, args) {
                var Imagename = args.get_fileName();
                alert(Imagename);
                var LinkBtn = document.getElementById("<%=Vendor_AadhaarCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //   window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete3(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Vendor_GST_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //   window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete4(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Vendor_CIN_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //    window.open('FileUpload/' + Imagename);
        }



        //Logistic Person Documents


        function uploadcomplete5(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Owner_PanCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete6(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Owner_AadhaarCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //   window.open('FileUpload/' + Imagename);
        }
    </script>

    <script>
        function ShowProgress() {
            document.getElementById('<% Response.Write(UpdateProgress_Upload_Documents.ClientID); %>').style.display = "inline";
            }
    </script>


    <script>

        function Txt_VendorPinCode_Search() {
            $('[id*=HiddenField_Txt_VendorPinCode_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_VendorPinCode_Search]').val());
        }
        function RadioButtonList_VendorPinCode() {
            $('[id*=HiddenField_RadioButtonList_VendorPinCode]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_VendorPinCode]').val());
        }



        function Txt_VendorArea_Search() {
            $('[id*=HiddenField_Txt_VendorArea_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_VendorArea_Search]').val());
        }
        function RadioButtonList_VendorArea() {
            $('[id*=HiddenField_RadioButtonList_VendorArea]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_VendorArea]').val());
        }

        function Txt_BranchName_Search() {
            $('[id*=HiddenField_Txt_BranchName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_BranchName_Search]').val());
        }
        function RadioButtonList_BranchName() {
            $('[id*=HiddenField_RadioButtonList_BranchName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_BranchName]').val());
        }

        function Button_Tab1Save() {
            $('[id*=HiddenField_Button_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab1Save]').val());
        }
        function Btn_ResetVendorCreation() {
            $('[id*=HiddenField_Btn_ResetVendorCreation]').val("1");
            console.log($('[id*=HiddenField_Btn_ResetVendorCreation]').val());
        }



        function Button_Tab2Save() {
            $('[id*=HiddenField_Button_Tab2Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab2Save]').val());
        }

        function Btn_OwnerReset() {
            $('[id*=HiddenField_Btn_OwnerReset]').val("1");
            console.log($('[id*=HiddenField_Btn_OwnerReset]').val());
        }



        function Button_Tab3Save() {
            $('[id*=HiddenField_Button_Tab3Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab3Save]').val());
        }

        function Btn_FirstReset() {
            $('[id*=HiddenField_Btn_FirstReset]').val("1");
            console.log($('[id*=HiddenField_Btn_FirstReset]').val());
        }



        function Button_Tab4Save() {
            $('[id*=HiddenField_Button_Tab4Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab4Save]').val());
        }

        function Btn_SecondReset() {
            $('[id*=HiddenField_Btn_SecondReset]').val("1");
            console.log($('[id*=HiddenField_Btn_SecondReset]').val());
        }



        function Button_Submit1() {
            $('[id*=HiddenField_Button_Submit1]').val("1");
            console.log($('[id*=HiddenField_Button_Submit1]').val());
        }

        function Btn_DocumentReset() {
            $('[id*=HiddenField_Btn_DocumentReset]').val("1");
            console.log($('[id*=HiddenField_Btn_DocumentReset]').val());
        }



        function Txt_SearchCompanyName_Search() {
            $('[id*=HiddenField_Txt_SearchCompanyName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchCompanyName_Search]').val());
        }

        function RadioButtonList_SearchCompanyName() {
            $('[id*=HiddenField_RadioButtonList_SearchCompanyName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchCompanyName]').val());
        }


        function RadioButtonList_SearchBranch() {
            $('[id*=HiddenField_RadioButtonList_SearchBranch]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchBranch]').val());
        }

        function Txt_SearchBranch_Search() {
            $('[id*=HiddenField_Txt_SearchBranch_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchBranch_Search]').val());
        }


        function Txt_SearchOwnerName_Search() {
            $('[id*=HiddenField_Txt_SearchOwnerName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchOwnerName_Search]').val());
        }

        function RadioButtonList_SearchOwnerName() {
            $('[id*=HiddenField_RadioButtonList_SearchOwnerName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchOwnerName]').val());
        }

        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }



    </script>
</asp:Content>

