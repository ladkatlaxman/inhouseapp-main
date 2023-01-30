<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehicleLimit.aspx.cs" Inherits="VehicleLimit" %>

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
                                            <asp:HiddenField ID="hVehicleId" runat="server" />
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_VehicleNo" runat="server" CssClass="label labelColor">VEHICLE NO</asp:Label><span class="required">*</span>
                                            <div class="row">
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                    <asp:TextBox ID="Txt_NewVehicleNoAlpha1" runat="server" CssClass="form-control input-sm Txt_NewVehicleNoAlpha1" placeholder="MH" Style="width: 45px; text-transform: uppercase;" MaxLength="2" ReadOnly="true" ></asp:TextBox>
                                                </div>
                                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                    <asp:TextBox ID="Txt_NewVehicleNoDigit1" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_NewVehicleNoDigit1" placeholder="12" Style="width: 45px; text-transform: uppercase;" MaxLength="2" ReadOnly="true" ></asp:TextBox>
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
                                            <asp:TextBox ID="Txt_VehicleCategory" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VehicleCategory"></asp:TextBox>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_VehicleType" runat="server" CssClass="label labelColor">VEHICLE TYPE</asp:Label>
                                            <asp:TextBox ID="Txt_VehicleType" runat="server" Style="text-transform: uppercase;" ReadOnly="true" Text="AUTO" CssClass="form-control input-sm Txt_VehicleType"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_AccessBranch" runat="server" CssClass="label labelColor">ACCESS BRANCH</asp:Label>
                                            <asp:DropDownList ID="Ddl_AccessBranch" runat="server" CssClass="formDisplay Ddl_AccessBranch">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Route" runat="server" CssClass="label labelColor">TRANSHIPMENT ROUTE</asp:Label>
                                            <asp:DropDownList ID="ddlTranshipmentRoute" runat="server" CssClass="formDisplay input-sm ddlTranshipmentRoute">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                          	<table class="table table-condensed table-bordered table-hover table-responsive" cellspacing="0" rules="all" border="1" id="gvVehicleGrid" style="border-collapse:collapse;">
                                                  <tr class="gvHeaderStyle" align="center" style="color:Black;">
                                                    <th scope="col">Branch</th>
                                                    <th scope="col">Route</th>
                                                  </tr>
                                                  <tr class="gvItemStyle">
                                                      <td>&nbsp;</td>
                                                      <td>&nbsp;</td>
                                                  </tr>
                                            </table>
                                            <asp:GridView ID="gvVehicleLimit" runat="server">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Branch">
                                                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Route">
                                                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
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
                                                <asp:LinkButton ID="Button_Submit_Limit" runat="server" CssClass="btn btn-info Btn_Basic_Save largeButtonStyle" OnClick="Button_Submit_Limit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                            </div>
                                            <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                                <div class="form-control-sm"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <script src="Validation/Vehicle.js?14"></script> 
</asp:Content>
