<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ConsigneeDetailsUpdate.aspx.cs" Inherits="ConsigneeDetailsUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_ConsigneeDetails" AssociatedUpdatePanelID="UpdatePanel_ConsigneeDetails" runat="server" DisplayAfter="0">
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

    <div id="AlertNotification"></div>

    <div class="panel panelTop">
        <asp:UpdatePanel ID="UpdatePanel_ConsigneeDetails" runat="server">
            <ContentTemplate>

                <div class="panel-heading panelHead">
                    <b>CONSIGNEE DETAILS UPDATE</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_ConsigneeName" runat="server" CssClass="label labelColor">CONSIGNEE NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignee" runat="server" NavigateUrl="~/ReportData.aspx?value=Consignee" Target="_blank">List</asp:HyperLink>
                                    <asp:TextBox ID="Txt_ConsigneeName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="1" CssClass="form-control input-sm Txt_ConsigneeName" onchange="ReadDataonchange('Txt_ConsigneeName','hfConsigneeID','Ddl_DelArea','PickReqCRMBranch.aspx/getConsigneeName');"></asp:TextBox>
                                    <asp:HiddenField ID="hfConsigneeID" runat="server" />
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_ConsigneeContNo" runat="server" CssClass="label labelColor">CONSIGNEE CONTACT NO</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_ConsigneeContNo" runat="server" Style="text-transform: uppercase;" TabIndex="2" onkeypress="return validateNumericValue(event)" MaxLength="10" CssClass="form-control input-sm Txt_ConsigneeContNo"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_DelPin" runat="server" CssClass="label labelColor">CONSIGNEE PINCODE</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_DelPin" runat="server" Style="text-transform: uppercase;" TabIndex="3" CssClass="form-control input-sm Txt_DelPin" MaxLength="6" onchange="ReadDataonchange('Txt_DelPin','hfDelPinID','Ddl_DelArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                    <asp:HiddenField ID="hfDelPinID" runat="server" />
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_DelArea" runat="server" CssClass="label labelColor">CONSIGNEE AREA</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_DelArea" runat="server" TabIndex="4" CssClass="formDisplay input-sm Ddl_DelArea">
                                        <asp:ListItem>SELECT</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_DelAdd" runat="server" CssClass="label labelColor">CONSIGNEE ADDRESS</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_DelAdd" runat="server" Style="text-transform: uppercase;" TabIndex="5" CssClass="form-control input-sm Txt_DelAdd" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                     <asp:HiddenField ID="hfSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="6" CssClass="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateConsigneeDetails()) {return false;};">UPDATE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="7" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
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

