<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RouteMasterSchedule.ascx.cs" Inherits="RouteMasterSchedule" %>

<!---Update Progress 1 ---->
<asp:UpdateProgress ID="UpdateProgress_RouteSchedule" AssociatedUpdatePanelID="UpdatePanel_RouteSchedule" runat="server" DisplayAfter="0">
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

<asp:UpdatePanel ID="UpdatePanel_RouteSchedule" runat="server">
    <ContentTemplate>
        <div class="form-group">
            <div class="row">
                <div class="col-xs-2 col-sm-4 col-md-4 col-lg-3 col-xl-2">
                    <div class="form-control-sm"></div>
                    <asp:Label ID="Lbl_RouteName" runat="server" CssClass="label labelColor">ROUTE NAME</asp:Label><span class="required">*</span>
                    <asp:DropDownList ID="Ddl_RouteName" runat="server" CssClass="formDisplay Ddl_RouteName" AutoPostBack="true" OnSelectedIndexChanged="Ddl_RouteName_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="col-xs-2 col-sm-4 col-md-4 col-lg-3 col-xl-2">
                    <div class="form-control-sm"></div>
                    <asp:Label ID="Lbl_ScheduleName" runat="server" CssClass="label labelColor">SCHEDULE NAME</asp:Label><span class="required">*</span>
                    <asp:TextBox ID="Txt_ScheduleName" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_ScheduleName"></asp:TextBox>
                </div>
                <div class="col-xs-2 col-sm-4 col-md-4 col-lg-3 col-xl-2">
                    <div class="form-control-sm"></div>
                    <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                    <asp:TextBox ID="Txt_Remark" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm FirstNoSpaceAndZero Txt_Remark" TextMode="MultiLine"></asp:TextBox>

                </div>
            </div>
        </div>
        <div class="form-group">
            <asp:GridView ID="Gv_RouteSchedule" runat="server" DataKeyNames="routeDetailID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive">
                <Columns>
                    <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="routeDetailId" HeaderText="ROUTE ID">
                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="route" HeaderText="ROUTE">
                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="DAY" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddl_Day" runat="server">
                                <asp:ListItem>SELECT</asp:ListItem>
                                <asp:ListItem>DAY 1</asp:ListItem>
                                <asp:ListItem>DAY 2</asp:ListItem>
                                <asp:ListItem>DAY 3</asp:ListItem>
                                <asp:ListItem>DAY 4</asp:ListItem>
                                <asp:ListItem>DAY 5</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center" Wrap="false"></HeaderStyle>
                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center" Wrap="false"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LEAVE TIME" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddl_LHours" runat="server">
                                <asp:ListItem>HOUR</asp:ListItem>
                                <asp:ListItem>01</asp:ListItem>
                                <asp:ListItem>02</asp:ListItem>
                                <asp:ListItem>03</asp:ListItem>
                                <asp:ListItem>04</asp:ListItem>
                                <asp:ListItem>05</asp:ListItem>
                                <asp:ListItem>06</asp:ListItem>
                                <asp:ListItem>07</asp:ListItem>
                                <asp:ListItem>08</asp:ListItem>
                                <asp:ListItem>09</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>13</asp:ListItem>
                                <asp:ListItem>14</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>17</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>19</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                                <asp:ListItem>22</asp:ListItem>
                                <asp:ListItem>23</asp:ListItem>
                                <asp:ListItem>24</asp:ListItem>
                            </asp:DropDownList>
                            :
                            <asp:DropDownList ID="ddl_LMinutes" runat="server">
                                <asp:ListItem>MINUTE</asp:ListItem>
                                <asp:ListItem>00</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>45</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center" Wrap="false"></HeaderStyle>
                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center" Wrap="false"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="REACH TIME" HeaderStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddl_RHours" runat="server">
                                <asp:ListItem>HOUR</asp:ListItem>
                                <asp:ListItem>01</asp:ListItem>
                                <asp:ListItem>02</asp:ListItem>
                                <asp:ListItem>03</asp:ListItem>
                                <asp:ListItem>04</asp:ListItem>
                                <asp:ListItem>05</asp:ListItem>
                                <asp:ListItem>06</asp:ListItem>
                                <asp:ListItem>07</asp:ListItem>
                                <asp:ListItem>08</asp:ListItem>
                                <asp:ListItem>09</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>13</asp:ListItem>
                                <asp:ListItem>14</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>17</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>19</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                                <asp:ListItem>22</asp:ListItem>
                                <asp:ListItem>23</asp:ListItem>
                                <asp:ListItem>24</asp:ListItem>
                            </asp:DropDownList>
                            :
                            <asp:DropDownList ID="ddl_RMinutes" runat="server">
                                <asp:ListItem>MINUTE</asp:ListItem>
                                <asp:ListItem>00</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>45</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center" Wrap="false"></HeaderStyle>
                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center" Wrap="false"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle HorizontalAlign="Center" />
            </asp:GridView>
        </div>
        <div class="form-group">
            <div class="row">
                <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                    <div class="form-control-sm"></div>
                    <asp:HiddenField ID="HiddenField_Submit1" runat="server" ClientIDMode="Static" Value="0" />
                    <asp:LinkButton ID="Button_Submit1" runat="server" Text="SUBMIT" CssClass="btn btn-info largeButtonStyle Button_Submit1" TabIndex="39" UseSubmitBehavior="false" OnClientClick="if (!ValidationRouteSchedule()) {return false;};" OnClick="Button_Submit1_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                </div>
                <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                    <div class="form-control-sm"></div>
                    <asp:HiddenField ID="HiddenField2" runat="server" />
                    <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Reset" ID="LinkButton2" runat="server" Text="RESET" OnClientClick="Btn_Reset()" TabIndex="40">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                </div>
            </div>
        </div>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>
    <script src="Validation/Val_RouteMaster.js"></script>
