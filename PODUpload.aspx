<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="PODUpload.aspx.cs" Inherits="PODUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel panelTop">
        <div class="panel-heading panelHead" runat="server" id="HeaderName">
            <b>POD UPLOAD</b>
        </div>
        <div class="panel-body labelColor">
            <div id="divFile">
                <h3>Multiple File Upload of POD's to the Server.</h3>
                <p>
                    <asp:FileUpload ID="fileUpload" multiple="true" runat="server" />
                </p>
                <p>
                    <asp:Button ID="btUpload" Text ="Upload Files" 
                        OnClick="Upload_Files" runat="server" />
                </p>
                <%--SHOW UPLOAD MESSAGE--%>
                <p><asp:label id="lblFileList" runat="server"></asp:label></p>
                <p><asp:Label ID="lblUploadStatus" runat="server"></asp:Label></p>
                <p><asp:Label ID="lblFailedStatus" runat="server"></asp:Label></p>
            </div>
        </div>
    </div>
</asp:Content>

