<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WayBillChargesNew.aspx.cs" Inherits="WayBillChargesNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop">
        <div class="panel-heading panelHead">
            <b>WAYBILL CHARGES</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                            <div class="form-control-sm"></div>
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
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <div class="form-control-lg"></div>
                                <div class="form-control-lg"></div>
                            <asp:LinkButton ID="Btn_View" runat="server" Text="ADD" CssClass="btn btn-info largeButtonStyle Btn_View" UseSubmitBehavior="false" TabIndex="4" OnClick="Btn_View_Click">VIEW</asp:LinkButton>
                        </div>
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-2">
                                <div class="form-control-sm"></div>
                                <div class="form-control-lg"></div>
                                <div class="form-control-lg"></div>
                            <asp:LinkButton ID="Btn_Add" runat="server" Text="ADD" CssClass="btn btn-info largeButtonStyle Btn_Add" UseSubmitBehavior="false" TabIndex="4" OnClick="Btn_Add_Click">ADD</asp:LinkButton>
                        </div>
                    </div>
                </div>

                <div class="form-group" runat="server" id="divWaybillCharges">
                    <asp:GridView ID="GV_WaybillCharges" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                        <Columns>
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
    </div>
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>
