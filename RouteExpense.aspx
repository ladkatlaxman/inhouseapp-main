<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="RouteExpense.aspx.cs" Inherits="RouteExpense" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        $(function () {
            $("[id*=<%=txtRate.ClientID%>]").keyup(function () {
                var rate = parseFloat($("[id*=<%=txtRate.ClientID%>]").val());
                var qnt = parseFloat($("[id*=<%=txtQty.ClientID%>]").val());
                var total = parseFloat(rate * qnt);
                $("[id*=<%=txtExpenseValue.ClientID%>]").val(total);
            });
        });
    </script>
    <script src="js/jquery/jquery.timepicker.min.js"></script>
    <link href="css/jquery/jquery.timepicker.min.css" rel="stylesheet" />
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_VehicleRequest" AssociatedUpdatePanelID="UpdatePanel_VehicleRequest" runat="server" DisplayAfter="0">
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
        <asp:UpdatePanel ID="UpdatePanel_VehicleRequest" runat="server">
            <ContentTemplate>
                <div class="panel-heading panelHead">
                    <b>VEHICLE REQUEST DETAILS</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl1" runat="server" CssClass="label labelColor">VEHICLE HIRING DATE</asp:Label><span class="required">
                                    <asp:TextBox ID="txtHiringDate" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label3" runat="server" CssClass="label labelColor">VEHICLE NUMBER</asp:Label> 
                                    <asp:TextBox ID="txtVehicleNo" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label5" runat="server" CssClass="label labelColor">VEHICLE TYPE</asp:Label> 
                                    <asp:TextBox ID="txtVehicleType" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor">ROUTE</asp:Label> 
                                    <asp:TextBox ID="txtRoute" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label4" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label> 
                                    <asp:TextBox ID="txtVendor" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label2" runat="server" CssClass="label labelColor">ACTUAL WEIGHT</asp:Label> 
                                    <asp:TextBox ID="txtActualWt" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label6" runat="server" CssClass="label labelColor">DRIVER NAME</asp:Label> 
                                    <asp:TextBox ID="txtDriverName" runat="server" ReadOnly="true" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox> 
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label11" runat="server" CssClass="label labelColor">TRIP START DATE</asp:Label> 
                                    <asp:TextBox ID="txtStartDate" runat="server" TabIndex="1" CssClass="form-control input-sm txtHiringDate" placeholder="DD/MM/YYYY"></asp:TextBox> 
                                </div> 
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2"> 
                                    <div class="form-control-sm"></div> 
                                    <asp:Label ID="Label13" runat="server" CssClass="label labelColor">TRIP START TIME</asp:Label> 
                                    <asp:TextBox ID="txtStartTime" runat="server" TabIndex="1" CssClass="form-control input-sm txtStartTime" placeholder="HH:MM"></asp:TextBox> 
                                </div> 
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2"> 
                                    <div class="form-control-sm"></div> 
                                    <asp:Label ID="Label12" runat="server" CssClass="label labelColor">TRIP END DATE</asp:Label> 
                                    <asp:TextBox ID="txtEndDate" runat="server" TabIndex="1" CssClass="form-control input-sm txtHiringDate" placeholder="DD/MM/YYYY"></asp:TextBox> 
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label14" runat="server" CssClass="label labelColor">TRIP END TIME</asp:Label> 
                                    <asp:TextBox ID="txtEndTime" runat="server" TabIndex="1" CssClass="form-control input-sm txtHiringDate" placeholder="HH:MM"></asp:TextBox> 
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label7" runat="server" CssClass="label labelColor">METER READING (START)</asp:Label> 
                                    <asp:TextBox ID="txtMeterStart" runat="server" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label8" runat="server" CssClass="label labelColor">METER READING (END)</asp:Label> 
                                    <asp:TextBox ID="txtMeterEnd" runat="server" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label15" runat="server" CssClass="label labelColor">KMS</asp:Label> 
                                    <asp:TextBox ID="txtKMS" runat="server" ReadOnly="true" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label16" runat="server" CssClass="label labelColor">TIME (HRS)</asp:Label> 
                                    <asp:TextBox ID="txtTime" runat="server" ReadOnly="true" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-sm"></div>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="6" CssClass="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClick="Button_Submit_Click">UPDATE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-control-sm"></div><div class="form-control-sm"></div>
                                <asp:Label ID="lblErrorMessage" runat="server" class="control-label" ForeColor="Red" Font-Bold="True"></asp:Label>
                                <div class="form-control-lg"></div>
                                <div class="form-control-lg"></div>
                            </div>
                        </div>
                    </div>
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label9" runat="server" CssClass="label labelColor">EXPENSE TYPE</asp:Label><span class="required">
                                    <asp:DropDownList ID="ddlExpenseType" runat="server" TabIndex="4" CssClass="formDisplay input-sm Ddl_DelArea"> 
                                        <asp:ListItem Value="1">FUEL(DIESEL)</asp:ListItem> 
                                        <asp:ListItem Value="2">FUEL(CNG)</asp:ListItem> 
                                        <asp:ListItem Value="3">FAST TAG</asp:ListItem> 
                                        <asp:ListItem Value="4">CASH TOLL</asp:ListItem> 
                                        <asp:ListItem Value="5">ADBLUE</asp:ListItem> 
                                        <asp:ListItem Value="6">REPAIR</asp:ListItem> 
                                        <asp:ListItem Value="7">MAINTENANCE</asp:ListItem> 
                                        <asp:ListItem Value="8">FINE</asp:ListItem> 
                                        <asp:ListItem Value="9">POLICE</asp:ListItem> 
                                        <asp:ListItem Value="100">OTHER</asp:ListItem> 
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label18" runat="server" CssClass="label labelColor">QTY (LTRS)</asp:Label> 
                                    <asp:TextBox ID="txtQty" runat="server" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label19" runat="server" CssClass="label labelColor">RATE</asp:Label> 
                                    <asp:TextBox ID="txtRate" runat="server" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label10" runat="server" CssClass="label labelColor">VALUE</asp:Label> 
                                    <asp:TextBox ID="txtExpenseValue" runat="server" Style="text-transform: uppercase;" TabIndex="1" CssClass="form-control input-sm txtHiringDate"></asp:TextBox>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="lnkExpense" runat="server" TabIndex="6" CssClass="btn btn-info largeButtonStyle2" UseSubmitBehavior="false" OnClick="lnkExpense_Click">ADD EXPENSE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                            </div> 
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Label17" runat="server" CssClass="label labelColor">EXPENSES DONE</asp:Label><span class="required"> 
                                    <asp:GridView ID="gvExpenseList" runat="server" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="&nbsp;&nbsp;SR.NO&nbsp;&nbsp;" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle><ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VehicleRequestExpenseId" HeaderText="Vehicle Request Expense Id" Visible="false" />
                                            <asp:BoundField DataField="VehicleExpenseName" HeaderText="&nbsp;&nbsp;EXPENSE TYPE&nbsp;&nbsp;"> 
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                                            </asp:BoundField> 
                                            <asp:BoundField DataField="qty" HeaderText="&nbsp;&nbsp;QTY&nbsp;&nbsp;"> 
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                                            </asp:BoundField> 
                                            <asp:BoundField DataField="rate" HeaderText="&nbsp;&nbsp;RATE&nbsp;&nbsp;"> 
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                                            </asp:BoundField> 
                                            <asp:BoundField DataField="Expense" HeaderText="&nbsp;&nbsp;AMOUNT&nbsp;&nbsp;"> 
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" /> 
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" /> 
                                            </asp:BoundField> 
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>

