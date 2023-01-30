<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="GetEWB.aspx.cs" Inherits="GetEWB" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
        <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div>
     <div id="AlertNotification"></div>
    <div class="panel panelTop">
        <div class="panel-heading panelHead">
            <b>CHANGE PASSWORD</b>
        </div>

        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>

                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_EmpCurrentPassword" runat="server" CssClass="label labelColor">EWB No</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="txtEWBNo" AutoComplete="off" runat="server" TabIndex="1" class="form-control input-sm Txt_EmpCurrentPassword"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>

                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_EmpChangePassword" runat="server" CssClass="label labelColor">EWB Details</asp:Label><span class="required">*</span> 
                            <asp:TextBox ID="txtEWMDetails" runat="server" TextMode="MultiLine" Rows="10" Columns="40"></asp:TextBox> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>

                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblItems" runat="server" CssClass="label labelColor">Item Details</asp:Label><span class="required">*</span> 
                            <asp:TextBox ID="txtItems" runat="server" TextMode="MultiLine" Rows="10" Columns="40"></asp:TextBox> 
                        </div>
                    </div>                </div>
                <div class="form-group">
                    <div class="row">
                        <div class=" col-sm-1 col-md-3 col-lg-4"></div>

                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="Btn_Submit" TabIndex="4" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateChangePassword()) {return false;};" OnClick="Btn_Submit_Click" class="btn btn-info largeButtonStyle" Text="SAVE">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>

                        </div>

                        <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-sm"></div>
                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" TabIndex="5" ID="Btn_Reset" runat="server" OnClick="Btn_Reset_Click" Text="RESET">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                        </div>

                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

