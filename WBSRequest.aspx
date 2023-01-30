<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WBSRequest.aspx.cs" Inherits="WBSRequest" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <ContentTemplate> 
        <div class="panel panelTop">
            <div class="panel-heading panelHead" runat="server" id="HeaderName">
                <b>WAYBILL STATIONARY REQUEST</b> 
            </div> 
            <div class="panel-body labelColor"> 
                <div class="form-horizontal" role="form"> 
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                    &nbsp; 
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_FromNumber" runat="server" CssClass="label labelColor">NO OF WAYBILLS</asp:Label>
                                <asp:TextBox ID="txtQty" runat="server" Style="text-transform: uppercase;" MaxLength="7" CssClass="form-control input-sm Txt_FromNumber"></asp:TextBox>
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                <div class="form-control-lg"></div>
                                <div class="form-control-lg"></div>
                                <div class="form-control-sm"></div>
                                <asp:LinkButton ID="Btn_Submit" runat="server" Text="ADD NEW" CssClass="btn btn-info largeButtonStyle Btn_Submit" OnClick="Btn_Submit_Click">SUBMIT</asp:LinkButton> 
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                &nbsp; 
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="lblResult" runat="server" CssClass="label labelColor" ForeColor="Blue" Visible="true"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                &nbsp; 
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="lblError" runat="server" CssClass="label labelColor" ForeColor="Red" Visible="true"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                    &nbsp; 
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Label1" runat="server" CssClass="label labelColor">WAYBILL STATIONARY REQUESTS</asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <asp:Label ID="lblClicked" runat="server" CssClass="label labelColor"></asp:Label>
                                    &nbsp; 
                            </div>
                                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" EnableViewState="true" OnRowCommand="gvFirstGrid_RowCommand"> 
                                    <Columns>
                                        <asp:BoundField DataField="BRANCH" HeaderText="BRANCH">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Qty" HeaderText="Quantity">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RequestDate" HeaderText="Request Date">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Name" HeaderText="Request By">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="STATUS" HeaderText="STATUS">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UpdateName" HeaderText="Update By">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UpdateAt" HeaderText="Update On">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:TemplateField Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblId" runat="server" Text='<%# Eval("WaybillStationaryRequestID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnUpdate" runat="server" Text="Delivered" OnClick="btnUpdate_Click" CommandArgument='<%# Eval("WaybillStationaryRequestID")%>'/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView> 
                        </div>
                    </div>
                </div> 
            </div> 
        </div> 
    </ContentTemplate> 
</asp:Content> 

