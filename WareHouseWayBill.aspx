<%@ Page Title="" Language="C#" MasterPageFile="~/dexMaster.master" AutoEventWireup="true" CodeFile="WareHouseWayBill.aspx.cs" Inherits="WareHouseWayBill" %>
<%@ Register Src="~/WaybillEntry.ascx" TagName="WaybillEntry" TagPrefix="uc" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
        <ul class="nav nav-tabs" id="myTab">
            <li class="active">
                <a data-toggle="tab" href="#home" class="target-tab-link">WAYBILL ENTRY</a>
            </li>
            <li>
                <a data-toggle="tab" href="#View_Tab">VIEW</a>
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
        </div>
        <div class="tab-content">
            <div id="AlertNotification"></div>
            
            <!--==============================================Start Waybill Entry Information=======================================================================-->
            <div id="home" class="tab-pane fade in active">
                <div id="MainCustomer" runat="server">
                    <uc:WaybillEntry ID="WaybillEntry" runat="server" />
                </div> 
            </div> 
            <!--==============================================End Waybill Entry Information=======================================================================-->

            <!--==============================================Start View Information=======================================================================-->
            <div id="View_Tab" class="tab-pane fade">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel_View_Searching" runat="server">
                        <ContentTemplate>
                            <div class="panel panelTop" runat="server">
                                <div class="panel-heading panelHead labelColor">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-1 col-lg-1"></div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <div class="form-control-lg"></div>
                                                <asp:Label ID="Lbl_FromDate" runat="server" CssClass="control-label">FROM DATE</asp:Label>
                                                <asp:TextBox ID="Txt_SearchFromDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm" TabIndex="14"></asp:TextBox>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <div class="form-control-lg"></div>
                                                <asp:Label ID="Lbl_SearchToDate" runat="server" CssClass="control-label">TO DATE</asp:Label>
                                                <asp:TextBox ID="Txt_SearchToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm" TabIndex="14"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-3 col-lg-4"></div>
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2 ">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" TabIndex="51" Text="SEARCH" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3 ">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-sm"></div>
                                                <asp:Label ID="Label7" runat="server" CssClass="control-label">TOTAL NO OF PACKAGE:-</asp:Label>
                                                <asp:Label ID="Lbl_TotalNoOfPackage" runat="server" Font-Bold="true" CssClass="control-label"></asp:Label>
                                            </div>

                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-sm"></div>
                                                <asp:Label ID="Label8" runat="server" CssClass="control-label">TOTAL WEIGHT:-</asp:Label>
                                                <asp:Label ID="Lbl_TotalWeight" runat="server" Font-Bold="true" CssClass="control-label"></asp:Label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="panel-body" id="searchRoute" runat="server">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <asp:GridView ID="GV_ViewWaybillDetail" runat="server" DataKeyNames="WaybillId" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewPickupRequestDetail_Sorting" OnPageIndexChanging="gridViewPickupRequestDetail_PageIndexChanging" PagerSettings-Mode="NumericFirstLast">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ACTION">
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:LinkButton ID="Btn_ViewData" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("WaybillId","javascript:return YourFunction(\"{0}\");")%>' ToolTip="View Data">VIEW</asp:LinkButton>
                                                                        <asp:HiddenField ID="hfPickUpIDValue" runat="server" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="WaybillId" HeaderText="WAYBILL ID" SortExpression="WaybillId">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="hidden" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="WaybillNo" HeaderText="WAYBILL NO" SortExpression="WaybillNo">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PickDate" HeaderText="WAYBILL DATE" SortExpression="PickDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME" SortExpression="CustName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ConsigneeName" HeaderText="CONSIGNEE NAME" SortExpression="ConsigneeName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                </Columns>

                                                <HeaderStyle HorizontalAlign="Center" />

                                            </asp:GridView>

                                            <asp:GridView ID="GV_Export" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" Visible="false">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>

                                                    <asp:BoundField DataField="pickupType" HeaderText="PICKUP TYPE" SortExpression="pickupType">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="hidden" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pickupDate" HeaderText="PICKUP DATE" SortExpression="pickupDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="customerNo" HeaderText="CONSIGNOR CODE" SortExpression="customerNo">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="customerName" HeaderText="CONSIGNOR NAME" SortExpression="customerName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <%-- <asp:BoundField DataField="consignorName" HeaderText="WALKIN CONSIGNOR NAME" SortExpression="consignorName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="pickupPincode" HeaderText="CONSIGNOR PINCODE" SortExpression="pickupPincode">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pickupArea" HeaderText="CONSIGNOR AREA" SortExpression="pickupArea">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="deliveryPincode" HeaderText="CONSIGNEE PINCODE" SortExpression="deliveryPincode">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="deliveryArea" HeaderText="CONSIGNEE AREA" SortExpression="deliveryArea">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="branchName" HeaderText="PICKUP BRANCH" SortExpression="branchName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="pickupStatus" HeaderText="STATUS" SortExpression="pickupStatus">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="remark" HeaderText="REMARK" SortExpression="remark">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" SortExpression="employeeNo">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                    </asp:BoundField>
                                                </Columns>

                                                <HeaderStyle HorizontalAlign="Center" />

                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div id="printPage">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class=" col-sm-10 col-md-10 col-lg-10"></div>

                                                <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                    <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" Text="Export To Excel" TabIndex="52" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                </div>

                                                <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">

                                                    <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="Print" TabIndex="53" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                            <asp:PostBackTrigger ControlID="btn_ExporttoExcel" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <!--==============================================End View Information=======================================================================-->

        </div>
    </div>
</asp:Content>

