<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="BayMaster.aspx.cs" Inherits="BayMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_BayMaster" AssociatedUpdatePanelID="UpdatePanel_BayMaster" runat="server" DisplayAfter="0">
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
        <asp:UpdatePanel ID="UpdatePanel_BayMaster" runat="server">
            <ContentTemplate>

                <div class="panel-heading panelHead">
                    <b>BAY MASTER</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                               
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_BayName" runat="server" CssClass="label labelColor">BAY NAME</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_BayName" runat="server" Style="text-transform: uppercase;" TabIndex="1" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_BayName"></asp:TextBox>
                                </div>
                                <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 col-xl-9">
                                    <div class="form-control-sm"></div>
                                    <div class="row">
                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                             <div class="form-control-sm"></div>
                                             <div class="form-control-sm"></div>
                                             <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_BayCapacity" runat="server" CssClass="label labelColor">BAY CAPACITY</asp:Label><span class="required">*</span>
                                        </div>
                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <asp:Label ID="Lbl_Qty" runat="server" CssClass="label labelColor">QTY (NO.OF PIECES)</asp:Label>
                                            <asp:TextBox ID="Txt_Qty" runat="server" CssClass="form-control input-sm Txt_Qty NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="2"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                                                 
                                            <asp:Label ID="Lbl_Weight" runat="server" CssClass="label labelColor">WEIGHT</asp:Label>
                                            <asp:TextBox ID="Txt_Weight" runat="server" CssClass="form-control input-sm Txt_Weight NoFirstSpaceZeroAndDot" AutoCompleteType="Disabled" TabIndex="3"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">   
                                           <asp:Label ID="Lbl_UOM" runat="server" CssClass="label labelColor">UOM</asp:Label>
                                            <asp:DropDownList ID="Ddl_Unit" runat="server" CssClass="formDisplay Ddl_Unit" TabIndex="4">
                                                <asp:ListItem Selected="True">KG</asp:ListItem>
                                                <asp:ListItem>TON</asp:ListItem>
                                            </asp:DropDownList>
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
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="5" CssClass="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateWaybillRemark()) {return false;};" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="6" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
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
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>

</asp:Content>

