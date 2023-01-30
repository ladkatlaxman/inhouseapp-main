<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PickUpRequest.aspx.cs" Inherits="PickUpRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Pickup_Manifest" AssociatedUpdatePanelID="UpdatePanel_Pickup_Manifest" runat="server" DisplayAfter="0">
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
                <li class="active">
                    <a data-toggle="tab" href="#home" class="target-tab-link">PICKUP REQUEST</a>
                </li>
                <li class="disabled">
                    <a data-toggle="tab" href="#View_Tab">VIEW</a>
                </li>
            </ul>

            <!-- Tab panes -->

            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--==============================================Pickup Request Information=======================================================================-->
                <div id="home" class="tab-pane fade in active">
                    <div id="MainCustomer" runat="server">

                        <asp:UpdatePanel ID="UpdatePanel_Pickup_Manifest" runat="server">
                            <ContentTemplate>
                                <div class="panel panelTop">
                                    <div class="panel-heading panelHead">
                                        <b>PICKUP REQUEST</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustCode" runat="server" CssClass="label labelColor">CUSTOMER CODE</asp:Label>
                                                        <asp:TextBox ID="Txt_CustCode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustCode"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickupType" runat="server" CssClass="label labelColor">PICKUP TYPE</asp:Label>
                                                        <asp:DropDownList ID="Ddl_PickType" runat="server" CssClass="formDisplay input-sm Ddl_PickType">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>LOCAL</asp:ListItem>
                                                            <asp:ListItem>GODOWN</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickUpDate" runat="server" CssClass="label labelColor">PICKUP DATE</asp:Label>
                                                        <asp:TextBox ID="Txt_PickUpDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PickUpDate" TextMode="Date"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label>
                                                        <asp:TextBox ID="Txt_CustName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustName"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustMobileNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label>
                                                        <asp:TextBox ID="Txt_CustMobileNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustMobileNo"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustTelephoneNo" runat="server" CssClass="label labelColor">TELEPHONE NO</asp:Label>
                                                        <asp:TextBox ID="Txt_CustTelephoneNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustTelephoneNo"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_EmailId" runat="server" CssClass="label labelColor">EMAILID</asp:Label>
                                                        <asp:TextBox ID="Txt_EmailId" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_EmailId"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustPin" runat="server" CssClass="label labelColor">CUSTOMER PINCODE</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_CustPin" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_CustPin"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender1" runat="server" Enabled="true" TargetControlID="Txt_CustPin"
                                                            PopupControlID="Panel_CustPin" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_CustPin" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_CustPin" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return validateNumericValue(event)" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_CustPin" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustArea" runat="server" CssClass="label labelColor">CUSTOMER AREA</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_CustArea" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_CustArea"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender2" runat="server" Enabled="true" TargetControlID="Txt_CustArea"
                                                            PopupControlID="Panel_CustArea" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_CustArea" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_CustArea" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return onlyAlphaValue()" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_CustArea" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustAdd" runat="server" CssClass="label labelColor">CUSTOMER ADDRESS</asp:Label>
                                                        <asp:TextBox ID="Txt_CustAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustAdd" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <asp:CheckBox ID="SameAdd" runat="server" />Same as Customer Address<br />
                                                        <asp:Label ID="Lbl_PickPin" runat="server" CssClass="label labelColor">PICKUP PINCODE</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_PickPin" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_PickPin"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender3" runat="server" Enabled="true" TargetControlID="Txt_PickPin"
                                                            PopupControlID="Panel_PickPin" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_PickPin" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_PickPin" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return validateNumericValue(event)" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_PickPin" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickArea" runat="server" CssClass="label labelColor">PICKUP AREA</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_PickArea" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_PickArea"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender4" runat="server" Enabled="true" TargetControlID="Txt_PickArea"
                                                            PopupControlID="Panel_PickArea" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_PickArea" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_PickArea" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return onlyAlphaValue()" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_PickArea" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickAdd" runat="server" CssClass="label labelColor">PICKUP ADDRESS</asp:Label>
                                                        <asp:TextBox ID="Txt_PickAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PickAdd" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_ConsigneeName" runat="server" CssClass="label labelColor">CONSIGNEE NAME</asp:Label>
                                                        <asp:TextBox ID="Txt_ConsigneeName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_ConsigneeName"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_ConsigneeContNo" runat="server" CssClass="label labelColor">CONSIGNEE CONTACT NO</asp:Label>
                                                        <asp:TextBox ID="Txt_ConsigneeContNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_ConsigneeContNo"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_DelPin" runat="server" CssClass="label labelColor">DELIVERY PINCODE</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_DelPin" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_DelPin"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender5" runat="server" Enabled="true" TargetControlID="Txt_DelPin"
                                                            PopupControlID="Panel_DelPin" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_DelPin" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_DelPin" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return validateNumericValue(event)" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_DelPin" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_DelArea" runat="server" CssClass="label labelColor">DELIVERY AREA</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_DelArea" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_DelArea"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender6" runat="server" Enabled="true" TargetControlID="Txt_DelArea"
                                                            PopupControlID="Panel_DelArea" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_DelArea" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_DelArea" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return onlyAlphaValue()" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_DelArea" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_DelAdd" runat="server" CssClass="label labelColor">DELIVERY ADDRESS</asp:Label>
                                                        <asp:TextBox ID="Txt_DelAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_DelAdd" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-control-sm"></div>
                                    <div class="panel-heading panelHead">
                                        <b>MATERIAL DETAIL</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_MaterialType" runat="server" CssClass="label labelColor">MATERIAL TYPE</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_MaterialType" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_MaterialType"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender7" runat="server" Enabled="true" TargetControlID="Txt_MaterialType"
                                                            PopupControlID="Panel_MaterialType" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_MaterialType" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_MaterialType" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return onlyAlphaValue()" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_MaterialType" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>

                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label>
                                                        <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                        <asp:TextBox ID="Txt_PackageType" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" CssClass="form-control Txt_PackageType"></asp:TextBox>
                                                        <ajaxToolkit:PopupControlExtender ID="PopupControlExtender8" runat="server" Enabled="true" TargetControlID="Txt_PackageType"
                                                            PopupControlID="Panel_PackageType" OffsetY="38" OffsetX="-2">
                                                        </ajaxToolkit:PopupControlExtender>
                                                        <asp:Panel ID="Panel_PackageType" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                                            BackColor="#ffffff" Style="display: none;">
                                                            <div runat="server" class="ddlSearchTextBoxInherit">
                                                                <asp:TextBox ID="Txt_Search_PackageType" runat="server" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero"
                                                                    AutoCompleteType="Disabled" AutoPostBack="true" onkeypress="return onlyAlphaValue()" Style="text-transform: uppercase;">
                                                                </asp:TextBox>
                                                            </div>
                                                            <div runat="server" class="ddlDropDownListInherit">
                                                                <asp:RadioButtonList ID="RadioButtonList_PackageType" runat="server">
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>

                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Length" runat="server" CssClass="label labelColor">LENGTH</asp:Label>
                                                        <asp:TextBox ID="Txt_Length" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Length"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Breadth" runat="server" CssClass="label labelColor">BREADTH</asp:Label>
                                                        <asp:TextBox ID="Txt_Breadth" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Breadth"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Height" runat="server" CssClass="label labelColor">HEIGHT</asp:Label>
                                                        <asp:TextBox ID="Txt_Height" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Height"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Unit" runat="server" CssClass="label labelColor">UNIT</asp:Label>
                                                        <asp:DropDownList ID="Ddl_Unit" runat="server" CssClass="formDisplay Ddl_Unit">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>CM</asp:ListItem>
                                                            <asp:ListItem>METER</asp:ListItem>
                                                            <asp:ListItem>INCH</asp:ListItem>
                                                            <asp:ListItem>KG</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Weight" runat="server" CssClass="label labelColor">WEIGHT</asp:Label>
                                                        <asp:TextBox ID="Txt_Weight" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Weight"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-4 col-md-4 col-lg-1 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_NoOfPackages" runat="server" CssClass="label labelColor">NO.OF PACKAGE</asp:Label>
                                                        <asp:TextBox ID="Txt_NoOfPackage" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_NoOfPackage"></asp:TextBox>
                                                    </div>

                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>

                                                        <asp:LinkButton ID="Btn_Add" runat="server" CssClass="btn btn-info largeButtonStyle">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Button_Submit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_Reset" runat="server" CssClass="btn btn-info largeButtonStyle">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                            </div>
                                        </div>
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
    </div>
</asp:Content>

