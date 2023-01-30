<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="MObileApp.aspx.cs" Inherits="MobileApp" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content> 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>FILE DETAILS</b>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" EmptyDataText = "No files uploaded">
                        <Columns>
                            <asp:BoundField DataField="Text" HeaderText="File Name">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>            
                                        <a href="<%# "..\\MobileApp\\" + Eval("Value") %>" target="_blank">Download</a>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

