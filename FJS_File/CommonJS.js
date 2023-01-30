function ReadDataonchange(text, textid, ddlID, path) {
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
                if (text == "Txt_CustCode" || text == "Txt_CCustName")
                    getCustomerDetailOnCode(text, ddlID);

                else if (text == "Txt_WCustName")
                    getWalkinCustomerDetailOnName(text, ddlID);

                else if (text == "Txt_ConsigneeName")
                    getConsigneeDetailOnName(text, ddlID);
                else if (text == "Txt_CustPin" || text == "Txt_PickPin" || text == "Txt_DelPin" || text == "Txt_PopupConsignorPincode" || text == "Txt_PopConsigneePincode") {
                    console.log($("[id$='" + text + "']").val());
                    GetAreaInDropDown($("[id$='" + text + "']").val(), ddlID, "");
                    if (text == "Txt_PickPin")
                        getPickupBranch(textid);
                }
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
};
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


function getPincodeDetails(text) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'Party_CustomerCreation.aspx/PincodeDetail',
            data: "{ 'pincode': '" + $("[id$='" + text + "']").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$=Txt_State]").val(item.split('ʭ')[0]);
                    $("[id$=Txt_District]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_City]").val(item.split('ʭ')[2]);
                });
            }
        });
    } else {
        $("[id$=Txt_State]").val("AUTO");
        $("[id$=Txt_District]").val("AUTO");
        $("[id$=Txt_City]").val("AUTO");
    }
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
