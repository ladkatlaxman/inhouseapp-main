<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WBEntry.aspx.cs" Inherits="WBEntry" %>
<%@ Register Src="~/WBEntry.ascx" TagName="wbentry" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" /> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager> 
    <script> 

        $(".Ddl_PaymentMode option[value = 'PAID']").remove(); 
        $(".Ddl_PaymentMode option[value = 'TO PAY']").remove(); 

        //CurrentWaybillNo();
        //GetPrevWayBillNo();
        function CalculateTotalGrandTotal() {
            var Amount = 0;
            var grandtotal = 0;
            var totalAmt;
            var GST = $("[id*=<%=WaybillEntry.FindControl("Txt_GST").ClientID%>]").val();

            $("[id*=<%=WaybillEntry.FindControl("GV_Invoice").ClientID%>] tr").each(function (index) {
                //console.log(index);
                var charges = $(this).find("td").eq(3).find("input").eq(0).val();
                //Check if number is not empty          
                if (charges != "") {
                    //Check if number is a valid integer               
                    if (!isNaN(charges)) {
                        Amount = Amount + parseFloat(charges);
                    }
                }
                //console.log("Amt" + Amount);
            });

            //console.log("FinalAmt" + Amount);
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
            $("[id*=<%=WaybillEntry.FindControl("hfCalculated").ClientID%>]").val('1');
            return false;
        }

        function CheckAvailability() {
            $("[id*=<%=WaybillEntry.FindControl("Lbl_ErrorMsg").ClientID%>]").text("");
            if ($("[id*=<%=WaybillEntry.FindControl("Txt_WaybillNo").ClientID%>]").val().trim() != "") {
                var WaybillNo = $("[id*=<%=WaybillEntry.FindControl("Txt_WaybillNo").ClientID%>]").val();
                $.ajax({
                    type: "POST",
                    url: 'WBEntry.aspx/CheckWaybillNo',
                    data: '{waybillNo: "' + WaybillNo + '" }',
                    contentType: 'application/json',
                    dataType: "json",
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {
                            if (item.split('ʭ')[0] != 'AVAILABLE') {
                                $("[id*=<%=WaybillEntry.FindControl("Lbl_ErrorMsg").ClientID%>]").text(item.split('ʭ')[0]);
                            }
                        });
                    }
                });
            }
        }

        //function GetPrevWayBillNo() {
        //    return; 
        //    $.ajax({
        //        url: 'WBEntry.aspx/GetPreviousWayBillNo',
        //        data: "{}",
        //        dataType: "json",
        //        type: "POST",
        //        contentType: "application/json; charset=utf-8",
        //        success: function (response) {
        //            var data = response.d;
        //            $.each(data, function (index, item) { 
        //                $("[id*=<%=WaybillEntry.FindControl("btnView").ClientID%>]").text(item.split('ʭ')[0]);
        //                $("[id*=<%=WaybillEntry.FindControl("hfWaybillID").ClientID%>]").val(item.split('ʭ')[1]);
        //                $("[id *=<%=WaybillEntry.FindControl("lnkPrevWayBill").ClientID%>]").attr("href", "WayBillPrint.aspx?WayBillNo=" + item.split('ʭ')[0]); // Set href value 
        //        });
        //        }
        //    });
        //} 

        function getPickupIDFromURL() {
            var pickupId = getUrlParameter('PickUpId');
            if (!isEmptyOrSpaces(pickupId)) {
                if (pickupId != "") {

                    $.ajax({
                        url: 'WBEntry.aspx/FillPickUPDataForWaybill',
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
                                        url: 'WBEntry.aspx/getArea',
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
                                        url: 'WBEntry.aspx/getArea',
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
                                            url: 'WBEntry.aspx/getArea',
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

        function MaterialForEWayBill(ewaybillno) {
            $("[id$=<%=GV_EwayBillMaterial.ClientID%>]").empty();
            //alert(ewaybillno); 
            $.ajax({
                url: 'WBEntry.aspx/GetEWaybillInvoice',
                data: "{ 'EWayBillNo': '" + ewaybillno + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    var strHeader = "<tr><th class='gvHeaderStyle'>SR.NO</th>" +
                        "<th class='gvHeaderStyle'>Invoice No</th> " +
                        "<th class='gvHeaderStyle'>Invoice Date</th>" +
                        "<th class='gvHeaderStyle'>Invoice Value</th>" +
                        "<th class='gvHeaderStyle'>Material type</th>" +
                        "<th class='gvHeaderStyle'>Package Type</th>" +
                        "<th class='gvHeaderStyle'>Qty</th>" +
                        "<th class='gvHeaderStyle'>Inner Qty</th>" +
                        "<th class='gvHeaderStyle'>Actual Weight</th>" +
                        "<th class='gvHeaderStyle'>Charged Weight</th>" +
                        "</tr > ";
                    //$("[id$=<%=GV_EwayBillMaterial.ClientID%>]").append(strHeader)
                    for (var i = 0; i < response.d.length; i++) {
                        Index = i + 1;
                        $("[id$=<%=GV_EwayBillMaterial.ClientID%>]").append("<tr><td class='gvItemStyle'><b>" + Index + "</b></td>" + 
                            "<td>Inv No</td><td class='gvItemStyle'><input type='textbox' readonly='readonly' name='txtInvNo" + Index + "' id='txtInvNo" + Index + "' value='" + response.d[i].split('ʭ')[0] + "'></td>" + 
                            "<td>Inv Date</td><td class='gvItemStyle'><input type='textbox' readonly='readonly' name='txtInvDate" + Index + "' id='txtInvDate" + Index + "' value='" + response.d[i].split('ʭ')[1] + "'></td>" +
                            "<td nowrap>Inv Value</td><td class='gvItemStyle'><input type='textbox' readonly='readonly' name='txtInvVal" + Index + "' id='txtInvVal" + Index + "' value='" + response.d[i].split('ʭ')[2] + "'></td>" +
                            "</tr><tr><td></td>" + 
                            "<td nowrap>Material Type</td><td class='gvItemStyle'><input type='textbox' name='Txt_EWayMatType" + Index + "' id='Txt_EWayMatType" + Index + "' value='' class='formDisplay EMAT'></td></td>" +
                            "<td nowrap>Package type</td><td class='gvItemStyle'><input type='textbox' name='packagetype' value=''></td></td>" +
                            "<td></td><td></td></tr><tr><td></td>" +
                            "<td>Qty</td><td class='gvItemStyle'><input type='textbox' readonly='readonly' name='txtEWQty" + Index + "' id='txtEWQty" + Index + "' value='" + response.d[i].split('ʭ')[3] + "'></td>"+
                            "<td>Inner Qty</td><td class='gvItemStyle'><input type='textbox' name='txtEWInnQty" + Index + "' id='txtEWInnQty" + Index + "' value='1'></td>" +
                            "<td></td><td></td></tr><tr><td></td>" +
                            "<td>Actual Wt</td><td class='gvItemStyle'><input type='textbox' readonly='readonly' name='txtEWActualWt" + Index + "' id='txtEWActualWt" + Index + "' value='" + response.d[i].split('ʭ')[4] + "'></td>" +
                            "<td>Charged Wt</td><td class='gvItemStyle'><input type='textbox' name='txtEWChargedWt" + Index + "' id='txtEWChargedWt" + Index + "' value='" + response.d[i].split('ʭ')[4] + "'></td>" +
                            "<td></td><td></td></tr><tr><td>&nbsp;</td></tr>")
                    };
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });
        }

        function InvoiceDetailForWalkin(type) {
            $("[id$=BtnAddEWayBillInvoice]").hide();
            $("[id$=Btn_AddNewInvoice]").hide();
            $("[id$=InvoiceDetailDiv]").show();
            $("[id$=<%=WaybillEntry.FindControl("GV_Invoice").ClientID%>]").empty();
            if (type == 'CREDIT' || type == 'FREE' || type == 'REVERSE') {
                $("[id$=InvoiceDetailDiv]").hide();
                return;
            }
            $.ajax({
                url: 'WBEntry.aspx/GetWaybillInvoice',
                data: "{ 'type': '" + type + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    $("[id$=<%=WaybillEntry.FindControl("GV_Invoice").ClientID%>]").append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle hidden'>RATE ID</th><th class='gvHeaderStyle'>RATE TYPE</th><th class='gvHeaderStyle'>CHARGES</th></tr>") 
                    for (var i = 0; i < response.d.length; i++) { 
                        Index = i + 1; 
                        $("[id$=<%=WaybillEntry.FindControl("GV_Invoice").ClientID%>]").append("<tr><td class='gvItemStyle'>" + Index + "</td>" + 
                            "<td class='gvItemStyle hidden'>" + response.d[i].split('ʭ')[0] + "</td>" + 
                            "<td class='gvItemStyle'>" + response.d[i].split('ʭ')[1] + "</td>" + 
                            "<td class='gvItemStyle'><input type='textbox' name='charges' value=" + response.d[i].split('ʭ')[2] + "></td>" + 
                            "</tr>") 
                    }; 
                }, 
                error: function (xhr, ajaxOptions, thrownError) { 
                    alert(xhr.status); 
                    alert(thrownError); 
                } 
            }); 
        } 

        function YourFunction1() {
            $("[id*=<%=PopUp.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Lbl_CurrentWaybillNo").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("lblCurrentWBNo").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_consignor").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_walkinConsignor").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_consignee").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("PrevWayBill").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("divCalculate").ClientID%>]").hide();
            var waybillID = $("[id*=<%=WaybillEntry.FindControl("hfWaybillID").ClientID%>]").val();
            console.log(waybillID);
            $.ajax({
                url: 'WBEntry.aspx/GetWaybillHeaderData',
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
                            url: 'WBEntry.aspx/getArea',
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
                            url: 'WBEntry.aspx/getArea',
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
                            url: 'WBEntry.aspx/getArea',
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
                url: 'WBEntry.aspx/GetWaybillDetailsData',
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
                url: 'WBEntry.aspx/GetWaybillInvoiceDetailsData',
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
            $("[id*=<%=PopUp.FindControl("ItemDetails").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Button").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("Txt_WaybillDate").ClientID%>]").attr("disabled", "disabled");
        }

        function EWayBillData() {
            var EWayBillNo = $("[id*=<%=txtModalEWayBillNo.ClientID%>]").val(); 
            console.log(EWayBillNo);
            $.ajax({
                url: 'WBEntry.aspx/GetEwayBillData',
                data: "{ 'sEWayBillNo': '" + EWayBillNo + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    //alert(response.d); 
                    var data = response.d;
                    var gridView = $("[id*=<%=GV_EwayBillMaterial.ClientID%>]");
                    var row = gridView.find("tr") 
                    row.remove();
                    $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th>" + 
                        "<th style='display: none;'> MATERIAL ID</th>" + 
                        "<th class='gvHeaderStyle'>  MATERIAL TYPE</th>" + 
                        "<th style='display: none;'> PACKAGE ID</th>" + 
                        "<th class= 'gvHeaderStyle'> PACKAGE TYPE</th>" + 
                        "<th class='gvHeaderStyle'>  UNIT</th>" + 
                        "<th class='gvHeaderStyle'>  WEIGHT</th>" + 
                        "<th class='gvHeaderStyle'>  QTY</th>" + 
                        "<th class= 'gvHeaderStyle'> INVOICE NO</th>" + 
                        "<th class='gvHeaderStyle'>  INVOICE DATE</th>" + 
                        "<th class='gvHeaderStyle'>  INVOICE VALUE</th>"); 
                    Index = 0;
                    $.each(data, function (index, item) {
                        console.log("loop");
                        Index = Index + 1;
                        $(gridView).append("<tr>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[0] + "</td>" +
                            "<td style='display: none;'>" + item.split('ʭ')[1] + "</td>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[2] + "</td>" +
                            "<td style='display: none;'>" + item.split('ʭ')[3] + "</td>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[4] + "</td>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[5] + "</td>" +
                            "<td class='gvItemStyle'><input type='textbox' name='txtEWayWt" + Index + "' id='txtEWayWt" + Index + "' value='" + item.split('ʭ')[6] + "'></input></td>" + 
                            "<td class='gvItemStyle'>" + item.split('ʭ')[7] + "</td>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[8] + "</td>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[9] + "</td>" +
                            "<td class='gvItemStyle'>" + item.split('ʭ')[10] + "</td>" +
                            "</tr>");
                        $("[id*=txtModalEWayBillDate").val(item.split('ʭ')[11]);
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });
        }

        $(document).keydown(function (e) {
            if (e.altKey && e.which == 86) {
                e.preventDefault();
                $("[id*=<%=WaybillEntry.FindControl("SameAdd").ClientID%>]").prop('checked', true);
                var pickid = $("[id*=<%=WaybillEntry.FindControl("hfPickPinID").ClientID%>]");
                fillPickupDetails(pickid);
            }
        });

        $("[id *=Txt_EWaybillDate]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
        $("[id$=<%=Txt_EWaybillDate.ClientID%>]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0 }).datepicker();
        $("[id$=Txt_EWaybillExpiryDate]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
        $("[id *=Txt_WaybillDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0, minDate: -1 }).datepicker("setDate", new Date());
        $("[id *=Txt_InvoiceDate1]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
        if ($("[id *=Txt_SearchFromDate]").val() == "") {
            $("[id *=Txt_SearchFromDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0 }).datepicker("setDate", new Date());
        } else {
            $("[id *=Txt_SearchFromDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0 }).datepicker("setDate", $("[id *=Txt_SearchFromDate]").val());
        } if ($("[id *=Txt_SearchToDate]").val() == "") {
            $("[id *=Txt_SearchToDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0 }).datepicker("setDate", new Date());
        } else {
            $("[id *=Txt_SearchToDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0 }).datepicker("setDate", $("[id *=Txt_SearchToDate]").val());
        }

        $(document).ready(function () {

            $("[id*=Button_Submit]").bind("click", function () {
                var hfWaybillSubmit = $("[id*=hfWaybillSubmit]");
                //alert(hfWaybillSubmit.val());

                if (hfWaybillSubmit.val() == 1) {
                    $("[id*=LoadingImage]").show();
                    var PickReqHeader = {};
                    var PickReqDetail = []; var Count;
                    var pickReqInvoice = []; var Count1;

                    PickReqHeader.PickType = $("[id$=Ddl_PickType]").val();
                    PickReqHeader.WaybillNo = $("[id*=Txt_WaybillNo]").val();
                    PickReqHeader.WaybillDate = $("[id$=Txt_WaybillDate]").val();
                    PickReqHeader.CustType = $("[id*=Ddl_CustomerType]").val();
                    PickReqHeader.PaymentMode = $("[id*=Ddl_PaymentMode]").val();
                    if (PickReqHeader.CustType == "CORPORATE") {
                        PickReqHeader.CustID = $("[id$=hfCustID]").val();
                        PickReqHeader.walkinCustId = 0;
                    }
                    else {
                        PickReqHeader.walkinCustId = $("[id$=hfWCustID]").val();
                        console.log('Consignor ID :- ' + $("[id$=hfWCustID]").val());
                        PickReqHeader.CustID = 0;
                    }
                    PickReqHeader.CustContactNo = $("[id*=Txt_CustMobileNo]").val();
                    PickReqHeader.CustTelephone = $("[id*=Txt_CustTelephoneNo]").val();
                    PickReqHeader.CustEmailId = $("[id*=Txt_EmailId]").val();
                    PickReqHeader.CustLocID = $("[id*=hfCustPinID]").val();
                    PickReqHeader.CustAreaID = $("[id$=Ddl_CustArea]").val();
                    PickReqHeader.CustAddress = $("[id*=Txt_CustAdd]").val();
                    PickReqHeader.PickLocID = $("[id*=hfPickPinID]").val();
                    if ($("[id*=Ddl_PickArea]").val() == 0 | $("[id*=Ddl_PickArea]").val() == '') {
                        PickReqHeader.PickAreaID = $("[id$=Ddl_CustArea]").val();
                    } else {
                        PickReqHeader.PickAreaID = $("[id*=Ddl_PickArea]").val();
                    }
                    PickReqHeader.PickAddress = $("[id*=Txt_PickAdd]").val();
                    PickReqHeader.ConsigneeID = $("[id$=hfConsigneeID]").val();
                    PickReqHeader.ConsigneeContactNo = $("[id*=Txt_ConsigneeContNo]").val();
                    PickReqHeader.DelLocID = $("[id*=hfDelPinID]").val();
                    PickReqHeader.DelAreaID = $("[id*=Ddl_DelArea]").val();
                    PickReqHeader.DelAddress = $("[id*=Txt_DelAdd]").val();
                    PickReqHeader.PickupBranch = $("[id*=hfPickupBranch]").val();

                    //Material Details
                    t = 0;
                    $("[id*=GV_WaybillDetail] tr").each(function () {
                        Count = ($(this).length) - 1;
                        if (!this.rowIndex) return;
                        var SubDetail = {};

                        console.log("length:" + $(this).length);
                        if ($.trim($(this).find("td").eq(1).html()) == "&nbsp;" || $(this).find("td").eq(1).find("input").eq(0).val() == "") { }
                        else {
                            console.log($(this).find("td").eq(1).html());
                            console.log($(this).find("td").eq(1).find("input").eq(0).val());
                            console.log("t:" + t);
                            t += "," + 0;
                            var a = t.indexOf($(this).find("td").eq(0).find("input").eq(0).val());
                            console.log("a:" + a);
                            if (a == -1 && $.trim($(this).find("td").eq(0).html()) != "&nbsp;") {
                                SubDetail.MaterialID = $(this).find("td").eq(1).find("input").eq(0).val();
                                SubDetail.PackageID = $(this).find("td").eq(3).find("input").eq(0).val();
                                SubDetail.Unit = $(this).find("td").eq(5).find("input").eq(0).val();
                                SubDetail.Length = $(this).find("td").eq(6).find("input").eq(0).val();
                                SubDetail.Breadth = $(this).find("td").eq(7).find("input").eq(0).val();
                                SubDetail.Height = $(this).find("td").eq(8).find("input").eq(0).val();
                                SubDetail.CFT = $(this).find("td").eq(9).find("input").eq(0).val();
                                SubDetail.ActualWeight = $(this).find("td").eq(10).find("input").eq(0).val();
                                SubDetail.ChargeWeight = $(this).find("td").eq(11).find("input").eq(0).val();
                                SubDetail.NoOfPackage = $(this).find("td").eq(12).find("input").eq(0).val();
                                SubDetail.NoOfInnerPackage = $(this).find("td").eq(13).find("input").eq(0).val();
                                SubDetail.InvoiceNo = $(this).find("td").eq(14).find("input").eq(0).val();
                                SubDetail.InvoiceDate = $(this).find("td").eq(15).find("input").eq(0).val();
                                SubDetail.InvoiceValue = $(this).find("td").eq(16).find("input").eq(0).val();
                                if (SubDetail.EWaybillNo != "NA") {
                                    SubDetail.EWaybillNo = $(this).find("td").eq(17).find("input").eq(0).val();
                                    SubDetail.EWaybillDate = $(this).find("td").eq(18).find("input").eq(0).val();
                                    SubDetail.EWaybillExpiryDate = $(this).find("td").eq(19).find("input").eq(0).val();
                                }
                                else {
                                    SubDetail.EWaybillNo = ("NA");
                                    SubDetail.EWaybillDate = ("");
                                    SubDetail.EWaybillExpiryDate = ("");
                                }
                                if (SubDetail.Unit != "KG") {
                                    var unit;
                                    if (SubDetail.Unit == "CM") { unit = 6000 } else { unit = 1728 }
                                    SubDetail.KgperItem = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;
                                } else {
                                    SubDetail.KgperItem = 0;
                                }
                                PickReqDetail.push(SubDetail);
                                t += "," + $(this).find("td").eq(0).find("input").eq(0).val();
                            }
                        }
                    });

                    //Invoice Details
                    if (PickReqHeader.PaymentMode != "FREE" && PickReqHeader.PaymentMode != "CREDIT" && PickReqHeader.PaymentMode != "REVERSE") {
                        t1 = 0;
                        $("[id*=GV_Invoice] tr").each(function () {
                            Count1 = ($(this).length) - 1;
                            if (!this.rowIndex) return;
                            var SubDetail1 = {};

                            console.log("length:" + $(this).length);
                            if ($.trim($(this).find("td").eq(1).html()) == "&nbsp;" || $(this).find("td").eq(1).find("input").eq(0).val() == "") {
                            }
                            else {
                                console.log("R1:" + $(this).find("td").eq(1).html());
                                console.log("R2:" + $(this).find("td").eq(1).find("input").eq(0).val());
                                console.log("t1:" + t1);
                                t1 += "," + 0;
                                var a = t1.indexOf($(this).find("td").eq(0).html());
                                console.log("a:" + a);
                                if (a == -1 && $.trim($(this).find("td").eq(0).html()) != "&nbsp;") {
                                    SubDetail1.RateID = $(this).find("td").eq(1).html();
                                    SubDetail1.Value = $(this).find("td").eq(3).find("input").eq(0).val();
                                    pickReqInvoice.push(SubDetail1);
                                    t1 += "," + $(this).find("td").eq(0).html();
                                }
                            }
                        });

                        //GST Details 
                        var SubDetailCGST = {};
                        SubDetailCGST.RateID = "11" //Fixed for CGST 
                        SubDetailCGST.Value = $("[id*=<%=WaybillEntry.FindControl("Txt_GSTAmt").ClientID%>]").val()/2;
                        pickReqInvoice.push(SubDetailCGST);

                        var SubDetailSGST = {};
                        SubDetailSGST.RateID = "12";
                        SubDetailSGST.Value = $("[id*=<%=WaybillEntry.FindControl("Txt_GSTAmt").ClientID%>]").val()/2;
                        pickReqInvoice.push(SubDetailSGST);
                    }

                    $.ajax({
                        url: "PickReqWareHouse.aspx/SavePickReqData",
                        data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + ', pickReqInvoice:' + JSON.stringify(pickReqInvoice) + '}',
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            var data = response.d;
                            console.log("data:" + data);
                            if (data == -1) {
                                alert("Data could not be Added...");
                                $("[id*=LoadingImage]").hide();
                            }
                            else {
                                $.ajax({
                                    type: "POST",
                                    url: 'PickReqWareHouse.aspx/CheckWaybillMaterialDetails',
                                    data: '{waybillId: "' + data + '" }',
                                    contentType: 'application/json',
                                    dataType: "json",
                                    success: function (response) {
                                        var data1 = response.d;
                                        $.each(data1, function (index, item) {
                                            console.log(item.split('ʭ')[0]);
                                            if (item.split('ʭ')[0] == '1') {
                                                // "clearData();
                                                $("[id*=LoadingImage]").hide();

                                                newFunction("Button_Tab1Save", "SAVE")

                                                var uri = window.location.toString();
                                                if (uri.indexOf("?") > 0) {
                                                    var clean_uri = uri.substring(0, uri.indexOf("?"));
                                                    window.history.replaceState({}, document.title, clean_uri);
                                                }
                                                location.reload(true);  // for reload page after submition
                                            }
                                            else {
                                                alert("Data could not Submitted...");
                                                $("[id*=LoadingImage]").hide();
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        error: function (response) {
                            alert(response.responseText);
                            $("[id*=LoadingImage]").hide();
                        },
                        failure: function (response) {
                            $("[id*=LoadingImage]").hide();
                            alert(response.responseText);
                        }
                    });
                }
                return false;
            });
        });

    </script> 
    <!-- Nav tabs -->
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
                <uc:wbentry ID="WaybillEntry" runat="server" /> 
            </div> 
        </div> 
        <!--==============================================End Waybill Entry Information=======================================================================--> 
    </div> 

    <script> 
        $("[id*=<%=WaybillEntry.FindControl("CustomerCodeDiv").ClientID%>]").show();
        $("[id*=<%=WaybillEntry.FindControl("CorporateCustomerDiv").ClientID%>]").show();
        $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
        $("[id*=<%=WaybillEntry.FindControl("Btn_AddInSameInvoice").ClientID%>]").hide();
        $("[id*=<%=WaybillEntry.FindControl("TelephoneNo").ClientID%>]").hide();
        $("[id*=<%=WaybillEntry.FindControl("Email").ClientID%>]").hide();
        $("[id$=<%=WaybillEntry.FindControl("BtnAddEWayBillInvoice").ClientID%>]").hide();
        $("[id*=<%=WaybillEntry.FindControl("Btn_AddNewInvoice").ClientID%>]").hide();
        $("[id*=<%=WaybillEntry.FindControl("Txt_TotalAmt").ClientID%>]").attr('disabled', 'disabled');
        $("[id*=<%=WaybillEntry.FindControl("Txt_GSTAmt").ClientID%>]").attr('disabled', 'disabled');
        $("[id*=<%=WaybillEntry.FindControl("Txt_GrandTotalAmt").ClientID%>]").attr('disabled', 'disabled');
        $("[id*=<%=WaybillEntry.FindControl("SameAdd").ClientID%>]").attr('disabled', 'disabled');
        InvoiceDetailForWalkin($("[id *=Ddl_PaymentMode]").val());

        function getCustomerType() {
            $(".Ddl_PaymentMode option[value='PAID']").remove();
            $(".Ddl_PaymentMode option[value='TO PAY']").remove();
            $(".Ddl_PaymentMode option[value='CREDIT']").remove();
            $(".Ddl_PaymentMode option[value='FREE']").remove();
            $(".Ddl_PaymentMode option[value='REVERSE']").remove();
            if ($("[id$=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val() == 'CORPORATE') {
                $("[id$=CustomerCodeDiv]").show();
                $("[id$=CorporateCustomerDiv]").show();
                $("[id$=WalkinCustomerDiv]").hide();
                $(".Ddl_PaymentMode").append('<option value="CREDIT">CREDIT</option>');
                $(".Ddl_PaymentMode").append('<option value="FREE">FREE</option>');
                $(".Ddl_PaymentMode option[value='PAID']").remove();
                $(".Ddl_PaymentMode option[value='TO PAY']").remove();
                $("[id$=InvoiceDetailDiv]").hide();
                $("[id$=SameAdd]").prop("checked", false);
                $("[id$=Txt_PickPin]").val("");
                $("[id$=hfPickPinID]").val("");
                $("[id$=Txt_PickPin]").removeAttr("disabled");
                $("[id*=Ddl_PickArea]").empty().append('<option selected="selected" value="0">SELECT</option>');
                $("[id$=Ddl_PickArea]").removeAttr("disabled");
                $("[id$=Txt_PickAdd]").val("");
                $("[id$=Txt_PickAdd]").removeAttr("disabled");
                $("[id$=Txt_PickupBranch]").val("AUTO");
                $("[id$=hfPickupBranch]").val("");
            }
            else if ($("[id$=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val() == 'WALKIN' || $("[id$=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val() == 'REVERSE')
            {
                if ($("[id$=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val() == 'WALKIN') {
                    $(".Ddl_PaymentMode").append('<option value="PAID">PAID</option>');
                    $(".Ddl_PaymentMode").append('<option value="TO PAY">TO PAY</option>');
                    $("[id$=InvoiceDetailDiv]").show();
                }
                if ($("[id$=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val() == 'REVERSE') {
                    $(".Ddl_PaymentMode").append('<option value="REVERSE">REVERSE</option>');
                }

                $("[id$=CorporateCustomerDiv]").hide();
                $("[id$=CustomerCodeDiv]").hide();
                $("[id$=WalkinCustomerDiv]").show();
                $("[id$=Txt_Rate]").val(8);
                InvoiceDetailForWalkin($("[id$=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]").val());
                $("[id$=SameAdd]").prop("checked", false);
                $("[id$=Txt_PickPin]").val("");
                $("[id$=hfPickPinID]").val("");
                $("[id$=Txt_PickPin]").removeAttr("disabled");
                $("[id*=Ddl_PickArea]").empty().append('<option selected="selected" value="0">SELECT</option>');
                $("[id$=Ddl_PickArea]").removeAttr("disabled");
                $("[id$=Txt_PickAdd]").val("");
                $("[id$=Txt_PickAdd]").removeAttr("disabled");
                $("[id$=Txt_PickupBranch]").val("AUTO");
                $("[id$=hfPickupBranch]").val("")
                $("[id$=hfCFTValue]").val("10");
                $("[id$=txtCFT]").val("10");
            }
        };

        function cleardata() {
            $("[id$=<%=WaybillEntry.FindControl("Txt_CustCode").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_CCustName").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_WCustName").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_CustMobileNo").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_CustTelephoneNo").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_EmailId").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_CustPin").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").val("SELECT");
            $("[id$=<%=WaybillEntry.FindControl("Txt_CustAdd").ClientID%>]").val("");

            $("[id$=<%=WaybillEntry.FindControl("Txt_ConsigneeName").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("hfConsigneeID").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_ConsigneeContNo").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_DelPin").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("hfDelPinID").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").val("SELECT");
            $("[id$=<%=WaybillEntry.FindControl("Txt_DelAdd").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("Txt_DeliveryBranch").ClientID%>]").val("");
            $("[id$=<%=WaybillEntry.FindControl("hfDeliveryBranch").ClientID%>]").val("");
        }

        function getPaymentType() {
            if ($("[id$=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]").val() == 'FREE' || $("[id$=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]").val() == 'CREDIT') {
                $("[id$=<%=WaybillEntry.FindControl("InvoiceDetailDiv").ClientID%>]").hide();
            }
            else {
                $("[id$=<%=WaybillEntry.FindControl("InvoiceDetailDiv").ClientID%>]").show();
            }
        };

        $("[id*=<%=WaybillEntry.FindControl("Lbl_Rate").ClientID%>]").hide();
        $("[id*=<%=WaybillEntry.FindControl("Txt_Rate").ClientID%>]").hide();

        $("[id *=Txt_EWaybillDate]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
    </script> 
    <script src="Validation/WayBillEntry.js?98"></script> 

    <!---Update Progress New Consignor ---->
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

    <!---Update Progress New Consignee ---->
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

    <!---Update Progress New Material ---->
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

    <!---Update Progress New Material ---->
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel_NewMaterial" runat="server" DisplayAfter="0">
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

    <!--=======================================================Popup modal of Consignor========================================================================================--> 
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
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_PopupConsignorClose" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
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
        </div>
    </div>
    <!--=================================================== End Consignor Popup Modal===============================================================--> 

    <!--=======================================================Popup modal of Consignee========================================================================================--> 
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
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_ConsigneeClose" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
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
        </div>
    </div>
    <!--=======================================================End popup modal of Consignee========================================================================================--> 

    <!--================================================PopUp Window for New AreaCreation============================================================================-->
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
                        <uc:wbentry ID="PopUp" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for New Area Creation====================================================-->

    <!--================================================PopUp Window for Material ============================================================================-->
    <div class="modal" id="EWayBillModal" role="dialog">
        <div class="modal-dialog modal-lg">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW ITEM</h4>
                    <asp:Label ID="Label5" runat="server"></asp:Label>
                </div>
                <div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel_EWayBillModal">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-dialog">
                                <div class="form-group">
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3"> 
                                            <div class="form-control-sm"></div> 
                                            <asp:Label ID="Label6" runat="server" CssClass="label labelColor">E-WAYBILL NO</asp:Label><span class="required">*</span> 
                                            <asp:TextBox ID="txtModalEWayBillNo" runat="server" Text="" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm txtModalEWayBillNo"></asp:TextBox> 
                                        </div> 
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3"> 
                                            <div class="form-control-sm"></div> 
                                            <div class="form-control-sm"></div> 
                                            <div class="form-control-sm"></div> 
                                            <asp:LinkButton ID="lnkBtnGetEwayBill" runat="server" CssClass="btn btn-info largeButtonStyle2" UseSubmitBehavior="false" OnClientClick="return EWayBillData();">GET DETAILS</i></asp:LinkButton> 
                                        </div> 
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3"> 
                                            <div class="form-control-sm"></div> 
                                            <asp:Label ID="Label7" runat="server" CssClass="label labelColor">E-WAYBILL DATE</asp:Label> 
                                            <asp:TextBox ID="txtModalEWayBillDate" runat="server" Style="text-transform: uppercase;" Enabled="false" AutoCompleteType="Disabled" CssClass="form-control input-sm txtModalEWayBillDate"></asp:TextBox> 
                                        </div> 
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3"> 
                                            <div class="form-control-sm"></div> 
                                            <asp:Label ID="Label8" runat="server" CssClass="label labelColor">E-WAYBILL EXPIRY DATE</asp:Label>
                                            <asp:TextBox ID="txtModalEWayBillExpiryDate" runat="server" Enabled="false" AutoCompleteType="Disabled" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_EWaybillExpiryDate"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row align-items-lg-start float-left">
                                        <div class="form-control-sm align-items-lg-start align-align-items-md-start"></div> 
                                        <asp:GridView ID="GV_EwayBillMaterial" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive align-content-lg-start float-left" HorizontalAlign="Left">
                                        </asp:GridView>
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
                                            <asp:HiddenField ID="HiddenField4" runat="server" ClientIDMode="Static" Value="0" /> 
                                            <asp:LinkButton ID="lnkEWayBillAdd" AccessKey="+" runat="server" CssClass="btn btn-info buttonStyle2" UseSubmitBehavior="false" OnClientClick="if (!validateEWaybillMaterialDetails()) {return false;};">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton> 
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="btnClose" AccessKey="c" runat="server" CssClass="btn btn-info buttonStyle2" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers></Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for Material====================================================-->


    <!--================================================PopUp Window for Material ============================================================================-->
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
                                            <asp:Label ID="Lbl_EWaybillNo" runat="server" CssClass="label labelColor">E-WAYBILL NO</asp:Label><span class="required">*</span> 
                                            <asp:TextBox ID="Txt_EWaybillNo" runat="server" Text="NA" Style="text-transform: uppercase;" Enabled="false" AutoCompleteType="Disabled" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_EWaybillNo"></asp:TextBox> 
                                        </div> 
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3"> 
                                            <div class="form-control-sm"></div> 
                                            <asp:Label ID="Lbl_EWaybillDate" runat="server" CssClass="label labelColor">E-WAYBILL DATE</asp:Label> 
                                            <asp:TextBox ID="Txt_EWaybillDate" runat="server" Style="text-transform: uppercase;" Enabled="false" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_EWaybillDate"></asp:TextBox> 
                                        </div> 
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3"> 
                                            <div class="form-control-sm"></div> 
                                            <asp:Label ID="Lbl_EWaybillExpiryDate" runat="server" CssClass="label labelColor">E-WAYBILL EXPIRY DATE</asp:Label>
                                            <asp:TextBox ID="Txt_EWaybillExpiryDate" runat="server" Enabled="false" AutoCompleteType="Disabled" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_EWaybillExpiryDate"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceNo" runat="server" CssClass="label labelColor">INVOICE NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InvoiceNo"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceDate" runat="server" CssClass="label labelColor">INVOICE DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InvoiceDate"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceValue" runat="server" CssClass="label labelColor">INVOICE VALUE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceValue" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_InvoiceValue FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <asp:HiddenField ID="AutoIncementNo" runat="server" />
                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_MaterialType" runat="server" CssClass="label labelColor">MATERIAL TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Material" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Material" TabIndex="10000" Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_MaterialType" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_MaterialType" onchange="ReadDataonchange('Txt_MaterialType', 'hfMaterialID','', 'PickReqCRMBranch.aspx/getMaterial');"></asp:TextBox>
                                            <asp:HiddenField ID="hfMaterialID" runat="server" />
                                        </div>
                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Package" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Package" TabIndex="10001"  Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_PackageType" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PackageType" onchange="ReadDataonchange('Txt_PackageType', 'hfPackageID','', 'PickReqCRMBranch.aspx/getPackages');"></asp:TextBox>
                                            <asp:HiddenField ID="hfPackageID" runat="server" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Unit" runat="server" CssClass="label labelColor">UNIT</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_Unit" runat="server" CssClass="formDisplay Ddl_Unit CFT">
                                                <asp:ListItem>CM</asp:ListItem>
                                                <asp:ListItem Selected="True">INCH</asp:ListItem>
                                                <asp:ListItem>KG</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Length" runat="server" CssClass="label labelColor">LENGTH</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Length" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Length FirstNoSpaceAndZero CFT"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Breadth" runat="server" CssClass="label labelColor">BREADTH</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Breadth" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Breadth FirstNoSpaceAndZero CFT"></asp:TextBox><%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Height" runat="server" CssClass="label labelColor">HEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Height" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Height FirstNoSpaceAndZero CFT"></asp:TextBox>
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
                                            <asp:TextBox ID="Txt_NoOfPackage" runat="server" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfPackage FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_NoOfInnerPakage" runat="server" CssClass="label labelColor">INNER QTY</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_NoOfInnerPakage" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfInnerPakage FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ActWeight" runat="server" CssClass="label labelColor">ACTUAL WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ActWeight" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" onchange="validateLimit()" CssClass="form-control input-sm Txt_ActWeight FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ChargeWeight" runat="server" CssClass="label labelColor">CHARGE WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ChargeWeight" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_ChargeWeight FirstNoSpaceAndZero"></asp:TextBox>
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
                                            <asp:HiddenField ID="hfAddWaybillItem" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:LinkButton ID="Btn_AddWaybillItem" AccessKey="+" runat="server" CssClass="btn btn-info buttonStyle2" UseSubmitBehavior="false" OnClientClick="if (!validateWareHouseWaybillMaterialDetails()) {return false;};">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_Close" AccessKey="c" runat="server" CssClass="btn btn-info buttonStyle2" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers></Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for Material====================================================-->

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
</asp:Content>

