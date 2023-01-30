<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintLHS.aspx.cs" Inherits="PrintLHS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <link href="css/Style.css" rel="stylesheet" />
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
                        DEXTERS LOGISTICS PVT. LTD.
                        <br />
                        <p style="font-size:small">
                        UNIT NO. 401,402 4TH FLOOR
                        <br />
                        KUMAR BUSINESS CENTRE,
                        <br />
                        BUND GARDEN ROAD, SANGAMWADI TPS
                        <br />
                        PUNE 411001<br />
                        CONTACT NO. 020-41301118, 
                        <br />
                        www.dexters.co.in , TOLL FREE NO- 18001021844</p>
                    </asp:TableCell> 
                     <asp:TableCell>
                         LHS 
                     </asp:TableCell>
                </asp:TableRow> 
                <asp:TableRow ID="tr_TranshipDetail" runat="server" Visible="true">  
                    <asp:TableCell Style="text-align: right" ID="tc_VendorName" runat="server"></asp:TableCell> 
                    <asp:TableCell Style="text-align: right" ID="tc_VehicleNo" runat="server"></asp:TableCell> 
                    <asp:TableCell Style="text-align: right" ID="tc_VehicleType" runat="server"></asp:TableCell> 
                    <asp:TableCell Style="text-align: right" ID="tc_vehicleNature" runat="server"></asp:TableCell> 
                </asp:TableRow> 
                <asp:TableRow> 
                    <asp:TableCell Style="text-align: center" ID="tc_PrintTitle" runat="server"></asp:TableCell> 
                    <asp:TableCell Style="text-align: right" ID="tc_PrintNo" runat="server"> 
                        <asp:Label ID="lblPrintNo" runat="server"></asp:Label> 
                    </asp:TableCell> 
                </asp:TableRow>
            </asp:Table>         
        </div>
         <hr />
        <div>
            <asp:Table ID="Table2" runat="server" Width="100%">
                <asp:TableRow>
                    <asp:TableCell >
						<asp:GridView runat="server" ID="gvLHSSummary" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="ManifestNo" HeaderText="Manifest No" />
                                <asp:BoundField DataField="hiringDate" HeaderText="Date" />
                                <asp:BoundField DataField="WayBillCOunt" HeaderText="No of Waybills" />
                                <asp:BoundField DataField="Qty" HeaderText="Qty" />
                                <asp:BoundField DataField="Actual Weight" HeaderText="Actual Weight" />
                            </Columns>
						</asp:GridView>  
                    </asp:TableCell>
                    </asp:TableRow>
            </asp:Table> 
        </div>

       <div>
            <!--Footer-->          
            <footer class="footer" id="footer" style="position: inherit">
                <asp:Table ID="Table3" runat="server" Width="100%">
                    <asp:TableRow>
                        <asp:TableCell Style="text-align: right" ID="TableCell1" runat="server"><p>Driver Name 
                        ______________</p>
                        </asp:TableCell>
                        <asp:TableCell Style="text-align: right" ID="TableCell2" runat="server"><p>Prepared By
                        ______________</p>
                        </asp:TableCell>
                        <asp:TableCell Style="text-align: right" ID="TableCell3" runat="server"><p>Authorised By 
                        ______________</p>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </footer>
            <!--End-->
        </div>
    </form>
</body>
</html>
