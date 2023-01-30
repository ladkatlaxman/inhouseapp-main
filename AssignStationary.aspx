<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="AssignStationary.aspx.cs" Inherits="AssignStationary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_AssignStationary" AssociatedUpdatePanelID="UpdatePanel_AssignStationary" runat="server" DisplayAfter="0">
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
        <div id="AlertNotification"></div>
        <asp:UpdatePanel ID="UpdatePanel_AssignStationary" runat="server">
            <ContentTemplate>
                <div class="panel panelTop">
                    <div class="panel-heading panelHead">
                        <b>ASSIGN STATIONAY</b>
                    </div>
                    <div class="panel-body labelColor">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_Stationary" runat="server" CssClass="label labelColor">STATIONARY LIST</asp:Label><span class="required">*</span>
                                        <asp:DropDownList ID="Ddl_Stationary" runat="server" TabIndex="1" CssClass="formDisplay input-sm Ddl_Stationary">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_AssignBranch" runat="server" CssClass="label labelColor">BRANCH</asp:Label><span class="required">*</span>
                                        <asp:DropDownList ID="Ddl_AssignBranch" runat="server" TabIndex="2" CssClass="formDisplay input-sm Ddl_AssignBranch">
                                        </asp:DropDownList>
                                    </div>
                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                        <div class="form-control-sm"></div>
                                         <div class="form-control-sm"></div>
                                         <div class="form-control-lg"></div>
                                        <asp:LinkButton ID="Button_Assign" runat="server" CssClass="btn btn-info Button_Assign largeButtonStyle" TabIndex="3" UseSubmitBehavior="false" OnClientClick="if (!validateStationary()) {return false;};" OnClick="Button_Assign_Click">ASSIGN</asp:LinkButton>
                                    </div>
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
    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
</asp:Content>

