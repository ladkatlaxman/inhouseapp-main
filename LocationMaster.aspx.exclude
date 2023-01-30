<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="LocationMaster.aspx.cs" Inherits="LocationMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link rel="icon" type="image/png" href="images/dexterLogo.png" />
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="AlertNotification"></div>


     <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_LocationMaster_Details" AssociatedUpdatePanelID="UpdatePanel_LocationMaster_Details" runat="server" DisplayAfter="0">
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
    <div class="panel panelTop">
        <div>
            <asp:UpdatePanel ID="UpdatePanel_LocationMaster_Details" runat="server">
                <ContentTemplate>
                    <div class="panel panelTop">
                        <div class="panel-heading panelHead">
                            <b>LOCATION MASTER DETAILS</b>
                        </div>
                    </div>


                    <div class="panel-heading panelHead labelColor">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-2 col-lg-2"></div>

                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:HiddenField ID="HiddenField_Txt_SearchPincode_Search" runat="server" Value="" />
                                    <asp:HiddenField ID="HiddenField_RadioButtonList_SearchPincode" runat="server" Value="" />
                                    <asp:Label ID="Lbl_SearchPincode" runat="server" CssClass="label labelColor">PINCODE</asp:Label>
                                    <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                    <asp:TextBox ID="Txt_SearchPincode" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" TabIndex="1" CssClass="form-control Txt_SearchPincode"></asp:TextBox>

                                    <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchPincode" runat="server" Enabled="true" TargetControlID="Txt_SearchPincode"
                                        PopupControlID="Panel_SearchPincode" OffsetY="38" OffsetX="-2">
                                    </ajaxToolkit:PopupControlExtender>

                                    <asp:Panel ID="Panel_SearchPincode" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                        BackColor="#ffffff" Style="display: none;">

                                        <div runat="server" class="ddlSearchTextBox">
                                            <asp:TextBox ID="Txt_SearchPincode_Search" runat="server" onchange="Txt_SearchPincode_Search()" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="2"
                                                AutoCompleteType="Disabled" AutoPostBack="true" Style="text-transform: uppercase;" OnTextChanged="Txt_SearchPincode_Search_TextChanged"></asp:TextBox>
                                        </div>
                                        <div runat="server" class="ddlDropDownList">
                                            <asp:RadioButtonList ID="RadioButtonList_SearchPincode" onchange="RadioButtonList_SearchPincode()" runat="server" AutoPostBack="true" TabIndex="3" OnSelectedIndexChanged="RadioButtonList_SearchPincode_SelectedIndexChanged">
                                            </asp:RadioButtonList>
                                        </div>
                                    </asp:Panel>
                                </div>
                                       <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:HiddenField ID="HiddenField_Txt_SearchCity_Search" runat="server" Value="" />
                                    <asp:HiddenField ID="HiddenField_RadioButtonList_SearchCity" runat="server" Value="" />
                                    <asp:Label ID="Lbl_SearchCity" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                    <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                    <asp:TextBox ID="Txt_SearchCity" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" TabIndex="1" CssClass="form-control Txt_SearchCity"></asp:TextBox>

                                    <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchCity" runat="server" Enabled="true" TargetControlID="Txt_SearchCity"
                                        PopupControlID="Panel_SearchCity" OffsetY="38" OffsetX="-2">
                                    </ajaxToolkit:PopupControlExtender>

                                    <asp:Panel ID="Panel_SearchCity" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                        BackColor="#ffffff" Style="display: none;">

                                        <div runat="server" class="ddlSearchTextBox">
                                            <asp:TextBox ID="Txt_SearchCity_Search" runat="server" onchange="Txt_SearchCity_Search()" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="2"
                                                AutoCompleteType="Disabled" AutoPostBack="true" Style="text-transform: uppercase;" OnTextChanged="Txt_SearchCity_Search_TextChanged"></asp:TextBox>
                                        </div>
                                        <div runat="server" class="ddlDropDownList">
                                            <asp:RadioButtonList ID="RadioButtonList_SearchCity" onchange="RadioButtonList_SearchCity()" runat="server" AutoPostBack="true" TabIndex="3" OnSelectedIndexChanged="RadioButtonList_SearchCity_SelectedIndexChanged">
                                            </asp:RadioButtonList>
                                        </div>
                                    </asp:Panel>
                                </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:HiddenField ID="HiddenField_Txt_SearchDistrict_Search" runat="server" Value="" />
                                    <asp:HiddenField ID="HiddenField_RadioButtonList_SearchDistrict" runat="server" Value="" />
                                    <asp:Label ID="Lbl_SearchDistrict" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                    <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                    <asp:TextBox ID="Txt_SearchDistrict" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" TabIndex="1" CssClass="form-control Txt_SearchDistrict"></asp:TextBox>

                                    <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchDistrict" runat="server" Enabled="true" TargetControlID="Txt_SearchDistrict"
                                        PopupControlID="Panel_SearchDistrict" OffsetY="38" OffsetX="-2">
                                    </ajaxToolkit:PopupControlExtender>

                                    <asp:Panel ID="Panel_SearchDistrict" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                        BackColor="#ffffff" Style="display: none;">

                                        <div runat="server" class="ddlSearchTextBox">
                                            <asp:TextBox ID="Txt_SearchDistrict_Search" runat="server" onchange="Txt_SearchDistrict_Search()" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="2"
                                                AutoCompleteType="Disabled" AutoPostBack="true" Style="text-transform: uppercase;" OnTextChanged="Txt_SearchDistrict_Search_TextChanged"></asp:TextBox>
                                        </div>
                                        <div runat="server" class="ddlDropDownList">
                                            <asp:RadioButtonList ID="RadioButtonList_SearchDistrict" onchange="RadioButtonList_SearchDistrict()" runat="server" AutoPostBack="true" TabIndex="3" OnSelectedIndexChanged="RadioButtonList_SearchDistrict_SelectedIndexChanged">
                                            </asp:RadioButtonList>
                                        </div>
                                    </asp:Panel>
                                </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:HiddenField ID="HiddenField_Txt_SearchState_Search" runat="server" Value="" />
                                    <asp:HiddenField ID="HiddenField_RadioButtonList_SearchState" runat="server" Value="" />
                                    <asp:Label ID="Lbl_SearchState" runat="server" CssClass="label labelColor">STATE</asp:Label>
                                    <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                    <asp:TextBox ID="Txt_SearchState" runat="server" ReadOnly="true" Style="background-color: white;" AutoCompleteType="Disabled" Text="SELECT" TabIndex="1" CssClass="form-control Txt_SearchState"></asp:TextBox>

                                    <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchState" runat="server" Enabled="true" TargetControlID="Txt_SearchState"
                                        PopupControlID="Panel_SearchState" OffsetY="38" OffsetX="-2">
                                    </ajaxToolkit:PopupControlExtender>

                                    <asp:Panel ID="Panel_SearchState" runat="server" CssClass="form-control " Height="140px" Width="87%" Direction="LeftToRight" ScrollBars="Auto"
                                        BackColor="#ffffff" Style="display: none;">

                                        <div runat="server" class="ddlSearchTextBox">
                                            <asp:TextBox ID="Txt_SearchState_Search" runat="server" onchange="Txt_SearchState_Search()" placeholder="SEARCH" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="2"
                                                AutoCompleteType="Disabled" AutoPostBack="true" Style="text-transform: uppercase;" OnTextChanged="Txt_SearchState_Search_TextChanged"></asp:TextBox>
                                        </div>
                                        <div runat="server" class="ddlDropDownList">
                                            <asp:RadioButtonList ID="RadioButtonList_SearchState" onchange="RadioButtonList_SearchState()" runat="server" AutoPostBack="true" TabIndex="3" OnSelectedIndexChanged="RadioButtonList_SearchState_SelectedIndexChanged">
                                            </asp:RadioButtonList>
                                        </div>
                                    </asp:Panel>
                                </div>

                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-5"></div>
                                <div class="col-xs-4 col-sm-5 col-md-3 col-lg-2 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <div class="form-control-sm"></div>
                                    <div class="form-control-sm"></div>
                                     <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" Value="" />
                                    <asp:LinkButton ID="Btn_Search" runat="server" OnClientClick="Btn_Search()" CssClass="btn btn-info largeButtonStyle Btn_Search" OnClick="Btn_Search_Click" TabIndex="6" Text="SEARCH">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="panel-body" id="searchLocationMaster" runat="server" visible="false">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <asp:GridView ID="gridViewLocationMaster" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewLocationMaster_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewLocationMaster_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                            <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="locID">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="locPincode" HeaderText="PINCODE" SortExpression="locPincode">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="type" HeaderText="TYPE" SortExpression="type">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header  gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>                                                                       
                                        <asp:BoundField DataField="BranchPinCode" HeaderText="BRANCH PINCODE" SortExpression="BranchPinCode">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                          <asp:BoundField DataField="branchName" HeaderText="BRANCH" SortExpression="branchName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                          <asp:BoundField DataField="distance" HeaderText="DISTANCE" SortExpression="distance">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                          <asp:BoundField DataField="cityID">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="cityName" HeaderText="CITY" SortExpression="cityName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                          <asp:BoundField DataField="districtID">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hiddengvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle"  Wrap="false" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="districtName" HeaderText="DISTRICT" SortExpression="districtName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                         <asp:BoundField DataField="stateID">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="stateName" HeaderText="STATE" SortExpression="stateName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                    </Columns>

                                    <HeaderStyle HorizontalAlign="Center" />

                                </asp:GridView>

                                <asp:GridView ID="GV_Export" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" Visible="false">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                            <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="locPincode" HeaderText="PINCODE" SortExpression="locPincode">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="type" HeaderText="TYPE" SortExpression="type">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>                                                                       
                                        <asp:BoundField DataField="BranchPinCode" HeaderText="BRANCH PINCODE" SortExpression="BranchPinCode">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="branchName" HeaderText="BRANCH" SortExpression="branchName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="distance" HeaderText="DISTANCE" SortExpression="distance">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>                                        
                                          <asp:BoundField DataField="cityName" HeaderText="CITY" SortExpression="cityName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>                                         
                                         <asp:BoundField DataField="districtName" HeaderText="DISTRICT" SortExpression="districtName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>                                       
                                          <asp:BoundField DataField="stateName" HeaderText="STATE" SortExpression="stateName">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                        </asp:BoundField>
                                    </Columns>

                                    <HeaderStyle HorizontalAlign="Center" />

                                </asp:GridView>
                            </div>
                        </div>
                        <div id="printPage">
                            <div class="form-group">
                                <div class="row">
                                    <div class=" col-sm-10 col-md-10 col-lg-10"></div>
                                    <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                        <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" Text="Export To Excel" TabIndex="7" ImageUrl="images/excel.png" OnClick="btn_ExporttoExcel_Click" ToolTip="Export To Excel"></asp:ImageButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchPincode" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchPincode_Search" EventName="TextChanged" />
                     <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchCity" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchCity_Search" EventName="TextChanged" />
                     <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchDistrict" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchDistrict_Search" EventName="TextChanged" />
                     <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchState" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchState_Search" EventName="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                    <asp:PostBackTrigger ControlID="btn_ExporttoExcel" />
                </Triggers>

            </asp:UpdatePanel>
        </div>
    </div>




     <script src="Validation/vendorMonthBillView.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script>

        function Txt_SearchPincode_Search() {
            $('[id*=HiddenField_Txt_SearchPincode_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchPincode_Search]').val());
        }
        function RadioButtonList_SearchPincode() {
            $('[id*=HiddenField_RadioButtonList_SearchPincode]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchPincode]').val());
        }
        function Txt_SearchCity_Search() {
            $('[id*=HiddenField_Txt_SearchCity_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchCity_Search]').val());
        }
        function RadioButtonList_SearchCity() {
            $('[id*=HiddenField_RadioButtonList_SearchCity]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchCity]').val());
        }
        function Txt_SearchDistrict_Search() {
            $('[id*=HiddenField_Txt_SearchDistrict_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchDistrict_Search]').val());
        }
        function RadioButtonList_SearchDistrict() {
            $('[id*=HiddenField_RadioButtonList_SearchDistrict]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchDistrict]').val());
        }
        function Txt_SearchState_Search() {
            $('[id*=HiddenField_Txt_SearchState_Search]').val("1");
            console.log($('[id*=HiddenField_Txt_SearchState_Search]').val());
        }
        function RadioButtonList_SearchState() {
            $('[id*=HiddenField_RadioButtonList_SearchState]').val("1");
            console.log($('[id*=HiddenField_RadioButtonList_SearchState]').val());
        }
        function Btn_Search() {
            $('[id*=HiddenField_Btn_Search]').val("1");
            console.log($('[id*=HiddenField_Btn_Search]').val());
        }
    </script>
</asp:Content>

