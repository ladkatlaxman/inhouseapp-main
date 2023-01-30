<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="FreeWaybillEntry.aspx.cs" Inherits="FreeWaybillEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />

    <script>
        //$(document).ready(function () {
        //    $("[id*=Btn_AddInSameInvoice]").click(function () {
        //        console.log("Invoice No", $("[id*=hfInvoiceNo]").val());
        //        console.log("Invoice date", $("[id*=hfInvoiceDate]").val());
        //        $("[id*=Txt_InvoiceNo]").text($("[id*=hfInvoiceNo]").val());
        //        $("[id*=Txt_InvoiceDate]").text($("[id*=hfInvoiceDate]").val());
        //        return false;
        //    });
        //});
        function SameInvoice() {
            console.log("Your Function");
            console.log("Invoice No", $("[id*=hfInvoiceNo]").val());
            console.log("Invoice date", $("[id*=hfInvoiceDate]").val());

            $("[id*=Txt_InvoiceNo]").val($("[id*=hfInvoiceNo]").val());
            $("[id*=Txt_InvoiceDate]").val($("[id*=hfInvoiceDate]").val());
            $("[id*=Txt_InvoiceValue]").val($("[id*=hfInvoiceValue]").val());

            $("[id*=Txt_EWaybillNo]").val($("[id*=hfEwaybillNo]").val());
            $("[id*=Txt_EWaybillDate]").val($("[id*=hfEwaybillDate]").val());
            $("[id*=Txt_EWaybillExpiryDate]").val($("[id*=hfEwaybillExpiryDate]").val());

            $("[id*= Txt_InvoiceNo]").attr("disabled", "disabled");
            $("[id*= Txt_InvoiceDate]").attr("disabled", "disabled");
            $("[id*= Txt_InvoiceValue]").attr("disabled", "disabled");
            $("[id*= Txt_EWaybillNo]").attr("disabled", "disabled");
            $("[id*= Txt_EWaybillDate]").attr("disabled", "disabled");
            $("[id*= Txt_EWaybillExpiryDate]").attr("disabled", "disabled");
            //  $("[id*=Txt_MaterialType]").focus();
            return true;
        }
        function NewInvoice() {
            console.log("Your Function");

            $("[id*=Txt_InvoiceNo]").val("");
            $("[id*=Txt_InvoiceDate]").val("");
            $("[id*=Txt_InvoiceValue]").val("");

            $("[id*=Txt_EWaybillNo]").val("");
            $("[id*=Txt_EWaybillDate]").val("");
            $("[id*=Txt_EWaybillExpiryDate]").val("");

            $("[id$=Txt_InvoiceNo]").removeAttr("disabled");
            $("[id$=Txt_InvoiceDate]").removeAttr("disabled");
            $("[id$=Txt_InvoiceValue]").removeAttr("disabled");
            $("[id$=Txt_EWaybillNo]").removeAttr("disabled");
            $("[id$=Txt_EWaybillDate]").removeAttr("disabled");
            $("[id$=Txt_EWaybillExpiryDate]").removeAttr("disabled");
            // $("[id*=Txt_MaterialType]").focus();
            return true;
        }
        function CheckAvailability() {
            $("[id*=Lbl_ErrorMsg").text("");
            var WaybillNo = $("[id*=Txt_WaybillNo").val();
            $.ajax({
                type: "POST",
                url: 'PickReqWareHouse.aspx/CheckWaybillNo',
                data: '{waybillNo: "' + WaybillNo + '" }',
                contentType: 'application/json',
                dataType: "json",
                success: function (response) {
                    var data = response.d;
                    $.each(data, function (index, item) {
                        if (item.split('ʭ')[0] != 'AVAILABLE') {
                            $("[id*=Lbl_ErrorMsg").text(item.split('ʭ')[0]);
                        }
                    });
                }
            });
        }
        function GetBranchPickupArea() {          
            $.ajax({
                type: "POST",
                url: 'FreeWaybillEntry.aspx/getBranchPickupArea',
                data: '{}',
                contentType: 'application/json',
                dataType: "json",
                success: function (response) {
                    var data = response.d;
                    $.each(data, function (index, item) {
                        $("[id*=hfPickupArea").val(item.split('ʭ')[0]);
                        console.log($("[id*=hfPickupArea").val());
                    });
                }
            });
        }
       

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hfTabs" Value="" runat="server" />
    <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_FreeWaybill" AssociatedUpdatePanelID="UpdatePanel_FreeWaybill" runat="server" DisplayAfter="0">
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
    <asp:UpdateProgress ID="UpdateProgress_View_Searching" AssociatedUpdatePanelID="UpdatePanel_View_Searching" runat="server" DisplayAfter="0">
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
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" id="myTab">
            <li class="nav-item">
                <a data-toggle="tab" href="#home" class="nav-link active tabfont">WAYBILL DETAILS</a>
            </li>
            <li class="nav-item">
                <a data-toggle="tab" href="#View_Tab" class="nav-link tabfont">VIEW</a>
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
        <!-- Tab panes -->

        <div class="tab-content">
            <div id="AlertNotification"></div>
            <!--==============================================Start Waybill Information=======================================================================-->
            <div id="home" class="tab-pane active">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel_FreeWaybill" runat="server">
                        <ContentTemplate>
                            <div class="panel panelTop">
                                <div class="panel-heading panelHead">
                                    <b>WAYBILL DETAIL</b>
                                </div>
                                <div class="panel-body labelColor">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <asp:HiddenField ID="GetORReadData" runat="server" Value="GetData" />
                                            <div class="row">
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_WaybillNo" runat="server" Style="text-transform: uppercase;" TabIndex="1" MaxLength="7" onchange="CheckAvailability()" AutoCompleteType="Disabled" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_WaybillNo"></asp:TextBox>
                                                    <asp:Label ID="Lbl_ErrorMsg" runat="server" ForeColor="Red" CssClass="label labelColor"></asp:Label>
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-6 col-xl-4" id="currentWaybills" runat="server" visible="false">
                                                    <asp:Label ID="Lbl_CurrentWaybillNo" runat="server" CssClass="label labelColor">CURRENT WAYBILL NOS:</asp:Label>
                                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor"></asp:Label>
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_WaybillDate" runat="server" CssClass="label labelColor">WAYBILL DATE</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_WaybillDate" runat="server" Style="text-transform: uppercase;" TabIndex="2" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_WaybillDate"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_DeliveryBranch" runat="server" CssClass="label labelColor">DELIVERY BRANCH</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_DeliveryBranch" runat="server" Style="text-transform: uppercase;" TabIndex="3" CssClass="form-control Txt_DeliveryBranch input-sm" onchange="ReadDataonchange('Txt_DeliveryBranch', 'hfDeliveryBranch','', 'FreeWaybillEntry.aspx/getDeliveryBranchName');"></asp:TextBox>
                                                    <asp:HiddenField ID="hfDeliveryBranch" runat="server" />
                                                    <asp:HiddenField ID="hfPickupBranch" runat="server" />
                                                    <asp:HiddenField ID="hfPickupArea" runat="server" />
                                                    <asp:HiddenField ID="hfDeliveryArea" runat="server" />
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_Remark" runat="server" Style="text-transform: uppercase;" TabIndex="4" AutoCompleteType="Disabled" placeholder="ENTER REMARK FOR WHICH DEPARTMENT" TextMode="MultiLine" CssClass="form-control input-sm Txt_Remark"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-control-sm"></div>
                                <div class="panel-heading panelHead">
                                    <b>MATERIAL DETAIL</b>
                                </div>
                                <div class="panel-body labelColor">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group" id="ItemDetails" runat="server">
                                            <asp:LinkButton ID="Btn_AddNewInvoice" runat="server" AccessKey="a" CssClass="btn btn-info largeButtonStyle2" TabIndex="5" data-toggle="modal" data-target="#MaterialModal" OnClientClick="javascript:return NewInvoice();">Add New Invoice(Alt+A)</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="Btn_AddInSameInvoice" AccessKey="i" runat="server" CssClass="btn btn-info largeButtonStyle2" TabIndex="6" data-toggle="modal" data-target="#MaterialModal" OnClientClick="javascript:return SameInvoice();">Add in Same Invoice(Alt+I)</asp:LinkButton>
                                            <asp:HiddenField ID="hfInvoiceNo" runat="server" />
                                            <asp:HiddenField ID="hfInvoiceDate" runat="server" />
                                            <asp:HiddenField ID="hfInvoiceValue" runat="server" />
                                            <asp:HiddenField ID="hfEwaybillNo" runat="server" />
                                            <asp:HiddenField ID="hfEwaybillDate" runat="server" />
                                            <asp:HiddenField ID="hfEwaybillExpiryDate" runat="server" />
                                        </div>
                                        <div class="form-group">
                                            <asp:GridView ID="GV_WaybillDetail" runat="server" EnableViewState="false" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="SR.<br>NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="MaterialID" HeaderText="MATERIAL ID" Visible="true">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="MaterialType" HeaderText="MATERIAL<br>TYPE" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PackageID" HeaderText="PACKAGE ID" Visible="true">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PackageType" HeaderText="PACKAGE<br>TYPE" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Unit" HeaderText="UNIT">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Length" HeaderText="LENGTH">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Breadth" HeaderText="BREADTH">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Height" HeaderText="HEIGHT">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CFT" HeaderText="CFT">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ActWeight" HeaderText="ACTUAL<br>WEIGHT" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ChargeWeight" HeaderText="CHARGE<br>WEIGHT" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="NoOfPackage" HeaderText="QTY" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="NoOfInnerPackage" HeaderText="INNER QTY" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE<br>NO" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="InvoiceDate" HeaderText="INVOICE<br>DATE" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="InvoiceValue" HeaderText="INVOICE<br>VALUE" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="EWaybillNo" HeaderText="E-WAYBILL<br>NO" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="EWaybillDate" HeaderText="EWAYBILL<br>DATE" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="EWaybillExpiryDate" HeaderText="E-WAYBILL<br>EXPIRY DATE" HtmlEncode="false">
                                                        <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>

                                    </div>
                                </div>

                                <div class="form-group" id="Button" runat="server">
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="hfWaybillSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="8" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateFreeWaybillDetails()) {return false;};">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                        </div>

                                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                            <div class="form-control-sm"></div>
                                            <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="9" OnClientClick="Btn_Reset()" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
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
            <!--==============================================End Waybill Information=======================================================================-->
            <!--==============================================Start View Information=======================================================================-->
            <div id="View_Tab" class="tab-pane">
                <div>
                    <asp:UpdatePanel ID="UpdatePanel_View_Searching" runat="server">
                        <ContentTemplate>
                            <div class="panel panelTop" runat="server">
                                <div class="panel-heading panelView">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-1 col-lg-1"></div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <div class="form-control-sm"></div>
                                                <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                                                <asp:TextBox ID="Txt_SearchFromDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm" TabIndex="14"></asp:TextBox>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <div class="form-control-sm"></div>
                                                <asp:Label ID="Lbl_SearchToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                                                <asp:TextBox ID="Txt_SearchToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm" TabIndex="14"></asp:TextBox>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-3 col-lg-4"></div>
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2 ">
                                                <div class="form-control-sm"></div>
                                                <div class="form-control-sm"></div>
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click" TabIndex="51" Text="SEARCH">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3 ">
                                                <div class="form-control-sm"></div>
                                                <div class="form-control-sm"></div>
                                                <div class="form-control-sm"></div>
                                                <asp:Label ID="Label7" runat="server" CssClass="label labelColor">TOTAL NO OF PACKAGE:-</asp:Label>
                                                <asp:Label ID="Lbl_TotalNoOfPackage" runat="server" Font-Bold="true" CssClass="label labelColor"></asp:Label>
                                            </div>

                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                <div class="form-control-sm"></div>
                                                <div class="form-control-sm"></div>
                                                <div class="form-control-sm"></div>
                                                <asp:Label ID="Label8" runat="server" CssClass="label labelColor">TOTAL WEIGHT:-</asp:Label>
                                                <asp:Label ID="Lbl_TotalWeight" runat="server" Font-Bold="true" CssClass="label labelColor"></asp:Label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="panel-body" id="searchRoute" runat="server">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <asp:GridView ID="gridViewFreeWaybillDetail" runat="server" DataKeyNames="WaybillId" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                                <Columns>

                                                    <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="waybillID" HeaderText="WAYBILL ID" SortExpression="WaybillId">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle  hidden" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="wayBillNo" HeaderText="WAYBILL NO" SortExpression="WaybillNo">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="WaybillDate" HeaderText="WAYBILL DATE" SortExpression="PickDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DeliveryBranchName" HeaderText="DELIVERY BRANCH" SortExpression="PickDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="materialName" HeaderText="MATERIAL" SortExpression="PickupBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="typeOfPackage" HeaderText="TYPE OF PACKAGE" SortExpression="DeliveryBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueL" HeaderText="LENGTH" SortExpression="UserName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueB" HeaderText="BREADTH" SortExpression="UserBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueH" HeaderText="HEIGHT" SortExpression="creationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueCFT" HeaderText="CFT" SortExpression="DeliveryBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueActualWt" HeaderText="ACTUAL WEIGHT" SortExpression="UserName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueChargedWt" HeaderText="CHARGE WEIGHT" SortExpression="UserBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="itemQty" HeaderText="QTY" SortExpression="creationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="innerqQty" HeaderText="INNER QTY" SortExpression="UserName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO" SortExpression="UserBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="invoiceDate" HeaderText="INVOICE DATE" SortExpression="creationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="invoiceAmount" HeaderText="INVOICE AMOUNT" SortExpression="creationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fullName" HeaderText="CREATED BY" SortExpression="creationDateTime">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
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
            <!--==============================================End View Information=======================================================================-->
        </div>
    </div>
    <div class="modal" id="MaterialModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW ITEM</h4>
                </div>
                <div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel_NewMaterial">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceNo" runat="server" CssClass="label labelColor">INVOICE NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceNo" TabIndex="21" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InvoiceNo"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceDate" runat="server" CssClass="label labelColor">INVOICE DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceDate" TabIndex="22" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InvoiceDate"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceValue" runat="server" CssClass="label labelColor">INVOICE VALUE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceValue" TabIndex="23" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_InvoiceValue FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_EWaybillNo" runat="server" CssClass="label labelColor">E-WAYBILL NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_EWaybillNo" runat="server" Style="text-transform: uppercase;" TabIndex="24" AutoCompleteType="Disabled" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_EWaybillNo"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_EWaybillDate" runat="server" CssClass="label labelColor">E-WAYBILL DATE</asp:Label>
                                            <asp:TextBox ID="Txt_EWaybillDate" runat="server" Style="text-transform: uppercase;" TabIndex="25" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_EWaybillDate"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_EWaybillExpiryDate" runat="server" CssClass="label labelColor">E-WAYBILL EXPIRY DATE</asp:Label>
                                            <asp:TextBox ID="Txt_EWaybillExpiryDate" runat="server" AutoCompleteType="Disabled" TabIndex="26" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_EWaybillExpiryDate"></asp:TextBox>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <asp:HiddenField ID="AutoIncementNo" runat="server" />
                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_MaterialType" runat="server" CssClass="label labelColor">MATERIAL TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Material" runat="server" NavigateUrl="~/ReportData.aspx?value=Material" Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_MaterialType" runat="server" Style="text-transform: uppercase;" TabIndex="27" CssClass="form-control input-sm Txt_MaterialType" onchange="ReadDataonchange('Txt_MaterialType', 'hfMaterialID','', 'PickReqCRMBranch.aspx/getMaterial');"></asp:TextBox>
                                            <asp:HiddenField ID="hfMaterialID" runat="server" />
                                        </div>

                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Package" runat="server" NavigateUrl="~/ReportData.aspx?value=Package" Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_PackageType" runat="server" Style="text-transform: uppercase;" TabIndex="28" CssClass="form-control input-sm Txt_PackageType" onchange="ReadDataonchange('Txt_PackageType', 'hfPackageID','', 'PickReqCRMBranch.aspx/getPackages');"></asp:TextBox>
                                            <asp:HiddenField ID="hfPackageID" runat="server" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Unit" runat="server" CssClass="label labelColor">UNIT</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_Unit" runat="server" TabIndex="29" CssClass="formDisplay Ddl_Unit CFT">
                                                <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                                <asp:ListItem>SELECT</asp:ListItem>
                                                <asp:ListItem>CM</asp:ListItem>
                                                <asp:ListItem Selected="True">INCH</asp:ListItem>
                                                <asp:ListItem>KG</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Length" runat="server" CssClass="label labelColor">LENGTH</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Length" runat="server" TabIndex="30" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Length FirstNoSpaceAndZero CFT"></asp:TextBox>
                                            <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Breadth" runat="server" CssClass="label labelColor">BREADTH</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Breadth" runat="server" TabIndex="31" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Breadth FirstNoSpaceAndZero CFT"></asp:TextBox><%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Height" runat="server" CssClass="label labelColor">HEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Height" runat="server" TabIndex="32" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Height FirstNoSpaceAndZero CFT"></asp:TextBox>
                                            <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_CFT" runat="server" CssClass="label labelColor">CFT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_CFT" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_CFT FirstNoSpaceAndZero" Text="0"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_NoOfPackages" runat="server" CssClass="label labelColor">QTY</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_NoOfPackage" TabIndex="33" runat="server" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfPackage FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_NoOfInnerPakage" runat="server" CssClass="label labelColor">INNER QTY</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_NoOfInnerPakage" TabIndex="34" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfInnerPakage FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ActWeight" runat="server" CssClass="label labelColor">ACTUAL WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ActWeight" TabIndex="35" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_ActWeight FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ChargeWeight" runat="server" CssClass="label labelColor">CHARGE WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ChargeWeight" TabIndex="36" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_ChargeWeight FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-control-sm"></div>
                                        <div class="form-control-sm"></div>
                                        <span style="color: deepskyblue">Enter 'NA' if E-Waybill No is Not Applicable.</span>
                                    </div>

                                </div>
                            </div>

                            <!-- Modal footer -->
                            <div class="modal-footer">
                                <div class="form-group">
                                    <div class="row">
                                        <div class=" col-md-2 col-lg-3 "></div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="hfAddWaybillItem" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:LinkButton ID="Btn_AddWaybillItem" AccessKey="+" runat="server" TabIndex="37" CssClass="btn btn-info buttonStyle2" UseSubmitBehavior="false" OnClientClick="if (!validateWareHouseWaybillMaterialDetails()) {return false;};">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_Close" AccessKey="c" runat="server" TabIndex="38" CssClass="btn btn-info buttonStyle2" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <%--<asp:PostBackTrigger ControlID="Btn_consigneeSubmit" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <script src="Validation/Val_PickUpRequest.js"></script>
    <script src="FJS_File/PickupRequestCRMBranch.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
</asp:Content>

