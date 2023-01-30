<%@ Page Title="Party Customer Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Party_CustomerCreation.aspx.cs" Inherits="OPERATIONS_party_master_CustomerCreation" %>

<%--<%@ Register Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" TagPrefix="CuteWebUI" %>--%>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />

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
        <%--<asp:HiddenField ID="hfFirstTab" Value="" runat="server" />--%>

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Customer_Information" AssociatedUpdatePanelID="UpdatePanel_Customer_Information" runat="server" DisplayAfter="0">
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
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_SalesPerson" AssociatedUpdatePanelID="UpdatePanel_SalesPerson" runat="server" DisplayAfter="0">
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
        <!---Update Progress 5 ---->
        <asp:UpdateProgress ID="UpdateProgress_OtherPerson" AssociatedUpdatePanelID="UpdatePanel_OtherPerson" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_Upload_Document" AssociatedUpdatePanelID="UpdatePanel_Upload_Document" runat="server" DisplayAfter="0">
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
        <!---Update Progress 10 ---->
        <asp:UpdateProgress ID="UpdateProgress_Grid_View" AssociatedUpdatePanelID="UpdatePanel_Grid_View" runat="server" DisplayAfter="0">
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
        <!---Update Progress 11 ---->
        <%-- <asp:UpdateProgress ID="UpdateProgress_Edit_Records" AssociatedUpdatePanelID="UpdatePanel_Edit_Records" runat="server" DisplayAfter="0">
            <ProgressTemplate><div id="overlay"><div id="modalprogress"><div id="theprogress"><img src="images/dots-4.gif" /></div></div></div></ProgressTemplate>
        </asp:UpdateProgress>--%>




        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#home" class="nav-link active tabfont">CUSTOMER CREATION</a>
                </li>
                <li class="nav-item disabled">
                    <a data-toggle="tab" href="#OtherPerson_Tab" class="nav-link tabfont">OTHER PERSON DETAIL</a>
                </li>
                <li class="nav-item disabled">
                    <a data-toggle="tab" href="#UploadDoc" class="nav-link tabfont">UPLOAD DOCUMENT</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View_Tab" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->

            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--==============================================Customer Information=======================================================================-->
                <div id="home" class="tab-pane active">
                    <div id="MainCustomer" runat="server">
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>CUSTOMER DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_Customer_Information" runat="server">
                                            <ContentTemplate>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_CustomerId" runat="server" CssClass="label labelColor" Text=""></asp:Label>
                                                            <asp:Label ID="Lbl_TypeofParty" runat="server" CssClass="label labelColor">TYPE OF CUSTOMER</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_TypeofParty" runat="server" CssClass="formDisplay Ddl_TypeofParty" TabIndex="1">
                                                                <asp:ListItem Selected="True">CORPORATE</asp:ListItem>
                                                                <asp:ListItem>3PL PARTNERS</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div id="customercategory" runat="server" class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">

                                                            <asp:Label ID="Lbl_Categoryofcustomer" runat="server" CssClass="label labelColor">CATEGORY OF CUSTOMER</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_Categoryofcustomer" runat="server" CssClass="formDisplay Ddl_Categoryofcustomer" TabIndex="2" onchange="getCustomerCategory();">
                                                                <%--AutoPostBack="true" OnSelectedIndexChanged="Ddl_Categoryofcustomer_SelectedIndexChanged"--%>
                                                                <asp:ListItem Selected="True">BILLING PARTY</asp:ListItem>
                                                                <asp:ListItem>CUSTOMER</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_CustomerName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_CustomerName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustomerName FirstNoSpaceAndZero"
                                                                TabIndex="3"></asp:TextBox> <%--onkeypress="return checkNumAlpha()"--%>
                                                        </div>
                                                         <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_CustCode" runat="server" CssClass="label labelColor">CUSTOMER CODE</asp:Label>
                                                            <asp:TextBox ID="Txt_CustCode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustCode FirstNoSpaceAndZero"
                                                                TabIndex="3"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_ContactNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_ContactNo" runat="server" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_ContactNo" MaxLength="10" placeholder="+91" onkeypress="return validateNumericValue(event)" TabIndex="4" TextMode="Phone"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_CustEmailId" runat="server" CssClass="label labelColor">EMAIL ID</asp:Label><%--<span class="required">*</span>--%>
                                                            <asp:TextBox ID="Txt_CustEmailId" runat="server" CssClass="form-control input-sm Txt_CustEmailId" onkeypress="return checkEmailId()" TabIndex="5" TextMode="Email"></asp:TextBox>
                                                        </div>
                                                        <div id="billingparty" runat="server" class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <asp:Label ID="Lbl_BillingParty" runat="server" CssClass="label labelColor">BILLING PARTY</asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_billingParty" runat="server" NavigateUrl="~/Report.aspx?Type=BillingParty" Target="_blank">List</asp:HyperLink>
                                                            <asp:TextBox ID="Txt_BillingParty" runat="server" CssClass="form-control input-sm Txt_BillingParty" Style="text-transform: uppercase;" onkeypress="return checkNumAlpha()" TabIndex="6" onchange="ReadDataonchange('Txt_BillingParty','hfBillingParty','','Party_CustomerCreation.aspx/getBillingParty');"></asp:TextBox>
                                                            <asp:HiddenField ID="hfBillingParty" runat="server" />
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_ModeOfPayment" runat="server" CssClass="label labelColor">MODE OF PAYMENT</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_ModeOfPayment" runat="server" CssClass="formDisplay Ddl_ModeOfPayment" TabIndex="10">
                                                                <asp:ListItem>CREDIT</asp:ListItem>
                                                                <asp:ListItem>TOPAY</asp:ListItem>
                                                                <asp:ListItem>PAID</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_CustCategory" runat="server" CssClass="label labelColor">CATEGORY</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_CustCategory" runat="server" CssClass="formDisplay Ddl_CustCategory" TabIndex="12">
                                                                <asp:ListItem>INDIVIDUAL</asp:ListItem>
                                                                <asp:ListItem Selected="True">FIRM/COMPANY</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_CreditLimit" runat="server" CssClass="label labelColor">CUSTOMER CREDIT LIMIT</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_CreditLimit" runat="server" CssClass="form-control input-sm Txt_CreditLimit" onkeypress="return validateNumericValue(event)" TabIndex="13"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="row">

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-4 ">
                                                            <asp:Label ID="Lbl_AutoUility" runat="server" CssClass="label labelColor"> AUTO UTILITY :- </asp:Label>
                                                            <asp:CheckBox ID="CheckBox_AutoUtility1" Text="MAILING" runat="server" TabIndex="14" CssClass="label labelColor" />
                                                            <asp:CheckBox ID="CheckBox_AutoUtility2" Text="SMS" runat="server" TabIndex="15" CssClass="label labelColor" />
                                                            <asp:CheckBox ID="CheckBox_AutoUtility3" Text="PDF_MAILING" runat="server" TabIndex="16" CssClass="label labelColor" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Ddl_TypeofParty" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                            <ContentTemplate>
                                                <!---Buttons --->
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class=" col-sm-3 col-md-3 col-lg-4  "></div>

                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="hfButtonTab1Save" runat="server" ClientIDMode="Static" Value="0" />
                                                            <asp:LinkButton ID="Button_Tab1Save" runat="server" CssClass="btn btn-info Button_Tab1Save largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateCustomerDetails()) {return false;};" OnClick="Button_Tab1Save_Click" TabIndex="17">SAVE&nbsp;<i class="fa fa-save "></i></asp:LinkButton>
                                                        </div>
                                                        <%--<input type="text" onselect=""/>--%>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_CustomerReset" runat="server" Value="" />
                                                            <asp:LinkButton ID="Btn_CustomerReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="CustomerReset()" OnClick="Btn_CustomerReset_Click" TabIndex="19">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_CustomerNext" runat="server" CssClass="btn btn-info next-step largeButtonStyle" TabIndex="18">NEXT&nbsp;<i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                            <%--<button type="button" class="btn btn-info next-step smallButtonStyle1">Next <i class="fa fa-arrow-circle-right"></i></button>--%>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!---Buttons End--->
                                        <div class="panel-heading panelHead">
                                            <b>ADDRESS DETAILS</b>
                                        </div>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <asp:HiddenField ID="AutoIncrementNo" runat="server" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_Pincode" runat="server" CssClass="label labelColor">PINCODE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_Pincode" runat="server" CssClass="form-control input-sm Txt_Pincode" MaxLength="6" TabIndex="6" onchange="ReadDataonchange('Txt_Pincode','hfPincode','Ddl_Area','Party_CustomerCreation.aspx/getPincode');"></asp:TextBox>
                                                            <asp:HiddenField ID="hfPincode" runat="server" />
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                            <asp:TextBox ID="Txt_State" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_State" Text="Auto" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                                            <asp:TextBox ID="Txt_District" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_District" Text="Auto" ReadOnly="true"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">PICKUP CITY</asp:Label>
                                                            <asp:TextBox ID="Txt_City" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_City" Text="Auto" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <asp:Label ID="Lbl_Area" runat="server" CssClass="label labelColor">AREA</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_Area" runat="server" CssClass="formDisplay input-sm Ddl_Area" TabIndex="7">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hfArea" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:Label ID="Lbl_BillingAddress" runat="server" CssClass="label labelColor">ADDRESS</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_BillingAddress" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_BillingAddress FirstNoSpaceAndZero" TextMode="MultiLine" TabIndex="9"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <asp:Label ID="Label2" runat="server" CssClass="label labelColor">GST NO</asp:Label>
                                                            <asp:TextBox ID="txtGSTNo" runat="server" CssClass="form-control input-sm txtGSTNo" TabIndex="25"></asp:TextBox>
                                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <asp:Label ID="Label1" runat="server" CssClass="label labelColor">BELONG TO BRANCH</asp:Label>
                                                            <asp:TextBox ID="Txt_BelongToBranch" runat="server" CssClass="form-control input-sm Txt_BelongToBranch" ReadOnly="true" Text="AUTO" TabIndex="25"></asp:TextBox>
                                                            <asp:HiddenField ID="hfbranchID" runat="server" />
                                                        </div>

                                                        <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                            <div class="form-control-lg"></div>
                                                            <div class="form-control-lg"></div>
                                                            <asp:HiddenField ID="hfAddCustomerBranch" runat="server" ClientIDMode="Static" Value="0" />
                                                            <asp:LinkButton ID="Btn_AddCustomerBranch" runat="server" CssClass="btn btn-info buttonStyle2 Btn_AddCustomerBranch" UseSubmitBehavior="false" OnClientClick="if (!valAddCustomerDetails()) {return false;};" OnClick="Btn_AddCustomerBranch_Click">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="row" id="branchDiv" runat="server">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 "></div>
                                                        <asp:GridView ID="Gv_BelongToBranch" runat="server" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                            <Columns>                                                             
                                                                <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Left"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="locID" HeaderStyle-CssClass="hidden gvHeaderStyle" ItemStyle-CssClass="hidden gvItemStyle" />
                                                                <asp:BoundField DataField="Pincode" HeaderText="PINCODE" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="State" HeaderText="STATE" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="District" HeaderText="DISTRICT" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="city" HeaderText="CITY" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="Area" HeaderText="AREA" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="AreaID" HeaderStyle-CssClass="hidden gvHeaderStyle" ItemStyle-CssClass="hidden gvItemStyle" />
                                                                <asp:BoundField DataField="Address" HeaderText="ADDRESS" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="GSTNumber" HeaderText="GST Number" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="BelongToBranchID" HeaderStyle-CssClass="hidden gvHeaderStyle" ItemStyle-CssClass="hidden gvItemStyle" />
                                                                <asp:BoundField DataField="BelongToBranch" HeaderText="BELONG TO BRANCH" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle"/>
                                                                <asp:BoundField DataField="custBelongToBranchID" HeaderStyle-CssClass="hidden gvHeaderStyle" ItemStyle-CssClass="hidden gvItemStyle" />
                                                              <%--    <asp:TemplateField>
                                                                    <ItemTemplate>  
                                                                          <asp:HiddenField ID="hfBelongToBranch" runat="server" Value='<%# Eval("locID") %>'/>                                                                 
                                                                         <asp:LinkButton ID="btn_Delete" runat="server" ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Record?');"><i class="fa fa-trash" style="font-size:18px; color:red" ></i></asp:LinkButton>       <%-- OnClientClick="return confirm('Are you sure you want to delete this Row?');"     -%>                                                                
                                                                    </ItemTemplate>
                                                                      <ItemStyle HorizontalAlign="Center" />                                                               
                                                                </asp:TemplateField>--%>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Btn_CustomerReset" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Btn_CustomerNext" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--==============================================End Customer Information=======================================================================-->

                <!--==============================================Logistic Person Information=======================================================================-->
                <div id="OtherPerson_Tab" class="tab-pane">
                    <div id="OtherPerson" runat="server">
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>SALES PERSON DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_SalesPerson" runat="server">
                                            <ContentTemplate>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <asp:HiddenField ID="hfGetCustID" runat="server" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_LinkButton_Search_SalesPerson" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField_Txt_Search_SalesPerson" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_SalesPerson" runat="server" CssClass="label labelColor">SALES PERSON</asp:Label><span class="required">*</span>
                                                            <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <%-- NOT EDITABLE TEXTBOX AND DISPLAY SELECTED VALUE --%>
                                                            <asp:TextBox ID="Txt_SalesPerson" runat="server" Style="background-color: white; text-transform: uppercase;" ReadOnly="true" TabIndex="19" AutoCompleteType="Disabled" placeholder="SELECT NAME" CssClass="form-control input-sm Txt_SalesPerson"></asp:TextBox>
                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SalesPerson" runat="server" Enabled="true" TargetControlID="Txt_SalesPerson" PopupControlID="Panel_SalesPerson" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>
                                                            <asp:Panel ID="Panel_SalesPerson" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto" BackColor="#ffffff" Style="display: none;">
                                                                <div runat="server" class="ddlSearchTextBox" style="position: inherit;">
                                                                    <%-- SUBMIT BUTTON --%>
                                                                    <asp:LinkButton ID="LinkButton_Search_SalesPerson" runat="server" OnClientClick="LinkButton_Search_SalesPerson()" ToolTip="Submit" TabIndex="20" OnClick="LinkButton_Search_SalesPerson_Click"><img src="images/submit.png" style="height:20px;" class="searchSubmitButtonMultiDropDown" /></asp:LinkButton>
                                                                    <%-- SEARCH BOX --%>
                                                                    <asp:TextBox ID="Txt_Search_SalesPerson" runat="server" Style="text-transform: uppercase;" TabIndex="21" placeholder="SEARCH" CssClass="form-control input-sm FirstNoSpaceAndZero txtSearchMultiDropDown"
                                                                        AutoCompleteType="Disabled" AutoPostBack="true" onchange="Txt_Search_SalesPerson()" onkeypress="return onlyAlphaValue()" OnTextChanged="Txt_Search_SalesPerson_TextChanged"></asp:TextBox>
                                                                </div>
                                                                <%--  OnTextChanged="TextBox2_TextChanged" --%>
                                                                <div runat="server" class="ddlDropDownList">
                                                                    <%-- DISPLAY VALUE FROM DATABASE --%>
                                                                    <asp:CheckBoxList ID="CheckBoxList_SalesPerson" Style="font-size: 11px; color: black" runat="server">
                                                                    </asp:CheckBoxList>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="LinkButton_Search_SalesPerson" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Txt_Search_SalesPerson" EventName="TextChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-heading panelHead">
                                <b>OTHER PERSON DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_OtherPerson" runat="server">
                                            <ContentTemplate>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_PersonDesignation" runat="server" CssClass="label labelColor">DESIGNATION</asp:Label>
                                                            <asp:DropDownList ID="Ddl_PersonDesignation" runat="server" CssClass="formDisplay Ddl_PersonDesignation" TabIndex="22">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>LOGISTIC</asp:ListItem>
                                                                <asp:ListItem>FINANCE</asp:ListItem>
                                                                <asp:ListItem>DIRECTOR</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_OtherPersonName" runat="server" CssClass="label labelColor">NAME</asp:Label>
                                                            <asp:TextBox ID="Txt_OtherPersonName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_OtherPersonName FirstNoSpaceAndZero" onkeypress="return checkNumAlpha(event)" TabIndex="23"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_OtherContactNo" runat="server" CssClass="label labelColor"> CONTACT NO </asp:Label>
                                                            <asp:TextBox ID="Txt_OtherContactNo" runat="server" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_OtherContactNo" MaxLength="10" placeholder="+91" onkeypress="return validateNumericValue(event)" TabIndex="24"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_OtherPersonEmailId" runat="server" CssClass="label labelColor">EMAIL ID</asp:Label>
                                                            <asp:TextBox ID="Txt_OtherPersonEmailId" runat="server" CssClass="form-control input-sm Txt_OtherPersonEmailId" onkeypress="return checkEmailId()" TabIndex="25"></asp:TextBox>
                                                        </div>

                                                        <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                            <div class="form-control-lg"></div>
                                                            <div class="form-control-lg"></div>
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_OtherPersonAdd" runat="server" CssClass="btn btn-info buttonStyle2 Btn_OtherPersonAdd" UseSubmitBehavior="false" OnClientClick="if (!OtherPersonDetails()) {return false;};" TabIndex="26" OnClick="Btn_OtherPersonAdd_Click">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="row" id="GridviewOtherDiv" runat="server">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <asp:GridView ID="DataTableGridView" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="ACTION">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="Delete_Data1" runat="server" OnClick="Delete_Data1_Click" CommandArgument='<%# Eval("Name")%>' ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Row?');"><i class="fa fa-trash" style="font-size:18px; color:red"></i></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Left"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="CustomerId" HeaderText="CUSTOMER ID" HeaderStyle-CssClass="hidden gvHeaderStyle" ItemStyle-CssClass="hidden gvItemStyle" />
                                                                <%--HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"--%>
                                                                <asp:BoundField DataField="Designation" HeaderText="DESIGNATION" />
                                                                <asp:BoundField DataField="Name" HeaderText="NAME" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle" />
                                                                <asp:BoundField DataField="ContactNo" HeaderText="CONTACT NO" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle" />
                                                                <asp:BoundField DataField="EmailID" HeaderText="EMAIL ID" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-CssClass="gvHeaderStyle" ItemStyle-CssClass="gvItemStyle" />

                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>

                                                <!---Buttons --->

                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-sm-1 col-md-2 col-lg-3 "></div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_OtherPrev" runat="server" CssClass="btn btn-info  prev-step largeButtonStyle" TabIndex="27"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                            <%--<button type="button" class="btn btn-info  prev-step largeButtonStyle"><i class="fa fa-arrow-circle-left"></i>PREV</button>--%>
                                                        </div>

                                                        <div class=" col-sm-2 col-md-2 col-lg-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Tab2Save" runat="server" Value="" />
                                                            <asp:LinkButton ID="Button_Tab2Save" runat="server" CssClass="btn btn-info largeButtonStyle Button_Tab2Save" UseSubmitBehavior="false" OnClientClick="if (!SalesPersonDetails()) {return false;};" OnClick="Button_Tab2Save_Click" TabIndex="28">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_OtherReset" runat="server" Value="" />
                                                            <asp:LinkButton ID="Btn_OtherReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="OtherReset()" OnClick="Btn_OtherReset_Click" TabIndex="29">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_OtherNext" runat="server" CssClass="btn btn-info next-step largeButtonStyle" TabIndex="30">NEXT&nbsp;<i class="fa fa-arrow-circle-right"></i></asp:LinkButton>

                                                        </div>
                                                    </div>
                                                </div>
                                                <!---Buttons End--->

                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Btn_OtherPrev" />
                                                <asp:AsyncPostBackTrigger ControlID="Button_Tab2Save" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Btn_OtherReset" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Btn_OtherNext" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--==============================================End logistic Person Information=======================================================================-->
                <!--================================================Upload Documents Details============================================================================-->
                <div id="UploadDoc" class="tab-pane">

                    <div class="panel panelTop">

                        <div>

                            <asp:UpdatePanel ID="UpdatePanel_Upload_Document" runat="server">
                                <ContentTemplate>

                                    <!--=================================Customer Documents==============================================-->
                                    <div class="panel-heading panelHead">
                                        <b>CUSTOMER DOCUMENTS</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PanCardNo" runat="server" CssClass="label labelColor"> PANCARD NO</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_PanCardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PanCardNo" MaxLength="10" onkeypress="return checkAlphaNumeric()" TabIndex="31"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Cust_PanCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Cust_PanCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="Btn_Upload" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validatePanDocumentsDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Cust_PanCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Cust_PanCard_Uploader_UploadComplete" TabIndex="32" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--%--<asp:Label ID="Cust_PanCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Cust_PanCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>

                                                <%-- <div class="row">
                                <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                </div>
                                 <div class="row">
                                <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                </div>--%>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_AdharcardNo" runat="server" CssClass="label labelColor"> AADHARCARD NO</asp:Label>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_AdharcardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_AdharcardNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="33"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Cust_AadhaarCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Cust_AadhaarCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton1" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateAadharDocumentsDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Cust_AadhaarCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete2" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Cust_AadhaarCard_Uploader_UploadComplete" TabIndex="34" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Cust_AadhaarCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Cust_AadhaarCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>

                                                <%--  <div class="row">
                                <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                </div>
                                 <div class="row">
                                <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                </div>--%>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustomerGSTCertificates" runat="server" CssClass="label labelColor">GST CERTIFICATE</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_CustomerGSTCertificates" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustomerGSTCertificates" onkeypress="return checkAlphaNumeric()" MaxLength="15" TabIndex="35"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Cust_GST_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Cust_GST_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton2" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateGSTDocumentsDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Cust_GST_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete3" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Cust_GST_Uploader_UploadComplete" TabIndex="36" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Cust_GST_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Cust_GST_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>
                                                <%-- <div class="row">
                                <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                </div>
                                 <div class="row">
                                <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                </div>--%>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustomerCIN" runat="server" CssClass="label labelColor">CIN</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_CustomerCIN" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustomerCIN" onkeypress="return checkAlphaNumeric()" MaxLength="21" TabIndex="37"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Cust_CIN_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Cust_CIN_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton3" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateCINDocumentsDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Cust_CIN_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete4" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Cust_CIN_Uploader_UploadComplete" TabIndex="38" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Cust_CIN_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Cust_CIN_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>


                                            </div>

                                        </div>
                                    </div>
                                    <!--=====================================End Customer Documents==============================================-->
                                    <!--=====================================Logistic Person Documents==============================================-->

                                    <div class="panel-heading panelHead">
                                        <b>OTHER PERSON DOCUMENTS</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>
                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_UploadDesignation" runat="server" CssClass="label labelColor">DESIGNATION</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:DropDownList ID="Ddl_UploadDesignation" runat="server" CssClass="formDisplay Ddl_UploadDesignation" TabIndex="39">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>LOGISTIC</asp:ListItem>
                                                            <asp:ListItem>FINANCE</asp:ListItem>
                                                            <asp:ListItem>DIRECTOR</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OtherPanCardNo" runat="server" CssClass="label labelColor">PANCARD NO</asp:Label>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_OtherPanCardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_OtherPanCardNo" MaxLength="10" onkeypress="return checkAlphaNumeric()" TabIndex="40"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Logistic_PanCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Logistic_PanCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton4" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validatelogPersonPanDocumentsDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Logistic_PanCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete5" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Logistic_PanCard_Uploader_UploadComplete" TabIndex="41" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Logistic_PanCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Logistic_PanCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>



                                                <div class="row">
                                                    <div class="col-sm-0 col-md-0 col-lg-1 "></div>

                                                    <div class="col-xs-2 col-sm-4 col-md-3 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_OtherAdharcardNo" runat="server" CssClass="label labelColor">AADHARCARD NO</asp:Label>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:TextBox ID="Txt_OtherAdharcardNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_OtherAdharcardNo" MaxLength="12" onkeypress="return validateNumericValue(event)" TabIndex="42"></asp:TextBox>

                                                    </div>
                                                    <div class="col-xs-2 col-sm-4 col-md-4 col-lg-4 col-xl-4">
                                                        <div class="form-control-sm"></div>

                                                        <%--<CuteWebUI:Uploader ID="Logistic_AadhaarCard_Uploader" runat="server" InsertText="UPLOAD" OnFileUploaded="Logistic_AadhaarCard_Uploader_FileUploaded"></CuteWebUI:Uploader>--%>
                                                        <%--<asp:LinkButton CssClass="btn btn-info Btn_Upload" ID="LinkButton5" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateCustomerDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="19">Upload  <i class="fa fa-upload"></i></asp:LinkButton>--%>

                                                        <ajaxToolkit:AjaxFileUpload ID="Logistic_AadhaarCard_Uploader" runat="server" Mode="Auto" OnClientUploadError="uploaderror"
                                                            OnClientUploadComplete="uploadcomplete6" MaximumNumberOfFiles="1" ClearFileListAfterUpload="true" AllowedFileTypes="png,jpg,jpeg"
                                                            OnUploadComplete="Logistic_AadhaarCard_Uploader_UploadComplete" TabIndex="43" />

                                                    </div>

                                                    <div class="col-xs-5 col-sm-5 col-md-4 col-lg-2 col-xl-1 ">
                                                        <div class="form-control-sm"></div>
                                                        <%--<asp:Label ID="Logistic_AadhaarCard_Label" runat="server" Style="text-transform: uppercase;"></asp:Label>--%>
                                                        <a id="Logistic_AadhaarCard_Label" runat="server" target="_blank"></a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--=====================================Logistic Person Documents==============================================-->

                                    <div class="form-group">
                                        <div class="row">

                                            <div class=" col-sm-3 col-md-3 col-lg-4  "></div>

                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_DocumentPrev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="44"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                <%--<button type="button" class="btn btn-info  prev-step largeButtonStyle"><i class="fa fa-arrow-circle-left"></i>PREV</button>--%>
                                            </div>
                                            <div class=" col-sm-2 col-md-3 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_Submit1" runat="server" Value="" />
                                                <asp:LinkButton ID="Button_Submit1" runat="server" Class="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateDocumentsDetails()) {return false;} ;" OnClick="Button_Submit1_Click" TabIndex="45">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>


                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_DocumenReset" runat="server" Value="" />

                                                <asp:LinkButton ID="Btn_DocumenReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="DocumenReset()" OnClick="Btn_DocumenReset_Click" TabIndex="46">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                            </div>
                                            <%--<div class=" col-sm-2 col-md-2 col-lg-1">
                                <div class="form-control-sm"></div>
                                 <button type="button" class="btn btn-info next-step smallButtonStyle">Next <i class="fa fa-arrow-circle-right"></i></button>
                            </div>--%>
                                        </div>
                                    </div>

                                </ContentTemplate>
                                <Triggers>

                                    <asp:AsyncPostBackTrigger ControlID="Btn_DocumentPrev" />
                                    <%--<asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click"/>--%>
                                    <asp:PostBackTrigger ControlID="Button_Submit1" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_DocumenReset" EventName="Click" />

                                </Triggers>
                            </asp:UpdatePanel>
                        </div>

                    </div>
                </div>
                <!--================================================End Upload Documents Details============================================================================-->
                <!--==============================================View Details=======================================================================-->
                <div id="View_Tab" class="tab-pane">

                    <div>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>

                                <div class="panel panelTop">
                                    <div class="panel-heading panelView">

                                        <div class="form-horizontal" role="form">
                                            <div>
                                                <asp:UpdatePanel ID="UpdatePanel_View_Search" runat="server">
                                                    <ContentTemplate>

                                                        <div class="form-group">
                                                            <div class="row">
                                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:Label ID="Lbl_SearchCustName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label>
                                                                    <asp:TextBox ID="Txt_SearchCustName" runat="server" CssClass="form-control input-sm" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="47"></asp:TextBox>
                                                                    <%--  <asp:DropDownList ID="Ddl_SearchCustName" runat="server" CssClass="formDisplay" TabIndex="94">                                                                      
                                                                    </asp:DropDownList>--%>
                                                                </div>
                                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:Label ID="Lbl_SearchSalesPersonName" runat="server" CssClass="label labelColor">SALES PERSON NAME</asp:Label>
                                                                    <asp:DropDownList ID="Ddl_SearchSalesPersonName" runat="server" CssClass="formDisplay" TabIndex="48">
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:Label ID="Lbl_SearchableStatus" runat="server" CssClass="label labelColor">STATUS</asp:Label>
                                                                    <asp:DropDownList ID="Ddl_SearchableStatus" runat="server" CssClass="formDisplay" TabIndex="49">
                                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                                        <asp:ListItem>ACTIVE</asp:ListItem>
                                                                        <asp:ListItem>INACTIVE</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                    <div class="form-control-lg"></div>
                                                                    <div class="form-control-lg"></div>
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle" Text="SEARCH" OnClick="Btn_Search_Click" TabIndex="50">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
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
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_Grid_View" runat="server">
                                            <ContentTemplate>
                                                <div class="panel-body" id="ViewData" runat="server" visible="false">
                                                    <div class="form-horizontal" role="form">
                                                        <div class="form-group">
                                                            <div>
                                                                <div>
                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:GridView ID="GV_CustomerView" runat="server" DataKeyNames="customerID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="GV_CustomerView_Sorting" AllowPaging="true" PageSize="10" OnPageIndexChanging="GV_CustomerView_PageIndexChanging" PagerSettings-Mode="NumericFirstLast" EnableViewState="true">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Action">
                                                                                        <ItemTemplate>
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td>                                                                                                     
                                                                                                        <ul class="list-inline pull-right">
                                                                                                            <li>                                                                                                               
                                                                                                                <asp:HiddenField ID="HiddenField_Edit_CustomerData" runat="server" Value="" />
                                                                                                                <asp:LinkButton ID="Edit_CustomerData" runat="server" CommandArgument='<%#Eval("customerID") %>' ToolTip="Edit" OnClientClick="Edit_CustomerData()" OnClick="Edit_CustomerData_Click"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton> 
                                                                                                            </li>
                                                                                                        </ul>                   
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                                        <ItemStyle />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="SR.NO">
                                                                                        <ItemTemplate>
                                                                                            <%#Container.DataItemIndex+1 %>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="customerID" HeaderText="CUSTOMER ID" SortExpression="customerID">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerNo" HeaderText="CUSTOMER CODE" SortExpression="customerNo">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerName" HeaderText="CUSTOMER NAME" SortExpression="customerName">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerType" HeaderText="CUSTOMER TYPE" SortExpression="customerType">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerCategory" HeaderText="CUSTOMER CATEGORY" SortExpression="customerCategory">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerContactNo" HeaderText="CONTACT NO" SortExpression="customerContactNo">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="EmailId" HeaderText="EMAIL ID" SortExpression="EmailId">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="locPincode" HeaderText="PICKUP PINCODE" SortExpression="locPincode">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="areaName" HeaderText="AREA" SortExpression="areaName">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="billingParty" HeaderText="BILLING PARTY" SortExpression="billingParty">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="billingAddress" HeaderText="BILLING ADDRESS" SortExpression="billingAddress">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="modeOfPayment" HeaderText="MODE OF PAYMENT" SortExpression="modeOfPayment">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="salesPerson" HeaderText="SALES PERSON" SortExpression="salesPerson">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="status" HeaderText="STATUS" SortExpression="status">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="username" HeaderText="USER NAME" SortExpression="username">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                                    </asp:BoundField>

                                                                                </Columns>


                                                                                <HeaderStyle HorizontalAlign="Center" />

                                                                            </asp:GridView>


                                                                            <asp:GridView ID="GV_Export" runat="server" DataKeyNames="customerNo" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">

                                                                                <Columns>
                                                                                    <asp:BoundField DataField="customerNo" HeaderText="CUSTOMER CODE">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerType" HeaderText="CUSTOMER TYPE">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerCategory" HeaderText="CUSTOMER CATEGORY">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerName" HeaderText="CONSIGNOR NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerContactNo" HeaderText="CONTACT NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>

                                                                                    <asp:BoundField DataField="EmailId" HeaderText="EMAIL ID">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>

                                                                                    <asp:BoundField DataField="customerPickupPincode" HeaderText="PICKUP PINCODE">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="state" HeaderText="STATE">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="district" HeaderText="DISTRICT">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="taluka" HeaderText="TALUKA">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="city" HeaderText="CITY">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="area" HeaderText="AREA">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="billingParty" HeaderText="BILLING PARTY">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="billingAddress" HeaderText="BILLING ADDRESS">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="modeOfPayment" HeaderText="MODE OF PAYMENT">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="branchName" HeaderText="BRANCH NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="category" HeaderText="CATEGORY">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="status" HeaderText="STATUS">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerCreditLimit" HeaderText="CUSTOMER CREDIT LIMIT">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="autoUtility" HeaderText="AUTO UTILITY">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>

                                                                                    <asp:BoundField DataField="salesPersonName" HeaderText="SALES PERSON NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="salesPersonContactNo" HeaderText="SALES PERSON CONTACTNO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="salesPersonEmailID" HeaderText="SALES PERSON EMAILID">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="salesPersonTerriorityWork" HeaderText="SALES PERSON TERRIORITYWORK">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonName" HeaderText="LOGISTIC PERSON NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonContactNo" HeaderText="LOGISTIC PERSON CONTACTNO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonEmailID" HeaderText="LOGISTIC PERSON EMAILID">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonName" HeaderText="FINANCE PERSON NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonContactNo" HeaderText="FINANCE PERSON CONTACTNO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonEmailID" HeaderText="FINANCE PERSON EMAILID">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonName" HeaderText="DIRECTOR PERSON NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonContactNo" HeaderText="DIRECTOR PERSON CONTACTNO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonEmailId" HeaderText="DIRECTOR PERSON EMAILID">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>

                                                                                    <asp:BoundField DataField="panCardNo" HeaderText="CUSTOMER PANCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="aadharCardNo" HeaderText="CUSTOMER AADHARCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="GSTCertificateNo" HeaderText="CUSTOMER GSTCERTIFICATE NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="CIN" HeaderText="CUSTOMER CIN">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonPancardNo" HeaderText="LOGISTIC PERSON PANCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonAadharcardNo" HeaderText="LOGISTIC PERSON AADHARCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonPancardNo" HeaderText="FINANCE PERSON PANCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonAadharcardNo" HeaderText="FINANCE PERSON AADHARCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonPancardNo" HeaderText="DIRECTOR PERSON PANCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonAadharcardNo" HeaderText="DIRECTOR PERSON AADHARCARD NO">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>

                                                                                    <asp:BoundField DataField="customerPancardFileName" HeaderText="CUSTOMER PANCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="customerAadharCardFileName" HeaderText="CUSTOMER AADHARCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="GSTCertificateFileName" HeaderText="CUSTOMER GSTCERTIFICATE FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="CINFileName" HeaderText="CUSTOMER CIN FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonPancardFileName" HeaderText="LOGISTIC PERSON PANCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="logisticPersonAadharcardFileName" HeaderText="LOGISTIC PERSON AADHARCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonPancardFileName" HeaderText="FINANCE PERSON PANCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="financePersonAadharcardFileName" HeaderText="FINANCE PERSON AADHARCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonPancardFileName" HeaderText="DIRECTOR PERSON PANCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="directorPersonAadharcardFileName" HeaderText="DIRECTOR PERSON AADHARCARD FILENAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <%-- <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE NO" >
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                        </asp:BoundField>--%>
                                                                                    <asp:BoundField DataField="username" HeaderText="USER NAME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME">
                                                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header" />
                                                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                                                    </asp:BoundField>

                                                                                </Columns>


                                                                                <HeaderStyle HorizontalAlign="Center" />

                                                                            </asp:GridView>
                                                                        </ContentTemplate>
                                                                        <Triggers>

                                                                            <%--<asp:PostBackTrigger ControlID="Edit_CustomerData" />--%>
                                                                            <%--<asp:PostBackTrigger ControlID="GV_CustomerView"/>--%>
                                                                        </Triggers>
                                                                    </asp:UpdatePanel>

                                                                </div>

                                                            </div>

                                                        </div>

                                                    </div>

                                                    <div id="printPage">
                                                        <div class="form-group">

                                                            <div class="row">
                                                                <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                                <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                                    <asp:ImageButton ID="btn_ExporttoExcel" runat="server" CssClass="btn" Text="EXPORT TO EXCEL" TabIndex="96" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton><%--OnClick="btn_ExporttoExcel_Click"--%>
                                                                </div>

                                                                <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                                    <asp:ImageButton ID="Btn_Printbtn" runat="server" CssClass="fa fa-print" Text="PRINT" TabIndex="97" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </ContentTemplate>
                                            <Triggers>
                                                <%--<asp:AsyncPostBackTrigger ControlID="btn_ExporttoExcel" EventName="Click"/>--%>
                                                <asp:PostBackTrigger ControlID="btn_ExporttoExcel" />
                                                <%--<asp:PostBackTrigger ControlID="Btn_GV_Demo"/>--%>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>

                                </div>


                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />

                                <%--<asp:AsyncPostBackTrigger ControlID="GV_CustomerView" EventName="PageIndexChanging"/>--%>

                                <%---redirect to first page---%>
                                <%--<asp:PostBackTrigger ControlID="GV_CustomerView" />--%>


                                <%--<asp:PostBackTrigger ControlID="Edit_CustomerData" />--%>
                                <%--<asp:AsyncPostBackTrigger ControlID="Edit_CustomerData" EventName="Click"/>--%>
                                <%--<asp:PostBackTrigger ControlID="Btn_Search"/>--%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
                <!--==============================================End View=======================================================================-->

            </div>
        </div>
    </div>



    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->


    <script src="Validation/Val_Party_CustomerCreation.js?1"></script>

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
            var LinkBtn = document.getElementById("<%=Cust_PanCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete2(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Cust_AadhaarCard_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete3(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Cust_GST_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            window.open('FileUpload/' + Imagename);
        }

        function uploadcomplete4(sender, args) {
            var Imagename = args.get_fileName();
            alert(Imagename);
            var LinkBtn = document.getElementById("<%=Cust_CIN_Label.ClientID%>");
            LinkBtn.innerHTML = Imagename;
            LinkBtn.setAttribute('href', 'FileUpload/' + Imagename);
            window.open('FileUpload/' + Imagename);
        }



        //Logistic Person Documents


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




    </script>


    <%--  <script>
  $('.custom-button').on('click', function (evt) {
    $('.target-tab-link').triggerHandler('click');
    evt.preventDefault();
  });
</script>--%>

    <%-- <script>

        /* Check Numbers Only*/
        $('.FirstNoSpaceAndZero').keypress(function (e) {
            if (this.value.length == 0 && e.which == 48) {
                return false;
            }
        });
    </script>

    <script>
         function validate() {

            var txtvalue = document.getElementById('<%=Txt_CreditLimit.ClientID %>').value;

            if (txtvalue.charAt(0) == 0) {

                alert("0 shold not be first character");

                return false;

            }

        }
    </script>--%>

    <script>
        function ShowProgress() {
            document.getElementById('<% Response.Write(UpdateProgress_Upload_Document.ClientID); %>').style.display = "inline";
        }

    </script>

    <%--<script>
        function myFunction(x) {
            //$(document).ready(function () {
            //    $(".focusArea").focus(function () {
            //        $("#Span").css("display", "inline").fadeOut(2000);
            //    });
            //});
            //}

            var x = document.getElementById('AlertNotification');
            x.className = "show";
            x.innerText = "Select Piccode First ..!!!!"
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 2000);
        }
    </script>--%>

    <script>
        //$('.SwitchEnterwithTab').keypress(function (e) {
        //    if (e.keyCode === 13) {
        //        MessageBox.Show("You pressed Tab");
        //    }
        //});

        //var nav = window.Event ? true : false;
        //if (nav) {
        //    window.captureEvents(Event.KEYDOWN);
        //    window.onkeydown = NetscapeEventHandler_KeyDown;
        //} else {
        //    document.onkeydown = MicrosoftEventHandler_KeyDown;
        //}

        //function NetscapeEventHandler_KeyDown(e) {
        //    if (e.which == 13 && e.target.type != 'textarea' && e.target.type != 'submit') {
        //        return false;
        //        //this.focus();
        //        //e.keyCode == 9;
        //    }
        //    return true;
        //}

        //function MicrosoftEventHandler_KeyDown() {
        //    if (event.keyCode == 13 && event.srcElement.type != 'textarea' &&
        //    event.srcElement.type != 'submit')
        //        return false;
        //    return true;
        //}


        function disableSubmitOnEnter(e) {
            var key;
            if (window.event)
                key = window.event.keyCode; //IE
            else
                key = e.which; //firefox      

            if (e.which == 13) {
                return (key == 9);
            }
            //return (key != 13);
            //return (key ==9);
        }

    </script>


    <script type="text/javascript">
        function onPopupLostFocus() {
            var be = $find('popupBehavior1');
            if (be != null && be != 'undefined') {
                if (be.get_visible()) {
                    be.hide();
                }
            }
        }
    </script>
    <%--  <script type="text/javascript" >
    function onPopupLostFocus() {
        var be = $find('popupBehavior1');
        if (be != null && be != 'undefined') {
            if (be.get_visible()) {
                be.hide();
            }
        }
    }
</script>--%>

    <script>
        $('.custom-button').on('click', function (evt) {
            $('.target-tab-link').triggerHandler('click');
            evt.preventDefault();
        });

        function Ddl_TypeofParty() {
            $('[id*=HiddenField_Ddl_TypeofParty]').val("1");
            console.log($('[id*=HiddenField_Ddl_TypeofParty]').val());
        }
        function Ddl_Categoryofcustomer() {
            $('[id*=HiddenField_Ddl_Categoryofcustomer]').val("1");
            console.log($('[id*=HiddenField_Ddl_Categoryofcustomer]').val());
        }
        function LinkButton_Search_SalesPerson() {
            $('[id*=HiddenField_LinkButton_Search_SalesPerson]').val("1");
            console.log($('[id*=HiddenField_LinkButton_Search_SalesPerson]').val());
        }
        function Txt_Search_SalesPerson() {
            $('[id*=HiddenField_Txt_Search_SalesPerson]').val("1");
            console.log($('[id*=HiddenField_Txt_Search_SalesPerson]').val());
        }



        function Tab1Save() {
            $('[id*=HiddenField_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Tab1Save]').val());
        }

        function CustomerReset() {
            $('[id*=HiddenField_CustomerReset]').val("1");
            console.log($('[id*=HiddenField_CustomerReset]').val());
        }



        function Tab2Save() {
            $('[id*=HiddenField_Tab2Save]').val("1");
            console.log($('[id*=HiddenField_Tab2Save]').val());
        }

        function Submit1() {
            $('[id*=HiddenField_Submit1]').val("1");
            console.log($('[id*=HiddenField_Submit1]').val());
        }

        function DocumenReset() {
            $('[id*=HiddenField_DocumenReset]').val("1");
            console.log($('[id*=HiddenField_DocumenReset]').val());
        }

        function Txt_SearchBranchName_Search() {
            $('[id*=HiddenField_Txt_SearchBranchName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchBranchName_Search]').val());
        }

        function RadioButtonList_SearchBranchName() {
            $('[id*=HiddenField_RadioButtonList_SearchBranchName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchBranchName]').val());
        }

        function Txt_SearchCustomerName_Search() {
            $('[id*=HiddenField_Txt_SearchCustomerName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchCustomerName_Search]').val());
        }

        function RadioButtonList_SearchCustomerName() {
            $('[id*=HiddenField_RadioButtonList_SearchCustomerName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchCustomerName]').val());
        }

        function Txt_SearchSalesPersonName_Search() {
            $('[id*=HiddenField_Txt_SearchSalesPersonName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchSalesPersonName_Search]').val());
        }

        function RadioButtonList_SearchSalesPersonName() {
            $('[id*=HiddenField_RadioButtonList_SearchSalesPersonName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchSalesPersonName]').val());
        }

        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }

        function Edit_CustomerData() {
            $('[id*=HiddenField_Edit_CustomerData]').val("1");
            console.log($('[id*=HiddenField_Edit_CustomerData]').val());
        }

        function Delete_Data1() {
            $('[id*=HiddenField_Delete_Data1]').val("1");
            console.log($('[id*=HiddenField_Delete_Data1]').val());
        }

        function Btn_PopupAreaSubmit() {
            $('[id*=HiddenField_Btn_PopupAreaSubmit]').val("1");
            console.log($('[id*=HiddenField_Btn_PopupAreaSubmit]').val());
        }

    </script>
        <script>
            $(document).change(function () {
                $("[id*=Ddl_Area]").change(function () {
                    //$("[id*=Ddl_Area]").bind('change', function () {
                    //$(document).on('change', '[id*=Ddl_Area]', function () {
                    console.log("In On Change", $("[id*=Ddl_Area]").children(":selected").text());
                    console.log("In On Change", $("[id*=Ddl_Area]").val());
                    $("[id*=hfArea]").val($("[id*=Ddl_Area]").val());
                    console.log($("[id*=hfArea]").val());
                    return false;
                });

                $("[id*=Gv_BelongToBranch] [id*=btn_Delete]").click(function () {
                    //Determine the GridView row within whose LinkButton was clicked.
                    var row = $(this).closest("tr");
                    //Look for the Hidden Field and fetch the branchId.
                    var branchId = parseInt(row.find("[id*=hfBelongToBranch]").val());
                    var rowId = row.find("td").eq(1).find("input").eq(0).val();//row.find("td").eq(2).find("input").eq(0).val()
                    console.log(rowId);
                    if (branchId == rowId) {
                        rowId.remove();
                        alert("Branch record has been deleted.");
                    }
                });
            });
        </script>
    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

