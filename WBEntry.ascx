<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WBEntry.ascx.cs" Inherits="WBEntry" %>
<script>
    
    function SameInvoice() {
        $("[id*=Txt_InvoiceNo]").val($("[id*=hfInvoiceNo]").val());
        $("[id*=Txt_InvoiceDate]").val($("[id*=hfInvoiceDate]").val());
        $("[id*=Txt_InvoiceValue]").val($("[id*=hfInvoiceValue]").val());

        $("[id*=Txt_EWaybillNo]").val($("[id*=hfEwaybillNo]").val());
        $("[id*=Txt_EWaybillDate]").val($("[id*=hfEwaybillDate]").val());
        $("[id*=Txt_EWaybillExpiryDate]").val($("[id*=hfEwaybillExpiryDate]").val());

        $("[id*= Txt_InvoiceNo]").attr("disabled", "disabled");
        $("[id*= Txt_InvoiceDate]").attr("disabled", "disabled");
        $("[id*= Txt_InvoiceValue]").attr("disabled", "disabled");
        $("[id*= Txt_EWaybillNo]").attr("disabled", "disabled");
        $("[id*= Txt_EWaybillDate]").attr("disabled", "disabled");
        $("[id*= Txt_EWaybillExpiryDate]").attr("disabled", "disabled");
        $("[id*=Lbl_InWaybillNo]").text("WAYBILL NO-" + $("[id*=Txt_WaybillNo]").val());
        return true;
    }
    function NewInvoice(which) {
        if(!$("[id*=" + which + "]").is(":visible")) return false;

        $("[id*=Txt_InvoiceNo]").val("");
        $("[id*=Txt_InvoiceValue]").val("");

        $("[id*=Txt_EWaybillNo]").val("NA");
        $("[id*=Txt_EWaybillDate]").val("");
        $("[id*=Txt_EWaybillExpiryDate]").val("");

        $("[id$=Txt_InvoiceNo]").removeAttr("disabled");
        $("[id$=Txt_InvoiceDate]").removeAttr("disabled");
        $("[id$=Txt_InvoiceValue]").removeAttr("disabled");
        $("[id*=Lbl_InWaybillNo]").text("WAYBILL NO-" + $("[id*=Txt_WaybillNo]").val());
        $("[id*=Txt_InvoiceDate]").datepicker({ dateFormat: 'dd/mm/yy', maxDate: 0 }).datepicker("setDate", new Date());
        $("[id*=Txt_EWaybillDate]").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker();
        $("[id*=Txt_EWaybillExpiryDate]").datepicker({ dateFormat: 'dd/mm/yy' }).datepicker();
        //alert(which.toString().indexOf("Btn_AddNewInvoice")); 
        if (which.toString().indexOf("Btn_AddNewInvoice") > 0)
        {
            //$("[id$=Txt_InvoiceNo]").focus();
            $('.Txt_InvoiceNo').focus();
        }

        return true;
    }

    function Btn_Reset() {
        // For clear Query String value from url
        var uri = window.location.toString();
        if (uri.indexOf("?") > 0) {
            var clean_uri = uri.substring(0, uri.indexOf("?"));
            window.history.replaceState({}, document.title, clean_uri);
        }
        location.reload(true);  // for reload page after submition
    }
</script>

<!---Update Progress 1 ---->
<asp:UpdateProgress ID="UpdateProgress_Waybill_Manifest" AssociatedUpdatePanelID="UpdatePanel_Waybill_Manifest" runat="server" DisplayAfter="0">
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

<asp:UpdatePanel ID="UpdatePanel_Waybill_Manifest" runat="server">
    <ContentTemplate>
        <div class="panel panelTop">
            <div class="panel-heading panelHead">
                <b>WAYBILL DETAIL</b>
            </div>
            <div class="panel-body labelColor">
                <div class="form-horizontal" role="form">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="row">
                                    <div class="col-sm-11 col-md-11 col-lg-10">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label><span class="required">*</span>
                                        <asp:TextBox ID="Txt_WaybillNo" runat="server" Style="text-transform: uppercase;" MaxLength="7" AutoCompleteType="Disabled" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_WaybillNo" onchange="CheckAvailability()"></asp:TextBox>
                                        <asp:Label ID="Lbl_ErrorMsg" runat="server" ForeColor="Red" CssClass="label labelColor"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-6 col-xl-2" id="currentWaybills" runat="server" visible="false">
                                <asp:Label ID="Lbl_CurrentWaybillNo" runat="server" CssClass="label labelColor">CURRENT WAYBILL NOS:</asp:Label>
                                <asp:Label ID="lblCurrentWBNo" runat="server" CssClass="label labelColor"></asp:Label>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-4 col-xl-2" id="PrevWayBill" runat="server"> 
                                <asp:Label ID="lblPrevWayBIllLabel" runat="server" CssClass="label labelColor">PREV WAY BILL:</asp:Label> 
                                <div class="form-control-sm"></div>&nbsp;&nbsp;
                                <asp:LinkButton ID="btnView" runat="server" data-toggle="modal" data-target="#modalForViewData" OnClientClick="javascript:return YourFunction1();" ToolTip="View Data">VIEW</asp:LinkButton> 
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:HyperLink ID="lnkPrevWayBill" ImageUrl="~/images/267px-PDF_file_icon.svg.png" runat="server" ImageHeight="30px" Target="_blank" ImageWidth="25px" AccessKey="p"></asp:HyperLink>&nbsp;&nbsp;alt+p
                                <!--<asp:LinkButton ID="btnAutoNo" runat="server" CssClass="btn btn-info btnAutoNo largeButtonStyle" ToolTip="Auto No" Text="Auto" OnClientClick="GetNoDocketWayBillNo(); return false;">Auto</asp:LinkButton> --> 
                                <asp:HiddenField ID="hfWaybillID" runat="server" />
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_WaybillDate" runat="server" CssClass="label labelColor">WAYBILL DATE</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_WaybillDate" runat="server" Style="text-transform: uppercase;" ReadOnly=true AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_WaybillDate"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PickupType" runat="server" CssClass="label labelColor">PICKUP TYPE</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_PickType" runat="server" CssClass="formDisplay input-sm Ddl_PickType">
                                    <asp:ListItem Value="GODOWN">GODOWN</asp:ListItem>
                                    <asp:ListItem Value="LOCAL">LOCAL</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustomerType" runat="server" CssClass="label labelColor">CONSIGNOR TYPE</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_CustomerType" runat="server" CssClass="formDisplay input-sm Ddl_CustomerType" onchange="cleardata();getCustomerType();">
                                    <asp:ListItem Value="CORPORATE">CORPORATE</asp:ListItem>
                                    <asp:ListItem Value="WALKIN">WALKIN</asp:ListItem>
                                    <asp:ListItem Value="REVERSE">REVERSE</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PaymentMode" runat="server" CssClass="label labelColor">PAYMENT MODE</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_PaymentMode" runat="server" CssClass="formDisplay input-sm Ddl_PaymentMode" onclick="getPaymentType();">
                                    <asp:ListItem Value="CREDIT">CREDIT</asp:ListItem>
                                    <asp:ListItem Value="FREE">FREE</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="CustomerCodeDiv">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustCode" runat="server" CssClass="label labelColor">CONSIGNOR CODE</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_CustCode" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_CustCode" onchange="ReadDataonchange('Txt_CustCode','hfCustID','Ddl_CustArea','WBEntry.aspx/getCustomerCode');"></asp:TextBox>
                                <asp:HiddenField ID="hfCustID" runat="server" />
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="CorporateCustomerDiv">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignor" runat="server" TabIndex="1002" NavigateUrl="~/ReportDataOne.aspx?value=Customers" Target="_blank">List</asp:HyperLink>
                                <asp:TextBox ID="Txt_CCustName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_CCustName" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_CCustName','hfCustID','Ddl_CustArea','PickReqCRMBranch.aspx/getCustName');"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="WalkinCustomerDiv">
                                <div class="row">
                                    <div class="col-sm-11 col-md-11 col-lg-10">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_CustName" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_walkinConsignor" runat="server" NavigateUrl="~/ReportDataOne.aspx?value=Consignors" Target="_blank">List</asp:HyperLink>
                                        <asp:TextBox ID="Txt_WCustName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" onkeypress="return checkNumAlpha()" CssClass="form-control input-sm Txt_WCustName" onchange="ReadDataonchange('Txt_WCustName','hfWCustID','Ddl_CustArea','PickReqCRMBranch.aspx/getWalkinCustName');"></asp:TextBox>
                                        <asp:HiddenField ID="hfWCustID" runat="server" />
                                    </div>
                                    <div class="col-sm-0.5 col-md-0.5 ">
                                        <div class="form-control-static"></div>
                                        <asp:ImageButton ID="Img_WCustName" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#ConsignorModal" ImageUrl="~/images//add.png" ToolTip="New Consignor" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustMobileNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_CustMobileNo" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" MaxLength="10" CssClass="form-control input-sm Txt_CustMobileNo FirstNoSpaceAndZero"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="TelephoneNo">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustTelephoneNo" runat="server" CssClass="label labelColor">TELEPHONE NO</asp:Label>
                                <asp:TextBox ID="Txt_CustTelephoneNo" runat="server" Style="text-transform: uppercase;" onkeypress="return checkNumericWithSpace()" MaxLength="13" CssClass="form-control input-sm Txt_CustTelephoneNo"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="Email">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_EmailId" runat="server" CssClass="label labelColor">EMAILID</asp:Label>
                                <asp:TextBox ID="Txt_EmailId" runat="server" CssClass="form-control input-sm Txt_EmailId"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustPin" runat="server" CssClass="label labelColor">CONSIGNOR PINCODE</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_CustPin" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustPin" ReadOnly="true" onchange="ReadDataonchange('Txt_CustPin','hfCustPinID','Ddl_CustArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                <asp:HiddenField ID="hfCustPinID" runat="server" />
                            </div>

                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustArea" runat="server" CssClass="label labelColor">CONSIGNOR AREA</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_CustArea" runat="server" CssClass="formDisplay input-sm Ddl_CustArea" Enabled="false">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_CustAdd" runat="server" CssClass="label labelColor">CONSIGNOR ADDRESS</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_CustAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustAdd" ReadOnly="true" TextMode="MultiLine"></asp:TextBox>
                            </div>

                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <asp:HiddenField runat="server" ID="HiddenField_SameAdd" Value="" />
                                <asp:CheckBox ID="SameAdd" runat="server" onclick="fillPickupDetails('hfPickPinID')" /><span id="SameAsText" runat="server" class="labelColor">Same as Consignor Address</span><br />
                                <asp:Label ID="Lbl_PickPin" runat="server" CssClass="label labelColor">PICKUP PINCODE</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_PickPin" runat="server" Style="text-transform: uppercase;" MaxLength="11" CssClass="form-control input-sm Txt_PickPin" onchange="ReadDataonchange('Txt_PickPin','hfPickPinID','Ddl_PickArea','WBEntry.aspx/getConsignorPincode');"></asp:TextBox>
                                <asp:HiddenField ID="hfPickPinID" runat="server" />
                            </div>

                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PickArea" runat="server" CssClass="label labelColor">PICKUP AREA</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_PickArea" runat="server" CssClass="formDisplay input-sm Ddl_PickArea" >
                                    <asp:ListItem>SELECT</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PickAdd" runat="server" CssClass="label labelColor">PICKUP ADDRESS</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_PickAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PickAdd" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_PickupBranch" runat="server" CssClass="label labelColor">PICKUP BRANCH</asp:Label>
                                <asp:TextBox ID="Txt_PickupBranch" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hfPickupBranch" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="row">
                                    <div class="col-sm-11 col-md-11 col-lg-10">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_ConsigneeName" runat="server" CssClass="label labelColor">CONSIGNEE NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignee" runat="server" TabIndex="1004" NavigateUrl="~/ReportDataOne.aspx?value=Consignee" Target="_blank">List</asp:HyperLink>
                                        <asp:TextBox ID="Txt_ConsigneeName" runat="server" Style="text-transform: uppercase;" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_ConsigneeName" onchange="ReadDataonchange('Txt_ConsigneeName','hfConsigneeID','Ddl_DelArea','WBEntry.aspx/getConsigneeName');"></asp:TextBox>
                                        <asp:HiddenField ID="hfConsigneeID" runat="server" />
                                    </div>

                                    <div class="col-sm-0.5 col-md-0.5 ">
                                        <div class="form-control-static"></div>
                                        <asp:ImageButton ID="Img_ConsigneeName" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#ConsigneeModal" ImageUrl="~/images//add.png" ToolTip="New Consignee" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_ConsigneeContNo" runat="server" CssClass="label labelColor">CONSIGNEE CONTACT NO</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_ConsigneeContNo" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" MaxLength="10" CssClass="form-control input-sm Txt_ConsigneeContNo"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_DelPin" runat="server" CssClass="label labelColor">CONSIGNEE PINCODE</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_DelPin" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_DelPin" MaxLength="6" onchange="ReadDataonchange('Txt_DelPin','hfDelPinID','Ddl_DelArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                <asp:HiddenField ID="hfDelPinID" runat="server" />
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_DelArea" runat="server" CssClass="label labelColor">CONSIGNEE AREA</asp:Label><span class="required">*</span>
                                <asp:DropDownList ID="Ddl_DelArea" runat="server" CssClass="formDisplay input-sm Ddl_DelArea">
                                    <asp:ListItem>SELECT</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_DelAdd" runat="server" CssClass="label labelColor">CONSIGNEE ADDRESS</asp:Label><span class="required">*</span>
                                <asp:TextBox ID="Txt_DelAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_DelAdd" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_DeliveryBranch" runat="server" CssClass="label labelColor">DELIVERY BRANCH</asp:Label>
                                <asp:TextBox ID="Txt_DeliveryBranch" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hfDeliveryBranch" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="materialDetails" runat="server">
                <div class="panel-heading panelHead">
                    <b>MATERIAL DETAIL</b>
                </div>
                <div class="form-horizontal" role="form">
                    <div class="form-group" id="ItemDetails" runat="server">
                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2">
                                <asp:LinkButton ID="BtnAddEWayBillInvoice" runat="server" AccessKey="w" CssClass="btn btn-info largeButtonStyle2" data-toggle="modal" data-target="#EWayBillModal" OnClientClick="javascript:return NewInvoice(this.id);">Add EWay Bill(Alt+W)</asp:LinkButton>
                            </div>
                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2">
                                <asp:LinkButton ID="Btn_AddNewInvoice" runat="server" AccessKey="a" CssClass="btn btn-info largeButtonStyle2" data-toggle="modal" data-target="#MaterialModal" OnClientClick="javascript:return NewInvoice(this.id);">Add New Invoice(Alt+A)</asp:LinkButton> 
                            </div>
                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2">
                                <asp:LinkButton ID="Btn_AddInSameInvoice" AccessKey="i" runat="server" CssClass="btn btn-info largeButtonStyle2" data-toggle="modal" data-target="#MaterialModal" OnClientClick="javascript:return SameInvoice();">Add in Same Invoice(Alt+I)</asp:LinkButton>
                            </div>
                            <div id="wailkinRate" runat="server">
                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-1 col-xl-1">
                                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor">CFT:</asp:Label>
                                </div>
                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-1 ">
                                    <asp:TextBox ID="txtCFT" runat="server" CssClass="form-control input-sm" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-1 col-xl-1">
                                    <asp:Label ID="Lbl_Weight" runat="server" CssClass="label labelColor">TOTAL WEIGHT:</asp:Label>
                                </div>
                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-1 ">
                                    <asp:TextBox ID="Txt_Weight" runat="server" CssClass="form-control input-sm" ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-2 col-xl-1" style="text-align: right">
                                    <asp:Label ID="Lbl_Rate" runat="server" CssClass="label labelColor">RATE(Rs):</asp:Label>
                                </div>
                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-1">
                                    <asp:TextBox ID="Txt_Rate" runat="server" CssClass="form-control input-sm Txt_Rate" Text="8" ></asp:TextBox>
                                </div>
                            </div>
                            <asp:HiddenField ID="hfInvoiceNo" runat="server" />
                            <asp:HiddenField ID="hfInvoiceDate" runat="server" />
                            <asp:HiddenField ID="hfInvoiceValue" runat="server" />
                            <asp:HiddenField ID="hfEwaybillNo" runat="server" />
                            <asp:HiddenField ID="hfEwaybillDate" runat="server" />
                            <asp:HiddenField ID="hfEwaybillExpiryDate" runat="server" />
                            <asp:HiddenField ID="hfCFTValue" runat="server" />
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
                                <asp:GridView ID="GV_WaybillDetail" runat="server" EnableViewState="false" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.<br>NO">
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
                                        <asp:BoundField DataField="MaterialType" HeaderText="MATERIAL<br>TYPE" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PackageID" HeaderText="PACKAGE ID" Visible="true">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PackageType" HeaderText="PACKAGE<br>TYPE" HtmlEncode="false">
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
                                        <asp:BoundField DataField="ActWeight" HeaderText="ACTUAL<br>WEIGHT" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ChargeWeight" HeaderText="CHARGE<br>WEIGHT" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NoOfPackage" HeaderText="QTY" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NoOfInnerPackage" HeaderText="INNER QTY" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceNo" HeaderText="INVOICE<br>NO" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceDate" HeaderText="INVOICE<br>DATE" HtmlEncode="false">
                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="InvoiceValue" HeaderText="INVOICE<br>VALUE" HtmlEncode="false">
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
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

                <div runat="server" id="InvoiceDetailDiv">
                    <div class="panel-heading panelHead">
                        <b>INVOICE DETAIL</b>
                    </div>
                    <div class="panel-body labelColor">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-4">
                                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                        </div>
                                        <asp:GridView ID="GV_Invoice" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="true">
                                        </asp:GridView>
                                    </div>
                                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 col-xl-6" runat="server" id="divCalculate">
                                        <div class="row">
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-3 col-xl-3">
                                                <asp:Label ID="Lbl_Total" runat="server" CssClass="label labelColor">Total:</asp:Label>
                                            </div>
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2">
                                                <asp:TextBox ID="Txt_TotalAmt" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-3 col-xl-3">
                                                <asp:Label ID="Lbl_GST" runat="server" CssClass="label labelColor">GST(%):</asp:Label>
                                                <asp:TextBox ID="Txt_GST" runat="server" CssClass="form-control input-sm Txt_GST" Text="12" ></asp:TextBox>
                                            </div>
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2">
                                                <asp:Label ID="Lbl_GSTAmt" runat="server" CssClass="label labelColor"></asp:Label>
                                                <asp:TextBox ID="Txt_GSTAmt" runat="server" CssClass="form-control input-sm Txt_GSTAmt"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-3 col-xl-3">
                                                <asp:Label ID="Lbl_GrandTotal" runat="server" CssClass="label labelColor">Grand Total:</asp:Label>
                                            </div>
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2">
                                                <asp:TextBox ID="Txt_GrandTotalAmt" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-4 col-sm-5 col-md-3 col-lg-3 col-xl-3">
                                                <div class="form-control-sm"></div><div class="form-control-sm"></div> 
                                                <asp:HiddenField ID="hfCalculated" runat="server" Value="0" />
                                                <asp:LinkButton ID="Btn_Calculate" runat="server" CssClass="btn btn-info largeButtonStyle2" AccessKey="k" OnClientClick="javascript:return CalculateTotalGrandTotal();">CALCULATE (Alt+K)</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="Button" runat="server">
                    <div class="row">
                        <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                            <div class="form-control-sm"></div>
                            <asp:HiddenField ID="hfWaybillSubmit" runat="server" ClientIDMode="Static" Value="0" />
                            <asp:LinkButton ID="Button_Submit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validateWarehouseWaybillDetails()) {return false;};">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                        </div>

                        <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="Btn_Reset" runat="server" OnClientClick="Btn_Reset()" CssClass="btn btn-info largeButtonStyle" >RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ContentTemplate>
    <Triggers>
    </Triggers>
</asp:UpdatePanel>