<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WayBillStationary.aspx.cs" Inherits="WayBillStationary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
    <script>
        function SetSeriesFrom() {
            var NextWaybill;
            var FromWaybillNo = $("[id*=Txt_FromNumber]").val();
            if (FromWaybillNo != "") {
                if (FromWaybillNo.length == 7) {
                    var strFromNo = parseInt(FromWaybillNo, 10) % 100;
                    if (strFromNo == "01" || strFromNo == "51") {
                        NextWaybill = parseInt(FromWaybillNo) + parseInt(49);
                        $("[id*=Txt_ToNumber]").val(NextWaybill);
                        $("[id*=Lbl_Note]").text("");
                    }
                    else {
                        $("[id*=Lbl_Note]").text("Please provide Correct Starting No.");
                        $("[id*=Txt_ToNumber]").val("");
                    }
                }
                else {
                    $("[id*=Txt_ToNumber]").val("");
                }
            } else {
                $("[id*=Lbl_Note]").text("");
            }

        }
        function SetSeriesTo() {
            var NextWaybill;
            var FromWaybillNo = $("[id*=Txt_FromNumber]").val();
            var ToWaybillNo = $("[id*=Txt_ToNumber]").val();
            if (FromWaybillNo != "") {
                if (ToWaybillNo != "") {
                    if (ToWaybillNo.length == 7) {
                        var strToNo = parseInt(ToWaybillNo, 10) % 100;
                        NextWaybill = parseInt(FromWaybillNo) + parseInt(49);
                        if (strToNo == "00" || strToNo == "50") {
                            if (ToWaybillNo != NextWaybill) {
                                $("[id*=Lbl_Note]").text("Please provide 50 Range of Waybill Series.");
                            }
                            else {
                                $("[id*=Lbl_Note]").text("");
                            }
                        }
                        else {
                            $("[id*=Lbl_Note]").text("Please provide Correct Ending No.");
                        }
                    } else {
                        $("[id*=Lbl_Note]").text("");
                    }
                }
            } else {
                $("[id*=Lbl_Note]").text("Please provide Starting No.");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_WaybillStationary" AssociatedUpdatePanelID="UpdatePanel_WaybillStationary" runat="server" DisplayAfter="0">
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
        <asp:UpdatePanel ID="UpdatePanel_WaybillStationary" runat="server">
            <ContentTemplate>
                <div class="panel-heading panelHead" runat="server" id="HeaderName">
                    <b>WAYBILL STATIONARY</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                    &nbsp; 
                                </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                <div class="form-control-sm"></div>
                                <asp:Label ID="Lbl_FromNumber" runat="server" CssClass="label labelColor">FROM NUMBER</asp:Label>
                                <asp:TextBox ID="Txt_FromNumber" runat="server" Style="text-transform: uppercase;" MaxLength="7" CssClass="form-control input-sm Txt_FromNumber" onchange="SetSeriesFrom()"></asp:TextBox>
                            </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_ToNumber" runat="server" CssClass="label labelColor">TO NUMBER</asp:Label>
                                    <asp:TextBox ID="Txt_ToNumber" runat="server" Style="text-transform: uppercase" MaxLength="7" CssClass="form-control input-sm Txt_ToNumber" onchange="SetSeriesTo()"></asp:TextBox>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Submit" runat="server" Text="ADD NEW" CssClass="btn btn-info largeButtonStyle Btn_Submit" UseSubmitBehavior="false" OnClientClick="if (!validateWaybillStationary()) {return false;};" OnClick="Btn_Submit_Click">SUBMIT</asp:LinkButton>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                    &nbsp;
                            <asp:Label ID="Lbl_Note" runat="server" ForeColor="Red" Font-Size="Medium" CssClass="label"></asp:Label>
                                </div>
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                                    &nbsp;
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-body">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                                    &nbsp; 
                                </div>
                                <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                    <Columns>
                                        <asp:BoundField DataField="startEndNo"  HeaderText="Start - End" /> 
                                        <asp:BoundField DataField="Utilisation" HeaderText="Utilisation" /> 
                                        <asp:BoundField DataField="Unused"      HeaderText="Unused Waybills" /> 
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" >
                                                    <asp:ListItem Value="Active"   Text="Active"  ></asp:ListItem>
                                                    <asp:ListItem Value="Inactive" Text="Inactive"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:Button ID="btnUpdate" runat="server" Text="Update" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
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

    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="Validation/Val_VehicleTypeMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

