<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PickDelRoute.aspx.cs" Inherits="PickDelRoute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress ---->
        <asp:UpdateProgress ID="UpdateProgress_RouteMasterDetail" AssociatedUpdatePanelID="UpdatePanel_RouteMasterDetail" runat="server" DisplayAfter="0">
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

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <ul class="nav nav-tabs" id="myTab">
            <li class="nav-item">
                <a data-toggle="tab" href="#RouteDetails" class="nav-link active tabfont">ROUTE DETAILS</a>
            </li>
            <li class="nav-item">
                <a data-toggle="tab" href="#ViewDetails" class="nav-link tabfont">VIEW</a>
            </li>
        </ul>
        <div id="LoadingImage" runat="server" style="display: none">
            <div id="overlay">
                <div id="modalprogress">
                    <div id="theprogress">
                        <img src="images/dots-4.gif" />
                    </div>
                </div>
            </div>
        </div>
        <!-- Tab panes -->
        <div class="tab-content">
            <div id="AlertNotification" runat="server"></div>
            <!--=========================================================================Route Details==========================================================================-->
            <div id="RouteDetails" class="tab-pane active">
                <div>
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>ROUTE DETAILS</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <asp:UpdatePanel ID="UpdatePanel_RouteMasterDetail" runat="server">
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <div class="row">
                                                 <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-3"></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_RouteName" runat="server" CssClass="label labelColor">ROUTE NAME</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="txtRouteName" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm txtRouteName FirstNoSpaceAndZero" TabIndex="1"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="lblTotalDistance" runat="server" CssClass="label labelColor">TOTAL DISTANCE(IN KMS)</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="txtTotalDistance" runat="server" CssClass="form-control input-sm txtTotalDistance" TabIndex="2"></asp:TextBox>                                               
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="3" CssClass="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validatePickDelRoute()) {return false;};" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="4" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--=============================================== End Route Details============================================-->

            <!--=============================================== Searching Parameters============================================-->
            <div id="ViewDetails" class="tab-pane">
                <div>
                    <div class="panel panelTop" runat="server">
                        <asp:UpdatePanel ID="UpdatePanel_View" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>                            
                                <div class="form-group">
                                    <div class="panel-body">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <asp:GridView ID="GV_RouteMaster" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowPaging="true" PageSize="15" OnPageIndexChanging="GV_RouteMaster_PageIndexChanging">
                                                    <Columns>                                                      
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="RouteName" HeaderText="ROUTE NAME" SortExpression="RouteName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="KMS" HeaderText="KMS" SortExpression="KMS">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:GridView>                                            
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>                             
                                <asp:AsyncPostBackTrigger ControlID="GV_RouteMaster" EventName="PageIndexChanging" />
                            </Triggers>
                        </asp:UpdatePanel>

                    </div>
                </div>
                <!--==============================================end Route Details======================================================== -->
            </div>
        </div>
    </div>
      <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
      <script src="Validation/Val_VehicleTypeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

