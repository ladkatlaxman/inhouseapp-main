<%@ Page Title="CUSTOMER CONTRACT" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Contract.aspx.cs" Inherits="Contract" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="icon" type="image/png" href="images/dexterLogo.png" />
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_ContractCustomer_BasicInfo" AssociatedUpdatePanelID="UpdatePanel_ContractCustomer_BasicInfo" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_RateCard" AssociatedUpdatePanelID="UpdatePanel_RateCard" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_ContractCustomer_GeoScope" AssociatedUpdatePanelID="UpdatePanel_ContractCustomer_GeoScope" runat="server" DisplayAfter="0">
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

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#BasicDetails" class="nav-link active tabfont">BASIC DETAILS</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" id="Tab_RateCard" runat="server" href="#RateCard" class="nav-link tabfont">RATE CARD</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" id="Tab_PickupSchedule" runat="server" href="#PickupSchedule" class="nav-link tabfont">PICKUP SCHEDULE</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" id="Tab_GeoScope" href="#GeoScope" runat="server" class="nav-link tabfont">GEO SCOPE</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
                <div class="tab-content">
                    <div id="AlertNotification"></div>
                    <!--================================================Basic  Details===============================================================-->
                    <div id="BasicDetails" class="tab-pane active">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_ContractCustomer_BasicInfo" runat="server">
                                <ContentTemplate>
                                    <div class="panel panelTop">
                                        <div class="panel-heading panelHead">
                                            <b>BASIC DETAILS</b>
                                        </div>
                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_ContractNo" runat="server" CssClass="label labelColor">CONTRACT NO.</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_ContractId" runat="server" CssClass="form-control input-sm Txt_ContractId" Enabled="false" Visible="false"></asp:TextBox>
                                                            <asp:TextBox ID="Txt_ContractNo" runat="server" CssClass="form-control input-sm Txt_ContractNo" Enabled="false"></asp:TextBox>
                                                        </div> 
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_BillingPartyName" runat="server" class="label labelColor labelColor">BILLING PARTY NAME</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_BillingPartyName" AutoCompleteType="Disabled" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_BillingPartyName" onkeypress="return checkNumAlpha()" TabIndex="1"></asp:TextBox>
                                                            <asp:HiddenField ID="hfBillingPartyName" runat="server" />
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_FromDate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_FromDate" TabIndex="2"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_ToDate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_ToDate" TabIndex="3"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_signingDate" runat="server" CssClass="label labelColor">SIGNING DATE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_signingDate" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_signingDate" TabIndex="4"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label4" runat="server" CssClass="label labelColor">CONTROLLING BRANCH</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_BranchName" AutoCompleteType="Disabled" runat="server" CssClass="formDisplay input-sm Ddl_BranchName" TabIndex="5">
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="CFTValue" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_CFTValue" runat="server" CssClass="label labelColor">CFT VALUE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_CFTValue" runat="server" CssClass="form-control input-sm Txt_CFTValue NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return checkDecimalNumeric()" TabIndex="6"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="Div1" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_FreightRate" runat="server" CssClass="label labelColor">FREIGHT RATE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_FreightRate"  runat="server" CssClass="form-control input-sm Txt_FreightRate NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return checkDecimalNumeric()" TabIndex="7"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <div class="row">
                                                                <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 col-xl-7">
                                                                    <asp:Label ID="Lbl_CategoryOfDays" runat="server" CssClass="label labelColor">CREDIT PERIOD</asp:Label><span class="required">*</span>
                                                                    <asp:DropDownList ID="Ddl_CategoryOfDays" runat="server" CssClass="formDisplay Ddl_CategoryOfDays" TabIndex="8">
                                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                                        <asp:ListItem Selected="True">DAYS</asp:ListItem>
                                                                        <asp:ListItem>WEEK</asp:ListItem>
                                                                        <asp:ListItem>MONTH</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                                <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 col-xl-5">
                                                                    <div class="form-control-lg"></div>
                                                                    <div class="form-control-lg"></div>
                                                                    <asp:TextBox ID="Txt_CategoryOfDays" runat="server" CssClass="form-control input-sm Txt_CategoryOfDays NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="9"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="Div2" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Ddl_DeliveryType" runat="server" Value="" />
                                                            <asp:Label ID="Label3" runat="server" CssClass="label labelColor">DELIVERY TYPE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_DeliveryType" runat="server" onchange="Ddl_DeliveryType()" CssClass="formDisplay Ddl_DeliveryType" AutoPostBack="True" OnSelectedIndexChanged="Ddl_DeliveryType_SelectedIndexChanged" TabIndex="10">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>DOOR DELIVERY</asp:ListItem>
                                                                <asp:ListItem>DOOR PICKUP</asp:ListItem>
                                                                <asp:ListItem>GODOWN PICKUP</asp:ListItem>
                                                                <asp:ListItem>GODOWN DELIVERY</asp:ListItem>
                                                                <asp:ListItem Selected="True">DOOR PICKUP - DOOR DELIVERY</asp:ListItem>
                                                                <asp:ListItem>GODOWN DELIVERY - GODOWN PICKUP</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="GracePeriod" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_GracePeriod" runat="server" CssClass="label labelColor labelColor">GRACE PERIOD</asp:Label><span class="required" id="Span7" runat="server">*</span>
                                                            <asp:TextBox ID="Txt_GracePeriod" runat="server" CssClass="form-control input-sm Txt_GracePeriod" AutoCompleteType="Disabled" TabIndex="11"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="AmountPerDay" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DemurrageCharges" runat="server" CssClass="label labelColor labelColor">DEMURRAGE CHARGES</asp:Label><span class="required" id="Span8" runat="server">*</span>
                                                            <asp:TextBox ID="Txt_DemurrageCharges" runat="server" CssClass="form-control input-sm Txt_DemurrageCharges" AutoCompleteType="Disabled" onkeypress="return validateNumericValue(event)" TabIndex="12"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                                            <asp:TextBox ID="Txt_Remark" runat="server" TextMode="MultiLine" CssClass="form-control input-sm" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="13"></asp:TextBox>
                                                        </div>
                                                        <%-- <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="PickupCuttOffTime" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_PIckupCutoffTime" runat="server" CssClass="label labelColor labelColor">Pickup Cutoff Time (PM)</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_PickupCutoffTime" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_PickupCutoffTime" TabIndex="11" MaxLength="2" onkeyup="return funNumber(this)" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                                        </div>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-heading panelHead">
                                            <b>COMMERCIAL DETAILS</b>
                                        </div>
                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="MinWait" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_minweight" runat="server" CssClass="label labelColor">MIN WEIGHT</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_Minweight" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_Minweight NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric(event)" TabIndex="14"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_MinFreight" runat="server" CssClass="label labelColor">MINIMUM FREIGHT</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_MinFreight" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_MinFreight NoFirstSpaceZeroAndDot" onkeypress="return validateNumericValue(event)" TabIndex="15"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="WaybillCharges" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_waybillcharges" runat="server" CssClass="label labelColor">WAYBILL CHARGES</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_waybillcharges" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_waybillcharges NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric(event)" TabIndex="16"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_ODACharges" runat="server" CssClass="label labelColor">ODA CHARGES</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_ODACharges" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_ODACharges NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric(event)" TabIndex="17"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2"> 
                                                            <div class="form-control-sm"></div> 
                                                            <asp:Label ID="Label17" runat="server" CssClass="label labelColor">ODA (PER KG)</asp:Label>
                                                            <asp:TextBox ID="txtODAPerKg" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm txtODAPerKg NoFirstSpaceZeroAndDot" onkeypress="return validateNumericValue(event)" TabIndex="17"></asp:TextBox> 
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2"> 
                                                            <div class="form-control-sm"></div> 
                                                            <asp:Label ID="Label20" runat="server" CssClass="label labelColor">CRITERIA</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="ddlRateOn" runat="server" CssClass="formDisplay ddlWeight" >
                                                                <asp:ListItem Value="Wgt" Text="Weight"></asp:ListItem>
                                                                <asp:ListItem Value="Qty" Text="Quantity"></asp:ListItem>
                                                                <asp:ListItem Value="Inn" Text="Inner Qty"></asp:ListItem>
																<asp:ListItem Value="Box" Text="Box"></asp:ListItem>
                                                            </asp:DropDownList>
                                                    </div>

                                                    </div>
                                                    <div class="row">
                                                         <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DSCType" runat="server" CssClass="label labelColor">DSC TYPE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_DSCType" runat="server" CssClass="formDisplay Ddl_DSCType" TabIndex="18">
                                                                <asp:ListItem>%</asp:ListItem>
                                                                <asp:ListItem>RS</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_DSCvalue" runat="server" CssClass="label labelColor">DSC VALUE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_DSCValue" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_DSCValue NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric()" TabIndex="19"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label15" runat="server" CssClass="label labelColor">BASE PRICE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="txtDSCBase" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_MinimumValue NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric(event)" TabIndex="22"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label14" runat="server" CssClass="label labelColor">CHANGE PER RUPEE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="txtDSCChange" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_MinimumValue NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric(event)" TabIndex="22"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label16" runat="server" CssClass="label labelColor">ON TOTAL</asp:Label><span class="required">*</span>
                                                            <asp:CheckBox ID="chkDSCOnTotal" runat="server" CssClass="form-control input-sm chkDSCOnTotal NoFirstSpaceZeroAndDot" onkeypress="return validateNumericValue(event)" TabIndex="22" Visible="false"></asp:CheckBox>
                                                            <asp:DropDownList ID="ddlDSCOnTotal" CssClass="formDisplay Ddl_DSCType" runat="server">
                                                                <asp:ListItem Value="#WAYBILL#" Text="BASIC"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##DOCKET#" Text="BASIC + DOCKET"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##ODA#" Text="BASIC + ODA"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##FOV#" Text="BASIC + FOV"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##DOCKET##ODA#" Text="BASIC + DOCKET + ODA"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##DOCKET##FOV#" Text="BASIC + DOCKET + FOV"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##ODA##FOV#" Text="BASIC + ODA + FOV"></asp:ListItem>
                                                                <asp:ListItem Value="#WAYBILL##DOCKET##ODA##FOV#" Text="BASIC + DOCKET + ODA + FOV"></asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label19" runat="server" CssClass="label labelColor">FUEL BASE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="ddlFuelBase" CssClass="formDisplay Ddl_DSCType" runat="server">
                                                                <asp:ListItem Value="MUM" Text="MUMBAI"></asp:ListItem>
                                                                <asp:ListItem Value="DEL" Text="DELHI"></asp:ListItem>
                                                                <asp:ListItem Value="PUN" Text="PUNE"></asp:ListItem>
                                                                <asp:ListItem Value="BHP" Text="BHOPAL"></asp:ListItem>
                                                                <asp:ListItem Value="IND" Text="INDORE"></asp:ListItem>
                                                                <asp:ListItem Value="BHP#IND" Text="BHOPAL + INDORE"></asp:ListItem>
                                                                <asp:ListItem Value="4MET" Text="FOUR METROS"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--========================================================ROV/FOV====================================================================================-->
                                        <div class="panel-heading panelHead">
                                            <b style="color: black;">ROV / FOV</b>
                                        </div>
                                        <div class="panel-body labelColor">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="ROVUnit" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_ROVUnit" runat="server" CssClass="label labelColor">ROV UNIT</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_ROVUnit" runat="server" CssClass="formDisplay Ddl_ROVUnit" TabIndex="20">
                                                                <asp:ListItem>% ON INV VALUE</asp:ListItem>
                                                                <asp:ListItem>RS</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="Range" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Range" runat="server" CssClass="label labelColor">VALUE</asp:Label><span class="required" id="MarkROVRange" runat="server">*</span>
                                                            <asp:TextBox ID="Txt_Range" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_Range NoFirstSpaceZeroAndDot" onkeypress="return checkDecimalNumeric()" TabIndex="21"></asp:TextBox>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_MinimumValue" runat="server" CssClass="label labelColor">MINIMUM VALUE</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_MinimumValue" AutoCompleteType="Disabled" runat="server" CssClass="form-control input-sm Txt_MinimumValue NoFirstSpaceZeroAndDot" onkeypress="return validateNumericValue(event)" TabIndex="22"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!------============================================================End FOV/ROV===============================================------>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Button_Tab1Save" runat="server" Value="" />
                                                    <asp:LinkButton CssClass="btn btn-info Button_Tab1Save largeButtonStyle" onchange="Button_Tab1Save()" ID="Button_Tab1Save" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateContractBasicDetails()) {return false;};" TabIndex="23" OnClick="Button_Tab1Save_Click">SAVE <i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Btn_BasicReset" runat="server" Value="" />
                                                    <asp:LinkButton CssClass="btn btn-info Btn_BasicReset largeButtonStyle" ID="Btn_BasicReset" onchange="Btn_BasicReset()" runat="server" TabIndex="24" OnClick="Btn_BasicReset_Click">RESET <i class="fa fa-refresh"></i></asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_CustomerContractNext" TabIndex="25" runat="server" class="btn btn-info next-step largeButtonStyle">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!---Buttons End--->
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Ddl_DeliveryType" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Button_Tab1Save" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_BasicReset" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_CustomerContractNext" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <!--================================================Rate Card Details===============================================================-->
                    <div id="RateCard" class="tab-pane">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_RateCard" runat="server">
                                <ContentTemplate>
                            <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>RATE CARD DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle2" ID="Btn_AddNewCharge" runat="server" data-toggle="modal" data-target="#NewRateModal" Text="">ADD NEW CHARGE</asp:LinkButton>
                                        <br />
                                        <br />
                                        <asp:GridView runat="server" ID="gridView" CssClass="table table-bordered" CellPadding="10" RowStyle-CssClass="gvItemStyle">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        </asp:GridView>
                                        <br />
                                        <br />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-2 col-md-3 col-lg-4 "></div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_Tab2Prev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="16"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_Tab2Next" runat="server" class="btn btn-info next-step largeButtonStyle" TabIndex="17">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <!--================================================Pickup Schedule Details===============================================================-->
                    <div id="PickupSchedule" class="tab-pane">
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>PICKUP SCHEDULE DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkMon" Checked="true" CssClass="chkMon" runat="server" TabIndex="18" />
                                                <asp:Label ID="Label2" runat="server" CssClass="label labelColor">MON</asp:Label>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_MonHours" runat="server" CssClass="formDisplay Ddl_MonHours" TabIndex="19">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_MonMinutes" runat="server" CssClass="formDisplay Ddl_MonMinutes" TabIndex="20">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkTue" Checked="true" CssClass="chkTue" runat="server" TabIndex="21" />
                                                <asp:Label ID="Label5" runat="server" CssClass="label labelColor">TUE</asp:Label>

                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_TueHours" runat="server" CssClass="formDisplay Ddl_TueHours" TabIndex="22">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_TueMinutes" runat="server" CssClass="formDisplay Ddl_TueMinutes" TabIndex="23">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkWed" Checked="true" CssClass="chkWed" runat="server" TabIndex="24" />
                                                <asp:Label ID="Label6" runat="server" CssClass="label labelColor">WED</asp:Label>

                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_WedHours" runat="server" CssClass="formDisplay Ddl_WedHours" TabIndex="25">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_WedMinutes" runat="server" CssClass="formDisplay Ddl_WedMinutes" TabIndex="26">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkThurs" Checked="true" CssClass="chkThurs" runat="server" TabIndex="27" />
                                                <asp:Label ID="Label7" runat="server" CssClass="label labelColor">THUR</asp:Label>

                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_ThursHours" runat="server" CssClass="formDisplay Ddl_ThursHours" TabIndex="28">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_ThursMinutes" runat="server" CssClass="formDisplay Ddl_ThursMinutes" TabIndex="29">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkFri" Checked="true" CssClass="chkFri" runat="server" TabIndex="30" />
                                                <asp:Label ID="Label8" runat="server" CssClass="label labelColor">FRI</asp:Label>

                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_FriHours" runat="server" CssClass="formDisplay Ddl_FriHours" TabIndex="31">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_FriMinutes" runat="server" CssClass="formDisplay Ddl_FriMinutes" TabIndex="32">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkSat" Checked="true" CssClass="chkSat" runat="server" TabIndex="33" />
                                                <asp:Label ID="Label9" runat="server" CssClass="label labelColor">SAT</asp:Label>

                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_SatHours" runat="server" CssClass="formDisplay Ddl_SatHours" TabIndex="34">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_SatMinutes" runat="server" CssClass="formDisplay Ddl_SatMinutes" TabIndex="35">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:CheckBox ID="chkSun" CssClass="chkSun" runat="server" TabIndex="36" />
                                                <asp:Label ID="Label10" runat="server" CssClass="label labelColor">SUN</asp:Label>

                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_SunHours" runat="server" CssClass="formDisplay Ddl_SunHours" TabIndex="37">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>6</asp:ListItem>
                                                    <asp:ListItem>7</asp:ListItem>
                                                    <asp:ListItem>8</asp:ListItem>
                                                    <asp:ListItem>9</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem>11</asp:ListItem>
                                                    <asp:ListItem>12</asp:ListItem>
                                                    <asp:ListItem>13</asp:ListItem>
                                                    <asp:ListItem>14</asp:ListItem>
                                                    <asp:ListItem>15</asp:ListItem>
                                                    <asp:ListItem>16</asp:ListItem>
                                                    <asp:ListItem>17</asp:ListItem>
                                                    <asp:ListItem>18</asp:ListItem>
                                                    <asp:ListItem>19</asp:ListItem>
                                                    <asp:ListItem>20</asp:ListItem>
                                                    <asp:ListItem>21</asp:ListItem>
                                                    <asp:ListItem>22</asp:ListItem>
                                                    <asp:ListItem>23</asp:ListItem>
                                                    <asp:ListItem>24</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:DropDownList ID="Ddl_SunMinutes" runat="server" CssClass="formDisplay Ddl_SunMinutes" TabIndex="38">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>00</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-2 col-md-3 col-lg-4 "></div>

                                        <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_Tab3Prev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="39"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                        </div>

                                        <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value="" />
                                            <asp:LinkButton ID="Btn_PickupSchedule" CssClass="btn btn-info Btn_PickupSchedule largeButtonStyle" Text="SAVE" runat="server" OnClick="Btn_PickupSchedule_Click" TabIndex="40">SAVE <i class="fa fa-save"></i></asp:LinkButton><%--UseSubmitBehavior="false" OnClientClick="if (!validatePickupDaysDetails()) {return false;};"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="HiddenField2" runat="server" Value="" />
                                            <asp:LinkButton CssClass="btn btn-info Btn_PickupReset largeButtonStyle" ID="Btn_PickupReset" runat="server" OnClick="Btn_PickupReset_Click" TabIndex="41">RESET <i class="fa fa-refresh"></i></asp:LinkButton>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_Tab3Next" runat="server" class="btn btn-info next-step largeButtonStyle" TabIndex="42">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--================================================ Geo Scope  Details===============================================================-->
                    <div id="GeoScope" class="tab-pane">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_ContractCustomer_GeoScope" runat="server">
                                <ContentTemplate>
                                    <div class="panel panelTop">
                                        <div class="panel-heading panelHead">
                                            <b>GEO SCOPE DETAILS</b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_FromPincode" runat="server" CssClass="label labelColor">FROM</asp:Label><span class="required">*</span>
                                                        </div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_ToPincode" runat="server" CssClass="label labelColor">TO</asp:Label><span class="required">*</span>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Pincode" runat="server" CssClass="label labelColor">PINCODE</asp:Label>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_FromPincode" runat="server" CssClass="form-control input-sm Txt_FromPincode NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="24" onchange="ReadDataonchange('Txt_FromPincode','hfFromPincode','','Party_CustomerCreation.aspx/getPincode');"></asp:TextBox>
                                                            <asp:HiddenField ID="hfFromPincode" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkFromPincode" CssClass="chkFromPincode" runat="server" TabIndex="18" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_ToPincode" runat="server" CssClass="form-control input-sm Txt_ToPincode NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="24" onchange="ReadDataonchange('Txt_ToPincode','hfToPincode','','Party_CustomerCreation.aspx/getPincode');"></asp:TextBox>
                                                            <asp:HiddenField ID="hfToPincode" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkToPincode" CssClass="chkToPincode" runat="server" TabIndex="18" />
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_FromDistrict" runat="server" CssClass="form-control input-sm Txt_FromDistrict" TabIndex="24"></asp:TextBox>
                                                            <asp:HiddenField ID="hfFromDistrict" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkFromDistrict" CssClass="chkFromDistrict" runat="server" TabIndex="18" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_ToDistrict" runat="server" CssClass="form-control input-sm Txt_ToDistrict" TabIndex="24"></asp:TextBox>
                                                            <asp:HiddenField ID="hfToDistrict" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkToDistrict" CssClass="chkToDistrict" runat="server" TabIndex="18" />
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_FromCity" runat="server" CssClass="form-control input-sm Txt_FromCity" TabIndex="24"></asp:TextBox>
                                                            <asp:HiddenField ID="hfFromCity" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkFromCity" CssClass="chkFromCity" runat="server" TabIndex="18" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_ToCity" runat="server" CssClass="form-control input-sm Txt_ToCity" TabIndex="24"></asp:TextBox>
                                                            <asp:HiddenField ID="hfToCity" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkToCity" CssClass="chkToCity" runat="server" TabIndex="18" />
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_FromState" runat="server" CssClass="form-control input-sm Txt_FromState" TabIndex="24"></asp:TextBox>
                                                            <asp:HiddenField ID="hfFromState" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkFromState" CssClass="chkFromState" runat="server" TabIndex="18" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:TextBox ID="Txt_ToState" runat="server" CssClass="form-control input-sm Txt_ToState" TabIndex="24"></asp:TextBox>
                                                            <asp:HiddenField ID="hfToState" runat="server" />
                                                        </div>
                                                        <asp:CheckBox ID="chkToState" CssClass="chkToState" runat="server" TabIndex="18" />
                                                </div>
                                                    <div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label18" runat="server" CssClass="label labelColor">REGION</asp:Label>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:DropDownList ID="ddlFromRegion" runat="server" EnableViewState="true"></asp:DropDownList>
                                                        </div>
                                                        <asp:CheckBox ID="chkfromRegion" CssClass="chkFromState" runat="server" TabIndex="18" />
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:DropDownList ID="ddlToRegion" runat="server" EnableViewState="true"></asp:DropDownList>
                                                        </div>
                                                        <asp:CheckBox ID="chkToRegion" CssClass="chkToState" runat="server" TabIndex="18" />
                                                </div>
												<div class="row">
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Label24" runat="server" CssClass="label labelColor">DEPOT </asp:Label>
                                                        </div> 
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 "></div> 
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 "></div> 
                                                        <asp:CheckBox ID="chkToDepot" CssClass="chkToState" runat="server"/> 
                                                </div>													
                                                <div class="row">
                                                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Weight" runat="server" CssClass="label labelColor">WEIGHT</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Weight" runat="server" CssClass="form-control input-sm Txt_Weight NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="24"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Kg" runat="server" CssClass="label labelColor">Kgs</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Price" runat="server" CssClass="label labelColor">PRICE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Price" runat="server" CssClass="form-control input-sm Txt_Price NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return checkDecimalNumeric()" TabIndex="24"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Rs" runat="server" CssClass="label labelColor">Rs</asp:Label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor">FROM WEIGHT</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtFromWeight" runat="server" CssClass="form-control input-sm txlFromWeight NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="24"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label11" runat="server" CssClass="label labelColor">Kgs</asp:Label>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label12" runat="server" CssClass="label labelColor">TO WEIGHT</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtToWeight" runat="server" CssClass="form-control input-sm txtToWeight NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return checkDecimalNumeric()" TabIndex="24"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label13" runat="server" CssClass="label labelColor">Kgs</asp:Label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <asp:Label ID="Label21" runat="server" CssClass="label labelColor">MATERIAL</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_MaterialType" runat="server" Style="text-transform: uppercase;" TabIndex="27" CssClass="form-control input-sm Txt_MaterialType" onchange="ReadDataonchange('Txt_MaterialType', 'hfMaterialID', '', 'PickReqCRMBranch.aspx/getMaterial');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfMaterialID" runat="server" />
                                                    </div>
                                                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                    </div>
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label23" runat="server" CssClass="label labelColor">&nbsp;</asp:Label>
                                                    </div>
                                                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <asp:Label ID="Label22" runat="server" CssClass="label labelColor">&nbsp;</asp:Label> 
                                                        <asp:LinkButton class="btn btn-info largeButtonStyle" ID="Btn_Add" runat="server" OnClick="Btn_Add_Click" UseSubmitBehavior="false" OnClientClick="if (!validateContractConditionDetails1()) {return false;};" TabIndex="45">ADD</asp:LinkButton>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                        <div class="form-group" id="AddDIV" runat="server" visible="true">
                                            <asp:GridView ID="AddGeoScope_DataTable_GridView" runat="server" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false" RowStyle-CssClass="gvItemStyle">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SR.NO">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="fromhfValue"         Visible="false" />
                                                    <asp:BoundField DataField="fromLocation"    HeaderText="FROM" />
                                                    <asp:BoundField DataField="tohfValue"           Visible="false" />
                                                    <asp:BoundField DataField="toLocation"      HeaderText="TO" />
                                                    <asp:BoundField DataField="weight"          HeaderText="WEIGHT" />
                                                    <asp:BoundField DataField="fromWeight"      HeaderText="From Weight" />
                                                    <asp:BoundField DataField="toWeight"        HeaderText="To Weight" />
                                                    <asp:BoundField DataField="MaterialName"    HeaderText="Material" />
                                                    <asp:BoundField DataField="price"           HeaderText="PRICE" />
						                            <asp:TemplateField HeaderText="DELETE">
                                                        <ItemTemplate>
                                                            <span onclick="return confirm('Are you sure you want to delete this record')">
                                                                <asp:LinkButton ID="deleteContractCondition" runat="server" CommandArgument='<%#Eval("contractConditionId") %>' OnClick="deleteContractCondition_Click" ToolTip="Delete"><i style="font-size: 25px; color:darkblue" class="fa fa-trash"></i></asp:LinkButton>
                                                            </span>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                            </asp:GridView>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4  "></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_GeoPrev" runat="server" CssClass="btn btn-info  prev-step largeButtonStyle" TabIndex="41"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                </div>
                                                 <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton CssClass="btn btn-info Button_Tab2Save largeButtonStyle" ID="Button_Tab2Save" runat="server" UseSubmitBehavior="false" OnClick="Button_Tab2Save_Click" TabIndex="50">SUBMIT <i class="fa fa-save"></i></asp:LinkButton><%-- else{ __doPostBack('this.name','');}--%>
                                                </div>
                                                 <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_ResetGeoScope" runat="server" OnClick="Btn_ResetGeoScope_Click" TabIndex="56">RESET <i class="fa fa-refresh"></i> </asp:LinkButton>
                                                </div>  
                                            </div>
                                        </div>
                                    </div>
                                    <!---Buttons End--->
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                  
                    <!--================================================FSC / QUOTATION  Details===============================================================-->
                    <%--  <div id="FSC_Quotation" class="tab-pane fade">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_ContractCustomer_FSCQuotation" runat="server">
                                <ContentTemplate>
                                    <div class="panel panelTop">
                                        <div class="row">
                                            <div class="col-sm-12 col-lg-6 col-md-6">
                                                <div class="panel panelTop">

                                                    <div class="panel-heading panelHead">
                                                        <b style="color: black;">FSC/DSC DETAILS</b>
                                                    </div>


                                                    <div class="panel-body labelColor">
                                                        <div class="form-horizontal" role="form">
                                                            <div class="form-group">

                                                                <div class="row">

                                                                    <div class="col-sm-2 col-md-2 col-lg-2">
                                                                    </div>
                                                                    <div class="col-sm-4 col-md-4 col-lg-4">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:HiddenField ID="HiddenField_LinkButton_SearchState_Dropdown_Submit" runat="server" Value="1" />
                                                                        <asp:HiddenField ID="HiddenField_Txt_State_Search" runat="server" Value="" />
                                                                        <asp:HiddenField ID="HiddenField_select_all_State" runat="server" Value="" />
                                                                        <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                        <%-- NOT EDITABLE TEXTBOX AND DISPLAY SELECTED VALUE -%>
                                                                        <asp:TextBox ID="Txt_State" runat="server" Style="background-color: white;" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" CssClass="form-control Txt_State"></asp:TextBox>
                                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_State" runat="server" Enabled="true" TargetControlID="Txt_State" PopupControlID="Panel_State" OffsetY="38" OffsetX="-2">
                                                                        </ajaxToolkit:PopupControlExtender>
                                                                        <asp:Panel ID="Panel_State" runat="server" CssClass="form-control" Height="140px" Width="97%" Direction="LeftToRight" ScrollBars="Auto" BackColor="#ffffff" Style="display: none;">
                                                                            <div runat="server" class="ddlSearchTextBox">
                                                                                <%-- SUBMIT BUTTON -%>
                                                                                <asp:LinkButton ID="LinkButton_SearchState_Dropdown_Submit" runat="server" onchange="LinkButton_SearchState_Dropdown_Submit()" ToolTip="Submit" OnClick="LinkButton_SearchState_Dropdown_Submit_Click">
                                                                               <img src="images/submit.png" style="height:20px;" class="searchSubmitButtonMultiDropDown" /></asp:LinkButton>
                                                                                <%-- SEARCH BOX -%>
                                                                                <asp:TextBox ID="Txt_State_Search" runat="server" onchange="Txt_State_Search()" placeholder="Enter" CssClass="form-control input-sm txtSearchMultiDropDown" AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_State_Search_TextChanged"></asp:TextBox>
                                                                            </div>
                                                                            <%--  OnTextChanged="TextBox2_TextChanged" -%>
                                                                            <div runat="server" class="ddlDropDownList">
                                                                                <%-- SELECT ALL CHECKBOX -%>
                                                                                <asp:CheckBox ID="select_all_State" runat="server" onchange="select_all_State()" AutoPostBack="true" OnCheckedChanged="select_all_State_CheckedChanged" Text="Select All" />
                                                                                <%-- DISPLAY VALUE FROM DATABASE -%>
                                                                                <asp:CheckBoxList ID="CheckBoxList__State" runat="server">
                                                                                </asp:CheckBoxList>
                                                                            </div>
                                                                        </asp:Panel>


                                                                    </div>

                                                                    <div class="col-sm-4 col-md-4 col-lg-4" id="BasicDieselRate" runat="server">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_basicDieselRate" runat="server" CssClass="label labelColor labelColor">BASIC DIESEL RATE</asp:Label>
                                                                        <asp:TextBox ID="Txt_basicDieselRate" runat="server" CssClass="form-control input-sm NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="49" ReadOnly="true" BackColor="White"></asp:TextBox>
                                                                    </div>

                                                                </div>

                                                            </div>
                                                        </div>

                                                    </div>



                                                </div>
                                            </div>
                                            <!--===============================================End FSC Details=======================================================-->
                                            <!--===============================================Quotation Details=======================================================-->
                                            <div class="col-sm-12 col-lg-6 col-md-6">
                                                <div class="panel panelTop">
                                                    <div class="panel-heading panelHead">
                                                        <b>QUOTATION DETAILS</b>
                                                    </div>
                                                    <div class="panel-body ">
                                                        <div class="form-horizontal" role="form">
                                                            <div class="form-group">
                                                                <div class="row">
                                                                    <%--<div class=" col-sm-1 col-md-1 col-lg-1 "></div>-%>
                                                                    <div class=" col-sm-4 col-md-5 col-lg-4 ">
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_QuotationDate" runat="server" CssClass="label labelColor labelColor">QUOTATION DATE</asp:Label>
                                                                        <asp:TextBox ID="Txt_Quotationdate" runat="server" CssClass="form-control input-sm Txt_Quotationdate" type="Date" TabIndex="52"></asp:TextBox>
                                                                    </div>

                                                                    <div class="col-sm-4 col-md-5 col-lg-4">

                                                                        <div class="form-control-sm"></div>
                                                                        <asp:Label ID="Lbl_QuotationNo" runat="server" CssClass="label labelColor labelColor">QUOTATION NO.</asp:Label>
                                                                        <asp:TextBox ID="Txt_QuotationNo" runat="server" CssClass="form-control input-sm Txt_QuotationNo" TabIndex="53"></asp:TextBox>

                                                                    </div>
                                                                    <div class="col-sm-4 col-md-5 col-lg-4" runat="server" id="mainAddDiv" visible="true">
                                                                        <div class="form-control-sm"></div>
                                                                        <div class="form-control-sm"></div>
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:HiddenField ID="HiddenField_Btn_addquotation" runat="server" Value="" />
                                                                        <asp:LinkButton CssClass="btn btn-info Btn_addquotation" ID="Btn_addquotation" onchange="Btn_addquotation()" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateQuotationDetails()) {return false;};" OnClick="Btn_addquotation_Click" TabIndex="54">ADD QUOTATION <i class="fa fa-plus"></i></asp:LinkButton>
                                                                    </div>
                                                                    <div class="col-sm-4 col-md-5 col-lg-4" runat="server" id="OnEditAddDiv" visible="false">
                                                                        <div class="form-control-sm"></div>
                                                                        <div class="form-control-sm"></div>
                                                                        <div class="form-control-sm"></div>
                                                                        <asp:HiddenField ID="HiddenField_Btn_OnEditAddQuotation" runat="server" Value="" />
                                                                        <asp:LinkButton CssClass="btn btn-info Btn_OnEditAddQuotation" ID="Btn_OnEditAddQuotation" onchange="Btn_OnEditAddQuotation()" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateQuotationDetails()) {return false;};" OnClick="Btn_OnEditAddQuotation_Click" TabIndex="54">ADD QUOTATION <i class="fa fa-plus"></i></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group" visible="false" runat="server" id="QuotationGridDiv">
                                                                <div class="row" style="margin-top: 12px">
                                                                    <div class="col-sm-8 col-lg-8 col-md-8">
                                                                        <asp:GridView ID="QuotationGridViewDataTable" runat="server" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="ACTION">
                                                                                    <ItemTemplate>
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:LinkButton ID="Edit_Data" runat="server" OnClick="Edit_Data_Click" CommandArgument='<%# Eval("dataTableID")%>' ToolTip="Edit"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:LinkButton ID="Delete_Data1" runat="server" OnClick="Delete_Data1_Click" CommandArgument='<%# Eval("dataTableID")%>' ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Row?');"><i class="fa fa-trash" style="font-size:25px; color:red"></i></asp:LinkButton>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                                    <ItemStyle />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle CssClass="table_04" HorizontalAlign="Left"></HeaderStyle>
                                                                                    <ItemStyle CssClass="table_02" HorizontalAlign="Left"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="dataTableID" HeaderText="ID" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                                                                                <asp:BoundField DataField="quotationDate" HeaderText="DATE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="quotationNo" HeaderText="QUOTATION NO" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group" visible="false" runat="server" id="EditQuotationDiv">
                                                                <div class="row" style="margin-top: 12px">
                                                                    <div class="col-sm-8 col-lg-8 col-md-8">
                                                                        <asp:GridView ID="GridViewEditQuotation" runat="server" DataKeyNames="quotationID" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="ACTION">
                                                                                    <ItemTemplate>
                                                                                        <table>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:LinkButton ID="EditQuotation_Data" runat="server" OnClick="EditQuotation_Data_Click" CommandArgument='<%# Eval("quotationID")%>' ToolTip="Edit"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:LinkButton ID="DeleteQuotation_Data1" runat="server" OnClick="DeleteQuotation_Data1_Click" ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Row?');"><i class="fa fa-trash" style="font-size:25px; color:red"></i></asp:LinkButton>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                                    <ItemStyle />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                                                                                    <ItemTemplate>
                                                                                        <%# Container.DataItemIndex + 1 %>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle CssClass="table_04" HorizontalAlign="Left"></HeaderStyle>
                                                                                    <ItemStyle CssClass="table_02" HorizontalAlign="Left"></ItemStyle>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="quotationDate" HeaderText="DATE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" />
                                                                                <asp:BoundField DataField="quotationNo" HeaderText="QUOTATION NO" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" />
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--==============================================end Quotation Details======================================================== -->
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-2 col-md-3 col-lg-4 "></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_FSCQuotationPrev" runat="server" CssClass="btn btn-info prev-step largeButtonStyle" TabIndex="34"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Button_Tab3Save" runat="server" Value="" />
                                                    <asp:LinkButton CssClass="btn btn-info Button_Tab3Save largeButtonStyle" ID="Button_Tab3Save" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateFSCDetails()) {return false;};" OnClick="Button_Tab3Save_Click" TabIndex="47">SAVE <i class="fa fa-save"></i></asp:LinkButton><%-- else{ __doPostBack('this.name','');}-%>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Btn_FSCReset" runat="server" Value="" />
                                                    <asp:LinkButton CssClass="btn btn-info Btn_FSCReset largeButtonStyle" ID="Btn_FSCReset" runat="server" OnClick="Btn_FSCReset_Click" TabIndex="48">RESET <i class="fa fa-refresh"></i></asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton runat="server" ID="Btn_FSCNext" class="btn btn-info next-step largeButtonStyle" TabIndex="49">NEXT <i class="fa fa-arrow-circle-right"></i></asp:LinkButton>
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="LinkButton_SearchState_Dropdown_Submit" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Txt_State_Search" EventName="TextChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="select_all_State" EventName="CheckedChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_addquotation" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_OnEditAddQuotation" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_FSCQuotationPrev" />
                                    <asp:AsyncPostBackTrigger ControlID="Button_Tab3Save" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_FSCReset" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_FSCNext" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>--%>
                    <!--================================================OLD Geo Scope  Details===============================================================-->
                    <%--   <div id="GeoScope" class="tab-pane fade">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_ContractCustomer_GeoScope" runat="server">
                                <ContentTemplate>
                                    <div class="panel panelTop">
                                        <div class="panel-heading panelHead">
                                            <b>GEO SCOPE DETAILS</b>
                                        </div>
                                        <div class="panel-body ">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group" runat="server" id="geoPanel">
                                                    <div class="row">
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="Items" runat="server" style="z-index: 1;">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_MaterialName_Search" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField_RadioButtonList_MaterialName" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_Material" runat="server" CssClass="label labelColor labelColor">MATERIAL</asp:Label><span class="required">*</span>
                                                            <!----DropDown Start----->
                                                            <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <asp:TextBox ID="Txt_MaterialName" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" Text="SELECT" CssClass="form-control Txt_MaterialName"></asp:TextBox>

                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_MaterialName" runat="server" Enabled="true" TargetControlID="Txt_MaterialName"
                                                                PopupControlID="Panel_MaterialName" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>

                                                            <asp:Panel ID="Panel_MaterialName" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                BackColor="#ffffff" Style="display: none;">

                                                                <div runat="server" class="ddlSearchTextBox">

                                                                    <asp:TextBox ID="Txt_MaterialName_Search" runat="server" onchange="Txt_MaterialName_Search()" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown"
                                                                        AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_MaterialName_Search_TextChanged"></asp:TextBox>
                                                                </div>

                                                                <div runat="server" class="ddlDropDownList">
                                                                    <asp:RadioButtonList ID="RadioButtonList_MaterialName" onchange="RadioButtonList_MaterialName()" runat="server" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_MaterialName_SelectedIndexChanged">
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </asp:Panel>
                                                            <!----DropDown End----->

                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="TypeOfPkg" runat="server" style="z-index: 1;">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_TypeOFPackage_Search" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField_RadioButtonList_TypeOFPackage" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_pkgtype" runat="server" CssClass="label labelColor labelColor">TYPE OF PACKAGE</asp:Label><span class="required">*</span>
                                                            <!----DropDown Start----->
                                                            <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <asp:TextBox ID="Txt_TypeOFPackage" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" Text="SELECT" placeholder="SELECT" CssClass="form-control Txt_TypeOFPackage"></asp:TextBox>

                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_TypeOFPackage" runat="server" Enabled="true" TargetControlID="Txt_TypeOFPackage"
                                                                PopupControlID="Panel_TypeOFPackage" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>

                                                            <asp:Panel ID="Panel_TypeOFPackage" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                BackColor="#ffffff" Style="display: none;">

                                                                <div runat="server" class="ddlSearchTextBox">

                                                                    <asp:TextBox ID="Txt_TypeOFPackage_Search" runat="server" onchange="Txt_TypeOFPackage_Search()" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown"
                                                                        AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_TypeOFPackage_Search_TextChanged"></asp:TextBox>
                                                                </div>

                                                                <div runat="server" class="ddlDropDownList">
                                                                    <asp:RadioButtonList ID="RadioButtonList_TypeOFPackage" onchange="RadioButtonList_TypeOFPackage()" runat="server" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_TypeOFPackage_SelectedIndexChanged">
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </asp:Panel>
                                                            <!----DropDown End----->

                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_GEOScopeCategory" runat="server" CssClass="label labelColor labelColor">CATEGORY</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_GEOScopeCategory" runat="server" CssClass="formDisplay Ddl_GEOScopeCategory" TabIndex="1">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem Selected="True">REGULAR</asp:ListItem>
                                                                <asp:ListItem>ODA</asp:ListItem>
                                                                <asp:ListItem>NON-SERVICEABLE</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Ddl_ScopeType" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_ScopeType" runat="server" CssClass="label labelColor labelColor">SCOPE TYPE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_ScopeType" runat="server" CssClass="formDisplay Ddl_ScopeType" onchange="Ddl_ScopeType()" AutoPostBack="True" OnSelectedIndexChanged="Ddl_ScopeType_SelectedIndexChanged" TabIndex="2">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>BRANCH TO BRANCH</asp:ListItem>
                                                                <asp:ListItem>BRANCH TO REGION</asp:ListItem>
                                                                <asp:ListItem>REGION TO REGION</asp:ListItem>
                                                                <asp:ListItem>REGION TO BRANCH</asp:ListItem>
                                                            </asp:DropDownList>

                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " visible="false" runat="server" id="DivScopeType1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_ScopeType1_Search" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField_RadioButtonList_ScopeType1" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_ScopeType1" runat="server" CssClass="label labelColor labelColor"></asp:Label><span class="required">*</span>
                                                            <!----DropDown Start----->
                                                            <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <asp:TextBox ID="Txt_ScopeType1" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" Text="SELECT" CssClass="form-control Txt_ScopeType1"></asp:TextBox>

                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_ScopeType1" runat="server" Enabled="true" TargetControlID="Txt_ScopeType1"
                                                                PopupControlID="Panel_ScopeType1" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>

                                                            <asp:Panel ID="Panel_ScopeType1" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                BackColor="#ffffff" Style="display: none;">

                                                                <div runat="server" class="ddlSearchTextBox">

                                                                    <asp:TextBox ID="Txt_ScopeType1_Search" runat="server" onchange="Txt_ScopeType1_Search()" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown"
                                                                        AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_ScopeType1_Search_TextChanged"></asp:TextBox>
                                                                </div>

                                                                <div runat="server" class="ddlDropDownList">
                                                                    <asp:RadioButtonList ID="RadioButtonList_ScopeType1" onchange="RadioButtonList_ScopeType1()" runat="server" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_ScopeType1_SelectedIndexChanged">
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </asp:Panel>
                                                            <!----DropDown End----->
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " visible="false" runat="server" id="DivScopeType2">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Txt_ScopeType2_Search" runat="server" Value="" />
                                                            <asp:HiddenField ID="HiddenField_RadioButtonList_ScopeType2" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_ScopeType2" runat="server" CssClass="label labelColor labelColor"></asp:Label><span class="required">*</span>
                                                            <!----DropDown Start----->
                                                            <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                            <asp:TextBox ID="Txt_ScopeType2" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" Text="SELECT" CssClass="form-control Txt_ScopeType2"></asp:TextBox>

                                                            <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_ScopeType2" runat="server" Enabled="true" TargetControlID="Txt_ScopeType2"
                                                                PopupControlID="Panel_ScopeType2" OffsetY="38" OffsetX="-2">
                                                            </ajaxToolkit:PopupControlExtender>

                                                            <asp:Panel ID="Panel_ScopeType2" runat="server" CssClass="form-control" Height="140px" Width="100%" Direction="LeftToRight" ScrollBars="Auto"
                                                                BackColor="#ffffff" Style="display: none;">

                                                                <div runat="server" class="ddlSearchTextBox">

                                                                    <asp:TextBox ID="Txt_ScopeType2_Search" runat="server" onchange="Txt_ScopeType2_Search()" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown"
                                                                        AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_ScopeType2_Search_TextChanged"></asp:TextBox>
                                                                </div>

                                                                <div runat="server" class="ddlDropDownList">
                                                                    <asp:RadioButtonList ID="RadioButtonList_ScopeType2" runat="server" onchange="RadioButtonList_ScopeType2()" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_ScopeType2_SelectedIndexChanged">
                                                                    </asp:RadioButtonList>
                                                                </div>
                                                            </asp:Panel>
                                                            <!----DropDown End----->
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Ddl_UnitType" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_UnitType" runat="server" CssClass="label labelColor labelColor">UNIT TYPE</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_UnitType" runat="server" onchange="Ddl_UnitType()" CssClass="formDisplay Ddl_UnitType" OnSelectedIndexChanged="Ddl_UnitType_SelectedIndexChanged" AutoPostBack="true" TabIndex="8">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>PER BOX</asp:ListItem>
                                                                <asp:ListItem Selected="True">KG</asp:ListItem>
                                                            </asp:DropDownList>


                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Ddl_UnitTypeOn" runat="server" Value="" />
                                                            <asp:Label ID="Lbl_Ddl_UnitTypeOn" runat="server" CssClass="label labelColor labelColor">UNIT TYPE ON</asp:Label><span class="required">*</span>
                                                            <asp:DropDownList ID="Ddl_UnitTypeOn" runat="server" onchange="Ddl_UnitTypeOn()" CssClass="formDisplay Ddl_UnitTypeOn" AutoPostBack="True" OnSelectedIndexChanged="Ddl_UnitTypeOn_SelectedIndexChanged" TabIndex="10">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                                <asp:ListItem>EQUAL TO</asp:ListItem>
                                                                <asp:ListItem>BETWEEN</asp:ListItem>
                                                                <asp:ListItem>ABOVE</asp:ListItem>
                                                            </asp:DropDownList>


                                                        </div>


                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="NoOfBoxes" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_NoOfBoxes" runat="server" CssClass="label labelColor labelColor">NO OF BOXES</asp:Label><span class="required" id="Span4" runat="server">*</span>
                                                            <asp:TextBox ID="Txt_NoOfBoxes" runat="server" CssClass="form-control input-sm NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return validateNumericValue(event)" TabIndex="16"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="NoOfBoxesBetween" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <div class="row">

                                                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
                                                                    <asp:Label ID="Lbl_NoOfBoxesBetween" runat="server" CssClass="label labelColor  labelColor">FROM</asp:Label><span class="required">*</span>
                                                                    <asp:TextBox ID="Txt_NoOfBoxesBetween1" runat="server" CssClass="form-control input-sm Txt_NoOfBoxesBetween1 NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return validateNumericValue(event)" TabIndex="17"></asp:TextBox>

                                                                </div>
                                                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
                                                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor  labelColor">TO</asp:Label><span class="required">*</span>
                                                                    <asp:TextBox ID="Txt_NoOfBoxesBetween2" runat="server" CssClass="form-control input-sm Txt_NoOfBoxesBetween2 NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return validateNumericValue(event)" TabIndex="18"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="Kg" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_Kg" runat="server" CssClass="label labelColor labelColor">KG</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_Kg" runat="server" CssClass="form-control input-sm Txt_Kg NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="24"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="KMFromTo" runat="server" visible="false">

                                                            <div class="form-control-sm"></div>


                                                            <div class="row">
                                                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
                                                                    <asp:Label ID="Lbl_KgFrom" runat="server" CssClass="label labelColor labelColor" Visible="false">FROM KG</asp:Label><span id="SpanKgFromTo" runat="server" class="required" visible="false">*</span>
                                                                    <asp:TextBox ID="Txt_FromKg" runat="server" CssClass="form-control input-sm Txt_KgFrom NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="21"></asp:TextBox>

                                                                </div>
                                                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6">
                                                                    <asp:Label ID="Lbl_KgTo" runat="server" CssClass="label labelColor labelColor" Visible="false">TO KG</asp:Label><span id="Span5" runat="server" class="required" visible="false">*</span>
                                                                    <asp:TextBox ID="Txt_ToKg" runat="server" CssClass="form-control input-sm Txt_KgTo NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="22"></asp:TextBox>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="Charges" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label runat="server" class="label labelColor labelColor">UNIT CHARGES</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_UnitCharges" runat="server" CssClass="form-control input-sm Txt_UnitCharges NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return validateNumericValueWithDot(event)" TabIndex="25"></asp:TextBox>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 " id="ExtraCharges" runat="server">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label runat="server" class="label labelColor labelColor">EXTRA CHARGES</asp:Label>
                                                            <asp:TextBox ID="Txt_Extrachargesmin" runat="server" CssClass="form-control input-sm Txt_Extrachargesmin NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" onkeypress="return validateNumericValueWithDot(event)" TabIndex="26"></asp:TextBox>
                                                        </div>

                                                        <!--===================================================================Visible Field on click multiselection on pincode multiselection ===================================-->

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="Btn_AddGeoScopeDiv" runat="server" visible="true">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Btn_addGeoScope" runat="server" Value="" />
                                                            <asp:Label runat="server" CssClass="label labelColor labelColor">&nbsp;</asp:Label>
                                                            <asp:LinkButton class="btn btn-info buttonStyle form-control input-sm" onchange="Btn_addGeoScope()" ID="Btn_addGeoScope" runat="server" Text="ADD GEO SCOPE" UseSubmitBehavior="false" OnClientClick="if (!validateGeoScopesDetails()) {return false;};" OnClick="Btn_addGeoScope_Click" TabIndex="45">ADD GEO SCOPE</asp:LinkButton>
                                                        </div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="Btn_AddGeoScopeDiv_OnEdit" runat="server" visible="false">
                                                            <div class="form-control-sm"></div>
                                                            <asp:HiddenField ID="HiddenField_Btn_addGeoScope_OnEdit" runat="server" Value="" />
                                                            <asp:Label runat="server" CssClass="label labelColor labelColor">&nbsp;</asp:Label>
                                                            <asp:LinkButton class="btn btn-info buttonStyle form-control input-sm" onchange="Btn_addGeoScope_OnEdit()" ID="Btn_addGeoScope_OnEdit" runat="server" Text="ADD GEO SCOPE" UseSubmitBehavior="false" OnClientClick="if (!validateGeoScopesDetails()) {return false;};" OnClick="Btn_addGeoScope_OnEdit_Click" TabIndex="45">ADD GEO SCOPE</asp:LinkButton>
                                                        </div>

                                                        <!--===================================================================End Visible Field on click multiselection on pincode multiselection ===================================-->
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" id="AddDIV" runat="server" visible="false">
                                                <asp:GridView ID="AddGeoScope_DataTable_GridView" runat="server" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton ID="GeoScopeEdit_Data" runat="server" OnClick="GeoScopeEdit_Data_Click" CommandArgument='<%# Eval("geoScopeID")%>' ToolTip="Edit"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                        </td>
                                                                        <td>
                                                                            <asp:LinkButton ID="GeoScopeDelete_Data1" runat="server" OnClick="GeoScopeDelete_Data1_Click" CommandArgument='<%# Eval("geoScopeID")%>' ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Row?');"><i class="fa fa-trash" style="font-size:25px; color:red"></i></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02" HorizontalAlign="Left"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="geoScopeID" HeaderText="ID" Visible="false" />
                                                        <asp:BoundField DataField="materialID" HeaderText="MATERIAL ID" Visible="false" />
                                                        <asp:BoundField DataField="materialName" HeaderText="MATERIAL NAME" />
                                                        <asp:BoundField DataField="packageID" HeaderText="PACK ID" Visible="false" />
                                                        <asp:BoundField DataField="packageName" HeaderText="PACKAGE NAME" />
                                                        <asp:BoundField DataField="category" HeaderText="CATEGORY" />
                                                        <asp:BoundField DataField="scopeType" HeaderText="SCOPE TYPE" />
                                                        <asp:BoundField DataField="from" HeaderText="FROM" />
                                                        <asp:BoundField DataField="to" HeaderText="TO" />
                                                        <asp:BoundField DataField="unitType" HeaderText="UNIT TYPE" />
                                                        <asp:BoundField DataField="unitTypeOn" HeaderText="UNIT TYPE ON" />
                                                        <asp:BoundField DataField="unitValue" HeaderText="UNIT VALUE" />
                                                        <asp:BoundField DataField="fromUnitValue" HeaderText="FROM UNIT VALUE" />
                                                        <asp:BoundField DataField="toUnitValue" HeaderText="TO UNIT VALUE" />
                                                        <asp:BoundField DataField="unitCharges" HeaderText="UNIT CHARGES" />
                                                        <asp:BoundField DataField="extraCharges" HeaderText="EXTRA CHARGES" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>

                                            <div class="form-group" id="AddGeoScopeOnEditDiv" runat="server" visible="false">
                                                <asp:GridView ID="AddGeoScopeOnEditGidView" runat="server" DataKeyNames="geoScopeID" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton ID="GeoScopeEdit_OnEdit" runat="server" OnClick="GeoScopeEdit_OnEdit_Click" CommandArgument='<%# Eval("geoScopeID")%>' ToolTip="Edit"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                        </td>
                                                                        <td>
                                                                            <asp:LinkButton ID="GeoScopeDelete_OnEdit" runat="server" OnClick="GeoScopeDelete_OnEdit_Click" ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Row?');"><i class="fa fa-trash" style="font-size:25px; color:red"></i></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02" HorizontalAlign="Left"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="materialID" HeaderText="MATERIAL ID" Visible="false" />
                                                        <asp:BoundField DataField="materialName" HeaderText="MATERIAL NAME" />
                                                        <asp:BoundField DataField="packID" HeaderText="PACK ID" Visible="false" />
                                                        <asp:BoundField DataField="packageName" HeaderText="PACKAGE NAME" />
                                                        <asp:BoundField DataField="category" HeaderText="CATEGORY" />
                                                        <asp:BoundField DataField="scopeType" HeaderText="SCOPE TYPE" />
                                                        <asp:BoundField DataField="scopeType1" HeaderText="FROM" />
                                                        <asp:BoundField DataField="scopeType2" HeaderText="TO" />
                                                        <asp:BoundField DataField="unitType" HeaderText="UNIT TYPE" />
                                                        <asp:BoundField DataField="unitTypeOn" HeaderText="UNIT TYPE ON" />
                                                        <asp:BoundField DataField="unitValue" HeaderText="UNIT VALUE" />
                                                        <asp:BoundField DataField="unitValueFrom" HeaderText="FROM UNIT VALUE" />
                                                        <asp:BoundField DataField="unitValueTo" HeaderText="TO UNIT VALUE" />
                                                        <asp:BoundField DataField="unitCharges" HeaderText="UNIT CHARGES" />
                                                        <asp:BoundField DataField="extraCharges" HeaderText="EXTRA CHARGES" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>

                                        </div>

                                        <div class="form-group">
                                            <div class="row">

                                                <div class=" col-sm-3 col-md-3 col-lg-4  "></div>

                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>

                                                    <asp:LinkButton ID="Btn_GeoPrev" runat="server" CssClass="btn btn-info  prev-step largeButtonStyle" TabIndex="41"><i class="fa fa-arrow-circle-left"></i>&nbsp;PREV</asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-3 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton runat="server" ID="Button_Submit1" OnClick="Button_Submit1_Click" CssClass="btn btn-info largeButtonStyle Button_Submit1">SUBMIT<i class="fa fa-save"></i></asp:LinkButton>

                                                </div>

                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Btn_ResetGeoScope" runat="server" Value="" />
                                                    <asp:LinkButton CssClass="btn btn-info Btn_ResetGeoScope largeButtonStyle" ID="Btn_ResetGeoScope" onchange="Btn_ResetGeoScope()" runat="server" OnClick="Btn_ResetGeoScope_Click" TabIndex="56">RESET <i class="fa fa-refresh"></i> </asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!---Buttons End--->
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Txt_MaterialName_Search" EventName="TextChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_MaterialName" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Txt_TypeOFPackage_Search" EventName="TextChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_TypeOFPackage" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Ddl_ScopeType" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Txt_ScopeType1_Search" EventName="TextChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_ScopeType1" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Txt_ScopeType2_Search" EventName="TextChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_ScopeType2" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Ddl_UnitType" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Ddl_UnitTypeOn" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_addGeoScope" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_addGeoScope_OnEdit" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_GeoPrev" />
                                    <asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Btn_ResetGeoScope" EventName="Click" />

                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>--%>


                    <!--==============================================View Details=======================================================================-->
                    <div id="View" class="tab-pane">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_View_Search" runat="server">
                                <ContentTemplate>
                                    <div class="panel panelTop" runat="server">
                                        <div class="panel-heading panelView">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class="col-md-2 col-lg-3 "></div>

                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_SearchPartyName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label>
                                                            <asp:TextBox ID="Txt_SearchPartyName" runat="server" CssClass="form-control input-sm" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="51"></asp:TextBox>
                                                            <%-- <asp:DropDownList ID="Ddl_SearchPartyName" runat="server" CssClass="formDisplay" TabIndex="58">
                                                                <asp:ListItem>SELECT</asp:ListItem>
                                                            </asp:DropDownList>--%>
                                                        </div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_SearchStatus" runat="server" CssClass="label labelColor">STATUS</asp:Label>
                                                            <asp:DropDownList ID="Ddl_SearchStatus" runat="server" CssClass="formDisplay" TabIndex="52">
                                                                <asp:ListItem>ACTIVE</asp:ListItem>
                                                                <asp:ListItem>INACTIVE</asp:ListItem>
                                                            </asp:DropDownList>
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
                                                            <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" Value="" />
                                                            <asp:LinkButton ID="Btn_Search" TabIndex="53" onchange="Btn_Search()" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Search" Text="SEARCH" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" style="overflow-x: auto;" id="Search_Contract_Customer_View" runat="server" visible="false">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <div>
                                                        <asp:GridView ID="gridViewContractCustomer" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowPaging="true" OnPageIndexChanging="gridViewContractCustomer_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="ACTION">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="editCustomerContractDetails" runat="server" CommandArgument='<%#Eval("contractId") %>' OnClick="editCustomerContractDetails_Click" ToolTip="Edit"><i style="font-size: 25px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                        <span onclick="return confirm('Are you sure you want to delete this record')">
                                                                        <asp:LinkButton ID="lnkdeleteCustomerContract" runat="server" Visible="false" CommandArgument='<%#Eval("contractNo") %>' OnClick="lnkdeleteCustomerContract_Click" ToolTip="Delete"><i style="font-size: 25px; color:red" class="fa fa-trash"></i></asp:LinkButton> 
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Center" />
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="contractNo" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="CONTRACT NO">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="customerName" HeaderText="BILLING PARTY NAME" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="fromDate" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderText="FROM">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="toDate" HeaderText="TO" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="contractStatus" HeaderText="STATUS" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="signingDate" HeaderText="SIGN DATE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="branchName" HeaderText="CONTROLING BRANCH" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="CFTValue" HeaderText="CFT VALUE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="creditPeriod" HeaderText="CREDIT PERIOD TYPE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="creditPeriodValue" HeaderText="CREDIT PERIOD" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="deliveryType" HeaderText="TYPE OF DELIVERY" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="gracePeriod" HeaderText="GRACE PERIOD" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="demurrageCharges" HeaderText="DEMURRAGE CHARGE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="remark" HeaderText="REMARK" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="minWeight" HeaderText="MIN WEIGHT" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="minimumFreight" HeaderText="MINIMUM FREIGHT" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="waybillCharges" HeaderText="WAYBILL CHARGE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ROVUnit" HeaderText="ROV UNIT" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="value" HeaderText="VALUE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="rovMinimumValue" HeaderText="ROV MINIMUM VALUE" HeaderStyle-Wrap="false" ItemStyle-Wrap="false">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="userName" HeaderText="USER NAME" SortExpression="userName">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                                </asp:BoundField>

                                                            </Columns>

                                                            <HeaderStyle HorizontalAlign="Center" />

                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="printPage">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-10 col-md-10 col-lg-10"></div>
                                                    <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" Text="Export To Excel" TabIndex="61" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                    </div>
                                                    <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="Print" TabIndex="62" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
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
                    <!--==============================================End View=======================================================================-->
                </div>
            </div>
        </div>
    </div>

    <!-- Modal For New Rate Value -->
    <div class="modal" id="NewRateModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW RATE</h4>
                </div>
                <div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel_PopupRateCard">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField runat="server" ID="HiddenField_RadioButtonList_PopupRateType" Value="" />
                                            <asp:Label ID="Lbl_PopupRateType" runat="server" CssClass="label labelColor labelColor">RATE TYPE</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_PopupRateType" runat="server" CssClass="formDisplay Ddl_PopupRateType" TabIndex="14">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupFromWeight" runat="server" class="label labelColor labelColor">FROM WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupFromWeight" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupFromWeight"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupToWeight" runat="server" class="label labelColor labelColor">TO WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupToWeight" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupToWeight"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupFromDistance" runat="server" class="label labelColor labelColor">FROM DISTANCE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupFromDistance" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupFromDistance"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupToDistance" runat="server" class="label labelColor labelColor">TO DISTANCE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupToDistance" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupToDistance"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_RateValue" runat="server" class="label labelColor labelColor">RATE VALUE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_RateValue" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_RateValue"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal footer -->
                            <div class="modal-footer">
                                <div class="form-group">
                                    <div class="row">
                                        <div class=" col-md-2 col-lg-3 "></div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_PopupRateSubmit" runat="server" CssClass="btn btn-info buttonStyle Btn_PopupRateSubmit" UseSubmitBehavior="false" OnClientClick="if (!validateRateCardDetails()) {return false;};" Text="SUBMIT" OnClick="Btn_PopupRateSubmit_Click"></asp:Button><%----%>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_PopupConsignorClose" runat="server" CssClass="btn btn-info buttonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="Btn_PopupRateSubmit" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=========================================================Popup Region============================================================-->
    <!-- Modal -->
    <div class="modal fade" id="Region" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title labelcolor">REGION</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PopRegionName" runat="server" Text="Type" CssClass="label labelColor">Region Name</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_PopRegionName" runat="server" CssClass="form-control input-sm Txt_PopRegionName" onkeypress="return checkNumAlpha(event)"></asp:TextBox>
                            </div>
                            <div class="col-sm-5 col-md-5 col-lg-5 ">
                                <div class="form-control-sm"></div>

                                <asp:Label ID="Lbl_PopViewBy" runat="server" CssClass="label labelColor">View By</asp:Label>
                                <asp:DropDownList ID="Ddl_PopViewBy" runat="server" CssClass="formDisplay Ddl_PopViewBy" OnSelectedIndexChanged="Ddl_PopViewBy_SelectedIndexChanged" AutoPostBack="True">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                    <asp:ListItem>STATE</asp:ListItem>
                                    <asp:ListItem>DISTRICT</asp:ListItem>
                                    <asp:ListItem>LOCATION</asp:ListItem>
                                    <asp:ListItem>BRANCH</asp:ListItem>
                                    <asp:ListItem>PINCODE</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-5 col-md-5 col-lg-5  ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PopViewState" runat="server" CssClass="label labelColor labelColor" Visible="false">View State</asp:Label>
                                <asp:Label ID="Lbl_PopViewDistrict" runat="server" CssClass="label labelColor labelColor" Visible="false">View District</asp:Label>
                                <asp:Label ID="Lbl_PopViewLocation" runat="server" CssClass="label labelColor labelColor" Visible="false">View Location</asp:Label>
                                <asp:Label ID="Lbl_PopViewBranch" runat="server" CssClass="label labelColor labelColor" Visible="false">View Branch</asp:Label>
                                <asp:Label ID="Lbl_PopViewPincode" runat="server" CssClass="label labelColor labelColor" Visible="false">View Pincode</asp:Label>
                                <asp:DropDownList ID="Ddl_PopView" runat="server" Visible="false" CssClass="formDisplay Ddl_PopView">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class=" col-md-2 col-lg-3   "></div>
                        <div class=" col-sm-3 col-md-2 col-lg-2">
                            <div class="form-control-sm"></div>
                            <asp:Button CssClass="btn btn-info Btn_RegionSubmit" ID="Btn_RegionSubmit" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateRegionDetails()) {return false;} else{ __doPostBack('this.name','');};" Text="Submit"></asp:Button>
                        </div>
                        <div class=" col-sm-3 col-md-2 col-lg-2">
                            <div class="form-control-sm"></div>
                            <asp:Button ID="Button2" runat="server" CssClass="btn btn-info " data-dismiss="modal" Text="Close"></asp:Button>
                        </div>
                    </div>
                </div>
                <!--==========================================*Search Region*======================================================================================-->
                <div id="SearchArea" runat="server">
                    <div id="Div4" class="panel panelTop" runat="server">
                        <div class="panel-heading panelHead labelColor" runat="server">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-0 col-lg-1 "></div>

                                    <div class="col-sm-1 col-md-4 col-lg-4 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_SearchArea" runat="server" CssClass="label labelColor">Region Name</asp:Label>
                                        <asp:DropDownList ID="Ddl_SearchArea" runat="server" CssClass="form-control selectpicker" data-live-search="true">
                                            <asp:ListItem>SELECT</asp:ListItem>
                                            <asp:ListItem></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-1 col-md-4 col-lg-4 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_SearchViewBy" runat="server" CssClass="label labelColor">View By</asp:Label>
                                        <asp:DropDownList ID="Ddl_SearchViewBy" runat="server" CssClass="formDisplay">
                                            <asp:ListItem>SELECT</asp:ListItem>
                                            <asp:ListItem>STATE</asp:ListItem>
                                            <asp:ListItem>DISTRICT</asp:ListItem>
                                            <asp:ListItem>LOCATIONS</asp:ListItem>
                                            <asp:ListItem>BRANCHES</asp:ListItem>
                                            <asp:ListItem>PINCODE</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-1 col-md-3 col-lg-4 "></div>
                                    <div class="col-sm-1 col-lg-1 col-md-1">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Button CssClass="btn btn-info" ID="Btn_SearchArea" runat="server" Text="Search"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <div>
                                        <div>
                                            <table class="table table-striped table-hover table-bordered">
                                                <thead style="text-align: center;">
                                                    <tr>
                                                        <th>Region Name</th>
                                                        <th>View By</th>
                                                        <th>Pincode</th>
                                                        <th>State</th>
                                                        <th>District</th>
                                                        <th>Locations</th>
                                                        <th>Branches</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--=========================================================End Region Popup============================================================-->
        </div>
    </div>
    <!---------------------------- Email ID Modal ---------------------------->
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
                            <asp:Button CssClass="btn btn-info " ID="Btn_PopSubmit" runat="server" Text="Submit"></asp:Button>
                        </div>
                        <div class=" col-sm-3 col-md-2 col-lg-2">
                            <div class="form-control-sm"></div>
                            <asp:Button ID="btn_PopClose" runat="server" class="btn btn-info " data-dismiss="modal" Text="Close"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--====================================================End Modal=======================================================================-->
    <!--=====================================Popup Window for New Area Creation====================================================-->
    <!-- small modal -->
    <div class="modal fade" id="AreaModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title labelColor" id="myModalLabel">Area Creation</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                            <div class="col-sm-6 col-md-9 col-lg-9 ">

                                <asp:Label ID="Lbl_PopArea" runat="server" CssClass="label labelColor labelColor">Area Name</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_popArea" runat="server" CssClass="form-control input-sm Txt_popArea" onkeypress="return checkAlpha(event)"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                    <div class=" col-sm-3 col-md-2 col-lg-3">
                        <asp:Button ID="Btn_SubmitArea" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateAreaDetails()) {return false;} else{ __doPostBack('this.name','');};" CssClass="btn btn-info buttonStyle Btn_SubmitArea" Text="Submit"></asp:Button>
                    </div>
                    <div class="col-sm-1 col-md-1 col-lg-1   "></div>
                    <div class="col-sm-3 col-md-2 col-lg-3">
                        <asp:Button ID="Btn_Close" runat="server" CssClass="btn btn-info buttonStyle" Text="Close" data-dismiss="modal"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for New Area Creation====================================================-->

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->

    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="Validation/Contract_CustomerMaster.js"></script>
    <script type="text/javascript">
        function funNumber(a) {
            if (a.value >= 1 && a.value < 13) {
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

    <script>
        //Basic details     
        function Ddl_DeliveryType() {
            $('[id*=HiddenField_Ddl_DeliveryType]').val("1");
            console.log($('[id*=HiddenField_Ddl_DeliveryType]').val());
        }
        function Button_Tab1Save() {
            $('[id*=HiddenField_Button_Tab1Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab1Save]').val());
        }
        function Btn_BasicReset() {
            $('[id*=HiddenField_Btn_BasicReset]').val("1");
            console.log($('[id*=HiddenField_Btn_BasicReset').val());
        }

        function Btn_CommercialReset() {
            $('[id*=HiddenField_Btn_CommercialReset]').val("1");
            console.log($('[id*=HiddenField_Btn_CommercialReset').val());
        }
        //FSC/Quotation Deatils
        function LinkButton_SearchState_Dropdown_Submit() {
            $('[id*=HiddenField_LinkButton_SearchState_Dropdown_Submit]').val("1");
            console.log($('[id*=HiddenField_LinkButton_SearchState_Dropdown_Submit]').val());
        }
        function Txt_State_Search() {
            $('[id*=HiddenField_Txt_State_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_State_Search]').val());
        }
        function select_all_State() {
            $('[id*=HiddenField_select_all_State]').val("1");
            console.log($('[id*=HiddenField_select_all_State]').val());
        }
        function Btn_addquotation() {
            $('[id*=HiddenField_Btn_addquotation]').val("1");
            console.log($('[id*=HiddenField_Btn_addquotation]').val());
        }
        function Btn_OnEditAddQuotation() {
            $('[id*=HiddenField_Btn_OnEditAddQuotation]').val("1");
            console.log($('[id*=HiddenField_Btn_OnEditAddQuotation]').val());
        }
        function Button_Tab3Save() {
            $('[id*=HiddenField_Button_Tab3Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab3Save]').val());
        }
        function Btn_FSCReset() {
            $('[id*=HiddenField_Btn_FSCReset]').val("1");
            console.log($('[id*=HiddenField_Btn_FSCReset]').val());
        }
        // Geo Scope Details
        function Txt_MaterialName_Search() {
            $('[id*=HiddenField_Txt_MaterialName_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_MaterialName_Search]').val());
        }
        function RadioButtonList_MaterialName() {
            $('[id*=HiddenField_RadioButtonList_MaterialName]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_MaterialName]').val());
        }
        function Txt_TypeOFPackage_Search() {
            $('[id*=HiddenField_Txt_TypeOFPackage_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_TypeOFPackage_Search]').val());
        }
        function RadioButtonList_TypeOFPackage() {
            $('[id*=HiddenField_RadioButtonList_TypeOFPackage]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_TypeOFPackage]').val());
        }
        function Txt_ScopeType1_Search() {
            $('[id*=HiddenField_Txt_ScopeType1_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_ScopeType1_Search]').val());
        }
        function RadioButtonList_ScopeType1() {
            $('[id*=HiddenField_RadioButtonList_ScopeType1]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_ScopeType1]').val());
        }
        function Txt_ScopeType2_Search() {
            $('[id*=HiddenField_Txt_ScopeType2_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_ScopeType2_Search]').val());
        }
        function RadioButtonList_ScopeType2() {
            $('[id*=HiddenField_RadioButtonList_ScopeType2]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_ScopeType2]').val());
        }
        function Ddl_ScopeType() {
            $('[id*=HiddenField_Ddl_ScopeType]').val("1");
            console.log($('[id*=HiddenField_Ddl_ScopeType]').val());
        }
        function Ddl_UnitType() {
            $('[id*=HiddenField_Ddl_UnitType]').val("1");
            console.log($('[id*=HiddenField_Ddl_UnitType]').val());
        }
        function Ddl_UnitTypeOn() {
            $('[id*=HiddenField_Ddl_UnitTypeOn]').val("1");
            console.log($('[id*=HiddenField_Ddl_UnitTypeOn]').val());
        }
        function Btn_addGeoScope() {
            $('[id*=HiddenField_Btn_addGeoScope]').val("1");
            console.log($('[id*=HiddenField_Btn_addGeoScope]').val());
        }
        function Btn_addGeoScope_OnEdit() {
            $('[id*=HiddenField_Btn_addGeoScope_OnEdit]').val("1");
            console.log($('[id*=HiddenField_Btn_addGeoScope_OnEdit]').val());
        }
        function Button_Tab4Save() {
            $('[id*=HiddenField_Button_Tab4Save]').val("1");
            console.log($('[id*=HiddenField_Button_Tab4Save]').val());
        }
        function Btn_ResetGeoScope() {
            $('[id*=HiddenField_Btn_ResetGeoScope]').val("1");
            console.log($('[id*=HiddenField_Btn_ResetGeoScope]').val());
        }

        //view Deatils
        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }

        function RadioButtonList_PopupRateType() {
            $('[id*=HiddenField_RadioButtonList_PopupRateType]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_PopupRateType]').val());
        }

    </script>
</asp:Content>

