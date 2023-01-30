<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ProjView.aspx.cs" Inherits="ProjView" EnableEventValidation="true"    %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>PROJECT DETAILS</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" runat="server" style="color">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:Button ID="btnAddProject" Text=" Add a new Project " runat="server" OnClick="btnAddProject_Click"/> 
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" runat="server" style="color">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:Label ID="Label34" runat="server" CssClass="label labelColor">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROJECTS : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label37" runat="server" CssClass="label labelColor">START DATE :</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label39" runat="server" CssClass="label labelColor">TARGET END DATE :</asp:Label>
                   </div>
                   <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label41" runat="server" CssClass="label labelColor">BY :</asp:Label>
                   </div>
                   <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label43" runat="server" CssClass="label labelColor">Status</asp:Label>
                   </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        &nbsp;
                    </div>
                </div>
                <asp:Repeater ID="rptprojects" runat="server" OnItemCommand="rptprojects_ItemCommand" OnItemDataBound="rptprojects_ItemDataBound">  
                    <ItemTemplate>
                        <div class="row" runat="server" style="color">
                            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                                <asp:Label ID="Label1" runat="server" CssClass="label labelColor">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%#DataBinder.Eval(Container,"DataItem.ProjectDescription")%></asp:Label> 
                            </div>
                            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                <asp:Label ID="Label2" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.StartDate")%></asp:Label>
                            </div>
                            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                <asp:Label ID="Label3" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.EndDate")%></asp:Label>
                           </div>
                           <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                <asp:Label ID="Label4" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.User")%></asp:Label>
                           </div>
                           <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                <asp:Label ID="Label5" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.Status")%></asp:Label>
                           </div>
                           <!--<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                               <asp:LinkButton ID="btnAddSubItem" Text="Add Sub Item" runat="server" CommandArgument='<%#Eval("ProjectId")%>' CommandName="btnAddSubItem" />
                           </div>--> 
                           <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                               <asp:LinkButton ID="btnEdit" Text="Edit" runat="server" CommandArgument='<%#Eval("ProjectId")%>' CommandName="btnEdit" />
                           </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="row" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

