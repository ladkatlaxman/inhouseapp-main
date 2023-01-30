<%@ Page Title="Walkin Freight Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Walkin_Freight_Master.aspx.cs" Inherits="OPERATIONS_Walkin_Freight" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_PopupRateCard" AssociatedUpdatePanelID="UpdatePanel_PopupRateCard" runat="server" DisplayAfter="0">
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
    <!--=======================================================================Walkin Freight Details==============================================================================================-->
    <div class="panel panelTop">
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div>
                    <asp:LinkButton CssClass="btn btn-info largeButtonStyle2" ID="Btn_AddNewCharge" runat="server" data-toggle="modal" data-target="#NewRateModal" Text="">ADD NEW CHARGE</asp:LinkButton>
                    <br />
                    <br />
                    <asp:GridView runat="server" ID="gridView" CssClass="table table-condensed table-bordered table-hover table-responsive" OnRowDataBound="gridView_RowDataBound" OnRowCreated="gridView_RowCreated"/>
                    <br />
                    <br />
                </div>
            </div>
        </div>
    </div>

    <!--------------------------------------------------------------------------Walkin First Tab End---------------------------------------------------------------------->


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
                                            <asp:Button ID="Btn_PopupRateSubmit" runat="server" CssClass="btn btn-info buttonStyle Btn_PopupRateSubmit" Text="SUBMIT" OnClick="Btn_PopupRateSubmit_Click"></asp:Button><%--UseSubmitBehavior="false" OnClientClick="if (!validateRateCardDetails()) {return false;};"--%>
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



    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--Footer End-->

    <script src="js/AlertNotifictaion.js"></script>
  
</asp:Content>

