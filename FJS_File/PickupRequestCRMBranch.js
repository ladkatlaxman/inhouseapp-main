
function cleardata() {
    $("[id$=Txt_CustCode]").val("");
    $("[id$=Txt_CCustName]").val("");
    $("[id$=Txt_WCustName]").val("");
    $("[id$=Txt_CustMobileNo]").val("");
    $("[id$=Txt_CustTelephoneNo]").val("");
    $("[id$=Txt_EmailId]").val("");
    $("[id$=Txt_CustPin]").val("");
    $("[id$=Ddl_CustArea]").val("SELECT");
    $("[id$=Txt_CustAdd]").val("");
}

function validateLimit() {
    var actualWeight = $("[id$=Txt_ActWeight]").val();
    if (actualWeight > 8000) {
        alert("Actual Weight must be less than 8000 kg");
        $("[id$=Txt_ActWeight]").val("");
    }
}

function CurrentWaybillNo() {
    $.ajax({
        type: "POST",
        url: 'PickReqWareHouse.aspx/GetCurrentWaybillNo',
        data: '{}',
        contentType: 'application/json',
        dataType: "json",
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                var waybillNo = item.split('ʭ')[0];
                console.log(item.split('ʭ')[0]);               
                $("[id$=Label1]").text("");
                $("[id$=Txt_WaybillNo]").val(waybillNo);
            });
        }
    });
}

function getCustomerType() {
    console.log(9090);
    $(".Ddl_PaymentMode option[value='PAID']").remove();
    $(".Ddl_PaymentMode option[value='TO PAY']").remove();
    $(".Ddl_PaymentMode option[value='CREDIT']").remove();
    $(".Ddl_PaymentMode option[value='FREE']").remove();
    if ($("[id$=Ddl_CustomerType]").val() == 'CORPORATE') {
        $("[id$=CustomerCodeDiv]").show();
        $("[id$=CorporateCustomerDiv]").show();
        $("[id$=WalkinCustomerDiv]").hide();
        $(".Ddl_PaymentMode").append('<option value="CREDIT">CREDIT</option>');
        $(".Ddl_PaymentMode").append('<option value="FREE">FREE</option>');
        $(".Ddl_PaymentMode option[value='PAID']").remove();
        $(".Ddl_PaymentMode option[value='TO PAY']").remove();
        InvoiceDetailForWalkin($("[id$=Ddl_PaymentMode]").val());
            if ($("[id$=Ddl_PaymentMode]").val() == 'FREE') {
                $("[id$=InvoiceDetailDiv]").hide();
            }
            else {
                $("[id$=InvoiceDetailDiv]").show();
            }   
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
    else if ($("[id$=Ddl_CustomerType]").val() == 'WALKIN') {
        $("[id$=CorporateCustomerDiv]").hide();
        $("[id$=CustomerCodeDiv]").hide();
        $("[id$=WalkinCustomerDiv]").show();
        $(".Ddl_PaymentMode option[value='CREDIT']").remove();
        $(".Ddl_PaymentMode option[value='FREE']").remove();
        $(".Ddl_PaymentMode").append('<option value="PAID">PAID</option>');
        $(".Ddl_PaymentMode").append('<option value="TO PAY">TO PAY</option>');
        $("[id$=Txt_Rate]").val(8);
        InvoiceDetailForWalkin($("[id$=Ddl_PaymentMode]").val()); 
            $("[id$=InvoiceDetailDiv]").show(); 
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
    }
};

function InvoiceDetailForWalkin(type) {
    console.log(1231);
    $("[id$=GV_Invoice]").empty();
    $.ajax({
        url: 'PickReqWareHouse.aspx/GetWaybillInvoice',
        data: "{ 'type': '" + type + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            $("[id$=GV_Invoice]").append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle hidden'>RATE ID</th><th class='gvHeaderStyle'>RATE TYPE</th><th class='gvHeaderStyle'>CHARGES</th></tr>")
            for (var i = 0; i < response.d.length; i++) {
                Index = i + 1;
                // debugger;            
                $("[id$=GV_Invoice]").append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
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
function InvoiceDetailForWalkinUpdateValue(value,type) {
    console.log(3456);
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
                console.log("loop1");
                Index = Index + 1;
                if (item.split('ʭ')[0] == 3)
                {
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


function getPaymentType() {
    console.log(8090);
    if ($("[id$=Ddl_PaymentMode]").val() == 'FREE')
    {
        $("[id$=InvoiceDetailDiv]").hide();
    }
    else
    {
        $("[id$=InvoiceDetailDiv]").show();
    }
    InvoiceDetailForWalkin($("[id$=Ddl_PaymentMode]").val());
};

function ReadDataonchange(text, textid, ddlID, path) {
    console.log(text);
    console.log(ddlID);
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
                console.log($("[id$='" + text + "']").val());

                if (text == "Txt_CustCode" || text == "Txt_CCustName")
                    getCustomerDetailOnCode(text, ddlID);

                else if (text == "Txt_WCustName")
                    getWalkinCustomerDetailOnName(text, ddlID);

                else if (text == "Txt_ConsigneeName")
                    getConsigneeDetailOnName(text, ddlID);

                else if (text == "Txt_DeliveryBranch")
                    GetBranchDeliveryArea();

                else if (text == "Txt_MaterialType")
                    GetMaterialDetails($("[id$='" + textid + "']").val());

                else if (text == "Txt_CustPin" || text == "Txt_PickPin" || text == "Txt_DelPin" || text == "Txt_PopupConsignorPincode" || text == "Txt_PopConsigneePincode") {
                    console.log($("[id$='" + text + "']").val());
                    GetAreaInDropDown($("[id$='" + text + "']").val(), ddlID, "");
                    if (text == "Txt_PopupConsignorPincode")
                        FillDistrictCityName($("[id$='" + text + "']").val(), "Txt_PopupConsignorDistrict", "Txt_PopupConsignorCity");
                    else if (text == "Txt_PopConsigneePincode")
                        FillDistrictCityName($("[id$='" + text + "']").val(), "Txt_PopConsigneeDistrict", "Txt_PopConsigneeCity");
                    else if (text == "Txt_PickPin")
                        getPickupBranch(textid);
                    else if (text == "Txt_DelPin")
                        getDeliveryBranch(textid);                   
                }
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
};

function GetMaterialDetails(textid) {
    $("[id$=Txt_NoOfPackage]").val(" ");
    console.log("materialDetails");
    $.ajax({
        type: "POST",
        url: 'PickReqCRMBranch.aspx/getMaterialDetails',
        data: '{materialId: "' + textid + '" }',
        contentType: 'application/json',
        dataType: "json",
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                if (item.split('ʭ')[0] != 999999)
                {
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

function GetBranchDeliveryArea() {
    var LocID = $("[id*=hfDeliveryBranch").val();
    $.ajax({
        type: "POST",
        url: 'FreeWaybillEntry.aspx/getBranchDeliveryArea',
        data: '{locId: "' + LocID + '" }',
        contentType: 'application/json',
        dataType: "json",
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                $("[id*=hfDeliveryArea").val(item.split('ʭ')[0]);
                console.log($("[id*=hfDeliveryArea").val());
            });
        }
    });
}
//function CheckArea(text) {
//    if (text == "Txt_CustPin" && $("[id$='" + text + "']").val() == "") {
//        $("[id$=Ddl_CustArea]").val("SELECT");
//        // $("[id$=hfCustAreaID]").val("");
//    }
//    else if (text == "Txt_PickPin" && $("[id$='" + text + "']").val() == "") {
//        $("[id$=Ddl_PickArea]").val("SELECT");
//        // $("[id$=hfPicAreaID]").val("");
//        $("[id$=Txt_PickupBranch]").val("AUTO");
//        $("[id$=hfPickupBranch]").val("");
//    }
//    else if (text == "Txt_DelPin" && $("[id$='" + text + "']").val() == "") {
//        $("[id$=Ddl_DelArea]").val("SELECT");
//        //  $("[id$=hfDelArea]").val("");
//    }
//    else if (text == "Txt_PopupConsignorPincode" && $("[id$='" + text + "']").val() == "") {
//        $("[id$=Txt_PopupConsignorArea]").val("");
//        $("[id$=hfPopupConsignorArea]").val("");
//    }
//    else if (text == "Txt_PopConsigneePincode" && $("[id$='" + text + "']").val() == "") {
//        $("[id$=Txt_PopConsigneeArea]").val("");
//        $("[id$=hfPopConsigneeArea]").val("");
//    }
//}

function ReadDataOnChangeTwoParam(text1, textid1, text2, path) {
    $.ajax({
        url: path,
        data: "{'searchPrefixText': '" + $("[id$='" + text1 + "']").val() + "','data':'" + "ReadData" + "','data2':'" + $("[id$='" + text2 + "']").val() + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                $("[id$='" + text1 + "']").val(item.split('ʭ')[0]);
                $("[id$='" + textid1 + "']").val(item.split('ʭ')[1]);
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
};

function GetAreaInDropDown(text, ddlID, areaID) {
    console.log(ddlID);
    console.log(areaID);
    if (text != "") {
        $.ajax({
            type: "POST",
            url: 'PickReqCRMBranch.aspx/getArea',
            data: "{ 'pincode': '" + text + "'}",
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                console.log($("[id*='" + ddlID + "']"));
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

function FillDistrictCityName(text,district,city) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'PickReqCRMBranch.aspx/PincodeDetail',
            data: "{ 'pincode': '" + text + "'}",
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
                    $("[id$=Btn_AddNewInvoice]").show();
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
        $("[id$=Btn_AddNewInvoice]").hide();
    }
};

function getWalkinCustomerDetailOnName(text, ddlID) {
    console.log("walkin");
    console.log(ddlID);
    console.log($("[id$=hfWCustID]").val());
    if ($("[id$='" + text + "']").val() != "") {
        console.log(text);
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
                    $("[id$=Btn_AddNewInvoice]").show();
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
        $("[id$=Btn_AddNewInvoice]").hide();
    }
};

function getConsigneeDetailOnName(text, ddlID) {
    console.log(ddlID);
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

function getConsigneeDetailReverseOnName(text, ddlID) {
    console.log(ddlID);
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'ReverseWaybill.aspx/getConsigneeNameDetail',
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

function getPickupBranch(textid) {
    console.log(789);
    $("[id$=Txt_PickupBranch]").val("AUTO");
    $("[id$=hfPickupBranch]").val("");

    if ($("[id$='" + textid + "']").val() != "") {
        console.log(100);
        $.ajax({
            url: 'PickReqCRMBranch.aspx/getPickupBranch',
            data: "{ 'pincode': '" + $("[id$='" + textid + "']").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    console.log(200);
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

function getDeliveryBranch(textid) {
    console.log(textid);
    console.log($("[id$='" + textid + "']").val());
    console.log("DeliveryBranch1");
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
                    console.log("DeliveryBranch2");
                    $("[id$=Txt_DeliveryBranch]").val(item.split('ʭ')[0]);
                    $("[id$=hfDeliveryBranch]").val(item.split('ʭ')[1]);
                });
            }
        });
    } else {
        console.log("DeliveryBranch3");
        $("[id$=Txt_DeliveryBranch]").val("AUTO");
        $("[id$=hfDeliveryBranch]").val("");
    }
};

function fillPickupDetails(textid) {
    console.log(1234);
    var chk = $("[id$=SameAdd]");
    if ($(chk).is(':checked')) {
        console.log(4567);
        $("[id$=Txt_PickPin]").val($("[id$=Txt_CustPin]").val());
        $("[id$=hfPickPinID]").val($("[id$=hfCustPinID]").val());
        $("[id$=Txt_PickPin]").attr("disabled", "disabled");
        GetAreaInDropDown($("[id$=Txt_PickPin]").val(), "Ddl_PickArea", $("[id$=Ddl_CustArea]").val());
        $("[id$=Ddl_PickArea]").attr("disabled", "disabled");
        $("[id$=Txt_PickAdd]").val($("[id$=Txt_CustAdd]").val());
        $("[id$=Txt_PickAdd]").attr("disabled", "disabled");
       // getPickupBranch(textid);
        getPickupBranch("hfCustPinID");
    }
    else {
        console.log(8910);
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