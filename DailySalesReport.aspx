<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="DailySalesReport.aspx.cs" Inherits="DailySalesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>REPORT DETAILS</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <asp:Repeater runat="server" id="rptClient">

                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

