<%@ Page Title="Area Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="AreaMaster.aspx.cs" Inherits="AreaMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
    <link rel="shortcut icon" href="images/dexterLogo.png" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress_Area" AssociatedUpdatePanelID="UpdatePanel_Area" runat="server" DisplayAfter="0">
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
    <div class="panel panelTop">
        <div class="panel-heading panelHead">
            <b>AREA CREATION</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel_Area" runat="server">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <asp:Label ID="Lbl_Pincode" runat="server" CssClass="label labelColor">PINCODE</asp:Label><span class="required">*</span>
                                        <asp:TextBox ID="Txt_Pincode" runat="server" CssClass="form-control input-sm Txt_Pincode" MaxLength="6" TabIndex="6" onchange="ReadDataonchange('Txt_Pincode','hfPincode','Ddl_Area','Party_CustomerCreation.aspx/getPincode');"></asp:TextBox>
                                        <asp:HiddenField ID="hfPincode" runat="server" />
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <asp:Label ID="Lbl_State" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                        <asp:TextBox ID="Txt_State" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_State" Text="Auto" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <asp:Label ID="Lbl_District" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                        <asp:TextBox ID="Txt_District" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_District" Text="Auto" ReadOnly="true"></asp:TextBox>
                                    </div>

                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <asp:Label ID="Lbl_City" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                        <asp:TextBox ID="Txt_City" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_City" Text="Auto" ReadOnly="true"></asp:TextBox>
                                    </div>
                                   <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor">EXISTING AREA</asp:Label>
                                        <asp:DropDownList ID="Ddl_Area" runat="server" CssClass="formDisplay input-sm Ddl_Area" TabIndex="7">
                                            <asp:ListItem>SELECT</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:HiddenField ID="hfArea" runat="server" />
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <asp:Label ID="Lbl_Area" runat="server" CssClass="label labelColor">AREA</asp:Label><span class="required">*</span>
                                        <asp:TextBox ID="Txt_Area" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Area FirstNoSpaceAndZero" TabIndex="9"></asp:TextBox>
                                    </div>                                                                  
                                </div>
                            </div>                    

                            <!---Buttons --->
                            <div class="form-group">
                                <div class="row">
                                    <div class=" col-sm-3 col-md-3 col-lg-4  "></div>
                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                        <div class="form-control-sm"></div>
                                        <asp:LinkButton ID="Btn_Submit" runat="server" CssClass="btn btn-info Btn_Submit largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!ValidateAreaMaster()) {return false;};" OnClick="Btn_Submit_Click" TabIndex="17">SUBMIT&nbsp;<i class="fa fa-save "></i></asp:LinkButton>
                                    </div>
                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                        <div class="form-control-sm"></div>
                                        <asp:LinkButton ID="Btn_Reset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click" TabIndex="19">RESET&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                    </div>                              
                                </div>
                            </div>

                            <!---Buttons End--->

                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Btn_Reset" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <script src="Validation/Val_DieselRate.js"></script>
    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

