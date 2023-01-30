<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="VehReqList.aspx.cs" Inherits="VehReqList"  EnableEventValidation = "false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="Validation/Contract_VendorMaster.js"></script>
    <script>
        var gridViewPickId = '#<%= gvFirstGrid.ClientID %>';
        function checkPickAll(selectAllCheckbox) {
            //get all checkboxes within item rows and select/deselect based on select all checked status            
            $('td :checkbox', gridViewPickId).prop("checked", selectAllCheckbox.checked);
        }
        function unCheckPickSelectAll(selectCheckbox) {
            //if any item is unchecked, uncheck header checkbox as well
            if (!selectCheckbox.checked)
                $('th :checkbox', gridViewPickId).prop("checked", false);
        }
    </script>
    <div class="panel panelTop"> 
        <div class="row">
            <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xl-8 ">
                <div class="panel-heading panelHead"  runat="server" id="HeaderName">
                    <b>LIST OF VENDOR VEHICLE REQUESTS</b>
                </div>
            </div>
        </div>
        <div class="row">
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
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-2">
                <div class="form-control-sm"></div>
                <asp:Label ID="Label1" runat="server" CssClass="label labelColor">BRANCH NAME</asp:Label><span class="required">*</span>
                <asp:DropDownList ID="cmbBranch" runat="server" CssClass="formDisplay input-sm cmbBranch" EnableViewState="true" />
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-2">
                <div class="form-control-sm"></div>
                <asp:Label ID="Lbl_PartyName" runat="server" CssClass="label labelColor">VENDOR NAME</asp:Label><span class="required">*</span>
                <asp:TextBox ID="TxtVendorName" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm TxtVendorName" Style="text-transform: uppercase;" onkeypress="return checkNumAlpha()" onchange="ReadDataonchange('Txt_VendorName','hfVendorName','','Contract_VendorMaster.aspx/getVendorName');" ></asp:TextBox> 
                <asp:HiddenField ID="hfVendorName" runat="server" EnableViewState="true" />
            </div>
        </div>
        <div class="row"> 
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-2"> 
                <div class="form-control-sm"></div>
                <asp:Label ID="Label3" runat="server" CssClass="label labelColor">VEHICLE NO</asp:Label> 
                <asp:TextBox ID="txtVehicleNo" runat="server" AutoCompleteType="Disabled" CssClass="form-control input-sm txtVehicleNo" Style="text-transform: uppercase;"></asp:TextBox> 
            </div>
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 col-xl-2"> 
                <div class="form-control-sm"></div>
                <asp:Label ID="Label4" runat="server" CssClass="label labelColor">Route</asp:Label> 
                <asp:DropDownList ID="cmbRoute" runat="server" CssClass="formDisplay input-sm cmbRoute" EnableViewState="true" /> 
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
        </div>
        <div class="row"> 
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:Label runat="server" ID="Label2" ForeColor="Red"></asp:Label>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:LinkButton ID="btnCreateBill" runat="server" Text="CREATE INVOICE" CssClass="btn btn-info largeButtonStyle2 btnCreateBill" OnClick="btnCreateBill_Click"></asp:LinkButton> 
                <asp:HiddenField ID="hSetVendorId"          runat="server" Value='' EnableViewState="true" /> 
                <asp:HiddenField ID="hVehicleRequestList"   runat="server" Value='' EnableViewState="true" /> 
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                <div class="form-control-lg"></div>
                <div class="form-control-sm"></div>
                <asp:Label runat="server" ID="lblError" ForeColor="Red"></asp:Label>
            </div>
        </div>
        <div class="form-group">
            <div class="form-horizontal" role="form">
                <div class="form-control-sm">&nbsp;</div>
                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast"> 
                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BranchName" HeaderText="BRANCH">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="VendorName" HeaderText="VENDOR">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hiringDate" HeaderText="HIRING">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ManifestNo" HeaderText="MANIFEST">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>
                            <asp:BoundField DataField="VehicleNo" HeaderText="VEHICLE NO">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>                                                 
                            <asp:BoundField DataField="VehicleType" HeaderText="VEHICLE TYPE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>                                                 
                        <asp:BoundField DataField="TripType" HeaderText="TRIP TYPE" Visible="false">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Route" HeaderText="ROUTE">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="FromKM" HeaderText="FROM KM">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="ToKM" HeaderText="TO KM">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="KMS" HeaderText="KM(S)">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="WayBills" HeaderText="WAYBILLS">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="Qty" HeaderText="QTY">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="ChargedWt" HeaderText="CHARGED WT">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:BoundField DataField="ActualWt" HeaderText="ACTUAL WT">
                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                        </asp:BoundField> 
                        <asp:TemplateField HeaderText="" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSelectAll" runat="server" onclick="checkPickAll(this);"/>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelect" runat="server" onclick="unCheckPickSelectAll(this);"/>
                                <asp:HiddenField ID="hvehicleRequestId"  runat="server" Value='<%# Eval("vehicleRequestId") %>' />
                                <asp:HiddenField ID="hvendorId"          runat="server" Value='<%# Eval("vendorId") %>' /> 
                            </ItemTemplate>
                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                        </asp:TemplateField>                        
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

