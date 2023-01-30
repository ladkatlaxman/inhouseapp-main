using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using BLProperties;
using BLFunctions;
using System.Web.Script.Services;
using System.Web.UI.WebControls;
using System.Web.UI;
public partial class RouteMaster : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                ViewData.Visible = true;
                //FillGrid();
                //call with ascx method

                //TxtBranch1.Attributes.Add("disabled", "disabled");
                //Txt_MapDistance.Attributes.Add("disabled", "disabled");
                //txtTotalDistance.Attributes.Add("disabled", "disabled");
                //txtTotalMapDistance.Attributes.Add("disabled", "disabled");
                //DataTable dt = DummyData();
                //GV_RouteDetail.DataSource = dt;
                //GV_RouteDetail.DataBind();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        CallPageLoadFuntion();
    }
    //call with ascx method

    //public DataTable DummyData()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Columns.Add(new DataColumn("fromBranchId", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("fromBranch", typeof(String)));
    //    dt.Columns.Add(new DataColumn("toBranchId", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("toBranch", typeof(String)));
    //    dt.Columns.Add(new DataColumn("distance", typeof(Decimal)));
    //    dt.Columns.Add(new DataColumn("mapDistance", typeof(Decimal)));
    //    dt.Rows.Add();
    //    return dt;
    //}
    public void CallPageLoadFuntion()
    {
        string str = "if($(\"[id *= Ddl_SearchingParameter]\").val()==\"SELECT\")" + "\n" +
                    // "{$(\"[id*=Txt_Search]\").hide();}" + "\n" +

                     "var Index=0;" + "\n" +
                     "$(\"[id*=Btn_AddTouchingBranch]\").click(function() {" + "\n" +
                     "var hfAddTouchingBranch = $(\"[id*=hfAddTouchingBranch]\");" + "\n" +
                     "if(hfAddTouchingBranch.val() !=0){" +
                     "var gridView = $(\"[id*=GV_RouteDetail]\");" + "\n" +
                     "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                     "var rowData= row.find(\"td\").eq(2).find(\"input\").eq(0).val()" + "\n" +
                     "console.log(rowData);" +
                     "if ($.trim(row.find(\"td\").eq(1).html()) == \"&nbsp;\" || rowData==\"\") {" + "\n" +
                     "console.log(row.find(\"td\").eq(2).html());" +
                     "row.remove();" + "\n" +
                     "Index=0;" +
                     "}" + "\n" +
                     "console.log(\"remove1\");" +
                     "row = row.clone(true);" + "\n" +
                     "Index=Index+1;" + "\n" +
                     "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
                      // "var RemoveButton=\"<input id='btnRemove' type='button' value='DELETE'/>\";" + "\n" +
                      //"var RemoveButton = $(\"[id*=GV_RouteDetail]\").find(\"[id*=btnRemove]\");" +
                      //"SetButton(row, 0, \"Button\", RemoveButton);" + "\n" +
                      "var i= row.find(\"td\").eq(0).html();" +
                     "console.log(i);" +
                     "var txtbranch = $(\"[id*=txtToBranch]\");" + "\n" +
                     "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
                     "SetValue(row, 0, \"Index\", txtAutoIncrementNo);" + "\n" +
                     "var k= row.find(\"td\").eq(1).html();" +
                     "console.log(k);" +
                     "var txtFromBranchId = $(\"[id*=hfTxtBranch1]\");" + "\n" +
                     "SetValue(row, 1, \"fromBranchId\", txtFromBranchId);" + "\n" +
                     "var txtFromBranch = $(\"[id*=TxtBranch1]\");" + "\n" +
                     "SetValue(row, 2, \"fromBranch\", txtFromBranch);" + "\n" +
                     "var txtToBranchId = $(\"[id*=hfTxtBranch2]\");" + "\n" +
                     "SetValue(row, 3, \"toBranchId\", txtToBranchId);" + "\n" +
                     "var txtToBranch = $(\"[id*=TxtBranch2]\");" + "\n" +
                     "SetValue(row, 4, \"toBranch\", txtToBranch);" + "\n" +
                     "var txtDistance = $(\"[id*=TxtDistance]\");" + "\n" +
                     "SetValue(row, 5, \"distance\", txtDistance);" + "\n" +
                     "var txtMapDistance = $(\"[id*=Txt_MapDistance]\");" + "\n" +
                     "SetValue(row, 6, \"mapDistance\", txtMapDistance);" + "\n" +
                     "gridView.append(row);" + "\n" +
                     "txtFromBranch.val(txtToBranch.val());" + "\n" +
                     "txtFromBranchId.val(txtToBranchId.val());" + "\n" +
                     "if(txtbranch.val()!=''){" + "\n" +
                     "if(txtToBranch.val()==txtbranch.val())" + "\n" +
                     "{$(\"[id*=HideShowData]\").hide();" + "\n" +
                     "$(\"[id*=txtFromBranch]\").attr(\"disabled\", \"disabled\");" + "\n" +
                     "$(\"[id*=txtToBranch]\").attr(\"disabled\", \"disabled\");" + "\n" +
                     "$(\"[id*=txtRouteName]\").attr(\"disabled\", \"disabled\");" + "\n" +
                     "txtFromBranch.val(\"AUTO\");" + "\n" +
                     "txtFromBranchId.val(\"\");" + "\n" +
                     "txtToBranch.val(\"\");" + "\n" +
                     "txtToBranchId.val(\"\");" + "\n" +
                     "txtDistance.val(\"\");" + "\n" +
                     "txtMapDistance.val(0);" + "\n" +
                     "$(\"[id*=hfRouteMasterSubmit]\").val(1);" + "\n" +
                     "console.log($(\"[id*=hfRouteMasterSubmit]\").val());" +
                     "}" + "\n" +
                     "else{" + "\n" +
                     "txtToBranch.val(\"\");" + "\n" +
                     "txtToBranchId.val(\"\");" + "\n" +
                     "txtDistance.val(\"\");" + "\n" +
                     "txtMapDistance.val(0);" + "\n" +
                     "}" + "\n" +
                     "}" + "\n" +
                     "return false;}" + "\n" +
                     "});" + "\n" +
                     "function SetValue(row, index, name, textbox)" + "\n" +
                     "{" + "\n" +
                     "row.find(\"td\").eq(index).html(textbox.val());" + "\n" +
                     "var input = $(\"<input type = 'hidden' />\");" + "\n" +
                     "input.prop(\"name\", name);" + "\n" +
                     "input.val(textbox.val());" + "\n" +
                     "row.find(\"td\").eq(index).append(input);" + "\n" +
                     "}" + "\n" +
                     "function SetButton(row, index, name, button)" + "\n" +
                     "{" + "\n" +
                     "row.find(\"td\").eq(index).html(button);" + "\n" +
                     "var input = $(\"<input type = 'hidden' />\");" + "\n" +
                     "input.prop(\"name\", name);" + "\n" +
                     "input.val(button);" + "\n" +
                     "row.find(\"td\").eq(index).append(input);" + "\n" +
                     "}";
        String savedata = "$(\"[id*=Button_Submit1]\").bind(\"click\", function() {" + "\n" +
                  "var hfRouteMasterSubmit = $(\"[id*=hfRouteMasterSubmit]\");" + "\n" +
                  "console.log(hfRouteMasterSubmit);" +
                  "if(hfRouteMasterSubmit.val()==1){" + "\n" +
                  "$(\"[id*=LoadingImage]\").show();" +
                  "var RouteMasterDetail = { };" + "\n" +
                  "var RouteDetail=[];var Count;" +
                  "RouteMasterDetail.RouteName=$(\"[id$=txtRouteName]\").val();" + "\n" +
                  "RouteMasterDetail.HFromBranchId = $(\"[id*=hffromBranchID]\").val();" + "\n" +
                  "RouteMasterDetail.HToBranchId = $(\"[id*=hfToBranchID]\").val();" + "\n" +
                  "RouteMasterDetail.TotalDistance = $(\"[id*=txtTotalDistance]\").val();" + "\n" +
                  "RouteMasterDetail.TotalMapDistance = $(\"[id*=txtTotalMapDistance]\").val();" + "\n" +
                  "$(\"[id*=GV_RouteDetail] tr\").each(function() {" +
                  "console.log(\"loop\");" +
                  "Count=($(this).length)-1;" +
                  "if (!this.rowIndex) return;" +
                  "var SubRouteDetail={};" +
                  "SubRouteDetail.FromBranchId = $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
                  "SubRouteDetail.ToBranchId = $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
                  "SubRouteDetail.Distance = $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
                  "SubRouteDetail.MapDistance = $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
                  "if(SubRouteDetail.FromBranchId!=null || SubRouteDetail.ToBranchId !=null || SubRouteDetail.Distance !=null || SubRouteDetail.MapDistance!=null)" + "\n" +
                  "{" +
                        "var added = false; " +
                        "$.map(RouteDetail, function(elementOfArray, indexInArray){" + "\n" +
                        "if (elementOfArray.FromBranchId == SubRouteDetail.FromBranchId)" + "\n" +
                        "{console.log(\"id:\"+SubRouteDetail.FromBranchId);" +
                        "added = true;}" + "\n" +
                        "});" + "\n" +
                    "console.log(added);" +
                    "if (!added){RouteDetail.push(SubRouteDetail);}" +
                    "}" + "\n" +
                  "});" + "\n" +
                  "console.log(RouteDetail);" +
                  "$.ajax({" + "\n" +
                  "url: \"RouteMaster.aspx/SaveRouteData\"," + "\n" +
                  "data: '{RouteMasterDetail: ' + JSON.stringify(RouteMasterDetail) + ', RouteDetail:' + JSON.stringify(RouteDetail) + '}'," + "\n" +
                  "type: \"POST\"," + "\n" +
                  "dataType: \"json\"," + "\n" +
                  "contentType: \"application/json; charset=utf-8\"," + "\n" +
                  "success: function(data) {" + "\n" +
                  "console.log(data.d);" + "\n" +
                  "if(data.d==true){" +
            // alert msg
                "newFunction(\"Button_Tab1Save\",\"SAVE\")" + "\n" +

               // "alert(\"Data Added Successfully...\");" + "\n" +
                  "$(\"[id*=LoadingImage]\").hide();}" +
                  "else" +
                  "{alert(\"Already Added Data......\");}" +
                  "clearData();" +
                  "}" + "\n" +
                "});" + "\n" +
                "}" + "\n" +
                "return false;" + "\n" +
                "});" + "\n" +
                 "function clearData() {" +
                 "console.log(\"clear\");" +
                 "$(\"[id*=txtFromBranch]\").removeAttr(\"disabled\");" +
                 "$(\"[id*=txtToBranch]\").removeAttr(\"disabled\");" +
                 "$(\"[id*=txtRouteName]\").removeAttr(\"disabled\");" +
                 "$(\"[id*=txtFromBranch]\").val(\"\");" +
                 "$(\"[id*=hffromBranchID]\").val(\"\");" +
                 "$(\"[id*=txtToBranch]\").val(\"\");" +
                 "$(\"[id*=hfToBranchID]\").val(\"\");" +
                 "$(\"[id*=txtRouteName]\").val(\"\");" +
                 "$(\"[id*=txtTotalDistance]\").val(0);" +
                 "$(\"[id*=txtTotalMapDistance]\").val(0);" +
                 "$(\"[id*=HideShowData]\").show();" +
                 "AddGridviewRow();" +
                 "$(\"[id*=TxtBranch1]\").val(\"AUTO\");" +
                 "$(\"[id*=Txt_MapDistance]\").val(0);" +
                 "$(\"[id*=hfRouteMasterSubmit]\").val(0);" + "\n" +
                "};" +
                "function AddGridviewRow()" +
                "{  var hfRouteMasterSubmit = $(\"[id*=hfRouteMasterSubmit]\");" + "\n" +
                    "console.log(\"add\"+hfRouteMasterSubmit);" +
                    "if(hfRouteMasterSubmit.val() !=0){" +
                    "var gridView = $(\"[id*=GV_RouteDetail]\");" + "\n" +
                    "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                    "$(\"[id*=GV_RouteDetail]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
                    "Index=1;" + "\n" +
                    "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
                    "var txtbranch = $(\"[id*=txtToBranch]\");" + "\n" +
                    "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
                    "SetValue(row, 1, \"fromBranch\", txtAutoIncrementNo);" + "\n" +
                    "var txtFromBrachId = $(\"[id*=hfTxtBranch1]\");" + "\n" +
                    "txtFromBrachId.val(\"\");" +
                    "SetValue(row, 2, \"fromBranchId\", txtFromBrachId);" + "\n" +
                    "var txtFromBranch = $(\"[id*=TxtBranch1]\");" + "\n" +
                    "txtFromBranch.val(\"\");" +
                    "SetValue(row, 3, \"fromBranch\", txtFromBranch);" + "\n" +
                    "var txtToBranchId = $(\"[id*=hfTxtBranch2]\");" + "\n" +
                    "txtToBranchId.val(\"\");" +
                    "SetValue(row, 4, \"toBranchId\", txtToBranchId);" + "\n" +
                    "var txtToBranch = $(\"[id*=TxtBranch2]\");" + "\n" +
                    "txtToBranch.val(\"\");" +
                    "SetValue(row, 5, \"toBranch\", txtToBranch);" + "\n" +
                    "var txtDistance = $(\"[id*=TxtDistance]\");" + "\n" +
                    "txtDistance.val(\"\");" +
                    "SetValue(row, 6, \"distance\", txtDistance);" + "\n" +
                    "var txtMapDistance = $(\"[id*=Txt_MapDistance]\");" + "\n" +
                    "txtMapDistance.val(\"\");" +
                    "SetValue(row, 7, \"mapDistance\", txtMapDistance);" + "\n" +
                    "gridView.append(row);" + "\n" +
                    "};" +
                "};";
        //String savedata = "$(\"[id*=Button_Submit1]\").bind(\"click\", function() {" + "\n" +
        //                  "var hfSubmit = $(\"[id*=hfSubmit]\");" + "\n" +
        //                  "console.log(hfSubmit);" +
        //                  "if(hfSubmit.val()==1){" + "\n" +
        //                  "$(\"[id*=LoadingImage]\").show();" +
        //                  "var RouteMasterDetail = { };" + "\n" +
        //                  "var RouteDetail=[];var Count;" +
        //                  "RouteMasterDetail.RouteName=$(\"[id$=txtRouteName]\").val();" + "\n" +
        //                  "RouteMasterDetail.HFromBranchId = $(\"[id*=hffromBranchID]\").val();" + "\n" +
        //                  "RouteMasterDetail.HToBranchId = $(\"[id*=hfToBranchID]\").val();" + "\n" +
        //                  "RouteMasterDetail.TotalDistance = $(\"[id*=txtTotalDistance]\").val();" + "\n" +
        //                  "RouteMasterDetail.TotalMapDistance = $(\"[id*=txtTotalMapDistance]\").val();" + "\n" +
        //                  "$(\"[id*=GV_RouteDetail] tr\").each(function() {" +
        //                  "console.log(\"loop\");" +
        //                  "Count=($(this).length)-1;" +
        //                  "if (!this.rowIndex) return;" +
        //                  "var SubRouteDetail={};" +
        //                  "SubRouteDetail.FromBranchId = $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
        //                  "SubRouteDetail.ToBranchId = $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
        //                  "SubRouteDetail.Distance = $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
        //                  "SubRouteDetail.MapDistance = $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
        //                  "if(SubRouteDetail.FromBranchId!=null || SubRouteDetail.ToBranchId !=null || SubRouteDetail.Distance !=null || SubRouteDetail.MapDistance!=null)" + "\n" +
        //                  "{" +
        //                        "var added = false; " +
        //                        "$.map(RouteDetail, function(elementOfArray, indexInArray){" + "\n" +
        //                        "if (elementOfArray.FromBranchId == SubRouteDetail.FromBranchId)" + "\n" +
        //                        "{console.log(\"id:\"+SubRouteDetail.FromBranchId);" +
        //                        "added = true;}" + "\n" +
        //                        "});" + "\n" +
        //                    "console.log(added);" +
        //                    "if (!added){RouteDetail.push(SubRouteDetail);}" +
        //                    "}" + "\n" +
        //                  "});" + "\n" +
        //                  "console.log(RouteDetail);" +
        //                  "$.ajax({" + "\n" +
        //                  "url: \"routemaster.aspx/saveroutedata\"," + "\n" +
        //                  "data: '{routemasterdetail: ' + json.stringify(routemasterdetail) + ', routedetail:' + json.stringify(routedetail) + '}'," + "\n" +
        //                  "type: \"post\"," + "\n" +
        //                  "datatype: \"json\"," + "\n" +
        //                  "contenttype: \"application/json; charset=utf-8\"," + "\n" +
        //                  "success: function(data) {" + "\n" +
        //                  "console.log(data.d);" + "\n" +
        //                  "if(data.d==true){" +
        //                  "alert(\"add data successfully......\");" +
        //                  "$(\"[id*=loadingimage]\").hide();}" +
        //                  "else" +
        //                  "{alert(\"already added data......\");}" +
        //                  "cleardata();" +
        //                  "}" + "\n" +
        //                "});" + "\n" +
        //                "}" + "\n" +
        //                "return false;" + "\n" +
        //                "});" + "\n" +
        //                 "function clearData() {" +
        //                 "console.log(\"clear\");" +
        //                 "$(\"[id*=txtFromBranch]\").removeAttr(\"disabled\");" +
        //                 "$(\"[id*=txtToBranch]\").removeAttr(\"disabled\");" +
        //                 "$(\"[id*=txtRouteName]\").removeAttr(\"disabled\");" +
        //                 "$(\"[id*=txtFromBranch]\").val(\"\");" +
        //                 "$(\"[id*=hffromBranchID]\").val(\"\");" +
        //                 "$(\"[id*=txtToBranch]\").val(\"\");" +
        //                 "$(\"[id*=hfToBranchID]\").val(\"\");" +
        //                 "$(\"[id*=txtRouteName]\").val(\"\");" +
        //                 "$(\"[id*=txtTotalDistance]\").val(0);" +
        //                 "$(\"[id*=txtTotalMapDistance]\").val(0);" +
        //                 "$(\"[id*=HideShowData]\").show();" +
        //                 "AddGridviewRow();" +
        //                 "$(\"[id*=TxtBranch1]\").val(\"AUTO\");" +
        //                 "$(\"[id*=Txt_MapDistance]\").val(0);" +
        //                 "$(\"[id*=hfSubmit]\").val(0);" + "\n" +
        //                "};" +
        //                "function AddGridviewRow()" +
        //                "{" +
        //                    "var hfAdd = $(\"[id*=hfSubmit]\");" + "\n" +
        //                    "console.log(\"add\"+hfAdd);" +
        //                    "if(hfAdd.val() !=0){" +
        //                    "var gridView = $(\"[id*=GV_RouteDetail]\");" + "\n" +
        //                    "var row = gridView.find(\"tr\").eq(1);" + "\n" +
        //                    "$(\"[id*=GV_RouteDetail]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
        //                    "Index=1;" + "\n" +
        //                    "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
        //                    "var txtbranch = $(\"[id*=txtToBranch]\");" + "\n" +
        //                    "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
        //                    "SetValue(row, 1, \"fromBranch\", txtAutoIncrementNo);" + "\n" +
        //                    "var txtFromBrachId = $(\"[id*=hfTxtBranch1]\");" + "\n" +
        //                    "txtFromBrachId.val(\"\");" +
        //                    "SetValue(row, 2, \"fromBranchId\", txtFromBrachId);" + "\n" +
        //                    "var txtFromBranch = $(\"[id*=TxtBranch1]\");" + "\n" +
        //                    "txtFromBranch.val(\"\");" +
        //                    "SetValue(row, 3, \"fromBranch\", txtFromBranch);" + "\n" +
        //                    "var txtToBranchId = $(\"[id*=hfTxtBranch2]\");" + "\n" +
        //                    "txtToBranchId.val(\"\");" +
        //                    "SetValue(row, 4, \"toBranchId\", txtToBranchId);" + "\n" +
        //                    "var txtToBranch = $(\"[id*=TxtBranch2]\");" + "\n" +
        //                    "txtToBranch.val(\"\");" +
        //                    "SetValue(row, 5, \"toBranch\", txtToBranch);" + "\n" +
        //                    "var txtDistance = $(\"[id*=TxtDistance]\");" + "\n" +
        //                    "txtDistance.val(\"\");" +
        //                    "SetValue(row, 6, \"distance\", txtDistance);" + "\n" +
        //                    "var txtMapDistance = $(\"[id*=Txt_MapDistance]\");" + "\n" +
        //                    "txtMapDistance.val(\"\");" +
        //                    "SetValue(row, 7, \"mapDistance\", txtMapDistance);" + "\n" +
        //                    "gridView.append(row);" + "\n" +
        //                    "};" +
        //                "};";


        //string str = "if($(\"[id *= Ddl_SearchingParameter]\").val()==\"SELECT\")" + "\n" +
        //             "{$(\"[id*=Txt_Search]\").hide();}" + "\n" +
        //             "var Index=0;" + "\n" +
        //             "$(\"[id*=Btn_Add]\").click(function() {" + "\n" +
        //             "var hfAdd = $(\"[id*=hfAdd]\");" + "\n" +
        //             "if(hfAdd.val() !=0){" +
        //             "var gridView = $(\"[id*=GV_RouteDetail]\");" + "\n" +
        //             "var row = gridView.find(\"tr\").eq(1);" + "\n" +
        //             "var rowData = row.find(\"td\").eq(2).find(\"input\").eq(0).val()" + "\n" +
        //             "console.log(rowData);" +
        //              "console.log(row.find(\"td\").eq(1).html());" +
        //             "if ($.trim(row.find(\"td\").eq(1).html()) == \"&nbsp;\" || rowData==\"\") {" + "\n" +
        //             "console.log(row.find(\"td\").eq(1).html());" +
        //             "row.remove();" + "\n" +
        //             "Index=0;" +
        //             "}" + "\n" +
        //             "console.log(\"remove1\");" +
        //             "row = row.clone(true);" + "\n" +
        //             "Index=Index+1;" + "\n" +
        //             "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
        //             "var txtbranch = $(\"[id*=txtToBranch]\");" + "\n" +
        //             "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
        //             "SetValue(row, 0, \"fromBranch\", txtAutoIncrementNo);" + "\n" +
        //              "var k= row.find(\"td\").eq(1).html();" +
        //             "console.log(k);" +
        //             "var txtFromBranchId = $(\"[id*=hfTxtBranch1]\");" + "\n" +
        //             "SetValue(row, 1, \"fromBranchId\", txtFromBranchId);" + "\n" +
        //             "var txtFromBranch = $(\"[id*=TxtBranch1]\");" + "\n" +
        //             "SetValue(row, 2, \"fromBranch\", txtFromBranch);" + "\n" +
        //             "var txtToBranchId = $(\"[id*=hfTxtBranch2]\");" + "\n" +
        //             "SetValue(row, 3, \"toBranchId\", txtToBranchId);" + "\n" +
        //             "var txtToBranch = $(\"[id*=TxtBranch2]\");" + "\n" +
        //             "SetValue(row, 4, \"toBranch\", txtToBranch);" + "\n" +
        //             "var txtDistance = $(\"[id*=TxtDistance]\");" + "\n" +
        //             "SetValue(row, 5, \"distance\", txtDistance);" + "\n" +
        //             "var txtMapDistance = $(\"[id*=Txt_MapDistance]\");" + "\n" +
        //             "SetValue(row, 6, \"mapDistance\", txtMapDistance);" + "\n" +
        //             "gridView.append(row);" + "\n" +
        //             "txtFromBranch.val(txtToBranch.val());" + "\n" +
        //             "txtFromBranchId.val(txtToBranchId.val());" + "\n" +
        //             "if(txtbranch.val()!=''){" + "\n" +
        //             "if(txtToBranch.val()==txtbranch.val())" + "\n" +
        //             "{$(\"[id*=HideShowData]\").hide();" + "\n" +
        //             "$(\"[id*=txtFromBranch]\").attr(\"disabled\", \"disabled\");" + "\n" +
        //             "$(\"[id*=txtToBranch]\").attr(\"disabled\", \"disabled\");" + "\n" +
        //             "$(\"[id*=txtRouteName]\").attr(\"disabled\", \"disabled\");" + "\n" +
        //             "txtFromBranch.val(\"AUTO\");" + "\n" +
        //             "txtFromBranchId.val(\"\");" + "\n" +
        //             "txtToBranch.val(\"\");" + "\n" +
        //             "txtToBranchId.val(\"\");" + "\n" +
        //             "txtDistance.val(\"\");" + "\n" +
        //             "txtMapDistance.val(0);" + "\n" +
        //             "$(\"[id*=hfSubmit]\").val(1);" + "\n" +
        //             "console.log($(\"[id*=hfSubmit]\").val());" +
        //             "}" + "\n" +
        //             "else{" + "\n" +
        //             "txtToBranch.val(\"\");" + "\n" +
        //             "txtToBranchId.val(\"\");" + "\n" +
        //             "txtDistance.val(\"\");" + "\n" +
        //             "txtMapDistance.val(0);" + "\n" +
        //             "}" + "\n" +
        //             "}" + "\n" +
        //             "return false;}" + "\n" +
        //             "});" + "\n" +
        //             "function SetValue(row, index, name, textbox)" + "\n" +
        //             "{" + "\n" +
        //             "row.find(\"td\").eq(index).html(textbox.val());" + "\n" +
        //             "var input = $(\"<input type = 'hidden' />\");" + "\n" +
        //             "input.prop(\"name\", name);" + "\n" +
        //             "input.val(textbox.val());" + "\n" +
        //             "row.find(\"td\").eq(index).append(input);" + "\n" +
        //             "}";
        //String savedata = "$(\"[id*=Button_Submit1]\").bind(\"click\", function() {" + "\n" +
        //                  "var hfSubmit = $(\"[id*=hfSubmit]\");" + "\n" +
        //                  "console.log(hfSubmit);" +
        //                  "if(hfSubmit.val()==1){" + "\n" +
        //                  "$(\"[id*=LoadingImage]\").show();" +
        //                  "var RouteMasterDetail = { };" + "\n" +
        //                  "var RouteDetail=[];var Count;" +
        //                  "RouteMasterDetail.RouteName=$(\"[id$=txtRouteName]\").val();" + "\n" +
        //                  "RouteMasterDetail.HFromBranchId = $(\"[id*=hffromBranchID]\").val();" + "\n" +
        //                  "RouteMasterDetail.HToBranchId = $(\"[id*=hfToBranchID]\").val();" + "\n" +
        //                  "RouteMasterDetail.TotalDistance = $(\"[id*=txtTotalDistance]\").val();" + "\n" +
        //                  "RouteMasterDetail.TotalMapDistance = $(\"[id*=txtTotalMapDistance]\").val();" + "\n" +
        //                  "$(\"[id*=GV_RouteDetail] tr\").each(function() {" +
        //                  "Count=($(this).length)-1;" +
        //                  "if (!this.rowIndex) return;" +
        //                  "var SubRouteDetail={};" +
        //                  "SubRouteDetail.FromBranchId = $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
        //                  "SubRouteDetail.ToBranchId = $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
        //                  "SubRouteDetail.Distance = $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
        //                  "SubRouteDetail.MapDistance = $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
        //                  "RouteDetail.push(SubRouteDetail);" + "\n" +
        //                  "});" + "\n" +
        //                  "console.log(RouteDetail);" +
        //                //  "$.ajax({" + "\n" +
        //                //  "url: \"RouteMaster.aspx/SaveRouteData\"," + "\n" +
        //                //  "data: '{RouteMasterDetail: ' + JSON.stringify(RouteMasterDetail) + ', RouteDetail:' + JSON.stringify(RouteDetail) + '}'," + "\n" +
        //                //  "type: \"POST\"," + "\n" +
        //                //  "dataType: \"json\"," + "\n" +
        //                //  "contentType: \"application/json; charset=utf-8\"," + "\n" +
        //                //  "success: function(data) {" + "\n" +
        //                //  "console.log(data.d);" + "\n" +
        //                //  "if(data.d==true){" +
        //                //  "alert(\"Add Data Successfully......\");" +
        //                //  "$(\"[id*=LoadingImage]\").hide();}" +
        //                //  "else" +
        //                //  "{alert(\"Already Added Data......\");}" +
        //                //  "clearData();" +
        //                //  "}" + "\n" +
        //                //"});" + "\n" +
        //                "}" + "\n" +
        //                "return false;" + "\n" +
        //                "});" + "\n" +
        //                 "function clearData() {" +
        //                 "console.log(\"clear\");" +
        //                 "$(\"[id*=txtFromBranch]\").removeAttr(\"disabled\");" +
        //                 "$(\"[id*=txtToBranch]\").removeAttr(\"disabled\");" +
        //                 "$(\"[id*=txtRouteName]\").removeAttr(\"disabled\");" +
        //                 "$(\"[id*=txtFromBranch]\").val(\"\");" +
        //                 "$(\"[id*=hffromBranchID]\").val(\"\");" +
        //                 "$(\"[id*=txtToBranch]\").val(\"\");" +
        //                 "$(\"[id*=hfToBranchID]\").val(\"\");" +
        //                 "$(\"[id*=txtRouteName]\").val(\"\");" +
        //                 "$(\"[id*=txtTotalDistance]\").val(0);" +
        //                 "$(\"[id*=txtTotalMapDistance]\").val(0);" +
        //                 "$(\"[id*=HideShowData]\").show();" +
        //                 "AddGridviewRow();" +
        //                 "$(\"[id*=TxtBranch1]\").val(\"AUTO\");" +
        //                 "$(\"[id*=Txt_MapDistance]\").val(0);" +
        //                 "$(\"[id*=hfSubmit]\").val(0);" + "\n" +
        //                "};" +
        //                "function AddGridviewRow()" +
        //                "{" +
        //                    "var hfAdd = $(\"[id*=hfSubmit]\");" + "\n" +
        //                    "console.log(\"add\"+hfAdd);" +
        //                    "if(hfAdd.val() !=0){" +
        //                    "var gridView = $(\"[id*=GV_RouteDetail]\");" + "\n" +
        //                    "var row = gridView.find(\"tr\").eq(1);" + "\n" +
        //                    "$(\"[id*=GV_RouteDetail]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
        //                    "Index=1;" + "\n" +
        //                    "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
        //                    "var txtbranch = $(\"[id*=txtToBranch]\");" + "\n" +
        //                    "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
        //                    "SetValue(row, 0, \"Index\", txtAutoIncrementNo);" + "\n" +
        //                    "var txtFromBrachId = $(\"[id*=hfTxtBranch1]\");" + "\n" +
        //                    "txtFromBrachId.val(\"\");" +
        //                    "SetValue(row, 1, \"fromBranchId\", txtFromBrachId);" + "\n" +
        //                    "var txtFromBranch = $(\"[id*=TxtBranch1]\");" + "\n" +
        //                    "txtFromBranch.val(\"\");" +
        //                    "SetValue(row, 2, \"fromBranch\", txtFromBranch);" + "\n" +
        //                    "var txtToBranchId = $(\"[id*=hfTxtBranch2]\");" + "\n" +
        //                    "txtToBranchId.val(\"\");" +
        //                    "SetValue(row, 3, \"toBranchId\", txtToBranchId);" + "\n" +
        //                    "var txtToBranch = $(\"[id*=TxtBranch2]\");" + "\n" +
        //                    "txtToBranch.val(\"\");" +
        //                    "SetValue(row, 4, \"toBranch\", txtToBranch);" + "\n" +
        //                    "var txtDistance = $(\"[id*=TxtDistance]\");" + "\n" +
        //                    "txtDistance.val(\"\");" +
        //                    "SetValue(row, 5, \"distance\", txtDistance);" + "\n" +
        //                    "var txtMapDistance = $(\"[id*=Txt_MapDistance]\");" + "\n" +
        //                    "txtMapDistance.val(\"\");" +
        //                    "SetValue(row, 6, \"mapDistance\", txtMapDistance);" + "\n" +
        //                    "gridView.append(row);" + "\n" +
        //                    "};" +
        //                "};";

        //string ShowRouteSchedule = "$(\"[id*=AddRouteSchedule]\").bind(\"click\", function() {" + "\n" +
        //                                     "var i=22;"+
        //                            "$.ajax({" + "\n" +
        //                                    "type: \"POST\"," + "\n" +
        //                                    "contentType: \"application/json; charset=utf-8\"," + "\n" +
        //                                    "url: \"RouteMaster.aspx/ShowRouteSchedule\", " + "\n" +
        //                                    "data: \"{routeId:'+i+'}\", " + "\n" +
        //                                    "dataType: \"json\", " + "\n" +
        //                                    "success: function(result) {" + "\n" +
        //                                    "console.log(result.d.length);" + "\n" +
        //                                    "for (var i = 0; i < result.d.length; i++)" + "\n" +
        //                                    "{" + "\n" +
        //                                    "console.log(result.d[i].RouteId);" + "\n" +
        //                                       "$(\"[id*=Gv_RouteSchedule]\").append(\"<tr><td>\" + result.d[i].RouteId + \"</td><td>\" + result.d[i].RouteName + \"</td></tr>\");" + "\n" +
        //                                     "}" + "\n" +
        //                                    "}, error: function(result)" + "\n" +
        //                                    "{alert(\"Error\");}" + "\n" +
        //                                  "}); " + "\n" +
        //                                "});";

        CFunctions.setjavascript(CFunctions.javascript + str + savedata);
        (new CFunctions()).GetJavascriptFunction(this, "txtFromBranch", "hffromBranchID", "RouteMaster.aspx/GetBranch", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "txtToBranch", "hfToBranchID", "RouteMaster.aspx/GetBranch", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "TxtBranch2", "hfTxtBranch2ID", "RouteMaster.aspx/GetBranch", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }
    /*----------------Fill Data in Gridview with sorting--------------------*/
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    private void FillGrid(string sortExpression = null)
    {
        DataTable dt = (new RouteMasterFunctions()).ViewData(Ddl_SearchingParameter.SelectedItem.Text, Convert.ToInt32(hfSearchId.Value));
        if (sortExpression != null)
        {
            DataView dv = dt.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            GV_RouteMaster.DataSource = dv;
            //GV_Export.DataSource = dv;                                      /*Export GV*/
        }
        else
        {
            GV_RouteMaster.DataSource = dt;
            //GV_Export.DataSource = dt;                                  /*Export GV*/
        }
        GV_RouteMaster.DataBind();
        //GV_Export.DataBind();                                               /*Export GV*/
    }

    [WebMethod]
    public static string[] GetBranch(string searchPrefixText, string data = null)
    {
        return (new RouteMasterFunctions()).GetBranch(searchPrefixText, data);
    }
    [WebMethod]

    public static string[] GetSearchBranch(string searchPrefixText, string data, string Param2)
    {
        return (new RouteMasterFunctions()).ViewRouteFromBranch(searchPrefixText, data, Param2);
    }
    [WebMethod]
    public static string GetMapDistance(string FromBranch, string ToBranch)
    {
        return (new RouteMasterFunctions()).GetMapDistance(FromBranch, ToBranch);
    }
    [WebMethod]
    [ScriptMethod]
    public static bool SaveRouteData(RouteMasterProperties RouteMasterDetail, List<RouteDetails> RouteDetail)
    {
        return (new RouteMasterFunctions()).SaveRouteData(RouteMasterDetail, RouteDetail);
    }

    //[WebMethod]
    //public static List<RouteMasterProperties> ShowRouteSchedule(int routeId)
    //{
    //    return (new RouteMasterFunctions()).ShowRouteScheduleList(routeId);
    //}

    protected void GV_RouteMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_RouteMaster.PageIndex = e.NewPageIndex;
        if (Ddl_SearchingParameter.SelectedItem.Text != "SELECT" || Txt_Search.Text != "")
            FillGrid();
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        ViewData.Visible = true;
        if (Ddl_SearchingParameter.SelectedItem.Text != "SELECT" || Txt_Search.Text != "")
        {
            FillGrid();
         //   Txt_Search.Visible = true;
            //DataTable dt = (new RouteMasterFunctions()).SearchData(Ddl_SearchingParameter.SelectedItem.Text, Convert.ToInt32(hfSearchId.Value));
            //GV_RouteMaster.DataSource = dt;
            //GV_RouteMaster.DataBind();
        }
    }

    [WebMethod]
    public static string[] GetRouteHeaderData(int routeId)
    {
        return (new RouteMasterFunctions()).LoadRouteHeaderData(routeId);
    }
    [WebMethod]
    public static string[] GetRouteDetailsData(int routeId)
    {
        return (new RouteMasterFunctions()).LoadRouteDetailsData(routeId);
    }
}