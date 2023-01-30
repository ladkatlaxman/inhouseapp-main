<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintScreen.aspx.cs" Inherits="PrintScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <link href="css/Style.css" rel="stylesheet" />
    <style>
        table
        {
            font-size:small;
        }
    </style>
</head>
<body>
    <form id="frmPrintScreen" runat="server">
        <div>           
            <asp:Table ID="Table1" runat="server" Width="100%">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="2" Style="text-align:right" ID="tc_PrintCurrentDate" runat="server"></asp:TableCell>
                </asp:TableRow>
                 <asp:TableRow>
                    <asp:TableCell ColumnSpan="2" Style="text-align: left">
                        <strong>DEXTERS LOGISTICS PVT. LTD.</strong>
                        <br />
                        <p style="font-size:small">
                        104, RACHNA EPICENTER 
                        <br />
                        SHIVAJINAGAR
                        <br />
                        PUNE 411005<br />
                        <br />
                        www.dexters.co.in , TOLL FREE NO- 18001021844</p>
                    </asp:TableCell>
                </asp:TableRow>
                 <asp:TableRow ID="tr_TranshipDetail" runat="server" Visible="false" >
                    <asp:TableCell Style="text-align: left" ID="tc_Branch" runat="server"></asp:TableCell>
                   <asp:TableCell Style="text-align: right" ID="tc_PrintNo" runat="server"></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="text-align: left" ID="tc_VehicleNo" runat="server"></asp:TableCell>
                    <asp:TableCell Style="text-align: right" ID="tc_TotalQty" runat="server"></asp:TableCell>
                </asp:TableRow>
                 <asp:TableRow>
                     <asp:TableCell Style="text-align: left" ID="tc_VendorName" runat="server"></asp:TableCell>
                    <asp:TableCell Style="text-align: right" ID="tc_TotalWeight" runat="server"></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="text-align: center" ID="tc_PrintTitle" runat="server"></asp:TableCell>                  
                </asp:TableRow>
            </asp:Table>         
        </div>
         <hr />
        <div>
            <asp:Table ID="Table2" runat="server" Width="100%">
                <asp:TableRow>
                    <asp:TableCell >
                                <!-- Delivery Loading Sheet -->
                          <asp:GridView runat="server" ID="gvDeliveryLoadingDetails" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle hidden" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
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
                                <asp:BoundField HeaderText=" TALLY / REMARKS">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" Width="80%"/>
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" Width="80%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:GridView>


                         <!-- Transhipment Loading Sheet -->
                        <asp:GridView runat="server" ID="gvTranshipLoadingSheet" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle hidden" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="toBranchName" HeaderText="BRANCH">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ManifestBranch" HeaderText="MANIFEST BRANCH">
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
                                <asp:BoundField DataField="remQty" HeaderText="QTY">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText=" TALLY / REMARKS">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" Width="80%" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" Width="80%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:GridView>


                        <!-- Delivery Run Sheet -->
                        <asp:GridView runat="server" ID="gvDRS" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO">
                                    <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle hidden" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="packNAme" HeaderText="PACKAGE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.consigneeName" HeaderText="CONSIGNEE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.consigneeCity" HeaderText="DELIVERY">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="valueActualWt" HeaderText="WEIGHT">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="itemQty" HeaderText="QTY">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:GridView>
						<asp:GridView runat="server" ID="gvLoadingSheet" AutoGenerateColumns="true" Visible="false"></asp:GridView> 
                    </asp:TableCell>
                    </asp:TableRow>
            </asp:Table>                      
        </div>
		
       <div>
            <!--Footer-->          
            <footer class="footer" id="footer" style="position: inherit">
                <p>Prepared By
		 ______________</p>
            </footer>
            <!--End-->
        </div>
    </form>
</body>
</html>
