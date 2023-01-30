<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="LocationDefinition.aspx.cs" Inherits="LocationDefinition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  

    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_LocationDef" AssociatedUpdatePanelID="UpdatePanel_LocationDef" runat="server" DisplayAfter="0">
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

    <div class="panel panelTop" runat="server">
        <div class="panel-heading panelHead">
            <b>LOCATION DEFINATION</b>
        </div>
        <div class="panel-body labelColor">
            <div id="mainBranch" runat="server">
                <div class="form-horizontal" role="form">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel_LocationDef" runat="server">
                            <ContentTemplate>

                                <div class="form-group ">
                                    <div class="row ">
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:RadioButton ID="rdPincode" runat="server" GroupName="RdGroup" CssClass="rd" value="Pincode" />
                                            <asp:Label ID="Lbl_Pincode" runat="server" CssClass="label labelColor">PIN CODE</asp:Label><span class="required">*</span>
                                            <asp:TextBox ID="Txt_Pincode" runat="server" Style="text-transform: uppercase;" CssClass="form-control input-sm Txt_Pincode" onkeypress="return validateNumericValue(event)" MaxLength="8" onchange="ReadDataonchange('Txt_Pincode','hfPincode','Ddl_Area','Party_CustomerCreation.aspx/getPincode');" TabIndex="3"></asp:TextBox>
                                            <asp:HiddenField ID="hfPincode" runat="server" />
                                        </div>

                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:RadioButton ID="rdDistrict" runat="server" GroupName="RdGroup" CssClass="rd" value="District" />
                                            <asp:Label ID="Lbl_LocDistrict" runat="server" CssClass="label labelColor">DISTRICT</asp:Label>
                                            <asp:TextBox ID="Txt_District" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                            <asp:HiddenField ID="hfDistrict" runat="server" />
                                        </div>

                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                            <div class="form-control-sm"></div>
                                            <asp:RadioButton ID="rdCity" runat="server" GroupName="RdGroup" CssClass="rd" value="City" />
                                            <asp:Label ID="Lbl_LocCity" runat="server" CssClass="label labelColor">CITY</asp:Label>
                                            <asp:TextBox ID="Txt_City" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                            <asp:HiddenField ID="hfCity" runat="server" />
                                        </div>

                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:RadioButton ID="rdArea" runat="server" GroupName="RdGroup" CssClass="rd" value="Area" />
                                            <asp:Label ID="Lbl_Area" runat="server" CssClass="label labelColor">AREA</asp:Label>
                                            <asp:DropDownList ID="Ddl_Area" runat="server" CssClass="formDisplay input-sm Ddl_Area" TabIndex="4">
                                                <asp:ListItem>SELECT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-sm"></div>
                                            <asp:Label ID="Lbl_Status" runat="server" CssClass="label labelColor">STATUS</asp:Label><span class="required">*</span>
                                            <asp:DropDownList ID="Ddl_Status" runat="server" CssClass="formDisplay input-sm Ddl_Status" TabIndex="5">
                                                <asp:ListItem>SELECT</asp:ListItem>
                                                <asp:ListItem>REGULAR</asp:ListItem>
                                                <asp:ListItem>ODA</asp:ListItem>
                                                <asp:ListItem>NON-SERVICE</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>

                                        <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2">
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-lg"></div>
                                            <div class="form-control-sm"></div>
                                            <asp:HiddenField ID="hfSetAsODA" runat="server" ClientIDMode="Static" Value="0" />
                                            <asp:LinkButton ID="Btn_SetAsODA" runat="server" CssClass="btn btn-info largeButtonStyle Btn_SetAsODA" UseSubmitBehavior="false" OnClientClick="if (!validateLocationDefinitionDetails()) {return false;};" TabIndex="21">SET STATUS</asp:LinkButton><%--OnClick="Btn_SetAsODA_Click"--%>
                                        </div>

                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <%-- <asp:AsyncPostBackTrigger ControlID="Ddl_Type" EventName="SelectedIndexChanged" />         --%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
            </div>
        </div>

        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <asp:GridView ID="GV_LocationDefinition" runat="server" AutoGenerateColumns="False" CssClass="table table-condensed table-bordered table-hover table-responsive">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                            </asp:TemplateField>
                            <asp:BoundField DataField="stateName" HeaderText="STATE">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="locPincode" HeaderText="PINCODE">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" Wrap="false" />
                            </asp:BoundField> 
                            <asp:BoundField DataField="districtName" HeaderText="DISTRICT">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                             <asp:BoundField DataField="cityName" HeaderText="CITY">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                             <asp:BoundField DataField="areaName" HeaderText="AREA">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>                                                 
                            <asp:BoundField DataField="Status" HeaderText="STATUS">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" Wrap="false" ForeColor="Black" />
                                <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                            </asp:BoundField>
                                                     
                        </Columns>

                        <HeaderStyle HorizontalAlign="Center" />

                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <script src="Validation/Val_LocationDefinition.js"></script>
    <script src="FJS_File/PartyCustomer.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

