<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WaybillCharges.aspx.cs" Inherits="WaybillCharges" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_WaybillCharges" AssociatedUpdatePanelID="UpdatePanel_WaybillCharges" runat="server" DisplayAfter="0">
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

    <div id="AlertNotification"></div>

    <div class="panel panelTop">
        <asp:UpdatePanel ID="UpdatePanel_WaybillCharges" runat="server">
            <ContentTemplate>

                <div class="panel-heading panelHead">
                    <b>WAYBILL CHARGES</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <asp:Label ID="lbl_SearchWaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                    <asp:TextBox ID="Txt_SearchWaybillNo" runat="server" onkeypress="return validateNumericValue(event)" TabIndex="1" MaxLength="7" CssClass="form-control input-sm Txt_SearchWaybillNo FirstNoSpaceAndZero" onchange="ReadDataonchange('Txt_SearchWaybillNo', 'hfWaybillID','', 'ReverseWaybill.aspx/getWayBillNo');"></asp:TextBox>
                                    <asp:HiddenField ID="hfWaybillID" runat="server" />
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_WaybillCharges" runat="server" CssClass="label labelColor">WAYBILL CHARGES</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_WaybillCharges" runat="server" CssClass="formDisplay input-sm Ddl_WaybillCharges" TabIndex="2">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_RateValue" runat="server" CssClass="label labelColor">RATE VALUE</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_RateValue" runat="server" Style="text-transform: uppercase;" TabIndex="3" AutoCompleteType="Disabled" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_RateValue"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                     <div class="form-control-sm"></div>
                                     <div class="form-control-lg"></div>
                                     <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Add" runat="server" Text="ADD" CssClass="btn btn-info largeButtonStyle Btn_Add" UseSubmitBehavior="false" OnClientClick="if (!validateWaybillCharges()) {return false;};" TabIndex="4" OnClick="Btn_Add_Click">ADD</asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" runat="server" id="divWaybillCharges">
                            <asp:GridView ID="GV_WaybillCharges" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="ACTION">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="Delete_Data1" runat="server" OnClick="Delete_Data1_Click" CommandArgument='<%# Eval("RateTypeId")%>' ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this Row?');"><i class="fa fa-trash" style="font-size:18px; color:red"></i></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="WayBillId">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="WaybillNo" HeaderText="WAYBILL NO">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RateTypeId">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RateTypeName" HeaderText="RATE TYPE">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Value" HeaderText="VALUE">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>


    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

