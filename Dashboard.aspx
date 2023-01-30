<%@ Page Title="Dash Board" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <p>
            <strong style="font-size: xx-large">WELCOME TO DEXTERS!!! </strong>
            <br />
        </p>
    </div>
    <div>
        <div class="row">
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                <asp:Label ID="lblEmployeeDetails" runat="server" Font-Bold="true"></asp:Label>
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                <asp:Label ID="lblBranch" runat="server" Font-Bold="true"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                <div class="form-control-lg"></div>
                <asp:Label ID="lblBelongTo" runat="server" Text="Belong To Branches: "></asp:Label>
                <asp:DropDownList ID="lstBranch" runat="server" CssClass="formDisplay input-sm"></asp:DropDownList>
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <asp:Button ID="setBranch" runat="server" Text="Set Branch" OnClick="setBranch_Click" CssClass="btn largeButtonStyle" />
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <asp:Button ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Logout" Width="92px" CssClass="btn largeButtonStyle" />
            </div>
        </div>
        <div class="row">
            <div class="form-control-lg"></div>
        </div>
        <div class="row">
            <div class="form-control-lg"></div>
            <div class="form-control-lg"></div>
            <div class="form-control-lg"></div>
            <asp:GridView ID="gdDash" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="sBranch" HeaderText="Branch" />
                    <asp:BoundField DataField="Range" HeaderText="Range" />
                    <asp:BoundField DataField="ChargedWeight" HeaderText="Weight" />
                    <asp:BoundField DataField="Freight" HeaderText="Freight" />
                </Columns>
            </asp:GridView>
        </div>
        <div class="row">
            <div class="form-control-lg"></div>
        </div>
        <div class="row">
            <div class="form-control-lg"></div>
            <div class="form-control-lg"></div>
            <div class="form-control-lg"></div>
            <asp:GridView ID="gvVehicles" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="true"></asp:GridView>
        </div>
    </div>
</asp:Content>