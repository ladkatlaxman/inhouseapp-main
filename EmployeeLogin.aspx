<%@ Page Title="Employee Login" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="EmployeeLogin.aspx.cs" Inherits="EmployeeLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <script type="text/javascript">
        $(function () {
            $("[id*=treeViewAccessPage] input[type=checkbox]").bind("click", function () {
                var table = $(this).closest("table");
                if (table.next().length > 0 && table.next()[0].tagName == "DIV") {
                    //Is Parent CheckBox
                    var childDiv = table.next();
                    var isChecked = $(this).is(":checked");
                    $("input[type=checkbox]", childDiv).each(function () {
                        if (isChecked) {
                            $(this).attr("checked", "checked");
                        } else {
                            $(this).removeAttr("checked");
                        }
                    });
                } else {
                    //Is Child CheckBox
                    var parentDIV = $(this).closest("DIV");
                    if ($("input[type=checkbox]", parentDIV).length == $("input[type=checkbox]:checked", parentDIV).length) {
                        $("input[type=checkbox]", parentDIV.prev()).attr("checked", "checked");
                    } else {
                        $("input[type=checkbox]", parentDIV.prev()).removeAttr("checked");
                    }
                }
            });
        })
    </script>
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />

        <!---Update Progress 2 ---->
        <asp:UpdateProgress ID="UpdateProgress_EmployeeLogin" AssociatedUpdatePanelID="UpdatePanel_EmployeeLogin" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_UserAccess" AssociatedUpdatePanelID="UpdatePanel_UserAccess" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_BranchAccess" AssociatedUpdatePanelID="UpdatePanel_BranchAccess" runat="server" DisplayAfter="0">
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
                    <a data-toggle="tab" href="#CreateUserAccess" class="nav-link active tabfont">CREATE NEW LOGIN & ACCESS RIGHTS</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#ChangesUserAccess" class="nav-link tabfont">CHANGES IN ACCESS RIGHTS</a>
                </li>
                <li class="nav-item">
                    <a data-toggle="tab" href="#BranchAccess" class="nav-link tabfont">BRANCH ACCESS</a>
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
                <!--==============================================Start New User Information=======================================================================-->
                <div id="CreateUserAccess" class="tab-pane active">
                    <asp:UpdatePanel ID="UpdatePanel_EmployeeLogin" runat="server">
                        <ContentTemplate>
                            <div class="panel panelTop">
                                <div class="panel-heading panelHead">
                                    <b>LOGIN DETAILS</b>
                                </div>

                                <div class="panel-body labelColor">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="hfEmployeeNo" runat="server" />
                                                    <asp:Label ID="Lbl_EmployeeName" runat="server" CssClass="label labelColor">EMPLOYEE NAME</asp:Label><span class="required">*</span>
                                                    <asp:DropDownList ID="Ddl_EmployeeName" runat="server" CssClass="formDisplay Ddl_EmployeeName" TabIndex="1">
                                                        <asp:ListItem Selected="True">SELECT</asp:ListItem>
                                                        <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_EmpUserName" runat="server" CssClass="label labelColor">USER NAME</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_EmpUserName" AutoComplete="off" runat="server" TabIndex="2" class="form-control input-sm Txt_EmpUserName" onkeypress="return checkUserName()" ToolTip="Eg: mohan.jadav" Placeholder="Eg: mohan.jadav"></asp:TextBox>
                                                </div>

                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_EmpPassword" runat="server" CssClass="label labelColor">PASSWORD</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_EmpPassword" AutoComplete="off" runat="server" TabIndex="3" class="form-control input-sm Txt_EmpPassword"></asp:TextBox>
                                                    <%-- <span id="password_strength"></span>--%>
                                                </div>

                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_EmpConfirmPassword" runat="server" CssClass="label labelColor">CONFIRM PASSWORD</asp:Label><span class="required">*</span>
                                                    <asp:TextBox ID="Txt_EmpConfirmPassword" runat="server" AutoComplete="off" TabIndex="4" class="form-control input-sm Txt_EmpConfirmPassword"></asp:TextBox>
                                                    <p id="validate-status"></p>
                                                </div>

                                            </div>
                                        </div>
                                        <%-- Tree View Of Forms To Assign Users --%>
                                        <div class="panel-heading panelHead">
                                            <b>ACCESS RIGHTS</b>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:TreeView runat="server" ID="treeViewAccessPage" ShowCheckBoxes="All"></asp:TreeView>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton ID="Btn_LoginDetailsSave" TabIndex="5" runat="server" UseSubmitBehavior="false" OnClientClick="if (!validateEmployeeLoginDetails()) {return false;};" OnClick="Btn_LoginDetailsSave_Click" class="btn btn-info largeButtonStyle Btn_LoginDetailsSave" Text="SAVE">SAVE&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                </div>
                                                <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                    <div class="form-control-sm"></div>
                                                    <asp:LinkButton CssClass="btn btn-info largeButtonStyle" TabIndex="6" ID="Btn_Reset" runat="server" OnClick="Btn_Reset_Click" Text="RESET">RESET&nbsp;&nbsp;<i class="fa fa-refresh "></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-heading panelHead">
                                    <b>SEARCH EMPLOYEE DETAILS</b>
                                </div>
                                <div class="panel-body labelColor">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-0 col-md-0 col-lg-2 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_SearchEmployeeCode" runat="server" CssClass="label labelColor">EMPLOYEE NAME</asp:Label>
                                                    <asp:DropDownList ID="Ddl_SearchEmployeeName" runat="server" CssClass="formDisplay  Ddl_SearchEmployeeName">
                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                        <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:Button ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle" Text="SEARCH" OnClick="Btn_Search_Click"></asp:Button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group" id="Search_EmployeeLogin_View" runat="server">
                                            <asp:GridView ID="gridViewEmployeeLogin" runat="server" DataKeyNames="userID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowSorting="true" OnSorting="gridViewEmployeeLogin_Sorting" AllowPaging="true" OnPageIndexChanging="gridViewEmployeeLogin_PageIndexChanging" Pazesize="10" PagerSettings-Mode="NumericFirstLast">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="ACTION">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="editEmployeeLogin" runat="server"  OnClick="editEmployeeLogin_Click" CommandArgument='<%#Eval("userID") %>'>INACTIVE</asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="userID" HeaderText="USER ID" SortExpression="userID">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="hidden gvItemStyle" Wrap="false" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fullName" HeaderText="EMPLOYEE NAME" SortExpression="fullName">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="username" HeaderText="USERNAME" SortExpression="joiningDate">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="password" HeaderText="PASSWORD" SortExpression="belongToBranch">
                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <!--==============================================End New User Information=======================================================================-->
                <!--==============================================Start Change User Access Information=======================================================================-->
                <div id="ChangesUserAccess" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel_UserAccess" runat="server">
                        <ContentTemplate>
                            <div class="panel panelTop">
                                <div class="panel-heading panelHead">
                                    <b>ADD & REMOVE USER ACCESS</b>
                                </div>
                                <div class="panel-body labelColor">
                                    <div class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_UserName" runat="server" CssClass="label labelColor">EMPLOYEE NAME</asp:Label>
                                                    <asp:DropDownList ID="Ddl_UserName" runat="server" CssClass="formDisplay Ddl_UserName" TabIndex="1">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_AccessPage" runat="server" CssClass="label labelColor">ACCESS PAGE</asp:Label>
                                                    <asp:DropDownList ID="Ddl_AccessPage" runat="server" CssClass="formDisplay Ddl_AccessPage" TabIndex="2">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-lg"></div>
                                                    <div class="form-control-lg"></div>
                                                    <asp:LinkButton ID="Btn_ViewAccess" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_ViewAccess_Click">VIEW</asp:LinkButton>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-lg"></div>
                                                    <div class="form-control-lg"></div>
                                                    <asp:LinkButton ID="Btn_AddAccess" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_AddAccess_Click">ADD</asp:LinkButton>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                <asp:GridView ID="GV_UserAccessDetails" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false" OnRowCommand="GV_UserAccessDetails_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="SR.NO">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex+1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="userID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass=" hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AccessId">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass=" hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AccessName" HeaderText="ACCESS PAGE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AccessMenuName" HeaderText="ACCESS MENU">
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" />
                                                            <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="REMOVE ACCESS">
                                                            <ItemTemplate>
                                                                <asp:Table ID="Table" runat="server">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell>
                                                                            <asp:LinkButton ID="Remove" runat="server" CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this access?');" CommandArgument='<%# Container.DataItemIndex %>'>REMOVE</asp:LinkButton>
                                                                        </asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:Table>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
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
                <!--==============================================End Change User Access Information=======================================================================-->
                <!--==============================================Start Branch Access Information=======================================================================-->
                <div id="BranchAccess" class="tab-pane">
                    <asp:UpdatePanel ID="UpdatePanel_BranchAccess" runat="server">
                        <ContentTemplate>
                             <div class="panel panelTop">
                                 <div class="panel-heading panelHead">
                                    <b>ADD & REMOVE BRANCH ACCESS</b>
                                </div>
                                 <div class="panel-body labelColor">
                                      <div class="form-horizontal" role="form">
                                           <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_EmpBranch" runat="server" CssClass="label labelColor">EMPLOYEE NAME</asp:Label>
                                                    <asp:DropDownList ID="Ddl_EmpBranch" runat="server" CssClass="formDisplay Ddl_EmpBranch" TabIndex="1">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_AccessBranch" runat="server" CssClass="label labelColor">ACCESS BRANCH</asp:Label>
                                                    <asp:DropDownList ID="Ddl_AccessBranch" runat="server" CssClass="formDisplay Ddl_AccessBranch" TabIndex="2">
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-lg"></div>
                                                    <div class="form-control-lg"></div>
                                                    <asp:LinkButton ID="Btn_ViewBranch" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_ViewBranch_Click">VIEW</asp:LinkButton>
                                                </div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-1 ">
                                                    <div class="form-control-sm"></div>
                                                    <div class="form-control-lg"></div>
                                                    <div class="form-control-lg"></div>
                                                    <asp:LinkButton ID="Btn_AddBranch" runat="server" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_AddBranch_Click">ADD</asp:LinkButton>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 "></div>
                                                <asp:GridView ID="GV_BranchAccess" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false" OnRowCommand="GV_BranchAccess_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="SR.NO">
                                                            <ItemTemplate>
                                                                <%#Container.DataItemIndex+1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="UserID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass=" hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="branchID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass=" hidden gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="branchName" HeaderText="BRANCH">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="REMOVE BRANCH">
                                                            <ItemTemplate>
                                                                <asp:Table ID="Table" runat="server">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell>
                                                                            <asp:LinkButton ID="Remove" runat="server" CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this access?');" CommandArgument='<%# Container.DataItemIndex %>'>REMOVE</asp:LinkButton>
                                                                        </asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:Table>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                        </asp:TemplateField>
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
                <!--==============================================Start Branch Access Information=======================================================================-->
            </div>
        </div>
    </div>



    <script src="Validation/Val_HR_EmployeeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script type="text/javascript">
        function CheckPasswordStrength(password) {
            var password_strength = document.getElementById("password_strength");

            //TextBox left blank.
            if (password.length == 0) {
                password_strength.innerHTML = "";
                return;
            }

            //Regular Expressions.
            var regex = new Array();
            regex.push("[A-Z]"); //Uppercase Alphabet.
            regex.push("[a-z]"); //Lowercase Alphabet.
            regex.push("[0-9]"); //Digit.
            regex.push("[@_]"); //Special Character.

            var passed = 0;

            //Validate for each Regular Expression.
            for (var i = 0; i < regex.length; i++) {
                if (new RegExp(regex[i]).test(password)) {
                    passed++;
                }
            }

            //Validate for length of Password.
            if (passed > 2 && password.length > 8) {
                passed++;
            }

            //Display status.
            var color = "";
            var strength = "";
            switch (passed) {
                case 0:
                case 1:
                    strength = "Weak Password";
                    color = "red";
                    break;
                case 2:
                    strength = "Good Password";
                    color = "darkorange";
                    break;
                case 3:
                case 4:
                    strength = "Strong Password";
                    color = "green";
                    break;
                case 5:
                    strength = "Very Strong Password";
                    color = "darkgreen";
                    break;
            }
            password_strength.innerHTML = strength;
            password_strength.style.color = color;
        }


    </script>

</asp:Content>

