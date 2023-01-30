<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="WayBillImport.aspx.cs" Inherits="WayBillImport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content> 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"> 
    <div class="panel panelTop"> 
        <div class="panel-heading panelHead"  runat="server" id="HeaderName">
            <b>WAYBILL DETAILS.</b>
        </div>
        <div class="panel-body labelColor">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-sm"></div>
                            <asp:Label ID="Lbl_FromDate" runat="server" CssClass="label labelColor">SELECT THE FILE FOR WAYBILLS.</asp:Label>
                            <asp:FileUpload ID="fileUpload" runat="server" />
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 ">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="btnUpload" runat="server"  CssClass="btn btn-info largeButtonStyle btnUpload">UPLOAD FILE</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                            <div class="form-control-lg"></div>
                            <div class="form-control-lg"></div>
                            <div class="form-control-sm"></div>
                            <asp:LinkButton ID="btnUpdateData" runat="server"  CssClass="btn btn-info largeButtonStyle btnUpdateData">UPDATE DATA</asp:LinkButton>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 col-xl-1">
                        </div>
                    </div> 
                </div> 
            </div> 
        </div> 
        <div class="panel-body">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <asp:GridView ID="gvFirstGrid" runat="server" AutoGenerateColumns="true" CssClass="table table-condensed table-bordered table-hover table-responsive" OnRowDataBound="gvFirstGrid_RowDataBound" OnDataBound="Page_Unload" RowStyle-CssClass="gvItemStyle">
                        <HeaderStyle HorizontalAlign="Center" CssClass="gvHeaderStyle" ForeColor="Black" Wrap="false"/>                              
                        <RowStyle Wrap="false" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

