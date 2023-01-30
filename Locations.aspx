<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Locations.aspx.cs" Inherits="Locations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>LOCATIONS</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-group" runat="server" id="divDRS">
                <div class="row">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Lbl_ToDate" runat="server" CssClass="label labelColor">SELECTED BRANCH :  </asp:Label>
                    </div> 
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                        <div class="form-control-sm"></div>
                        <asp:DropDownList ID="ddlBranches" runat="server" CssClass="formDisplay ddlBranches"></asp:DropDownList>
                    </div> 
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnGetLocations" runat="server" OnClick="btnGetLocations_Click" Text="Get Branch Locations" CssClass="btn btn-info largeButtonStyle2 btnGetLocations"/>
                    </div> 
                </div>
                <div class="row">
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                        <div class="form-control-sm"></div>
                        <asp:Label ID="Label1" runat="server" CssClass="label labelColor">PIN CODE :  </asp:Label>
                    </div> 
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                        <div class="form-control-sm"></div>
                        <asp:TextBox ID="txtPINCode" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                    </div> 
                    <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">  
                        <div class="form-control-sm"></div>
                        <asp:Button ID="btnPINCode" runat="server" OnClick="btnPINCode_Click" Text="Get PINCode Location" CssClass="btn btn-info largeButtonStyle2 btnGetLocations"/>
                    </div> 
                </div>
            </div>
            <div class="form-group">
                <div class="form-horizontal" role="form" id="divFirstGrid" runat="server">
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="form-control-sm">&nbsp;</div>
                    <div class="WordWrap">
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive" RowStyle-CssClass="gvItemStyle" AllowPaging="false" PagerSettings-Mode="NumericFirstLast" OnRowDataBound="gvFirstGrid_RowDataBound"> 
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black"/> 
                        <Columns>
                            <asp:BoundField DataField="locId" HeaderText="locId" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="locPinCode" HeaderText="PIN Code">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cityName" HeaderText="City">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="districtName" HeaderText="District">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="stateName" HeaderText="State">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="distance" HeaderText="Distance">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="service" HeaderText="Status">
                                <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Set ODA" >
                                <ItemTemplate>
                                    <asp:LinkButton ID="setODA" runat="server" OnClick="setODA_Click" CommandArgument='<%#Eval("locId") %>' ToolTip="Set ODA" OnClientClick="return confirm('Are you sure you want to set this as ODA')"><i style="font-size: 20px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Set Regular">
                                <ItemTemplate>
                                    <asp:LinkButton ID="removeODA" runat="server" OnClick="removeODA_Click" CommandArgument='<%#Eval("locId") %>' ToolTip="Set Regular" OnClientClick="return confirm('Are you sure you want to set this as Regular')"><i style="font-size: 20px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Set N S ">
                                <ItemTemplate>
                                    <asp:LinkButton ID="setNS" runat="server" OnClick="setNS_Click" CommandArgument='<%#Eval("locId") %>' ToolTip="Set Non Servicable" OnClientClick="return confirm('Are you sure you want to set this as Non Servicable')"><i style="font-size: 20px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

