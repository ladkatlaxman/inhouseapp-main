<%@ Page Language="C#" MasterPageFile="~/dashAdmin.master"  AutoEventWireup="true" CodeFile="Dash.aspx.cs" Inherits="Dash"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
    <script src="js/jquery/jquery.min.js"></script>
    <script src="js/jquery/jquery.ui.min.js"></script>
    <link href="css/jquery/jquery.ui.css" rel="stylesheet" />
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    <script src="js/export-data.js"></script>
    <script src="js/accessibility.js"></script>
    <style>
        .highcharts-figure, .highcharts-data-table table {
          min-width: 310px; 
          max-width: 400px;
          margin: 1em auto;
        }
        #dailybookingcontainer {
          height: 300px;
        }
        #monthlybookingcontainer {
          height: 300px;
        }
        #monthlybookingtilldatecontainer {
          height: 300px;
        }
        #deliveryreportcontainer{
          height: 300px;
        }
        #pendingdeliveryreportcontainer{
          height: 300px;
        }
        #podcontainer{
          height: 300px;
        }
        .highcharts-data-table table {
	        font-family: Verdana, sans-serif;
	        border-collapse: collapse;
	        border: 1px solid #EBEBEB;
	        margin: 10px auto;
	        text-align: center;
	        width: 50%;
	        max-width: 200px;
        }
        .highcharts-data-table caption {
          padding: 1em 0;
          font-size: 1.2em;
          color: #555;
        }
        .highcharts-data-table th {
	        font-weight: 600;
            padding: 1.5em;
        }
        .highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
          padding: 0.5em;
        }
        .highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
          background: #f8f8f8;
        }
        .highcharts-data-table tr:hover {
          background: #f1f7ff;
        }
    </style>
    <div class="panel panelTop">
        <div class="panel-heading panelHead">
            <div class="row">
                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1"></div> 
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-4"><br /> 
                    <h2><asp:Label ID="lblCompanyDashboard" runat="server" Text="Application Dashboard " Font-Bold="true"></asp:Label><asp:Label ID="lblType" runat="server" Text="" Font-Bold="true"></asp:Label></h2> 
                </div>
            </div>
        </div>
    </div>
    <div class="panel-body" runat="server"> 
        <ContentTemplate> 
            <div class="form-horizontal" role="form"> 
                <div class="form-group"> 
                    <div class="container"> 
                <div class="row">
                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                    Branch : 
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                    <asp:DropDownList ID="cmbBranchList" runat="server" CssClass="formDisplay input-sm cmbBranchList" OnSelectedIndexChanged="Btn_Search_Click" AutoPostBack="true"></asp:DropDownList> 
                </div>
                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1">
                    Legend : 
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                    <asp:DropDownList ID="cmbType" runat="server" CssClass="formDisplay input-sm cmbtype" OnSelectedIndexChanged="Btn_Search_Click" AutoPostBack="true">
                        <asp:ListItem Value="ActualWeight" Text="Actual Weight" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="WayBills" Text="No of Waybills"></asp:ListItem>
                        <asp:ListItem Value="Qty" Text="No of Packets"></asp:ListItem>
                        <asp:ListItem Value="ChargedWeight" Text="Charged Weight"></asp:ListItem>
                        <asp:ListItem Value="Freight" Text="Freight Value"></asp:ListItem>
                    </asp:DropDownList> 
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2">
                    <asp:LinkButton ID="Btn_Search" runat="server" Text="REFRESH" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click">GET LIST</asp:LinkButton>
                </div>
            </div>
            <div class="row">&nbsp;</div>
            <div class="row" id="dailybookingcontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid">
                    <div id="dailybookingcontainer" runat="server"></div> 
                    <!-- <asp:ImageButton ID="imgBookingReport" OnClientClick="return false;" runat="server" data-toggle="modal" data-target="#ConsignorModal" ImageUrl="~/images//add.png" TabIndex="8" ToolTip="Detailed Report" />--> 
                </div>
            </div>
            <div class="row" id="monthlybookingtilldatecontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid"> 
                    <div id="monthlybookingtilldatecontainer" runat="server"></div> 
                    <!--<a href="details.aspx">View Details</a>--> 
                </div>
            </div>
            <div class="row" id="monthlybookingcontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid"> 
                    <div id="monthlybookingcontainer" runat="server"></div> 
                    <!--<a href="details.aspx">View Details</a>--> 
                </div>
            </div>
            <div class="row" id="monthlydeliverycontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid"> 
                    <div id="monthlydeliverycontainer" runat="server"></div> 
                    <!--<a href="details.aspx">View Details</a>--> 
                </div>
            </div>
            <div class="row" id="deliveryreportcontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid">
                    <div id="deliveryreportcontainer" runat="server"></div> 
                    <!--<a href="details.aspx">View Details</a>-->
                </div>
            </div>
            <div class="row" id="transhipmentreportrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid">
                    <div id="transhimentoperation" runat="server"></div> 
                    <!--<a href="details.aspx">View Details</a>-->
                </div>
            </div>
            <div class="row" id="podcontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid">
                    <div id="podcontainer" runat="server"></div>
                    <!-- <a href="details.aspx">View Details</a> --> 
                </div>
            </div>
            <div class="row" id="pendingtranshipmentscontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid"> 
                    <div id="pendingtranshipmentscontainer" runat="server"></div> 
                    <asp:HyperLink ID="lnkPendingTranshipments" Target="PendingTranshipment" runat="server">View Details</asp:HyperLink>
                </div>
            </div>
            <div class="row" id="pendingdeliveryreportcontainerrow" runat="server" visible="false"> 
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8" style="border:2px solid">
                    <div id="pendingdeliveryreportcontainer" runat="server"></div> 
                    <asp:HyperLink ID="lnkPendingDeliveries" Target="PendingDeliveries" runat="server">View Details</asp:HyperLink>
                </div>
            </div>
            </div>
        </div>
    </div>
        </ContentTemplate>
    </div>
    <script>
        <%=strJSData.ToString()%>        
    </script>
</asp:Content>
