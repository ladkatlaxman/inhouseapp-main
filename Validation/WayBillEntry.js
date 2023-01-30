$("[id *=Txt_EWaybillDate]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
$("[id *=Txt_EWaybillExpiryDate]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
$("[id *=Txt_WaybillDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0, minDate: -1 }).datepicker("setDate", new Date());
$("[id *=Txt_InvoiceDate1]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();

function ReadDataonchange(text, textid, ddlID, path) {
    var rev = $("[id *=Ddl_PaymentMode]").val(); 
    $.ajax({
        url: path,
        data: "{'searchPrefixText': '" + $("[id$='" + text + "']").val() + "','data':'" + "ReadData" + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                $("[id$='" + text + "']").val(item.split('ʭ')[0]);
                $("[id$='" + textid + "']").val(item.split('ʭ')[1]);
                //console.log($("[id$='" + text + "']").val());
                if (text == "Txt_CustCode" || text == "Txt_CCustName")
                    getCustomerDetailOnCode(text, ddlID);
                else if (text == "Txt_WCustName")
                    getWalkinCustomerDetailOnName(text, ddlID);
                else if (text == "Txt_ConsigneeName")
                    if (rev == 'REVERSE')
                        getConsigneeDetailOnName(text, ddlID);
                    else
                        getConsigneeDetailOnName(text, ddlID);
                else if (text == "Txt_DeliveryBranch")
                    GetBranchDeliveryArea();
                else if (text == "Txt_MaterialType")
                    GetMaterialDetails($("[id$='" + textid + "']").val());
                else if (text == "Txt_PopupConsignorPincode")
                    FillDistrictCityName("Txt_PopupConsignorPincode", "Txt_PopupConsignorDistrict", "Txt_PopupConsignorCity");
                else if (text == "Txt_PopConsigneePincode")
                    FillDistrictCityName("Txt_PopConsigneePincode", "Txt_PopConsigneeDistrict", "Txt_PopConsigneeCity");
                else if (text == "Txt_PickPin")
                    getPickupBranch(textid);
                else if (text == "Txt_DelPin")
                    getDeliveryBranch(textid);
                if (text == "Txt_CustPin" || text == "Txt_PickPin" || text == "Txt_DelPin" || text == "Txt_PopupConsignorPincode" || text == "Txt_PopConsigneePincode") {
                    GetAreaInDropDown($("[id$='" + text + "']").val(), ddlID, "");
                }
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
};

function getCustomerDetailOnCode(text, ddlID) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'PickReqCRMBranch.aspx/getCCustomerDetail',
            data: "{ 'customerID': '" + $("[id$=hfCustID]").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$=hfCustID]").val(item.split('ʭ')[0]);
                    $("[id$=Txt_CustCode]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_CCustName]").val(item.split('ʭ')[2]);
                    $("[id$=Txt_CustMobileNo]").val(item.split('ʭ')[3]);
                    $("[id$=Txt_EmailId]").val(item.split('ʭ')[4]);
                    $("[id$=hfCustPinID]").val(item.split('ʭ')[5]);
                    $("[id$=Txt_CustPin]").val(item.split('ʭ')[6]);
                    var areaid = item.split('ʭ')[7];
                    GetAreaInDropDown($("[id$=Txt_CustPin]").val(), ddlID, areaid);
                    $("[id*=SameAdd]").removeAttr("disabled");
                    $("[id$=Txt_CustAdd]").val(item.split('ʭ')[9]);
                    if (item.split('ʭ')[10] == "" || item.split('ʭ')[10] == null) {
                        $("[id$=Txt_Rate]").val(8);
                    }
                    else {
                        $("[id$=Txt_Rate]").val(item.split('ʭ')[10]);
                    }
                    $("[id$=hfCFTValue]").val(item.split('ʭ')[11]);
                    $("[id$=txtCFT]").val(item.split('ʭ')[11]);
                    $("[id$=BtnAddEWayBillInvoice]").show();
                    $("[id$=Btn_AddNewInvoice]").show();
                    $("[id$=SameAdd]").prop('checked', true);
                    fillPickupDetails('hfPickPinID');
                });
            }
        });
    } else {
        $("[id$=hfCustID]").val("");
        $("[id$=Txt_CustCode]").val("");
        $("[id$=Txt_CCustName]").val("");
        $("[id$=Txt_CustMobileNo]").val("");
        $("[id$=Txt_EmailId]").val("");
        $("[id$=hfCustPinID]").val("");
        $("[id$=Txt_CustPin]").val("");
        $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
        $("[id$=Txt_CustAdd]").val("");
        $("[id$=Txt_Rate]").val("");
        $("[id$=hfCFTValue]").val("");
        $("[id$=BtnAddEWayBillInvoice]").hide();
        $("[id$=Btn_AddNewInvoice]").hide();
        $("[id$=Btn_AddNewInvoice]").attr("disabled", true);
    }
};

function getConsigneeDetailOnName(text, ddlID) {
    //console.log(ddlID);
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'PickReqCRMBranch.aspx/getConsigneeNameDetail',
            data: "{ 'Name': '" + $("[id$=hfConsigneeID]").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$=Txt_ConsigneeContNo]").val(item.split('ʭ')[0]);
                    $("[id$=hfDelPinID]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_DelPin]").val(item.split('ʭ')[2]);
                    var areaid = item.split('ʭ')[3];
                    GetAreaInDropDown($("[id$=Txt_DelPin]").val(), ddlID, areaid);
                    $("[id$=Txt_DelAdd]").val(item.split('ʭ')[5]);
                    $("[id$=Txt_DeliveryBranch]").val(item.split('ʭ')[6]);
                });
            }
        });
    } else {
        $("[id$=Txt_ConsigneeContNo]").val("");
        $("[id$=hfDelPinID]").val("");
        $("[id$=Txt_DelPin]").val("");
        $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
        $("[id$=Txt_DelAdd]").val("");
        $("[id$=Txt_DeliveryBranch]").val("AUTO");
    }
};

function getConsigneeDetailOnReverse(text, ddlID) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'PickReqCRMBranch.aspx/getConsigneeNameDetail',
            data: "{ 'Name': '" + $("[id$=hfConsigneeID]").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$=Txt_ConsigneeContNo]").val(item.split('ʭ')[0]);
                    $("[id$=hfDelPinID]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_DelPin]").val(item.split('ʭ')[2]);
                    var areaid = item.split('ʭ')[3];
                    GetAreaInDropDown($("[id$=Txt_DelPin]").val(), ddlID, areaid);
                    $("[id$=Txt_DelAdd]").val(item.split('ʭ')[5]);
                    $("[id$=Txt_DeliveryBranch]").val(item.split('ʭ')[6]);
                });
            }
        });
    } else {
        $("[id$=Txt_ConsigneeContNo]").val("");
        $("[id$=hfDelPinID]").val("");
        $("[id$=Txt_DelPin]").val("");
        $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
        $("[id$=Txt_DelAdd]").val("");
        $("[id$=Txt_DeliveryBranch]").val("AUTO");
    }
};


function GetAreaInDropDown(text, ddlID, areaID) {
    if (text != "") {
        $.ajax({
            type: "POST",
            url: 'PickReqCRMBranch.aspx/getArea',
            data: "{ 'pincode': '" + text + "'}",
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                //console.log($("[id*='" + ddlID + "']"));
                $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
                $.each(response.d, function () {
                    if (this['AreaID'] == areaID) {
                        $("[id*='" + ddlID + "']").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                    } else {
                        $("[id*='" + ddlID + "']").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                    }
                });
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                alert(thrownError);
            }
        });
    }
    else {
        $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
    }
};

function fillPickupDetails(textid) {
    var chk = $("[id$=SameAdd]");
    if ($(chk).is(':checked')) {
        $("[id$=Txt_PickPin]").val($("[id$=Txt_CustPin]").val());
        $("[id$=hfPickPinID]").val($("[id$=hfCustPinID]").val());
        $("[id$=Txt_PickPin]").attr("disabled", "disabled");
        GetAreaInDropDown($("[id$=Txt_PickPin]").val(), "Ddl_PickArea", $("[id$=Ddl_CustArea]").val());
        $("[id$=Ddl_PickArea]").attr("disabled", "disabled");
        $("[id$=Txt_PickAdd]").val($("[id$=Txt_CustAdd]").val());
        $("[id$=Txt_PickAdd]").attr("disabled", "disabled");
        getPickupBranch("hfCustPinID");
    }
    else {
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
}

function getPickupBranch(textid) {
    $("[id$=Txt_PickupBranch]").val("AUTO");
    $("[id$=hfPickupBranch]").val("");

    if ($("[id$='" + textid + "']").val() != "") {
        //console.log(100);
        $.ajax({
            url: 'PickReqCRMBranch.aspx/getPickupBranch',
            data: "{ 'pincode': '" + $("[id$='" + textid + "']").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    //console.log(200);
                    $("[id$=Txt_PickupBranch]").val(item.split('ʭ')[0]);
                    $("[id$=hfPickupBranch]").val(item.split('ʭ')[1]);
                });
            }
        });
    } else {
        $("[id$=Txt_PickupBranch]").val("AUTO");
        $("[id$=hfPickupBranch]").val("");
    }
};

function getWalkinCustomerDetailOnName(text, ddlID) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'PickReqCRMBranch.aspx/getWCustomerDetail',
            data: "{ 'WcustID': '" + $("[id$=hfWCustID]").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$=Txt_CustMobileNo]").val(item.split('ʭ')[0]);
                    $("[id$=hfCustPinID]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_CustPin]").val(item.split('ʭ')[2]);
                    var areaid = item.split('ʭ')[3];
                    GetAreaInDropDown($("[id$=Txt_CustPin]").val(), ddlID, areaid);
                    $("[id$=Txt_CustAdd]").val(item.split('ʭ')[5]);
                    $("[id*=SameAdd]").removeAttr("disabled");
                    $("[id$=BtnAddEWayBillInvoice]").show();
                    $("[id$=Btn_AddNewInvoice]").show();
                    $("[id$=SameAdd]").prop('checked', true);
                    fillPickupDetails('hfPickPinID');
                });
            }
        });
    } else {
        $("[id$=Txt_CustMobileNo]").val("");
        $("[id$=hfCustPinID]").val("");
        $("[id$=Txt_CustPin]").val("");
        $("[id$=hfCustAreaID]").val("");
        $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
        $("[id$=Txt_CustAdd]").val("");
        $("[id$=BtnAddEWayBillInvoice]").hide();
        $("[id$=Btn_AddNewInvoice]").hide();
    }
};

function FillDistrictCityName(text, district, city) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'PickReqCRMBranch.aspx/PincodeDetail',
            data: "{ 'pincode': '" + $("[id$='" + text + "']").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$='" + district + "']").val(item.split('ʭ')[1]);
                    $("[id$='" + city + "']").val(item.split('ʭ')[2]);
                });
            }
        });
    } else {
        $("[id$='" + district + "']").val("");
        $("[id$='" + city + "']").val("");
    }
};

function getDeliveryBranch(textid) {
    $("[id$=Txt_DeliveryBranch]").val("AUTO");
    $("[id$=hfDeliveryBranch]").val("");

    if ($("[id$='" + textid + "']").val() != "") {
        $.ajax({
            url: 'PickReqWareHouse.aspx/getDeliveryBranch',
            data: "{ 'pincode': '" + $("[id$='" + textid + "']").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    //console.log("DeliveryBranch2");
                    $("[id$=Txt_DeliveryBranch]").val(item.split('ʭ')[0]);
                    $("[id$=hfDeliveryBranch]").val(item.split('ʭ')[1]);
                });
            }
        });
    } else {
        $("[id$=Txt_DeliveryBranch]").val("AUTO");
        $("[id$=hfDeliveryBranch]").val("");
    }
};

function GetMaterialDetails(textid) {
    $("[id$=Txt_NoOfPackage]").val(" ");
    //console.log("materialDetails");
    $.ajax({
        type: "POST",
        url: 'PickReqCRMBranch.aspx/getMaterialDetails',
        data: '{materialId: "' + textid + '" }',
        contentType: 'application/json',
        dataType: "json",
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                if (item.split('ʭ')[0] != 999999) {
                    $("[id*=Txt_Length").val(item.split('ʭ')[1]);
                    $("[id*=Txt_Breadth").val(item.split('ʭ')[2]);
                    $("[id*=Txt_Height").val(item.split('ʭ')[3]);
                    $("[id*=Ddl_Unit").val(item.split('ʭ')[4]);
                    $("[id*=Txt_CFT").val(item.split('ʭ')[5]);
                    $("[id*=Txt_Length]").attr("disabled", "disabled");
                    $("[id*=Txt_Breadth]").attr("disabled", "disabled");
                    $("[id*=Txt_Height]").attr("disabled", "disabled");
                    $("[id*=Ddl_Unit]").attr("disabled", "disabled");
                    $("[id*=Txt_CFT]").attr("disabled", "disabled");
                }
                else {
                    $("[id*=Txt_Length").val(item.split('ʭ')[1]);
                    $("[id*=Txt_Breadth").val(item.split('ʭ')[2]);
                    $("[id*=Txt_Height").val(item.split('ʭ')[3]);
                    $("[id*=Ddl_Unit").val("INCH");
                    $("[id*=Txt_CFT").val(0);
                    $("[id*=Txt_Length]").removeAttr("disabled");
                    $("[id*=Txt_Breadth]").removeAttr("disabled");
                    $("[id*=Txt_Height]").removeAttr("disabled");
                    $("[id*=Ddl_Unit]").removeAttr("disabled");
                    $("[id*=Txt_CFT]").removeAttr("disabled");
                }
            });
        }
    });
}

function validateLimit() {
    var actualWeight = $("[id$=Txt_ActWeight]").val();
    if (actualWeight > 8000) {
        alert("Actual Weight must be less than 8000 kg");
        $("[id$=Txt_ActWeight]").val("");
    }
}

function SetValue(row, index, name, textbox) {
    //alert(textbox);
    row.find("td").eq(index).html(textbox.val());
    var input = $("<input type = 'hidden' />");
    input.prop("name", name);
    input.val(textbox.val());
    row.find("td").eq(index).append(input);
}

function SetValueOnly(row, index, name, textbox) {
    //alert(textbox);
    row.find("td").eq(index).html(textbox); 
    var input = $("<input type = 'hidden' />");
    input.prop("name", name);
    input.val(textbox);
    row.find("td").eq(index).append(input);
}

function SetValue1(row, index, name, textbox) {
    row.find("td").eq(index).html(textbox);
    var input = $("<input type = 'hidden' />");
    input.prop("name", name);
    row.find("td").eq(index).append(input);
}

function InvoiceDetailForWalkinUpdateValue(value, type) {
    $.ajax({
        url: 'PickReqWareHouse.aspx/GetWaybillInvoice',
        data: "{ 'type': '" + type + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            var gridView = $("[id$=GV_Invoice]");
            var row = gridView.find("tr");
            row.remove();
            $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle hidden'>RATE ID</th><th class='gvHeaderStyle'>RATE TYPE</th><th class='gvHeaderStyle'>CHARGES</th></tr>");
            Index = 0;
            $.each(data, function (index, item) {
                //console.log("loop1");
                Index = Index + 1;
                if (item.split('ʭ')[0] == 3) {
                    //  console.log("loop fright");
                    $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                        "<td class='gvItemStyle hidden'>" + item.split('ʭ')[0] + "</td>" +
                        "<td class='gvItemStyle'>" + item.split('ʭ')[1] + "</td>" +
                        "<td class='gvItemStyle'><input type='textbox' id='charges' name='charges' value=" + value + "></td>" +
                        "</tr>");
                }
                else {
                    // console.log("loop others");
                    $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                        "<td class='gvItemStyle hidden'>" + item.split('ʭ')[0] + "</td>" +
                        "<td class='gvItemStyle'>" + item.split('ʭ')[1] + "</td>" +
                        "<td class='gvItemStyle'><input type='textbox' id='charges' name='charges' value=" + item.split('ʭ')[2] + "></td>" +
                        "</tr>");
                }
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
}

function validateWarehouseWaybillDetails() {
    $("#hfWaybillSubmit").val(0);

    var grdv = $("[id*=GV_WaybillDetail]");
    if ($('.Txt_WaybillNo').val() == '') {
        alert('Provide WayBill No');
        $('[id*=Txt_WaybillNo]').focus();
        return;
    }
    if (($('.Txt_CustCode').is(':visible') && $('.Txt_CustCode').val() == '')) {
        alert('Provide Customer Code.'); 
        $('.Txt_CustCode').focus();
        return;
    }
    if (($('.Txt_CCustName').is(':visible') && $('.Txt_CCustName').val() == '')) {
        alert('Provide Customer Name.');
        $('.Txt_CustCode').focus();
    }
    if (($('.Txt_WCustName').is(':visible') && $('.Txt_WCustName').val() == '')) {
        alert('Provide Customer Name.');
        $('.Txt_WCustName').focus();
        return;
    }
    if ($('.Txt_CustMobileNo').val() == '') {
        alert('Provide Contact No.');
        $('.Txt_CustMobileNo').focus();
        return;
    }
    if ($('.Txt_PickPin').val() == '') {
        alert('Provide PIN Code.');
        $('.Txt_PickPin').focus();
        return;
    }
    if ($('.Ddl_PickArea').val() == 0) {
        if ($('.Ddl_CustArea').val() == 0) {
            alert('Provide Pickup Area.');
            $('.Ddl_PickArea').focus();
            return;
        }
    }
    if ($('.Txt_PickAdd').val() == '') {
        alert('Provide Contact No.');
        $('.Txt_PickAdd').focus();
        return;
    }
    if ($('.Txt_ConsigneeName').val() == '') {
        alert('Enter Consignee Name.');
        $('.Txt_ConsigneeName').focus();
        return;
    }
    if ($('.Txt_ConsigneeContNo').val() == '') {
        alert('Enter Consignee Contact.');
        $('.Txt_ConsigneeContNo').focus();
        return;
    }
    if ($('.Txt_DelPin').val() == '') {
        alert('Select Delivery Pincode.');
        $('.Txt_DelPin').focus();
        return;
    }
    if ($('.Ddl_DelArea').val() == 0) {
        alert('Select Delivery Area.');
        $('.Ddl_DelArea').focus();
        return;
    }
    if ($('.Txt_DelAdd').val() == '') {
        alert('Enter Delivery Address.');
        $('.Txt_DelAdd').focus();
        return;
    }
    if ($("[id*=AutoIncementNo]").val() == 0) {
        alert('Provide Material Details.');
        $('.Txt_DelAdd').focus();
        return;
    }
    //alert($("[id$=Ddl_PaymentMode]").val() + ':' + $("[id$=Ddl_PaymentMode]").val() + ':' + $("[id*=hfCalculated]").val());
    if (($("[id$=Ddl_PaymentMode]").val() == 'PAID' || $("[id$=Ddl_PaymentMode]").val() == 'TO PAY') && $("[id*=hfCalculated]").val() == '0') { 
        alert('Please Calculate the Total amount as per GST.'); 
        $('.Txt_GST').focus(); 
        return; 
    } 

    if (($("[id$=Ddl_PaymentMode]").val() == 'PAID' || $("[id$=Ddl_PaymentMode]").val() == 'TO PAY')) {
        if ($("[id$=Txt_GrandTotalAmt]").val() < 500) {
            alert('Minimum amount should be Rs 500.');
            $('.Txt_GST').focus();
            return;
        }
    } 


    $("#hfWaybillSubmit").val(1); 
    return true;
}

function validateWareHouseWaybillMaterialDetails() {
    if ($('.Txt_EWaybillNo').val() == '') {
        alert('Enter E-WaybillNo');
        $('.Txt_EWaybillNo').focus();
        return;
    }
    if ($('.Txt_InvoiceNo').val() == '') {
        alert('Enter Invoice No');
        $('.Txt_InvoiceNo').focus();
        return;
    }
    if (!isDate($('.Txt_InvoiceDate').val())) {
        console.log($('.Txt_InvoiceDate').val() + '1');
        alert('Select Invoice Date');
        console.log($('.Txt_InvoiceDate').val() + '2');
        $('.Txt_InvoiceDate').focus();
        return;
    }
    if ($('.Txt_InvoiceValue').val() == '') {
        alert('Enter Invoice Value');
        $('.Txt_InvoiceValue').focus();
        return;
    }
    if ($('.Txt_MaterialType').val() == '') {
        alert('Select Material type');
        $('.Txt_MaterialType').focus();
        return;
    }
    if ($('.Txt_PackageType').val() == '') {
        alert('Select Package type');
        $('.Txt_PackageType').focus();
        return;
    }
    if ($('.Ddl_Unit option:selected').text() == 'SELECT') {
        alert('Select Unit');
        $('.Ddl_Unit option').focus();
        return;
    }
    if ($('.Txt_Length').val() == '') {
        alert('Enter Length');
        $('.Txt_Length').focus();
        return;
    }
    if ($('.Txt_Breadth').val() == '') {
        alert('Enter Breadth');
        $('.Txt_Breadth').focus();
        return;
    }
    if ($('.Txt_Height').val() == '') {
        alert('Enter Height');
        $('.Txt_Height').focus();
        return;
    }
    if ($('.Txt_CFT').val() == '') {
        alert('Enter CFT');
        $('.Txt_CFT').focus();
        return;
    }
    if ($('.Txt_NoOfPackage').val() == '') {
        alert('Enter No Of Package');
        $('.Txt_NoOfPackage').focus();
        return;
    }
    if ($('.Txt_NoOfInnerPakage').val() == '') {
        alert('Enter No Of Inner Package');
        $('.Txt_NoOfInnerPakage').focus();
        return;
    }
    if ($('.Txt_ActWeight').val() == '') {
        alert('Enter Actual Weight');
        $('.Txt_ActWeight').focus();
        return;
    }
    if ($('.Txt_ChargeWeight').val() == '') {
        alert('Enter charge Weight');
        $('.Txt_ChargeWeight').focus();
        return;
    }
    $("#hfAddWaybillItem").val(1);
    return true;
}

function validateEWaybillMaterialDetails() { 
    if ($('.txtModalEWayBillNo').val() == '') { 
        alert('Enter EWayBill No'); 
        $('.txtModalEWayBillNo').focus(); 
        return; 
    } 
    $("#hfAddWaybillItem").val(1); 
}


$(document).ready(function () {

    $('.dropdown-submenu a.test').on("click", function (e) {
        $(this).next('ul').toggle();
        e.stopPropagation();
        e.preventDefault();
    });
    $('ul.dropdown-menu[data-toggle=dropdown]').on('click', function (event) {
        event.preventDefault();
        event.stopPropagation();
        $(this).parent().siblings().removeClass('open');
        $(this).parent().toggleClass('open');
    });

    $(function () {
        $('.EMAT').change(function () {
            //alert('hello')
        });
        $('.CFT').change(function () {
            var unit;
            if ($("[id$=Ddl_Unit]").children("option:selected").val() != "SELECT" && $("[id$=Txt_Length]").val() != "" && $("[id$=Txt_Breadth]").val() != "" && $("[id$=Txt_Height]").val() != "") {
                if ($("[id$=Ddl_Unit]").children("option:selected").val() == "CM") {
                    unit = 27000
                }
                else {
                    unit = 1728
                }
                if ($("[id$=Ddl_CustomerType]").val() == "CORPORATE") {
                    if ($("[id$=hfCFTValue]").val() != "") {
                        $("[id$=Txt_CFT]").val((($("[id$=Txt_Length]").val() * $("[id$=Txt_Breadth]").val() * $("[id$=Txt_Height]").val() * $("[id$=hfCFTValue]").val()) / unit).toFixed(5)); 
                    } 
                    else {
                        $("[id$=Txt_CFT]").val((($("[id$=Txt_Length]").val() * $("[id$=Txt_Breadth]").val() * $("[id$=Txt_Height]").val() * 10) / unit).toFixed(5)); 
                    }
                }
                else { $("[id$=Txt_CFT]").val((($("[id$=Txt_Length]").val() * $("[id$=Txt_Breadth]").val() * $("[id$=Txt_Height]").val() * 10) / unit).toFixed(5)); } $("[id$=Txt_CFT]").attr("disabled", "disabled"); $("[id$=Txt_NoOfPackage]").val("");
            }
        });
        $("[id$=Txt_NoOfPackage]").change(function () {
            $("[id$=Txt_ChargeWeight]").val((($("[id$=Txt_NoOfPackage]").val()) * (($("[id$=Txt_CFT]").val()))).toFixed(2));
            $("[id$=Txt_ChargeWeight]").attr("disabled", "disabled");
        });
        $("[id*='Btn_PopupConsignorSubmit']").bind("click", function () {
            if ($("[id$='Txt_PopupConsignorName']").val() == "") {
                $("[id$='Txt_PopupConsignorName']").focus();
                return false;
            }
            if ($("[id*='Txt_PopupContactNo']").val() == "") {
                $("[id*='Txt_PopupContactNo']").focus();
                return false;
            }
            if ($("[id*='Txt_PopupConsignorPincode']").val() == "") {
                $("[id*='Txt_PopupConsignorPincode']").focus();
                return false;
            }
            if ($("[id*='Ddl_PopupConsignorArea']").text() == "SELECT") {
                $("[id*='Ddl_PopupConsignorArea']").focus();
                return false;
            }
            if ($("[id*='Txt_PopupConsignorAddress']").val() == "") {
                $("[id*='Txt_PopupConsignorAddress']").focus();
                return false;
            }
            if ($("[id*='Txt_PopupConsignorGST']").val() == "") {
                $("[id*='Txt_PopupConsignorGST']").focus();
                return false;
            }
            $("[id*='LoadingImage']").show();
            var consignorOrConsignee = {};
            consignorOrConsignee.value = 'CONSIGNOR'; consignorOrConsignee.Name = $("[id$='Txt_PopupConsignorName']").val();
            consignorOrConsignee.ContactNo = $("[id*='Txt_PopupContactNo']").val();
            consignorOrConsignee.LocID = $("[id*='hfPopupConsignorPincode']").val();
            consignorOrConsignee.AreaID = $("[id$='Ddl_PopupConsignorArea']").val();
            consignorOrConsignee.Address = $("[id*='Txt_PopupConsignorAddress']").val();
            consignorOrConsignee.GSTNo = $("[id*='Txt_PopupConsignorGST']").val();
            $.ajax({
                url: "PickReqCRMBranch.aspx/SaveConsignorConsignee",
                data: '{Details: ' + JSON.stringify(consignorOrConsignee) + '}',
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("[id*='hfWCustID']").val(data.d);
                    FillData();
                    clearFunction();
                    $("[id*='LoadingImage']").hide();
                    alert("Data Added Successfully...");
                    return false;
                },
                error: function (response) {
                    $("[id*='LoadingImage']").hide();
                    alert(response.responseText);
                    return false;
                },
                failure: function (response) {
                    $("[id*='LoadingImage']").hide();
                    alert(response.responseText);
                    return false;
                }
            });
            function FillData() {
                $("[id*='Txt_WCustName']").val($("[id*='Txt_PopupConsignorName']").val());
                $("[id*='Txt_CustMobileNo']").val($("[id*='Txt_PopupContactNo']").val());
                $("[id*='Txt_CustPin']").val($("[id*='Txt_PopupConsignorPincode']").val());
                $("[id*='hfCustPinID']").val($("[id*='hfPopupConsignorPincode']").val());
                GetAreaInDropDown($("[id*='Txt_CustPin']").val(), 'Ddl_CustArea', $("[id*='Ddl_PopupConsignorArea']").val());
                //console.log($("[id*='hfPopupConsignorPincode']").val());
                getDeliveryBranch('hfCustPinID');
                $("[id*='Txt_CustAdd']").val($("[id*='Txt_PopupConsignorAddress']").val());
                $("[id$= SameAdd]").removeAttr("disabled");
                fillPickupDetails('hfPickPinID');
            }
            function clearFunction() {
                //console.log("clear");
                $("[id*='Txt_PopupConsignorName']").val("");
                $("[id*='Txt_PopupContactNo']").val("");
                $("[id*='Txt_PopupConsignorPincode']").val("");
                $("[id*='hfPopupConsignorPincode']").val("");
                $("[id*='Ddl_PopupConsignorArea']").empty().append('<option selected="selected" value="0">SELECT</option>');
                $("[id*='Txt_PopupConsignorAddress']").val("");
                $("[id*='Txt_PopupConsignorGST']").val("");
                $("[id*='hfPopupConsignorSubmit']").val(0);
                $("[id*=Txt_PopConsigneeDistrict]").val("AUTO");
                $("[id*=Txt_PopConsigneeCity]").val("AUTO");
                $("[id*=Txt_PopupConsignorDistrict]").val("AUTO");
                $("[id*=Txt_PopupConsignorCity]").val("AUTO");
            };
            return false;
        }),
            $("[id*='Btn_ConsigneeSubmit']").bind("click", function () {
                if ($("[id$='Txt_PopConsigneeName']").val() == "") {
                    $("[id$='Txt_PopConsigneeName']").focus();
                    return false;
                }
                if ($("[id*='Txt_PopConsigneeContactNo']").val() == "") {
                    $("[id*='Txt_PopConsigneeContactNo']").focus();
                    return false;
                }
                if ($("[id*='Txt_PopConsigneePincode']").val() == "") {
                    $("[id*='Txt_PopConsigneePincode']").focus();
                    return false;
                }
                if ($("[id*='Ddl_PopConsigneeArea']").text() == "SELECT") {
                    $("[id*='Ddl_PopConsigneeArea']").focus();
                    return false;
                }
                if ($("[id*='Txt_popConsigneeAddress']").val() == "") {
                    $("[id*='Txt_popConsigneeAddress']").focus();
                    return false;
                }
                if ($("[id*='Txt_PopGSTNoOfConsignee']").val() == "") {
                    $("[id*='Txt_PopGSTNoOfConsignee']").focus(); 
                    return false; 
                }
                $("[id*='LoadingImage']").show();
                var consignorOrConsignee = {};
                consignorOrConsignee.value = 'CONSIGNEE'; consignorOrConsignee.Name = $("[id$='Txt_PopConsigneeName']").val();
                consignorOrConsignee.ContactNo = $("[id*='Txt_PopConsigneeContactNo']").val();
                consignorOrConsignee.LocID = $("[id*='hfPopConsigneePincode']").val();
                consignorOrConsignee.AreaID = $("[id$='Ddl_PopConsigneeArea']").val();
                consignorOrConsignee.Address = $("[id*='Txt_popConsigneeAddress']").val();
                consignorOrConsignee.GSTNo = $("[id*='Txt_PopGSTNoOfConsignee']").val();
                $.ajax({
                    url: "PickReqCRMBranch.aspx/SaveConsignorConsignee",
                    data: '{Details: ' + JSON.stringify(consignorOrConsignee) + '}',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        $("[id*='hfConsigneeID']").val(data.d);
                        FillData();
                        clearFunction();
                        $("[id*='LoadingImage']").hide();
                        alert("Data Added Successfully...");
                        return false;
                    },
                    error: function (response) {
                        alert(response.responseText);
                        $("[id*='LoadingImage']").hide();
                    },
                    failure: function (response) {
                        $("[id*='LoadingImage']").hide();
                        alert(response.responseText);
                    }
                });
                function FillData() {
                    $("[id*='Txt_ConsigneeName']").val($("[id*='Txt_PopConsigneeName']").val());
                    $("[id*='Txt_ConsigneeContNo']").val($("[id*='Txt_PopConsigneeContactNo']").val());
                    $("[id*='Txt_DelPin']").val($("[id*='Txt_PopConsigneePincode']").val());
                    $("[id*='hfDelPinID']").val($("[id*='hfPopConsigneePincode']").val());
                    GetAreaInDropDown($("[id*='Txt_DelPin']").val(), 'Ddl_DelArea', $("[id*='Ddl_PopConsigneeArea']").val());
                    console.log($("[id*='hfPopConsigneePincode']").val());
                    getDeliveryBranch('hfDelPinID');
                    $("[id*='Txt_DelAdd']").val($("[id*='Txt_popConsigneeAddress']").val());
                    $("[id$= SameAdd]").removeAttr("disabled");
                }
                function clearFunction() {
                    //console.log("clear");
                    $("[id*='Txt_PopConsigneeName']").val("");
                    $("[id*='Txt_PopConsigneeContactNo']").val("");
                    $("[id*='Txt_PopConsigneePincode']").val("");
                    $("[id*='hfPopConsigneePincode']").val("");
                    $("[id*='Ddl_PopConsigneeArea']").empty().append('<option selected="selected" value="0">SELECT</option>');
                    $("[id*='Txt_popConsigneeAddress']").val("");
                    $("[id*='Txt_PopGSTNoOfConsignee']").val("");
                    $("[id*='hfConsigneeSubmit']").val(0);
                    $("[id*=Txt_PopConsigneeDistrict]").val("AUTO");
                    $("[id*=Txt_PopConsigneeCity]").val("AUTO");
                    $("[id*=Txt_PopupConsignorDistrict]").val("AUTO");
                    $("[id*=Txt_PopupConsignorCity]").val("AUTO");
                };
            });

        $("[id$='Txt_CustCode']").autocomplete({
                source: function (request, response) {
                    //console.log(request.term.length);
                    $.ajax({
                        url: '/PickReqCRMBranch.aspx/getCustomerCode',
                        data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('ʭ')[0],
                                    val: item.split('ʭ')[1]
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                            return false;
                        },
                        failure: function (response) {
                            alert(response.responseText);
                            return false;
                        }
                    });
                },
                select: function (e, i) {
                    $("[id$='hfCustID']").val(i.item.val);
                    return false;
                },
                minLength: 3
            });
        $("[id$='Txt_CCustName']").autocomplete({
            source: function (request, response) {
                //console.log(request.term.length);
                $.ajax({
                    url: '/PickReqCRMBranch.aspx/getCustName',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfCustID']").val(i.item.val);
            },
            minLength: 3
        });
        $("[id$='Txt_WCustName']").autocomplete({
            source: function (request, response) {
                //console.log(request.term.length);
                $.ajax({
                    url: '/PickReqCRMBranch.aspx/getWalkinCustName',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfWCustID']").val(i.item.val);
            },
            minLength: 3
        });
        $("[id$='Txt_ConsigneeName']").autocomplete({
            source: function (request, response) {
                //console.log(request.term.length);
                $.ajax({
                    url: '/WBEntry.aspx/getConsigneeName',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfConsigneeID']").val(i.item.val);
            },
            minLength: 3
        });
        $('.EMAT').autocomplete({
            source: function (request, response) {
                //console.log(request.term.length);
                $.ajax({
                    url: '/PickReqCRMBranch.aspx/getMaterial',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfMatID1']").val(i.item.val);
            },
            minLength: 3
        });
        $("[id*='Txt_MaterialType']").autocomplete({
            source: function (request, response) {
                //console.log(request.term.length);
                $.ajax({
                    url: '/PickReqCRMBranch.aspx/getMaterial',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfMatID1']").val(i.item.val);
            },
            minLength: 3
        });
        $("[id$='Txt_PackageType']").autocomplete({
            source: function (request, response) {
                //console.log(request.term.length);
                $.ajax({
                    url: '/PickReqCRMBranch.aspx/getPackages',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfPackageID']").val(i.item.val);
            },
            minLength: 3
        });
        $("[id*='Txt_MatType1']").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '/PickReqCRMBranch.aspx/getMaterial',
                    data: "{ 'searchPrefixText': '" + request.term + "','data':'GetData'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('ʭ')[0],
                                val: item.split('ʭ')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("[id$='hfMatID1']").val(i.item.val);
            },
            minLength: 3
        });
        $("[id*=Btn_AddWaybillItem]").click(function () {
            var totalWeight = 0; var finalFreightCharge = 100; var hfAddWaybillItem = $("[id*=hfAddWaybillItem]");
            if (hfAddWaybillItem.val() != 0) {
                var gridView = $("[id*=GV_WaybillDetail]");
                var row = gridView.find("tr").eq(1);
                var rowData = row.find("td").eq(1).find("input").eq(0).val()
                if ($.trim(row.find("td").eq(1).html()) == "&nbsp;" || rowData == "") {
                    row.remove();
                    Index = 0; temp = 0;
                }
                row = row.clone(true);
                Index = Index + 1;
                if (temp == 0) {
                    temp = Index;
                }
                else {
                    temp += "," + Index
                }
                $("[id*=AutoIncementNo]").val(Index);
                {
                    var txtAutoIncrementNo = $("[id*=AutoIncementNo]");
                    SetValue(row, 0, "Index", txtAutoIncrementNo);
                    var MaterialID = $("[id*=hfMaterialID]");
                    SetValue(row, 1, "MaterialID", MaterialID);
                    var MaterialType = $("[id*=Txt_MaterialType]");
                    SetValue(row, 2, "MaterialType", MaterialType);
                    var PackageID = $("[id*=hfPackageID]");
                    SetValue(row, 3, "PackageID", PackageID);
                    var PackageType = $("[id*=Txt_PackageType]");
                    SetValue(row, 4, "PackageType", PackageType);
                    var Unit = $("[id*=Ddl_Unit]");
                    SetValue(row, 5, "Unit", Unit);
                    var Length = $("[id*=Txt_Length]");
                    SetValue(row, 6, "Length", Length);
                    var Breadth = $("[id*=Txt_Breadth]");
                    SetValue(row, 7, "Breadth", Breadth);
                    var Height = $("[id*=Txt_Height]");
                    SetValue(row, 8, "Height", Height);
                    var CFT = $("[id*=Txt_CFT]");
                    SetValue(row, 9, "CFT", CFT);
                    var ActWeight = $("[id*=Txt_ActWeight]");
                    SetValue(row, 10, "ActWeight", ActWeight);
                    var ChargeWeight = $("[id*=Txt_ChargeWeight]");
                    SetValue(row, 11, "ChargeWeight", ChargeWeight);
                    var NoOfPackage = $("[id*=Txt_NoOfPackage]");
                    SetValue(row, 12, "NoOfPackage", NoOfPackage);
                    var NoOfInnerPackage = $("[id*=Txt_NoOfInnerPakage]");
                    SetValue(row, 13, "NoOfInnerPackage", NoOfInnerPackage);
                    var InvoiceNo = $("[id*=Txt_InvoiceNo]");
                    SetValue(row, 14, "InvoiceNo", InvoiceNo);
                    var InvoiceDate = $("[id*=Txt_InvoiceDate]");
                    SetValue(row, 15, "InvoiceDate", InvoiceDate);
                    var InvoiceValue = $("[id*=Txt_InvoiceValue]");
                    SetValue(row, 16, "InvoiceValue", InvoiceValue);
                    var EWaybillNo = $("[id*=Txt_EWaybillNo]");
                    SetValue(row, 17, "EWaybillNo", EWaybillNo);
                    var EWaybillDate = $("[id*=Txt_EWaybillDate]");
                    SetValue(row, 18, "EWaybillDate", EWaybillDate);
                    var EWaybillExpiryDate = $("[id*=Txt_EWaybillExpiryDate]");
                    SetValue(row, 19, "EWaybillExpiryDate", EWaybillExpiryDate);
                    var AW = parseInt($("[id*=Txt_ActWeight]").val(), 10);
                    var CW = parseInt($("[id*=Txt_ChargeWeight]").val(), 10);
                    if (AW > CW) { 
                        $("[id$=Txt_ChargeWeight]").val(AW); $("[id$=Txt_CFT]").attr("disabled", "disabled"); $("[id$=Txt_ChargeWeight]").attr("disabled", "disabled"); var ChargeWeight = $("[id*=Txt_ChargeWeight]"); 
                        SetValue(row, 11, "ChargeWeight", ChargeWeight); 
                        CW = AW; 
                    }
                    if (Index == 1) { 
                        totalWeight = AW; 
                    } else {
                        totalWeight = parseFloat($("[id*=Txt_Weight]").val(), 10) + parseFloat(CW, 10);
                    }
                    gridView.append(row);
                    var PickReqDetail = [];
                    temp += "," + 0;
                    var n = temp.indexOf(0); //console.log("n:" + n);
                }
                //console.log(PickReqDetail);
                $("[id*=Txt_Weight]").val(totalWeight);
                MaterialID.val("");
                MaterialType.val("");
                PackageID.val("");
                PackageType.val("");
                Unit.val("INCH");
                Length.val("");
                Breadth.val("");
                Height.val("");
                CFT.val("");
                ActWeight.val(""); 
                ChargeWeight.val(""); 
                NoOfPackage.val(""); 
                NoOfInnerPackage.val(""); 
                $("[id*=hfInvoiceNo]").val(InvoiceNo.val()); 
                $("[id*=hfInvoiceDate]").val(InvoiceDate.val()); 
                $("[id*=hfInvoiceValue]").val(InvoiceValue.val()); 
                $("[id*=hfEwaybillNo]").val(EWaybillNo.val()); 
                $("[id*=hfEwaybillDate]").val(EWaybillDate.val()); 
                $("[id*=hfEwaybillExpiryDate]").val(EWaybillExpiryDate.val()); 
                $("[id$=Btn_AddInSameInvoice]").show();
                $("[id*= Txt_CustCode]").attr("disabled", "disabled");
                $("[id*= Txt_CCustName]").attr("disabled", "disabled");
                $("[id*= Txt_WCustName]").attr("disabled", "disabled");
                $("[id*= Txt_CustMobileNo]").attr("disabled", "disabled");
                var paymentMode = $("[id$=Ddl_PaymentMode]").val();
                //alert(paymentMode);
                if (paymentMode == "PAID" || paymentMode == "TO PAY") {
                    finalFreightCharge = CW * totalWeight; 

                    InvoiceDetailForWalkinUpdateValue(finalFreightCharge, paymentMode);
                }
            }
            return false;
        });
        $("[id*=lnkEWayBillAdd]").click(function () {
            var totalWeight = 0; var finalFreightCharge; var hfAddWaybillItem = $("[id*=hfAddWaybillItem]");
            if (hfAddWaybillItem.val() != 0) {
                //Validate the Weight in the Items 
                var iRow = 0, goout = 0; 
                $("[id*=GV_EwayBillMaterial] tr").each(function () {
                    if ($(this).find("td").eq(6).find("input").eq(0).val() == "") {
                        iRow = iRow + 1; 
                        alert('Please provide weight in the EWaybill Value. \r at Row ' + iRow);
                        goout = 1; 
                        return;
                    }
                    if (goout == 1) return; 
                }); 
                if (goout == 1) return; 

                var gridView = $("[id*=GV_WaybillDetail]");
                var row = gridView.find("tr").eq(1);
                var rowData = row.find("td").eq(1).find("input").eq(0).val()
                if ($.trim(row.find("td").eq(1).html()) == "&nbsp;" || rowData == "") {
                    row.remove();
                    Index = 0; temp = 0;
                }
                row = row.clone(true);
                $("[id*=GV_EwayBillMaterial] tr").each(function () {
                    $("[id*=AutoIncementNo]").val(Index); 
                    if (Index > 0) { 
                        var txtAutoIncrementNo = $("[id*=AutoIncementNo]"); 
                        SetValue(row, 0, "Index", txtAutoIncrementNo);
                        SetValueOnly(row, 1, "MaterialID", $(this).find("td").eq(1).html());
                        SetValueOnly(row, 2, "MaterialType", $(this).find("td").eq(2).html());
                        SetValueOnly(row, 3, "PackageID", $(this).find("td").eq(3).html());
                        SetValueOnly(row, 4, "PackageType", $(this).find("td").eq(4).html());
                        SetValueOnly(row, 5, "Unit", "PCS");
                        SetValueOnly(row, 6, "Length", 1);
                        SetValueOnly(row, 7, "Breadth", 1);
                        SetValueOnly(row, 8, "Height", 1);
                        SetValueOnly(row, 9, "CFT", 1);
                        SetValueOnly(row, 10, "ActWeight", $(this).find("td").eq(6).find("input").eq(0).val());
                        SetValueOnly(row, 11, "ChargeWeight", $(this).find("td").eq(6).find("input").eq(0).val());
                        SetValueOnly(row, 12, "NoOfPackage", $(this).find("td").eq(7).html());
                        SetValueOnly(row, 13, "NoOfInnerPackage", 1);
                        SetValueOnly(row, 14, "InvoiceNo", $(this).find("td").eq(8).html());
                        SetValueOnly(row, 15, "InvoiceDate", $(this).find("td").eq(9).html());
                        SetValueOnly(row, 16, "InvoiceValue", $(this).find("td").eq(10).html());
                        SetValueOnly(row, 17, "EWaybillNo", $('.txtModalEWayBillNo').val());
                        SetValueOnly(row, 18, "EWaybillDate", $('.txtModalEWayBillDate').val());
                        SetValueOnly(row, 19, "EWaybillExpiryDate", "");
                        gridView.append(row);

                        if (Index == 1) {
                            totalWeight = $(this).find("td").eq(6).find("input").eq(0).val();
                        } else {
                            totalWeight = parseFloat($("[id*=Txt_Weight]").val(), 10) + parseFloat($(this).find("td").eq(6).find("input").eq(0).val(), 10);
                        }
                        $("[id*=Txt_Weight]").val(totalWeight);
                    }
                    Index = Index + 1;
                });
                $("[id*=GV_EwayBillMaterial]").remove(); 
                $("[id$=Btn_AddInSameInvoice]").hide();
                $("[id$=lnkEWayBillAdd]").hide();
                $("[Btn_AddNewInvoice]").hide();
            }
            return false;
        });
    });
});

function isDate(txtDate) {
    var currVal = txtDate;
    //console.log("currVal : " + currVal);
    if (currVal == '')
        return false;
    //Declare Regex 
    //var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2}? )(\/|-)(\d{4})$/;
    var rxDatePattern = /^\d{1,2}\/\d{1,2}\/\d{4}$/;
    var dtArray = currVal.match(rxDatePattern); // is format OK? 
    //console.log("dtArray : " + dtArray); 
    if (dtArray == null)
        return false;
    //Checks for dd/mm/yyyy format.
    dtDay = dtArray[1];
    dtMonth = dtArray[3];
    dtYear = dtArray[5];
    //console.log(dtDay + ":" + dtMonth + ":" + dtYear);
    if (dtDay < 1 || dtDay > 31)
        return false;
    else if (dtMonth < 1 || dtMonth > 12)
        return false;
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
        return false;
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap))
            return false;
    }
    return true;
}

