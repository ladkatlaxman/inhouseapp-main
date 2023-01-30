<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VDTReport.aspx.cs" Inherits="VDTReport" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content> 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    <div class="panel-body"> 
        <div class="form-horizontal" role="form"> 
            <div class="form-group"> 
                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle"> 
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false"/> 
                </asp:GridView> 
            </div> 
        </div> 
    </div> 
</asp:Content> 
