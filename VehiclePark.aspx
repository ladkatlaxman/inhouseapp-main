<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehiclePark.aspx.cs" Inherits="VehiclePark" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
      
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_VehicleParkView" AssociatedUpdatePanelID="UpdatePanel_VehicleParkView" runat="server" DisplayAfter="0">
            <ProgressTemplate>
                <div id="overlay">
                    <div id="modalprogress">
                        <div id="theprogress">
                            <img src="images/dots-4.gif" />
                        </div>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
        <div id="AlertNotification"></div>
            <div class="panel panelTop">
                <div class="panel-heading panelHead" style="font-weight:bold" runat="server" id="HeaderName"></div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <asp:UpdatePanel ID="UpdatePanel_VehicleParkView" runat="server">
                            <ContentTemplate>
                                <div class="form-group">
                                    <asp:GridView ID="GV_VehiclePark" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false" OnRowCommand="GV_VehiclePark_RowCommand">
                                        <Columns>
					    <asp:TemplateField HeaderText="SR.NO">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PARK">
                                                <ItemTemplate>
                                                    <asp:Table ID="TablePark" runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell>
                                                                 <asp:LinkButton ID="Park" runat="server" CommandName="PARK" CommandArgument='<%# Container.DataItemIndex %>'>PARK</asp:LinkButton>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VehicleRequestID" HeaderText="VEHICLE ID" SortExpression="VehicleRequestID">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle hidden"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO" SortExpression="VehicleNo">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField> 
                                            <asp:BoundField DataField="routeName" HeaderText="ROUTE NAME" SortExpression="routeName">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField> 
                                            <asp:BoundField DataField="distance" HeaderText="DISTANCE FROM BRANCH (IN KMS)" SortExpression="distance">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="KM" ItemStyle-Width="100">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="Txt_Km" Style="text-transform: uppercase" AutoCompleteType="Disabled" TabIndex="5" CssClass="form-control input-sm  FirstNoSpaceAndZero"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField> 
                                            <asp:TemplateField HeaderText="REMARK" ItemStyle-Width="100">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="Txt_Remark" Style="text-transform: uppercase" AutoCompleteType="Disabled" TabIndex="6" CssClass="form-control input-sm  FirstNoSpaceAndZero"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="creationDateTime" HeaderText="DISPATCH AT">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </div>
                            </ContentTemplate>
                            <Triggers></Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

