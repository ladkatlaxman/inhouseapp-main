<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VendorTrips.aspx.cs" Inherits="VendorTrips" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="row">
            <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 ">
                <div class="panel-heading panelHead"  runat="server" id="HeaderName">
                    <b>LIST OF VENDOR VEHICLE TRIPS</b>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                <div class="form-control-sm"></div>
                <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                <asp:TextBox ID="Txt_FromDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FromDate"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                <div class="form-control-sm"></div>
                <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                <asp:TextBox ID="Txt_ToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="Btn_Search" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click">GET LIST</asp:LinkButton>
            </div>
        </div>
        <div class="row"> 
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:Label runat="server" ID="Label2" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:Label runat="server" ID="lblError" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="form-group">
            <div class="form-horizontal" role="form">
                <div class="form-control-sm">&nbsp;</div>
                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast" OnRowDataBound="gvFirstGrid_RowDataBound"> 
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                    <Columns>
                        <asp:BoundField DataField="VendorId" HeaderText="Vendor Id">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Vendor Name" HeaderText="VENDOR">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>
                            <asp:BoundField DataField="LocalTrips" HeaderText="Local Trips">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>                                                 
                            <asp:BoundField DataField="RouteTrips" HeaderText="Route Trips">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>                                                 
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

