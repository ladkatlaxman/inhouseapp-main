<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="MaterialApproval.aspx.cs" Inherits="MaterialApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_MaterialApproval" AssociatedUpdatePanelID="UpdatePanel_MaterialApproval" runat="server" DisplayAfter="0">
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
            <asp:UpdatePanel ID="UpdatePanel_MaterialApproval" runat="server">
                <ContentTemplate>
                    <div class="panel panelTop" runat="server">
                        <div class="panel-heading panelHead">
                            <b>MATERIAL APPROVAL</b>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-1 col-lg-1"></div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                                            <asp:TextBox ID="Txt_SearchFromDate" runat="server" Style="text-transform: uppercase" type="date" CssClass="form-control input-sm" TabIndex="1"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_SearchToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                                            <asp:TextBox ID="Txt_SearchToDate" runat="server" Style="text-transform: uppercase" type="date" CssClass="form-control input-sm" TabIndex="2"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Branch" runat="server" CssClass="label labelColor">BRANCH</asp:Label>
                                            <asp:DropDownList ID="Ddl_Branch" runat="server" TabIndex="3" CssClass="formDisplay input-sm Ddl_Branch">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Status" runat="server" CssClass="label labelColor">STATUS</asp:Label>
                                            <asp:DropDownList ID="Ddl_Status" runat="server" TabIndex="3" CssClass="formDisplay input-sm Ddl_Status">
                                                <asp:ListItem Value="1">OPEN</asp:ListItem>
                                                <asp:ListItem Value="2">APPROVED</asp:ListItem>
                                                <asp:ListItem Value="3">REJECTED</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-lg"></div>
                                            <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                            <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" TabIndex="4" Text="SEARCH" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:GridView ID="GV_PurachaseMaterialDetailList" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false" OnRowDataBound="GV_PurachaseMaterialDetailList_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="APPROVE">
                                                <ItemTemplate>
                                                    <asp:Table ID="TableApproved" runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell>
                                                                <asp:LinkButton ID="Approved" runat="server" CommandArgument='<%#Eval("ID")%>' OnClick="Approved_Click">APPROVE</asp:LinkButton>
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
                                                                <asp:LinkButton ID="Rejected" runat="server" CommandArgument='<%#Eval("ID")%>' OnClick="Rejected_Click">REJECT</asp:LinkButton>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SR.NO">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ID">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="branchName" HeaderText="BRANCH NAME">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="materialName" HeaderText="MATERIAL NAME">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="unit" HeaderText="UOM">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="qty" HeaderText="QTY">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="departmentName" HeaderText="DEPARTMENT NAME">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="remarks" HeaderText="REMARKS">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="expectedDate" HeaderText="EXPECTED DATE">
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
                    <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>

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

