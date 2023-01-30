<%@ Page Title="Branch Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="BranchCreation_Master.aspx.cs" Inherits="OPERATIONS_BranchCreation" %>

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
            //    var $active = $('.nav-tabs li.active')
            //    firstTab($active);
            //    return false;
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

        //function firstTab(elem) {
        //    $(elem).first().find('a[data-toggle="tab"]').click();
        //    $('[id*hfTabs]').val($(elem).first().attr('id'));
        //}
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
        <asp:UpdateProgress ID="UpdateProgress_Branch_Details" AssociatedUpdatePanelID="UpdatePanel_Branch_Details" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Branch" AssociatedUpdatePanelID="UpdatePanel_Branch" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_View_Details" AssociatedUpdatePanelID="UpdatePanel_View_Details" runat="server" DisplayAfter="0">
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

        <!---Update Progress 6 ---->
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

        <script>
            $(document).ready(function () {
                $("[id*=Ddl_Area]").change(function () {
                    console.log("In On Change", $("[id*=Ddl_Area]").val());
                    $("[id*=hfArea]").val($("[id*=Ddl_Area]").val());
                    console.log($("[id*=hfArea]").val());
                    return false;
                });
            });
            function getBranchType() {
                if ($("[id$=Ddl_Type]").children("option:selected").val() == 'CONTROLLING BRANCH') {
                    $("[id$=ControllingBranch]").hide();
                }
                else if ($("[id$=Ddl_Type]").children("option:selected").val() == 'HEAD OFFICE') {
                    $("[id$=ControllingBranch]").hide();
                }
                else {
                    $("[id$=ControllingBranch]").show();
                }
            };

            function getContractType() {
                if ($("[id$=Ddl_BContractType]").children("option:selected").val() == 'SELECT') {
                    $("[id$=purchasedate]").hide();
                    $("[id$=validfrom]").hide();
                    $("[id$=validto]").hide();
                }
                else if ($("[id$=Ddl_BContractType]").children("option:selected").val() == 'LEASE') {
                    $("[id$=purchasedate]").hide();
                    $("[id$=validfrom]").show();
                    $("[id$=validto]").show();
                }
                else {
                    $("[id$=purchasedate]").show();
                    $("[id$=validfrom]").hide();
                    $("[id$=validto]").hide();
                }
            };

        </script>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div>

            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#BranchDetails" class="nav-link active tabfont">BRANCH CREATION</a>
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
                <!--=========================================================================Branch Details==========================================================================-->
                <div id="BranchDetails" class="tab-pane active">

                    <div id="AlertNotification"></div>

                    <div class="panel panelTop" runat="server">

                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_Branch_Details" runat="server">
                                <ContentTemplate>
                                    <div class="panel-heading panelHead">
                                        <b>BRANCH DETAILS</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div id="mainBranch" runat="server">
                                            <div class="form-horizontal" role="form">
                                                <div>
                                                    <asp:UpdatePanel ID="UpdatePanel_Branch" runat="server">
                                                        <ContentTemplate>

                                                            <div class="form-group ">
                                                                <div class="row ">
                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <asp:HiddenField ID="HiddenField_Ddl_Type" runat="server" />
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_Type" runat="server" CssClass="label labelColor">TYPE</asp:Label><span class="required">*</span>
                                                                        <asp:DropDownList ID="Ddl_Type" runat="server" CssClass="formDisplay Ddl_Type" TabIndex="1" onchange="getBranchType()">
                                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                                            <asp:ListItem>HEAD OFFICE</asp:ListItem>
                                                                            <asp:ListItem Selected="True">BRANCH</asp:ListItem>
                                                                            <asp:ListItem>CONTROLLING BRANCH</asp:ListItem>
                                                                            <asp:ListItem>CO-LOADER</asp:ListItem>
                                                                            <asp:ListItem>FRANCHISE</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BranchName" runat="server" CssClass="label labelColor">BRANCH NAME</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_BranchName" Style="text-transform: uppercase" AutoComplete="off" runat="server" CssClass="form-control input-sm Txt_BranchName FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="2"></asp:TextBox>
                                                                    </div>


                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_Pincode" runat="server" CssClass="label labelColor">PIN CODE</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_Pincode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Pincode" onkeypress="return validateNumericValue(event)" MaxLength="8" onchange="ReadDataonchange('Txt_Pincode','hfPincode','Ddl_Area','Party_CustomerCreation.aspx/getPincode');" TabIndex="3"></asp:TextBox>
                                                                        <asp:HiddenField ID="hfPincode" runat="server" />
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                                        <asp:TextBox ID="Txt_State" runat="server" Text="AUTO" CssClass="form-control input-sm" ReadOnly="true"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                                                        <asp:TextBox ID="Txt_District" runat="server" Text="AUTO" CssClass="form-control input-sm" ReadOnly="true"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                                                        <asp:TextBox ID="Txt_City" runat="server" Text="AUTO" CssClass="form-control input-sm" ReadOnly="true"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_Area" runat="server" CssClass="label labelColor">AREA</asp:Label><span class="required">*</span>
                                                                        <asp:DropDownList ID="Ddl_Area" runat="server" CssClass="formDisplay input-sm Ddl_Area" TabIndex="4">
                                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:HiddenField ID="hfArea" runat="server" />
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BAddress" runat="server" CssClass="label labelColor">ADDRESS</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_BAddress" Style="text-transform: uppercase" AutoComplete="off" runat="server" CssClass="form-control input-sm Txt_BAddress FirstNoSpaceAndZero" TextMode="MultiLine" TabIndex="5"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BLandMark" runat="server" CssClass="label labelColor">LANDMARK</asp:Label>
                                                                        <asp:TextBox ID="Txt_BLandmark" runat="server" Style="text-transform: uppercase" AutoComplete="off" onkeypress="return checkAlphaNumericWithDotAndDash()" CssClass="form-control input-sm Txt_BLandmark FirstNoSpaceAndZero" TabIndex="6"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:HiddenField ID="HiddenField_Ddl_BContractType" runat="server" />
                                                                        <asp:Label ID="Lbl_BContractType" runat="server" CssClass="label labelColor">CONTRACT TYPE</asp:Label><span class="required">*</span>
                                                                        <asp:DropDownList ID="Ddl_BContractType" runat="server" CssClass="formDisplay Ddl_BContractType" onchange="getContractType()" TabIndex="7">
                                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                                            <asp:ListItem>PURCHASE</asp:ListItem>
                                                                            <asp:ListItem Selected="True">LEASE</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="purchasedate" runat="server">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BPurchaseDate" runat="server" CssClass="label labelColor">PURCHASE DATE</asp:Label><span class="required" id="spanPurchaseDate" runat="server">*</span>
                                                                        <asp:TextBox ID="Txt_BPurchaseDate" AutoComplete="off" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_BPurchaseDate" Type="date" TabIndex="8"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="validfrom" runat="server">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BValidFrom" runat="server" CssClass="label labelColor">VALID DATE FROM</asp:Label><span class="required" id="ValidDateFrom" runat="server">*</span>
                                                                        <asp:TextBox ID="Txt_BValidFrom" AutoComplete="off" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_BValidFrom" Type="date" TabIndex="9"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="validto" runat="server">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:HiddenField ID="HiddenField_Txt_BValidTo" runat="server" />
                                                                        <asp:Label ID="Lbl_BValidTo" runat="server" CssClass="label labelColor">VALID DATE TO</asp:Label><span class="required" id="ValidDateTo" runat="server">*</span>
                                                                        <asp:TextBox ID="Txt_BValidTo" autoComplete="off" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_BValidTo" Type="date" TabIndex="10"></asp:TextBox>
                                                                        <%--AutoPostBack="true" OnTextChanged="Txt_BValidTo_TextChanged"--%>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BContractNo" runat="server" CssClass="label labelColor">PROPERTY CONTRACT NO</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_BContractNo" Style="text-transform: uppercase" AutoComplete="off" runat="server" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_BContractNo" TabIndex="11"></asp:TextBox>

                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BOwnerName" runat="server" CssClass="label labelColor">PROP. OWNER NAME</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_BOwnerName" Style="text-transform: uppercase" AutoComplete="off" runat="server" CssClass="form-control input-sm Txt_BOwnerName FirstNoSpaceAndZero" onkeypress="return checkAlpha()" TabIndex="12"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_OwnerContactNo" runat="server" CssClass="label labelColor">PROP. OWNER CONTACT NO</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_BOwnerContactNo" AutoComplete="off" runat="server" CssClass="form-control input-sm Txt_BOwnerContactNo" MaxLength="10" onkeypress="return validateNumericValue(event)" TabIndex="13"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_BEmailId" runat="server" CssClass="label labelColor">PROP. OWNER EMAIL ID</asp:Label><span class="required">*</span>
                                                                        <asp:TextBox ID="Txt_BOwnerEmailId" AutoComplete="off" CssClass="form-control input-sm Txt_BOwnerEmailId" runat="server" onkeypress="return checkEmailId()" placeholder="Enter E-Mail" TabIndex="14"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="ControllingBranch" runat="server">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Label2" runat="server" CssClass="label labelColor">CONTROLLING BRANCH</asp:Label><span class="required">*</span>
                                                                        <asp:DropDownList ID="Ddl_ControllingBranchName" runat="server" CssClass="formDisplay input-sm Ddl_ControllingBranchName" TabIndex="15">
                                                                        </asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <%-- <asp:AsyncPostBackTrigger ControlID="Ddl_Type" EventName="SelectedIndexChanged" />         --%>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <!--===============================================Branch Area Measurement (in Square Feet)details============================================-->
                                    <div class="panel-heading panelHead">
                                        <b>BRANCH AREA MEASUREMENT (IN SQUARE FEET)</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_BuildUp" runat="server" CssClass="label labelColor">BUILD UP</asp:Label>
                                                        <asp:TextBox ID="Txt_BuildUp" runat="server" AutoComplete="off" CssClass="form-control input-sm" onkeypress="return validateNumericValue(event)" TabIndex="16"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Txt_Carpet" runat="server" />
                                                        <asp:Label ID="Lbl_Carpet" runat="server" CssClass="label labelColor">CARPET</asp:Label>
                                                        <asp:TextBox ID="Txt_Carpet" runat="server" AutoComplete="off" CssClass="form-control input-sm" onkeypress="return validateNumericValue(event)" TabIndex="17"></asp:TextBox><%--OnTextChanged="Txt_Carpet_TextChanged" AutoPostBack="true" --%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--==============================================Government policies======================================================== -->
                                    <div class="panel-heading panelHead ac-c">
                                        <b>GOVERNMENT CLAUSES</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-3 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_UnderESIC" runat="server" CssClass="label labelColor">AREA COVERED UNDER ESIC</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_UnderESIC" runat="server" CssClass="formDisplay Ddl_UnderESIC" TabIndex="18">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>YES</asp:ListItem>
                                                            <asp:ListItem>NO</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-3 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CoveredLabourLaw" runat="server" CssClass="label labelColor">AREA COVERED UNDER LABOUR LAW</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_CoveredLabourLaw" runat="server" CssClass="formDisplay Ddl_CoveredLabourLaw" TabIndex="19">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>YES</asp:ListItem>
                                                            <asp:ListItem>NO</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-3 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Cataegory" runat="server" CssClass="label labelColor">AREA CATAGORY</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_Cataegory" runat="server" CssClass="formDisplay Ddl_Cataegory" TabIndex="20">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>MUNICIPLE</asp:ListItem>
                                                            <asp:ListItem>GRAMPANCHAYAT</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>

                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>

                                                        <asp:LinkButton ID="Button_Tab1Save" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Submit" Text="SAVE" OnClick="Button_Tab1Save_Click" UseSubmitBehavior="false" OnClientClick="if (!validateBranchDetails()) {return false;};" TabIndex="21">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>

                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>

                                                        <asp:HiddenField ID="HiddenField_Branch_Reset" runat="server" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Branch_Reset" runat="server" Text="RESET" TabIndex="23" OnClientClick="Branch_Reset()" OnClick="Branch_Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                    </div>
                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:LinkButton runat="server" ID="Btn_Next" CssClass="btn btn-info largeButtonStyle next-step" TabIndex="22">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                        <%-- <button type="button" class="btn btn-info next-step smallButtonStyle1">Next <i class="fa fa-arrow-circle-right"></i></button> --%>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>


                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Button_Tab1Save" EventName="Click" />
                                    <%--<asp:PostBackTrigger ControlID="Button_Tab1Save" />--%>
                                    <asp:AsyncPostBackTrigger ControlID="Branch_Reset" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_Next" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>

                    </div>

                </div>

                <!--========================================Upload Documents=================================================================================-->
                <div id="UploadDoc" class="tab-pane">

                    <div class="panel panelTop" runat="server">
                        <div class="panel-heading panelHead">
                            <b>UPLOAD DOCUMENTS</b>
                        </div>
                        <div class="panel-body labelColor">


                            <div id="Div1" runat="server">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_Upload_Documents" runat="server">
                                            <ContentTemplate>

                                                <div class="form-group ">
                                                    <div class="row ">
                                                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_BranchPanCardNo" runat="server" CssClass="label labelColor">PANCARD NO</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_BranchPanCardNo" AutoComplete="off" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_BranchPanCardNo" MaxLength="10" onkeypress="return checkAlphaNumeric()" TabIndex="32"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <%--<CuteWebUI:Uploader ID="BranchPanCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="BranchPanCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>

                                                            <ajaxToolkit:AjaxFileUpload ID="BranchPanCard_Uploader" runat="server" Mode="Client" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="BranchPanCard_Uploader_UploadComplete" TabIndex="33" />
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <%--<asp:Label ID="BranchPanCard_Label" runat="server" Text=""></asp:Label>--%>
                                                            <a id="BranchPanCard_Label" runat="server" target="_blank"></a>
                                                        </div>
                                                    </div>
                                                    <div class="row ">
                                                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_BranchLineAdharcardNo" runat="server" CssClass="label labelColor">AADHARCARD NO</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_BranchLineAdharcardNo" AutoComplete="off" runat="server" CssClass="form-control input-sm Txt_BranchLineAdharcardNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="34"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <%--<CuteWebUI:Uploader ID="BranchLineAdharCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="BranchLineAdharCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>

                                                            <ajaxToolkit:AjaxFileUpload ID="BranchLineAdharCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="BranchLineAdharCard_Uploader_UploadComplete" TabIndex="35" />
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <%--<asp:Label ID="BranchLineAdharCard_Label" runat="server" Text=""></asp:Label>--%>
                                                            <a id="BranchLineAdharCard_Label" runat="server" target="_blank"></a>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_prev" runat="server" CssClass="btn btn-info largeButtonStyle prev-step" TabIndex="36"><i class="fa fa-arrow-circle-left"></i> PREV</asp:LinkButton>

                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Submit1" runat="server" />
                                                            <asp:LinkButton ID="Button_Submit1" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Button_Submit1_Click" Text="SUBMIT" TabIndex="37">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton><%--UseSubmitBehavior="false" OnClientClick="if (!validateBranchDocDetails()) {return false;};"--%>
                                                        </div>

                                                        <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>

                                                            <asp:HiddenField ID="HiddenField_Btn_DocReset" runat="server" />
                                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_DocReset" runat="server" Text="RESET" TabIndex="38" OnClientClick="Btn_DocReset()" OnClick="Btn_DocReset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>

                                                    </div>
                                                </div>

                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Btn_prev" />
                                                <%--<asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click"/>--%>
                                                <asp:PostBackTrigger ControlID="Button_Submit1" />
                                                <asp:AsyncPostBackTrigger ControlID="Btn_DocReset" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>

                                </div>
                            </div>



                        </div>
                    </div>

                </div>
                <!--======================================End Upload Documents===============================================================================-->
                <!--=====================================Searching Parameter==========================================================================-->
                <div id="ViewDetails" class="tab-pane">
                    <div>
                        <div class="panel panelTop" runat="server">

                            <div>
                                <asp:UpdatePanel ID="UpdatePanel_View_Details" runat="server">
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
                                                                        <asp:Label ID="Lbl_SearchBranch" runat="server" CssClass="label labelColor">BRANCH NAME</asp:Label>
                                                                        <asp:DropDownList ID="Ddl_SearchBranch" runat="server" CssClass="formDisplay" TabIndex="50">
                                                                        </asp:DropDownList>

                                                                    </div>


                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_SearchBranchStatus" runat="server" CssClass="label labelColor">STATUS</asp:Label>
                                                                        <asp:DropDownList ID="Ddl_SearchBranchStatus" runat="server" CssClass="formDisplay" TabIndex="48">
                                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                                            <asp:ListItem>ACTIVE</asp:ListItem>
                                                                            <asp:ListItem>INACTIVE</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                                        <div class="form-control-lg"></div>
                                                                        <div class="form-control-lg"></div>
                                                                        <div class="form-control-sm"></div>
                                                                         <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click" TabIndex="30" Text="SEARCH">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                         
                                                        </ContentTemplate>
                                                        <Triggers>

                                                            <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />


                                                            <%--<asp:PostBackTrigger ControlID="Btn_Search"/>--%>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="panel-body" style="overflow-x: auto" id="Search_BranchDetails_View" runat="server">

                                            <div>
                                                <asp:UpdatePanel ID="UpdatePanel_GridView" runat="server">
                                                    <ContentTemplate>

                                                        <div class="form-horizontal" role="form">

                                                            <div class="form-group">
                                                                <div>
                                                                    <asp:GridView ID="gridViewBranch" runat="server" DataKeyNames="branchID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewBranch_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewBranch_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="ACTION">
                                                                                <ItemTemplate>
                                                                                     <asp:LinkButton ID="editBranchDetails" runat="server" CommandArgument='<%#Eval("branchID") %>' OnClick="editBranchDetails_Click" ToolTip="Edit"><i style="font-size: 18px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton></li>        
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                                                <ItemStyle HorizontalAlign="Center"/>
                                                                            </asp:TemplateField>

                                                                            <asp:BoundField DataField="branchID" HeaderText="BRANCH ID" SortExpression="branchID">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" ForeColor="Black" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="branchNo" HeaderText="BRANCH CODE" SortExpression="branchNo">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="branchType" HeaderText="BRANCH TYPE" SortExpression="branchType">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="branchName" HeaderText="BRANCH NAME" SortExpression="branchName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="status" HeaderText="STATUS" SortExpression="status">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ControllingBranch" HeaderText="CONTROLLING BRANCH" SortExpression="ControllingBranch">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="address" HeaderText="ADDRESS" SortExpression="address">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="landMark" HeaderText="LANDMARK" SortExpression="landMark">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="locPincode" HeaderText="PINCODE" SortExpression="locPincode">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="stateName" HeaderText="STATE" SortExpression="stateName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="districtName" HeaderText="DISTRICT" SortExpression="districtName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="cityName" HeaderText="CITY" SortExpression="cityName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="areaName" HeaderText="AREA" SortExpression="areaName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="username" HeaderText="CREATED BY" SortExpression="username">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black"/>
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                                            </asp:BoundField>

                                                                        </Columns>

                                                                        <HeaderStyle HorizontalAlign="Center" />

                                                                    </asp:GridView>


                                                                    <asp:GridView ID="GV_Export" runat="server" DataKeyNames="branchID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">
                                                                        <Columns>


                                                                            <asp:BoundField DataField="branchNo" HeaderText="BRANCH CODE" SortExpression="branchNo">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="branchType" HeaderText="BRANCH TYPE" SortExpression="branchType">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="branchName" HeaderText="BRANCH NAME" SortExpression="branchName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="status" HeaderText="STATUS" SortExpression="status">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ControllingBranch" HeaderText="CONTROLLING BRANCH" SortExpression="ControllingBranch">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="address" HeaderText="ADDRESS" SortExpression="address">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="landMark" HeaderText="LANDMARK" SortExpression="landMark">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="locPincode" HeaderText="PINCODE" SortExpression="locPincode">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="stateName" HeaderText="STATE" SortExpression="stateName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="districtName" HeaderText="DISTRICT" SortExpression="districtName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="cityName" HeaderText="CITY" SortExpression="cityName">
                                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="areaName" HeaderText="AREA" SortExpression="areaName">
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

                                                                        <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" OnClick="btn_ExporttoExcel_Click" Text="EXPORT TO EXCEL" TabIndex="50" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                                    </div>

                                                                    <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                                        <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="PRINT" TabIndex="51" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
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
                </div>
            </div>

        </div>

    </div>
    <!--================================================PopUp Window for Area============================================================================-->
    <!-- Modal -->
    <%-- <div class="modal modal-sm" id="myModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">New Area</h4>

                </div>
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-lg"></div>
                                <asp:Label ID="Lbl_popArea" runat="server" CssClass="lblsize">Area</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_popArea" runat="server" class="form-control input-sm Txt_popArea"></asp:TextBox>
                            </div>                        
                        </div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="col-sm-1 col-md-2 col-lg-2   "></div>
                        <div class=" col-sm-3 col-md-2 col-lg-3">
                            <div class="form-control-lg"></div>

                            <asp:Button ID="Btn_PopAreaSubmit" runat="server" Text="Submit" CssClass="btn btn-info buttonStyle Btn_PopAreaSubmit" OnClick="Btn_PopAreaSubmit_Click" UseSubmitBehavior="false" OnClientClick="if (!validateAreaDetails()) {return false;} else{ __doPostBack('this.name','');};"></asp:Button>
                        </div>
                        <div class=" col-sm-3 col-md-2 col-lg-3">
                            <div class="form-control-lg"></div>
                            <asp:Button ID="Btn_PopAraeaClose" runat="server" Text="Close" data-dismiss="modal" CssClass="btn btn-info buttonStyle"></asp:Button>
                        </div>
                    </div>
                    <asp:Label ID="lblmsg" runat="server" ></asp:Label> 

                    <!--==========================================*Search Area*======================================================================================-->
                    
                </div>
            </div>
            <!--=====================================End Popup Window for Area====================================================-->
        </div>
    </div>--%>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
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

                                <asp:Label ID="Label1" runat="server" CssClass="lblsize labelColor">AREA NAME</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_popArea" runat="server" CssClass="form-control input-sm Txt_popArea FirstNoSpaceAndZero" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return checkAlpha(event)"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                    <div class=" col-sm-3 col-md-2 col-lg-3">
                        <%--<input type="text" onclick="" onchange="" />--%>
                        <asp:HiddenField ID="HiddenField_Btn_PopAreaSubmit" runat="server" />
                        <asp:Button ID="Btn_PopAreaSubmit" runat="server" Text="SUBMIT" CssClass="btn btn-info largeButtonStyle Btn_PopAreaSubmit" OnClick="Btn_PopAreaSubmit_Click" UseSubmitBehavior="false" OnClientClick="if (!validateAreaDetails()) {return false;} else{ __doPostBack('this.name','');};"></asp:Button>

                    </div>
                    <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                    <div class="col-sm-3 col-md-2 col-lg-3">
                        <asp:Button ID="Btn_Close" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                    </div>
                </div>
                <asp:Label ID="lblmsg" runat="server"></asp:Label>
            </div>
        </div>
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->



    <script src="Validation/Val_BranchMaster.js"></script>
    <script>
        function validateAreaDetails() {
            var check = true;

            if ($('.Txt_popArea').val() != '') {


            } else {
                check = false;
                $('.Txt_popArea').tooltip({
                    placement: "top",
                    title: "Enter Area Name",
                    trigger: "focus"
                });
                $('.Txt_popArea').focus();
            }
            if (!check) {
                return false;
            }
            else {
                return true;
            }
        }

    </script>


    <script>
        function onPopupLostFocus() {
            var be = $find('popupBehavior1');
            if (be != null && be != 'undefined') {
                if (be.get_PopupVisible()) {
                    be.hidePopup();
                }
            }
        }
    </script>

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
            var LinkBtn = document.getElementById("<%=BranchPanCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete2(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=BranchLineAdharCard_Label.ClientID%>");
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
    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="js/AlertNotifictaion.js"></script>

    <script>
        function Ddl_Type() {
            $('[id*=HiddenField_Ddl_Type]').val("1");
            console.log($('[id*=HiddenField_Ddl_Type]').val());
        }

        function Ddl_BContractType() {
            $('[id*=HiddenField_Ddl_BContractType]').val("1");
            console.log($('[id*=HiddenField_Ddl_BContractType]').val());
        }

        function Ddl_BContractType() {
            $('[id*=HiddenField_Ddl_BContractType]').val("1");
            console.log($('[id*=HiddenField_Ddl_BContractType]').val());
        }

        function Txt_BValidTo() {
            $('[id*=HiddenField_Txt_BValidTo]').val("1");
            console.log($('[id*=HiddenField_Txt_BValidTo]').val());
        }


        function Txt_Carpet() {
            $('[id*=HiddenField_Txt_Carpet]').val("1");
            console.log($('[id*=HiddenField_Txt_Carpet]').val());
        }


        function Branch_Reset() {
            $('[id*=HiddenField_Branch_Reset]').val("1");
            console.log($('[id*=HiddenField_Branch_Reset]').val());
        }

        /*Please check the OnClientClick Event*/
        function Submit1() {
            $('[id*=HiddenField_Submit1]').val("1");
            console.log($('[id*=HiddenField_Submit1]').val());
        }
        function Btn_DocReset() {
            $('[id*=HiddenField_Btn_DocReset]').val("1");
            console.log($('[id*=HiddenField_Btn_DocReset]').val());
        }

        function Txt_SearchBranchName_Search() {
            $('[id*=HiddenField_Txt_SearchBranchName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchBranchName_Search]').val());
        }

        function RadioButtonList_SearchBranchName() {
            $('[id*=HiddenField_RadioButtonList_SearchBranchName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchBranchName]').val());
        }

        function Txt_SearchBranchName_Search() {
            $('[id*=HiddenField_Txt_SearchBranchName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchBranchName_Search]').val());
        }

        function RadioButtonList_SearchBranchName() {
            $('[id*=HiddenField_RadioButtonList_SearchBranchName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_ControllingBranch]').val());
        }

        function Txt_SearchState_Search() {
            $('[id*=HiddenField_Txt_SearchState_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchState_Search]').val());
        }

        function RadioButtonList_SearchState() {
            $('[id*=HiddenField_RadioButtonList_SearchState]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchState]').val());
        }

        function Txt_SearchControllingBranch_Search() {
            $('[id*=HiddenField_Txt_SearchControllingBranch_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchControllingBranch_Search]').val());
        }

        function RadioButtonList_SearchControllingBranch() {
            $('[id*=HiddenField_RadioButtonList_SearchControllingBranch]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchControllingBranch]').val());
        }

        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }
        /*Please Check the OnClientClick Event*/
        function Btn_PopAreaSubmit() {
            $('[id*=HiddenField_Btn_PopAreaSubmit]').val("1");
            console.log($('[id*=HiddenField_Btn_PopAreaSubmit]').val());
        }

    </script>


</asp:Content>

