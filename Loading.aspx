<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Loading.aspx.cs" Inherits="TranshipmentLoading" %>

<%@ Register Src="~/WaybillEntry.ascx" TagName="WaybillEntry" TagPrefix="uc" %>
<%@ Register Src="~/RouteMaster.ascx" TagPrefix="uc" TagName="Route" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hfTabs" Value="" runat="server" />
    <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
    <script>
        function RouteFunction(RouteId) {
            var id = $("[id*='" + RouteId + "']").val();

            console.log(id);
            $("[id*=<%=RoutepopUp.FindControl("txtFromBranch").ClientID%>]").val("");
            $("[id*=<%=RoutepopUp.FindControl("hffromBranchID").ClientID%>]").val("");
            $("[id*=<%=RoutepopUp.FindControl("txtToBranch").ClientID%>]").val("");
            $("[id*=<%=RoutepopUp.FindControl("hfToBranchID").ClientID%>]").val("");
            $("[id*=<%=RoutepopUp.FindControl("txtRouteName").ClientID%>]").val("");
            $("[id*=<%=RoutepopUp.FindControl("txtTotalDistance").ClientID%>]").val(0);
            $("[id*=<%=RoutepopUp.FindControl("txtTotalMapDistance").ClientID%>]").val(0);
            $("[id*=<%=RoutepopUp.FindControl("txtFromBranch").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=RoutepopUp.FindControl("txtToBranch").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=RoutepopUp.FindControl("txtRouteName").ClientID%>]").attr("disabled", "disabled");
            $("[id*=<%=RoutepopUp.FindControl("HideShowData").ClientID%>]").hide();

            var gridView = $("[id*=<%=RoutepopUp.FindControl("GV_RouteDetail").ClientID%>]");
            var row = gridView.find("tr")
            row.remove();
            $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>FROM BRANCH</th><th class='gvHeaderStyle'>TO BRANCH</th><th class='gvHeaderStyle'>DISTANCE</th><th class='gvHeaderStyle'>MAP DISTANCE</th></tr>");
            if (id != "SELECT") {
                $.ajax({
                    url: 'Loading.aspx/GetRouteHeaderData',
                    data: "{ 'vehicleRequestId': '" + id + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {
                            $("[id*=<%=RoutepopUp.FindControl("txtFromBranch").ClientID%>]").val(item.split('ʭ')[0]);
                            $("[id*=<%=RoutepopUp.FindControl("hffromBranchID").ClientID%>]").val(item.split('ʭ')[1]);
                            $("[id*=<%=RoutepopUp.FindControl("txtToBranch").ClientID%>]").val(item.split('ʭ')[2]);
                            $("[id*=<%=RoutepopUp.FindControl("hfToBranchID").ClientID%>]").val(item.split('ʭ')[3]);
                            $("[id*=<%=RoutepopUp.FindControl("txtRouteName").ClientID%>]").val(item.split('ʭ')[4]);
                            $("[id*=<%=RoutepopUp.FindControl("txtTotalDistance").ClientID%>]").val(item.split('ʭ')[5]);
                            $("[id*=<%=RoutepopUp.FindControl("txtTotalMapDistance").ClientID%>]").val(item.split('ʭ')[6]);
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });

                $.ajax({
                    url: 'Loading.aspx/GetRouteDetailsData',
                    data: "{ 'vehicleRequestId': '" + id + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        Index = 0;
                        $.each(data, function (index, item) {
                            console.log("loop");

                            Index = Index + 1;
                            $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[0] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[2] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[4] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[5] + "</td>" +
                                               "</tr>");
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });
            }
        }
        function YourFunction(id) {
            console.log(id);
            $("[id*=<%=PopUp.FindControl("currentWaybills").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_consignor").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_walkinConsignor").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("SameAsText").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("hl_consignee").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("InvoiceDetailDiv").ClientID%>]").hide();
            $("[id*=<%=PopUp.FindControl("PrevWayBill").ClientID%>]").hide();
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
        //$(document).ready(function () {
        //    $("[id*=Ddl_SelectVehicle]").change(function () {
        //        console.log("In On Change", $("[id*=Ddl_SelectVehicle]").val());
        //        $("[id*=hfDdlVehicle]").val($("[id*=Ddl_SelectVehicle]").val());
        //        return false;
        //    });
        //});
       var gridViewPickId = '#<%= gvPickupLoadingDetails.ClientID %>';
            function checkPickAll(selectAllCheckbox) {
                //get all checkboxes within item rows and select/deselect based on select all checked status            
                $('td :checkbox', gridViewPickId).prop("checked", selectAllCheckbox.checked);
            }
            function unCheckPickSelectAll(selectCheckbox) {
                //if any item is unchecked, uncheck header checkbox as well
                if (!selectCheckbox.checked)
                    $('th :checkbox', gridViewPickId).prop("checked", false);
            }
       var gridViewDelId = '#<%= gvDeliveryLoadingDetails.ClientID %>';
            function checkDelAll(selectAllCheckbox) {
                $('td :checkbox', gridViewDelId).prop("checked", selectAllCheckbox.checked);
            }
            function unCheckDelSelectAll(selectCheckbox) {              
                if (!selectCheckbox.checked)
                    $('th :checkbox', gridViewDelId).prop("checked", false);
            }
         var gridViewTranshipId = '#<%= gvwLoadingDetails.ClientID %>';
            function checkTranshipAll(selectAllCheckbox) {             
                $('td :checkbox', gridViewTranshipId).prop("checked", selectAllCheckbox.checked);
            }
            function unCheckTranshipSelectAll(selectCheckbox) {            
                if (!selectCheckbox.checked)
                    $('th :checkbox', gridViewTranshipId).prop("checked", false);
            }  
    </script>
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_PickDelDetails" AssociatedUpdatePanelID="UpdatePanel_PickDelDetails" runat="server" DisplayAfter="0">
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
    <asp:UpdateProgress ID="UpdateProgress_TranshipLoadingDetail" AssociatedUpdatePanelID="UpdatePanel_TranshipLoadingDetail" runat="server" DisplayAfter="0">
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

    <ul class="nav nav-tabs" id="myTab">
        <li class="nav-item" id="idPickUP" runat="server">
            <a data-toggle="tab" href="#Loading" id="pdl" runat="server">LOADING</a>
        </li>
        <li id="idTranship" class="nav-item" runat="server">
            <a data-toggle="tab" href="#TranshipmentLoadingDetails" id="tl" runat="server">LOADING</a>
        </li>

    </ul>

    <div class="tab-content">
        <div id="AlertNotification"></div>
        <!--********************************************************************PICKUP LOADING DEATILS*************************************************************************-->
        <div id="Loading" runat="server">
            <div>
                <asp:UpdatePanel ID="UpdatePanel_PickDelDetails" runat="server">
                    <ContentTemplate>
                        <div class="panel  panelTop">
                            <div class="panel-heading panelHead">
                                <b>PICKUP/DELIVERY LOADING</b>
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
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Label1" runat="server" CssClass="label labelColor">LOADING</asp:Label>
                                                <asp:DropDownList ID="Ddl_Loading" runat="server" CssClass="formDisplay input-sm Ddl_Loading" OnSelectedIndexChanged="Ddl_Loading_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>PICKUP</asp:ListItem>
                                                    <asp:ListItem>DELIVERY</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_PickupVehicle" runat="server" CssClass="label labelColor">SELECT VEHICLE</asp:Label>
                                                <asp:HiddenField ID="hfPickupVehicle" runat="server" />
                                                <asp:DropDownList ID="Ddl_PickupVehicle" runat="server" CssClass="formDisplay input-sm Ddl_PickupVehicle">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="divBranch" visible="false">
                                                <asp:Label ID="Label9" runat="server" CssClass="label labelColor">BRANCH</asp:Label>
                                                <asp:DropDownList ID="Ddl_DeliveryBranch" runat="server" CssClass="formDisplay input-sm Ddl_DeliveryBranch"></asp:DropDownList>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btn_PickupLoadingList" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle btn_PickupLoadingList" OnClick="btn_PickupLoadingList_Click">GET LIST&nbsp;</asp:LinkButton><%----%>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="PickDelPrint" visible="false">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btnPrintToDo" runat="server" Text="PRINT LIST" CssClass="btn btn-info largeButtonStyle btnPrintToDo" OnClick="btnPrintToDo_Click">PRINT LIST&nbsp;</asp:LinkButton><%----%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <asp:GridView ID="gvPickupLoadingDetails" runat="server" DataKeyNames="waybillID" AutoGenerateColumns="false" OnRowCommand="gvPickupLoadingDetails_RowCommand" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chk_selectall" onclick="checkPickAll(this);" runat="server" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_select" runat="server" onclick="unCheckPickSelectAll(this);" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="WayBillItemId" HeaderText="ITEM ID">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="WAYBILL NO">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Btn_Waybill" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("waybillID","javascript:YourFunction({0});")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>'></asp:LinkButton>
                                                        <%-- <asp:HyperLink runat="server" data-toggle="modal" data-target="#modalForViewData" NavigateUrl='<%#Eval("waybillID","javascript:return YourFunction(\"{0}\");")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>' />--%>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="waybillID" HeaderText="WAYBILL ID">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="materialName" HeaderText="ITEM NAME">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="packName" HeaderText="PACKAGE">
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
                                                <asp:TemplateField HeaderText="LOADED QTY" ItemStyle-Width="100">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="LoadedItemQty" AutoCompleteType="Disabled" Text='<%# Eval("remQty") %>' TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                                     <asp:Label ID="Lbl_QtyError" runat="server" ForeColor="Red"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
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
                                                                    <asp:LinkButton ID="Btn_Loading" runat="server" CommandName="LOAD" CommandArgument='<%# Container.DataItemIndex %>' Text="LOAD"></asp:LinkButton>
                                                                    <asp:Label ID="Lbl_Loaded" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:GridView>

                                        <asp:GridView ID="gvDeliveryLoadingDetails" runat="server" DataKeyNames="waybillID" AutoGenerateColumns="false" OnRowCommand="gvDeliveryLoadingDetails_RowCommand" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chk_selectall" onclick="checkDelAll(this);" runat="server" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_select" runat="server" onclick="unCheckDelSelectAll(this);" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="WayBillItemId" HeaderText="ITEM ID">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="WAYBILL NO">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Btn_Waybill" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("waybillID","javascript:YourFunction({0});")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>'></asp:LinkButton>
                                                        <%-- <asp:HyperLink runat="server" data-toggle="modal" data-target="#modalForViewData" NavigateUrl='<%#Eval("waybillID","javascript:return YourFunction(\"{0}\");")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>' />--%>
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
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="materialName" HeaderText="ITEM NAME">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="packNAme" HeaderText="PACKAGE">
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
                                                <asp:TemplateField HeaderText="LOADED QTY" ItemStyle-Width="100">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="LoadedItemQty" AutoCompleteType="Disabled" Text='<%# Eval("remQty") %>' TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)"></asp:TextBox>
						<asp:Label ID="Lbl_QtyError" runat="server" ForeColor="Red"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
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
                                                                    <asp:LinkButton ID="Btn_Loading" runat="server" CommandName="LOAD" CommandArgument='<%# Container.DataItemIndex %>' Text="LOAD"></asp:LinkButton>
                                                                    <asp:Label ID="Lbl_Loaded" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                                
                                            </Columns>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:GridView>
                                    </div>
  <div class="form-group" id="PickDelSubmit" runat="server" visible="false">
                                        <div class="row">
                                            <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Button_PickDelSubmit" runat="server" CssClass="btn btn-info Button_PickDelSubmit largeButtonStyle" OnClick="Button_PickDelSubmit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_PickDelReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_PickDelReset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--***************************************************************************************************************-->
                            <div runat="server" id="loadedItems" visible="false">
                                <div class="panel-heading panelHead">
                                    <b>LOADED WAYBILL MATERIALS</b>
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
                                            <table border="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblPickDelHeader" runat="server" CssClass="label labelColor"></asp:Label>
                                                    </td>
                                                    <td>.</td>
                                                    <td>
                                                        <asp:Label ID="lblNo" runat="server" CssClass="label labelColor" Text="No."></asp:Label></td>
                                                    <td>
                                                        <asp:Label ID="lblPickDelNo" runat="server" CssClass="label labelColor"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <asp:LinkButton ID="btnPrintDRS" runat="server" Text="PRINT LIST" CssClass="btn btn-info largeButtonStyle btnPrintToDo" OnClick="btnPrintDRS_Click">PRINT LIST&nbsp;</asp:LinkButton>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="form-group">
                                            <asp:GridView ID="GV_LoadedWaybillItems" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                    <asp:BoundField DataField="Qty" HeaderText="LOADED QTY">
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
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btn_PickupLoadingList" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>

        <!--********************************************************************TRANSHIPMENT LOADING DEATILS*************************************************************************-->
        <div id="TranshipmentLoadingDetails" runat="server">
            <div>
                <asp:UpdatePanel ID="UpdatePanel_TranshipLoadingDetail" runat="server">
                    <ContentTemplate>
                        <div class="panel  panelTop">
                            <div class="panel-heading panelHead">
                                <b>TRANSHIPMENT LOADING </b>
                                  <div style="text-align: right; text-wrap: inherit;">
                                    <asp:Label ID="Label5" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL QTY:</asp:Label>
                                    <asp:Label ID="Lbl_TotalTranshipQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="Label8" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL WEIGHT:</asp:Label>
                                    <asp:Label ID="Lbl_TotalTranshipWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                </div>
                            </div>

                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                           <div class="row">
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="lblSelectVehicle" runat="server" CssClass="label labelColor">SELECT VEHICLE</asp:Label>
                                                 <asp:HiddenField ID="hfDdlVehicle" runat="server" />
                                                <asp:DropDownList ID="Ddl_SelectVehicle" runat="server" CssClass="formDisplay input-sm Ddl_SelectVehicle" AutoPostBack="true" OnSelectedIndexChanged="Ddl_SelectVehicle_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </div>                                       
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_ManifestBranch" runat="server" CssClass="label labelColor">MANIFEST BRANCH</asp:Label>
                                                 <asp:HiddenField ID="HiddenField1" runat="server" />
                                                <asp:DropDownList ID="Ddl_ManifestBranch" runat="server" CssClass="formDisplay input-sm Ddl_ManifestBranch">
                                                </asp:DropDownList>
                                            </div>                                         
                                              <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">ROUTE NAME</asp:Label>
                                                <asp:TextBox ID="Txt_RouteName" runat="server" CssClass="form-control input-sm Txt_RouteName" ReadOnly="true"></asp:TextBox>     
                                            </div>                                       
                                             <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-1">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btnGetDetails" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle btnGetDetails" OnClick="btnGetDetails_Click">GET LIST&nbsp;</asp:LinkButton>
                                            </div>
                                              <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="TranshipPrint" visible="false">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="Btn_TranshipLoadingPrint" runat="server" CssClass="btn btn-info largeButtonStyle2 Btn_TranshipLoadingPrint" OnClick="btnPrintToDo_Click">PRINT LOADING SHEET&nbsp;</asp:LinkButton>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="routeDiv" runat="server" visible="false">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="BtnViewRoute" runat="server" Text="VIEW VEHICLE ROUTE" CssClass="btn btn-info largeButtonStyle2 BtnViewRoute" data-toggle="modal" data-target="#RouteModal" OnClientClick="RouteFunction('Ddl_SelectVehicle');">VIEW VEHICLE ROUTE&nbsp;</asp:LinkButton><%----%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <asp:GridView ID="gvwLoadingDetails" runat="server" DataKeyNames="waybillID" AutoGenerateColumns="false" OnRowCommand="gvwLoadingDetails_RowCommand" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
 <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chk_selectall" onclick="checkTranshipAll(this);" runat="server" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_select" runat="server" onclick="unCheckTranshipSelectAll(this);" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="WayBillItemId" HeaderText="ITEM ID">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="WAYBILL NO">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Btn_Waybill" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("waybillID","javascript:YourFunction({0});")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>'></asp:LinkButton>
                                                        <%-- <asp:HyperLink runat="server" data-toggle="modal" data-target="#modalForViewData" NavigateUrl='<%#Eval("waybillID","javascript:return YourFunction(\"{0}\");")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>' />--%>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="waybillID" HeaderText="WAYBILL ID" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="toBranchName" HeaderText="BRANCH">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="ManifestBranch" HeaderText="MANIFEST BRANCH">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="materialName" HeaderText="ITEM NAME">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="packNAme" HeaderText="PACKAGE">
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
                                                <asp:TemplateField HeaderText="LOADED QTY" ItemStyle-Width="100">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="LoadedItemQty" AutoCompleteType="Disabled" Text='<%# Eval("remQty") %>' TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)"></asp:TextBox>
 						<asp:Label ID="Lbl_QtyError" runat="server" ForeColor="Red"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
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
                                                                    <asp:LinkButton ID="Btn_Loading" runat="server" CommandName="LOAD" CommandArgument='<%# Container.DataItemIndex %>' Text="LOAD"></asp:LinkButton>
                                                                    <asp:Label ID="Lbl_Loaded" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                </asp:TemplateField>
                                               
                                            </Columns>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:GridView>
                                    </div>
  <div class="form-group" id="TranshipSubmit" runat="server" visible="false">
                                        <div class="row">
                                            <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_TranshipSubmit" runat="server" CssClass="btn btn-info Btn_TranshipSubmit largeButtonStyle" OnClick="Btn_TranshipSubmit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Btn_TranshipReset" runat="server"  CssClass="btn btn-info largeButtonStyle" OnClick="Btn_TranshipReset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="TranshipLoadedItems" runat="server" visible="false">
                             <div class="panel-heading panelHead">
                                <b>LOADED WAYBILL MATERIAL</b>
                                  <div style="text-align: right; text-wrap: inherit;">
                                        <asp:Label ID="Label7" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL LOADED QTY:</asp:Label>
                                        <asp:Label ID="Lbl_TotalTranshipLoadedQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                        <asp:Label ID="Label10" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL LOADED WEIGHT:</asp:Label>
                                        <asp:Label ID="Lbl_TotalTranshipLoadedWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                    </div>
                            </div>
							
                            <div class="panel-body">
                                <div class="form-horizontal" role="form">
                                      <div class="form-group">
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                <asp:Label ID="lblManifestNo" runat="server" CssClass="label labelColor"></asp:Label>
                                            </div>
                                           <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                <asp:LinkButton ID="btnPrintManifest" runat="server" CssClass="btn btn-info largeButtonStyle2 btnPrintManifest" OnClick="btnPrintDRS_Click">PRINT MANIFEST&nbsp;</asp:LinkButton>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 "> 
                                                <asp:DropDownList id="ddlManifest" runat="server"></asp:DropDownList> 
                                            </div>
					    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                                                <asp:LinkButton ID="btnPrintLHS" runat="server"  CssClass="btn btn-info largeButtonStyle btnPrintLHS" OnClick="btnPrintLHS_Click">PRINT LHS</asp:LinkButton> 
                                            </div>
                                        </div>
                                    <div class="form-group">
                                        <asp:GridView ID="GV_TranshipLoadedWaybillItems" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="pickUpBranchName" HeaderText="BRANCH">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="DeliveryBranchName" HeaderText="MANIFEST BRANCH">
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
                                                <asp:BoundField DataField="Qty" HeaderText="LOADED QTY">
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
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnGetDetails" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
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

        <!--================================================PopUp Window for Route Detail============================================================================-->
        <!-- Modal -->
        <div class="modal" id="RouteModal" role="dialog">
            <div class="modal-dialog">
                <!--Modal Content-->
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">ROUTE DETAIL</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <uc:Route ID="RoutepopUp" runat="server" />
                            <%--<iframe src="RoutePopup.aspx"/>--%>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <!--=====================================End Popup Window for Route Detail====================================================-->
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->

    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

