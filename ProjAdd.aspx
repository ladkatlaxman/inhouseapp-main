<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ProjAdd.aspx.cs" Inherits="ProjAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b><!-- ADD PROJECT DETAILS --> 
                <asp:Label ID="lblHeading" runat="server"></asp:Label>
            </b>
        </div>

        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" runat="server" style="color">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div>
                        <asp:Label ID="Label10" runat="server" CssClass="label labelColor">ADD PROJECT DETAILS : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div>
                        <asp:Label ID="Label11" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div>
                        <asp:Label ID="lblHeadingOld" runat="server" CssClass="label labelColor"><!--ADD PROJECT DETAILS --></asp:Label>
                        <asp:TextBox ID="txtAddProject" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtAddProject"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label26" runat="server" CssClass="label labelColor">START DATE</asp:Label>
                        <asp:TextBox ID="txtAddStartDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtAddStartDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label28" runat="server" CssClass="label labelColor">TARGET END DATE</asp:Label>
                        <asp:TextBox ID="txtAddEndDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtAddEndDate"></asp:TextBox>
                   </div>
                   <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:Label ID="Label30" runat="server" CssClass="label labelColor">BY</asp:Label><br />
                        <asp:Label ID="lblUser" runat="server" Text="05/11/2022" CssClass="label label-default"></asp:Label>
                   </div>
                   <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label32" runat="server" CssClass="label labelColor">Status</asp:Label>
                        <asp:Label ID="Label34" runat="server" CssClass="label label-default">Open</asp:Label>
                   </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div>
                        <asp:Button ID="btnSave" Text="    Save    " runat="server" OnClick="btnSave_Click" /> 
                    </div>
                </div>
                <div class="row" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <asp:Label ID="lblErrorMessage" runat="server" class="control-label" ForeColor="Red" Font-Bold="True"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

