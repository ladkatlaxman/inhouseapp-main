<%@ Page Title="Route Master" Language="C#" MasterPageFile="AdminMasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="RouteMaster.aspx.cs" Inherits="RouteMaster" %>

<%@ Register Src="~/RouteMaster.ascx" TagPrefix="uc" TagName="Route" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="shortcut icon" href="images/dexterLogo.png" />
    <link href="css/AlertNotification.css" rel="stylesheet" />
     <%-- <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.6.2.js"></script>--%>
    <script src="js/jquery/jquery-1.6.2.js"></script>

    <%--    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:HiddenField ID="hfTabs" Value="" runat="server" />
        <asp:HiddenField ID="hfLastStep" Value="" runat="server" />
        <script>
            function YourFunction(id) {
                console.log(id);
                $.ajax({
                    url: 'RouteMaster.aspx/GetRouteHeaderData',
                    data: "{ 'routeId': '" + id + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        $.each(data, function (index, item) {
                            $("[id*=<%=PopUp.FindControl("txtFromBranch").ClientID%>]").val(item.split('ʭ')[0]);
                            $("[id*=<%=PopUp.FindControl("hffromBranchID").ClientID%>]").val(item.split('ʭ')[1]);
                            $("[id*=<%=PopUp.FindControl("txtToBranch").ClientID%>]").val(item.split('ʭ')[2]);
                            $("[id*=<%=PopUp.FindControl("hfToBranchID").ClientID%>]").val(item.split('ʭ')[3]);
                            $("[id*=<%=PopUp.FindControl("txtRouteName").ClientID%>]").val(item.split('ʭ')[4]);
                            $("[id*=<%=PopUp.FindControl("txtTotalDistance").ClientID%>]").val(item.split('ʭ')[5]);
                            $("[id*=<%=PopUp.FindControl("txtTotalMapDistance").ClientID%>]").val(item.split('ʭ')[6]);
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });
                $.ajax({
                    url: 'RouteMaster.aspx/GetRouteDetailsData',
                    data: "{ 'routeId': '" + id + "'}",
                    type: "POST",
                    dataType: "json",
                    contentType: 'application/json',
                    success: function (response) {
                        var data = response.d;
                        var gridView = $("[id*=<%=PopUp.FindControl("GV_RouteDetail").ClientID%>]");
                        var row = gridView.find("tr")
                        row.remove();
                        $(gridView).append("<tr><th class='gvHeaderStyle'>SR.NO </th><th class='gvHeaderStyle'>FROM BRANCH</th><th class='gvHeaderStyle'>TO BRANCH </th><th class='gvHeaderStyle'>DISTANCE</th><th class='gvHeaderStyle'>MAP DISTANCE</th></tr>");
                        Index = 0;
                        $.each(data, function (index, item) {
                            console.log("loop");

                            Index = Index + 1;
                           $(gridView).append("<tr><td class='gvItemStyle'>" + Index + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[0] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[2] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[4] + "</td>" +
                                                    "<td class='gvItemStyle'>" + item.split('ʭ')[5] + "</td>" +
                                               "</tr>");
                        });
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(xhr.status);
                        alert(thrownError);
                    }
                });
                $("[id*=<%=PopUp.FindControl("txtFromBranch").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("txtToBranch").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("txtRouteName").ClientID%>]").attr("disabled", "disabled");
                $("[id*=<%=PopUp.FindControl("HideShowData").ClientID%>]").hide();
            }
        </script>
        <!---Update Progress 1 ---->
        <%--<asp:UpdateProgress ID="UpdateProgress_RouteSubmit" AssociatedUpdatePanelID="UpdatePanel_RouteSubmit" runat="server" DisplayAfter="0">
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
        <!---Update Progress 2 ---->
        <%--  <asp:UpdateProgress ID="UpdateProgress_RouteSchedule" AssociatedUpdatePanelID="UpdatePanel_RouteSchedule" runat="server" DisplayAfter="0">
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
        <asp:UpdateProgress ID="UpdateProgress_View" AssociatedUpdatePanelID="UpdatePanel_View" runat="server" DisplayAfter="0">
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
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <ul class="nav nav-tabs" id="myTab">
                <li class="nav-item">
                    <a data-toggle="tab" href="#RouteDetails" class="nav-link active tabfont">ROUTE DETAILS</a>
                </li>
                <%-- <li>
                    <a data-toggle="tab" href="#RouteSchedule">ROUTE SCHEDULE</a>
                </li>--%>
                <li class="nav-item">
                    <a data-toggle="tab" href="#ViewDetails" class="nav-link tabfont">VIEW</a>
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
                <div id="AlertNotification" runat="server"></div>
                <!--=========================================================================Route Details==========================================================================-->
                <div id="RouteDetails" class="tab-pane active">
                    <div>
                        <div class="panel panelTop">
                            <uc:Route ID="Route" runat="server" />
                            <%--  <div class="panel-heading panelHead">
                                <b>ROUTE DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <asp:UpdatePanel ID="UpdatePanel_RouteMasterDetail" runat="server">
                                        <ContentTemplate>
                                            <div class="form-group">
                                                <div class="row">
                                                    <asp:HiddenField ID="AutoIncementNo" runat="server" />
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="lblFromBranch" runat="server" CssClass="label labelColor">FROM BRANCH</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtFromBranch" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm txtFromBranch FirstNoSpaceAndZero" onchange="ReadDataonchange('txtFromBranch','hffromBranchID','txtFromBranch','txtToBranch','txtTotalMapDistance','ReadData','RouteMaster.aspx/GetBranch');" TabIndex="2"></asp:TextBox>
                                                        <asp:HiddenField ID="hffromBranchID" runat="server" />
                                                    </div>
                                                    <%--ReadDataonchange('txtFromBranch','hffromBranchID','txtToBranch','txtTotalMapDistance')--%
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="lblToBranch" runat="server" CssClass="label labelColor">TO BRANCH</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtToBranch" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm txtToBranch FirstNoSpaceAndZero" onchange="ReadDataonchange('txtToBranch','hfToBranchID','txtFromBranch','txtToBranch','txtTotalMapDistance','ReadData','RouteMaster.aspx/GetBranch');" TabIndex="3"></asp:TextBox>
                                                        <asp:HiddenField ID="hfToBranchID" runat="server" />
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="Lbl_RouteName" runat="server" CssClass="label labelColor">ROUTE NAME</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtRouteName" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm txtRouteName FirstNoSpaceAndZero" TabIndex="1"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="lblTotalDistance" runat="server" CssClass="label labelColor">TOTAL DISTANCE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtTotalDistance" runat="server" CssClass="form-control input-sm txtTotalDistance" Text="0"></asp:TextBox>
                                                        <asp:HiddenField ID="hfTotalDistance" runat="server" />

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="lblTotalMapDistance" runat="server" CssClass="label labelColor">MAP DISTANCE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="txtTotalMapDistance" runat="server" CssClass="form-control input-sm txtTotalMapDistance" Text="0"></asp:TextBox>
                                                        <asp:HiddenField ID="hfTotalMapDistance" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                            <!--=====================================Route Connecting Branch Details==========================================-->
                            <div class="panel-heading panelHead">
                                <b>ROUTE DETAILS</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <asp:UpdatePanel ID="UpdatePanel_RouteDetail" runat="server">
                                        <ContentTemplate>
                                            <div class="form-group" id="HideShowData" runat="server" visible="true">
                                                <div class="row">
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="LblBranch1" runat="server" CssClass="label labelColor">FROM BRANCH</asp:Label>
                                                        <asp:TextBox ID="TxtBranch1" runat="server" AutoComplete="off" CssClass="form-control input-sm TxtBranch1" Text="AUTO"></asp:TextBox>
                                                        <asp:HiddenField ID="hfTxtBranch1ID" runat="server" />
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="LblBranch2" runat="server" CssClass="label labelColor">TO BRANCH</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="TxtBranch2" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm TxtBranch2 FirstNoSpaceAndZero" onchange="ReadDataonchange('TxtBranch2','hfTxtBranch2ID','TxtBranch1','TxtBranch2','Txt_MapDistance','ReadData','RouteMaster.aspx/GetBranch');" TabIndex="5"></asp:TextBox>
                                                        <asp:HiddenField ID="hfTxtBranch2ID" runat="server" />

                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="LblDistance" runat="server" CssClass="label labelColor">DISTANCE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="TxtDistance" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm TxtDistance FirstNoSpaceAndZero" onchange="TotalDistance();" TabIndex="6"></asp:TextBox>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                        <div class="form-control-sm"></div>
                                                        <asp:Label ID="LblMapDistance" runat="server" CssClass="label labelColor">MAP DISTANCE</asp:Label><span class="required">*</span>
                                                        <asp:TextBox ID="Txt_MapDistance" runat="server" Text="0" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm Lbl_MapDistance FirstNoSpaceAndZero" ReadOnly="true"></asp:TextBox>
                                                    </div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="hfAdd" runat="server" ClientIDMode="Static" Value="0" />
                                                        <asp:LinkButton ID="Btn_Add" runat="server" Text="ADD" CssClass="btn btn-info largeButtonStyle Btn_Add" UseSubmitBehavior="false" OnClientClick="if (!validateRouteDetail()) {return false;};">ADD</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 col-xl-1 ">
                                                    </div>
                                                    <asp:GridView ID="GV_RouteDetail" runat="server" CssClass="table table-striped table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="DELETE DATA">
                                                                <ItemTemplate>
                                                                    <input id='btnRemove' type='button' value='DELETE' />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="SR.NO">
                                                                <ItemTemplate>
                                                                    <%#Container.DataItemIndex+1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="fromBranchId" HeaderText="FROM BRANCH ID">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fromBranch" HeaderText="FROM Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="toBranchId" HeaderText="TO BRANCH ID">
                                                                <HeaderStyle Wrap="false" HorizontalAlign="Center" CssClass="th-header hidden" />
                                                                <ItemStyle Wrap="false" HorizontalAlign="Center" CssClass="hidden" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="toBranch" HeaderText="TO BRANCH">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="distance" HeaderText="DISTANCE">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="mapDistance" HeaderText="MAP DISTANCE">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="hfSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                                        <asp:LinkButton ID="Button_Submit1" runat="server" Text="SUBMIT" CssClass="btn btn-info largeButtonStyle Button_Submit1" UseSubmitBehavior="false" OnClientClick="if (!validateRouteMaster()) {return false;};" TabIndex="39">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>
                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField_Btn_Reset" runat="server" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Reset" ID="Btn_Reset" runat="server" Text="RESET" OnClientClick="Btn_Reset()" TabIndex="40">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="TxtBranch2" EventName="TextChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>--%>
                            <%--  <asp:UpdatePanel ID="UpdatePanel_RouteSubmit" runat="server">
                                <ContentTemplate>--%>
                            <div class="form-group">
                                <div class="row">
                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                        <div class="form-control-sm"></div>
                                        <asp:HiddenField ID="hfRouteMasterSubmit" runat="server" ClientIDMode="Static" Value="0" />
                                        <asp:LinkButton ID="Button_Submit1" runat="server" Text="SUBMIT" CssClass="btn btn-info largeButtonStyle Button_Submit1" UseSubmitBehavior="false" OnClientClick="if (!validateRouteMaster()) {return false;};" TabIndex="39">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                    </div>
                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                        <div class="form-control-sm"></div>
                                        <asp:HiddenField ID="HiddenField_Btn_Reset" runat="server" />
                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Reset" ID="Btn_Reset" runat="server" Text="RESET" OnClientClick="Btn_Reset()" TabIndex="40">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            <%-- </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>--%>
                        </div>
                    </div>
                </div>
                <!--=============================================== End Route Details============================================-->

                <!--=========================================================================Route Schedule Details==========================================================================-->
                <%--<div id="RouteSchedule" class="tab-pane">
                    <div>
                        <div class="panel panelTop">
                            <div class="panel-heading panelHead">
                                <b>ROUTE SCHEDULE</b>
                            </div>
                            <div class="panel-body labelColor">
                                <div class="form-horizontal" role="form">
                                    <asp:UpdatePanel ID="UpdatePanel_RouteSchedule" runat="server">
                                        <ContentTemplate>
                                            <div class="form-group">
                                                <div class="row">
                                                    <asp:LinkButton ID="AddRouteSchedule" runat="server" Style="width: auto" CssClass="btn btn-info">ADD ROUTE SCHEDULE &nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <asp:GridView ID="Gv_RouteSchedule" runat="server" DataKeyNames="routeDetailID" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover table-responsive">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="routeDetailId" HeaderText="ROUTE ID">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="route" HeaderText="ROUTE">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                            <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="DAY" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="Day" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="LEAVE TIME" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="LeavingTime" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="REACH TIME" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="ReachTime" runat="server" AutoComplete="off" Style="text-transform: uppercase" CssClass="form-control input-sm"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:GridView>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class=" col-sm-1 col-md-3 col-lg-4"></div>
                                                    <div class=" col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField1" runat="server" ClientIDMode="Static" Value="0" />
                                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="SUBMIT" CssClass="btn btn-info largeButtonStyle Button_Submit1" UseSubmitBehavior="false" OnClientClick="if (!validateRouteMaster()) {return false;};" TabIndex="39">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                                    </div>
                                                    <div class="col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                                        <div class="form-control-sm"></div>
                                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                                        <asp:LinkButton CssClass="btn btn-info largeButtonStyle Btn_Reset" ID="LinkButton2" runat="server" Text="RESET" OnClientClick="Btn_Reset()" TabIndex="40">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers></Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>
                <!--=============================================== End Route Schedule============================================-->

                <!--=============================================== Searching Parameters============================================-->
                <div id="ViewDetails" class="tab-pane">
                    <div>
                        <div class="panel panelTop" runat="server">
                            <asp:UpdatePanel ID="UpdatePanel_View" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <div class="panel-heading panelView">
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-0 col-md-1 col-lg-4 "></div>
                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Label1" runat="server" CssClass="label labelColor">SEARCH PARAMETERS</asp:Label>
                                                    <asp:DropDownList ID="Ddl_SearchingParameter" runat="server" CssClass="formDisplay" onchange="GetSearchDdlBranch('Txt_Search','hfSearchId','GetData');">
                                                        <asp:ListItem>SELECT</asp:ListItem>
                                                        <asp:ListItem>FROM BRANCH</asp:ListItem>
                                                        <asp:ListItem>TOUCHING BRANCH</asp:ListItem>
                                                        <asp:ListItem>TO BRANCH</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                 
                                                    <div class="form-control-sm"></div>
                                                    <asp:Label ID="Lbl_Search" runat="server" CssClass="label labelColor">BRANCH NAME</asp:Label>
                                                    <asp:TextBox ID="Txt_Search" runat="server" AutoComplete="off" Style="text-transform: uppercase" onkeypress="return onlyAlphaValue()" CssClass="form-control input-sm Txt_Search FirstNoSpaceAndZero" onchange="ReadSearchDataonchange('Txt_Search','hfSearchId','ReadData');" TabIndex="5"></asp:TextBox>
                                                    <asp:HiddenField ID="hfSearchId" runat="server" />
                                                </div>
                                                  <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                                    <div class="form-control-lg"></div>
                                                    <div class="form-control-lg"></div>
                                                    <div class="form-control-sm"></div>
                                                    <asp:HiddenField ID="HiddenField_Btn_Search" runat="server" />
                                                    <asp:LinkButton ID="Btn_Search" runat="server" CssClass="btn btn-info largeButtonStyle Btn_Search" TabIndex="51" Text="SEARCH" OnClick="Btn_Search_Click">SEARCH&nbsp;<i class="fa fa-search"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                      
                                    </div>

                                    <div class="form-group" id="ViewData" runat="server" visible="false">
                                        <div class="panel-body" id="searchRoute" runat="server">
                                            <div class="form-horizontal" role="form">
                                                <div class="form-group">
                                                    <asp:GridView ID="GV_RouteMaster" runat="server" DataKeyNames="routeID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" AllowPaging="true" PageSize="15" OnPageIndexChanging="GV_RouteMaster_PageIndexChanging">
                                                        <Columns>
                                                            <asp:TemplateField HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="ViewData" runat="server" data-toggle="modal" data-target="#RouteModal" OnClientClick='<%#Eval("routeID","javascript:YourFunction({0});")%>' ToolTip="View Data" Text="VIEW"></asp:LinkButton>
                                                                </ItemTemplate>
                                                                 <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle"/>
                                                                 <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="routeID" HeaderText="ROUTE ID" SortExpression="routeID">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="routeName" HeaderText="ROUTE NAME" SortExpression="routeName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="noofBranch" HeaderText="NO OF BRANCHES" SortExpression="noofBranch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle"/>
                                                            </asp:BoundField>

                                                        </Columns>

                                                        <HeaderStyle HorizontalAlign="Center" />

                                                    </asp:GridView>

                                                    <%--<div class="Pager"></div>--%>
                                                    <asp:GridView ID="GV_Export" runat="server" DataKeyNames="routeID" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive" Visible="false">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="table_04" HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle CssClass="table_02" HorizontalAlign="Center"></ItemStyle>
                                                            </asp:TemplateField>

                                                            <asp:BoundField DataField="routeCode" HeaderText="ROUTE CODE" SortExpression="routeCode">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="routeName" HeaderText="ROUTE NAME" SortExpression="routeName">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="fromBranch" HeaderText="FROM BRANCH" SortExpression="fromBranch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub1Branch" HeaderText="HUB1" SortExpression="hub1Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub2Branch" HeaderText="HUB2" SortExpression="hub2Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub3Branch" HeaderText="HUB3" SortExpression="hub3Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub4Branch" HeaderText="HUB4" SortExpression="hub4Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub5Branch" HeaderText="HUB5" SortExpression="hub5Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>

                                                            <asp:BoundField DataField="hub6Branch" HeaderText="HUB6" SortExpression="hub6Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub7Branch" HeaderText="HUB7" SortExpression="hub7Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub8Branch" HeaderText="HUB8" SortExpression="hub8Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub9Branch" HeaderText="HUB9" SortExpression="hub9Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="hub10Branch" HeaderText="HUB10" SortExpression="hub10Branch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>

                                                            <asp:BoundField DataField="toBranch" HeaderText="TO BRANCH" SortExpression="toBranch">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="employeeNo" HeaderText="EMPLOYEE CODE" SortExpression="employeeNo">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="username" HeaderText="USERNAME" SortExpression="username">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="creationDateTime" HeaderText="CREATION DATE/TIME" SortExpression="creationDateTime">
                                                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" Wrap="false" />
                                                                <ItemStyle HorizontalAlign="Center" Wrap="false" />
                                                            </asp:BoundField>

                                                        </Columns>

                                                        <HeaderStyle HorizontalAlign="Center" />

                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <%--  <div id="printPage">
                                                <div class="form-group">
                                                    <div class="row">
                                                        <div class=" col-sm-10 col-md-10 col-lg-10"></div>
                                                        <div class=" col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                            <asp:ImageButton CssClass="btn" ID="btn_ExporttoExcel" runat="server" Text="Export To Excel" TabIndex="52" ImageUrl="images/excel.png" ToolTip="Export To Excel"></asp:ImageButton>
                                                        </div>
                                                        <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1">
                                                            <asp:ImageButton CssClass="fa fa-print" ID="Btn_Printbtn" runat="server" Text="Print" TabIndex="53" ImageUrl="images/Print.png" ToolTip="Print"></asp:ImageButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Btn_Search" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="GV_RouteMaster" EventName="PageIndexChanging" />
                                </Triggers>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                    <!--==============================================end Route Details======================================================== -->
                </div>
            </div>
        </div>

    </div>
    <!--================================================PopUp Window for RouteData============================================================================-->
    <!-- Modal -->
    <div class="modal" id="RouteModal" role="dialog">
        <div class="modal-dialog modal-lg">
            <!--Modal Content-->
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">ROUTE DETAIL</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <uc:Route ID="PopUp" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
    <!--=====================================End Popup Window for RouteData====================================================-->
    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="Validation/Val_RouteMaster.js"></script>
    <script src="FJS_File/RouteMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
    <script type="text/javascript">
        function showModal() {
            $("#RouteModal").modal('show');
        }
        $(function () {
            $("#ViewData").click(function () {
                showModal();
            });
        });

    </script>
</asp:Content>

