<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ReverseCustomerCreation.aspx.cs" Inherits="ReverseCustomerCreation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_ReverseCustomer" AssociatedUpdatePanelID="UpdatePanel_ReverseCustomer" runat="server" DisplayAfter="0">
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
     <div id="LoadingImage" runat="server" style="display: none">
                <div id="overlay">
                    <div id="modalprogress">
                        <div id="theprogress">
                            <img src="images/dots-4.gif" />
                        </div>
                    </div>
                </div>
            </div>

    <div id="AlertNotification"></div>

    <div class="panel panelTop">
        <asp:UpdatePanel ID="UpdatePanel_ReverseCustomer" runat="server">
            <ContentTemplate>

                <div class="panel-heading panelHead">
                    <b>REVERSE CUSTOMER CREATION</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignor" runat="server" NavigateUrl="~/ReportData.aspx?value=Customers" Target="_blank">List</asp:HyperLink>
                                    <asp:HiddenField ID="hfCustID" runat="server" />
                                    <asp:TextBox ID="Txt_CCustName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="1" CssClass="form-control input-sm Txt_CCustName" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_CCustName','hfCustID','Ddl_CustArea','ReverseCustomerCreation.aspx/getCustName');"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustMobileNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label>
                                    <asp:TextBox ID="Txt_CustMobileNo" runat="server" Style="text-transform: uppercase;" TabIndex="9" ReadOnly="true" CssClass="form-control input-sm Txt_CustMobileNo FirstNoSpaceAndZero"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustPin" runat="server" CssClass="label labelColor">CONSIGNOR PINCODE</asp:Label>
                                    <asp:TextBox ID="Txt_CustPin" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustPin" ReadOnly="true"></asp:TextBox>
                                    <asp:HiddenField ID="hfCustPinID" runat="server" />
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustArea" runat="server" CssClass="label labelColor">CONSIGNOR AREA</asp:Label>
                                    <asp:DropDownList ID="Ddl_CustArea" runat="server" CssClass="formDisplay input-sm Ddl_CustArea" Enabled="false">
                                        <asp:ListItem>SELECT</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustAdd" runat="server" CssClass="label labelColor">CONSIGNOR ADDRESS</asp:Label>
                                    <asp:TextBox ID="Txt_CustAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustAdd" ReadOnly="true" TextMode="MultiLine"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_BranchName" runat="server" CssClass="label labelColor">BRANCH</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_BranchName" runat="server" CssClass="formDisplay input-sm Ddl_BranchName" TabIndex="2">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class=" col-sm-3 col-md-3 col-lg-5"></div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                     <asp:HiddenField ID="hfSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="3" UseSubmitBehavior="false" OnClientClick="if (!validateReverseCustomer()) {return false;};" CssClass="btn btn-info largeButtonStyle">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>                               
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>


    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="FJS_File/PickupRequestCRMBranch.js"></script>
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

