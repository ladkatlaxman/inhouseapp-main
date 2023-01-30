<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PickDelLHSApproveRejectView.aspx.cs" Inherits="PickDelLHSApproveRejectView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_VehicleHiringStatusView" AssociatedUpdatePanelID="UpdatePanel_VehicleHiringStatusView" runat="server" DisplayAfter="0">
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
                <div class="panel-heading panelHead">
                    <b>VIEW DATA</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <asp:UpdatePanel ID="UpdatePanel_VehicleHiringStatusView" runat="server">
                            <ContentTemplate>
                                <div class="form-group">
                                    <asp:GridView ID="GV_PickDelApprovedRejectView" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" OnRowDataBound="GV_PickDelApprovedRejectView_RowDataBound" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="APPROVE">
                                                <ItemTemplate>
                                                    <asp:Table ID="TableApproved" runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell>
                                                                <asp:LinkButton ID="Approved" runat="server" CommandArgument='<%#Eval("VehicleRequestID")+","+ Eval("VehicleID")%>' OnClick="Approved_Click">APPROVE</asp:LinkButton>
                                                                <%--"return confirm('Are you sure you want to Approve this Vehicle?');"--%>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="REJECT">
                                                <ItemTemplate>
                                                    <asp:Table ID="TableRejected" runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell>
                                                                <asp:LinkButton ID="Rejected" runat="server" CommandArgument='<%#Eval("VehicleRequestID")+","+ Eval("VehicleID")%>' OnClick="Rejected_Click">REJECT</asp:LinkButton>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="VIEW DATA">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="View" runat="server" CommandArgument='<%#Eval("VehicleRequestID")+","+ Eval("VehicleID")%>' OnClick="View_Click">VIEW</asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                            <asp:BoundField DataField="VehicleRequestID">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="sessionDetail.UserBranch" HeaderText="BRANCH NAME" SortExpression="sessionDetail.UserBranch">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Remark" HeaderText="REASON FOR REQUEST" SortExpression="Remark">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="hiringDate" HeaderText="HIRING DATE" SortExpression="hiringDate">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VehicleID" HeaderText="VEHICLE ID" SortExpression="VehicleID">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO" SortExpression="VehicleNo">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="ACCOUNT DETAIL">
                                                <ItemTemplate>
                                                    <asp:GridView runat="server" ID="gridViewAccountDetail" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField DataField="AccountName" HeaderText="ACCOUNT NAME">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Left" Wrap="false" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="AccountValue" HeaderText="CHARGES">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Left" Wrap="false" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Remark" HeaderText="REMARK">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Left" Wrap="false" CssClass="gvItemStyle" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                    </asp:GridView>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="sessionDetail.UserName" HeaderText="CREATED BY">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="totalAttachPickup" HeaderText="ATTACH TOTAL PICKUP" SortExpression="totalAttachPickup">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="totalAttachWaybill" HeaderText="ATTACH TOTAL WAYBILL" SortExpression="totalAttachWaybill">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderText="STATUS" SortExpression="Status">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="sessionDetail.CreationDateTime" HeaderText="CREATION DATETIME" SortExpression="sessionDetail.CreationDateTime">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                            <Triggers></Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>


        </div>

    </div>
    <script type="javascript">
    function alert() {
        return confirm('Are you sure you want to Reject this Vehicle?');
    }
    </script>
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

