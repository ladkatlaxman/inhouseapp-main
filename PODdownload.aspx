<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PODdownload.aspx.cs" Inherits="PODdownload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel panelTop">
        <div class="panel-heading panelHead">
            <b>POD DOWNLOAD</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-1">
                            <div class="form-control-sm"></div>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-3">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="lblWayBillNo" runat="server" CssClass="label labelColor">WAYBILL NO</asp:Label>
                            <asp:TextBox ID="txtWayBillNo" runat="server" TextMode="MultiLine" CssClass="form-control input-sm txtWayBillNo FirstNoSpaceAndZero"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-2">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <asp:LinkButton ID="Btn_DownloadPOD" runat="server" CssClass="btn btn-info largeButtonStyle2 Btn_DownloadPOD" OnClick="Btn_DownloadPOD_Click">Single POD Download</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-2">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <asp:LinkButton ID="Btn_ZipFile" runat="server" CssClass="btn btn-info largeButtonStyle2 Btn_ZipFile" OnClick="Btn_ZipFile_Click">Zip File Download</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-2">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <asp:LinkButton ID="Btn_NotUploadedPOD" runat="server" CssClass="btn btn-info largeButtonStyle2 Btn_NotUploadedPOD" OnClick="Btn_NotUploadedPOD_Click">Not Uploaded POD's</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="PODListD" visible="false" runat="server">
                    <div class="row">
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-1">
                            <div class="form-control-sm"></div>
                        </div>
                        <div>
                            <asp:GridView ID="gvPODList" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Text" HeaderText="POD List">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header gvHeaderStyle" ForeColor="Black" Wrap="false" />
                                        <ItemStyle HorizontalAlign="Center" Wrap="false" CssClass="gvItemStyle" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <a href="<%# "..\\pod\\" + Eval("Value") %>" target="_blank">Download</a>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>

                    </div>
                </div>

                <div class="form-group" id="NoPODList" visible="false" runat="server">
                    <div class="row">
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-1">
                            <div class="form-control-sm"></div>
                        </div>
                        <div>
                            <asp:GridView ID="GvPODNotUploadedList" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="gvItemStyle" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Text" HeaderText="POD NOT UPLOADED LIST">
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
        </div>
    </div>
</asp:Content>

