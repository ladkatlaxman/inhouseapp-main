<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PurchaseMaterial.aspx.cs" Inherits="PurchaseMaterial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_MaterialPurchaseDetails" AssociatedUpdatePanelID="UpdatePanel_MaterialPurchaseDetails" runat="server" DisplayAfter="0">
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
        <asp:UpdatePanel ID="UpdatePanel_MaterialPurchaseDetails" runat="server">
            <ContentTemplate>
                <div class="panel-heading panelHead">
                    <b>HEADER DETAILS</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_Branch" runat="server" CssClass="label labelColor">BRANCH</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_Branch" runat="server" TabIndex="1" CssClass="formDisplay input-sm Ddl_Branch">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_Department" runat="server" CssClass="label labelColor">DEPARTMENT</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_Department" runat="server" TabIndex="2" CssClass="formDisplay input-sm Ddl_Department">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_Remark" runat="server" CssClass="label labelColor">REMARK</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_Remark" runat="server" Style="text-transform: uppercase;" TabIndex="3" AutoCompleteType="Disabled" TextMode="MultiLine" CssClass="form-control input-sm Txt_Remark"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-heading panelHead">
                    <b>MATERIAL PURCHASE DETAILS</b>
                </div>
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-5 col-sm-6 col-md-4 col-lg-3 col-xl-2 ">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_Material" runat="server" CssClass="label labelColor">MATERIAL</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_Material" runat="server" TabIndex="4" CssClass="formDisplay input-sm Ddl_Material">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_Qty" runat="server" CssClass="label labelColor">QTY</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_Qty" runat="server" Style="text-transform: uppercase;" TabIndex="5" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_Qty"></asp:TextBox>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_UOM" runat="server" CssClass="label labelColor">UOM</asp:Label><span class="required">*</span>
                                    <asp:DropDownList ID="Ddl_UOM" runat="server" TabIndex="6" CssClass="formDisplay input-sm Ddl_UOM">
                                        <asp:ListItem>SELECT</asp:ListItem>
                                        <asp:ListItem>KG</asp:ListItem>
                                        <asp:ListItem>LITRES</asp:ListItem>
                                        <asp:ListItem>METERS</asp:ListItem>
                                        <asp:ListItem>CENTIMETERS</asp:ListItem>
                                        <asp:ListItem>CUBIC METERS</asp:ListItem>
                                        <asp:ListItem>PIECES</asp:ListItem>
                                        <asp:ListItem>ROLLS</asp:ListItem>
                                        <asp:ListItem>DRUMS</asp:ListItem>
                                        <asp:ListItem>PACKETS</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 col-xl-2">
                                    <div class="form-control-sm"></div>
                                    <asp:Label ID="Lbl_ExpectedDate" runat="server" CssClass="label labelColor">EXPECTED DATE</asp:Label><span class="required">*</span>
                                    <asp:TextBox ID="Txt_ExpectedDate" runat="server" Style="text-transform: uppercase;" TabIndex="7" AutoCompleteType="Disabled" CssClass="form-control input-sm Txt_ExpectedDate"></asp:TextBox>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-lg"></div>
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Add" runat="server" TabIndex="8" CssClass="btn btn-info buttonStyle2" UseSubmitBehavior="false" OnClientClick="if (!validateAddMaterial()) {return false;};" OnClick="Btn_Add_Click">ADD&nbsp;<i class="fa fa-plus"></i></asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:GridView ID="Add_DataTable_GridView" runat="server" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false" RowStyle-CssClass="gvItemStyle">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="materialId" HeaderText="ID">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="materialName" HeaderText="MATERIAL" />
                                    <asp:BoundField DataField="qty" HeaderText="QTY" />
                                    <asp:BoundField DataField="unit" HeaderText="UNIT" />
                                    <asp:BoundField DataField="expectedDate" HeaderText="EXPECTED DATE" />
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                            </asp:GridView>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <div class=" col-sm-3 col-md-3 col-lg-4"></div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Button_Submit" runat="server" TabIndex="9" CssClass="btn btn-info largeButtonStyle" UseSubmitBehavior="false" OnClientClick="if (!validatePurchaseMaterialDetails()) {return false;};" OnClick="Button_Submit_Click">SUBMIT&nbsp;<i class="fa fa-save"></i></asp:LinkButton>
                                </div>
                                <div class=" col-sm-2 col-md-2 col-lg-1 col-xl-1">
                                    <div class="form-control-sm"></div>
                                    <asp:LinkButton ID="Btn_Reset" runat="server" TabIndex="10" CssClass="btn btn-info largeButtonStyle" OnClick="Btn_Reset_Click">RESET&nbsp;<i class="fa fa-refresh"></i></asp:LinkButton>
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


    <!--Footer-->
    <footer class="footer" id="footer" style="position: inherit">
        <p>Copyright@2018 Dexters Logistics Pvt Ltd - All right reserved. </p>
    </footer>
    <!--End-->
    <script src="Validation/Val_MaterialMaster.js"></script>
    <script src="js/AlertNotifictaion.js"></script>
</asp:Content>

