<%@ Page Title="Vehicle Type Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="VehicleTypeMaster.aspx.cs" Inherits="VehicleTypeMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <script type="text/javascript">

        function pageLoad() {
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                var $target = $(e.target);
                if ($target.parent().hasClass('disabled')) {
                    return false;
                }
            });
            $(".next-step").click(function (e) {
                var $active = $('.nav-tabs li.active');
                $active.next().removeClass('disabled');
                if ($active.next().attr('id') == $('[id*=UploadDocument]').attr('id')) {
                    $('[id*=hfLastStep]').val('true');
                }
                nextTab($active);                                                                   /////////// Open if not working properly //////////////
                return false;
            });

            //$('#butEdit_CustomerDataton').submit(function () {
            //    $("#myTab").tabs({
            //        active: $("#home")
            //    });
            //});

            //$(".first-tab").click(function (e) {
            //    var $active=$('')
            //    });

            $(".prev-step").click(function (e) {
                var $active = $('.nav-tabs li.active');
                prevTab($active);
                return false;
            });


            var tabId = '';
            $('[id*=myTab] li').each(function () {
                if ($('[id*=hfTabs]').val() != '') {

                    if ($(this).attr('id') == $('[id*=hfTabs]').val()) {
                        $(this).attr('class', 'active');
                        var tabpaneId = $(this).find('a').attr('href').split('#')[1];
                        $('.tab-pane').each(function () {
                            if ($(this).attr('id') == tabpaneId) {
                                $(this).attr('class', 'tab-pane active');
                            }
                            else {
                                $(this).attr('class', 'tab-pane');
                            }
                        });
                    }
                    else {
                        if ($('[id*=UploadDocument]').attr('id') == $(this).attr('id')) {
                            if ($('[id*=hfLastStep]').val() == 'true') {
                                $(this).attr('class', '');
                            }
                        } else {
                            $(this).attr('class', '');
                        }
                    }
                }
            });

            $('.maintainTab').click(function () {
                $('[id*=hfTabs]').val($(this).closest('li').attr('id'));

            });
        }

        function nextTab(elem) {
            $(elem).next().find('a[data-toggle="tab"]').click();
            $('[id*=hfTabs]').val($(elem).next().attr('id'));

        }
        function prevTab(elem) {
            $(elem).prev().find('a[data-toggle="tab"]').click();
            $('[id*=hfTabs]').val($(elem).prev().attr('id'));
        }
    </script>

    <link href="css/AlertNotification.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>

        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Item_Details" AssociatedUpdatePanelID="UpdatePanel_Item_Details" runat="server" DisplayAfter="0">
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
      <%--  <asp:UpdateProgress ID="UpdateProgress_ViewDetails" AssociatedUpdatePanelID="UpdatePanel_ViewDetails" runat="server" DisplayAfter="0">
            <ProgressTemplate>
                <div id="overlay">
                    <div id="modalprogress">
                        <div id="theprogress">
                            <img src="images/dots-4.gif" />
                        </div>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>--%>

        <!---Update Progress 3 ---->
        <asp:UpdateProgress ID="UpdateProgress_GridView" AssociatedUpdatePanelID="UpdatePanel_GridView" runat="server" DisplayAfter="0">
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
            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#VehicleTypeMaster" class="nav-link active tabfont">VEHICLE TYPE MASTER</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" tabindex="4" href="#ViewDetails" class="nav-link tabfont">VIEW</a>
                </li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <div id="AlertNotification"></div>

                <!--=========================================================================VEHICLE TYPE MASTER==========================================================================-->
                <div id="VehicleTypeMaster" class="tab-pane active">
                    <div>
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>VEHICLE TYPE</b>
                                <div style="text-align: right" runat="server" id="dateTime" visible="false">
                                    <asp:Label ID="Lbl_CurrentDateTime" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel_Item_Details" runat="server">
                                            <ContentTemplate>
                                                <div class="form-group">
                                                    <asp:HiddenField ID="hfmaterialID" runat="server" />
                                                    <div class="row">
                                                        <div class="col-sm-0 col-md-0 col-lg-4 "></div>
                                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                            <div class="form-control-sm"></div>
                                                            <asp:Label ID="Lbl_VehicleTypeName" runat="server" CssClass="label labelColor">VEHICLE TYPE NAME</asp:Label><span class="required">*</span>
                                                            <asp:TextBox ID="Txt_VehicleTypeName" runat="server" Style="text-transform: uppercase" AutoComplete="off" CssClass="form-control input-sm Txt_VehicleTypeName FirstNoSpaceAndZero" onkeypress="return checkAlphaNumericWithDash()" TabIndex="1"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                        <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Submit" ID="Button_Submit1" runat="server" Text="SUBMIT" UseSubmitBehavior="false" OnClientClick="if (!validateVehicleTypeDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="2" OnClick="Button_Submit1_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                            <div class="form-control-sm"></div>
                                                            <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Reset" runat="server" Text="RESET" TabIndex="3" OnClick="Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="Reset" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--================================================================End VEHICLE TYPE MASTER===================================================================-->
                <!--=============================================== Searching Parameters============================================-->
                <div id="ViewDetails" class="tab-pane">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel_GridView" runat="server">
                            <ContentTemplate>
                                <div class="panel panelTop" runat="server">
                                    <div class="panel-heading panelView">

                                        <%--             <div>
                                            <asp:UpdatePanel ID="UpdatePanel_ViewDetails" runat="server">
                                                <ContentTemplate>

                                                    <div class="form-group">
                                                        <div class="row">
                                                            <asp:HiddenField ID="hfBranchID" runat="server" />
                                                            <div class="col-sm-0 col-md-0 col-lg-3 "></div>
                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <asp:Label ID="Lbl_SearchVehicleTypeName" runat="server" CssClass="label labelColor">VEHICLE TYPE NAME</asp:Label>

                                                                <!----DropDown Start----->
                                                                <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                                <asp:TextBox ID="Txt_SearchVehicleTypeName" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" CssClass="form-control Txt_PinCode" Text="SELECT" TabIndex="5"></asp:TextBox>

                                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchVehicleTypeName" runat="server" Enabled="true" TargetControlID="Txt_SearchVehicleTypeName"
                                                                    PopupControlID="Panel_SearchVehicleTypeName" OffsetY="38" OffsetX="-2">
                                                                </ajaxToolkit:PopupControlExtender>

                                                                <asp:Panel ID="Panel_SearchVehicleTypeName" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto"
                                                                    BackColor="#ffffff" Style="display: none;">

                                                                    <div runat="server" class="ddlSearchTextBoxInherit">

                                                                        <asp:TextBox ID="Txt_SearchVehicleTypeName_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="6"
                                                                            AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_SearchVehicleTypeName_Search_TextChanged" onkeypress="return checkAlphaNumericWithDash()"></asp:TextBox>
                                                                    </div>

                                                                    <div runat="server" class="ddlDropDownListInherit">
                                                                        <asp:RadioButtonList ID="RadioButtonList_SearchVehicleTypeName" runat="server" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_SearchVehicleTypeName_SelectedIndexChanged" TabIndex="7">
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </asp:Panel>
                                                                <!----DropDown End----->
                                                                <%--<asp:DropDownList ID="Ddl_SearchItemName" runat="server" CssClass="form-control selectpicker Ddl_DLSNo" data-show-subtext="true" data-live-search="true" TabIndex="4">
                                    <asp:ListItem>Select... </asp:ListItem>
                                </asp:DropDownList>--%
                                                            </div>

                                                            <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                                <div class="form-control-sm"></div>
                                                                <div class="form-control-sm"></div>
                                                                <div class="form-control-sm"></div>
                                                                <asp:LinkButton CssClass="btn btn-info largeButtonStyle" ID="Btn_Search" runat="server" Text="SEARCH" OnClick="Btn_Search_Click" TabIndex="8">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </ContentTemplate>

                                            </asp:UpdatePanel>
                                        </div>
                                        --%>
                                    </div>

                                    <div class="panel-body" id="ViewData" runat="server" visible="true">

                                        <div class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <asp:GridView ID="GV_VehicleType" runat="server" DataKeyNames="vehicleTypeID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowPaging="true" OnPageIndexChanging="gridViewVehicleType_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                    <%--AllowSorting="true" OnSorting="gridViewVehicleType_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewVehicleType_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast"--%>
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ACTION">
                                                            <ItemTemplate>
                                                                
                                                                  <asp:LinkButton ID="editViewVehicleType" runat="server" OnClick="editViewVehicleType_Click" CommandArgument='<%#Eval("vehicleTypeID") %>' ToolTip="Edit"><i style="font-size: 18px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                               
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="vehicleTypeID" HeaderText="VEHICLETYPE ID" SortExpression="vehicleTypeID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="vehicleType" HeaderText="VEHICLE TYPE" SortExpression="vehicleType">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>
                                                       <%-- <asp:BoundField DataField="branchName" HeaderText="USER BRANCH" SortExpression="branchName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>--%>
                                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                        </asp:BoundField>

                                                    </Columns>
                                                </asp:GridView>

                                                <asp:GridView ID="GV_Export" runat="server" DataKeyNames="vehicleTypeID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">
                                                    <Columns>
                                                        <asp:BoundField DataField="vehicleType" HeaderText="VEHICLE TYPE" SortExpression="vehicleType">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="fullName" HeaderText="USER NAME" SortExpression="fullName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                      <%--  <asp:BoundField DataField="branchName" HeaderText="USER BRANCH" SortExpression="branchName">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>--%>
                                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATETIME" SortExpression="creationDateTime">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div id="printPage">
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-10 col-md-10 col-lg-10"></div>
                                                    <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" OnClick="btn_ExporttoExcel_Click" Text="Export To Excel" TabIndex="9" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                    </div>
                                                    <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                        <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="Print" TabIndex="10" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                            <Triggers>
<%--                                <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />--%>
                                <%--<asp:AsyncPostBackTrigger ControlID="lnkdelete" EventName="Click"/>--%>
                                <%--<asp:PostBackTrigger ControlID="Btn_Search" />--%>
                                <asp:PostBackTrigger ControlID="btn_ExporttoExcel" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <!--=============================================== End Item Details============================================-->

                </div>
            </div>
        </div>
    </div>
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->

    <script src="Validation/Val_VehicleTypeMaster.js"></script>

    <script src="js/AlertNotifictaion.js"></script>

</asp:Content>

