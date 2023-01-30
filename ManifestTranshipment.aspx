<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ManifestTranshipment.aspx.cs" Inherits="ManifestTranshipment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_ManifestTranshipment" AssociatedUpdatePanelID="UpdatePanel_ManifestTranshipment" runat="server" DisplayAfter="0">
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
            <asp:UpdatePanel ID="UpdatePanel_ManifestTranshipment" runat="server">
                <ContentTemplate>
                    <div class="panel panelTop" runat="server">
                        <div class="panel-heading panelHead">
                            <b>MANIFEST (TRANSHIPMENT)</b>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-1 col-lg-1"></div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Date" runat="server" CssClass="label labelColor">DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Date" runat="server" Style="text-transform: uppercase" type="date" CssClass="form-control input-sm Txt_Date" TabIndex="1"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Route" runat="server" CssClass="label labelColor">ROUTE</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_Route" runat="server" TabIndex="2" CssClass="formDisplay input-sm Ddl_Route" AutoPostBack="true" OnSelectedIndexChanged="Ddl_Route_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Branch" runat="server" CssClass="label labelColor">BRANCH</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_Branch" runat="server" TabIndex="2" CssClass="formDisplay input-sm Ddl_Branch" AutoPostBack="true" OnSelectedIndexChanged="Ddl_Branch_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Remark" runat="server" Style="text-transform: uppercase" TextMode="Multiline" CssClass="form-control input-sm Txt_Remark" TabIndex="3"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_SearchWaybills" runat="server" CssClass="btn btn-info largeButtonStyle Btn_SearchWaybills" OnClick="Btn_SearchWaybills_Click">SEARCH</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div runat="server" id="DivWaybillsList" visible="false">
                        <div class="panel-heading panelHead">
                            <b>WAYBILLS TO BE SELECTED</b>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <asp:GridView ID="GV_ManifestTranshipment" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="waybillID" HeaderText="WAYBILL ID">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="WayBillItemId">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ManifestBranch" HeaderText="TO-LOCATION">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="materialName" HeaderText="MATERIAL">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="packNAme" HeaderText="PACKAGE">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="valueActualWt" HeaderText="WEIGHT">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="remQty" HeaderText="REM QTY">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="SEL QTY" ItemStyle-Width="100">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="ItemQty" AutoCompleteType="Disabled" Text='<%# Eval("remQty") %>' CssClass="form-control input-sm FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:GridView>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Button_Submit" runat="server" CssClass="btn btn-info largeButtonStyle" TabIndex="21" UseSubmitBehavior="false" OnClientClick="if (!validateManifestTranshipment()) {return false;};" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                        </div>

                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_Reset" runat="server" OnClientClick="Btn_Reset()" CssClass="btn btn-info largeButtonStyle" TabIndex="22" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div runat="server" id="DivSelectedWaybills" visible="false">
                            <div class="panel-heading panelHead">
                                <b>SELECTED WAYBILLS IN THE MANIFEST</b>
                            </div>
                            <div class="panel-body">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <asp:GridView ID="GV_SelectedWaybillsManifest" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                    <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="waybillID">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>                                             
                                                <asp:BoundField DataField="ManifestBranch" HeaderText="TO-LOCATION">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="materialName" HeaderText="MATERIAL">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="packNAme" HeaderText="PACKAGE">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="valueActualWt" HeaderText="WEIGHT">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="itemQty" HeaderText="QTY">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Remove" runat="server" CommandArgument='<%#Eval("waybillID")%>' OnClick="Remove_Click">REMOVE</asp:LinkButton>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
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
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>

        </div>

    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
</asp:Content>

