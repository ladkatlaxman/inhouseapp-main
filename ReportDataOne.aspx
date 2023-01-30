<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ReportDataOne.aspx.cs" Inherits="ReportDataOne" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>REPORT DETAILS</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
                        <%--  <div class="col-md-1 col-lg-1"></div>--%>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">FROM DATE</asp:Label>
                            <asp:TextBox ID="Txt_FromDate" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_FromDate"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">TO DATE</asp:Label>
                            <asp:TextBox ID="Txt_ToDate" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm Txt_ToDate"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Label1" runat="server" CssClass="label labelColor">DOCUMENT NO</asp:Label>
                            <asp:TextBox ID="txtWayBillNo" runat="server" Style="text-transform: uppercase" CssClass="form-control input-sm"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_Select" runat="server" CssClass="label labelColor">SELECT</asp:Label>
                            <asp:DropDownList ID="Ddl_Select" runat="server" CssClass="formDisplay input-sm Ddl_Select" AutoPostBack="true" OnSelectedIndexChanged="Ddl_Select_SelectedIndexChanged">
                                <asp:ListItem Value="">SELECT</asp:ListItem>
                                <asp:ListItem Value="BOOKINGWAYBILL">WAYBILL BOOKING REPORT</asp:ListItem>
                                <asp:ListItem Value="BOOKINGWAYBILLPAID">WAYBILL BOOKING REPORT (PAID / TO PAY)</asp:ListItem>
                                <asp:ListItem Value="BOOKINGWAYBILLDELIVERY">WAYBILL BOOKING REPORT (DELIVERY)</asp:ListItem>
                                <asp:ListItem Value="BOOKINGITEMS">ITEMWISE BOOKING REPORT</asp:ListItem>
                                <asp:ListItem Value="SUMMARY">WAYBILL SUMMARY</asp:ListItem>
                                <asp:ListItem Value="MATERIALFORWARDING">MATERIAL FORWARDING REPORT</asp:ListItem> 
                                <asp:ListItem Value="ALLOPENPICKUPS">OPEN PICKUPS</asp:ListItem>
                                <asp:ListItem Value="PICKUPS">PICKUPS CREATED</asp:ListItem>
                                <asp:ListItem Value="WAYBILLTRACKING">WAY BILL TRACKING</asp:ListItem>
                                <asp:ListItem Value="WAYBILLTRACKINGSUM">WAY BILL TRACKING SUM</asp:ListItem>
                                <asp:ListItem Value="WAYBILLMOVEMENT">WAYBILL MOVEMENTS</asp:ListItem>
                                <asp:ListItem Value="WAYBILLS">WAYBILLS ENTERED</asp:ListItem>
                                <asp:ListItem Value="LOADEDWAYBILLS">LOADED WAYBILLS</asp:ListItem>
                                <asp:ListItem Value="BOOKINGWAYBILLS">BOOKED WAYBILLS (TO PICK)</asp:ListItem>
                                <asp:ListItem Value="TOBRANCHSTOCK">TO BRANCH STOCK</asp:ListItem>
                                <asp:ListItem Value="TOROUTESTOCK">WAYBILLS FOR THE ROUTES</asp:ListItem>
                                <asp:ListItem Value="BRANCHVEHICLES">BRANCH VEHICLES</asp:ListItem>
                                <asp:ListItem Value="VEHICLEREQUESTS">VEHICLE REQUESTS</asp:ListItem>
                                <asp:ListItem Value="VEHICLEINTRIP">VEHICLES IN TRIP</asp:ListItem>
                                <asp:ListItem Value="DRS">DELIVERY RUN SHEET</asp:ListItem>
                                <asp:ListItem Value="PICKUPLOADED">PICKUP LOADING</asp:ListItem>
                                <asp:ListItem Value="LHS">LHS</asp:ListItem>
                                <asp:ListItem Value="VEHICLEWAYBILLEXECDATE">WAYBILL VEHICLE LOADING (EXEC DATE)</asp:ListItem>
                                <asp:ListItem Value="VEHICLEWAYBILLWAYBILLDATE">WAYBILL VEHICLE LOADING (WAYBILL DATE)</asp:ListItem>
                                <asp:ListItem Value="TRANSHIPWEIGHT">TRANSHIPMENT VEHICLE WEIGHT</asp:ListItem>
                                <asp:ListItem Value="PICKDELWEIGHT">PICK UP / DELIVERY VEHICLE WEIGHT</asp:ListItem>
                                <asp:ListItem Value="MANIFEST">MANIFEST</asp:ListItem>
                                <asp:ListItem Value="MANIFESTSUMMARY">MANIFEST SUMMARY</asp:ListItem>
                                <asp:ListItem Value="DRSREGISTER">DRS REGISTER</asp:ListItem>
                                <asp:ListItem Value="VEHICLEREQUESTMATERIAL">VEHICLE REQUEST MATERIAL</asp:ListItem>
                                <asp:ListItem Value="BRANCHSTOCK">WAYBILL STOCK AT BRANCH</asp:ListItem>
                                <asp:ListItem Value="TRANSHIPMENTSTOCK">WAYBILL STOCK AT BRANCH - FOR TRANSHIPMENT</asp:ListItem>
                                <asp:ListItem Value="DELIVERYBRANCHSTOCK">WAYBILL STOCK AT BRANCH - FOR DELIVERY</asp:ListItem>
                                <asp:ListItem Value="VEHICLEMOVEMENT">VEHICLE MOVEMENTS</asp:ListItem>
                                <asp:ListItem Value="BRANCHLOCATIONS">BRANCH LOCATIONS</asp:ListItem>
                                <asp:ListItem Value="BILLINGPARTY">BILLING PARTY</asp:ListItem>
                                <asp:ListItem Value="CUSTOMERS">CUSTOMERS</asp:ListItem>
                                <asp:ListItem Value="CONSIGNORS">CONSIGNORS</asp:ListItem>
                                <asp:ListItem Value="CONSIGNEE">CONSIGNEE</asp:ListItem>
                                <asp:ListItem Value="CUSTOMERCONTRACTS">CUSTOMER CONTRACTS</asp:ListItem>
                                <asp:ListItem Value="MATERIAL">MATERIAL TYPE</asp:ListItem>
                                <asp:ListItem Value="PACKAGE">PACKAGE TYPE</asp:ListItem>
                                <asp:ListItem Value="ROUTES">ROUTES</asp:ListItem>
                                <asp:ListItem Value="WAYBILLSTATIONARY">WAYBILL STATIONARY</asp:ListItem>
                                <asp:ListItem Value="WAYBILLMOBILE">MOBILE WAYBILL</asp:ListItem>
				                <asp:ListItem Value="VEHICLECONTRACTCONDITION">VEHICLE CONTRACT CONDITIONS</asp:ListItem>
				                <asp:ListItem Value="MOVINGVEHICLE"> MOVING VEHICLE DATA</asp:ListItem>
				                <asp:ListItem Value="BRANCHLOAD">BRANCH LOAD</asp:ListItem>
                                <asp:ListItem Value="WAYBILLTRANSITIONDELIVERY">WAYBILL TRANSITION (DELIVERY)</asp:ListItem>
                                <asp:ListItem Value="WAYBILLTRANSITIONTRANSHIPMENT">WAYBILL TRANSITION (TRANSHIPMENT)</asp:ListItem>
				                <asp:ListItem Value="MOVEMENTSUMMARY">MOVEMENT SUMMARY</asp:ListItem>
                                <asp:ListItem Value="MIS">MIS</asp:ListItem> 
				                <asp:ListItem Value="PENDDEL">PENDING DELIVERIES</asp:ListItem>
                                <asp:ListItem Value="PENDTRANS">PENDING TRANSHIPMENTS</asp:ListItem> 
                            </asp:DropDownList>
                        </div>
                         <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1" runat="server" id="AllBranchesReport" visible="false">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:CheckBox ID="chkALLBranches" runat="server" Text="All Branches" />
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="Btn_Search" runat="server" Text="GET LIST" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click">GET LIST</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="btnExport" runat="server"  CssClass="btn btn-info largeButtonStyle btnExport" OnClick="btnExport_Click">EXCEL</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="lnkDirectDownload" runat="server"  CssClass="btn btn-info largeButtonStyle btnExport" OnClick="lnkDirectDownload_Click">EXCEL(DIRECT)</asp:LinkButton> 
                        </div>
                    </div>
                         <div class="row" id="SearchingParam" runat="server" visible="false">
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1"></div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_SearchCustName" runat="server" CssClass="label labelColor">CUSTOMER NAME</asp:Label>
                            <asp:TextBox ID="Txt_SearchCustName" runat="server" CssClass="form-control input-sm Txt_SearchCustName" Style="text-transform: uppercase;" AutoCompleteType="Disabled" onkeypress="return checkNumAlpha()" TabIndex="47"></asp:TextBox>
                             <asp:HiddenField ID="hfSearchCustName" runat="server" />                       
                        </div>
                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_PodUploaded" runat="server" CssClass="label labelColor">POD UPLOADED</asp:Label>
                            <asp:DropDownList ID="Ddl_PodUploaded" runat="server" CssClass="formDisplay input-sm Ddl_PodUploaded">
                                <asp:ListItem Value="ALL">ALL</asp:ListItem>
                                <asp:ListItem Value="YES">YES</asp:ListItem>
                                <asp:ListItem Value="NO">NO</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group" runat="server" id="HeaderDetails" visible="false">
                    <div class="row">
                         <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor">WAYBILL NO:</asp:Label>
                    <asp:Label ID="Lbl_WaybillNo" runat="server" CssClass="label" ForeColor="#666666" />
                </div>
                <div class="col-md-1 col-lg-1"></div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                    <asp:Label ID="Label11" runat="server" CssClass="label labelColor">WAYBILL DATE:</asp:Label>
                    <asp:Label ID="lblWayBillDate" runat="server" CssClass="label" ForeColor="#666666" />
                </div>
                <div class="col-md-1 col-lg-1"></div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                    <asp:Label ID="Label12" runat="server" CssClass="label labelColor">PAYMENT MODE:</asp:Label>
                    <asp:Label ID="Lbl_PaymentMode" runat="server" CssClass="label" ForeColor="#666666" />
                </div>
			 	<div class="col-md-1 col-lg-1"></div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                    <asp:Label ID="Label13" runat="server" CssClass="label labelColor">CREATED BY:</asp:Label>
                    <asp:Label ID="lblUser" runat="server" CssClass="label" ForeColor="#666666" />
                </div>
                </div>
                <div class="row">
				<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        	
					<asp:Label ID="Label4" runat="server" CssClass="label labelColor">PICKUP BRANCH:</asp:Label>
				</div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">	
                	<asp:Label ID="Lbl_PickupBranch" runat="server" CssClass="label" ForeColor="#666666"/>
                </div>
			<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "> 
                            <asp:Label ID="Label6" runat="server" CssClass="label labelColor">PICKUP AREA:</asp:Label>
			</div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">	
                            <asp:Label ID="lblPickUpArea" runat="server" CssClass="label" ForeColor="#666666"/>
                        </div> 
			<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        	
                            <asp:Label ID="Label9" runat="server" CssClass="label labelColor">PIN CODE:</asp:Label>                                   	
                        </div>	
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">	
                                <asp:Label ID="lblPickUpPIN" runat="server" CssClass="label" ForeColor="#666666"/>	
                        </div>
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        
                            <asp:Label ID="Label3" runat="server" CssClass="label labelColor">CONSIGNOR NAME:</asp:Label>                                   
                        </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <asp:Label ID="Lbl_ConsignorName" runat="server" CssClass="label" ForeColor="#666666"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        
                            <asp:Label ID="Label8" runat="server" CssClass="label labelColor">DELIVERY BRANCH:</asp:Label>
			</div> 
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <asp:Label ID="Lbl_DeliveryBranch" runat="server" CssClass="label" ForeColor="#666666"/>
                        </div>
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        
                            <asp:Label ID="Label7" runat="server" CssClass="label labelColor">DELIVERY AREA:</asp:Label> 
			</div> 
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <asp:Label ID="lblDeliveryArea" runat="server" CssClass="label" ForeColor="#666666"/> 
                        </div> 
			<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        	
                            <asp:Label ID="Label10" runat="server" CssClass="label labelColor">DELIVERY PIN CODE:</asp:Label>	
                        </div>	
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">	
                                <asp:Label ID="lblDeliveryPIN" runat="server" CssClass="label" ForeColor="#666666" />	
                        </div>      
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">        
                            <asp:Label ID="Label5" runat="server" CssClass="label labelColor">CONSIGNEE NAME:</asp:Label>
                        </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <asp:Label ID="Lbl_ConsigneeName" runat="server" CssClass="label" ForeColor="#666666" />
                        </div>                              
                    </div>
        </div>
	<div class="form-group" runat="server" id="divManifest" visible="false">
            <div class="row">
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                    MANIFEST BRANCH : 
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                    <asp:DropDownList id="ddlManifest" runat="server"></asp:DropDownList> 
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                    <asp:LinkButton ID="btnPrintScreen" runat="server"  CssClass="btn btn-info largeButtonStyle btnPrintScreen" OnClick="btnPrintScreen_Click">PRINT</asp:LinkButton> 
                </div>
		<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                    <asp:LinkButton ID="btnPrintLHS" runat="server"  CssClass="btn btn-info largeButtonStyle btnPrintLHS" OnClick="btnPrintLHS_Click">PRINT LHS</asp:LinkButton> 
                </div>
            </div>
        </div>
        <div class="form-group" runat="server" id="divDRS" visible="false">
            <div class="row">
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                    <asp:LinkButton ID="btnPrintDRS" runat="server"  CssClass="btn btn-info largeButtonStyle btnPrintScreen" OnClick="btnPrintScreen_Click">PRINT</asp:LinkButton> 
                </div> 
            </div>
        </div>
        <asp:Label ID="lblError" runat="server" Visible="false" Font-Bold="true" ForeColor="Red"></asp:Label>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" OnRowDataBound="GV_CustomerList_RowDataBound" RowStyle-CssClass="gvItemStyle" AllowPaging="false" OnPageIndexChanging="gvFirstGrid_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/>                              
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <asp:GridView ID="gvSecondGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" Visible="false" RowStyle-CssClass="gvItemStyle" AllowPaging="false" OnPageIndexChanging="gvSecondGrid_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false"/>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

