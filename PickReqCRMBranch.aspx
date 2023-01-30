<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PickReqCRMBranch.aspx.cs" Inherits="PickReqCRMBranch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
    <%--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <script>
             $(document).keydown(function (e) {
                if (e.altKey && e.which == 86) {
                e.preventDefault();
                $("[id*=SameAdd]").prop('checked', true);                   
                    var pickid = $("[id*=hfPickPinID]");
                    fillPickupDetails(pickid);                  
            }
        });

            function YourFunction(id) {
                console.log("Your Function");
                //console.log(id);
                $("[id*=hfPickUpIDValue]").val(id);
                console.log($("[id*=hfPickUpIDValue]").val());
                return true;
            }
        </script>

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Pickup_Manifest" AssociatedUpdatePanelID="UpdatePanel_Pickup_Manifest" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_View_Searching" AssociatedUpdatePanelID="UpdatePanel_View_Searching" runat="server" DisplayAfter="0">
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
        <!---Update Progress 3 ---->
        <asp:UpdateProgress ID="UpdateProgress_PopupChangeStatus" AssociatedUpdatePanelID="UpdatePanel_PopupChangeStatus" runat="server" DisplayAfter="0">
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
        <!---Update Progress 4 ---->
        <asp:UpdateProgress ID="UpdateProgress_NewConsignor" AssociatedUpdatePanelID="UpdatePanel_NewConsignor" runat="server" DisplayAfter="0">
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
        <!---Update Progress 5 ---->
        <asp:UpdateProgress ID="UpdateProgress_NewConsignee" AssociatedUpdatePanelID="UpdatePanel_NewConsignee" runat="server" DisplayAfter="0">
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
        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#home" class="nav-link active tabfont">PICKUP REQUEST</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View_Tab" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <div id="LoadingImage" runat="server" style="display: none">
                <div id="overlay">
                    <div id="modalprogress">
                        <div id="theprogress">
                            <img src="images/dots-4.gif" />
                        </div>
                    </div>
                </div>
            </div>
            <!-- Tab panes -->

            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--==============================================Start Pickup Request Information=======================================================================-->
                <div id="home" class="tab-pane active">
                    <div id="MainCustomer" runat="server">

                        <asp:UpdatePanel ID="UpdatePanel_Pickup_Manifest" runat="server">
                            <ContentTemplate>
                                <div class="panel panelTop">
                                    <div class="panel-heading panelHead">
                                        <b>PICKUP REQUEST</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <asp:HiddenField ID="GetORReadData" runat="server" Value="GetData" />
                                                <div class="row">

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickUpDate" runat="server" CssClass="label labelColor">PICKUP DATE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_PickUpDate" runat="server" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm Txt_PickUpDate" MaxLength="10"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustomerType" runat="server" CssClass="label labelColor">CONSIGNOR TYPE</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_CustomerType" runat="server" CssClass="formDisplay input-sm Ddl_CustomerType" TabIndex="2" onclick="getCustomerType();" onchange="getCustomerType(); cleardata();">
                                                            <asp:ListItem Value="CORPORATE">CORPORATE</asp:ListItem>
                                                            <asp:ListItem Value="WALKIN">WALKIN</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="row">

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="CustomerCodeDiv">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustCode" runat="server" CssClass="label labelColor">CONSIGNOR CODE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CustCode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustCode" TabIndex="3" onkeypress="checkAlphaNumeric()" onchange="ReadDataonchange('Txt_CustCode','hfCustID','Ddl_CustArea','PickReqCRMBranch.aspx/getCustomerCode');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfCustID" runat="server" />

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="CorporateCustomerDiv">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignor" runat="server" NavigateUrl="~/ReportData.aspx?value=Customers" Target="_blank">List</asp:HyperLink>
                                                        <asp:TextBox ID="Txt_CCustName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CCustName" TabIndex="4" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_CCustName','hfCustID','Ddl_CustArea','PickReqCRMBranch.aspx/getCustName');"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" runat="server" id="WalkinCustomerDiv">
                                                        <div class="row">
                                                            <div class="col-sm-11 col-md-11 col-lg-10">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_CustName" runat="server" CssClass="label labelColor">CONSIGNOR NAME</asp:Label><span class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_walkinConsignor" runat="server" NavigateUrl="~/ReportData.aspx?value=Consignors" Target="_blank">List</asp:HyperLink>
                                                                <asp:TextBox ID="Txt_WCustName" runat="server" Style="text-transform: uppercase;" onkeypress="return checkNumAlpha()" TabIndex="4" CssClass="form-control input-sm Txt_WCustName" onchange="ReadDataonchange('Txt_WCustName','hfWCustID','Ddl_CustArea','PickReqCRMBranch.aspx/getWalkinCustName');"></asp:TextBox>
                                                                <asp:HiddenField ID="hfWCustID" runat="server" />

                                                            </div>

                                                            <div class="col-sm-0.5 col-md-0.5 ">
                                                                <div class="form-control-static"></div>
                                                                <asp:ImageButton ID="Img_WCustName" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#ConsignorModal" ImageUrl="~/images//add.png" TabIndex="13" ToolTip="New Consignee" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustMobileNo" runat="server" CssClass="label labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CustMobileNo" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" MaxLength="10" CssClass="form-control input-sm Txt_CustMobileNo FirstNoSpaceAndZero"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustTelephoneNo" runat="server" CssClass="label labelColor">TELEPHONE NO</asp:Label>
                                                        <asp:TextBox ID="Txt_CustTelephoneNo" runat="server" Style="text-transform: uppercase;"  TabIndex="5" onkeypress="return checkNumericWithSpace()" MaxLength="13" CssClass="form-control input-sm Txt_CustTelephoneNo"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_EmailId" runat="server" CssClass="label labelColor">EMAILID</asp:Label>
                                                        <asp:TextBox ID="Txt_EmailId" runat="server" CssClass="form-control input-sm Txt_EmailId" TabIndex="6" onkeypress="return checkEmailId()"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustPin" runat="server" CssClass="label labelColor">CONSIGNOR PINCODE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CustPin" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustPin" onkeypress="return validateNumericValue(event)" MaxLength="6" onchange="ReadDataonchange('Txt_CustPin','hfCustPinID','Ddl_CustArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfCustPinID" runat="server" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustArea" runat="server" CssClass="label labelColor">CONSIGNOR AREA</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_CustArea" runat="server" CssClass="formDisplay input-sm Ddl_CustArea">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CustAdd" runat="server" CssClass="label labelColor">CONSIGNOR ADDRESS</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CustAdd" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_CustAdd" TextMode="MultiLine"></asp:TextBox>
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <asp:HiddenField runat="server" ID="HiddenField_SameAdd" Value="" />
                                                         <asp:CheckBox ID="SameAdd" runat="server" onclick="fillPickupDetails('hfPickPinID')" TabIndex="7"/><span id="SameAsText" runat="server" class="labelColor">Same as Consignor Address</span><br />
                                                        <asp:Label ID="Lbl_PickPin" runat="server" CssClass="label labelColor">PICKUP PINCODE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_PickPin" runat="server" Style="text-transform: uppercase;"  TabIndex="8" CssClass="form-control input-sm Txt_PickPin" onkeypress="return validateNumericValue(event)" MaxLength="6" onchange="ReadDataonchange('Txt_PickPin','hfPickPinID','Ddl_PickArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfPickPinID" runat="server" />
                                                    </div>

                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickArea" runat="server" CssClass="label labelColor">PICKUP AREA</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_PickArea" runat="server" CssClass="formDisplay input-sm Ddl_PickArea"  TabIndex="9">
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickAdd" runat="server" CssClass="label labelColor">PICKUP ADDRESS</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_PickAdd" runat="server" Style="text-transform: uppercase;"  TabIndex="10" CssClass="form-control input-sm Txt_PickAdd" TextMode="MultiLine"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PickupBranch" runat="server" CssClass="label labelColor">PICKUP BRANCH</asp:Label>
                                                        <asp:TextBox ID="Txt_PickupBranch" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PickupBranch" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                        <asp:HiddenField ID="hfPickupBranch" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="row">
                                                            <div class="col-sm-11 col-md-11 col-lg-10">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_ConsigneeName" runat="server" CssClass="label labelColor">CONSIGNEE NAME</asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="hl_consignee" runat="server" NavigateUrl="~/ReportData.aspx?value=Consignee" Target="_blank">List</asp:HyperLink>
                                                                <asp:TextBox ID="Txt_ConsigneeName" runat="server"  TabIndex="11" Style="text-transform: uppercase;" onkeypress="return checkNumAlpha()" CssClass="form-control input-sm Txt_ConsigneeName" onchange="ReadDataonchange('Txt_ConsigneeName','hfConsigneeID','Ddl_DelArea','PickReqCRMBranch.aspx/getConsigneeName');"></asp:TextBox>
                                                                <asp:HiddenField ID="hfConsigneeID" runat="server" />

                                                            </div>

                                                            <div class="col-sm-0.5 col-md-0.5 ">
                                                                <div class="form-control-static"></div>
                                                                <asp:ImageButton ID="Img_ConsigneeName" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#ConsigneeModal" ImageUrl="~/images//add.png" TabIndex="13" ToolTip="New Consignee" /><%----%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_ConsigneeContNo" runat="server" CssClass="label labelColor">CONSIGNEE CONTACT NO</asp:Label>
                                                        <asp:TextBox ID="Txt_ConsigneeContNo" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" MaxLength="10" CssClass="form-control input-sm Txt_ConsigneeContNo"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_DelPin" runat="server" CssClass="label labelColor">CONSIGNEE PINCODE</asp:Label>
                                                        <asp:TextBox ID="Txt_DelPin" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_DelPin" onkeypress="return validateNumericValue(event)" MaxLength="6" onchange="ReadDataonchange('Txt_DelPin','hfDelPinID','Ddl_DelArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfDelPinID" runat="server" />
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_DelArea" runat="server" CssClass="label labelColor">CONSIGNEE AREA</asp:Label>
                                                        <asp:DropDownList ID="Ddl_DelArea" runat="server" CssClass="formDisplay input-sm Ddl_DelArea">
                                                            <asp:ListItem>SELECT</asp:ListItem>
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
                                                        <asp:TextBox ID="Txt_DeliveryBranch" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                                        <asp:HiddenField ID="hfDeliveryBranch" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                     <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Label6" runat="server" CssClass="label labelColor">EXPECTED WEIGHT OF MATERIAL</asp:Label>
                                                        <asp:TextBox ID="Txt_ExpectedWeight" runat="server" TabIndex="12" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_ExpectedWeight"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-control-sm"></div>
                                    <div class="panel-heading panelHead">
                                        <b>MATERIAL DETAIL (OPTIONAL)</b>
                                    </div>
                                    <div class="panel-body labelColor">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <div class="row">
                                                    <asp:HiddenField ID="AutoIncementNo" runat="server" />
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_MaterialType" runat="server" CssClass="label labelColor">MATERIAL TYPE</asp:Label><span class="required">*</span>
                                                         <asp:HyperLink ID="hl_Material" runat="server" NavigateUrl="~/ReportData.aspx?value=Material" Target="_blank">List</asp:HyperLink>
                                                        <asp:TextBox ID="Txt_MaterialType" runat="server" TabIndex="13" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_MaterialType" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_MaterialType', 'hfMaterialID','', 'PickReqCRMBranch.aspx/getMaterial');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfMaterialID" runat="server" />
                                                    </div>

                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-2">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_PackageType" runat="server" CssClass="label labelColor">PACKAGE TYPE</asp:Label><span class="required">*</span>
                                                         <asp:HyperLink ID="hl_Package" runat="server" NavigateUrl="~/ReportData.aspx?value=Package" Target="_blank">List</asp:HyperLink>
                                                        <asp:TextBox ID="Txt_PackageType" runat="server" TabIndex="14" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PackageType" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_PackageType', 'hfPackageID','', 'PickReqCRMBranch.aspx/getPackages');"></asp:TextBox>
                                                        <asp:HiddenField ID="hfPackageID" runat="server" />
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Unit" runat="server" CssClass="label labelColor">UNIT</asp:Label><span class="required">*</span>
                                                        <asp:DropDownList ID="Ddl_Unit" runat="server" TabIndex="15" CssClass="formDisplay Ddl_Unit CFT">
                                                            <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                                            <asp:ListItem>SELECT</asp:ListItem>
                                                            <asp:ListItem>CM</asp:ListItem>
                                                            <asp:ListItem Selected="True">INCH</asp:ListItem>
                                                            <asp:ListItem>KG</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Length" runat="server" CssClass="label labelColor">LENGTH</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Length" runat="server" TabIndex="16" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Length FirstNoSpaceAndZero CFT"></asp:TextBox>
                                                        <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Breadth" runat="server" CssClass="label labelColor">BREADTH</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Breadth" runat="server" TabIndex="17" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Breadth FirstNoSpaceAndZero CFT"></asp:TextBox>
                                                        <%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_Height" runat="server" CssClass="label labelColor">HEIGHT</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_Height" runat="server" TabIndex="18" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_Height FirstNoSpaceAndZero CFT"></asp:TextBox><%--onchange="CFT('Ddl_Unit','Txt_Length','Txt_Breadth','Txt_Height');"--%>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_CFT" runat="server" CssClass="label labelColor">CFT</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_CFT" runat="server" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_CFT FirstNoSpaceAndZero" ReadOnly="true" Text="0"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_ActWeight" runat="server" CssClass="label labelColor">ACT WEIGHT</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_ActWeight" runat="server" TabIndex="19" Style="text-transform: uppercase;" onkeypress="return checkDecimalNumeric()" CssClass="form-control input-sm Txt_ActWeight FirstNoSpaceAndZero"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-4 col-md-4 col-lg-1 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_NoOfPackages" runat="server" CssClass="label labelColor">QTY</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_NoOfPackage" runat="server" TabIndex="20" Style="text-transform: uppercase;" onkeypress="return validateNumericValue(event)" CssClass="form-control input-sm Txt_NoOfPackage FirstNoSpaceAndZero"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-lg"></div>
                                                        <div class="form-control-sm"></div>

                                                        <asp:HiddenField ID="hfAddPickReqItem" runat="server" ClientIDMode="Static" Value="0" />
                                                        <asp:LinkButton ID="Btn_AddPickReqItem" runat="server" TabIndex="21" CssClass="btn btn-info buttonStyle2" UseSubmitBehavior="false" OnClientClick="if (!validatePickupRequestMaterialDetails()) {return false;};">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <asp:GridView ID="GV_Detail" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
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
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" />
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
                                                        <asp:BoundField DataField="NoOfPackages" HeaderText="QTY">
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="row">
                                            <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="hfPickReqSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                                <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="22" CssClass="btn btn-info Button_Submit largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validatePickupRequestDetails()) {return false;};">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <%--OnClick="Button_Submit_Click" --%>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:HiddenField ID="HiddenField_Btn_Reset" runat="server" Value="" />
                                                <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="23" OnClientClick="Btn_Reset()" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <!--==============================================End Pickup Request Information=======================================================================-->
                <!--==============================================Start Pickup Request View Information=======================================================================-->
                <div id="View_Tab" class="tab-pane">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel_View_Searching" runat="server">
                            <ContentTemplate>
                                <div class="panel panelTop" runat="server">
                                    <div class="panel-heading panelView">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-1 col-lg-1"></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                                                    <asp:TextBox ID="Txt_SearchFromDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm" TabIndex="14"></asp:TextBox>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_SearchToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                                                    <asp:TextBox ID="Txt_SearchToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm" TabIndex="14"></asp:TextBox>
                                                </div>

                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_Status" runat="server" CssClass="label labelColor">STATUS</asp:Label>
                                                    <asp:DropDownList ID="Ddl_SearchStatus" runat="server" CssClass="formDisplay" TabIndex="59">
                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                        <asp:ListItem>OPEN</asp:ListItem>
                                                        <asp:ListItem>CLOSE</asp:ListItem>
                                                        <asp:ListItem>CANCEL</asp:ListItem>
                                                        <asp:ListItem>REJECT</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-md-3 col-lg-4"></div>
                                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                    <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click" TabIndex="51" Text="SEARCH">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-3 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Label7" runat="server" CssClass="label labelColor">TOTAL QTY:-</asp:Label>
                                                    <asp:Label ID="Lbl_TotalNoOfPackage" runat="server" Font-Bold="true" CssClass="label labelColor"></asp:Label>
                                                </div>

                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Label8" runat="server" CssClass="label labelColor">TOTAL WEIGHT:-</asp:Label>
                                                    <asp:Label ID="Lbl_TotalWeight" runat="server" Font-Bold="true" CssClass="label labelColor"></asp:Label>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-body" id="searchRoute" runat="server">
                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <asp:GridView ID="gridViewPickupRequestDetail" runat="server" DataKeyNames="pickupID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewPickupRequestDetail_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewPickupRequestDetail_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="Btn_ChangeStatus" runat="server" data-toggle="modal" data-target="#modalForChangeStatus" OnClientClick='<%#Eval("pickupID","javascript:return YourFunction(\"{0}\");")%>' ToolTip="Change Status"><i style="font-size: 20px; color:red" class="fa fa-close"></i></asp:LinkButton>
                                                                <asp:HiddenField ID="hfPickUpIDValue" runat="server" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="CREATE WAYBILL">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnk_CreateWaybill" runat="server" CommandArgument='<%#Eval("pickupID") %>' OnClick="lnk_CreateWaybill_Click" Text='CREATE'></asp:LinkButton>
                                                                <%-- OnClientClick='<%#Eval("pickupID","javascript:FillData({0});")%>'              --%>
                                                                <%--   <asp:HiddenField ID="hfPickUpIDValue" runat="server" />--%>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="pickupID" HeaderText="PICKUP ID" SortExpression="pickupID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                         <asp:BoundField DataField="PickupNo" HeaderText="PICKUP NO" SortExpression="PickupNo">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle " ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PickType" HeaderText="PICKUP TYPE" SortExpression="PickType">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle hidden" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PickDate" HeaderText="PICKUP DATE" SortExpression="PickDate">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="CustCode" HeaderText="CONSIGNOR CODE" SortExpression="CustCode">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="CustName" HeaderText="CONSIGNOR NAME" SortExpression="CustName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PickupBranch" HeaderText="PICKUP BRANCH" SortExpression="PickupBranch">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PickPINCode" HeaderText="PICKUP PINCODE" SortExpression="PickPINCode">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="pickupArea" HeaderText="PICKUP AREA" SortExpression="pickupArea">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DelPINCode" HeaderText="CONSIGNEE PINCODE" SortExpression="DelPINCode">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DelArea" HeaderText="CONSIGNEE AREA" SortExpression="DelArea">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DeliveryBranch" HeaderText="DELIVERY BRANCH" SortExpression="DeliveryBranch">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ExpectedWeightOfMaterial" HeaderText="EXPECTED WEIGHT OF MATERIAL" SortExpression="ExpectedWeightOfMaterial">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Status" HeaderText="STATUS" SortExpression="Status">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Remark" HeaderText="REMARK" SortExpression="Remark">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UserName" HeaderText="CREATED BY" SortExpression="UserName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UserBranch" HeaderText="CREATED BRANCH" SortExpression="UserBranch">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:GridView>
                                                <%--  <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
                                                    <div id="map" style="width: 500px; height: 400px;"></div>
                                                    <script type="text/javascript">
                                                        var locations = [
                                                            ['11, SWAMINARAYAN ESTATE, OPPOSITE BARODA EXPRESS HIGHWAY, SWAMINARAYAN ESTATE, AHMEDABAD', 23.00, 72.62, 3],
                                                            ['304, 3RD EYE ONE COMPLEX, OPPOSITE HONEST RESTAURANT, CHIMANLAL GIRDHARLAL RD, PANCHAVATI SOCIETY, AHMEDABAD', 23.02, 72.55, 2],
                                                            ['ANMOL LAXMI INDUSTRIAL & LOGISTICS PARK, BESIDES BHARAT PETROLEUM DEPOT, NR. VRAJ INTEGRATED TEXTILE PARK, NATIONAL HIGHWAY 8, PINGLAJ, AHMEDABAD', 22.82, 72.61, 1]
                                                        ];

                                                        var map = new google.maps.Map(document.getElementById('map'), {
                                                            zoom: 10,
                                                            center: new google.maps.LatLng(23.02, 72.55),
                                                            mapTypeId: google.maps.MapTypeId.ROADMAP
                                                        });

                                                        var infowindow = new google.maps.InfoWindow();

                                                        var marker, i;

                                                        for (i = 0; i < locations.length; i++) {
                                                            marker = new google.maps.Marker({
                                                                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                                                                map: map
                                                            });

                                                            google.maps.event.addListener(marker, 'click', (function (marker, i) {
                                                                return function () {
                                                                    infowindow.setContent(locations[i][0]);
                                                                    infowindow.open(map, marker);
                                                                }
                                                            })(marker, i));
                                                        }
                                                    </script>--%>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <!--==============================================End Pickup Request View Information=======================================================================-->
            </div>
        </div>
    </div>

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
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
                                            <asp:TextBox ID="Txt_PopupConsignorPincode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopupConsignorPincode" onchange="ReadDataonchange('Txt_PopupConsignorPincode','hfPopupConsignorPincode','Ddl_PopupConsignorArea','PickReqCRMBranch.aspx/getConsignorPincode');"></asp:TextBox>
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
                                            <asp:Button ID="Btn_PopupConsignorSubmit" runat="server" CssClass="btn btn-info buttonStyle Btn_PopupConsignorSubmit" Text="SUBMIT"></asp:Button>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_PopupConsignorClose" runat="server" CssClass="btn btn-info buttonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=================================================== End Consignor Popup Modal===============================================================-->

    <!--=======================================================Change Status========================================================================================-->
    <!-- Modal -->
    <div class="modal" id="modalForChangeStatus" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">CHANGE STATUS</h4>
                </div>
                <div>
                    <asp:UpdatePanel ID="UpdatePanel_PopupChangeStatus" runat="server">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-1 col-md-1 col-lg-1"></div>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_popupChangeStatus" runat="server" CssClass="label labelColor labelColor">STATUS</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_popupChangeStatus" runat="server" CssClass="formDisplay" TabIndex="59">
                                                <asp:ListItem>SELECT</asp:ListItem>
                                                <asp:ListItem>CANCEL</asp:ListItem>
                                                <asp:ListItem>REJECT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_popupRemark" runat="server" class="label labelColor labelColor">REMARK</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_popupRemark" runat="server" Style="text-transform: uppercase;" TextMode="MultiLine" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal footer -->
                            <div class="modal-footer">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-1 col-md-1 col-lg-1"></div>
                                        <div class=" col-md-2 col-lg-3 "></div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="HiddenField_Btn_popupChangeStatus" runat="server" />
                                            <asp:Button ID="Btn_popupChangeStatus" runat="server" OnClientClick="Btn_popupChangeStatus()" CssClass="btn btn-info buttonStyle" Text="SUBMIT" OnClick="Btn_popupChangeStatus_Click"></asp:Button>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_popupStatusClose" runat="server" CssClass="btn btn-info buttonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Btn_popupChangeStatus" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=================================================== End Change Status Popup Modal===============================================================-->

    <!--=======================================================popup modal of Consignee========================================================================================-->
    <div class="modal" id="ConsigneeModal" role="dialog">
        <div class="modal-dialog">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">NEW CONSIGNEE</h4>
                </div>
                <div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel_NewConsignee">
                        <ContentTemplate>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneeName" runat="server" class="label labelColor labelColor">CONSIGNEE NAME</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneeName" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeName" onkeypress="return checkNumAlpha()"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneeContactNo" runat="server" class="label labelColor labelColor">CONTACT NO</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneeContactNo" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeContactNo" placeholder="+91" MaxLength="10" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneePincode" runat="server" class="label labelColor labelColor">CONSIGNEE PINCODE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopConsigneePincode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneePincode" onchange="ReadDataonchange('Txt_PopConsigneePincode','hfPopConsigneePincode','Ddl_PopConsigneeArea','PickReqCRMBranch.aspx/getPincode');"></asp:TextBox>
                                            <asp:HiddenField ID="hfPopConsigneePincode" runat="server" />
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopConsigneeArea" runat="server" class="label labelColor labelColor">CONSIGNEE AREA</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_PopConsigneeArea" runat="server" CssClass="formDisplay input-sm Ddl_PopConsigneeArea">
                                                <asp:ListItem>SELECT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label3" runat="server" class="label labelColor labelColor">DISTRICT</asp:Label>
                                            <asp:TextBox ID="Txt_PopConsigneeDistrict" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeDistrict" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label4" runat="server" class="label labelColor labelColor">CITY</asp:Label>
                                            <asp:TextBox ID="Txt_PopConsigneeCity" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopConsigneeCity" Text="AUTO" ReadOnly="true"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_popConsigneeAddress" runat="server" class="label labelColor labelColor">CONSIGNEE ADDRESS</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_popConsigneeAddress" runat="server" Style="text-transform: uppercase;" TextMode="MultiLine" CssClass="form-control input-sm Txt_popConsigneeAddress"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5 col-md-5 col-lg-5 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_PopGSTNoOfConsignee" runat="server" class="label labelColor labelColor">GST NO OF CONSIGNEE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_PopGSTNoOfConsignee" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_PopGSTNoOfConsignee"></asp:TextBox>
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
                                            <asp:HiddenField ID="hfConsigneeSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:Button ID="Btn_ConsigneeSubmit" runat="server" CssClass="btn btn-info buttonStyle Btn_ConsigneeSubmit" Text="SUBMIT"></asp:Button>
                                        </div>
                                        <div class=" col-sm-3 col-md-2 col-lg-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Button ID="Btn_ConsigneeClose" runat="server" CssClass="btn btn-info buttonStyle" Text="CLOSE" data-dismiss="modal"></asp:Button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <!--=======================================================End popup modal of Consignee========================================================================================-->

    <script src="FJS_File/PickupRequestCRMBranch.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script src="Validation/Val_PickUpRequest.js"></script>
    <script>
        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }
        function Btn_popupChangeStatus() {
            $('[id*=HiddenField_Btn_popupChangeStatus]').val("1");
            console.log($('[id*=HiddenField_Btn_popupChangeStatus]').val());
        }
        function Btn_Reset() {
            $('[id*=HiddenField_Btn_Reset]').val("1");
            console.log($('[id*=HiddenField_Btn_Reset]').val());
        }
    </script>

    <script type="text/javascript">
        function showModal() {
            console.log("modal");
            $("#modalForChangeStatus").modal("show");
        }
    </script>
</asp:Content>

