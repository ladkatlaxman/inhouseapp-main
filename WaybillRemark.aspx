<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WaybillRemark.aspx.cs" Inherits="WaybillRemark" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_WaybillRemark" AssociatedUpdatePanelID="UpdatePanel_WaybillRemark" runat="server" DisplayAfter="0">
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
        <asp:UpdatePanel ID="UpdatePanel_WaybillRemark" runat="server">
            <ContentTemplate>

                <div class="panel-heading panelHead">
                    <b>WAYBILL REMARK</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">  
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3"></div>                              
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                     <div class="form-control-sm"></div>
                                      <asp:Label ID="lbl_SearchWaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                    <asp:TextBox ID="Txt_SearchWaybillNo" runat="server" onkeypress="return validateNumericValue(event)" MaxLength="7" TabIndex="1" CssClass="form-control input-sm Txt_SearchWaybillNo FirstNoSpaceAndZero" onchange="ReadDataonchange('Txt_SearchWaybillNo', 'hfWaybillID','', 'ReverseWaybill.aspx/getWayBillNo');"></asp:TextBox>
                                    <asp:HiddenField ID="hfWaybillID" runat="server" />
                                </div>                                
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_Remark" runat="server" Style="text-transform: uppercase;" TabIndex="2" AutoCompleteType="Disabled" TextMode="MultiLine" CssClass="form-control input-sm Txt_Remark"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    
                        <div class="form-group">
                            <div class="row">
                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="3" CssClass="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateWaybillRemark()) {return false;};" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="4" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
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

