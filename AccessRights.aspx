<%@ Page Title="" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="AccessRights.aspx.cs" Inherits="AccessRights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
       
        .LblWidth {
            width: 200px;
            font-size: small;
            color: blue;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                $('#myTab1 a[href="' + activeTab + '"]').tab('show');
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="panel panel-default">
                <div class="panel-heading panelHead">
                    <b>Access Rights</b>
                </div>
                <div class="panel-body" style="margin-left: 10px;">
                    <div class="container">                      
                        <ul class="nav nav-tabs" id="myTab1">
                            <li class="active"><a data-toggle="tab" href="#addClass"><b>Add/Edit Class</b></a></li>
                            <li><a data-toggle="tab" href="#assignClass"><b>Assign Class to User</b></a></li>
                            <li><a data-toggle="tab" href="#modifyClass"><b>Modify Access Class</b></a></li>
                        </ul>

                        <div class="tab-content">
                            <div id="addClass" class="tab-pane in active">
                                <div style="margin-top: 60px;">
                                    <div class="container-fluid">
                                        <div class="col-sm-6 col-lg-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading panelHead">
                                                    <b>Add/Edit Access Class</b>
                                                </div>
                                                <div class="panel-body" style="margin-left: 10px;">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <asp:HiddenField ID="hfAccessID" runat="server" />
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                            </div>
                                                            <div class="col-sm-3 col-lg-3 col-md-3">
                                                                <asp:Label runat="server" Text="Type" class="control-label">Access Class</asp:Label>
                                                            </div>
                                                            <div class="col-sm-5 col-lg-5 col-md-5">
                                                                <asp:TextBox class="form-control" ID="txtAccessClassName" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                            </div>
                                                            <div class="col-sm-3 col-lg-3 col-md-3">
                                                                <asp:Label runat="server" Text="Type" class="control-label">Status</asp:Label>
                                                            </div>
                                                            <div class="col-sm-5 col-lg-5 col-md-5">
                                                                <asp:DropDownList ID="Ddl_Status" runat="server" CssClass="formDisplay">
                                                                    <asp:ListItem>select</asp:ListItem>
                                                                    <asp:ListItem>Active</asp:ListItem>
                                                                    <asp:ListItem>InActive</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row" style="align-content: center">
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                            </div>
                                                            <div class="col-sm-1 col-lg-1 col-md-1">
                                                            </div>
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                                <asp:Button CssClass="btn btn-success" ID="Btn_Save" runat="server" Text="Save" OnClick="Btn_Save_Click"></asp:Button>
                                                            </div>

                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                                <asp:Button CssClass="btn btn-success" ID="Btn_Reset_AccessClass" runat="server" Text="Clear" OnClick="Btn_Reset_AccessClass_Click"></asp:Button>

                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">

                                                            <asp:Label ID="lblSuccessMessage" runat="server" class="control-label" ForeColor="Green" Font-Bold="True"></asp:Label>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">

                                                            <asp:Label ID="lblErrorMessage" runat="server" class="control-label" ForeColor="Red" Font-Bold="True"></asp:Label>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-sm-6 col-lg-6 col-md-6">

                                            <div class="panel panel-default">
                                                <div class="panel-heading panelHead">
                                                    <b>Access Class List</b>
                                                </div>
                                                <div class="panel-body">
                                                    <div class="form-horizontal" role="form">
                                                        <div class="form-group">

                                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" BorderStyle="Solid" HorizontalAlign="Center" Width="500px">
                                                                <AlternatingRowStyle BackColor="White" />
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                       
                                                                                        <asp:LinkButton ID="editAccessClassDetails" runat="server" OnClick="lnk_onClick" CommandArgument='<%#Eval("access_class_ID") %>' ToolTip="Edit"><i style="font-size: 20px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                                       
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="access_class_name" HeaderText="Access Class Name">
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="status" HeaderText="Status">
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>

                                                                </Columns>
                                                                <FooterStyle BackColor="#CCCC99" />
                                                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                                            <RowStyle BackColor="#F7F7DE" />
                                                            <SelectedRowStyle BackColor="#CE5D5A" ForeColor="White" Font-Bold="True" />
                                                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                                            <SortedAscendingHeaderStyle BackColor="#848384" />
                                                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                                            <SortedDescendingHeaderStyle BackColor="#575357" />
                                                                
                                                            </asp:GridView>


                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!--end col6-->
                                    </div>


                                </div>

                            </div>

                            <div id="assignClass" class="tab-pane">
                                <div style="margin-top: 60px;">

                                    <div class="container-fluid">
                                        <div class="col-sm-6 col-lg-6 col-md-6">
                                            <div class="panel panel-default" style="width: 500px;">
                                                <div class="panel-heading panelHead">
                                                    <b>Assign Class to User</b>

                                                </div>
                                                <div class="panel-body" style="margin-left: 10px;">
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <asp:HiddenField ID="hfAssignID" runat="server" />
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                            </div>
                                                            <div class="col-sm-3 col-lg-3 col-md-3">
                                                                <asp:Label runat="server" Text="Type" class="control-label">User Name</asp:Label>
                                                            </div>
                                                            <div class="col-sm-5 col-lg-5 col-md-5">
                                                                <asp:DropDownList ID="Ddl_Username" runat="server" CssClass="formDisplay" DataTextField="username" DataValueField="userID">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                            </div>
                                                            <div class="col-sm-3 col-lg-3 col-md-3">
                                                                <asp:Label runat="server" Text="Type" class="control-label">Access Class</asp:Label>
                                                            </div>
                                                            <div class="col-sm-5 col-lg-5 col-md-5">
                                                                <asp:DropDownList ID="Ddl_AccessClass" runat="server" CssClass="formDisplay" DataTextField="access_class_name" DataValueField="access_class_ID">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row" style="text-align: center">

                                                            <div class="col-sm-12 col-lg-12 col-md-12">
                                                                <asp:Button CssClass="btn btn-success" ID="btn_AssignClass" runat="server" Text="Assign" OnClick="btn_AssignClass_Click"></asp:Button>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">

                                                            <asp:Label ID="lblSuccessMessage1" runat="server" class="control-label" ForeColor="Green" Font-Bold="True"></asp:Label>

                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">

                                                            <asp:Label ID="lblErrorMessage1" runat="server" class="control-label" ForeColor="Red" Font-Bold="True"></asp:Label>

                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-sm-6 col-lg-6 col-md-6">

                                            <div class="panel panel-default">
                                                <div class="panel-heading panelHead">
                                                    <b>Assign Class to User List</b>
                                                </div>
                                                <div class="panel-body">
                                                    <div class="form-horizontal" role="form">
                                                        <div class="form-group">
                                                            <table>
                                                                
                                                                <tr>
                                                                    <td>

                                                                    </td>
                                                                </tr>
                                                                 
                                                            </table>
                                                            <asp:GridView ID="Grv_AssignClass" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" BorderStyle="Solid" HorizontalAlign="Center" Width="500px">
                                                                 <AlternatingRowStyle BackColor="White" />
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                       
                                                                                        <asp:LinkButton ID="editAccessClassDetails1" runat="server" OnClick="lnk1_onClick" CommandArgument='<%#Eval("ID") %>' ToolTip="Edit"><i style="font-size: 20px; color:darkblue" class="fa fa-pencil"></i></asp:LinkButton>
                                                                                       
                                                                                    </td>
                                                                                </tr>
                                                                            </table>

                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="username" HeaderText="User Name">
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="access_class_name" HeaderText="Access Class">

                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>

                                                                </Columns>
                                                                 <FooterStyle BackColor="#CCCC99" />
                                                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                                            <RowStyle BackColor="#F7F7DE" />
                                                            <SelectedRowStyle BackColor="#CE5D5A" ForeColor="White" Font-Bold="True" />
                                                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                                            <SortedAscendingHeaderStyle BackColor="#848384" />
                                                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                                            <SortedDescendingHeaderStyle BackColor="#575357" />

                                                            </asp:GridView>
                                                            

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!--end col6-->
                                    </div>


                                </div>



                            </div>
                            <div id="modifyClass" class="tab-pane">

                                <div style="margin-top: 60px;">

                                    <div class="container-fluid">
                                        <div class="col-sm-6 col-lg-6 col-md-6">

                                            <div class="panel panel-default">
                                                <div class="panel-heading panelHead">
                                                    <b>Modify Access Class</b>

                                                </div>
                                                <div class="panel-body" style="margin-left: 10px;">

                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-2 col-lg-2 col-md-2">
                                                            </div>
                                                            <div class="col-sm-3 col-lg-3 col-md-3">
                                                                <asp:Label runat="server" Text="Type" class="control-label">Select Class</asp:Label>
                                                            </div>
                                                            <div class="col-sm-5 col-lg-5 col-md-5">
                                                                <asp:DropDownList ID="Ddl_AccessName" runat="server" CssClass="formDisplay" DataTextField="access_class_name" DataValueField="access_class_ID">
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row" style="text-align: center">

                                                            <div class="col-sm-12 col-lg-12 col-md-12">
                                                                <asp:Button CssClass="btn btn-success" ID="Btn_ChangeAccess" runat="server" Text="Change Access" OnClick="Btn_ChangeAccess_Click"></asp:Button>
                                                            </div>


                                                        </div>
                                                    </div>


                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-sm-6 col-lg-6 col-md-6">

                                            <div class="panel panel-default" id="ListAccessClass" runat="server">
                                                <div class="panel-heading panelHead" style="height: 40px;">
                                                    <div class="col-sm-3 col-lg-3 col-md-3">
                                                        <asp:Label runat="server" Text="" class="control-label"><b>Class Name:</b></asp:Label>
                                                    </div>
                                                    <div class="col-sm-3 col-lg-3 col-md-3">
                                                        <asp:Label ID="lblClassName" runat="server" Text="" CssClass="LblWidth"></asp:Label>
                                                    </div>
                                                    <div class="col-sm-2 col-lg-2 col-md-2">
                                                    </div>
                                                    <div class="col-sm-2 col-lg-2 col-md-2">
                                                        <asp:Label runat="server" Text="" class="control-label"><b>Status:</b></asp:Label>
                                                    </div>
                                                    <div class="col-sm-2 col-lg-2 col-md-2">
                                                        <asp:Label ID="lblStatus" runat="server" Text="" CssClass="LblWidth"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="panel-body">
                                                    <div class="form-horizontal" role="form">
                                                        <div class="form-group">

                                                            <div class="form-group">

                                                                <div class="row" style="text-align: center; margin-top: 10px">

                                                                    <div class="col-sm-12 col-lg-12 col-md-12">
                                                                        <asp:Button CssClass="btn btn-success" ID="Btn_UpdateTableList1" runat="server" Text="Update" OnClick="Btn_UpdateTableList1_Click"></asp:Button>
                                                                    </div>

                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="row" style="text-align: center; margin-top: 5px">

                                                                    <div class="col-sm-12 col-lg-12 col-md-12">
                                                                    </div>
                                                                    <asp:Label ID="LblUpdate" runat="server" ForeColor="Blue" Font-Bold="True"></asp:Label>
                                                                </div>
                                                            </div>


                                                            <asp:GridView ID="Grid_ModifyAccessClass" runat="server" AutoGenerateColumns="False"  BackColor="White" BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" BorderStyle="Solid" HorizontalAlign="Center" Width="500px">
                                                                 <AlternatingRowStyle BackColor="White" />
                                                                <Columns>
                                                                    <asp:BoundField ReadOnly="True" HeaderText="Sr.No" DataField="SrNo">
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField HeaderText="Title" DataField="MenuTitle">
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField HeaderText="Parent Menu" DataField="Parent">
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Visible">
                                                                        <EditItemTemplate>
                                                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                                                        </EditItemTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" CssClass="th-header" />
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>

                                                                </Columns>
                                                                <FooterStyle BackColor="#CCCC99" />
                                                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                                            <RowStyle BackColor="#F7F7DE" />
                                                            <SelectedRowStyle BackColor="#CE5D5A" ForeColor="White" Font-Bold="True" />
                                                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                                            <SortedAscendingHeaderStyle BackColor="#848384" />
                                                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                                            <SortedDescendingHeaderStyle BackColor="#575357" />

                                                            </asp:GridView>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!--end col6-->
                                    </div>


                                </div>

                            </div>

                        </div>
                    </div>

                    <script>
                        $(document).ready(function () {
                            $(".nav-tabs a").click(function () {
                                $(this).tab('show');
                            });
                        });
                    </script>
                </div>
            </div>
</asp:Content>

