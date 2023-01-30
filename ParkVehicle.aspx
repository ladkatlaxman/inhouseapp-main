<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ParkVehicle.aspx.cs" Inherits="ParkVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>TRACKO VEHICLE RESULT</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" id="SearchingParam" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Lbl_SearchCustName" runat="server" CssClass="label labelColor">VEHICLE NUMBER</asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:TextBox ID="txtVehicleNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtVehicleNo"></asp:TextBox>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnGetResult" Text="Get Vehicle Tracking" runat="server" OnClick="btnGetResult_Click"/> 
                    </div>
                </div>
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:TextBox runat="server" ID="txtResult" TextMode="MultiLine" Columns="150" Rows="30">
                    </asp:TextBox>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

