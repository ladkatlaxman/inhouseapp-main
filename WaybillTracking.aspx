<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WaybillTracking.aspx.cs" Inherits="WaybillTracking" %>

<%@ Register Src="~/WaybillTrackingControl.ascx" TagName="WaybillTrackingControl" TagPrefix="UserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="AlertNotification"></div>

    <div id="MultipleTrackingDetails" runat="server">
           <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                    <asp:TextBox ID="txtWayBillNo" runat="server" Style="text-transform: uppercase" AutoCompleteType="Disabled" CssClass="form-control input-sm txtWayBillNo"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click">SEARCH</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
       <%-- <UserControl:WaybillTrackingControl ID="Tracking1" runat="server" Visible="false" />
        <UserControl:WaybillTrackingControl ID="Tracking2" runat="server" Visible="false" />
        <UserControl:WaybillTrackingControl ID="Tracking3" runat="server" Visible="false" />
        <UserControl:WaybillTrackingControl ID="Tracking4" runat="server" Visible="false" />
        <UserControl:WaybillTrackingControl ID="Tracking5" runat="server" Visible="false" />--%>
    </div>

    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

