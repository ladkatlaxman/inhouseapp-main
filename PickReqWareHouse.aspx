<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PickReqWareHouse.aspx.cs" Inherits="PickReqWareHouse" %>

<%@ Register Src="~/WaybillEntry.ascx" TagName="WaybillEntry" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <script>           

            function CalculateTotalGrandTotal() {
                var Amount = 0;
                var grandtotal = 0;
                var totalAmt;
                var GST = $("[id*=<%=WaybillEntry.FindControl("Txt_GST").ClientID%>]").val();

                //$("[id*=GV_Invoice] tr").each(function (index) {
                $("[id*=<%=WaybillEntry.FindControl("GV_Invoice").ClientID%>] tr").each(function (index) {
                    console.log(index);
                    var charges = $(this).find("td").eq(3).find("input").eq(0).val();
                    //Check if number is not empty          
                    if (charges != "") {
                        //Check if number is a valid integer               
                        if (!isNaN(charges)) {
                            Amount = Amount + parseFloat(charges);
                        }
                    }
                    console.log("Amt" + Amount);
                });

                console.log("FinalAmt" + Amount);
                $("[id*=<%=WaybillEntry.FindControl("Txt_TotalAmt").ClientID%>]").val(Amount);
                totalAmt = $("[id*=<%=WaybillEntry.FindControl("Txt_TotalAmt").ClientID%>]").val();
                if (GST != "") {
                    grandtotal = parseFloat(totalAmt) + parseFloat(totalAmt * ((GST) / 100));
                }
                else {
                    grandtotal = parseFloat(totalAmt) + parseFloat(totalAmt * ((GST) / 100));
                }
                var GSTAmt = (parseFloat(totalAmt) * GST) / 100;
                $("[id*=<%=WaybillEntry.FindControl("Txt_GSTAmt").ClientID%>]").val(GSTAmt);
                $("[id*=<%=WaybillEntry.FindControl("Txt_GrandTotalAmt").ClientID%>]").val(grandtotal);

                return false;
            }


            function CheckAvailability() {
                $("[id*=<%=WaybillEntry.FindControl("Lbl_ErrorMsg").ClientID%>]").text("");
                var WaybillNo = $("[id*=<%=WaybillEntry.FindControl("Txt_WaybillNo").ClientID%>]").val();
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
                                $("[id*=<%=WaybillEntry.FindControl("Lbl_ErrorMsg").ClientID%>]").text(item.split('ʭ')[0]);
                            }
                            if (item.split('ʭ')[0] == 'WAYBILL ALREADY MADE') {
                                $("[id*=<%=WaybillEntry.FindControl("Btn_EditData").ClientID%>]").show();
                                $("[id*=<%=WaybillEntry.FindControl("hdnEditWayBill").ClientID%>]").val(1);
                                console.log($("[id*=<%=WaybillEntry.FindControl("hdnEditWayBill").ClientID%>]").val());                              
                                return true;
                            }
                        });
                    }
                });
            }

       
            function GetPrevWayBillNo() {
            $.ajax({
            url: 'PickReqWareHouse.aspx/GetPreviousWayBillNo',
            data: "{}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id*=<%=WaybillEntry.FindControl("btnView").ClientID%>]").text(item.split('ʭ')[0]);
                                $("[id*=<%=WaybillEntry.FindControl("hfWaybillID").ClientID%>]").val(item.split('ʭ')[1]);
                                console.log(item.split('ʭ')[1]);

                            });
                        }
                    });
            }
           <%-- function InvoiceDetailForWalkin() {
                console.log(1231);
                $.ajax({
                    url: 'PickReqWareHouse.aspx/GetWaybillInvoice',
                    data: "{}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        var gridView = $("[id*=<%=WaybillEntry.FindControl("GV_Invoice").ClientID%>]");
                       var row = gridView.find("tr")
                       row.remove();
                       $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle hidden'>RATE ID</th><th class='gvHeaderStyle'>RATE TYPE</th><th class='gvHeaderStyle'>CHARGES</th></tr>");           
                Index = 0;
                $.each(data, function (index, item) {
                    console.log("loop1");
                    Index = Index + 1;
                    $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                                            "<td class='gvItemStyle hidden'>" + item.split('ʭ')[0] + "</td>" +
                                            "<td class='gvItemStyle'>" + item.split('ʭ')[1] + "</td>" +
                                             "<td class='gvItemStyle'><input type='textbox' name='charges'></td>" +
                                       "</tr>");
                });
            },
                      error: function (xhr, ajaxOptions, thrownError) {
                          alert(xhr.status);
                          alert(thrownError);
                      }
                  });
    }--%>


            $(document).keydown(function (e) {
                if (e.altKey && e.which == 86) {
                    e.preventDefault();
                    $("[id*=<%=WaybillEntry.FindControl("SameAdd").ClientID%>]").prop('checked', true);
                    var pickid = $("[id*=<%=WaybillEntry.FindControl("hfPickPinID").ClientID%>]");
                    fillPickupDetails(pickid);
                }
            });

            function getUrlParameter(sParam) {
                var sPageURL = window.location.search.substring(1),
                    sURLVariables = sPageURL.split('&'), sParameterName, i;

                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');

                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
                    }
                }
            };

            function isEmptyOrSpaces(str) {
                return str == null || str.trim() === ''; // || str.match(/^ *$/) !== null;
            }

            function getPickupIDFromURL() {
                var pickupId = getUrlParameter('PickUpId');
                console.log(pickupId);
                if (!isEmptyOrSpaces(pickupId)) {
                    if (pickupId != "") {

                        $.ajax({
                            url: 'PickReqWareHouse.aspx/FillPickUPDataForWaybill',
                            data: "{ 'strPickUpRequestId': '" + pickupId + "'}",
                            type: "POST",

                            dataType: "json",
                            contentType: 'application/json',
                            success: function (response) {
                                var data = response.d;
                                $.each(data, function (index, item) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val(item.split('ʭ')[1]);
                                    if (item.split('ʭ')[1] == 'CORPORATE') {
                                        $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
                                        $("[id*=<%=WaybillEntry.FindControl("hfCustID").ClientID%>]").val(item.split('ʭ')[3]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_CustCode").ClientID%>]").val(item.split('ʭ')[2]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_CCustName").ClientID%>]").val(item.split('ʭ')[4]);
                                    }
                                    else {
                                        $("[id*=<%=WaybillEntry.FindControl("CustomerCodeDiv").ClientID%>]").hide();
                                        $("[id*=<%=WaybillEntry.FindControl("CorporateCustomerDiv").ClientID%>]").hide();
                                        $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").show();
                                        $("[id*=<%=WaybillEntry.FindControl("hfWCustID").ClientID%>]").val(item.split('ʭ')[3]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_WCustName").ClientID%>]").val(item.split('ʭ')[4]);
                                        $("[id*=<%=WaybillEntry.FindControl("InvoiceDetailDiv").ClientID%>]").show();
                                     <%--   $("[id*=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]").removeAttr("disabled");--%>
                                        var paymentMode = $("[id*=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]");
                                        paymentMode.find('option[value=CREDIT]').remove();
                                    }

                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustMobileNo").ClientID%>]").val(item.split('ʭ')[5]);
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustTelephoneNo").ClientID%>]").val(item.split('ʭ')[6]);
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_EmailId").ClientID%>]").val(item.split('ʭ')[7]);
                                    $("[id*=<%=WaybillEntry.FindControl("hfCustPinID").ClientID%>]").val(item.split('ʭ')[8]);
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustPin").ClientID%>]").val(item.split('ʭ')[9]);
                                    $.ajax({
                                        type: "POST",
                                        url: 'PickReqWareHouse.aspx/getArea',
                                        data: "{ 'pincode': '" + item.split('ʭ')[9] + "'}",
                                        contentType: "application/json",
                                        dataType: "json",
                                        success: function (response) {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                            $.each(response.d, function () {
                                                if (this['Area'] == item.split('ʭ')[11]) {
                                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                                } else {
                                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                                }
                                            });
                                        },
                                        error: function (xhr, ajaxOptions, thrownError) {
                                            alert(xhr.status);
                                            alert(thrownError);
                                        }
                                    });
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustAdd").ClientID%>]").val(item.split('ʭ')[12]);

                                    $("[id*=<%=WaybillEntry.FindControl("hfPickPinID").ClientID%>]").val(item.split('ʭ')[13]);
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_PickPin").ClientID%>]").val(item.split('ʭ')[14]);
                                    $.ajax({
                                        type: "POST",
                                        url: 'PickReqWareHouse.aspx/getArea',
                                        data: "{ 'pincode': '" + item.split('ʭ')[14] + "'}",
                                        contentType: "application/json",
                                        dataType: "json",
                                        success: function (response) {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                            $.each(response.d, function () {
                                                if (this['Area'] == item.split('ʭ')[16]) {
                                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                                } else {
                                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                                }
                                            });
                                        },
                                        error: function (xhr, ajaxOptions, thrownError) {
                                            alert(xhr.status);
                                            alert(thrownError);
                                        }
                                    });
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_PickAdd").ClientID%>]").val(item.split('ʭ')[17]);
                                    $("[id*=<%=WaybillEntry.FindControl("hfPickupBranch").ClientID%>]").val(item.split('ʭ')[18]);
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_PickupBranch").ClientID%>]").val(item.split('ʭ')[19]);

                                    if (item.split('ʭ')[20] != 0) {
                                        $("[id*=<%=WaybillEntry.FindControl("hfConsigneeID").ClientID%>]").val(item.split('ʭ')[20]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeName").ClientID%>]").val(item.split('ʭ')[21]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeContNo").ClientID%>]").val(item.split('ʭ')[22]);
                                        $("[id*=<%=WaybillEntry.FindControl("hfDelPinID").ClientID%>]").val(item.split('ʭ')[23]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_DelPin").ClientID%>]").val(item.split('ʭ')[24]);
                                        $.ajax({
                                            type: "POST",
                                            url: 'PickReqWareHouse.aspx/getArea',
                                            data: "{ 'pincode': '" + item.split('ʭ')[24] + "'}",
                                            contentType: "application/json",
                                            dataType: "json",
                                            success: function (response) {
                                                $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                                $.each(response.d, function () {
                                                    if (this['Area'] == item.split('ʭ')[26]) {
                                                        $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                                    } else {
                                                        $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                                    }
                                                });
                                            },
                                            error: function (xhr, ajaxOptions, thrownError) {
                                                alert(xhr.status);
                                                alert(thrownError);
                                            }
                                        });
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_DelAdd").ClientID%>]").val(item.split('ʭ')[27]);
                                        $("[id*=<%=WaybillEntry.FindControl("hfDeliveryBranch").ClientID%>]").val(item.split('ʭ')[28]);
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_DeliveryBranch").ClientID%>]").val(item.split('ʭ')[29]);
                                    }

                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickType").ClientID%>]").val(item.split('ʭ')[30]);
                                    // For Disabled
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickType").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustCode").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_WCustName").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CCustName").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustMobileNo").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustTelephoneNo").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Img_WCustName").ClientID%>]").attr("disabled", "disabled");

                                    $("[id*=<%=WaybillEntry.FindControl("Txt_EmailId").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustPin").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_CustAdd").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("SameAdd").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_PickPin").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").attr("disabled", "disabled");
                                    $("[id*=<%=WaybillEntry.FindControl("Txt_PickAdd").ClientID%>]").attr("disabled", "disabled");
                                    if (item.split('ʭ')[20] != 0) {
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeName").ClientID%>]").attr("disabled", "disabled");
                                        $("[id*=<%=WaybillEntry.FindControl("Img_ConsigneeName").ClientID%>]").attr("disabled", "disabled");
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeContNo").ClientID%>]").attr("disabled", "disabled");
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_DelPin").ClientID%>]").attr("disabled", "disabled");
                                        $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").attr("disabled", "disabled");
                                        $("[id*=<%=WaybillEntry.FindControl("Txt_DelAdd").ClientID%>]").attr("disabled", "disabled");
                                    }
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickType").ClientID%>]").attr("disabled", "disabled");

                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });

                    }
                }
            }

            function YourFunction(id) {
                $("[id*=<%=PopUp.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Lbl_CurrentWaybillNo").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Label1").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("hl_consignor").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("hl_walkinConsignor").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("hl_consignee").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("PrevWayBill").ClientID%>]").hide();
                console.log(id);
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
                                $("[id*=<%=PopUp.FindControl("divCalculate").ClientID%>]").hide();
                                $("[id*=<%=PopUp.FindControl("CustomerCodeDiv").ClientID%>]").show();
                                $("[id*=<%=PopUp.FindControl("Txt_CustCode").ClientID%>]").val(item.split('ʭ')[3]);
                            }
                            else {
                                $("[id*=<%=PopUp.FindControl("CustomerCodeDiv").ClientID%>]").hide();
                                $("[id*=<%=PopUp.FindControl("divCalculate").ClientID%>]").hide();
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
                        $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>MATERIAL TYPE</th><th class='gvHeaderStyle'>PACKAGE TYPE</th><th class='gvHeaderStyle'>UNIT</th><th class='gvHeaderStyle'>LENGTH</th><th class='gvHeaderStyle'>BREADTH</th><th class='gvHeaderStyle'>HEIGHT</th><th class='gvHeaderStyle'>CFT</th><th class='gvHeaderStyle'>ACTUAL WEIGHT</th><th class='gvHeaderStyle'>QTY</th><th class='gvHeaderStyle'>INNER QTY</th><th class='gvHeaderStyle'>INVOICE NO</th><th class='gvHeaderStyle'>INVOICE DATE</th><th class='gvHeaderStyle'>INVOICE VALUE</th><th class='gvHeaderStyle'>E-WAYBILL NO</th><th class='gvHeaderStyle'>E-WAYBILL DATE</th><th class='gvHeaderStyle'>E-WAYBILL EXPIRY DATE</th></tr>");
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


                $.ajax({
                    url: 'PickReqWareHouse.aspx/GetWaybillInvoiceDetailsData',
                    data: "{ 'WaybillId': '" + id + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        var gridView = $("[id*=<%=PopUp.FindControl("GV_Invoice").ClientID%>]");
                        var row = gridView.find("tr")
                        row.remove();
                        $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>RATE TYPE</th><th class='gvHeaderStyle'>CHARGES</th></tr>");
                        Index = 0;
                        $.each(data, function (index, item) {
                            console.log("loop1");
                            Index = Index + 1;
                            $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[0] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[1] + "</td>" +
                                               "</tr>");
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });

                $("[id*=<%=PopUp.FindControl("Txt_WaybillNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_PickType").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_CustomerType").ClientID%>]").attr("disabled", "disabled");
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
                $("[id*=<%=PopUp.FindControl("SameAsText").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Txt_PickPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_PickArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_PickAdd").ClientID%>]").attr("disabled", "disabled");

                $("[id*=<%=PopUp.FindControl("Txt_ConsigneeName").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Img_ConsigneeName").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Txt_ConsigneeContNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_DelPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_DelArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_DelAdd").ClientID%>]").attr("disabled", "disabled");
              <%--  $("[id*=<%=PopUp.FindControl("Txt_EWaybillNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_EWaybillDate").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_EWaybillExpiryDate").ClientID%>]").attr("disabled", "disabled");--%>
                $("[id*=<%=PopUp.FindControl("ItemDetails").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Button").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Txt_WaybillDate").ClientID%>]").attr("disabled", "disabled");
            }


            function YourFunction1() {
                $("[id*=<%=PopUp.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Lbl_CurrentWaybillNo").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Label1").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("hl_consignor").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("hl_walkinConsignor").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("hl_consignee").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("PrevWayBill").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("divCalculate").ClientID%>]").hide();
                var waybillID = $("[id*=<%=WaybillEntry.FindControl("hfWaybillID").ClientID%>]").val();
                console.log(waybillID);
                $.ajax({
                    url: 'PickReqWareHouse.aspx/GetWaybillHeaderData',
                    data: "{ 'WaybillId': '" + waybillID + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {
                            console.log(123);
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
                    data: "{ 'WaybillId': '" + waybillID + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        var gridView = $("[id*=<%=PopUp.FindControl("GV_WaybillDetail").ClientID%>]");
                        var row = gridView.find("tr")
                        row.remove();
                        $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>MATERIAL TYPE</th><th class='gvHeaderStyle'>PACKAGE TYPE</th><th class='gvHeaderStyle'>UNIT</th><th class='gvHeaderStyle'>LENGTH</th><th class='gvHeaderStyle'>BREADTH</th><th class='gvHeaderStyle'>HEIGHT</th><th class='gvHeaderStyle'>CFT</th><th class='gvHeaderStyle'>ACTUAL WEIGHT</th><th class='gvHeaderStyle'>QTY</th><th class='gvHeaderStyle'>INNER QTY</th><th class='gvHeaderStyle'>INVOICE NO</th><th class='gvHeaderStyle'>INVOICE DATE</th><th class='gvHeaderStyle'>INVOICE VALUE</th><th class='gvHeaderStyle'>E-WAYBILL NO</th><th class='gvHeaderStyle'>E-WAYBILL DATE</th><th class='gvHeaderStyle'>E-WAYBILL EXPIRY DATE</th></tr>");
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


                $.ajax({
                    url: 'PickReqWareHouse.aspx/GetWaybillInvoiceDetailsData',
                    data: "{ 'WaybillId': '" + waybillID + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        var gridView = $("[id*=<%=PopUp.FindControl("GV_Invoice").ClientID%>]");
                        var row = gridView.find("tr")
                        row.remove();
                        $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>RATE TYPE</th><th class='gvHeaderStyle'>CHARGES</th></tr>");
                        Index = 0;
                        $.each(data, function (index, item) {
                            console.log("loop1");
                            Index = Index + 1;
                            $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[0] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[1] + "</td>" +
                                               "</tr>");
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });

                $("[id*=<%=PopUp.FindControl("Txt_WaybillNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_PickType").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_CustomerType").ClientID%>]").attr("disabled", "disabled");
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
                $("[id*=<%=PopUp.FindControl("SameAsText").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Txt_PickPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_PickArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_PickAdd").ClientID%>]").attr("disabled", "disabled");

                $("[id*=<%=PopUp.FindControl("Txt_ConsigneeName").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Img_ConsigneeName").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Txt_ConsigneeContNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_DelPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Ddl_DelArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_DelAdd").ClientID%>]").attr("disabled", "disabled");
              <%--  $("[id*=<%=PopUp.FindControl("Txt_EWaybillNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_EWaybillDate").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("Txt_EWaybillExpiryDate").ClientID%>]").attr("disabled", "disabled");--%>
                $("[id*=<%=PopUp.FindControl("ItemDetails").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Button").ClientID%>]").hide();
                $("[id*=<%=PopUp.FindControl("Txt_WaybillDate").ClientID%>]").attr("disabled", "disabled");
            }

            
            function WaybillEdit(waybillNo) {
                console.log("edit");                            
                console.log(waybillNo);
                $.ajax({
                    url: 'PickReqWareHouse.aspx/GetWaybillHeaderDataForEdit',
                    data: "{ 'WaybillNo': '" + waybillNo + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {                          
                            $("[id*=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val(item.split('ʭ')[1]);
                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]").val(item.split('ʭ')[2]);
                            if (item.split('ʭ')[1] == 'CORPORATE') {
                                $("[id*=<%=WaybillEntry.FindControl("divCalculate").ClientID%>]").hide();
                                 $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("CustomerCodeDiv").ClientID%>]").show();
                                $("[id*=<%=WaybillEntry.FindControl("CorporateCustomerDiv").ClientID%>]").show();
                                $("[id*=<%=WaybillEntry.FindControl("Txt_CustCode").ClientID%>]").val(item.split('ʭ')[3]);
                                $("[id*=<%=WaybillEntry.FindControl("hfCustID").ClientID%>]").val(item.split('ʭ')[22]);//custId,
                                $("[id*=<%=WaybillEntry.FindControl("Txt_CCustName").ClientID%>]").val(item.split('ʭ')[4]);
                            }
                            else {
                                $("[id*=<%=WaybillEntry.FindControl("CustomerCodeDiv").ClientID%>]").hide();
                                 $("[id*=<%=WaybillEntry.FindControl("CorporateCustomerDiv").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("divCalculate").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").show();
                                $("[id*=<%=WaybillEntry.FindControl("hfWCustID").ClientID%>]").val(item.split('ʭ')[22]);//WcustId,
                                $("[id*=<%=WaybillEntry.FindControl("Txt_WCustName").ClientID%>]").val(item.split('ʭ')[4]);
                            }
                           
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustMobileNo").ClientID%>]").val(item.split('ʭ')[5]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustTelephoneNo").ClientID%>]").val(item.split('ʭ')[6]);

                            $("[id*=<%=WaybillEntry.FindControl("Txt_EmailId").ClientID%>]").val(item.split('ʭ')[7]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustPin").ClientID%>]").val(item.split('ʭ')[8]);
                           
                            $.ajax({
                                type: "POST",
                                url: 'PickReqWareHouse.aspx/getArea',
                                data: "{ 'pincode': '" + item.split('ʭ')[8] + "'}",
                                contentType: "application/json",
                                dataType: "json",
                                success: function (response) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").empty().append('<option value="0">SELECT</option>');
                                    $.each(response.d, function () {
                                        if (this['Area'] == item.split('ʭ')[9]) {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                        } else {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                        }
                                    });
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(xhr.status);
                                    alert(thrownError);
                                }
                            });
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustAdd").ClientID%>]").val(item.split('ʭ')[10]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_PickPin").ClientID%>]").val(item.split('ʭ')[11]);
                            $.ajax({
                                type: "POST",
                                url: 'PickReqWareHouse.aspx/getArea',
                                data: "{ 'pincode': '" + item.split('ʭ')[11] + "'}",
                                contentType: "application/json",
                                dataType: "json",
                                success: function (response) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").empty().append('<option value="0">SELECT</option>');
                                    $.each(response.d, function () {
                                        if (this['Area'] == item.split('ʭ')[12]) {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                        } else {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                        }
                                    });
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(xhr.status);
                                    alert(thrownError);
                                }
                            });
                            $("[id*=<%=WaybillEntry.FindControl("Txt_PickAdd").ClientID%>]").val(item.split('ʭ')[13]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeName").ClientID%>]").val(item.split('ʭ')[14]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeContNo").ClientID%>]").val(item.split('ʭ')[15]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_DelPin").ClientID%>]").val(item.split('ʭ')[16]);
                            $.ajax({
                                type: "POST",
                                url: 'PickReqWareHouse.aspx/getArea',
                                data: "{ 'pincode': '" + item.split('ʭ')[16] + "'}",
                                contentType: "application/json",
                                dataType: "json",
                                success: function (response) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").empty().append('<option value="0">SELECT</option>');
                                    $.each(response.d, function () {
                                        if (this['Area'] == item.split('ʭ')[17]) {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                        } else {
                                            $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                        }
                                    });
                                },
                                error: function (xhr, ajaxOptions, thrownError) {
                                    alert(xhr.status);
                                    alert(thrownError);
                                }
                            });
                            $("[id*=<%=WaybillEntry.FindControl("Txt_DelAdd").ClientID%>]").val(item.split('ʭ')[18]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_PickupBranch").ClientID%>]").val(item.split('ʭ')[19]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_DeliveryBranch").ClientID%>]").val(item.split('ʭ')[20]);
                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PickType").ClientID%>]").val(item.split('ʭ')[21]);
                           
                            $("[id*=<%=WaybillEntry.FindControl("hfCustPinID").ClientID%>]").val(item.split('ʭ')[23]);//CustLocId
                            $("[id*=<%=WaybillEntry.FindControl("hfPickPinID").ClientID%>]").val(item.split('ʭ')[24]);//pickUpLocationId                         
                            $("[id*=<%=WaybillEntry.FindControl("hfConsigneeID").ClientID%>]").val(item.split('ʭ')[25]);//consigneeID
                            $("[id*=<%=WaybillEntry.FindControl("hfDelPinID").ClientID%>]").val(item.split('ʭ')[26]);//consigneeLocationId                          
                            $("[id*=<%=WaybillEntry.FindControl("hfPickupBranch").ClientID%>]").val(item.split('ʭ')[27]);//pickUPBranchId

                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });

                 $.ajax({
                     url: 'PickReqWareHouse.aspx/GetWaybillDetailsDataForEdit',
                     data: "{ 'WaybillNo': '" + waybillNo + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        var gridView = $("[id*=<%=WaybillEntry.FindControl("GV_WaybillDetail").ClientID%>]");
                        var row = gridView.find("tr")
                        row.remove();
                        $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>MATERIAL TYPE</th><th class='gvHeaderStyle'>PACKAGE TYPE</th><th class='gvHeaderStyle'>UNIT</th><th class='gvHeaderStyle'>LENGTH</th><th class='gvHeaderStyle'>BREADTH</th><th class='gvHeaderStyle'>HEIGHT</th><th class='gvHeaderStyle'>CFT</th><th class='gvHeaderStyle'>ACTUAL WEIGHT</th><th class='gvHeaderStyle'>CHARGE WEIGHT</th><th class='gvHeaderStyle'>QTY</th><th class='gvHeaderStyle'>INNER QTY</th><th class='gvHeaderStyle'>INVOICE NO</th><th class='gvHeaderStyle'>INVOICE DATE</th><th class='gvHeaderStyle'>INVOICE VALUE</th><th class='gvHeaderStyle'>E-WAYBILL NO</th><th class='gvHeaderStyle'>E-WAYBILL DATE</th><th class='gvHeaderStyle'>E-WAYBILL EXPIRY DATE</th></tr>");
                        Index = 0;
                        $.each(data, function (index, item) {
                            console.log("loopDetails");
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
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[16] + "</td>" +
                                               "</tr>");
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                 });

                $.ajax({
                    type: "POST",
                    url: 'PickReqWareHouse.aspx/GetWaybillItemIDForEdit',
                    data: "{ 'WaybillNo': '" + waybillNo + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (response) {
                        console.log(7856);
                        console.log($("[id$=hfWaybillID]").val());
                        $("[id*=Ddl_WaybillItemID]").empty().append('<option selected="selected" value="0">SELECT</option>');
                        $.each(response.d, function () {
                            if (this['Id'] == "") {
                                $("[id*=Ddl_WaybillItemID]").append('<option selected="selected" value=' + this['Id'] + '>' + this['SrNo'] + '</option>');
                                $("[id*=hfWaybillItemID]").val(this['Id']);
                            } else {
                                $("[id*=Ddl_WaybillItemID]").append($("<option></option>").val(this['Id']).html(this['SrNo']));
                                $("[id*=hfWaybillItemID]").val(this['Id']);
                            }
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });

                $("[id*=<%=WaybillEntry.FindControl("Txt_WaybillNo").ClientID%>]").attr("disabled", "disabled");
                <%-- $("[id*=<%=WaybillEntry.FindControl("materialDetails").ClientID%>]").hide();--%>
                $("[id*=<%=WaybillEntry.FindControl("PrevWayBill").ClientID%>]").hide();
                $("[id*=<%=WaybillEntry.FindControl("Btn_Update").ClientID%>]").show();  
                $("[id*=<%=WaybillEntry.FindControl("materialUpdate").ClientID%>]").show();  
                $("[id*=<%=WaybillEntry.FindControl("ItemDetails").ClientID%>]").hide();
                $("[id*=<%=WaybillEntry.FindControl("InvoiceDetailDiv").ClientID%>]").hide();
                $("[id*=<%=WaybillEntry.FindControl("Button").ClientID%>]").hide();

            }


            function getMaterialPackage() {
                console.log("getMaterialPack");
                $("[id$=Txt_MatType1]").val("");
                $("[id$=Txt_PackType1]").val("");
                $("[id$=hfMatID1]").val("");
                $("[id$=hfPackID1]").val("");
                $("[id$=Ddl_EditUnit]").val("SELECT");
                $("[id$=Txt_EditLength]").val("");
                $("[id$=Txt_EditBreadth]").val("");
                $("[id$=Txt_EditHeight]").val("");
                $("[id$=Txt_EditCFT]").val("");
                $("[id$=Txt_EditNoOfPackage]").val("");
                $("[id$=Txt_EditNoOfInnerPakage]").val("");
                $("[id$=Txt_EditActWeight]").val("");
                $("[id$=Txt_EditChrgWeight]").val("");
                $("[id$=Txt_EditInvoiceNo]").val("");
                $("[id$=Txt_EditInvoiceDate]").val("");
                $("[id$=Txt_EditInvoiceValue]").val("");
                $("[id$=Txt_EditEWaybillNo]").val("");
                $("[id$=Txt_EditEWaybillDate]").val("");
                $("[id$=Txt_EditEWaybillExpiryDate]").val("");
                if ($("[id$=Ddl_WaybillItemID]").text() != "SELECT") {
                    $.ajax({
                        url: 'PickReqWareHouse.aspx/getMaterialPackageName',
                        data: "{ 'id': '" + $("[id$=Ddl_WaybillItemID]").val() + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            var data = response.d;
                            $.each(data, function (index, item) {
                                console.log($("[id$=Ddl_WaybillItemID]").val());
                                $("[id$=Txt_MatType1]").val(item.split('ʭ')[0]);
                                $("[id$=Txt_PackType1]").val(item.split('ʭ')[1]);
                                $("[id$=hfMatID1]").val(item.split('ʭ')[4]);
                                $("[id$=hfPackID1]").val(item.split('ʭ')[5]);
                                $("[id$=Ddl_EditUnit]").val(item.split('ʭ')[6]);
                                $("[id$=Txt_EditLength]").val(item.split('ʭ')[7]);
                                $("[id$=Txt_EditBreadth]").val(item.split('ʭ')[8]);
                                $("[id$=Txt_EditHeight]").val(item.split('ʭ')[9]);
                                $("[id$=Txt_EditCFT]").val(item.split('ʭ')[10]);
                                $("[id$=Txt_EditNoOfPackage]").val(item.split('ʭ')[11]);
                                $("[id$=Txt_EditNoOfInnerPakage]").val(item.split('ʭ')[14]);
                                $("[id$=Txt_EditActWeight]").val(item.split('ʭ')[12]);
                                $("[id$=Txt_EditChrgWeight]").val(item.split('ʭ')[13]);
                                $("[id$=Txt_EditInvoiceNo]").val(item.split('ʭ')[15]);
                                $("[id$=Txt_EditInvoiceDate]").val(item.split('ʭ')[16]);
                                $("[id$=Txt_EditInvoiceValue]").val(item.split('ʭ')[17]);
                                $("[id$=Txt_EditEWaybillNo]").val(item.split('ʭ')[18]);
                                $("[id$=Txt_EditEWaybillDate]").val(item.split('ʭ')[19]);
                                $("[id$=Txt_EditEWaybillExpiryDate]").val(item.split('ʭ')[20]);
                            });
                        }
                    });
                } else {
                    $("[id$=Txt_MatType1]").val("");
                    $("[id$=Txt_PackType1]").val("");
                    $("[id$=hfMatID1]").val("");
                    $("[id$=hfPackID1]").val("");
                    $("[id$=Ddl_EditUnit]").text("SELECT");
                    $("[id$=Txt_EditLength]").val("");
                    $("[id$=Txt_EditBreadth]").val("");
                    $("[id$=Txt_EditHeight]").val("");
                    $("[id$=Txt_EditCFT]").val("");
                    $("[id$=Txt_EditNoOfPackage]").val("");
                    $("[id$=Txt_EditNoOfInnerPakage]").val("");
                    $("[id$=Txt_EditActWeight]").val("");
                    $("[id$=Txt_EditChrgWeight]").val("");
                    $("[id$=Txt_EditInvoiceNo]").val("");
                    $("[id$=Txt_EditInvoiceDate]").val("");
                    $("[id$=Txt_EditInvoiceValue]").val("");
                    $("[id$=Txt_EditEWaybillNo]").val("");
                    $("[id$=Txt_EditEWaybillDate]").val("");
                    $("[id$=Txt_EditEWaybillExpiryDate]").val("");
                } 
            } 
        </script>               
                                
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
        <!---Update Progress 3 ---->
        <asp:UpdateProgress ID="UpdateProgress_NewConsignor" AssociatedUpdatePanelID="UpdatePanel_NewConsignor" runat="server" DisplayAfter="0">
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
        <!---Update Progress 4 ---->
        <asp:UpdateProgress ID="UpdateProgress_NewConsignee" AssociatedUpdatePanelID="UpdatePanel_NewConsignee" runat="server" DisplayAfter="0">
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
        <!---Update Progress 5 ---->
        <asp:UpdateProgress ID="UpdateProgress_NewMaterial" AssociatedUpdatePanelID="UpdatePanel_NewMaterial" runat="server" DisplayAfter="0">
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
                    <a data-toggle="tab" href="#home" class="nav-link active tabfont">WAYBILL ENTRY</a>
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
                <!--==============================================Start Waybill Entry Information=======================================================================-->
                <div id="home" class="tab-pane active">
                    <div id="MainCustomer" runat="server">
                        <uc:WaybillEntry ID="WaybillEntry" runat="server" />
                    </div>
                </div>
                <!--==============================================End Waybill Entry Information=======================================================================-->
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
                                                    <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" TabIndex="51" Text="SEARCH" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
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
                                                <asp:GridView ID="GV_ViewWaybillDetail" runat="server" DataKeyNames="WaybillId" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowPaging="true" PageSize="10" AllowSorting="true" OnSorting="gridViewPickupRequestDetail_Sorting" OnPageIndexChanging="gridViewPickupRequestDetail_PageIndexChanging" PagerSettings-Mode="NumericFirstLast">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="Btn_ViewData" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("WaybillId","javascript:return YourFunction(\"{0}\");")%>' ToolTip="View Data">VIEW</asp:LinkButton>
                                                                <asp:HiddenField ID="hfPickUpIDValue" runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="WaybillId" HeaderText="WAYBILL ID" SortExpression="WaybillId">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle  hidden" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="WaybillNo" HeaderText="WAYBILL NO" SortExpression="WaybillNo">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PickDate" HeaderText="WAYBILL DATE" SortExpression="PickDate">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PickType" HeaderText="PICKUP TYPE" SortExpression="PickType">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle " ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass=" gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME" SortExpression="CustName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ConsigneeName" HeaderText="CONSIGNEE NAME" SortExpression="ConsigneeName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
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
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <!--=======================================================popup modal of Consignor========================================================================================-->
    <!-- Modal -->
    <div class="modal" id="ConsignorModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW CONSIGNOR</h4>
                </div>
                <div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel_NewConsignor">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupConsignorName" runat="server" class="label labelColor labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupConsignorName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorName" onkeypress="return checkNumAlpha()"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupContactNo" runat="server" class="label labelColor labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupContactNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupContactNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupConsignorPincode" runat="server" class="label labelColor labelColor">CONSIGNOR PINCODE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupConsignorPincode" runat="server" MaxLength="6" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorPincode" onchange="ReadDataonchange('Txt_PopupConsignorPincode','hfPopupConsignorPincode','Ddl_PopupConsignorArea','PickReqCRMBranch.aspx/getConsignorPincode');"></asp:TextBox>
                                            <asp:HiddenField ID="hfPopupConsignorPincode" runat="server" />
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupConsignorArea" runat="server" class="label labelColor labelColor">CONSIGNOR AREA</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_PopupConsignorArea" runat="server" CssClass="formDisplay input-sm Ddl_PopupConsignorArea">
                                                <asp:ListItem>SELECT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label1" runat="server" class="label labelColor labelColor">DISTRICT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupConsignorDistrict" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorDistrict" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label2" runat="server" class="label labelColor labelColor">CITY</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupConsignorCity" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorCity" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupConsignorAddress" runat="server" class="label labelColor labelColor">CONSIGNOR ADDRESS</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupConsignorAddress" runat="server" Style="text-transform: uppercase;" TextMode="MultiLine" CssClass="form-control input-sm Txt_PopupConsignorAddress"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopupConsignorGST" runat="server" class="label labelColor labelColor">GST NO OF CONSIGNOR</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopupConsignorGST" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorGST"></asp:TextBox>
                                        </div>


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
                                            <asp:HiddenField ID="hfPopupConsignorSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:Button ID="Btn_PopupConsignorSubmit" runat="server" CssClass="btn btn-info largeButtonStyle Btn_PopupConsignorSubmit" Text="SUBMIT"></asp:Button>
                                        </div>
                                        <%--UseSubmitBehavior="false" OnClientClick="if (!validatePickupRequestConsignorDetails()) {return false;};"--%>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_PopupConsignorClose" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <%--                            <asp:PostBackTrigger ControlID="Btn_PopupConsignorSubmit"/>--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=================================================== End Consignor Popup Modal===============================================================-->

    <!--=======================================================popup modal of Consignee========================================================================================-->
    <div class="modal" id="ConsigneeModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW CONSIGNEE</h4>
                </div>
                <div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel_NewConsignee">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneeName" runat="server" class="label labelColor labelColor">CONSIGNEE NAME</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneeName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeName" onkeypress="return checkAlphaNumericWithSpace()"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneeContactNo" runat="server" class="label labelColor labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneeContactNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeContactNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneePincode" runat="server" class="label labelColor labelColor">CONSIGNEE PINCODE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneePincode" runat="server" MaxLength="6" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneePincode" onchange="ReadDataonchange('Txt_PopConsigneePincode','hfPopConsigneePincode','Ddl_PopConsigneeArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                            <asp:HiddenField ID="hfPopConsigneePincode" runat="server" />
                                        </div>

                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneeArea" runat="server" class="label labelColor labelColor">CONSIGNEE AREA</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_PopConsigneeArea" runat="server" CssClass="formDisplay input-sm Ddl_PopConsigneeArea">
                                                <asp:ListItem>SELECT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label3" runat="server" class="label labelColor labelColor">DISTRICT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneeDistrict" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeDistrict" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label4" runat="server" class="label labelColor labelColor">CITY</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneeCity" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeCity" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_popConsigneeAddress" runat="server" class="label labelColor labelColor">CONSIGNEE ADDRESS</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_popConsigneeAddress" runat="server" Style="text-transform: uppercase;" TextMode="MultiLine" CssClass="form-control input-sm Txt_popConsigneeAddress"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopGSTNoOfConsignee" runat="server" class="label labelColor labelColor">GST NO OF CONSIGNEE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopGSTNoOfConsignee" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopGSTNoOfConsignee"></asp:TextBox>
                                        </div>
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
                                            <asp:HiddenField ID="hfConsigneeSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:Button ID="Btn_ConsigneeSubmit" runat="server" CssClass="btn btn-info largeButtonStyle Btn_ConsigneeSubmit" Text="SUBMIT"></asp:Button>
                                        </div>
                                        <%--UseSubmitBehavior="false" OnClientClick="if (!validatePickupRequestConsigneeDetails()) {return false;};"--%>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_ConsigneeClose" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <%--                            <asp:PostBackTrigger ControlID="Btn_consigneeSubmit" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=======================================================End popup modal of Consignee========================================================================================-->

    <!--================================================PopUp Window for New AreaCreation============================================================================-->
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
    <!--=====================================End Popup Window for New Area Creation====================================================-->

    <div class="modal" id="MaterialModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW ITEM</h4>
                    <asp:Label ID="Lbl_InWaybillNo" runat="server"></asp:Label>
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
                                            <asp:HyperLink ID="hl_Material" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Material" Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_MaterialType" runat="server" Style="text-transform: uppercase;" TabIndex="27" CssClass="form-control input-sm Txt_MaterialType" onchange="ReadDataonchange('Txt_MaterialType', 'hfMaterialID','', 'PickReqCRMBranch.aspx/getMaterial');"></asp:TextBox>
                                            <asp:HiddenField ID="hfMaterialID" runat="server" />
                                        </div>

                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Package" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Package" Target="_blank">List</asp:HyperLink>
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
                                                 <%--  <asp:ListItem>SELECT</asp:ListItem>--%>
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
                                            <asp:TextBox ID="Txt_ActWeight" TabIndex="35" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" onchange="validateLimit()" CssClass="form-control input-sm Txt_ActWeight FirstNoSpaceAndZero"></asp:TextBox>
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

    <script src="FJS_File/PickupRequestCRMBranch.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Val_PickUpRequest.js"></script>
   
</asp:Content>

