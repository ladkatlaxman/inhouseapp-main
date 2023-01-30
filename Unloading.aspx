<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Unloading.aspx.cs" Inherits="PickUPUnload" %>

<%--<%@ Register Src="~/LoadingUnloading.ascx" TagName="LoadUnload" TagPrefix="uc" %>--%>
<%@ Register Src="~/WaybillEntry.ascx" TagName="WaybillEntry" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hfTabs" Value="" runat="server" />
    <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

    <script>

        function GetVehicle(text) {
            console.log(1);
            console.log(text);
            $.ajax({
                type: "POST",
                url: 'Unloading.aspx/getVehicleList',
                data: "{ 'branchId': '" + text + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (response) {
                    console.log($("[id*=Ddl_SelectVehicle]"));
                    $("[id*=Ddl_SelectVehicle]").empty().append('<option selected="selected" value="0">SELECT</option>');
                    $.each(response.d, function () {
                        $("[id*=Ddl_SelectVehicle]").append('<option value=' + this['VehicleRequestID'] + '>' + this['vehicleNo'] + '</option>');
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });
        };

        $(document).ready(function () {
            $("[id*=Ddl_SelectVehicle]").change(function () {
                console.log(234);
                console.log("In On Change", $("[id*=Ddl_SelectVehicle]").val());
                $("[id*=hfDdlVehicle]").val($("[id*=Ddl_SelectVehicle]").val());
                //return false;
            });

            $("[id*=ddlTranshipmentVehicle]").change(function () {
                console.log(234);
                console.log("In On Change", $("[id*=ddlTranshipmentVehicle]").val());
                $("[id*=hfTranshipmentVehicle]").val($("[id*=ddlTranshipmentVehicle]").val());
                //return false;
            });
        });

    </script>

    <script>
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

        var gridViewPickId = '#<%= gvwPickUpWayBills.ClientID %>';
        function checkPickAll(selectAllCheckbox) {
            //get all checkboxes within item rows and select/deselect based on select all checked status            
            $('td :checkbox', gridViewPickId).prop("checked", selectAllCheckbox.checked);
        }
        function unCheckPickSelectAll(selectCheckbox) {
            //if any item is unchecked, uncheck header checkbox as well
            if (!selectCheckbox.checked)
                $('th :checkbox', gridViewPickId).prop("checked", false);
        }
        var gridViewDelId = '#<%= gvwDeliveryWaybills.ClientID %>';
            function checkDelAll(selectAllCheckbox) {
                $('td :checkbox', gridViewDelId).prop("checked", selectAllCheckbox.checked);
            }
            function unCheckDelSelectAll(selectCheckbox) {
                if (!selectCheckbox.checked)
                    $('th :checkbox', gridViewDelId).prop("checked", false);
            }
            var gridViewTranshipId = '#<%= grdTranshipmentWayBills.ClientID %>';
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
    <asp:UpdateProgress ID="UpdateProgress_TranshipUnloadingDetail" AssociatedUpdatePanelID="UpdatePanel_TranshipUnloadingDetail" runat="server" DisplayAfter="0">
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
            <a data-toggle="tab" href="#PickupDelDetails" id="pdl" runat="server">UNLOADING</a>
        </li>
        <li id="idTranship" class="nav-item" runat="server">
            <a data-toggle="tab" href="#Transhipment" id="tl" runat="server">UNLOADING</a>
        </li>

    </ul>

    <div class="tab-content" runat="server">
        <div id="AlertNotification"></div>
        <!--================================================Pick/Del Detail============================================================================-->
        <div id="PickupDelDetails" runat="server">
            <div>
                <asp:UpdatePanel ID="UpdatePanel_PickDelDetails" runat="server">
                    <ContentTemplate>
                        <div class="panel  panelTop">
                            <div class="panel-heading panelHead">
                                <b>PICKUP/DELIVERY UNLOADING</b>
                                <div style="text-align: right; text-wrap: inherit;">
                                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL QTY:</asp:Label>
                                    <asp:Label ID="Lbl_TotalQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="Label4" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL WEIGHT:</asp:Label>
                                    <asp:Label ID="Lbl_TotalWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                </div>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Label3" runat="server" CssClass="label labelColor">UNLOADING</asp:Label>
                                                <asp:DropDownList ID="Ddl_UnLoading" runat="server" OnSelectedIndexChanged="Ddl_UnLoading_SelectedIndexChanged" AutoPostBack="true" CssClass="formDisplay input-sm Ddl_UnLoading">
                                                    <asp:ListItem>SELECT</asp:ListItem>
                                                    <asp:ListItem>PICKUP</asp:ListItem>
                                                    <asp:ListItem>DELIVERY</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="lblSelectVehicle" runat="server" CssClass="label labelColor">SELECT VEHICLE</asp:Label>
                                                <asp:HiddenField ID="hfDdlVehicle" runat="server" />
                                                 <asp:DropDownList ID="Ddl_SelectVehicle" runat="server" CssClass="formDisplay input-sm Ddl_SelectVehicle" AutoPostBack="true" OnSelectedIndexChanged="Ddl_SelectVehicle_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_LoadingWaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                                <asp:TextBox ID="Txt_UnLoadingWaybillNo" runat="server" onkeypress="return validateNumericValue(event)" MaxLength="7" TabIndex="1" CssClass="form-control input-sm Txt_LoadingWaybillNo FirstNoSpaceAndZero" onchange="ReadDataonchange('Txt_UnLoadingWaybillNo', 'hfUnLoadingWaybillNo','', 'Loading.aspx/getWayBillNo');"></asp:TextBox>
                                                <asp:HiddenField ID="hfUnLoadingWaybillNo" runat="server" />
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btnGetDetails" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle btnGetDetails" OnClick="btnGetDetails_Click">GET LIST&nbsp;</asp:LinkButton>
                                            </div>
                    					    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">	
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:Label ID="lblUnloadingNo" runat="server"></asp:Label>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="PickDelPrint" visible="false">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btnPrintUnloading" runat="server" Text="PRINT LIST" CssClass="btn btn-info largeButtonStyle btnPrintUnloading" OnClick="btnPrintUnloading_Click">PRINT LIST&nbsp;</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body" id="searchPickupDetail" runat="server">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <asp:GridView ID="gvwPickUpWayBills" runat="server" AutoGenerateColumns="false" OnRowCommand="gvwPickUpWayBills_RowCommand" OnRowDataBound="gvwPickUpWayBills_RowDataBound" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="WAYBILL NO">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Btn_Waybill" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("waybillID","javascript:YourFunction({0});")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
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
                                                        <asp:TextBox runat="server" ID="Txt_Remark" Style="text-transform: uppercase" AutoCompleteType="Disabled" TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="Btn_Unload" runat="server" CommandName="UNLOAD" CommandArgument='<%# Container.DataItemIndex %>' Text="UNLOAD"></asp:LinkButton>
                                                                    <asp:Label ID="Lbl_Unloaded" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:GridView>

                                        <asp:GridView ID="gvwDeliveryWaybills" runat="server" AutoGenerateColumns="false" OnRowCommand="gvwDeliveryWaybills_RowCommand" OnRowDataBound="gvwDeliveryWaybills_RowDataBound" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
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
                                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="waybillItemID" HeaderText="WAYBILL ID" Visible="true">
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
                                                <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO">
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
                                                <asp:TemplateField HeaderText="Reason" ItemStyle-Width="100">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlUndeliveryReason" runat="server">
                                                            <asp:ListItem Value="1" Text="Contact number not working"></asp:ListItem>
                                                            <asp:ListItem Value="2" Text="National Holidays"></asp:ListItem>
                                                            <asp:ListItem Value="3" Text="Local Festival"></asp:ListItem>
                                                            <asp:ListItem Value="4" Text="Documents mis match"></asp:ListItem>
                                                            <asp:ListItem Value="5" Text="Documents mis placed"></asp:ListItem>
                                                            <asp:ListItem Value="6" Text="shortages"></asp:ListItem>
                                                            <asp:ListItem Value="7" Text="Damages"></asp:ListItem>
                                                            <asp:ListItem Value="8" Text="Natural Calamities"></asp:ListItem>
                                                            <asp:ListItem Value="9" Text="Mansoon"></asp:ListItem>
                                                            <asp:ListItem Value="10" Text="Customer refuse"></asp:ListItem>
                                                            <asp:ListItem Value="11" Text="Topay not ready"></asp:ListItem>
                                                            <asp:ListItem Value="12" Text="Cheque not ready"></asp:ListItem>
                                                            <asp:ListItem Value="13" Text="Mathadi Issue"></asp:ListItem>
                                                            <asp:ListItem Value="14" Text="In torn condition"></asp:ListItem>
                                                            <asp:ListItem Value="15" Text="Ewaybill expired"></asp:ListItem>
                                                            <asp:ListItem Value="16" Text="Ewaybill not available"></asp:ListItem>
                                                            <asp:ListItem Value="17" Text="Appointment deliveries"></asp:ListItem>
                                                            <asp:ListItem Value="18" Text="Time bound delivery in Factories"></asp:ListItem>
                                                            <asp:ListItem Value="19" Text="Mall Delivery"></asp:ListItem>
                                                            <asp:ListItem Value="20" Text="Vehicle break down"></asp:ListItem>
                                                            <asp:ListItem Value="21" Text="Vehicle accident"></asp:ListItem>
                                                            <asp:ListItem Value="22" Text="Political Issues"></asp:ListItem>
                                                            <asp:ListItem Value="23" Text="Curfew/Called of Strike/Bandh"></asp:ListItem>
                                                            <asp:ListItem Value="24" Text="Special vehicle required"></asp:ListItem>
                                                            <asp:ListItem Value="25" Text="Non serviceable Location"></asp:ListItem>
                                                            <asp:ListItem Value="26" Text="Consignee Address change"></asp:ListItem>
                                                            <asp:ListItem Value="27" Text="ODA delivery"></asp:ListItem>
                                                            <asp:ListItem Value="28" Text="Consignee address not found"></asp:ListItem>
                                                            <asp:ListItem Value="29" Text="Others-"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="REMARK" ItemStyle-Width="100">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="Txt_Remark" Style="text-transform: uppercase" AutoCompleteType="Disabled" TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="Btn_Unload" runat="server" CommandName="UNLOAD" CommandArgument='<%# Container.DataItemIndex %>' Text="UNLOAD"></asp:LinkButton><%--CommandArgument='<%# Eval("tblWayBillItemId")  OnClick="Btn_Unload_Click"%>'--%>
                                                                    <asp:Label ID="Lbl_Unloaded" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
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
                            <div runat="server" id="UnloadedWaybillItems" visible="false">
                                <div class="panel-heading panelHead">
                                    <b>UNLOADED WAYBILL MATERIAL</b>
                                    <div style="text-align: right; text-wrap: inherit;">
                                        <asp:Label ID="Label5" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL UNLOADED QTY:</asp:Label>
                                        <asp:Label ID="Lbl_TotalUnLoadedQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                        <asp:Label ID="Label6" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL UNLOADED WEIGHT:</asp:Label>
                                        <asp:Label ID="Lbl_TotalUnLoadedWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <asp:GridView ID="GV_ReceivedWaybillItems" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                    <asp:BoundField DataField="materialName" HeaderText="ITEM NAME">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="typeOfPackage" HeaderText="PACKAGE">
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
                                                    <asp:BoundField DataField="Qty" HeaderText="RECEIVED QTY">
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
                                         <div class="form-group">
                                              <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="closeVehicleDiv" visible="true">
                                                <asp:LinkButton ID="CloseVehicle" runat="server" Text="CLOSE VEHICLE" CssClass="btn btn-info largeButtonStyle2 CloseVehicle" OnClick="CloseVehicle_Click" Visible="false">CLOSE VEHICLE&nbsp;</asp:LinkButton><%----%>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="Div2" visible="true">
                                                  <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_PickDelClosingRemark" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                                <asp:TextBox runat="server" ID="Txt_PickDelClosingRemark" Style="text-transform: uppercase" AutoCompleteType="Disabled" TextMode="MultiLine" CssClass="form-control input-sm FirstNoSpaceAndZero"></asp:TextBox>
                                            </div>
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
        <!--================================================Transhipment Detail============================================================================-->
        <div id="Transhipment" runat="server">
            <div>
                <asp:UpdatePanel ID="UpdatePanel_TranshipUnloadingDetail" runat="server">
                    <ContentTemplate>
                        <div class="panel  panelTop">
                            <div class="panel-heading panelHead">
                                <b>TRANSHIPMENT UNLOADING</b>
                                <div style="text-align: right; text-wrap: inherit;">
                                    <asp:Label ID="Label7" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL QTY:</asp:Label>
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
                                                <asp:Label ID="Label1" runat="server" CssClass="label labelColor">SELECT VEHICLE</asp:Label>
                                                 <asp:HiddenField ID="hfTranshipmentVehicle" runat="server" />
                                               <asp:DropDownList ID="ddlTranshipmentVehicle" runat="server" CssClass="formDisplay input-sm ddlTranshipmentVehicle" AutoPostBack="true" OnSelectedIndexChanged="ddlTranshipmentVehicle_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </div>                                          
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                                 <asp:TextBox ID="Txt_SearchWaybillNo" runat="server" onkeypress="return validateNumericValue(event)" MaxLength="7" TabIndex="1" CssClass="form-control input-sm Txt_SearchWaybillNo FirstNoSpaceAndZero" onchange="ReadDataonchange('Txt_SearchWaybillNo', 'hfWaybillID','', 'Loading.aspx/getWayBillNo');"></asp:TextBox>
                                                <asp:HiddenField ID="hfWaybillID" runat="server" />
                                            </div>                                           
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btnGetTranshipmentDetails" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle btnGetDetails" OnClick="btnGetTranshipmentDetails_Click">GET LIST&nbsp;</asp:LinkButton>
                                            </div>
                                             <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">	
                                                 <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:Label ID="lblManifestNo" runat="server"></asp:Label>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="TranshipPrint" visible="false">
                                                <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="btnPrintManifest" runat="server" Text="PRINT LIST" CssClass="btn btn-info largeButtonStyle btnPrintManifest" OnClick="btnPrintManifest_Click">PRINT LIST&nbsp;</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body" id="Div1" runat="server">
                                <div class="form-horizontal" role="form">
                                    <div class="form-group">
                                        <asp:GridView ID="grdTranshipmentWayBills" runat="server" AutoGenerateColumns="false" OnRowCommand="grdTranshipmentWayBills_RowCommand" OnRowDataBound="grdTranshipmentWayBills_RowDataBound" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="WAYBILL NO">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Btn_Waybill" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick='<%#Eval("waybillID","javascript:YourFunction({0});")%>' Text='<%# Eval("wayBillHeader.wayBillNo") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="wayBillHeader.wayBillNo" HeaderText="WAYBILL NO" Visible="true">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="waybillID" HeaderText="WAYBILL ID" Visible="true">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="wayBillHeader.pickupDateTime" HeaderText="WAYBILL DATE">
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                    <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="BranchName" HeaderText="BRANCH">
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
                                                <asp:BoundField DataField="invoiceNo" HeaderText="INVOICE NO">
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
                                                        <asp:TextBox runat="server" ID="Txt_Remark" Style="text-transform: uppercase" AutoCompleteType="Disabled" TabIndex="6" CssClass="form-control input-sm bookletStartNo FirstNoSpaceAndZero"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="Btn_Unload" runat="server" CommandName="UNLOAD" CommandArgument='<%# Container.DataItemIndex %>' Text="UNLOAD"></asp:LinkButton><%--CommandArgument='<%# Eval("tblWayBillItemId")  OnClick="Btn_Unload_Click"%>'--%>
                                                                    <asp:Label ID="Lbl_Unloaded" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                    <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
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
                                                <asp:LinkButton ID="Btn_TranshipReset" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_TranshipReset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="TranshipUnloadedItems" runat="server" visible="false">
                                <div class="panel-heading panelHead">
                                    <b>UNLOADED WAYBILL MATERIAL</b>
                                    <div style="text-align: right; text-wrap: inherit;">
                                        <asp:Label ID="Label9" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL UNLOADED QTY:</asp:Label>
                                        <asp:Label ID="Lbl_TotalTranshipUnLoadedQty" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                        <asp:Label ID="Label10" runat="server" CssClass="label labelColor" Font-Size="Smaller">TOTAL UNLOADED WEIGHT:</asp:Label>
                                        <asp:Label ID="Lbl_TotalTranshipUnLoadedWeight" runat="server" CssClass="label labelColor" Font-Size="Small"></asp:Label>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <asp:GridView ID="GV_TranshipReceivedWaybillItems" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
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
                                                    <asp:BoundField DataField="pickUpBranchName" HeaderText="BRANCH">
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
                                                    <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE NO">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valueActualWt" HeaderText="WEIGHT">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Qty" HeaderText="RECEIVED QTY">
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
                                         <div class="form-group" id="BtnClose" runat="server" visible="false">
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                  <div class="form-control-lg"></div>
                                                <div class="form-control-lg"></div>
                                                <asp:LinkButton ID="Btn_TranshipCloseVehicle" runat="server" Text="CLOSE VEHICLE" CssClass="btn btn-info largeButtonStyle2 Btn_TranshipCloseVehicle" OnClick="Btn_TranshipCloseVehicle_Click">CLOSE VEHICLE&nbsp;</asp:LinkButton><%----%>
                                            </div>
                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                <asp:Label ID="Lbl_TranshipClosingRemark" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                                <asp:TextBox runat="server" ID="Txt_TranshipClosingRemark" Style="text-transform: uppercase" AutoCompleteType="Disabled" TextMode="MultiLine" CssClass="form-control input-sm FirstNoSpaceAndZero"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnGetTranshipmentDetails" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
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
