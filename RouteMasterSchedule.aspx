<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="RouteMasterSchedule.aspx.cs" Inherits="RouteMasterSchedule" %>

<%@ Register Src="~/RouteMasterSchedule.ascx" TagPrefix="SD" TagName="Route" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_View" AssociatedUpdatePanelID="UpdatePanel_View" runat="server" DisplayAfter="0">
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
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#RouteSchedule" class="nav-link active tabfont">ROUTE SCHEDULE</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#ViewDetails" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification" runat="server"></div>
                <!--=========================================================================Route Schedule Details==========================================================================-->
                <div id="RouteSchedule" class="tab-pane active">
                    <div>
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>ROUTE SCHEDULE</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <SD:Route ID="Route1" runat="server" />

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--=============================================== End Route Schedule============================================-->
                <!--=========================================================================Route Schedule Details==========================================================================-->
                <div id="ViewDetails" class="tab-pane">
                    <div>
                        <div class="panel panelTop">
                            <asp:UpdatePanel ID="UpdatePanel_View" runat="server">
                                <ContentTemplate>
                                    <div class="panel-heading panelView">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-0 col-md-1 col-lg-4 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor">ROUTE NAME</asp:Label>
                                                    <asp:DropDownList ID="Ddl_ViewRouteName" runat="server" CssClass="formDisplay">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-4 col-lg-5 ">
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                    <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Search" TabIndex="51" Text="SEARCH" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <asp:GridView ID="GV_RouteMasterSchedule" runat="server" DataKeyNames="routeID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="GV_RouteMasterSchedule_Sorting">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="routeID" HeaderText="ROUTE ID" SortExpression="routeID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="routeName" HeaderText="ROUTE NAME" SortExpression="routeName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="scheduleName" HeaderText="SCHEDULE NAME" SortExpression="scheduleName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="routeDetailId" HeaderText="ROUTE DETAIL ID" SortExpression="routeDetailId">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="route" HeaderText="ROUTES" SortExpression="route">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="routeDay" HeaderText="ROUTE SCHEDULE DAY" SortExpression="routeDay">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="leaveTime" HeaderText="LEAVING TIME" SortExpression="leaveTime">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="reachTime" HeaderText="REACH TIME" SortExpression="reachTime">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" />

                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
                <!--=============================================== End Route Schedule============================================-->

            </div>
        </div>
    </div>
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
</asp:Content>

