<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VendorInvoice.aspx.cs" Inherits="VendorInvoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>WAY BILL INVOICE</b>
        </div> 
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label1" runat="server" CssClass="label labelColor">INVOICE NO</asp:Label>
                <asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="form-control input-sm txtInvoiceNo" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                <div class="form-control-sm"></div>
                <asp:Label ID="lblVendorName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label>
                <asp:TextBox ID="txtVendorName" runat="server" CssClass="form-control input-sm txtVendorName" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
                <asp:HiddenField ID="hVendorId" runat="server" />
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label2" runat="server" CssClass="label labelColor">INVOICE DATE</asp:Label>
                <asp:TextBox ID="txtInvoiceDate" runat="server" CssClass="form-control input-sm txtInvioceDate" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label13" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control input-sm txtFromDate" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label14" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control input-sm txtToDate" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label3" runat="server" CssClass="label labelColor">NO OF DAYS</asp:Label>
                <asp:TextBox ID="txtNoOfDays" runat="server" CssClass="form-control input-sm txtNoOfDays" Style="text-transform: uppercase;" AutoCompleteType="Disabled"></asp:TextBox> 
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="btnCalculate" runat="server"  CssClass="btn btn-info largeButtonStyle btnCalculate">CALCULATE</asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label11" runat="server" CssClass="label labelColor">NET WEIGHT</asp:Label>
                <asp:TextBox ID="txtNETWeight" runat="server" CssClass="form-control input-sm txtNETWeight" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label12" runat="server" CssClass="label labelColor">NO OF PCS</asp:Label>
                <asp:TextBox ID="txtNoOfPieces" runat="server" CssClass="form-control input-sm txtNoOfPieces" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label4" runat="server" CssClass="label labelColor">NET AMOUNT</asp:Label>
                <asp:TextBox ID="txtNetAmount" runat="server" CssClass="form-control input-sm txtNetAmount" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label8" runat="server" CssClass="label labelColor">DEDUCTIONS</asp:Label>
                <asp:TextBox ID="txtDeductions" runat="server" CssClass="form-control input-sm txtNetAmount" Style="text-transform: uppercase;" AutoCompleteType="Disabled"></asp:TextBox>
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-2">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label10" runat="server" CssClass="label labelColor">REMARKS</asp:Label>
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control input-sm txtNetAmount" Style="text-transform: uppercase;" AutoCompleteType="Disabled"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label9" runat="server" CssClass="label labelColor">NET AMOUNT</asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control input-sm txtNetAmount" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CGST</asp:Label>
                <asp:TextBox ID="txtCGST" runat="server" CssClass="form-control input-sm txtCGST" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label6" runat="server" CssClass="label labelColor">SGST</asp:Label>
                <asp:TextBox ID="txtSGST" runat="server" CssClass="form-control input-sm txtSGST" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label7" runat="server" CssClass="label labelColor">GROSS AMOUNT</asp:Label>
                <asp:TextBox ID="txtGrossAmount" runat="server" CssClass="form-control input-sm txtGrossAmount" Style="text-transform: uppercase;" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="btnSaveInvoice" runat="server"  CssClass="btn btn-info largeButtonStyle2 btnSaveInvoice">SAVE INVOICE</asp:LinkButton>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="btnPrintInvoice" runat="server"  CssClass="btn btn-info largeButtonStyle btnPrintInvoice">PRINT</asp:LinkButton>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="btnExcel" runat="server"  CssClass="btn btn-info largeButtonStyle btnPrintInvoice" OnClick="btnExcel_Click">EXCEL</asp:LinkButton>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="lnkWayBills" runat="server" CssClass="btn btn-info largeButtonStyle2 lnkWayBills" OnClick="lnkWayBills_Click">WAYBILL LIST</asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <div class="form-horizontal" role="form">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="BranchName" HeaderText="BRANCH">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="hiringDate" HeaderText="HIRING DATE">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="ManifestNo" HeaderText="MANIFEST">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="Route" HeaderText="ROUTE">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:BoundField DataField="WayBills" HeaderText="WAYBILLS"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:BoundField DataField="Qty" HeaderText="QTY"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:BoundField DataField="ActualWt" HeaderText="WEIGHT"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:BoundField DataField="KMS" HeaderText="KMS" Visible="false"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:TemplateField HeaderText="KMS" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtKMS" runat="server" Text='<%#Eval("KMS")%>'></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Amount" HeaderText="Amount" Visible="false"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:TemplateField HeaderText="AMOUNT" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtAmount" runat="server" Text='<%#Eval("Amount")%>'></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                        </Columns> 
                    </asp:GridView> 
                </div>
            </div>
        </div>
    </div>
    <div class="form-horizontal" role="form">
        <asp:HiddenField ID="hdVendorTrips" runat="server" /> 
        <asp:GridView ID="gvWayBills" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast"></asp:GridView>
    </div>
</asp:Content>