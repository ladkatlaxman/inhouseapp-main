function ReadDataonchange(text, textid, fromBranch, toBranch, Distance, data, path) {
    $.ajax({
        url: path,
        data: "{ 'searchPrefixText': '" + $("[id$='" + text + "']").val() + "','data':'" + data + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                $("[id$='" + text + "']").val(item.split('ʭ')[0]);
                $("[id$='" + textid + "']").val(item.split('ʭ')[1]);
                if (text == "TxtBranch2")
                    MapDistance(fromBranch, toBranch, Distance);
                if (text == "txtToBranch")
                    routeName(fromBranch, toBranch, Distance);
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
};

function routeName(fromBranch, toBranch, distance) {
    if ($("[id$='" + fromBranch + "']").val() != "" && $("[id$='" + toBranch + "']").val() != "")
        MapDistance(fromBranch, toBranch, distance);
    else
        $("[id$='" + distance + "']").val(0);
    if ($("[id$=txtFromBranch]").val() != "" && $("[id$=txtToBranch]").val() != "") {
        $("[id$=txtRouteName]").val($("[id$=txtFromBranch]").val() + "-" + $("[id$=txtToBranch]").val());
        $("[id$=TxtBranch1]").val($("[id$=txtFromBranch]").val());
        $("[id$=hfTxtBranch1ID]").val($("[id$=hffromBranchID]").val());
    }
    else if ($("[id$=txtFromBranch]").val() == "") {
        if ($("[id$=txtToBranch]").val() != "") {
            $("[id$=txtRouteName]").val($("[id$=txtFromBranch]").val() + "-" + $("[id$=txtToBranch]").val());
        } else {
            $("[id$=txtRouteName]").val("");
            $("[id$=TxtBranch1]").val($("[id$=txtFromBranch]").val());
            $("[id$=hfTxtBranch1ID]").val("");
        }
    }
    else if ($("[id$=txtToBranch]").val() == "") {
        if ($("[id$=txtFromBranch]").val() != "") {
            $("[id$=TxtBranch1]").val($("[id$=txtFromBranch]").val());
            $("[id$=txtRouteName]").val($("[id$=txtFromBranch]").val() + "-" + $("[id$=txtToBranch]").val());
        } else {
            $("[id$=txtRouteName]").val("");
            $("[id$=TxtBranch1]").val("AUTO");
            $("[id$=hfTxtBranch1ID]").val("");
        }
    }
};

function MapDistance(fromBranch, toBranch, distance) {
    if (fromBranch != "" || fromBranch != "AUTO")
        if (toBranch != "") {
            $.ajax({
                url: 'RouteMaster.aspx/GetMapDistance',
                data: "{'FromBranch':'" + $("[id*='" + fromBranch + "']").val() + "','ToBranch':'" + $("[id*='" + toBranch + "']").val() + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (data) {
                    console.log(data.d);
                    $("[id*='" + distance + "']").val(data.d);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });
        }
};
function TotalDistance() {
    var dblTotalDistance = parseInt($("[id$=txtTotalDistance]").val()) + parseInt($("[id$=TxtDistance]").val());
    $("[id$=txtTotalDistance]").val(dblTotalDistance);
    $("[id$=hfTotalDistance]").val(dblTotalDistance);
};

function GetSearchDdlBranch(text, textid, data) {
    if ($("[id*=Ddl_SearchingParameter]").val() == "SELECT")
        $("[id*=Txt_Search]").hide();
    else {
        $("[id*=Txt_Search]").show();
        console.log($("[id*=Ddl_SearchingParameter]").val());
        if (data == "GetData")
            GetSearchableBranch(text, textid, data, $("[id*=Ddl_SearchingParameter]").val());
    }
};
function GetSearchableBranch(text, textid, data, ddl) {
    console.log(text);
    $("[id$='" + text + "']").autocomplete({
        source: function (request, response) {
            $.ajax({
                url: 'RouteMaster.aspx/GetSearchBranch',
                data: "{ 'searchPrefixText': '" + request.term + "','data':'" + data + "','Param2':'" + ddl + "'}",
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
            $("[id$='" + textid + "']").val(i.item.val);
        },
        minLength: 3,
    });
};
function ReadSearchDataonchange(text, textid, data) {
    $.ajax({
        url: 'RouteMaster.aspx/GetSearchBranch',
        data: "{'searchPrefixText': '" + $("[id$='" + text + "']").val() + "','data':'" + data + "','Param2':'" + $("[id*=Ddl_SearchingParameter]").find("option:selected").text() + "'}",
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        success: function (response) {
            var data = response.d;
            $.each(data, function (index, item) {
                $("[id$='" + text + "']").val(item.split('ʭ')[0]);
                console.log($("[id$='" + text + "']").val());
                $("[id$='" + textid + "']").val(item.split('ʭ')[1]);
                console.log($("[id$='" + textid + "']").val());
            });
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
        }
    });
};