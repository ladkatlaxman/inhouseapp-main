<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ReverseCustomer.aspx.cs" Inherits="ReverseCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-5 col-xl-4">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignor" runat="server" NavigateUrl="~/ReportData.aspx?value=Customers" Target="_blank">List</asp:HyperLink>
                                    <asp:HiddenField ID="hfCustID" runat="server" />
                                    <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCustomer_SelectedIndexChanged" CssClass="formDisplay input-sm ddlCustomer"></asp:DropDownList>
                                    <asp:TextBox ID="Txt_CCustName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" TabIndex="1" CssClass="form-control input-sm Txt_CCustName" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_CCustName','hfCustID','Ddl_CustArea','ReverseCustomerCreation.aspx/getCustName');" Visible="false"></asp:TextBox> 
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustMobileNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label>
                                    <asp:TextBox ID="Txt_CustMobileNo" runat="server" Style="text-transform: uppercase;" TabIndex="9" ReadOnly="true" CssClass="form-control input-sm Txt_CustMobileNo FirstNoSpaceAndZero"></asp:TextBox>
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustPin" runat="server" CssClass="label labelColor">CONSIGNOR PINCODE</asp:Label>
                                    <asp:TextBox ID="Txt_CustPin" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustPin" ReadOnly="true"></asp:TextBox>
                                    <asp:HiddenField ID="hfCustPinID" runat="server" />
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustArea" runat="server" CssClass="label labelColor">CONSIGNOR AREA</asp:Label>
                                    <asp:HiddenField ID="hfAreaId" runat="server" />
                                    <asp:TextBox ID="txtArea" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtArea" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_CustAdd" runat="server" CssClass="label labelColor">CONSIGNOR ADDRESS</asp:Label>
                                    <asp:TextBox ID="Txt_CustAdd" runat="server" Style="text-transform: uppercase;" Height="140" CssClass="form-control input-sm Txt_CustAdd" ReadOnly="true" TextMode="MultiLine"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_BranchName" runat="server" CssClass="label labelColor">BRANCH</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_BranchName" runat="server" CssClass="formDisplay input-sm Ddl_BranchName" TabIndex="2">
                                    </asp:DropDownList>
                                    <div class="form-control-sm"></div>
                                    <asp:HiddenField ID="hfSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="3" CssClass="btn btn-info largeButtonStyle" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>                               
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class=" col-sm-3 col-md-3 col-lg-5"></div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-5 col-xl-4">
                                    <asp:GridView runat="server" ID="gvBranch" CssClass="table table-condensed table-bordered table-hover table-responsive"></asp:GridView> 
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

