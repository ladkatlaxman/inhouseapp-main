<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="MarketVehicle.aspx.cs" Inherits="MarketVehicle" %>

<asp:Content ID="contentHeader" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="contentDetail" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
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

        <asp:ScriptManager ID="ScriptManager1" runat="server" ScriptMode="Inherit" EnableCdn="true"></asp:ScriptManager>

        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#VehicleDetails" class="nav-link active tabfont">VEHICLE MASTER</a>
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
                                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha1" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha1" placeholder="MH" Style="width: 45px; text-transform: uppercase;" onkeypress="return checkNum()" MaxLength="2"></asp:TextBox> 
                                                                </div>
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit1" runat="server" onchange="Txt_NewVehicleNoDigit1()" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_NewVehicleNoDigit1" placeholder="12" Style="width: 45px; text-transform: uppercase;" MaxLength="2"></asp:TextBox>
                                                                </div>
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha2" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha2" placeholder="EK" Style="width: 45px; text-transform: uppercase;" onkeypress="return checkNum()" MaxLength="2"></asp:TextBox> 
                                                                </div>
                                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit2" runat="server" onchange="Txt_NewVehicleNoDigit2()" CssClass="form-control input-sm Txt_NewVehicleNoDigit2" placeholder="1234" Style="width: 50px; text-transform: uppercase;" MaxLength="4" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_VehicleCategory" runat="server" CssClass="label labelColor">VEHICLE CATEGORY</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_VehicleCategory" runat="server" Style="text-transform: uppercase;" class="formDisplay Ddl_VehicleCategory" AutoPostBack="true">
                                                                <asp:ListItem Selected="True">MARKET</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="TransporterName" runat="server">
                                                            <div class="row">

                                                                <div class="col-sm-11 col-md-11 col-lg-10 ">
                                                                    <div class="form-control-sm"></div>
                                                                    <asp:HiddenField ID="HiddenField_Txt_Transportername_Search" runat="server" />
                                                                    <asp:HiddenField ID="HiddenField_RadioButtonList_Transportername" runat="server" />

                                                                    <asp:Label ID="Lbl_TransporterName" runat="server" CssClass="label labelColor">TRANSPORTER NAME</asp:Label><span class="required">*</span>
                                                                    <asp:DropDownList ID="Ddl_TransporterName" runat="server" Style="text-transform: uppercase;" CssClass="formDisplay Ddl_TransporterName">
                                                                    </asp:DropDownList>
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
                                                            <asp:TextBox ID="Txt_VehicleHiringType" runat="server" Style="background-color: white; text-transform: uppercase;" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT VEHICLE HIRING TYPE" CssClass="form-control input-sm Txt_VehicleHiringType"></asp:TextBox>
                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_VehicleUsedFor" runat="server" Enabled="true" TargetControlID="Txt_VehicleHiringType" PopupControlID="Panel_VehicleHiringType" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>
                                                            <asp:Panel ID="Panel_VehicleHiringType" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto" BackColor="#ffffff" Style="display: none;">
                                                                <div runat="server" class="ddlSearchTextBox">
                                                                    <%-- SUBMIT BUTTON --%>
                                                                    <asp:LinkButton ID="LinkButton_VehicleHiringType_Submit" runat="server" ToolTip="Submit" OnClientClick="LinkButton_VehicleHiringType_Submit()"><%--
                                                                                                                                                                                        OnTextChanged="Txt_AttachWaybillNo_Search_TextChanged" onchange="Txt_AttachWaybillNo_Search()"                                                                                                                             --%>
                                                                                <img src="images/submit.png" style="height:18px;" class="searchSubmitButtonMultiDropDown" /></asp:LinkButton>
                                                                     <asp:TextBox ID="Txt_Search_EmpBelongToBranch" runat="server" Style="text-transform: uppercase;" placeholder="SEARCH" CssClass="form-control input-sm FirstNoSpaceAndZero txtSearchMultiDropDown"
                                                                    AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                                    <%-- SELECT ALL CHECKBOX --%>
                                                                    <asp:CheckBox ID="select_all_VehicleHiringType" runat="server" Width="190px" style="font-size:11px;color:black" AutoPostBack="true" Text="SELECT ALL" onchange="select_all_VehicleHiringType()"/>

                                                                    <%-- DISPLAY VALUE FROM DATABASE --%>
                                                                    <asp:CheckBoxList ID="CheckBoxList_VehicleHiringType" runat="server" style="font-size:11px;color:black" >
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
                                                            <asp:DropDownList ID="Ddl_VehicleType" runat="server" Style="text-transform: uppercase;" CssClass="formDisplay Ddl_VehicleType" >
                                                            </asp:DropDownList>
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
                                                            <asp:LinkButton ID="Button_Tab1Save" runat="server" CssClass="btn btn-info largeButtonStyle Btn_VehicleDetailsSave" UseSubmitBehavior="false" OnClientClick="if (!validateVehicleDetails()) {return false;} else{ __doPostBack('this.name','');};" >SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Btn_VehicleReset" runat="server" />
                                                            <asp:LinkButton ID="Btn_VehicleReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClientClick="Btn_VehicleReset()">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton ID="Btn_VehicleNext" runat="server" CssClass="btn btn-info largeButtonStyle" >NEXT&nbsp;<i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!---Buttons End--->
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
                <!--==============================================End Vehicle Information=======================================================================-->
            </div>
        </div>
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->



    <script src="Validation/Val_Vehicle.js"></script>

    <script type="text/javascript">
        function uploaderror() {
            alert("sonme error occured while uploading file!");
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

    </script>

</asp:Content>

