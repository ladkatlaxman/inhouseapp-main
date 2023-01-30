<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ProjEdit.aspx.cs" Inherits="ProjEdit" EnableEventValidation="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>PROJECT DETAILS</b>
        </div>

            <div class="form-group">
                <div class="row" runat="server" style="color">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:Label ID="Label34" runat="server" CssClass="label labelColor">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PROJECT : </asp:Label>
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
                        Update Status
                    </div>
                </div>
                <asp:Repeater ID="rptprojects" runat="server" OnItemDataBound="rptprojects_ItemDataBound" OnItemCommand="rptprojects_ItemCommand">  
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
                            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                <asp:DropDownList ID="ddlProjectStatus" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                <asp:Button ID="btnUpdateProjectSTatus" Text="Save" runat="server" CommandArgument='Save' CommandName="btnSaveProjectStatus" OnClick="btnUpdateProjectStatus_Click" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="row" runat="server">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div><div class="form-control-lg"></div>
                    </div>
                </div>
                <div class="panel-success"  runat="server" id="Div1">
                    <b>PROJECT UPDATES</b>
                </div>
                <div class="row" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-lg"></div><div class="form-control-lg"></div> 
                    </div>
                </div>
                <div class="row" runat="server">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:Label ID="Comment" runat="server" CssClass="label labelColor">COMMENT: </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label19" runat="server" CssClass="label labelColor">Status :</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label17" runat="server" CssClass="label labelColor"> Dated :</asp:Label>
                    </div>
                </div>
                <asp:Repeater ID="rptprojectsstatus" runat="server">  
                    <ItemTemplate>
                    <div class="row" runat="server">
                        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                            <asp:Label ID="Label6" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.Comments")%></asp:Label>
                        </div>
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                            <asp:Label ID="Label7" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.Status")%></asp:Label>
                        </div>
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                            <asp:Label ID="Label9" runat="server" CssClass="label labelColor"><%#DataBinder.Eval(Container,"DataItem.CreationDate")%></asp:Label>
                        </div>
                    </div>
                    <div class="row" runat="server">&nbsp;</div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="row" runat="server">
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:TextBox ID="txtAddComment" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtAddProject"></asp:TextBox>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:DropDownList ID="ddlStatus" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Label8" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Button ID="btnSave" Text="Save" runat="server" CommandArgument='Save' CommandName="btnEdit" OnClick="btnSave_Click" />
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <asp:Label ID="lblErrorMessage" runat="server" class="control-label" ForeColor="Red" Font-Bold="True"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
</asp:Content>

