<%@ Page Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PendingPOD.aspx.cs" Inherits="PendingPOD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <asp:LinkButton ID="btnRefreshList" runat="server" CssClass="btn btn-info largeButtonStyle2 btnRefreshList" OnClick="btnRefreshList_Click">REFRESH POD UPDATE</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-4">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <asp:LinkButton ID="btnPendingPODListBranchWise" runat="server" CssClass="btn btn-info largeButtonStyle2 btnPendingPODListBranchWise" OnClick="btnPendingPODListBranchWise_Click">BRANCHWISE PENDING POD</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="PODListD" visible="true" runat="server">
                    <div class="row">
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-4 col-xl-1">
                            <div class="form-control-sm">
                                <asp:Label runat="server" ID="lblFileName"></asp:Label>
                            </div>
                        </div>
                        <div>
                            <asp:GridView ID="gvPODList" runat="server" AutoGenerateColumns="false" CssClass="table table-condensed table-bordered table-hover table-responsive">
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

