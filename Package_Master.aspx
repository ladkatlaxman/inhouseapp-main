<%@ Page Title="Package Creation" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="Package_Master.aspx.cs" Inherits="OPERATIONS_PackageMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

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

    <style type="text/css">
    .ajax__fileupload_dropzone {
        display:none;
    } 
    </style>

    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
         <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
    
        <!---Update Progress 1 ---->
        <asp:UpdateProgress ID="UpdateProgress_Package_Details" AssociatedUpdatePanelID="UpdatePanel_Package_Details" runat="server" DisplayAfter="0">
            <ProgressTemplate><div id="overlay"><div id="modalprogress"><div id="theprogress"><img src="images/dots-4.gif" /></div></div></div></ProgressTemplate>
        </asp:UpdateProgress>

         <!---Update Progress 2 ---->
        <asp:UpdateProgress ID="UpdateProgress_ViewDetails" AssociatedUpdatePanelID="UpdatePanel_ViewDetails" runat="server" DisplayAfter="0">
            <ProgressTemplate><div id="overlay"><div id="modalprogress"><div id="theprogress"><img src="images/dots-4.gif" /></div></div></div></ProgressTemplate>
        </asp:UpdateProgress>

        <!---Update Progress 3 ---->
        <asp:UpdateProgress ID="UpdateProgress_GridView" AssociatedUpdatePanelID="UpdatePanel_GridView" runat="server" DisplayAfter="0">
            <ProgressTemplate><div id="overlay"><div id="modalprogress"><div id="theprogress"><img src="images/dots-4.gif" /></div></div></div></ProgressTemplate>
        </asp:UpdateProgress>



     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
    <ul class="nav nav-tabs" id="myTab">
        <li class="nav-item">
            <a data-toggle="tab" href="#PackageDetails" class="nav-link active tabfont">PACKAGE DETAILS</a>
        </li>
        <li class="nav-item">
            <a data-toggle="tab" tabindex="4" href="#ViewDetails" class="nav-link tabfont">VIEW</a>
        </li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
        <div id="AlertNotification"></div>
        <!--=========================================================================Package Details==========================================================================-->
        <div id="PackageDetails" class="tab-pane active">
            <div>
                <div class="panel panelTop">
                    <div class="panel-heading panelHead">
                        <b>PACKAGE DETAILS</b>
                         <div style="text-align:right" runat="server" id="dateTime" visible="false"> <asp:Label ID="Lbl_CurrentDateTime" runat="server"></asp:Label></div>
                    </div>
                    <div class="panel-body labelColor">
                        <div class="form-horizontal" role="form">

                            <div>
                                <asp:UpdatePanel ID="UpdatePanel_Package_Details" runat="server">
                                    <ContentTemplate>

                            <div class="form-group">
                                <asp:HiddenField ID="hfpackageID" runat="server" />
                                <div class="row">
                                    
                                     <div class="col-sm-0 col-md-0 col-lg-4 "></div>
                                     <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                        <div class="form-control-sm"></div>
                                        <asp:Label ID="Lbl_TypeOfPackage" runat="server" CssClass="label labelColor">TYPE OF PACKAGE</asp:Label><span class="required">*</span>
                                        <asp:TextBox ID="Txt_TypeOfPackage" runat="server" AutoComplete="off" style="text-transform:uppercase" CssClass="form-control input-sm Txt_TypeOfPackage FirstNoSpaceAndZero" onkeypress="return checkAlphaNumericWithDotAndDash()" TabIndex="1"></asp:TextBox>
                                    </div>
                                </div>

                                 </div>
                                 <div class="form-group">
                       
                                  <div class="row">
                                   <div class=" col-sm-1 col-md-3 col-lg-4"></div>

                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                        <div class="form-control-sm"></div>
                                          <asp:linkbutton CssClass="btn btn-info largeButtonStyle Btn_Submit" ID="Button_Submit1" runat="server" Text="SUBMIT" UseSubmitBehavior="false" OnClick="Button_Submit1_Click" OnClientClick="if (!validatePackageDetails()) {return false;} else{ __doPostBack('this.name','');};" TabIndex="2">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:linkbutton>
                                    </div>
                        
                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                        <div class="form-control-sm"></div>                                       
                                        <asp:Linkbutton CssClass="btn btn-info largeButtonStyle" ID="Reset" runat="server" Text="RESET" TabIndex="3" OnClick="Reset_Click">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:Linkbutton>
                                    </div>
                           
                                
                            </div>
                    </div>
                           
                                        
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="Button_Submit1" EventName="Click"/>
                                        <asp:AsyncPostBackTrigger ControlID="Reset" EventName="Click"/>
                                    </Triggers>
                                </asp:UpdatePanel>
                                </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!--==========================================================End Package Details========================================================================================-->
        <!--=============================================== Searching Parameters============================================-->
        <div id="ViewDetails" class="tab-pane">
            <div>


                <div>
                            <asp:UpdatePanel ID="UpdatePanel_GridView" runat="server">
                                <ContentTemplate>
                               
                <div class="panel panelTop" runat="server">
                    <div class="panel-heading panelView">

                        <div>
                            <asp:UpdatePanel ID="UpdatePanel_ViewDetails" runat="server">
                                <ContentTemplate>

                        <div class="form-group">
                            <div class="row">
                                
                                <div class="col-sm-0 col-md-3 col-lg-4 "></div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_SearchTypeOFPackage" runat="server" CssClass="label labelColor">TYPE OF PACKAGE</asp:Label>

                                     <!----DropDown Start----->
                                                <img src="images/5-5.png" style="position: absolute; margin-top: 35px; right: 10%; z-index: 1;" />
                                                <asp:TextBox ID="Txt_SearchTypeOFPackage" runat="server" Style="background-color: white" ReadOnly="true" AutoCompleteType="Disabled" placeholder="SELECT" CssClass="form-control Txt_PinCode" Text="SELECT" TabIndex="5"></asp:TextBox>

                                                <ajaxToolkit:PopupControlExtender ID="PopupControlExtender_SearchTypeOFPackage" runat="server" Enabled="true" TargetControlID="Txt_SearchTypeOFPackage"
                                                    PopupControlID="Panel_SearchTypeOFPackage" OffsetY="38" OffsetX="-2">
                                                </ajaxToolkit:PopupControlExtender>

                                                <asp:Panel ID="Panel_SearchTypeOFPackage" runat="server" CssClass="form-control" Height="140px" Width="90%" Direction="LeftToRight" ScrollBars="Auto"
                                                    BackColor="#ffffff" Style="display: none;">

                                                    <div runat="server" class="ddlSearchTextBoxInherit">

                                                        <asp:TextBox ID="Txt_SearchTypeOFPackage_Search" runat="server" placeholder="Search" Style="text-transform: uppercase" CssClass="form-control input-sm txtSearchSingleDropDown FirstNoSpaceAndZero" TabIndex="6"
                                                            AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="Txt_SearchTypeOFPackage_Search_TextChanged" onkeypress="return checkAlphaNumericWithDotAndDash()" ></asp:TextBox>
                                                    </div>

                                                    <div runat="server" class="ddlDropDownListInherit">
                                                        <asp:RadioButtonList ID="RadioButtonList_SearchTypeOFPackage" runat="server" Style="font-size: 12px;" AutoPostBack="true" OnSelectedIndexChanged="RadioButtonList_SearchTypeOFPackage_SelectedIndexChanged" TabIndex="7">
                                                        </asp:RadioButtonList>                                                                                                                              
                                                    </div>
                                                </asp:Panel>
                                    <%--<asp:DropDownList ID="Ddl_SearchTypeOFPackage" runat="server" CssClass="form-control selectpicker" data-live-search="true"  TabIndex="4">
                                        <asp:ListItem Text="startwith">Select...</asp:ListItem>
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>--%>
                                </div>

                                 <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                     <div class="form-control-sm"></div>
                                     <div class="form-control-sm"></div>
                                    <asp:Button CssClass="btn btn-info largeButtonStyle" ID="Btn_Search" OnClick="Btn_Search_Click" runat="server" Text="SEARCH" TabIndex="8"></asp:Button>
                                </div>

                            </div>
                        </div>
                                    
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="RadioButtonList_SearchTypeOFPackage" EventName="SelectedIndexChanged"/>
                                    <asp:AsyncPostBackTrigger ControlID="Txt_SearchTypeOFPackage_Search" EventName="TextChanged"/>
                                    <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click"/>
                                </Triggers>                              
                            </asp:UpdatePanel>
                        </div>

                    </div>

                    <div class="panel-body" id="Search_PackageDetails_View" runat="server">

                       

                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                
                                 <asp:GridView ID="gridViewPackage" runat="server" DataKeyNames="packID" AutoGenerateColumns="False"  CssClass="table table-striped table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewPackage_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewPackage_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                        <Columns>
                                             <asp:TemplateField HeaderText="ACTION">
                                                <ItemTemplate>
                                                   
                                                              <asp:LinkButton ID="editBranchDetails" runat="server" OnClick="editBranchDetails_Click" CommandArgument='<%#Eval("packID") %>' ToolTip="Edit"><i style="font-size: 18px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                               
                                                                <span onclick="return confirm('Are you sure you want to delete this record')">
                                                                <asp:LinkButton ID="Delete_Data1" runat="server" OnClick="Delete_Data1_Click" ToolTip="Delete"><i style="font-size: 18px; color:red" class="fa fa-trash"></i></asp:LinkButton>
                                                            
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                <ItemStyle  HorizontalAlign="Center" CssClass="gvItemStyle"/>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="typeOfPackage" HeaderText="TYPE OF PACKAGE" SortExpression="typeOfPackage">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false"/>
                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" Visible="false" SortExpression="employeeNo">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="username" HeaderText="USERNAME" SortExpression="username">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                        </asp:BoundField>
                                            
                                        </Columns>

                                       

                                    </asp:GridView>


                                 <asp:GridView ID="GV_Export" runat="server" DataKeyNames="packID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive" Visible="false">
                                        <Columns>
                                             
                                            <asp:BoundField DataField="typeOfPackage" HeaderText="TYPE OF PACKAGE" >
                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false"/>
                                                <ItemStyle HorizontalAlign="Center" Wrap="false"/>
                                            </asp:BoundField>
                                            <%--<asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" SortExpression="employeeNo">
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false"/>
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="username" HeaderText="USERNAME" >
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" >
                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                            <ItemStyle HorizontalAlign="Center" Wrap="false"/>
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


                    <!--=============================================== End Package Details============================================-->
                </div>

                 </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btn_ExporttoExcel"/>
                                </Triggers>
                            </asp:UpdatePanel>
                          </div>


            </div>
        </div>
    </div>
    
        </div>
    </div>
     <!--Footer-->
        <footer class="footer" id="footer" style="position:inherit ">
            <p >Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
        </footer>
        <!--End-->


    <script src="Validation/Val_PackageMaster.js"></script>

    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

