<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Delivery.aspx.cs" Inherits="Delivery" %>

<%@ Register Src="~/WaybillEntry.ascx" TagName="WaybillEntry" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function FillWaybillData(id) {
            console.log(id);
            $("[id*=<%=PopUp.FindControl("currentWaybills").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_consignor").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_walkinConsignor").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("SameAsText").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_consignee").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("InvoiceDetailDiv").ClientID%>]").hide();

            $.ajax({
                url: 'PickReqWareHouse.aspx/GetWaybillHeaderData',
                data: "{ 'WaybillId': '" + id + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    var data = response.d;
                    $.each(data, function (index, item) {
                        $("[id*=<%=PopUp.FindControl("Txt_WaybillNo").ClientID%>]").val(item.split('ʭ')[0]);
                        $("[id*=<%=PopUp.FindControl("Ddl_CustomerType").ClientID%>]").val(item.split('ʭ')[1]);
                        $("[id*=<%=PopUp.FindControl("Ddl_PaymentMode").ClientID%>]").val(item.split('ʭ')[2]);
                        if (item.split('ʭ')[1] == 'CORPORATE') {
                            $("[id*=<%=PopUp.FindControl("CustomerCodeDiv").ClientID%>]").show();
                            $("[id*=<%=PopUp.FindControl("Txt_CustCode").ClientID%>]").val(item.split('ʭ')[3]);
                        }
                        else {
                            $("[id*=<%=PopUp.FindControl("CustomerCodeDiv").ClientID%>]").hide();
                        }
                        $("[id*=<%=PopUp.FindControl("Txt_CCustName").ClientID%>]").val(item.split('ʭ')[4]);
                        $("[id*=<%=PopUp.FindControl("Txt_CustMobileNo").ClientID%>]").val(item.split('ʭ')[5]);
                        $("[id*=<%=PopUp.FindControl("Txt_CustTelephoneNo").ClientID%>]").val(item.split('ʭ')[6]);
                        $("[id*=<%=PopUp.FindControl("Txt_EmailId").ClientID%>]").val(item.split('ʭ')[7]);
                        $("[id*=<%=PopUp.FindControl("Txt_CustPin").ClientID%>]").val(item.split('ʭ')[8]);
                        $.ajax({
                            type: "POST",
                            url: 'PickReqWareHouse.aspx/getArea',
                            data: "{ 'pincode': '" + item.split('ʭ')[8] + "'}",
                            contentType: "application/json",
                            dataType: "json",
                            success: function (response) {
                                $("[id*=<%=PopUp.FindControl("Ddl_CustArea").ClientID%>]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                $.each(response.d, function () {
                                    if (this['Area'] == item.split('ʭ')[9]) {
                                        $("[id*=<%=PopUp.FindControl("Ddl_CustArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                    } else {
                                        $("[id*=<%=PopUp.FindControl("Ddl_CustArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                    }
                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });
                        $("[id*=<%=PopUp.FindControl("Txt_CustAdd").ClientID%>]").val(item.split('ʭ')[10]);
                        $("[id*=<%=PopUp.FindControl("Txt_PickPin").ClientID%>]").val(item.split('ʭ')[11]);
                        $.ajax({
                            type: "POST",
                            url: 'PickReqWareHouse.aspx/getArea',
                            data: "{ 'pincode': '" + item.split('ʭ')[11] + "'}",
                            contentType: "application/json",
                            dataType: "json",
                            success: function (response) {
                                $("[id*=<%=PopUp.FindControl("Ddl_PickArea").ClientID%>]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                $.each(response.d, function () {
                                    if (this['Area'] == item.split('ʭ')[12]) {
                                        $("[id*=<%=PopUp.FindControl("Ddl_PickArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                    } else {
                                        $("[id*=<%=PopUp.FindControl("Ddl_PickArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                    }
                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });
                        $("[id*=<%=PopUp.FindControl("Txt_PickAdd").ClientID%>]").val(item.split('ʭ')[13]);
                        $("[id*=<%=PopUp.FindControl("Txt_ConsigneeName").ClientID%>]").val(item.split('ʭ')[14]);
                        $("[id*=<%=PopUp.FindControl("Txt_ConsigneeContNo").ClientID%>]").val(item.split('ʭ')[15]);
                        $("[id*=<%=PopUp.FindControl("Txt_DelPin").ClientID%>]").val(item.split('ʭ')[16]);
                        $.ajax({
                            type: "POST",
                            url: 'PickReqWareHouse.aspx/getArea',
                            data: "{ 'pincode': '" + item.split('ʭ')[16] + "'}",
                            contentType: "application/json",
                            dataType: "json",
                            success: function (response) {
                                $("[id*=<%=PopUp.FindControl("Ddl_DelArea").ClientID%>]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                $.each(response.d, function () {
                                    if (this['Area'] == item.split('ʭ')[17]) {
                                        $("[id*=<%=PopUp.FindControl("Ddl_DelArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                    } else {
                                        $("[id*=<%=PopUp.FindControl("Ddl_DelArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                    }
                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });
                        $("[id*=<%=PopUp.FindControl("Txt_DelAdd").ClientID%>]").val(item.split('ʭ')[18]);
                        $("[id*=<%=PopUp.FindControl("Txt_PickupBranch").ClientID%>]").val(item.split('ʭ')[19]);
                        $("[id*=<%=PopUp.FindControl("Txt_DeliveryBranch").ClientID%>]").val(item.split('ʭ')[20]);
                        $("[id*=<%=PopUp.FindControl("Ddl_PickType").ClientID%>]").val(item.split('ʭ')[21]);
                        $("[id*=<%=PopUp.FindControl("Txt_WaybillDate").ClientID%>]").val(item.split('ʭ')[22]);
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });

            $.ajax({
                url: 'PickReqWareHouse.aspx/GetWaybillDetailsData',
                data: "{ 'WaybillId': '" + id + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    var data = response.d;
                    var gridView = $("[id*=<%=PopUp.FindControl("GV_WaybillDetail").ClientID%>]");
                    var row = gridView.find("tr")
                    row.remove();
                    $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>MATERIAL TYPE</th><th class='gvHeaderStyle'>PACKAGE TYPE</th><th class='gvHeaderStyle'>UNIT</th><th class='gvHeaderStyle'>LENGTH</th><th class='gvHeaderStyle'>BREADTH</th><th class='gvHeaderStyle'>HEIGHT</th><th class='gvHeaderStyle'>CFT</th><th class='gvHeaderStyle'>ACTUAL WEIGHT</th><th class='gvHeaderStyle'>NO OF PACKAGES</th><th class='gvHeaderStyle'>NO OF INNER PACKAGES</th><th class='gvHeaderStyle'>INVOICE NO</th><th class='gvHeaderStyle'>INVOICE DATE</th><th class='gvHeaderStyle'>INVOICE VALUE</th><th class='gvHeaderStyle'>E-WAYBILL NO</th><th class='gvHeaderStyle'>E-WAYBILL DATE</th><th class='gvHeaderStyle'>E-WAYBILL EXPIRY DATE</th></tr>");
                    Index = 0;
                    $.each(data, function (index, item) {
                        console.log("loop");
                        Index = Index + 1;
                        $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[0] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[1] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[2] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[3] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[4] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[5] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[6] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[7] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[8] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[9] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[10] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[11] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[12] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[13] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[14] + "</td>" +
                                                "<td class='gvItemStyle'>" + item.split('ʭ')[15] + "</td>" +
                                           "</tr>");
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });

            $("[id*=<%=PopUp.FindControl("Txt_WaybillNo").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Ddl_CustomerType").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Ddl_PickType").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Ddl_PaymentMode").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_CustCode").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_CCustName").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_CustMobileNo").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_CustTelephoneNo").ClientID%>]").attr("disabled", "disabled");

            $("[id*=<%=PopUp.FindControl("Txt_EmailId").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_CustPin").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Ddl_CustArea").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_CustAdd").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("SameAdd").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Txt_PickPin").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Ddl_PickArea").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_PickAdd").ClientID%>]").attr("disabled", "disabled");

            $("[id*=<%=PopUp.FindControl("Txt_ConsigneeName").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Img_ConsigneeName").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Txt_ConsigneeContNo").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_DelPin").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Ddl_DelArea").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Txt_DelAdd").ClientID%>]").attr("disabled", "disabled");

            $("[id*=<%=PopUp.FindControl("ItemDetails").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Button").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Txt_WaybillDate").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=PopUp.FindControl("Btn_Update").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("materialUpdate").ClientID%>]").hide();

        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <div id="AlertNotification"></div>
        <div class="panel  panelTop">
            <div class="panel-heading panelHead">
                <b>DELIVERY</b>
                <div style="text-align: right; text-wrap: inherit;">
                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL QTY:</asp:Label>
                    <asp:Label ID="Lbl_TotalQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                    <asp:Label ID="Label3" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL WEIGHT:</asp:Label>
                    <asp:Label ID="Lbl_TotalWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                </div>
            </div>
            <div class="panel-body labelColor">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" style="text-align: right">
                                <asp:Label ID="lblSelectVehicle" runat="server" CssClass="label labelColor">SELECT VEHICLE</asp:Label>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <asp:HiddenField ID="hfDdlVehicle" runat="server" />
                                <asp:DropDownList ID="Ddl_SelectVehicle" runat="server" CssClass="formDisplay input-sm Ddl_SelectVehicle">
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <asp:LinkButton ID="btnGetDetails" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle btnGetDetails" OnClick="btnGetDetails_Click">GET LIST&nbsp;</asp:LinkButton>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <asp:Label ID="lblDRSNo" runat="server" CssClass="label labelColor lblDRSNo"></asp:Label>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <asp:LinkButton ID="btnPrintDRS" runat="server" Text="PRINT LIST" CssClass="btn btn-info largeButtonStyle btnPrintDRS" OnClick="btnPrintDRS_Click">PRINT LIST&nbsp;</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <asp:GridView ID="gvwDeliveryWaybills" runat="server" AutoGenerateColumns="false" OnRowCommand="gvwDeliveryWaybills_RowCommand" OnRowDataBound="gvwDeliveryWaybills_RowDataBound" CssClass="table table-condensed table-bordered table-hover table-responsive">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="WayBillItemId" HeaderText="ITEM ID">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="WAYBILL NO">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="Btn_Waybill" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("waybillID","javascript:FillWaybillData({0});")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle hidden" />
                                </asp:BoundField>
                                <asp:BoundField DataField="waybillID" HeaderText="WAYBILL ID">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="wayBillHeader.paymentMode" HeaderText="PAYMENT MODE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="materialName" HeaderText="ITEM NAME">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="packNAme" HeaderText="PACKAGE">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE NO">
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
                                <asp:BoundField DataField="remQty" HeaderText="REM QTY">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="RECEIVED QTY" ItemStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="receivedItemQty" AutoCompleteType="Disabled" Text='<%# Eval("remQty") %>' TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                        <asp:Label ID="Lbl_QtyError" runat="server" ForeColor="Red"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                              
                                <asp:TemplateField HeaderText="REMARK" ItemStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="Txt_Remark" AutoCompleteType="Disabled" TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="Btn_Unload" runat="server" CommandName="DELIVERY" CommandArgument='<%# Container.DataItemIndex %>' Text="DELIVERY"></asp:LinkButton><%--CommandArgument='<%# Eval("tblWayBillItemId")  OnClick="Btn_Unload_Click"%>'--%>
                                                    <asp:Label ID="Lbl_Unloaded" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PAYMENT MODE">
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="Btn_Payment" runat="server" CommandName="ToPay" CommandArgument='<%# Container.DataItemIndex %>' Text='<%#Eval("wayBillHeader.paymentMode") %>'></asp:LinkButton><%--CommandArgument='<%# Eval("tblWayBillItemId")  OnClick="Btn_Unload_Click"%>'--%>                                                 
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <!--***************************************************************************************************************-->
            <div id="DeliveredItems" runat="server" visible="false">
                <div class="panel-heading panelHead">
                    <b>DELIVERED WAYBILL MATERIAL</b>
                    <div style="text-align: right; text-wrap: inherit;">
                        <asp:Label ID="Label4" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL LOADED QTY:</asp:Label>
                        <asp:Label ID="Lbl_TotalLoadedQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label6" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL LOADED WEIGHT:</asp:Label>
                        <asp:Label ID="Lbl_TotalLoadedWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <asp:GridView ID="GV_DeliveredWaybillItems" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="wayBillNo" HeaderText="WAYBILL NO">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="WaybillDate" HeaderText="WAYBILL DATE">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="materialName" HeaderText="ITEM NAME">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="typeOfPackage" HeaderText="PACKAGE">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="valueActualWt" HeaderText="WEIGHT">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="DELIVERED QTY">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Remark" HeaderText="REMARK">
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
        </div>

    </div>


    <!--================================================PopUp Window for Waybill Detail============================================================================-->
    <!-- Modal -->
    <div class="modal" id="modalForViewData" role="dialog">
        <div class="modal-dialog modal-lg">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">WAYBILL DETAIL</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <uc:WaybillEntry ID="PopUp" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for Waybill Detail====================================================-->

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="js/AlertNotifictaion.js"></script>

</asp:Content>

