function ReadDataonchange(text, textid, ddlID, path) {
    console.log(ddlID);
    console.log(text);
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
                console.log(text);
                if (text == "Txt_Pincode") {
                    console.log(ddlID);
                    console.log($("[id$='" + text + "']").val());
                    GetAreaInDropDown($("[id$='" + text + "']").val(), ddlID, "");
                    getPincodeDetails(text);
                }
                else if (text == "Txt_FromPincode") {                   
                    console.log($("[id$='" + text + "']").val());                 
                    getFromPincodeDetails(text);
                }
                else if (text == "Txt_ToPincode") {
                    console.log($("[id$='" + text + "']").val());
                    getToPincodeDetails(text);
                }
                else if (text == "Txt_VendorName") {
                    console.log($("[id$='" + textid + "']").val());
                    getVendorDetails(textid);
                }
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
            url: 'Party_CustomerCreation.aspx/getArea',
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
                    $("[id$=Txt_BelongToBranch]").val(item.split('ʭ')[3]);
                    $("[id$=hfbranchID]").val(item.split('ʭ')[4]);
                    $("[id$=hfDistrict]").val(item.split('ʭ')[5]);
                    $("[id$=hfCity]").val(item.split('ʭ')[6]);
                });
            }
        });
    } else {
        $("[id$=Txt_State]").val("AUTO");
        $("[id$=Txt_District]").val("AUTO");
        $("[id$=Txt_City]").val("AUTO");
        $("[id$=Txt_BelongToBranch]").val("AUTO");
        $("[id$=hfbranchID]").val("");
        $("[id$=hfDistrict]").val("");
        $("[id$=hfCity]").val("");

    }
};


function getFromPincodeDetails(text) {
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
                    $("[id$=Txt_FromState]").val(item.split('ʭ')[0]);
                    $("[id$=Txt_FromDistrict]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_FromCity]").val(item.split('ʭ')[2]);                                   
                    $("[id$=hfFromDistrict]").val(item.split('ʭ')[5]);
                    $("[id$=hfFromCity]").val(item.split('ʭ')[6]);
                    $("[id$=hfFromState]").val(item.split('ʭ')[7]);
                });
            }
        });
    } else {
        $("[id$=Txt_FromState]").val("");
        $("[id$=Txt_FromDistrict]").val("");
        $("[id$=Txt_FromCity]").val("");
        $("[id$=hfFromDistrict]").val("");
        $("[id$=hfFromCity]").val("");
        $("[id$=hfFromState]").val("");

    }
};
function getToPincodeDetails(text) {
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
                    $("[id$=Txt_ToState]").val(item.split('ʭ')[0]);
                    $("[id$=Txt_ToDistrict]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_ToCity]").val(item.split('ʭ')[2]);
                    $("[id$=hfToDistrict]").val(item.split('ʭ')[5]);
                    $("[id$=hfToCity]").val(item.split('ʭ')[6]);
                    $("[id$=hfToState]").val(item.split('ʭ')[7]);
                });
            }
        });
    } else {
        $("[id$=Txt_ToState]").val("");
        $("[id$=Txt_ToDistrict]").val("");
        $("[id$=Txt_ToCity]").val("");
        $("[id$=hfToDistrict]").val("");
        $("[id$=hfToCity]").val("");
        $("[id$=hfToState]").val("");

    }
};

function ReadDataOnChangeTwoParam(text1, textid1, text2, path) {
    console.log(text1);
    console.log(text2);
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

function getCustomerCategory() {
    if ($("[id$=Ddl_Categoryofcustomer]").children("option:selected").val() == 'CUSTOMER') {
        $("[id$=billingparty]").show();
    }
    else {        
        $("[id$=billingparty]").hide();
    }  
};

function getVendorDetails(text) {
    if ($("[id$='" + text + "']").val() != "") {
        $.ajax({
            url: 'Contract_VendorMaster.aspx/getVendorDetail',
            data: "{ 'vendorId': '" + $("[id$='" + text + "']").val() + "'}",
            dataType: "json",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var data = response.d;
                $.each(data, function (index, item) {
                    $("[id$=Txt_VendorType]").val(item.split('ʭ')[0]);
                    $("[id$=Txt_PartyContact]").val(item.split('ʭ')[1]);
                    $("[id$=Txt_BelongToBranch]").val(item.split('ʭ')[2]);                   
                });
            }
        });
    } else {
        $("[id$=Txt_VendorType]").val("AUTO");
        $("[id$=Txt_PartyContact]").val("AUTO");
        $("[id$=Txt_BelongToBranch]").val("AUTO");
    }
};