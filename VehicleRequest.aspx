<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehicleRequest.aspx.cs" Inherits="VehicleRequest" EnableEventValidation="false" EnableViewState="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#home" class="nav-link active tabfont">VEHICLE HIRING REQUEST</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View_Tab1" class="nav-link tabfont">VIEW PICK UP / DELIVERY VEHICLES</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#View_Tab2" class="nav-link tabfont">VIEW TRANSHIPMENT VEHICLES</a>
                </li>
            </ul>
        </div>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>
                <!--==============================================Pickup/Delivery Request Detail=======================================================================-->
                <div id="home" class="tab-pane active">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>VEHICLE HIRING REQUEST</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label1" runat="server" CssClass="label labelColor">VEHICLE NUMBER</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="form-control input-sm txtVehicleNo" Style="width: 215px; text-transform: uppercase;" MaxLength="10" onchange="GetVehicleData()"></asp:TextBox>
                                            <asp:HiddenField ID="hVehicleId" runat="server" EnableViewState="true" />
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Condition" runat="server" CssClass="label labelColor labelColor">REQUEST TYPE</asp:Label>
                                            <asp:DropDownList ID="Ddl_Condition" runat="server" CssClass="formDisplay Ddl_Condition" AutoPostBack="false">
                                                <asp:ListItem Value="PD">PICKUP / DELIVERY</asp:ListItem>
                                                <asp:ListItem Value="RT">TRANSHIPMENT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_VehicleNo" runat="server" CssClass="label labelColor">VEHICLE NO</asp:Label><span class="required">*</span>
                                            <div class="row">
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha1" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha1" placeholder="MH" Style="width: 45px; text-transform: uppercase;" MaxLength="2" ReadOnly="true" ></asp:TextBox>
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit1" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_NewVehicleNoDigit1" placeholder="12" Style="width: 45px; text-transform: uppercase;" MaxLength="2" onchange="clr()" ReadOnly="true" ></asp:TextBox>
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha2" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha2" placeholder="EK" Style="width: 45px; text-transform: uppercase;" MaxLength="2" ReadOnly="true" ></asp:TextBox>
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit2" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoDigit2" placeholder="1234" Style="width: 50px; text-transform: uppercase;" MaxLength="4" ReadOnly="true" ></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_VendorName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label>
                                            <asp:TextBox ID="Txt_VendorName" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VendorName"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_VehicleCategory" runat="server" CssClass="label labelColor">VEHICLE CATEGORY</asp:Label>
                                            <asp:TextBox ID="Txt_VehicleCategory" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VehicleCategory" onkeypress="return onlyAlphaValue()"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_VehicleType" runat="server" CssClass="label labelColor">VEHICLE TYPE</asp:Label>
                                            <asp:TextBox ID="Txt_VehicleType" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VehicleType" onkeypress="return onlyAlphaValue()"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_HiringDate" runat="server" CssClass="label labelColor">VEHICLE HIRING DATE</asp:Label>
                                            <asp:TextBox ID="Txt_HiringDate" runat="server" Style="text-transform: uppercase;" ReadOnly="true" CssClass="form-control input-sm Txt_HiringDate" EnableViewState="true" ClientIDMode="Static"></asp:TextBox>
                                            <asp:HiddenField ID="hdHiringDate" runat="server" />
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="divDelivery">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label2" runat="server" CssClass="label labelColor">DELIVERY ROUTE</asp:Label>
                                            <asp:DropDownList ID="ddlDeliveryRoute" runat="server" CssClass="formDisplay input-sm ddlDeliveryRoute">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="divTrans1">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Route" runat="server" CssClass="label labelColor">TRANSHIPMENT ROUTE</asp:Label>
                                            <asp:DropDownList ID="ddlTranshipmentRoute" runat="server" CssClass="formDisplay input-sm ddlTranshipmentRoute">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2" id="divTrans2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Label3" runat="server" CssClass="label labelColor">SCHEDULE</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_RouteSchedule" runat="server" CssClass="formDisplay input-sm Ddl_RouteSchedule" AutoPostBack="false" >
                                                <asp:ListItem>SELECT</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="hdRouteSchedule" runat="server" />
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_ReasonForVehicle" runat="server" CssClass="label labelColor">REMARK</asp:Label>
                                            <asp:TextBox ID="Txt_ReasonForVehicle" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_ReasonForVehicle" Placeholder="Give Reason for Vehicle Request" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                                <asp:LinkButton ID="Button_Submit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" OnClick="Button_Submit_Click" EnableViewState="true">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--==============================================View PICKUP / DELIVERY Data=======================================================================-->
                <div id="View_Tab1" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>VIEW VEHICLES FOR PICKUP DELIVERY</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <asp:GridView ID="GV_PickDelView" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="VIEW">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnk_VehicleRequestID" runat="server" OnClientClick='<%#Eval("VehicleRequestID","javascript:mapVehicle({0});")%>' Text='VIEW'></asp:LinkButton>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="sessionDetail.UserBranch" HeaderText="BRANCH NAME" SortExpression="sessionDetail.UserBranch">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="hiringDate" HeaderText="HIRING DATE" SortExpression="hiringDate">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO" SortExpression="VehicleNo">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Mpin" HeaderText="M-PIN" SortExpression="Mpin">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="totalAttachPickup" HeaderText="ATTACH TOTAL PICKUP" SortExpression="totalAttachPickup">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="totalAttachWaybill" HeaderText="ATTACH TOTAL WAYBILL" SortExpression="totalAttachWaybill">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderText="STATUS" SortExpression="Status">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="sessionDetail.CreationDateTime" HeaderText="CREATION DATETIME" SortExpression="sessionDetail.CreationDateTime">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--==============================================View PICKUP / DELIVERY Data=======================================================================-->
                <div id="View_Tab2" class="tab-pane">
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>VIEW DATA OF TRANSHIPMENT VEHICLES</b>
                        </div>
                        <div class="panel-body labelColor">
                            <div class="form-horizontal" role="form">
                                <div class="form-group">
                                    <asp:GridView ID="GV_TranshipView" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="sessionDetail.UserBranch" HeaderText="BRANCH NAME" SortExpression="sessionDetail.UserBranch">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="hiringDate" HeaderText="HIRING DATE" SortExpression="hiringDate">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO" SortExpression="VehicleNo">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="totalAttachWaybill" HeaderText="ATTACH TOTAL WAYBILL" SortExpression="totalAttachWaybill">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="routeName" HeaderText="ROUTE NAME" SortExpression="routeName">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="sealNo" HeaderText="SEAL NO" SortExpression="sealNo">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderText="STATUS" SortExpression="Status">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CurrentBranch" HeaderText="CURRENT BRANCH" SortExpression="CurrentBranch">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="sessionDetail.CreationDateTime" HeaderText="CREATION DATETIME" SortExpression="sessionDetail.CreationDateTime">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <script src="Validation/Vehicle.js?28"></script> 
</asp:Content>
