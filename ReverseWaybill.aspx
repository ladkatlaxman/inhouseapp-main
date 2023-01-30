<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ReverseWaybill.aspx.cs" Inherits="ReverseWaybill" %>
<%@ Register Src="~/WaybillEntry.ascx" TagName="WaybillEntry" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function changeConsigneeOnChangeEvent() {
            console.log("ReverseEventStart");
            $("[id*=Txt_ConsigneeName").attr('onchange', undefined).change(function () {
                ReadDataonchange('Txt_ConsigneeName', 'hfConsigneeID', 'Ddl_DelArea', 'ReverseWaybill.aspx/getConsigneeNameReverse');
                console.log("ReverseEventEnd");
            });
        }

        function CheckAvailability() {
            $("[id*=Lbl_ErrorMsg").text("");
            var WaybillNo = $("[id*=Txt_WaybillNo").val();
            $.ajax({
                type: "POST",
                url: 'PickReqWareHouse.aspx/CheckWaybillNo',
                data: '{waybillNo: "' + WaybillNo + '" }',
                contentType: 'application/json',
                dataType: "json",
                success: function (response) {
                    var data = response.d;
                    $.each(data, function (index, item) {
                        if (item.split('ʭ')[0] != 'AVAILABLE') {
                            $("[id*=Lbl_ErrorMsg").text(item.split('ʭ')[0]);
                        }
                    });
                }
            });
        }
       
            function getReverse() 
           {
                $("[id*=WaybillDetailsDiv]").hide();
                $("[id*=Txt_SearchWaybillNo]").val("");
                $("[id*=hfWaybillID]").val("");
                if ($("[id*=Ddl_Reverse]").val() == 'SELECT') {
                    $("[id*=divWaybill]").hide();
                }
                else if ($("[id*=Ddl_Reverse]").val() == 'WAYBILL NO') {                   
                    $("[id*=divWaybill]").show();                  
                }
                else if ($("[id*=Ddl_Reverse]").val() == 'CUSTOMER') {
                    $("[id*=divWaybill]").hide(); 
                }            
            }
            function FillWaybillDetails(waybillNo) {
                $("[id*=WaybillDetailsDiv]").show();
                console.log("FillReverseWaybillNo");
                console.log(waybillNo);
                $.ajax({
                    url: 'PickReqWareHouse.aspx/GetWaybillHeaderDataForEdit',
                    data: "{ 'WaybillNo': '" + waybillNo + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {
                            console.log(item.split('ʭ')[1]);
                            $("[id*=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val("WALKIN");
                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PaymentMode").ClientID%>]").val(item.split('ʭ')[2]);
                            if ($("[id*=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").val() == 'CORPORATE') {
                                $("[id*=<%=WaybillEntry.FindControl("divCalculate").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("CorporateCustomerDiv").ClientID%>]").show();                              
                                $("[id*=<%=WaybillEntry.FindControl("hfCustID").ClientID%>]").val(item.split('ʭ')[25]);//custId,
                                console.log("walkinCustID" + item.split('ʭ')[25]);
                                $("[id*=<%=WaybillEntry.FindControl("Txt_CCustName").ClientID%>]").val(item.split('ʭ')[14]);
                            }
                            else {                              
                                $("[id*=<%=WaybillEntry.FindControl("CorporateCustomerDiv").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("divCalculate").ClientID%>]").hide();
                                $("[id*=<%=WaybillEntry.FindControl("WalkinCustomerDiv").ClientID%>]").show();
                                $("[id*=<%=WaybillEntry.FindControl("hfWCustID").ClientID%>]").val(item.split('ʭ')[25]);//WcustId,
                                console.log("walkinCustID"+item.split('ʭ')[25]);
                                $("[id*=<%=WaybillEntry.FindControl("Txt_WCustName").ClientID%>]").val(item.split('ʭ')[14]);
                            }                           
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustMobileNo").ClientID%>]").val(item.split('ʭ')[15]);                         
                            $("[id*=<%=WaybillEntry.FindControl("Email").ClientID%>]").hide();
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustPin").ClientID%>]").val(item.split('ʭ')[16]);
                            $.ajax({
                                type: "POST",
                                url: 'PickReqWareHouse.aspx/getArea',
                                data: "{ 'pincode': '" + item.split('ʭ')[16] + "'}",
                                contentType: "application/json",
                                dataType: "json",
                                success: function (response) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").empty().append('<option value="0">SELECT</option>');
                                    $.each(response.d, function () {
                                        if (this['Area'] == item.split('ʭ')[17]) {
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
                            $("[id*=<%=WaybillEntry.FindControl("Txt_CustAdd").ClientID%>]").val(item.split('ʭ')[18]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_PickPin").ClientID%>]").val(item.split('ʭ')[16]);
                            $.ajax({
                                type: "POST",
                                url: 'PickReqWareHouse.aspx/getArea',
                                data: "{ 'pincode': '" + item.split('ʭ')[16] + "'}",
                                contentType: "application/json",
                                dataType: "json",
                                success: function (response) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").empty().append('<option value="0">SELECT</option>');
                                    $.each(response.d, function () {
                                        if (this['Area'] == item.split('ʭ')[17]) {
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
                            $("[id*=<%=WaybillEntry.FindControl("Txt_PickAdd").ClientID%>]").val(item.split('ʭ')[18]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeName").ClientID%>]").val(item.split('ʭ')[4]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeContNo").ClientID%>]").val(item.split('ʭ')[5]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_DelPin").ClientID%>]").val(item.split('ʭ')[11]);
                            $.ajax({
                                type: "POST",
                                url: 'PickReqWareHouse.aspx/getArea',
                                data: "{ 'pincode': '" + item.split('ʭ')[11] + "'}",
                                contentType: "application/json",
                                dataType: "json",
                                success: function (response) {
                                    $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").empty().append('<option value="0">SELECT</option>');
                                    $.each(response.d, function () {
                                        if (this['Area'] == item.split('ʭ')[12]) {
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
                            $("[id*=<%=WaybillEntry.FindControl("Txt_DelAdd").ClientID%>]").val(item.split('ʭ')[13]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_PickupBranch").ClientID%>]").val(item.split('ʭ')[20]);
                            $("[id*=<%=WaybillEntry.FindControl("Txt_DeliveryBranch").ClientID%>]").val(item.split('ʭ')[19]);
                            $("[id*=<%=WaybillEntry.FindControl("Ddl_PickType").ClientID%>]").val(item.split('ʭ')[21]);
                            $("[id*=<%=WaybillEntry.FindControl("hfCustPinID").ClientID%>]").val(item.split('ʭ')[26]);
                            $("[id*=<%=WaybillEntry.FindControl("hfPickPinID").ClientID%>]").val(item.split('ʭ')[26]);             
                            $("[id*=<%=WaybillEntry.FindControl("hfConsigneeID").ClientID%>]").val(item.split('ʭ')[22]);
                            $("[id*=<%=WaybillEntry.FindControl("hfDelPinID").ClientID%>]").val(item.split('ʭ')[24]);             
                            $("[id*=<%=WaybillEntry.FindControl("hfPickupBranch").ClientID%>]").val(item.split('ʭ')[28]);                          
                            $("[id*=<%=WaybillEntry.FindControl("hfCFTValue").ClientID%>]").val(item.split('ʭ')[29]);
                            $("[id*=<%=WaybillEntry.FindControl("hfDeliveryBranch").ClientID%>]").val(item.split('ʭ')[27]);
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });              
                $("[id*=<%=WaybillEntry.FindControl("PrevWayBill").ClientID%>]").hide();      
                $("[id*=<%=WaybillEntry.FindControl("hl_consignor").ClientID%>]").hide();      
                $("[id*=<%=WaybillEntry.FindControl("hl_walkinConsignor").ClientID%>]").hide();      
                $("[id*=<%=WaybillEntry.FindControl("hl_consignee").ClientID%>]").hide();      
                $("[id*=<%=WaybillEntry.FindControl("Ddl_PickType").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Ddl_CustomerType").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_CCustName").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_CustMobileNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_CustPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Ddl_CustArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_CustAdd").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("SameAdd").ClientID%>]").hide();
                $("[id*=<%=WaybillEntry.FindControl("SameAsText").ClientID%>]").hide();
                $("[id*=<%=WaybillEntry.FindControl("Txt_PickPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Ddl_PickArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_PickAdd").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeName").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Img_ConsigneeName").ClientID%>]").hide();
                $("[id*=<%=WaybillEntry.FindControl("Txt_ConsigneeContNo").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_DelPin").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Ddl_DelArea").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=WaybillEntry.FindControl("Txt_DelAdd").ClientID%>]").attr("disabled", "disabled");
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
                    <b>REVERSE WAYBILL</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <asp:HiddenField ID="GetORReadData" runat="server" Value="GetData" />
                            <asp:HiddenField ID="hfReverseConsigneeID" runat="server"/>
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">                                 
                                    <asp:Label ID="Lbl_Reverse" runat="server" CssClass="label labelColor">REVERSE</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_Reverse" runat="server" CssClass="formDisplay input-sm Ddl_Reverse" TabIndex="1" onclick="getReverse();">
                                        <asp:ListItem Value="SELECT">SELECT</asp:ListItem>
                                        <asp:ListItem Value="WAYBILL NO">WAYBILL NO</asp:ListItem>
                                        <asp:ListItem Value="CUSTOMER">CUSTOMER</asp:ListItem> 
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="divWaybill" runat="server">
                                    <asp:Label ID="lbl_SearchWaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                                    <asp:TextBox ID="Txt_SearchWaybillNo" runat="server" onkeypress="return validateNumericValue(event)" MaxLength="7" CssClass="form-control input-sm Txt_SearchWaybillNo FirstNoSpaceAndZero" onchange="ReadDataonchange('Txt_SearchWaybillNo', 'hfWaybillID','', 'ReverseWaybill.aspx/getWayBillNo');"></asp:TextBox>
                                    <asp:HiddenField ID="hfWaybillID" runat="server" />
                                </div>                               
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                     <div class="form-control-sm"></div>
                                     <div class="form-control-sm"></div>
                                     <div class="form-control-lg"></div>
                                    <asp:LinkButton ID="Btn_SearchWaybill" runat="server" Text="CREATE REV. WAYBILL" CssClass="btn btn-info largeButtonStyle2 Btn_SearchWaybill" OnClientClick="return false;">CREATE REV. WAYBILL</asp:LinkButton><%--OnClientClick="FillWaybillDetails()"--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
             <Triggers>
             </Triggers>
        </asp:UpdatePanel>

        <div runat="server" id="WaybillDetailsDiv">
            <uc:WaybillEntry ID="WaybillEntry" runat="server" />
        </div>   
    </div>
      <!--=======================================================popup modal of Consignor========================================================================================-->
    <!-- Modal -->
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
                                            <asp:TextBox ID="Txt_PopupConsignorPincode" runat="server" MaxLength="6" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorPincode" onchange="ReadDataonchange('Txt_PopupConsignorPincode','hfPopupConsignorPincode','Ddl_PopupConsignorArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
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
                                        <%--UseSubmitBehavior="false" OnClientClick="if (!validatePickupRequestConsignorDetails()) {return false;};"--%>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_PopupConsignorClose" runat="server" CssClass="btn btn-info largeButtonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <%--                            <asp:PostBackTrigger ControlID="Btn_PopupConsignorSubmit"/>--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=================================================== End Consignor Popup Modal===============================================================-->
    <!--=========================================================================Popup Material================================================================================-->
     <div class="modal" id="MaterialModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW ITEM</h4>
                    <asp:Label ID="Lbl_InWaybillNo" runat="server" ></asp:Label>
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
                                            <asp:Label ID="Lbl_InvoiceNo" runat="server" CssClass="label labelColor">INVOICE NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceNo" TabIndex="21" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InvoiceNo"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceDate" runat="server" CssClass="label labelColor">INVOICE DATE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceDate" TabIndex="22" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_InvoiceDate"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_InvoiceValue" runat="server" CssClass="label labelColor">INVOICE VALUE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_InvoiceValue" TabIndex="23" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_InvoiceValue FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_EWaybillNo" runat="server" CssClass="label labelColor">E-WAYBILL NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_EWaybillNo" runat="server" Style="text-transform: uppercase;" TabIndex="24" AutoCompleteType="Disabled" onkeypress="return checkAlphaNumeric()" CssClass="form-control input-sm Txt_EWaybillNo"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_EWaybillDate" runat="server" CssClass="label labelColor">E-WAYBILL DATE</asp:Label>
                                            <asp:TextBox ID="Txt_EWaybillDate" runat="server" Style="text-transform: uppercase;" TabIndex="25" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_EWaybillDate"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_EWaybillExpiryDate" runat="server" CssClass="label labelColor">E-WAYBILL EXPIRY DATE</asp:Label>
                                            <asp:TextBox ID="Txt_EWaybillExpiryDate" runat="server" AutoCompleteType="Disabled" TabIndex="26" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_EWaybillExpiryDate"></asp:TextBox>
                                        </div>
                                    </div>
                                    <hr />
                                    <div class="row">
                                        <asp:HiddenField ID="AutoIncementNo" runat="server" />
                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_MaterialType" runat="server" CssClass="label labelColor">MATERIAL TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Material" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Material" Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_MaterialType" runat="server" Style="text-transform: uppercase;" TabIndex="27" CssClass="form-control input-sm Txt_MaterialType" onchange="ReadDataonchange('Txt_MaterialType', 'hfMaterialID','', 'PickReqCRMBranch.aspx/getMaterial');"></asp:TextBox>
                                            <asp:HiddenField ID="hfMaterialID" runat="server" />
                                        </div>

                                        <div class="col-sm-4 col-md-4 col-lg-4 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label><span class="required">*</span>
                                            <asp:HyperLink ID="hl_Package" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Package" Target="_blank">List</asp:HyperLink>
                                            <asp:TextBox ID="Txt_PackageType" runat="server" Style="text-transform: uppercase;" TabIndex="28" CssClass="form-control input-sm Txt_PackageType" onchange="ReadDataonchange('Txt_PackageType', 'hfPackageID','', 'PickReqCRMBranch.aspx/getPackages');"></asp:TextBox>
                                            <asp:HiddenField ID="hfPackageID" runat="server" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Unit" runat="server" CssClass="label labelColor">UNIT</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_Unit" runat="server" TabIndex="29" CssClass="formDisplay Ddl_Unit CFT">
                                                <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                                <asp:ListItem>SELECT</asp:ListItem>
                                                <asp:ListItem>CM</asp:ListItem>
                                                <asp:ListItem Selected="True">INCH</asp:ListItem>
                                                <asp:ListItem>KG</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Length" runat="server" CssClass="label labelColor">LENGTH</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Length" runat="server" TabIndex="30" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Length FirstNoSpaceAndZero CFT"></asp:TextBox>
                                            <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Breadth" runat="server" CssClass="label labelColor">BREADTH</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Breadth" runat="server" TabIndex="31" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Breadth FirstNoSpaceAndZero CFT"></asp:TextBox><%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Height" runat="server" CssClass="label labelColor">HEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Height" runat="server" TabIndex="32" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Height FirstNoSpaceAndZero CFT"></asp:TextBox>
                                            <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
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
                                            <asp:TextBox ID="Txt_NoOfPackage" TabIndex="33" runat="server" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfPackage FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_NoOfInnerPakage" runat="server" CssClass="label labelColor">INNER QTY</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_NoOfInnerPakage" TabIndex="34" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfInnerPakage FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ActWeight" runat="server" CssClass="label labelColor">ACTUAL WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ActWeight" TabIndex="35" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_ActWeight FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                        <div class=" col-sm-3 col-md-3 col-lg-3 col-xl-3">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ChargeWeight" runat="server" CssClass="label labelColor">CHARGE WEIGHT</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_ChargeWeight" TabIndex="36" runat="server" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_ChargeWeight FirstNoSpaceAndZero"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-control-sm"></div>
                                        <div class="form-control-sm"></div>
                                        <span style="color: deepskyblue">Enter 'NA' if E-Waybill No is Not Applicable.</span>
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
                                            <asp:LinkButton ID="Btn_AddWaybillItem" AccessKey="+" runat="server" TabIndex="37" CssClass="btn btn-info buttonStyle2" UseSubmitBehavior="false" OnClientClick="if (!validateWareHouseWaybillMaterialDetails()) {return false;};">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_Close" AccessKey="c" runat="server" TabIndex="38" CssClass="btn btn-info buttonStyle2" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <%--<asp:PostBackTrigger ControlID="Btn_consigneeSubmit" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="FJS_File/ReverseWaybill.js"></script>
    <script src="Validation/Val_PickUpRequest.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

