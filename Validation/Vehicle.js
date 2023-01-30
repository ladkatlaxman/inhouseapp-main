
$("[id$= Txt_HiringDate]").datepicker({ dateFormat: 'dd/mm/yy', minDate: 0 }).datepicker("setDate", new Date());

//alert($("[id$=Txt_HiringDate]").val()); 

//showSubmit('any One', 'any Two');

function GetVehicleData() {
    $.ajax({
        url: '/VehicleRequest.aspx/getVehicles',
        data: "{'searchPrefixText': '" + $("[id*='txtVehicleNo']").val() + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                if (index == 0) {
                    $("[id$='txtVehicleNo']").val(item.split('ʭ')[0]);
                    $("[id$='hVehicleId']").val(item.split('ʭ')[1]);
                    $("[id$='Txt_NewVehicleNoAlpha1']").val(item.split('ʭ')[0].substr(0, 2));
                    $("[id$='Txt_NewVehicleNoDigit1']").val(item.split('ʭ')[0].substr(2, 2));
                    $("[id$='Txt_NewVehicleNoAlpha2']").val(item.split('ʭ')[0].substr(4, 2));
                    $("[id$='Txt_NewVehicleNoDigit2']").val(item.split('ʭ')[0].substr(6, 4));
                    GetVehicleDetails(item.split('ʭ')[1]); 
                    getVehiclelimits(item.split('ʭ')[1]); 
                }
            })
        }
    })
}

function GetVehicleDetails(vehicleid) {
    $.ajax({
        url: '/VehicleRequest.aspx/getVehicleDetail',
        data: "{'searchPrefixText': '" + vehicleid + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                $("[id*='Txt_VehicleCategory']").val(item.split('ʭ')[0]);
                $("[id*='Txt_VehicleType']").val(item.split('ʭ')[1]);
                $("[id*='Txt_VendorName']").val(item.split('ʭ')[0]);
            })
        }
    })
}


$(document).ready(function () {
    $(function () {
        
        $("[id*='txtVehicleNo']").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '/VehicleRequest.aspx/getVehicles',
                    data: "{ 'searchPrefixText': '" + request.term + "'}", 
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
                $("[id*='hVehicleId']").val(i.item.val);
            },
            minLength: 3
        });

        $("[id*='Ddl_Condition']").change(function () { // When the value changes
            //alert('here'); 
            var value = $(this).val();
            hideDivs();

            if (value == 'PD') { // PICK UP / DELIVERY 
                $('#divDelivery').show();
                $('#divTrans1').hide();
                $('#divTrans2').hide();
            }
            if (value == 'RT') { // TRANSHIPMENT
                $('#divDelivery').hide();
                $('#divTrans1').show();
                $('#divTrans2').show();
            }
        }).change();

        $("[id*='ddlTranshipmentRoute']").change(function () { // When the Route Name changes
            if ($(this).val() != 'SELECT') GetRouteSchedule($(this).val());
        }).change();

        $("[id*='Button_Submit']").bind("click", function () {
            if ($("[id$='hVehicleId']").val() == "" || $("[id$='txtVehicleNo']").val() == "") {
                alert('Select Vehicle No.');
                return false;
                $("[id$='txtVehicleNo']").focus();
            }
            if ($("[id$='Ddl_Condition']").val() == "RT") {
                if ($("[id$='ddlTranshipmentRoute']").val() == "SELECT" || $("[id$='ddlTranshipmentRoute']").val() == "") {
                    alert('Select Vehicle Route.');
                    $("[id$='ddlTranshipmentRoute']").focus();
                    return false;
                }
                if ($("[id$='Ddl_RouteSchedule']").val() == "SELECT" || $("[id$='ddlTranshipmentRoute']").val() == "") {
                    alert('Select Route Schedule.');
                    $("[id$='Ddl_RouteSchedule']").focus();
                    return false;
                }
            }
            $("[id*='hdHiringDate']").val($("[id*='Txt_HiringDate']").val());
            $("[id*='hdRouteSchedule']").val($("[id*='Ddl_RouteSchedule']").val());
            
        });
        $("[id*='Button_Submit_Limit']").bind("click", function () {
            if ($("[id$='hVehicleId']").val() == "" || $("[id$='txtVehicleNo']").val() == "") {
                alert('Select Vehicle No.');
                $("[id$='txtVehicleNo']").focus();
                return false;
            }
            if ($("[id$='ddlTranshipmentRoute']").val() == "SELECT" & $("[id$='Ddl_AccessBranch']").val() == "SELECT") {
                alert('Select Vehicle Route or Branch as a Condition.'); 
                $("[id$='ddlTranshipmentRoute']").focus();
                return false;
            }
        });
    });
})

hideDivs(); //Initialize
function hideDivs() {
    $('#divDelivery').hide();
    $('#divTrans1').hide();
    $('#divTrans2').hide();
}

function GetRouteSchedule(routeid) {
    if (routeid != "") {
        $.ajax({
            type: "POST",
            url: '/VehicleRequest.aspx/getRouteSchedules',
            data: "{ 'searchPrefixText': '" + routeid + "'}",
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                $("[id*='Ddl_RouteSchedule']").empty(); 
                $.each(response.d, function (index, item) {
                    $("[id*='Ddl_RouteSchedule']").append('<option value=' + item.split('ʭ')[0] + '>' + item.split('ʭ')[1] + '</option>');
                });
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(xhr.status);
                alert(thrownError);
            }
        });
    }
    else {
        $("[id*='Ddl_RouteSchedule']").empty().append('<option value="">SELECT</option>');
    }
}

function showSubmit(message) { 
    var x = document.getElementById('AlertNotification'); 
    x.className = "show"; 
    x.innerText = message; // "Vehicle No. " + vehicleno + " Created for " + route + " !";
    setTimeout(function () { x.className = x.className.replace("show", ""); }, 10000); 
}

function getVehiclelimits(vehicleid) {
    $.ajax({
        type: "POST",
        url: "VehicleLimit.aspx/getVehicleLimits",
        data: "{ 'VehicleId': '" + vehicleid + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function (r) {
            alert(r.d);
        },
        error: function (response) {
            alert(r.d);
        }
    });
}


function OnSuccess(r) {
    var chatDatas = r.d;
    var row = $("[id*=gvVehicleGrid] tr:last-child").clone(true);
    $("[id*=gvVehicleGrid] tr").not($("[id*=gvVehicleGrid] tr:first-child")).remove();
    $.each(chatDatas, function (index, item) {
        $("td", row).eq(0).html(item.split('ʭ')[0]);
        $("td", row).eq(1).html(item.split('ʭ')[1]);
        $("[id*=gvVehicleGrid]").append(row);
        row = $("[id*=gvVehicleGrid] tr:last-child").clone(true);
    })
}

