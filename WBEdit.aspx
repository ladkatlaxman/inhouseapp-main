<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WBEdit.aspx.cs" Inherits="WBEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                    <b>WAYBILL EDIT</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label5" runat="server" CssClass="label labelColor">WAYBILL NO : </asp:Label><span class="required">*</span>
                                    <asp:HiddenField ID="hfWayBillId" runat="server" />
                                    <asp:TextBox ID="Txt_WayBillNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_WayBillNo" ></asp:TextBox> 
                                </div>
                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                    <div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div>
                                    <asp:LinkButton ID="lnkEditData" runat="server" ToolTip="Edit Data" OnClick="lnkEditData_Click"><i style="font-size: 20px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="lblCustomerName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label>
                                    <asp:TextBox ID="Txt_CustName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_CCustName" onkeypress="return checkNumAlpha()" Enabled="false"></asp:TextBox> 
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor">WAYBILL DATE : </asp:Label>
                                    <asp:TextBox ID="txtWayBillDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_WayBillDate" Enabled="false" ></asp:TextBox> 
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor">CONSIGNEE NAME</asp:Label>
                                    <asp:TextBox ID="txtConsigneeName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_CCustName" onkeypress="return checkNumAlpha()"></asp:TextBox> 
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <asp:LinkButton ID="btnConsigneeUpdate" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateReverseCustomer()) {return false;};" CssClass="btn btn-info largeButtonStyle">UPDATE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label3" runat="server" CssClass="label labelColor">PIN CODE : </asp:Label>
                                    <asp:TextBox ID="txtPINCode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtPINCode" Enabled="false" ></asp:TextBox> 
                                </div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label6" runat="server" CssClass="label labelColor">ADDRESS</asp:Label>
                                    <asp:TextBox ID="txtAddress" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_CCustName" onkeypress="return checkNumAlpha()"></asp:TextBox> 
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label4" runat="server" CssClass="label labelColor">AREA</asp:Label> 
                                    <asp:HiddenField ID="hfAreaId" runat="server" />
                                    <asp:TextBox ID="txtArea" runat="server" Style="text-transform: uppercase;" Enabled="false" CssClass="form-control input-sm txtArea"></asp:TextBox> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-heading panelHead">
                    <b>MATERIAL DETAILS</b>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-5 col-xl-4">
                            <p>
                            <asp:GridView runat="server" ID="gvmaterial" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:BoundField DataField="WayBillItemId" HeaderText="WayBill Item Id" />
                                    <asp:BoundField DataField="materialName" HeaderText="Material" />
                                    <asp:BoundField DataField="typeOfPackage" HeaderText="Package" />
                                    <asp:BoundField DataField="valueChargedWt" HeaderText="Charged Wt" />
                                    <asp:BoundField DataField="valueActualWt" HeaderText="Actual Wt" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtActualWt" Text='<%#Eval("valueActualWt")%>' runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="itemQty" HeaderText="Qty" />                                    
                                </Columns>
                            </asp:GridView> 
                            </p>
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

