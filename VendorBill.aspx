<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VendorBill.aspx.cs" Inherits="VendorBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>VENDOR INVOICE</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group">
                <div class="row" id="SearchingParam" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="Lbl_SearchVendorName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label>
                    </div>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4 ">
                        <asp:TextBox ID="Txt_VendorName" runat="server" CssClass="form-control input-sm Txt_VendorName" Style="text-transform: uppercase;" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:HiddenField ID="hfVendorId" runat="server" /> 
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <asp:Label ID="LblInvoiceno" runat="server" CssClass="label labelColor">INVOICE NO</asp:Label>
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <asp:TextBox ID="txtInvoiceNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm txtInvoiceNo"></asp:TextBox>
                    </div>
                </div>
                <div class="row" id="divCriteria" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="Txt_FromDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FromDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="Txt_ToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                    </div>
                </div>
                <div class="row" id="divInvoiceButtons" runat="server">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1"></div> 
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="lblFixCost" runat="server" CssClass="label labelColor" Text=""></asp:Label> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnCalculate" Text="Calculate Bill Values" runat="server" OnClick="btnCalculate_Click" /> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnSaveKMDetails" Text="Save KMS" runat="server" OnClick="btnSaveKMDetails_Click"/> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnSaveInvoiceValues" Text="Save Invoice" runat="server"/> 
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        <div class="form-control-sm"></div>
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnExcel" Text="Excel" runat="server" Visible="false"/> 
                    </div>
                </div>
                <div class="row" id="divSummariesOne" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor right">Total Weight : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblWeight" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label6" runat="server" CssClass="label labelColor right">No of Dockets : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblNoOfDockets" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label8" runat="server" CssClass="label labelColor right">No of Pkgs : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblNoOfItems" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="Label9" runat="server" CssClass="label labelColor right">No of Trips : </asp:Label> 
                    </div> 
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="lblNoOfTrips" runat="server" CssClass="label labelColor left"></asp:Label> 
                    </div> 
                    <!-- <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="Label10" runat="server" CssClass="label labelColor right">No of Days : </asp:Label> 
                    </div> 
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                        <div class="form-control-sm"></div> 
                        <asp:Label ID="lblNoOfDays" runat="server" CssClass="label labelColor left"></asp:Label> 
                    </div> --> 
                </div>
                <div class="row" id="divSummariesTwo" runat="server">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label2" runat="server" CssClass="label labelColor right">Total Value : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblValue" runat="server" CssClass="label labelColor left"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label3" runat="server" CssClass="label labelColor">CGST : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblCGST" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label5" runat="server" CssClass="label labelColor">SGST : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblSGST" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label7" runat="server" CssClass="label labelColor">IGST : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblIGST" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label4" runat="server" CssClass="label labelColor">Invoice Value : </asp:Label>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                        <div class="form-control-sm"></div>
                        <asp:Label ID="lblInvoiceValue" runat="server" CssClass="label labelColor"></asp:Label>
                    </div>
                </div>
                <div class="row" id="div1" runat="server">
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6 ">
                        <asp:Label ID="lblError" runat="server" CssClass="label bdc-red-500"></asp:Label>
                    </div>
                </div>
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" 
                        RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast" OnRowDataBound="gvFirstGrid_RowDataBound"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                        <Columns> 
                            <asp:BoundField DataField="VehicleRequestId" HeaderText="Vehicle Request Id" Visible="false"> 
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                            </asp:BoundField> 
                            <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left"> 
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Manifest No">
                                <ItemTemplate>
                                    <asp:Label ID="lnkVehicleRequestId" runat="server" Text='<%#Eval("VehicleRequestId") %>' Visible="false"></asp:Label> 
                                    <asp:HyperLink ID="lnkRouteId" runat="server" Target="_blank"></asp:HyperLink> 
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="VendorId" HeaderText="Vendor Id" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="RouteId" HeaderText="Route Id" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="Route" HeaderText="ROUTE">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="hiringDate" HeaderText="DATE">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="branchName" HeaderText="BRANCH">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="WayBillNo" HeaderText="No Of Waybills">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>   
                            <asp:BoundField DataField="NoOfItems" HeaderText="No Of Pkgs">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="ChargedWt" HeaderText="Charged Wt">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="ActualWt" HeaderText="Actual Wt">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField> 
                            <asp:TemplateField HeaderText="KMS">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfVehicleRequestId" runat="server" Value='<%# Eval("VehicleRequestId") %>' />
                                    <asp:TextBox ID="txtKMS" runat="server" MaxLength="6" Width="60" Text='<%# Eval("KMS") %>' EnableViewState="true"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Rate" DataField="Rate">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Amount" HeaderText="Amount">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField> 
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

