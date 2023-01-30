<%@ Page Title="EMPLOYEE DETAILS" Language="C#" MasterPageFile="AdminMasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="HR_Employee.aspx.cs" Inherits="OPERATIONS_Employee" %>

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

    <%--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>--%>

    <script type="text/javascript">
        $(function () {
            $("[id*=TreeView1] input[type=checkbox]").bind("click", function () {
                var table = $(this).closest("table");

                if (table.next().length > 0 && table.next()[0].tagName == "DIV") {
                    //Is Parent CheckBox
                    var childDiv = table.next();
                    var isChecked = $(this).is(":checked");
                    $("input[type=checkbox]", childDiv).each(function () {
                        if (isChecked) {
                            $(this).attr("checked", "checked");
                        } else {
                            $(this).removeAttr("checked");
                        }
                    });
                }
                else {
                    //Is Child CheckBox
                    var parentDIV = $(this).closest("DIV");
                    if ($("input[type=checkbox]", parentDIV).length == $("input[type=checkbox]:checked", parentDIV).length) {
                        $("input[type=checkbox]", parentDIV.prev()).attr("checked", "checked");
                    } else {
                        $("input[type=checkbox]", parentDIV.prev()).removeAttr("checked");
                    }
                }
            });
        })

        $('#RadioBtn_Male').tooltip({
            placement: "bottom",
            trigger: "hover"

        });
        $('#RadioBtn_FeMale').tooltip({
            placement: "bottom",
            trigger: "hover"

        });
    </script>

    <style type="text/css">
        .ajax__fileupload_dropzone {
            display: none;
        }
    </style>

    <link href="css/AlertNotification.css" rel="stylesheet" />

    <style type="text/css">
        .th-header {
            text-align: center;
        }

        .LblWidth {
            width: 200px;
            font-size: small;
            color: blue;
        }
    </style>
    <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("button").click(function () {
                var label = $("#texens").val("tinkumaster");
                alert($("#texens").val());
                $('[id*=LabelID]').html("#texens");
                //return false;
            });
        });

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                $('#myTab1 a[href="' + activeTab + '"]').tab('show');
            }
        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Employee_Personal_Details" AssociatedUpdatePanelID="UpdatePanel_Employee_Personal_Details" runat="server" DisplayAfter="0">
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
      <%--  <asp:UpdateProgress ID="UpdateProgress6" AssociatedUpdatePanelID="UpdatePanel_Upload_Documents" runat="server" DisplayAfter="0">
            <ProgressTemplate>
                <div id="overlay">
                    <div id="modalprogress">
                        <div id="theprogress">
                            <img src="images/dots-4.gif" />
                        </div>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>--%>

        <!---Update Progress 8 ---->
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

        <!---Update Progress 9 ---->
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
                    <a data-toggle="tab" href="#Employee" class="nav-link active tabfont">EMPLOYEE DETAILS</a>
                </li>
              <%--  <li class="nav-item">
                    <a data-toggle="tab" href="#UploadDoc" class="nav-link tabfont">UPLOAD DOCUMENTS</a>
                </li>--%>
                <li class="nav-item">
                    <a data-toggle="tab" tabindex="99" href="#View" class="nav-link tabfont">VIEW</a>

                </li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--=============================================================Employee Personal Details==================================================================-->

                <div id="Employee" class="tab-pane active">
                    <div class="panel panelTop">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_Employee_Personal_Details" runat="server">
                                <ContentTemplate>
                                    <div class="panel-heading panelHead">
                                        <b>PERSONAL DETAILS</b>
                                        <div style="text-align: right" runat="server" id="dateTime" visible="false">
                                            <asp:Label ID="Lbl_CurrentDateTime" runat="server"></asp:Label>
                                        </div>
                                    </div>

                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Ddl_EmployeeType" runat="server" />
                                                        <asp:Label ID="Lbl_EmployeeType" runat="server" CssClass="label labelColor">EMPLOYEE TYPE</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_EmployeeType" runat="server" onchange="Ddl_EmployeeType()" CssClass="formDisplay Ddl_EmployeeType"  TabIndex="1">                                                         
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>FRESHER</asp:ListItem>
                                                            <asp:ListItem>EXPERIENCED</asp:ListItem>
                                                        </asp:DropDownList>
                                                     <%--AutoPostBack="True" OnSelectedIndexChanged="Ddl_EmployeeType_SelectedIndexChanged"--%>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_FirstName" runat="server" CssClass="label labelColor">FIRST NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_FirstName" runat="server" CssClass="form-control input-sm Txt_FirstName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" Style="text-transform: uppercase" AutoComplete="off" TabIndex="6"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_MiddleName" runat="server" CssClass="label labelColor">MIDDLE NAME</asp:Label>
                                                        <asp:TextBox ID="Txt_MiddleName" runat="server" CssClass="form-control input-sm Txt_MiddleName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" Style="text-transform: uppercase" AutoComplete="off" TabIndex="7"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_LastName" runat="server" CssClass="label labelColor">LAST NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_LastName" runat="server" CssClass="form-control input-sm Txt_LastName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" Style="text-transform: uppercase" AutoComplete="off" TabIndex="8"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_SexMaleFemale" runat="server" CssClass="label labelColor ">GENDER</asp:Label><span class="required">*</span>
                                                        <asp:RadioButton ID="RadioBtn_Male" runat="server" Text="Male" CssClass="rS33x" GroupName="Gender" TabIndex="9" />
                                                        <asp:RadioButton ID="RadioBtn_Female" runat="server" Text="Female" CssClass="rS33x" GroupName="Gender" TabIndex="10" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Birthdate" runat="server" CssClass="label labelColor">BIRTH DATE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Birthdate" runat="server" CssClass="form-control input-sm Txt_Birthdate" Style="text-transform: uppercase" Type="date" AutoComplete="off" TabIndex="11"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_EmployeeContactNo" runat="server" CssClass="label labelColor">EMPLOYEE CONTACT NO</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_EmployeeContactNo" runat="server" CssClass="form-control input-sm Txt_EmployeeContactNo FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)" AutoComplete="off" placeholder="+91" MaxLength="10" TabIndex="12"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_EmailId" runat="server" CssClass="label labelColor">EMAIL ID</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_EmailId" runat="server" CssClass="form-control input-sm Txt_EmailId" onkeypress="return checkEmailId()" AutoComplete="off" TabIndex="13"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PermanantAddress" runat="server" CssClass="label labelColor">PERMANANT ADDRESS</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_PermanantAddress" runat="server" CssClass="form-control input-sm Txt_PermanantAddress FirstNoSpaceAndZero" Style="text-transform: uppercase" AutoComplete="off" TextMode="MultiLine" TabIndex="14"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Check_Address" runat="server" />
                                                        <asp:Label ID="Lbl_CurrentAddress" runat="server" CssClass="label labelColor">CURRENT ADDRESS</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CurrentAddress" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm Txt_CurrentAddress FirstNoSpaceAndZero" TextMode="MultiLine" TabIndex="15"></asp:TextBox>
                                                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor">Same as Above  </asp:Label>
                                                        <asp:CheckBox ID="Check_Address" runat="server" onchange="Check_Address()" OnCheckedChanged="Check_Address_CheckedChanged" AutoPostBack="true" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_DateofJoining" runat="server" CssClass="label labelColor">DATE OF JOINING</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_DateofJoining" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_DateofJoining" Type="date" TabIndex="2" AutoComplete="off"></asp:TextBox>
                                                    </div>

                                                   

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_LinkButton_Search_EmpBelongToBranch" runat="server" Value="" />
                                                        <asp:HiddenField ID="HiddenField_Txt_Search_EmpBelongToBranch" runat="server" Value="" />
                                                        <asp:Label ID="Lbl_EmpBelongToBranch" runat="server" CssClass="label labelColor">OTHER BELONG TO BRANCHES</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <%-- NOT EDITABLE TEXTBOX AND DISPLAY SELECTED VALUE --%>
                                                        <asp:TextBox ID="Txt_EmpBelongToBranch" runat="server" Style="background-color: white; text-transform: uppercase;" ReadOnly="true" TabIndex="2" AutoCompleteType="Disabled" placeholder="SELECT BRANCH" CssClass="form-control input-sm Txt_EmpBelongToBranch"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_EmpBelongToBranch" runat="server" Enabled="true" TargetControlID="Txt_EmpBelongToBranch" PopupControlID="Panel_EmpBelongToBranch" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_EmpBelongToBranch" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto" BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBox" style="position: inherit;">
                                                                <%-- SUBMIT BUTTON --%>
                                                                <asp:LinkButton ID="LinkButton_Search_EmpBelongToBranch" runat="server" OnClientClick="LinkButton_Search_EmpBelongToBranch()" ToolTip="Submit" TabIndex="5" OnClick="LinkButton_Search_EmpBelongToBranch_Click">
                                                                                <img src="images/submit.png" style="height:20px;" class="searchSubmitButtonMultiDropDown" /></asp:LinkButton>
                                                                <%-- SEARCH BOX --%>
                                                                <asp:TextBox ID="Txt_Search_EmpBelongToBranch" runat="server" Style="text-transform: uppercase;" TabIndex="3" placeholder="SEARCH" CssClass="form-control input-sm FirstNoSpaceAndZero txtSearchMultiDropDown"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onchange="Txt_Search_EmpBelongToBranch()" onkeypress="return onlyAlphaValue()" OnTextChanged="Txt_Search_EmpBelongToBranch_TextChanged"></asp:TextBox>
                                                            </div>
                                                            <%--  OnTextChanged="TextBox2_TextChanged" --%>
                                                            <div runat="server" class="ddlDropDownList">
                                                                <%-- SELECT ALL CHECKBOX --%>
                                                                <%--   <asp:CheckBox ID="select_all_EmpBelongToBranch" runat="server" onchange="select_all_EmpBelongToBranch()" AutoPostBack="true" TabIndex="4" OnCheckedChanged="select_all_EmpBelongToBranch_CheckedChanged" Text="SELECT ALL" />--%>
                                                                <%-- DISPLAY VALUE FROM DATABASE --%>
                                                                <asp:CheckBoxList ID="CheckBoxList_EmpBelongToBranch" style="font-size:11px;color:black" runat="server">
                                                                </asp:CheckBoxList>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--================================================================End Personal Details=================================================================================-->

                                    <!--================================================================Medical Details=================================================================================-->

                           <%--         <div runat="server" visible="false">
                                        <div class="panel-heading panelHead">
                                            <b>MEDICAL DETAILS</b>
                                        </div>

                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_BloodGroup" runat="server" CssClass="label labelColor">Blood Group</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_BloodGroup" runat="server" CssClass="formDisplay Ddl_BloodGroup" TabIndex="16">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>A+</asp:ListItem>
                                                                <asp:ListItem>O+</asp:ListItem>
                                                                <asp:ListItem>B+</asp:ListItem>
                                                                <asp:ListItem>AB+</asp:ListItem>
                                                                <asp:ListItem>A-</asp:ListItem>
                                                                <asp:ListItem>O-</asp:ListItem>
                                                                <asp:ListItem>B-</asp:ListItem>
                                                                <asp:ListItem>AB-</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Physicaldisability" runat="server" CssClass="label labelColor">Physical disability</asp:Label><span class="required">*</span>
                                                            <div class="form-control-sm"></div>
                                                            <asp:RadioButton ID="Radio_Yes" runat="server" Text="Yes" CssClass="YesNo" GroupName="PhisicalDisability" TabIndex="17" />
                                                            <asp:RadioButton ID="Radio_No" runat="server" Text="No" CssClass="YesNo" GroupName="PhisicalDisability" TabIndex="18" />
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Radio_Yes2" runat="server" />
                                                            <asp:HiddenField ID="HiddenField_Radio_No2" runat="server" />
                                                            <asp:Label ID="Lbl_MajorIllness" runat="server" CssClass="label labelColor">Major Illness</asp:Label><span class="required">*</span>
                                                            <div class="form-control-sm"></div>
                                                            <asp:RadioButton ID="Radio_Yes2" runat="server" Text="Yes" onchange="Radio_Yes2()" CssClass="YesNo1" GroupName="MajorIllness" TabIndex="19" AutoPostBack="true" OnCheckedChanged="Radio_Yes2_CheckedChanged" />
                                                            <asp:RadioButton ID="Radio_No2" runat="server" Text="No" onchange="Radio_No2()" CssClass="YesNo1" GroupName="MajorIllness" TabIndex="20" AutoPostBack="true" OnCheckedChanged="Radio_No2_CheckedChanged" />
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="MajorIllnessDescribe" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_Describe" runat="server" CssClass="label labelColor">Describe</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_Describe" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_Describe" TabIndex="21" TextMode="MultiLine"></asp:TextBox>

                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                    </div>--%>
                                    <!--================================================================End Medical Details=================================================================================-->


                                    <!--================================================================Previous Experience Details=================================================================================-->
                                 <%--   <div runat="server" visible="false">
                                        <div id="PreviousExperience" runat="server" visible="false">
                                            <div class="panel-heading panelHead">
                                                <b>PREVIOUS EXPERIENCE DETAILS</b>
                                            </div>

                                            <div class="panel-body labelColor">
                                                <div class="form-horizontal" role="form">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>

                                                                <asp:Label ID="Lbl_PrevousCompanyName" runat="server" CssClass="label labelColor">Previous company Name</asp:Label><span class="required">*</span>
                                                                <asp:TextBox ID="Txt_PrevousCompanyName" Style="text-transform: uppercase" AutoComplete="off" runat="server" CssClass="form-control input-sm Txt_PrevousCompanyName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="22"></asp:TextBox>

                                                            </div>

                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>

                                                                <asp:Label ID="Lbl_Durationfrom" runat="server" CssClass="label labelColor">Duration (from)</asp:Label><span class="required">*</span>
                                                                <asp:TextBox ID="Txt_Durationfrom" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_Durationfrom" Type="date" TabIndex="23"></asp:TextBox>

                                                            </div>

                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <asp:HiddenField ID="HiddenField_Txt_DurationTo" runat="server" />
                                                                <asp:Label ID="Lbl_DurationTo" runat="server" CssClass="label labelColor">Duration (To)</asp:Label><span class="required">*</span>
                                                                <asp:TextBox ID="Txt_DurationTo" runat="server" AutoComplete="off" Style="text-transform: uppercase" onchange="Txt_DurationTo()" CssClass="form-control input-sm Txt_DurationTo" Type="date" AutoPostBack="true" OnTextChanged="Txt_DurationTo_TextChanged" TabIndex="24"></asp:TextBox>

                                                            </div>

                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>

                                                                <asp:Label ID="Lbl_PrevDesgination" runat="server" CssClass="label labelColor">Desgination</asp:Label><span class="required">*</span>
                                                                <asp:TextBox ID="Txt_PrevDesgination" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm Txt_PrevDesgination FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="25"></asp:TextBox>

                                                            </div>

                                                        </div>
                                                    </div>



                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <!--================================================================End Previous Experience Details=================================================================================-->
                                    <!--================================================================Joining details Details=================================================================================-->
                                    <div class="panel-heading panelHead">
                                        <b>JOINING DETAILS</b>
                                    </div>

                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label2" runat="server" CssClass="label labelColor">DEPARTMENT</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_Department" runat="server" CssClass="formDisplay" TabIndex="103">
                                                        </asp:DropDownList>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label3" runat="server" CssClass="label labelColor">DESIGNATION</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_Designation" runat="server" CssClass="formDisplay" TabIndex="103">
                                                        </asp:DropDownList>
                                                    </div>

                                                   <%-- <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_MonthlyGrossSalary" runat="server" CssClass="label labelColor">Monthly Gross Salary</asp:Label>
                                                        <asp:TextBox ID="Txt_MonthlyGrossSalary" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_MonthlyGrossSalary FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)" TabIndex="32"></asp:TextBox>

                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="AnnualGrossSalary" runat="server" CssClass="label labelColor">Annual Gross Salary</asp:Label>
                                                        <asp:TextBox ID="Txt_AnnualGrossSalary" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_AnnualGrossSalary FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)" TabIndex="33"></asp:TextBox>

                                                    </div>--%>

                                                </div>
                                            </div>
                                              <div class="form-group">
                                                    <div class="row">
                                                        <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Tab1Save" runat="server" />
                                                            <asp:LinkButton ID="Button_Tab1Save" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateEmployeeDetails()) {return false;} else{ __doPostBack('this.name','');};" class="btn btn-info largeButtonStyle Btn_EmpSubmit" Text="SAVE" OnClick="Button_Tab1Save_Click" TabIndex="45">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                        </div>

                                                        <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Emp_Reset" runat="server" />
                                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Emp_Reset" runat="server" Text="RESET" OnClientClick="Emp_Reset()" TabIndex="46" OnClick="Emp_Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>

                                                      <%--  <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton runat="server" ID="Btn_Next" CssClass="btn btn-info next-step largeButtonStyle" TabIndex="47">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>                                                   
                                                        </div>--%>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>

                                    <!--================================================================End Joining Details=================================================================================-->

                                    <!--================================================================Bank Account details=================================================================================-->
                               <%--     <div runat="server" visible="false">
                                        <div class="panel-heading panelHead">
                                            <b>BANK ACCOUNT DETAILS</b>
                                        </div>

                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_NameofBank" runat="server" CssClass="label labelColor">Name of Bank</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_NameofBank" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm Txt_NameofBank FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="34"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Branch" runat="server" CssClass="label labelColor">Branch</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_Branch" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm Txt_Branch FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="35"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_BankAddress" runat="server" CssClass="label labelColor">Address </asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_BankAddress" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm Txt_BankAddress FirstNoSpaceAndZero" onkeypress="return checkAlphaNumeric()" TabIndex="36" TextMode="MultiLine"></asp:TextBox>

                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">State</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_State" runat="server" CssClass="formDisplay" TabIndex="103">
                                                        </asp:DropDownList>
                                                    </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_BankAccountNumber" runat="server" CssClass="label labelColor">Bank Account Number</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_BankAccountNumber" Style="text-transform: uppercase" AutoComplete="off" runat="server" MaxLength="21" CssClass="form-control input-sm Txt_BankAccountNumber" onkeypress="return validateNumericValue(event)" TabIndex="40"></asp:TextBox>
                                                            <%--  Bank Account Numbers of different types of Banks:-   https://latestbankupdate.blogspot.com/2016/02/digits-in-account-number-of-indian-banks.html?m=1    -%>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_IFSCcode" runat="server" CssClass="label labelColor">IFSC code</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_IFSCcode" runat="server" Style="text-transform: uppercase" AutoComplete="off" MaxLength="11" CssClass="form-control input-sm Txt_IFSCcode" TabIndex="41" onkeypress="return checkAlphaNumeric()"></asp:TextBox>

                                                            <%--  Bank IFSC Code of different types of Banks:- https://www.policybazaar.com/ifsc/  -%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
                                    <!--================================================================End Bank Account details=================================================================================-->
                                    <!--================================================================Employee Provident Fund Details=================================================================================-->
                                 <%--   <div runat="server" visible="false">
                                        <div class="panel-heading panelHead">
                                            <b>PROVIDENT FUND DETAILS</b>
                                        </div>

                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_PFNumber" runat="server" CssClass="label labelColor">PF Number</asp:Label>
                                                            <asp:TextBox ID="Txt_PFNumber" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_PFNumber" Style="text-transform: uppercase" onkeypress="return checkAlphaNumeric()" TabIndex="42"></asp:TextBox>


                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_DateofRegistration" runat="server" CssClass="label labelColor">Date of Registration</asp:Label>
                                                            <asp:TextBox ID="Txt_DateofRegistration" AutoComplete="off" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_DateofRegistration" Type="date" TabIndex="43"></asp:TextBox>

                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>

                                                            <asp:Label ID="Lbl_UAN" runat="server" CssClass="label labelColor">UAN</asp:Label>
                                                            <asp:TextBox ID="Txt_UAN" runat="server" AutoComplete="off" CssClass="form-control input-sm Txt_UAN" Style="text-transform: uppercase" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="44"></asp:TextBox>

                                                        </div>

                                                    </div>
                                                </div>

                                              

                                            </div>
                                        </div>
                                    </div>--%>
                                    <!--================================================================End Employee Provident Fund details=================================================================================-->


                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Ddl_EmployeeType" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Check_Address" EventName="CheckedChanged" />
                                   <%-- <asp:AsyncPostBackTrigger ControlID="Radio_Yes2" EventName="CheckedChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Radio_No2" EventName="CheckedChanged" />--%>
                                    <asp:AsyncPostBackTrigger ControlID="Button_Tab1Save" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Emp_Reset" EventName="Click" />
                                 <%--   <asp:AsyncPostBackTrigger ControlID="Btn_Next" />--%>
                                    <asp:AsyncPostBackTrigger ControlID="LinkButton_Search_EmpBelongToBranch" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Txt_Search_EmpBelongToBranch" EventName="TextChanged" />
                                    <%--<asp:AsyncPostBackTrigger ControlID="select_all_EmpBelongToBranch" EventName="CheckedChanged" />--%>
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                </div>



                <!--=============================================================End Employee Details==================================================================-->
                <!--=================================================Upload Documents=================================================================================-->
              <%--  <div id="UploadDoc" class="tab-pane">
                    <div id="Div1" runat="server">
                        <div class="panel panelTop" runat="server">
                            <div class="panel-heading panelHead">
                                <b>UPLOAD DOCUMENTS</b>
                            </div>

                            <div class="panel-body labelColor">

                                <div>
                                    <asp:UpdatePanel ID="UpdatePanel_Upload_Documents" runat="server">
                                        <ContentTemplate>

                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">

                                                    <div class="row">
                                                        <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                        <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_PancardNo" runat="server" CssClass="label labelColor">PANCARD NO</asp:Label>
                                                            <asp:TextBox ID="Txt_PancardNo" runat="server" Style="text-transform: uppercase;" AutoComplete="off" CssClass="form-control input-sm Txt_PancardNo" MaxLength="10" onkeypress="return checkAlphaNumeric()" TabIndex="90"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <ajaxToolkit:AjaxFileUpload ID="Emp_PanCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Emp_PanCard_Uploader_UploadComplete" TabIndex="91" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <a id="Emp_PanCard_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                        <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_AadharNo" runat="server" CssClass="label labelColor">AADHARCARD NO</asp:Label>
                                                            <asp:TextBox ID="Txt_AadharNo" runat="server" AutoComplete="off" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_AadharNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="92"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <ajaxToolkit:AjaxFileUpload ID="Emp_AadhaarCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Emp_AadhaarCard_Uploader_UploadComplete" TabIndex="93" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <div class="form-control-sm"></div>
                                                            <a id="Emp_AadhaarCard_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                        <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Resume" runat="server" CssClass="label labelColor">RESUME</asp:Label>
                                                        </div>

                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>

                                                            <ajaxToolkit:AjaxFileUpload ID="Emp_Resume_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete3" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Emp_Resume_Uploader_UploadComplete" TabIndex="94" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <a id="Emp_Resume_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>




                                                    <div class="row">
                                                        <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                        <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Photo" runat="server" CssClass="label labelColor">PHOTO</asp:Label>
                                                        </div>

                                                        <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                            <div class="form-control-sm"></div>

                                                            <ajaxToolkit:AjaxFileUpload ID="Emp_Photo_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                                OnClientUploadComplete="uploadcomplete4" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                                OnUploadComplete="Emp_Photo_Uploader_UploadComplete" TabIndex="95" />

                                                        </div>

                                                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <a id="Emp_Photo_Label" runat="server" target="_blank"></a>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:LinkButton ID="Btn_Prev1" runat="server" class="btn btn-info prev-step largeButtonStyle" TabIndex="96"><i class="fa fa-arrow-circle-left"></i>PREV</asp:LinkButton>
                                                        <%-- <button type="button" class="btn btn-info  prev-step smallButtonStyle"><i class="fa fa-arrow-circle-left"></i>PREV</button>-%>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Submit1" runat="server" />
                                                        <asp:LinkButton ID="Button_Submit1" runat="server" class="btn btn-info largebuttonStyle Btn_DocSubmit" Text="SUBMIT" OnClick="Button_Submit1_Click" TabIndex="97">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>

                                                    </div>

                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>

                                                        <asp:HiddenField ID="HiddenField_Upload_Reset" runat="server" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Upload_Reset" runat="server" OnClientClick="Upload_Reset()" Text="RESET" TabIndex="98" OnClick="Upload_Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                    </div>

                                                </div>
                                            </div>


                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="Btn_Prev1" />
                                            <asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click" />
                                            <%--<asp:PostBackTrigger ControlID="Button_FinalTabSave" />-%>
                                            <asp:AsyncPostBackTrigger ControlID="Upload_Reset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>



                        </div>
                    </div>

                </div>--%>
                <!--================================================================End Upload Document details=================================================================================-->


                <!--=====================================Searching Parameter==========================================================================-->
                <div id="View" class="tab-pane">
                    <div id="hideshow" runat="server">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_View_Search" runat="server">
                                <ContentTemplate>


                                    <div class="panel panelTop" runat="server">


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
                                                                        <asp:Label ID="Lbl_SearchEmployeeName" runat="server" CssClass="label labelColor">EMPLOYEE NAME</asp:Label>
                                                                        <asp:DropDownList ID="Ddl_SearchEmployeeName" runat="server" CssClass="formDisplay" TabIndex="103">
                                                                        </asp:DropDownList>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_SearchEmployeeType" runat="server" CssClass="label labelColor">EMPLOYEE TYPE</asp:Label>
                                                                        <asp:DropDownList ID="Ddl_SearchEmployeeType" runat="server" CssClass="formDisplay" TabIndex="103">
                                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                                            <asp:ListItem>FRESHER</asp:ListItem>
                                                                            <asp:ListItem>EXPERIENCED</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_SearchDepartment" runat="server" CssClass="label labelColor">DEPARTMENT</asp:Label>
                                                                        <asp:DropDownList ID="Ddl_SearchDepartment" runat="server" CssClass="formDisplay" TabIndex="103">
                                                                        </asp:DropDownList>
                                                                    </div>

                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                        <div class="form-control-lg"></div>
                                                                        <div class="form-control-lg"></div>
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                                        <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click" TabIndex="107" Text="SEARCH">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                                    </div>


                                                                </div>
                                                            </div>

                                                        </ContentTemplate>
                                                        <Triggers>
                                                   
                                                            <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click"/>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="panel-body">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group" id="Search_EmployeeDetails_View" runat="server">
                                                    <asp:GridView ID="gridViewEmployeeCreation" runat="server" DataKeyNames="userID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewEmployeeCreation_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewEmployeeCreation_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="ACTION">
                                                                <ItemTemplate>
                                                                   
                                                                    <asp:LinkButton ID="editEmployeeCreationDetails" runat="server" OnClick="editEmployeeCreationDetails_Click" CommandArgument='<%#Eval("userID") %>' ToolTip="Edit"><i style="font-size: 18px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                                  
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/>
                                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="userID" HeaderText="USER ID" SortExpression="userID">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="EmployeeNo" HeaderText="EMPLOYEE CODE" SortExpression="employeeNo">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                               <asp:BoundField DataField="fullName" HeaderText="EMPLOYEE NAME" SortExpression="fullName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="employeeType" HeaderText="TYPE OF EMPLOYEE" SortExpression="employeeType">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="joiningDate" HeaderText="JOINING DATE" SortExpression="joiningDate">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>                                                      
                                                            <asp:BoundField DataField="gender" HeaderText="GENDER" SortExpression="gender">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="birthDate" HeaderText="DATE OF BIRTH" SortExpression="birthDate">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="contactNo" HeaderText="CONTACT NO" SortExpression="contactNo">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="emailID" HeaderText="EMAIL-ID" SortExpression="emailID">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permanentAddress" HeaderText="PERMANENT ADDRESS" SortExpression="permanentAddress">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="currentAddress" HeaderText="CURRENT ADDRESS" SortExpression="currentAddress">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField> 
                                                              <asp:BoundField DataField="department" HeaderText="EMPLOYEE DEPARTMENT" SortExpression="department">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                            </asp:BoundField>                                                    
                                                            <asp:BoundField DataField="departmentName" HeaderText="EMPLOYEE DEPARTMENT" SortExpression="departmentName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="designationName" HeaderText="EMPLOYEE DESIGNATION" SortExpression="designationName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>                                                       
                                                            <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="panCardFileName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                        </Columns>


                                                        <HeaderStyle HorizontalAlign="Center" />

                                                    </asp:GridView>

                                                    <asp:GridView ID="GV_Export" runat="server" DataKeyNames="userID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">
                                                        <Columns>

                                                         
                                                            <asp:BoundField DataField="EmployeeNo" HeaderText="EMPLOYEE CODE" SortExpression="employeeNo">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                              <asp:BoundField DataField="fullName" HeaderText="EMPLOYEE NAME" SortExpression="fullName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="employeeType" HeaderText="TYPE OF EMPLOYEE" SortExpression="employeeType">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="joiningDate" HeaderText="JOINING DATE" SortExpression="joiningDate">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                         
                                                            <asp:BoundField DataField="gender" HeaderText="GENDER" SortExpression="gender">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="birthDate" HeaderText="DATE OF BIRTH" SortExpression="birthDate">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="contactNo" HeaderText="CONTACT NO" SortExpression="contactNo">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="emailID" HeaderText="EMAIL-ID" SortExpression="emailID">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="permanentAddress" HeaderText="PERMANENT ADDRESS" SortExpression="permanentAddress">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="currentAddress" HeaderText="CURRENT ADDRESS" SortExpression="currentAddress">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                             <asp:BoundField DataField="department" HeaderText="EMPLOYEE DEPARTMENT" SortExpression="department">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" CssClass="hidden" Wrap="false" />
                                                            </asp:BoundField>                                                       
                                                            <asp:BoundField DataField="departmentName" HeaderText="EMPLOYEE DEPARTMENT" SortExpression="departmentName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="designationName" HeaderText="EMPLOYEE DESIGNATION" SortExpression="designationName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>                                                       
                                                            <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="panCardFileName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                        </Columns>


                                                        <HeaderStyle HorizontalAlign="Center" />

                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div id="printPage">
                                                <div class="form-group">

                                                    <div class="row">
                                                        <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                        <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                            <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" OnClick="btn_ExporttoExcel_Click" TabIndex="108" runat="server" Text="Export To Excel" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                        </div>

                                                        <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                            <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="Print" TabIndex="109" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
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
                <!--======================================================End Searching==============================================================================-->
            </div>

        </div>



    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->

    <script type="text/javascript">
        function uploaderror() {
            alert("sonme error occured while uploading file!");
        }
    </script>

    <%-- Customer Documents --%>
  <%--  <script type="text/javascript">
        function uploadcomplete(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Emp_PanCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete2(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Emp_AadhaarCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete3(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Emp_Resume_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            //  window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete4(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Emp_Photo_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            // window.open('FileUpload/' + Imagename);
        }



        <%--      //Logistic Person Documents


        function uploadcomplete5(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Logistic_PanCard_Label.ClientID%>");
        LinkBtn.innerHTML = Imagename;
        LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
        window.open('FileUpload/' + Imagename);
    }

    function uploadcomplete6(sender, args) {
        var Imagename = args.get_fileName();
        alert(Imagename);
        var LinkBtn = document.getElementById("<%=Logistic_AadhaarCard_Label.ClientID%>");
        LinkBtn.innerHTML = Imagename;
        LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
        window.open('FileUpload/' + Imagename);
    }


    //Finance Person Documents

    function uploadcomplete7(sender, args) {
        var Imagename = args.get_fileName();
        alert(Imagename);
        var LinkBtn = document.getElementById("<%=Finance_PanCard_Label.ClientID%>");
        LinkBtn.innerHTML = Imagename;
        LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
        window.open('FileUpload/' + Imagename);
    }

    function uploadcomplete8(sender, args) {
        var Imagename = args.get_fileName();
        alert(Imagename);
        var LinkBtn = document.getElementById("<%=Finance_AadhaarCard_Label.ClientID%>");
        LinkBtn.innerHTML = Imagename;
        LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
        window.open('FileUpload/' + Imagename);
    }


    //Director Person Documents

    function uploadcomplete9(sender, args) {
        var Imagename = args.get_fileName();
        alert(Imagename);
        var LinkBtn = document.getElementById("<%=Director_PacCard_Label.ClientID%>");
        LinkBtn.innerHTML = Imagename;
        LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
        window.open('FileUpload/' + Imagename);
    }

    function uploadcomplete10(sender, args) {
        var Imagename = args.get_fileName();
        alert(Imagename);
        var LinkBtn = document.getElementById("<%=Director_AadhaarCard_Label.ClientID%>");
        LinkBtn.innerHTML = Imagename;
        LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
        window.open('FileUpload/' + Imagename);
    }-%>

    </script>--%>

    <%--<script src="JScript/jquery-1.5.2.js" type="text/javascript"></script>--%>

    <%-- <scriptsrc="http://code.jquery.com/jquery-1.5.2.js"></script>--%>

    <%--http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.5.2.min.js--%>
    <script src="Validation/Val_HR_EmployeeMaster.js"></script>

    <%--<script type="text/javascript">
        $(document).ready(function() {
            $("input[type=submit][id*=Btn_Submit]").click(function () {
        if ($(".rS33x input[type=radio]:checked").length == 0) {
                    alert("Select option");
                    return false;
                }
            });
        });
    
</script>--%>

    <script type="text/javascript">
        function CheckPasswordStrength(password) {
            var password_strength = document.getElementById("password_strength");

            //TextBox left blank.
            if (password.length == 0) {
                password_strength.innerHTML = "";
                return;
            }

            //Regular Expressions.
            var regex = new Array();
            regex.push("[A-Z]"); //Uppercase Alphabet.
            regex.push("[a-z]"); //Lowercase Alphabet.
            regex.push("[0-9]"); //Digit.
            regex.push("[@_]"); //Special Character.

            var passed = 0;

            //Validate for each Regular Expression.
            for (var i = 0; i < regex.length; i++) {
                if (new RegExp(regex[i]).test(password)) {
                    passed++;
                }
            }

            //Validate for length of Password.
            if (passed > 2 && password.length > 8) {
                passed++;
            }

            //Display status.
            var color = "";
            var strength = "";
            switch (passed) {
                case 0:
                case 1:
                    strength = "Weak Password";
                    color = "red";
                    break;
                case 2:
                    strength = "Good Password";
                    color = "darkorange";
                    break;
                case 3:
                case 4:
                    strength = "Strong Password";
                    color = "green";
                    break;
                case 5:
                    strength = "Very Strong Password";
                    color = "darkgreen";
                    break;
            }
            password_strength.innerHTML = strength;
            password_strength.style.color = color;
        }


    </script>

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
    </script>

    <script src="js/AlertNotifictaion.js"></script>


    <script type="text/javascript">

        function Ddl_EmployeeType() {
            $('[id*=HiddenField_Ddl_EmployeeType]').val("1");
            console.log($('[id*=HiddenField_Ddl_EmployeeType]').val());
        }

        function Txt_BelongToBranch_Search() {
            $('[id*=HiddenField_Txt_BelongToBranch_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_BelongToBranch_Search]').val());
        }

        function RadioButtonList_BelongToBranch() {
            $('[id*=HiddenField_RadioButtonList_BelongToBranch]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_BelongToBranch]').val());
        }

        function Check_Address() {
            $('[id*=HiddenField_Check_Address]').val("1");
            console.log($('[id*=HiddenField_Check_Address]').val());
        }

        function Radio_Yes2() {
            $('[id*=HiddenField_Radio_Yes2]').val("1");
            console.log($('[id*=HiddenField_Radio_Yes2]').val());
        }
        function Radio_No2() {
            $('[id*=HiddenField_Radio_No2]').val("1");
            console.log($('[id*=HiddenField_Radio_No2]').val());
        }

        function Txt_DurationTo() {
            $('[id*=HiddenField_Txt_DurationTo]').val("1");
            console.log($('[id*=HiddenField_Txt_DurationTo]').val());
        }
        function Txt_JoiningDepartment_Search() {
            $('[id*=HiddenField_Txt_JoiningDepartment_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_JoiningDepartment_Search]').val());
        }

        function RadioButtonList_JoiningDepartment() {
            $('[id*=HiddenField_RadioButtonList_JoiningDepartment]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_JoiningDepartment]').val());
        }

        function Txt_JoiningDesignation_Search() {
            $('[id*=HiddenField_Txt_JoiningDesignation_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_JoiningDesignation_Search]').val());
        }

        function RadioButtonList_JoiningDesignation() {
            $('[id*=HiddenField_RadioButtonList_JoiningDesignation]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_JoiningDesignation]').val());
        }



        function Txt_State_Search() {
            $('[id*=HiddenField_Txt_State_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_State_Search]').val());
        }

        function RadioButtonList_State() {
            $('[id*=HiddenField_RadioButtonList_State]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_State]').val());
        }


        function Tab1Save() {
            $('[id*=HiddenField_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Tab1Save]').val());
        }


        function Emp_Reset() {
            $('[id*=HiddenField_Emp_Reset]').val("1");
            console.log($('[id*=HiddenField_Emp_Reset]').val());
        }

        //function Btn_Reset_Others() {
        //    $('[id*=HiddenField_Btn_Reset_Others]').val("1");
        //    console.log($('[id*=HiddenField_Btn_Reset_Others]').val());
        //}



        function Submit1() {
            $('[id*=HiddenField_Submit1]').val("1");
            console.log($('[id*=HiddenField_Submit1]').val());
        }


        function Upload_Reset() {
            $('[id*=HiddenField_Upload_Reset]').val("1");
            console.log($('[id*=HiddenField_Upload_Reset]').val());
        }

        function Txt_SearchEmployeeName_Search() {
            $('[id*=HiddenField_Txt_SearchEmployeeName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchEmployeeName_Search]').val());
        }


        function RadioButtonList_SearchEmployeeName() {
            $('[id*=HiddenField_RadioButtonList_SearchEmployeeName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchEmployeeName]').val());
        }
        function Txt_SearchDepartment_Search() {
            $('[id*=HiddenField_Txt_SearchDepartment_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchDepartment_Search]').val());
        }
        function RadioButtonList_SearchDepartment() {
            $('[id*=HiddenField_RadioButtonList_SearchDepartment]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchDepartment]').val());
        }
        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }

        function LinkButton_Search_EmpBelongToBranch() {
            $('[id*=HiddenField_LinkButton_Search_EmpBelongToBranch]').val("1");
            console.log($('[id*=HiddenField_LinkButton_Search_EmpBelongToBranch]').val());
        }
        function Txt_Search_EmpBelongToBranch() {
            $('[id*=HiddenField_Txt_Search_EmpBelongToBranch]').val("1");
            console.log($('[id*=HiddenField_Txt_Search_EmpBelongToBranch]').val());
        }



    </script>


</asp:Content>

