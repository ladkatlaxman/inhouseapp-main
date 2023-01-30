<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WaybillPrint.aspx.cs" Inherits="WaybillPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="AlertNotification"></div>
    <div id="MultipleTrackingDetails" runat="server">
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div> 
                            <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label> 
                            <asp:TextBox ID="txtWayBillNo" runat="server" Style="text-transform: uppercase" AutoCompleteType="Disabled" CssClass="form-control input-sm txtWayBillNo" EnableViewState="true"></asp:TextBox> 
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblEMail" runat="server" CssClass="label labelColor">EMAIL ID </asp:Label>
                            <asp:TextBox ID="txtEmailId" runat="server" Style="text-transform: uppercase" AutoCompleteType="Disabled" CssClass="form-control input-sm txtWayBillNo" Text="ithead@dexters.co.in" EnableViewState="true"></asp:TextBox> 
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="Btn_Print" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Print_Click">PRINT</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="lnkSendEmail" runat="server" CssClass="btn btn-info largeButtonStyle lnkSendEmail" OnClick="lnkSendEmail_Click">EMAIL</asp:LinkButton>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                        <div class="form-control-lg"></div>
                        <asp:Label ID="lblError" runat="server" CssClass="label label-danger"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

