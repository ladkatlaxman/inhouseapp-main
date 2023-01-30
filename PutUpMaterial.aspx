<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PutUpMaterial.aspx.cs" Inherits="PutUpMaterial" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <link href="css/AlertNotification.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <!---Update Progress 1 ---->
    <asp:UpdateProgress ID="UpdateProgress_PutUpMaterial" AssociatedUpdatePanelID="UpdatePanel_PutUpMaterial" runat="server" DisplayAfter="0">
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
        <asp:UpdatePanel ID="UpdatePanel_PutUpMaterial" runat="server">
            <ContentTemplate>
                <div class="panel-heading panelHead">
                    <b>PUT UP MATERIAL</b>
                    <asp:Label ID="lblControl" runat="server"></asp:Label>
                </div> 
                <div class="panel-body labelColor">
                    <div class="form-horizontal" role="form">
                        <div class="form-group">
                            <asp:GridView ID="GV_PutUpMaterial" runat="server" CssClass="table table-condensed table-bordered table-hover table-responsive" AutoGenerateColumns="false" OnRowDataBound="GV_PutUpMaterial_RowDataBound" OnRowCommand="GV_PutUpMaterial_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="table_04 gvHeaderStyle" HorizontalAlign="Center"></HeaderStyle>
                                        <ItemStyle CssClass="table_02 gvItemStyle" HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="grnId" HeaderText="ID">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header hidden gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="hidden gvItemStyle" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="grnNo" HeaderText="GRN NO">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MaterialName" HeaderText="MATERIAL NAME">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="QTY">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>  
                                      <asp:BoundField DataField="UOM" HeaderText="UNIT">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>                                   
                                    <asp:TemplateField HeaderText="PUT UP QTY" ItemStyle-Width="100">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="PutUpQty" AutoCompleteType="Disabled" Text='<%# Eval("Qty") %>' CssClass="form-control input-sm FirstNoSpaceAndZero" onkeypress="return validateNumericValue(event)"></asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="BAY AREA" ItemStyle-Width="100">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlBay" runat="server" CssClass="formDisplay Ddl_Bay">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="BaySet" runat="server" CommandName="SET" CommandArgument='<%# Container.DataItemIndex %>'>SET MATERIAL</asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
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

