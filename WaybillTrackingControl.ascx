<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WaybillTrackingControl.ascx.cs" Inherits="WaybillTrackingControl" %>

<!---Update Progress 1 ---->
<asp:UpdateProgress ID="UpdateProgress_TrackingWaybill" AssociatedUpdatePanelID="UpdatePanel_TrackingWaybill" runat="server" DisplayAfter="0">
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


<asp:UpdatePanel ID="UpdatePanel_TrackingWaybill" runat="server">
    <ContentTemplate>
        <div class="panel panelTop">
            <div style="text-align: center;">
                <asp:Label ID="HeaderName" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <div>

                <div class="panel-heading panelHead">
                    <b>BOOKING DETAILS</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                                <asp:GridView ID="GV_Booking" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:BoundField DataField="waybillNo" HeaderText="WAYBILL NO">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="WaybillDate" HeaderText="WAYBILL DATE">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="pickUpBranchName" HeaderText="FROM">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DeliveryBranchName" HeaderText="TO">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField> 
                                         <asp:BoundField DataField="WayBillRemark" HeaderText="REASON/REMARK">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>                                      
                                    </Columns>
                                </asp:GridView>                                         
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <asp:GridView ID="gvPODList" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                        <Columns>                                         
                                            <asp:BoundField DataField="Text" HeaderText="POD LIST">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                     <a href="<%# "http://122.170.111.196:4000/pod/" + Eval("Value") %>" target="_blank">Download</a>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="panel-heading panelHead">
                    <b>TRANSIT DETAILS</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                                <asp:GridView ID="GV_Transhipment" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Creation Date" HeaderText="DATE">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Creation Time" HeaderText="TIME">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="STATUS">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Item Qty" HeaderText="QTY">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Vehicle No" HeaderText="VEHICLENO">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="Inv No" HeaderText="INVOICE NO">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="Inv Amt" HeaderText="INVOICE VALUE">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Branch" HeaderText="LOCATION">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <%--   <asp:BoundField DataField="reason" HeaderText="REASON/REMARK">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                        </asp:BoundField>--%>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </ContentTemplate>
    <Triggers>
    </Triggers>
</asp:UpdatePanel>
