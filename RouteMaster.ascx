<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RouteMaster.ascx.cs" Inherits="RouteMaster" %>
<!---Update Progress 1 ---->
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
<!---Update Progress 2 ---->
<asp:UpdateProgress ID="UpdateProgress_RouteDetail" AssociatedUpdatePanelID="UpdatePanel_RouteDetail" runat="server" DisplayAfter="0">
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
<div class="panel-heading panelHead">
    <b>ROUTE DETAILS</b>
</div>
<div class="panel-body labelColor">
    <div class="form-horizontal" role="form">
        <asp:UpdatePanel ID="UpdatePanel_RouteMasterDetail" runat="server">
            <ContentTemplate>
                     <div class="form-group">
                    <div class="row">
                        <asp:HiddenField ID="AutoIncementNo" runat="server" />
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblFromBranch" runat="server" CssClass="label labelColor">FROM BRANCH</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="txtFromBranch" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm txtFromBranch FirstNoSpaceAndZero" onchange="ReadDataonchange('txtFromBranch','hffromBranchID','txtFromBranch','txtToBranch','txtTotalMapDistance','ReadData','RouteMaster.aspx/GetBranch');" TabIndex="1"></asp:TextBox>
                            <asp:HiddenField ID="hffromBranchID" runat="server" />
                        </div>
                        <%--ReadDataonchange('txtFromBranch','hffromBrnachID','txtToBranch','txtTotalMapDistance')--%>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblToBranch" runat="server" CssClass="label labelColor">TO BRANCH</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="txtToBranch" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm txtToBranch FirstNoSpaceAndZero" onchange="ReadDataonchange('txtToBranch','hfToBranchID','txtFromBranch','txtToBranch','txtTotalMapDistance','ReadData','RouteMaster.aspx/GetBranch');" TabIndex="2"></asp:TextBox>
                            <asp:HiddenField ID="hfToBranchID" runat="server" />
                        </div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-4 col-xl-5">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_RouteName" runat="server" CssClass="label labelColor">ROUTE NAME</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="txtRouteName" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm txtRouteName FirstNoSpaceAndZero" TabIndex="3"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblTotalDistance" runat="server" CssClass="label labelColor">TOTAL DISTANCE</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="txtTotalDistance" runat="server" CssClass="form-control input-sm txtTotalDistance" Text="0"></asp:TextBox>
                            <asp:HiddenField ID="hfTotalDistance" runat="server" />
                        </div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblTotalMapDistance" runat="server" CssClass="label labelColor">MAP DISTANCE</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="txtTotalMapDistance" runat="server" CssClass="form-control input-sm txtTotalMapDistance" Text="0"></asp:TextBox>
                            <asp:HiddenField ID="hfTotalMapDistance" runat="server" />
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
<!--=====================================Route Connecting Branch Details==========================================-->
<div class="panel-heading panelHead">
    <b>ROUTE DETAILS</b>
</div>
<div class="panel-body labelColor">
    <div class="form-horizontal" role="form">
        <asp:UpdatePanel ID="UpdatePanel_RouteDetail" UpdateMode="Always" runat="server">
            <ContentTemplate>
                <div class="form-group" id="HideShowData" runat="server" visible="true">
                    <div class="row">
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="LblBranch1" runat="server" CssClass="label labelColor">FROM BRANCH</asp:Label>
                            <asp:TextBox ID="TxtBranch1" runat="server" CssClass="form-control input-sm TxtBranch1"></asp:TextBox>
                            <asp:HiddenField ID="hfTxtBranch1ID" runat="server" />
                        </div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="LblBranch2" runat="server" CssClass="label labelColor">TO BRANCH</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="TxtBranch2" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm TxtBranch2 FirstNoSpaceAndZero" onchange="ReadDataonchange('TxtBranch2','hfTxtBranch2ID','TxtBranch1','TxtBranch2','Txt_MapDistance','ReadData','RouteMaster.aspx/GetBranch');" TabIndex="4"></asp:TextBox>
                            <asp:HiddenField ID="hfTxtBranch2ID" runat="server" />

                        </div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="LblDistance" runat="server" CssClass="label labelColor">DISTANCE</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="TxtDistance" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm TxtDistance FirstNoSpaceAndZero" onchange="TotalDistance();" TabIndex="5"></asp:TextBox>
                        </div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="LblMapDistance" runat="server" CssClass="label labelColor">MAP DISTANCE</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="Txt_MapDistance" runat="server" Text="0" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Lbl_MapDistance FirstNoSpaceAndZero" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:HiddenField ID="hfAddTouchingBranch" runat="server" ClientIDMode="Static" Value="0" />
                            <asp:LinkButton ID="Btn_AddTouchingBranch" runat="server" Text="ADD" CssClass="btn btn-info buttonStyle2 Btn_Add" UseSubmitBehavior="false" OnClientClick="if (!validateRouteDetail()) {return false;};" TabIndex="7">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        </div>
                        <asp:GridView ID="GV_RouteDetail" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                     <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                     <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="fromBranchId" HeaderText="FROM BRANCH ID">
                                    <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="fromBranch" HeaderText="FROM BRANCH">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="toBranchId" HeaderText="TO BRANCH ID">
                                    <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="toBranch" HeaderText="TO BRANCH">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="distance" HeaderText="DISTANCE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="mapDistance" HeaderText="MAP DISTANCE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="TxtBranch2" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
