<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="DEPSNew.aspx.cs" Inherits="DEPSNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function ReadDataonchange(text, textid, ddlID, path) {
            console.log(text);
            console.log(textid);
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
                        console.log($("[id$='" + textid + "']").val());
                        $("[id$=Txt_MaterialType]").val("AUTO");
                        $("[id$=Txt_PackageType]").val("AUTO");
                        $("[id$=hfVehicleRequestID]").val("");
                        $("[id$=hfStatusID]").val("");                        
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });
        }

        function GetWaybillItems(text, ddlID, itemID) {
            console.log(text);
            console.log(ddlID);
            console.log(itemID);
            if (text != "") {
                $.ajax({
                    type: "POST",
                    url: 'DEPSNew.aspx/getWaybillItemID',
                    data: "{ 'waybillID': '" + text + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (response) {
                        console.log($("[id*='" + ddlID + "']"));
                        $("[id*='" + ddlID + "']").empty().append('<option selected="selected" value="0">SELECT</option>');
                        $.each(response.d, function () {
                            if (this['Id'] == itemID) {
                                $("[id*='" + ddlID + "']").append('<option selected="selected" value=' + this['Id'] + '>' + this['SrNo'] + '</option>');
                                $("[id*=hfWaybillItemID]").val(this['Id']);
                            } else {
                                $("[id*='" + ddlID + "']").append($("<option></option>").val(this['Id']).html(this['SrNo']));
                                $("[id*=hfWaybillItemID]").val(this['Id']);
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
        }

        function getMaterialPackage() {
            console.log("getMaterialPack");
            $("[id$=Txt_MaterialType]").val("AUTO");
            $("[id$=Txt_PackageType]").val("AUTO");
            $("[id$=hfVehicleRequestID]").val("");
            $("[id$=hfStatusID]").val("");
            if ($("[id$=Ddl_WaybillItemID]").text() != "SELECT") {
                $.ajax({
                    url: 'DEPSNew.aspx/getMaterialPackageName',
                    data: "{ 'id': '" + $("[id$=Ddl_WaybillItemID]").val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {
                            console.log($("[id$=Ddl_WaybillItemID]").val());
                            $("[id$=Txt_MaterialType]").val(item.split('ʭ')[0]);
                            $("[id$=Txt_PackageType]").val(item.split('ʭ')[1]);
                            $("[id$=hfVehicleRequestID]").val(item.split('ʭ')[2]);
                            console.log(item.split('ʭ')[2]);
                            console.log($("[id$=hfVehicleRequestID]").val());
                            $("[id$=hfStatusID]").val(item.split('ʭ')[3]);
                            console.log(item.split('ʭ')[3]);
                            console.log($("[id$=hfStatusID]").val());
                        });
                    }
                });
            } else {
                $("[id$=Txt_MaterialType]").val("AUTO");
                $("[id$=Txt_PackageType]").val("AUTO");
                $("[id$=hfVehicleRequestID]").val("");
                $("[id$=hfStatusID]").val("");
            }
        }

        function FillWaybillDetails() {

            $.ajax({
                url: 'DEPSNew.aspx/GetWaybillHeaderData',
                data: "{ 'WaybillId': '" + $("[id$=hfWaybillID]").val() + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    var data = response.d;
                    $.each(data, function (index, item) {
                        $("[id*=Txt_WaybillNo]").val(item.split('ʭ')[0]);
                        $("[id*=Ddl_CustomerType]").val(item.split('ʭ')[1]);
                        $("[id*=Ddl_PaymentMode]").val(item.split('ʭ')[2]);
                        if (item.split('ʭ')[1] == 'CORPORATE') {
                            $("[id*=CustomerCodeDiv]").show();
                            $("[id*=Txt_CustCode]").val(item.split('ʭ')[3]);
                        }
                        else {
                            $("[id*=CustomerCodeDiv]").hide();
                        }
                        $("[id*=Txt_CCustName]").val(item.split('ʭ')[4]);
                        $("[id*=Txt_CustMobileNo]").val(item.split('ʭ')[5]);
                        $("[id*=Txt_CustTelephoneNo]").val(item.split('ʭ')[6]);
                        $("[id*=Txt_EmailId]").val(item.split('ʭ')[7]);
                        $("[id*=Txt_CustPin]").val(item.split('ʭ')[8]);
                        $.ajax({
                            type: "POST",
                            url: 'DEPSNew.aspx/getArea',
                            data: "{ 'pincode': '" + item.split('ʭ')[8] + "'}",
                            contentType: "application/json",
                            dataType: "json",
                            success: function (response) {
                                $("[id*=Ddl_CustArea]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                $.each(response.d, function () {
                                    if (this['Area'] == item.split('ʭ')[9]) {
                                        $("[id*=Ddl_CustArea]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                    } else {
                                        $("[id*=Ddl_CustArea]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                    }
                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });
                        $("[id*=Txt_CustAdd]").val(item.split('ʭ')[10]);
                        $("[id*=Txt_PickPin]").val(item.split('ʭ')[11]);
                        $.ajax({
                            type: "POST",
                            url: 'DEPSNew.aspx/getArea',
                            data: "{ 'pincode': '" + item.split('ʭ')[11] + "'}",
                            contentType: "application/json",
                            dataType: "json",
                            success: function (response) {
                                $("[id*=Ddl_PickArea]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                $.each(response.d, function () {
                                    if (this['Area'] == item.split('ʭ')[12]) {
                                        $("[id*=Ddl_PickArea]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                    } else {
                                        $("[id*=Ddl_PickArea]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                    }
                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });
                        $("[id*=Txt_PickAdd]").val(item.split('ʭ')[13]);
                        $("[id*=Txt_ConsigneeName]").val(item.split('ʭ')[14]);
                        $("[id*=Txt_ConsigneeContNo]").val(item.split('ʭ')[15]);
                        $("[id*=Txt_DelPin]").val(item.split('ʭ')[16]);
                        $.ajax({
                            type: "POST",
                            url: 'DEPSNew.aspx/getArea',
                            data: "{ 'pincode': '" + item.split('ʭ')[16] + "'}",
                            contentType: "application/json",
                            dataType: "json",
                            success: function (response) {
                                $("[id*=Ddl_DelArea]").empty().append('<option selected="selected" value="0">SELECT</option>');
                                $.each(response.d, function () {
                                    if (this['Area'] == item.split('ʭ')[17]) {
                                        $("[id*=Ddl_DelArea]").append('<option selected="selected" value=' + this['AreaID'] + '>' + this['Area'] + '</option>');
                                    } else {
                                        $("[id*=Ddl_DelArea]").append($("<option></option>").val(this['AreaID']).html(this['Area']));
                                    }
                                });
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                alert(xhr.status);
                                alert(thrownError);
                            }
                        });
                        $("[id*=Txt_DelAdd]").val(item.split('ʭ')[18]);
                        $("[id*=Txt_PickupBranch]").val(item.split('ʭ')[19]);                      
                        $("[id*=Txt_DeliveryBranch]").val(item.split('ʭ')[20]);
                        $("[id*=Ddl_PickType]").val(item.split('ʭ')[21]);
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });


            $.ajax({
                url: 'DEPSNew.aspx/GetWaybillDetailsData',
                data: "{ 'WaybillId': '" + $("[id$=hfWaybillID]").val() + "'}",
                type: "POST",
                dataType: "json",
                contentType: 'application/json',
                success: function (response) {
                    var data = response.d;
                    var gridView = $("[id*=GV_WaybillDetail]");
                    var row = gridView.find("tr")
                    row.remove();
                    $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO</th><th class='gvHeaderStyle'>MATERIAL TYPE</th><th class='gvHeaderStyle'>PACKAGE TYPE</th><th class='gvHeaderStyle'>UNIT</th><th class='gvHeaderStyle'>LENGTH</th><th class='gvHeaderStyle'>BREADTH</th><th class='gvHeaderStyle'>HEIGHT</th><th class='gvHeaderStyle'>CFT</th><th class='gvHeaderStyle'>ACTUAL WEIGHT</th><th class='gvHeaderStyle'>NO OF PACKAGES</th><th class='gvHeaderStyle'>INVOICE NO</th><th class='gvHeaderStyle'>INVOICE DATE</th><th class='gvHeaderStyle'>INVOICE VALUE</th><th class='gvHeaderStyle'>E-WAYBILL NO</th><th class='gvHeaderStyle'>E-WAYBILL DATE</th><th class='gvHeaderStyle'>E-WAYBILL EXPIRY DATE</th></tr>");
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
                                           "</tr>");
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                }
            });


            $("[id*=Txt_WaybillNo]").attr("disabled", "disabled");
            $("[id*=Ddl_CustomerType]").attr("disabled", "disabled");
            $("[id*=Ddl_PickType]").attr("disabled", "disabled");
            $("[id*=Ddl_PaymentMode]").attr("disabled", "disabled");
            $("[id*=Txt_CustCode]").attr("disabled", "disabled");
            $("[id*=Txt_CCustName]").attr("disabled", "disabled");
            $("[id*=Txt_CustMobileNo]").attr("disabled", "disabled");
            $("[id*=Txt_CustTelephoneNo]").attr("disabled", "disabled");

            $("[id*=Txt_EmailId]").attr("disabled", "disabled");
            $("[id*=Txt_CustPin]").attr("disabled", "disabled");
            $("[id*=Ddl_CustArea]").attr("disabled", "disabled");
            $("[id*=Txt_CustAdd]").attr("disabled", "disabled");

            $("[id*=Txt_PickPin]").attr("disabled", "disabled");
            $("[id*=Ddl_PickArea]").attr("disabled", "disabled");
            $("[id*=Txt_PickAdd]").attr("disabled", "disabled");
            $("[id*=Txt_PickupBranch]").attr("disabled", "disabled");

            $("[id*=Txt_ConsigneeName]").attr("disabled", "disabled");
            $("[id*=Txt_ConsigneeContNo]").attr("disabled", "disabled");
            $("[id*=Txt_DelPin]").attr("disabled", "disabled");
            $("[id*=Ddl_DelArea]").attr("disabled", "disabled");
            $("[id*=Txt_DelAdd]").attr("disabled", "disabled");
            $("[id*=Txt_EWaybillNo]").attr("disabled", "disabled");
            $("[id*=Txt_DeliveryBranch]").attr("disabled", "disabled");

            $("[id*=Txt_EWaybillDate]").attr("disabled", "disabled");
            $("[id*=Txt_EWaybillExpiryDate]").attr("disabled", "disabled");



            $.ajax({
                type: "POST",
                url: 'DEPSNew.aspx/GetWaybillItemID',
                data: "{ 'waybillID': '" + $("[id$=hfWaybillID]").val() + "'}",
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

        }
    </script>

    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_Waybill" AssociatedUpdatePanelID="UpdatePanel_Waybill" runat="server" DisplayAfter="0">
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


    <div id="AlertNotification"></div>

    <div class="panel panelTop">
        <asp:UpdatePanel ID="UpdatePanel_Waybill" runat="server">
            <ContentTemplate>

                <div class="panel-heading panelHead">
                    <b>DEPS</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" style="text-align: right">
                                    <asp:Label ID="lbl_SearchWaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <asp:TextBox ID="Txt_SearchWaybillNo" runat="server" onkeypress="return validateNumericValue(event)" MaxLength="7" CssClass="form-control input-sm Txt_SearchWaybillNo FirstNoSpaceAndZero" onchange="ReadDataonchange('Txt_SearchWaybillNo', 'hfWaybillID','', 'DEPSNew.aspx/getWayBillNo');"></asp:TextBox>
                                    <asp:HiddenField ID="hfWaybillID" runat="server" />
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <asp:LinkButton ID="Btn_SearchWaybill" runat="server" Text="SEARCH" CssClass="btn btn-info largeButtonStyle Btn_SearchWaybill" OnClientClick="return FillWaybillDetails();return false;">SEARCH</asp:LinkButton><%--OnClientClick="FillWaybillDetails()"--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div runat="server" id="WaybillDetailsDiv">
                    <div class="panel-heading panelHead">
                        <b>WAYBILL DETAIL</b>
                    </div>
                    <div class="panel-body labelColor">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <asp:HiddenField ID="GetORReadData" runat="server" Value="GetData" />
                                <div class="row">
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                        <asp:TextBox ID="Txt_WaybillNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_WaybillNo"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustomerType" runat="server" CssClass="label labelColor">CONSIGNOR TYPE</asp:Label>
                                        <asp:DropDownList ID="Ddl_CustomerType" runat="server" CssClass="formDisplay input-sm Ddl_CustomerType">
                                            <asp:ListItem Value="CORPORATE">CORPORATE</asp:ListItem>
                                            <asp:ListItem Value="WALKIN">WALKIN</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_PaymentMode" runat="server" CssClass="label labelColor">PAYMENT MODE</asp:Label>
                                        <asp:DropDownList ID="Ddl_PaymentMode" runat="server" CssClass="formDisplay input-sm Ddl_PaymentMode">
                                            <asp:ListItem Value="CREDIT">CREDIT</asp:ListItem>
                                            <asp:ListItem Value="PAID">PAID</asp:ListItem>
                                            <asp:ListItem Value="TO PAY">TO PAY</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="CustomerCodeDiv">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustCode" runat="server" CssClass="label labelColor">CONSIGNOR CODE</asp:Label>
                                        <asp:TextBox ID="Txt_CustCode" runat="server" CssClass="form-control input-sm Txt_CustCode"></asp:TextBox>

                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label>
                                        <asp:TextBox ID="Txt_CCustName" runat="server" CssClass="form-control input-sm Txt_CCustName"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustMobileNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label>
                                        <asp:TextBox ID="Txt_CustMobileNo" runat="server" CssClass="form-control input-sm Txt_CustMobileNo"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustTelephoneNo" runat="server" CssClass="label labelColor">TELEPHONE NO</asp:Label>
                                        <asp:TextBox ID="Txt_CustTelephoneNo" runat="server" CssClass="form-control input-sm Txt_CustTelephoneNo"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_EmailId" runat="server" CssClass="label labelColor">EMAILID</asp:Label>
                                        <asp:TextBox ID="Txt_EmailId" runat="server" CssClass="form-control input-sm Txt_EmailId"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustPin" runat="server" CssClass="label labelColor">CONSIGNOR PINCODE</asp:Label>
                                        <asp:TextBox ID="Txt_CustPin" runat="server" CssClass="form-control input-sm Txt_CustPin"></asp:TextBox>
                                    </div>

                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustArea" runat="server" CssClass="label labelColor">CONSIGNOR AREA</asp:Label>
                                        <asp:DropDownList ID="Ddl_CustArea" runat="server" CssClass="formDisplay input-sm Ddl_CustArea">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustAdd" runat="server" CssClass="label labelColor">CONSIGNOR ADDRESS</asp:Label>
                                        <asp:TextBox ID="Txt_CustAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustAdd" TextMode="MultiLine"></asp:TextBox>
                                    </div>

                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <asp:Label ID="Lbl_PickPin" runat="server" CssClass="label labelColor">PICKUP PINCODE</asp:Label>
                                        <asp:TextBox ID="Txt_PickPin" runat="server" CssClass="form-control input-sm Txt_PickPin"></asp:TextBox>
                                    </div>

                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_PickArea" runat="server" CssClass="label labelColor">PICKUP AREA</asp:Label>
                                        <asp:DropDownList ID="Ddl_PickArea" runat="server" CssClass="formDisplay input-sm Ddl_PickArea">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_PickAdd" runat="server" CssClass="label labelColor">PICKUP ADDRESS</asp:Label>
                                        <asp:TextBox ID="Txt_PickAdd" runat="server" CssClass="form-control input-sm Txt_PickAdd" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_PickupBranch" runat="server" CssClass="label labelColor">PICKUP BRANCH</asp:Label>
                                        <asp:TextBox ID="Txt_PickupBranch" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_ConsigneeName" runat="server" CssClass="label labelColor">CONSIGNEE NAME</asp:Label>
                                        <asp:TextBox ID="Txt_ConsigneeName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_ConsigneeName"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_ConsigneeContNo" runat="server" CssClass="label labelColor">CONSIGNEE CONTACT NO</asp:Label>
                                        <asp:TextBox ID="Txt_ConsigneeContNo" runat="server" CssClass="form-control input-sm Txt_ConsigneeContNo"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_DelPin" runat="server" CssClass="label labelColor">CONSIGNEE PINCODE</asp:Label>
                                        <asp:TextBox ID="Txt_DelPin" runat="server" CssClass="form-control input-sm Txt_DelPin"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_DelArea" runat="server" CssClass="label labelColor">CONSIGNEE AREA</asp:Label>
                                        <asp:DropDownList ID="Ddl_DelArea" runat="server" CssClass="formDisplay input-sm Ddl_DelArea">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_DelAdd" runat="server" CssClass="label labelColor">CONSIGNEE ADDRESS</asp:Label>
                                        <asp:TextBox ID="Txt_DelAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_DelAdd" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_DeliveryBranch" runat="server" CssClass="label labelColor">DELIVERY BRANCH</asp:Label>
                                        <asp:TextBox ID="Txt_DeliveryBranch" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm"></asp:TextBox>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="panel-heading panelHead">
                        <b>MATERIAL DETAIL</b>
                    </div>
                    <div class="panel-body labelColor">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <asp:GridView ID="GV_WaybillDetail" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                    <Columns>

                                        <asp:TemplateField HeaderText="SR.NO">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MaterialID" HeaderText="MATERIAL ID" Visible="true">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="MaterialType" HeaderText="MATERIAL TYPE">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PackageID" HeaderText="PACKAGE ID" Visible="true">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PackageType" HeaderText="PACKAGE TYPE">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Unit" HeaderText="UNIT">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Length" HeaderText="LENGTH">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Breadth" HeaderText="BREADTH">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Height" HeaderText="HEIGHT">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CFT" HeaderText="CFT">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ActWeight" HeaderText="ACTUAL WEIGHT">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ChargeWeight" HeaderText="CHARGE WEIGHT">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NoOfPackage" HeaderText="NO OF PACKAGES">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NoOfInnerPackage" HeaderText="NO OF INNER PACKAGES">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE NO">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceDate" HeaderText="INVOICE DATE">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceValue" HeaderText="INVOICE VALUE">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EWaybillNo" HeaderText="E-WAYBILL<br>NO" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EWaybillDate" HeaderText="EWAYBILL<br>DATE" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EWaybillExpiryDate" HeaderText="E-WAYBILL<br>EXPIRY DATE" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_WaybillItemID" runat="server" CssClass="label labelColor">SR.NO</asp:Label><span class="required">*</span>
                            <asp:DropDownList ID="Ddl_WaybillItemID" runat="server" CssClass="formDisplay Ddl_WaybillItemID" onchange="getMaterialPackage()">
                            </asp:DropDownList>
                            <asp:HiddenField ID="hfWaybillItemID" runat="server" />
                        </div>
                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_MaterialType" runat="server" CssClass="label labelColor">MATERIAL TYPE</asp:Label>
                            <asp:TextBox ID="Txt_MaterialType" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_MaterialType" Text="AUTO" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label>
                            <asp:TextBox ID="Txt_PackageType" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PackageType" Text="AUTO" ReadOnly="true"></asp:TextBox>
                        </div>

                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_Unit" runat="server" CssClass="label labelColor">DEPS TYPE</asp:Label><span class="required">*</span>
                            <asp:DropDownList ID="Ddl_DepsType" runat="server" CssClass="formDisplay Ddl_DepsType">
                                <asp:ListItem>SELECT</asp:ListItem>
                                <asp:ListItem>DAMAGE</asp:ListItem>
                                <asp:ListItem>EXCESS</asp:ListItem>
                                <asp:ListItem>PILFERAGE</asp:ListItem>
                                <asp:ListItem>SHORTAGE</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_DepsQty" runat="server" CssClass="label labelColor">QTY</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="Txt_DepsQty" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_DepsQty FirstNoSpaceAndZero"></asp:TextBox>
                            <asp:HiddenField ID="hfVehicleRequestID" runat="server" />
                            <asp:HiddenField ID="hfStatusID" runat="server" />
                        </div>
                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label><span class="required">*</span>
                            <asp:TextBox ID="Txt_Remark" runat="server" Style="text-transform: uppercase;" TextMode="MultiLine" CssClass="form-control input-sm Txt_Remark FirstNoSpaceAndZero"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                            <div class="form-control-sm"></div>
                            <asp:HiddenField ID="hfDEPSSubmit" runat="server" ClientIDMode="Static" Value="0" />
                            <asp:LinkButton ID="Button_DEPSSubmit" runat="server" CssClass="btn btn-info Button_DEPSSubmit largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateDEPSDetails()) {return false;};">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton><%-- OnClick="Button_DEPSSubmit_Click1" --%>
                        </div>
                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="Btn_Reset" runat="server" OnClientClick="Btn_Reset()" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
            <Triggers>
                
            </Triggers>
        </asp:UpdatePanel>
    </div>


    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->

    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Val_PickUpRequest.js"></script>
</asp:Content>

