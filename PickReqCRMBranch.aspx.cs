using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using System.Data;
using System.Web.Services;
using System.Net;
using System.Text;

public partial class PickReqCRMBranch : System.Web.UI.Page
{
    public static string PopupValue = String.Empty;
    public static string ContactNo = String.Empty, Pincode = String.Empty, Area = String.Empty, Address = String.Empty;
    public static int consigneeId, ccustId, wcustId, materialID, packageID;
    public static int pickUpID, branchID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null)
            {
                FillSummary();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        DataTable dt = DummyData();
        GV_Detail.DataSource = dt;
        GV_Detail.DataBind();
        string str =  // "$(function() {" + "\n" +
                             "$(\"[id$= Txt_PickUpDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
                         "if($(\"[id *=Txt_SearchFromDate]\").val()==\"\")" +
                         "{" +
                             "$(\"[id *=Txt_SearchFromDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
                         "}" +
                         "else" +
                         "{" +
                             "$(\"[id *=Txt_SearchFromDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", $(\"[id *=Txt_SearchFromDate]\").val());" + "\n" +
                         "}" +
                         "if($(\"[id *=Txt_SearchToDate]\").val()==\"\")" +
                         "{" +
                             "$(\"[id *=Txt_SearchToDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
                         "}" +
                         "else" +
                         "{" +
                             "$(\"[id *=Txt_SearchToDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", $(\"[id *=Txt_SearchToDate]\").val());" + "\n" +
                         "}" +

                          "$(\"[id$= CustomerCodeDiv]\").show();" +
                          "$(\"[id$=CorporateCustomerDiv]\").show();" +
                          "$(\"[id$=WalkinCustomerDiv]\").hide();";

        string CFT = "$('.CFT').change(function() {" +
                    "var unit;" +
                     "console.log($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val());" +
                     "console.log($(\"[id$=Txt_Length]\").val());" +
                     "console.log($(\"[id$=Txt_Breadth]\").val());" +
                     "console.log($(\"[id$=Txt_Height]\").val());" +
                     "if ($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val() != \"SELECT\" && $(\"[id$=Txt_Length]\").val() != \"\" && $(\"[id$=Txt_Breadth]\").val() != \"\" && $(\"[id$=Txt_Height]\").val() != \"\") {" +
                     "    if ($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val() == \"CM\") { unit = 6000; } else { unit = 1728; }" +
                      "$(\"[id$=Txt_CFT]\").val((($(\"[id$=Txt_Length]\").val() * $(\"[id$=Txt_Breadth]\").val() * $(\"[id$=Txt_Height]\").val()) / unit).toFixed(2));" +
                      "console.log($(\"[id$=Txt_CFT]\").val());" +
                     "}" +
                     "else" +
                     "    $(\"[id$=Txt_CFT]\").val(\"\");" +
                     "});";

        string strDataTable = "$(function() {" + "\n" +
                           "var Index=0;" + "\n" +
            "$(\"[id*=Btn_AddPickReqItem]\").click(function() {" + "\n" +
        #region
        "var hfAddPickReqItem = $(\"[id*=hfAddPickReqItem]\");" + "\n" +
            "if(hfAddPickReqItem.val() !=0){" +
            "var gridView = $(\"[id*=GV_Detail]\");" + "\n" +
            "var row = gridView.find(\"tr\").eq(1);" + "\n" +
            "console.log(row)" + "\n" +
            "var rowData= row.find(\"td\").eq(1).find(\"input\").eq(0).val()" + "\n" +
              "console.log(rowData)" + "\n" +
            "if ($.trim(row.find(\"td\").eq(1).html()) == \"&nbsp;\" || rowData==\"\") {" + "\n" +
            "row.remove();" + "\n" +
            "Index=0;" +
            "}" + "\n" +
            "row = row.clone(true);" + "\n" +
            "Index=Index+1;" + "\n" +
            "console.log(Index+\"Table\");" +
            "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
            "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
            "SetValue(row, 0, \"Index\", txtAutoIncrementNo);" + "\n" +
            "var MaterialID = $(\"[id*=hfMaterialID]\");" + "\n" +
            "SetValue(row, 1, \"MaterialID\", MaterialID);" + "\n" +
            "var MaterialType = $(\"[id*=Txt_MaterialType]\");" + "\n" +
            "SetValue(row, 2, \"MaterialType\", MaterialType);" + "\n" +
            "var PackageID = $(\"[id*=hfPackageID]\");" + "\n" +
            "SetValue(row, 3, \"PackageID\", PackageID);" + "\n" +
            "var PackageType = $(\"[id*=Txt_PackageType]\");" + "\n" +
            "SetValue(row, 4, \"PackageType\", PackageType);" + "\n" +
            "var Unit = $(\"[id*=Ddl_Unit]\");" + "\n" +
            "SetValue(row, 5, \"Unit\", Unit);" + "\n" +
            "var Length = $(\"[id*=Txt_Length]\");" + "\n" +
            "SetValue(row, 6, \"Length\", Length);" + "\n" +
            "var Breadth = $(\"[id*=Txt_Breadth]\");" + "\n" +
            "SetValue(row, 7, \"Breadth\", Breadth);" + "\n" +
            "var Height = $(\"[id*=Txt_Height]\");" + "\n" +
            "SetValue(row, 8, \"Height\", Height);" + "\n" +
            "var CFT = $(\"[id*=Txt_CFT]\");" + "\n" +
            "SetValue(row, 9, \"CFT\", CFT);" + "\n" +
            "var ActWeight = $(\"[id*=Txt_ActWeight]\");" + "\n" +
            "SetValue(row, 10, \"ActWeight\", ActWeight);" + "\n" +
            "var NoOfPackage = $(\"[id*=Txt_NoOfPackage]\");" + "\n" +
            "SetValue(row, 11, \"NoOfPackage\", NoOfPackage);" + "\n" +
            "gridView.append(row);" + "\n" +
            "MaterialID.val(\"\");" + "\n" +
            "MaterialType.val(\"\");" + "\n" +
            "PackageID.val(\"\");" + "\n" +
            "PackageType.val(\"\");" + "\n" +
            "Unit.val(\"SELECT\");" + "\n" +
            "Length.val(\"\");" + "\n" +
            "Breadth.val(\"\");" + "\n" +
            "Height.val(\"\");" + "\n" +
            "CFT.val(\"\");" + "\n" +
            "ActWeight.val(\"\");" + "\n" +
            "NoOfPackage.val(\"\");" + "\n" +
            "}" + "\n" +
            "return false;" + "\n" +
            "});" + "\n" +
            "function SetValue(row, index, name, textbox)" + "\n" +
            "{" + "\n" +
            "row.find(\"td\").eq(index).html(textbox.val());" + "\n" +
            "var input = $(\"<input type = 'hidden' />\");" + "\n" +
            "input.prop(\"name\", name);" + "\n" +
            "input.val(textbox.val());" + "\n" +
            "row.find(\"td\").eq(index).append(input);" + "\n" +
        #endregion
                "}" + "\n" +
          "}),";

        String savedata = "$(function () {" + "\n" +
                  "$(\"[id*=Button_Submit]\").bind(\"click\", function() {" + "\n" +
                   "var hfPickReqSubmit = $(\"[id*=hfPickReqSubmit]\");" + "\n" +
                   "console.log(hfPickReqSubmit.val());" +
        #region
                  "if(hfPickReqSubmit.val()==1){" + "\n" +
                  "$(\"[id*=LoadingImage]\").show();" + "\n" +
                  "var PickReqHeader = { };" + "\n" +
                  "var PickReqDetail=[];var Count;" +
                  "PickReqHeader.PickType=(\"LOCAL\");" + "\n" +
                  "PickReqHeader.PickDate = $(\"[id*=Txt_PickUpDate]\").val();" + "\n" +
                  "PickReqHeader.CustType = $(\"[id*=Ddl_CustomerType]\").val();" + "\n" +

                  // "if(PickReqHeader.CustType==\"CORPORATE\"){" +
                  //"PickReqHeader.CustCode = $(\"[id*=Txt_CustCode]\").val();" + "\n" +
                  //"PickReqHeader.CustSeachWord = $(\"[id*=Txt_CustomerSearchCode]\").val(\"NULL\");}" + "\n" +
                  //"else{PickReqHeader.CustSeachWord = $(\"[id*=Txt_CustomerSearchCode]\").val();" + "\n" +
                  //"PickReqHeader.CustCode = $(\"[id*=Txt_CustCode]\").val(\"NULL\");}" + "\n" +

                  "PickReqHeader.CustCode = $(\"[id*=Txt_CustCode]\").val();" + "\n" +

                  "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
                  "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
                  "PickReqHeader.walkinCustId=0;" + "\n" +
                  "}" + "\n" +
                  "else{PickReqHeader.walkinCustId =$(\"[id$=hfWCustID]\").val();" + "\n" +
                   "PickReqHeader.CustID=0;}" + "\n" +
                  "PickReqHeader.CustContactNo = $(\"[id*=Txt_CustMobileNo]\").val();" + "\n" +
                  "PickReqHeader.CustTelephone = $(\"[id*=Txt_CustTelephoneNo]\").val();" + "\n" +
                  "PickReqHeader.CustEmailId = $(\"[id*=Txt_EmailId]\").val();" + "\n" +
                  "PickReqHeader.CustLocID = $(\"[id*=hfCustPinID]\").val();" + "\n" +
                  "PickReqHeader.CustAreaID=$(\"[id$=Ddl_CustArea]\").val();" + "\n" +
                  "PickReqHeader.CustAddress = $(\"[id*=Txt_CustAdd]\").val();" + "\n" +
                  "PickReqHeader.PickLocID = $(\"[id*=hfPickPinID]\").val();" + "\n" +
                  "PickReqHeader.PickAreaID = $(\"[id*=Ddl_PickArea]\").val();" + "\n" +
                  "PickReqHeader.PickAddress = $(\"[id*=Txt_PickAdd]\").val();" + "\n" +
                  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                  "if($(\"[id$=Txt_ConsigneeName]\").val()!=(\"\")){" + "\n" +
                  "PickReqHeader.ConsigneeID=$(\"[id$=hfConsigneeID]\").val();" + "\n" +
                  "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
                  "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
                  "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
                  "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
                    "}" + "\n" +
                     "else{" + "\n" +
                   "PickReqHeader.ConsigneeID=0;" + "\n" +
                  "PickReqHeader.ConsigneeContactNo = (\"\");" + "\n" +
                  "PickReqHeader.DelLocID = 0;" + "\n" +
                  "PickReqHeader.DelAreaID = 0;" + "\n" +
                  "PickReqHeader.DelAddress = (\"\");" + "\n" +
                      "}" + "\n" +
               
                  "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
                  "if($(\"[id$=Txt_ExpectedWeight]\").val()!=(\"\")){" + "\n" +
                  "PickReqHeader.expectedWeightOfMaterial = $(\"[id*=Txt_ExpectedWeight]\").val();" + "\n" +
                   "}" + "\n" +
                     "else{" + "\n" +
                      "PickReqHeader.expectedWeightOfMaterial = 0;" + "\n" +
                      "}" + "\n" +

                   "var gridView = $(\"[id*=GV_Detail]\");" + "\n" +
                   "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                   "var rowData= row.find(\"td\").eq(1).find(\"input\").eq(0).val()" + "\n" +
                   "console.log($.trim(row.find(\"td\").eq(1).html()));" +
                   "console.log(rowData);" +
                   "if($.trim(row.find(\"td\").eq(1).html()) != \"&nbsp;\" && rowData!=\"\"){" +
                                      "console.log(rowData);" +
                  "$(\"[id*=GV_Detail] tr\").each(function() {" + "\n" +
                  "Count=($(this).length)-1;" + "\n" +
                  "if (!this.rowIndex) return;" + "\n" +
                  "var SubDetail={};" + "\n" +
                  "SubDetail.MaterialType= $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.PackageType = $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Unit =  $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Length = $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Breadth =$(this).find(\"td\").eq(7).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Height = $(this).find(\"td\").eq(8).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.CFT =$(this).find(\"td\").eq(9).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.ActualWeight=$(this).find(\"td\").eq(10).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.NoOfPackage =$(this).find(\"td\").eq(11).find(\"input\").eq(0).val();" + "\n" +
                  "if (SubDetail.Unit != \"KG\"){" + "\n" +
                  "var unit;" + "\n" +
                  "if(SubDetail.Unit == \"CM\"){ unit=6000; }else{ unit= 1728; }" + "\n" +
                  "var KPI; KPI = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;" +
                  "SubDetail.KgperItem = KPI.toFixed(2);" + "\n" +
                  "console.log('Kg Per Item '+ KPI);" +
                  "SubDetail.ChargeWeight = SubDetail.KgperItem * SubDetail.NoOfPackage;" + "\n" +
                  "}else{" + "\n" +
                  "SubDetail.KgperItem = 0;" + "\n" +
                  "SubDetail.ChargeWeight = SubDetail.ActualWeight;}" + "\n" +
                  "PickReqDetail.push(SubDetail);" + "\n" + "\n" +
          "});" + "\n" +
          "}" +
          "console.log(PickReqHeader);" +
          "console.log(PickReqDetail);" +
          "$.ajax({" + "\n" +
          "url: \"PickReqCRMBranch.aspx/SavePickReqData\"," + "\n" +
          "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
          "type: \"POST\"," + "\n" +
          "dataType: \"json\"," + "\n" +
          "contentType: \"application/json; charset=utf-8\"," + "\n" +
          "success: function(response) {" + "\n" +
          "clearData();" + "\n" +
          "$(\"[id*=LoadingImage]\").hide();" + "\n" +
            // alert msg
                "newFunction(\"Button_Tab1Save\",\"SAVE\")" + "\n" +

               // "alert(\"Data Added Successfully...\");" + "\n" +
           "location.reload(true);" + "\n" +  // for reload page after submition
          "}," + "\n" +
           "error: function(response) {" + "\n" +
                 "alert(response.responseText);" + "\n" +
                  "$(\"[id*=LoadingImage]\").hide();" + "\n" +
           "}," + "\n" +
           "failure: function(response) {" + "\n" +
           "$(\"[id*=LoadingImage]\").hide();" + "\n" +
           "alert(response.responseText);" + "\n" +
           "}" + "\n" +
        "});" + "\n" +
        "}" + "\n" +
        "return false;" + "\n" +
        "});" + "\n" +
        "function clearData() {" + "\n" +
         "console.log(\"clear\");" + "\n" +
         "$(\"[id$= Txt_PickUpDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
         "$(\"[id*=Ddl_CustomerType]\").val(\"CORPORATE\");" + "\n" +
         "$(\"[id*=Txt_CustCode]\").val(\"\");" + "\n" +
         "$(\"[id*=hfCustID]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_CCustName]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_WCustName]\").val(\"\");" + "\n" +
         "$(\"[id$= CustomerCodeDiv]\").show();" +
         "$(\"[id$=CorporateCustomerDiv]\").show();" +
         "$(\"[id$=WalkinCustomerDiv]\").hide();" +
         "$(\"[id*=hfWCustID]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_CustMobileNo]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_CustTelephoneNo]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_EmailId]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_CustPin]\").val(\"\");" + "\n" +
         "$(\"[id*=hfCustPinID]\").val(\"\");" + "\n" +
         "$(\"[id*=Ddl_CustArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
         "$(\"[id*=Txt_CustAdd]\").val(\"\");" + "\n" +
         "$(\"[id*=SameAdd]\").prop(\"checked\", false);" + "\n" +
         "$(\"[id$=Txt_PickPin]\").val(\"\");" + "\n" +
         "$(\"[id$=hfPickPinID]\").val(\"\");" + "\n" +
         "$(\"[id$=Txt_PickPin]\").removeAttr(\"disabled\");" + "\n" +
         "$(\"[id*=Ddl_PickArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
         "$(\"[id$=Ddl_PickArea]\").removeAttr(\"disabled\");" + "\n" +
         "$(\"[id$=Txt_PickAdd]\").val(\"\");" + "\n" +
         "$(\"[id$=Txt_PickAdd]\").removeAttr(\"disabled\");" + "\n" +
         "$(\"[id*=Txt_ConsigneeName]\").val(\"\");" + "\n" +
         "$(\"[id*=hfConsigneeID]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_ConsigneeContNo]\").val(\"\");" + "\n" +
         "$(\"[id*=Txt_DelPin]\").val(\"\");" + "\n" +
         "$(\"[id*=hfDelPinID]\").val(\"\");" + "\n" +
         "$(\"[id*=Ddl_DelArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
         "$(\"[id*=Txt_DelAdd]\").val(\"\");" + "\n" +
         "$(\"[id$=Txt_PickupBranch]\").val(\"AUTO\"); " + "\n" +
         "$(\"[id$=hfPickupBranch]\").val(\"\"); " + "\n" +
         "AddGridviewRow();" +
         "$(\"[id*=hfPickReqSubmit]\").val(0);" + "\n" +
        "};" +
         // function for Add Blank DataTable Row after Submit
         "function AddGridviewRow()" +
                "{" +
                    "var hfPickReqSubmit = $(\"[id*=hfPickReqSubmit]\");" + "\n" +
                    "console.log(\"add\"+hfPickReqSubmit);" +
                    "if(hfPickReqSubmit.val() !=0){" +
                    "var gridView = $(\"[id*=GV_Detail]\");" + "\n" +
                    "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                    "$(\"[id*=GV_Detail]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
                    "Index=1;" + "\n" +
                    "$(\"[id*=AutoIncementNo]\").val(Index);" + "\n" +
                    "var txtAutoIncrementNo = $(\"[id*=AutoIncementNo]\");" + "\n" +
                    "SetValue(row, 0, \"Index\", txtAutoIncrementNo);" + "\n" +
                    "var MaterialID = $(\"[id*=hfMaterialID]\");" + "\n" +
                    "MaterialID.val(\"\");" + "\n" +
                    "SetValue(row, 1, \"MaterialID\", MaterialID);" + "\n" +
                    "var MaterialType = $(\"[id*=Txt_MaterialType]\");" + "\n" +
                    "SetValue(row, 2, \"MaterialType\", MaterialType);" + "\n" +
                    "var PackageID = $(\"[id*=hfPackageID]\");" + "\n" +
                    "PackageID.val(\"\");" + "\n" +
                    "SetValue(row, 3, \"PackageID\", PackageID);" + "\n" +
                    "var PackageType = $(\"[id*=Txt_PackageType]\");" + "\n" +
                    "SetValue(row, 4, \"PackageType\", PackageType);" + "\n" +
                    //"Unit.Val(\"\");" + "\n" +
                    "SetValue(row, 5, \"Unit\", PackageType);" + "\n" +
                    "var Length = $(\"[id*=Txt_Length]\");" + "\n" +
                    "SetValue(row, 6, \"Length\", Length);" + "\n" +
                    "var Breadth = $(\"[id*=Txt_Breadth]\");" + "\n" +
                    "SetValue(row, 7, \"Breadth\", Breadth);" + "\n" +
                    "var Height = $(\"[id*=Txt_Height]\");" + "\n" +
                    "SetValue(row, 8, \"Height\", Height);" + "\n" +
                    "var CFT = $(\"[id*=Txt_CFT]\");" + "\n" +
                    "SetValue(row, 9, \"CFT\", CFT);" + "\n" +
                    "var ActWeight = $(\"[id*=Txt_ActWeight]\");" + "\n" +
                    "SetValue(row, 10, \"ActWeight\", ActWeight);" + "\n" +
                    "var NoOfPackage = $(\"[id*=Txt_NoOfPackage]\");" + "\n" +
                    "SetValue(row, 11, \"NoOfPackage\", NoOfPackage);" + "\n" +
                    "gridView.append(row);" + "\n" +
                    "};" +
                "};" +
             "function SetValue(row, index, name, textbox)" + "\n" +
             "{" + "\n" +
             "row.find(\"td\").eq(index).html(textbox.val());" + "\n" +
             "var input = $(\"<input type = 'hidden' />\");" + "\n" +
             "input.prop(\"name\", name);" + "\n" +
             "input.val(textbox.val());" + "\n" +
             "row.find(\"td\").eq(index).append(input);" + "\n" +
             "};" + "\n" +

        #endregion
               "}),";

        CFunctions.setjavascript(CFunctions.javascript + str + CFT + strDataTable + savedata);
        SaveJavaScriptConsignorConsignee("LoadingImage", "CONSIGNOR", "hfPopupConsignorSubmit", "Btn_PopupConsignorSubmit", "Txt_PopupConsignorName", "Txt_PopupContactNo", "hfPopupConsignorPincode", "Txt_PopupConsignorPincode", "Ddl_PopupConsignorArea", "Txt_PopupConsignorAddress", "Txt_PopupConsignorGST",
                                                                                                                            "hfWCustID", "Txt_WCustName", "Txt_CustMobileNo", "hfCustPinID", "Txt_CustPin", "Ddl_CustArea", "Txt_CustAdd");
        SaveJavaScriptConsignorConsignee("LoadingImage", "CONSIGNEE", "hfConsigneeSubmit", "Btn_ConsigneeSubmit", "Txt_PopConsigneeName", "Txt_PopConsigneeContactNo", "hfPopConsigneePincode", "Txt_PopConsigneePincode", "Ddl_PopConsigneeArea", "Txt_popConsigneeAddress", "Txt_PopGSTNoOfConsignee",
                                                                                                                  "hfConsigneeID", "Txt_ConsigneeName", "Txt_ConsigneeContNo", "hfDelPinID", "Txt_DelPin", "Ddl_DelArea", "Txt_DelAdd");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_CustPin", "hfCustPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
        // (new CFunctions()).GetJavascriptTwoParameter(this, "Txt_CustArea", "hfCustAreaID", "Txt_CustPin", "hfCustPinID", "PickReqCRMBranch.aspx/getArea", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PickPin", "hfPickPinID", "PickReqCRMBranch.aspx/getConsignorPincode", "GetData", "});");
        //(new CFunctions()).GetJavascriptTwoParameter(this, "Txt_PickArea", "hfPicAreaID", "Txt_PickPin", "hfPickPinID", "PickReqCRMBranch.aspx/getArea", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_DelPin", "hfDelPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
        //(new CFunctions()).GetJavascriptTwoParameter(this, "Txt_DelArea", "hfDelArea", "Txt_DelPin", "hfDelPinID", "PickReqCRMBranch.aspx/getArea", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_MaterialType", "hfMaterialID", "PickReqCRMBranch.aspx/getMaterial", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PackageType", "hfPackageID", "PickReqCRMBranch.aspx/getPackages", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_CustCode", "hfCustID", "PickReqCRMBranch.aspx/getCustomerCode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_CCustName", "hfCustID", "PickReqCRMBranch.aspx/getCustName", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_ConsigneeName", "hfConsigneeID", "PickReqCRMBranch.aspx/getConsigneeName", "GetData", "});");
        //(new CFunctions()).GetJavascriptFunction(this, "Txt_SearchCustomerName", "hfSearchCustomerName", "PickReqCRMBranch.aspx/getSearchCustName", "GetData", "});");
        //(new CFunctions()).GetJavascriptFunction(this, "Txt_SearchCustomerCode", "hfSearchCustomerCode", "PickReqCRMBranch.aspx/getSearchCustCode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PopupConsignorPincode", "hfPopupConsignorPincode", "PickReqCRMBranch.aspx/getConsignorPincode", "GetData", "});");
        // (new CFunctions()).GetJavascriptTwoParameter(this, "Txt_PopupConsignorArea", "hfPopupConsignorArea", "Txt_PopupConsignorPincode", "hfPopupConsignorPincode", "PickReqCRMBranch.aspx/getArea", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PopConsigneePincode", "hfPopConsigneePincode", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
        //(new CFunctions()).GetJavascriptTwoParameter(this, "Txt_PopConsigneeArea", "hfPopConsigneeArea", "Txt_PopConsigneePincode", "hfPopConsigneePincode", "PickReqCRMBranch.aspx/getArea", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_WCustName", "hfWCustID", "PickReqCRMBranch.aspx/getWalkinCustName", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    public void SaveJavaScriptConsignorConsignee(string LoadingImage, string value, string hfButton, string button, string name, string contactNo, string hfpincode, string pincode, string area, string address, string gstno,
                                                 string fillnameId, string fillname, string fillcontactNo, string fillhfpincode, string fillpincode, string fillarea, string filladdress)
    {
        CFunctions.setjavascript(CFunctions.javascript + "$(function () {" + "\n" +
                       "$(\"[id*='" + button + "']\").bind(\"click\", function() {" + "\n" +
                       "if ($(\"[id$='" + name + "']\").val() != \"\") {" +
                            "if ($(\"[id*='" + contactNo + "']\").val() != \"\") {" +
                                "if ($(\"[id*='" + pincode + "']\").val() != \"\") {" +
                                    "if ($(\"[id*='" + area + "']\").text() != \"SELECT\") {" +
                                        "if ($(\"[id*='" + address + "']\").val() != \"\") {" +
                                            "if ($(\"[id*='" + gstno + "']\").val() != \"\") {" +
                                                "$(\"[id*='" + LoadingImage + "']\").show();" + "\n" +
                                                "var consignorOrConsignee = { };" + "\n" +
                                                "consignorOrConsignee.value='" + value + "';" +
                                                "consignorOrConsignee.Name=$(\"[id$='" + name + "']\").val();" + "\n" +
                                                "consignorOrConsignee.ContactNo = $(\"[id*='" + contactNo + "']\").val();" + "\n" +
                                                "consignorOrConsignee.LocID = $(\"[id*='" + hfpincode + "']\").val();" + "\n" +
                                                "consignorOrConsignee.AreaID=$(\"[id$='" + area + "']\").val();" + "\n" +
                                                "consignorOrConsignee.Address = $(\"[id*='" + address + "']\").val();" + "\n" +
                                                "consignorOrConsignee.GSTNo = $(\"[id*='" + gstno + "']\").val();" + "\n" +
                                                "$.ajax({" + "\n" +
                                                "url: \"PickReqCRMBranch.aspx/SaveConsignorConsignee\"," + "\n" +
                                                "data: '{Details: ' + JSON.stringify(consignorOrConsignee) +'}'," + "\n" +
                                                "type: \"POST\"," + "\n" +
                                                "dataType: \"json\"," + "\n" +
                                                "contentType: \"application/json; charset=utf-8\"," + "\n" +
                                                "success: function(data) {" + "\n" +
                                                "$(\"[id*='" + fillnameId + "']\").val(data.d);" + "\n" +
                                                "FillData();" + "\n" +
                                                "clearFunction();" + "\n" +
                                                "$(\"[id*='" + LoadingImage + "']\").hide();" + "\n" +
                                                "alert(\"Data Added Successfully...\");" + "\n" +
                                                //"console.log($(\"[id*='" + fillnameId + "']\").val());" +
                                                "}," + "\n" +
                                                 "error: function(response) {" + "\n" +
                                                       "alert(response.responseText);" + "\n" +
                                                       "$(\"[id*='" + LoadingImage + "']\").hide();" + "\n" +
                                                 "}," + "\n" +
                                                 "failure: function(response) {" + "\n" +
                                                "$(\"[id*='" + LoadingImage + "']\").hide();" + "\n" +
                                                 "alert(response.responseText);" + "\n" +
                                                 "}" + "\n" +
                                                "});" + "\n" +
                                                 "}" + "\n" +
                                                 "else{$(\"[id*='" + gstno + "']\").focus();}}" +
                                                 "else{$(\"[id*='" + address + "']\").focus();}}" +
                                                 "else{$(\"[id*='" + area + "']\").focus();}}" +
                                                 "else{$(\"[id*='" + pincode + "']\").focus();}}" +
                                                 "else{$(\"[id*='" + contactNo + "']\").focus();}}" +
                                                 "else{$(\"[id$='" + name + "']\").focus();}" +
                     "return false;" + "\n" +
                     "});" + "\n" +
                     "function FillData(){" +
                      "$(\"[id*='" + fillname + "']\").val($(\"[id*='" + name + "']\").val());" + "\n" +
                      "$(\"[id*='" + fillcontactNo + "']\").val($(\"[id*='" + contactNo + "']\").val());" + "\n" +
                      "$(\"[id*='" + fillpincode + "']\").val($(\"[id*='" + pincode + "']\").val());" + "\n" +
                      "$(\"[id*='" + fillhfpincode + "']\").val($(\"[id*='" + hfpincode + "']\").val());" + "\n" +
                      "GetAreaInDropDown($(\"[id*='" + fillpincode + "']\").val(),'" + fillarea + "', $(\"[id*='" + area + "']\").val());" + "\n" +
                      "$(\"[id*='" + filladdress + "']\").val($(\"[id*='" + address + "']\").val());" + "\n" +
                     "}" + "\n" +
                     "function clearFunction() {" + "\n" +
                      "console.log(\"clear\");" + "\n" +
                      "$(\"[id*='" + name + "']\").val(\"\");" + "\n" +
                      "$(\"[id*='" + contactNo + "']\").val(\"\");" + "\n" +
                      "$(\"[id*='" + pincode + "']\").val(\"\");" + "\n" +
                      "$(\"[id*='" + hfpincode + "']\").val(\"\");" + "\n" +
                      "$(\"[id*='" + area + "']\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
                      "$(\"[id*='" + address + "']\").val(\"\");" + "\n" +
                      "$(\"[id*='" + gstno + "']\").val(\"\");" + "\n" +
                      "$(\"[id*='" + hfButton + "']\").val(0);" + "\n" +
                    "};" +
                  "}),");
    }

    //Dummy Entry
    public DataTable DummyData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("MaterialID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("MaterialType", typeof(String)));
        dt.Columns.Add(new DataColumn("PackageID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("PackageType", typeof(String)));
        dt.Columns.Add(new DataColumn("Unit", typeof(String)));
        dt.Columns.Add(new DataColumn("Length", typeof(Double)));
        dt.Columns.Add(new DataColumn("Breadth", typeof(Double)));
        dt.Columns.Add(new DataColumn("Height", typeof(Double)));
        dt.Columns.Add(new DataColumn("CFT", typeof(Int32)));
        dt.Columns.Add(new DataColumn("ActWeight", typeof(Double)));
        dt.Columns.Add(new DataColumn("NoOfPackages", typeof(Int32)));
        dt.Rows.Add();
        return dt;
    }

    // Get Pincode
    [WebMethod]
    public static string[] getPincode(string searchPrefixText, string data = null)
    {
        return (new CommFunctions()).getPincode(searchPrefixText, data);
    }
    // Get Pincode
    [WebMethod]
    public static string[] getConsignorPincode(string searchPrefixText, string data = null)
    {
        return (new CommFunctions()).getConsignorPincode(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }

    [WebMethod]
    public static string[] PincodeDetail(int pincode)
    {
        return (new CommFunctions()).PincodeDetail(pincode);
    }
    //Auto Fill pickup Branch
    [WebMethod]
    public static string[] getPickupBranch(string pincode)
    {
        return (new PickReqFunctions()).getPickupBranch(pincode);
    }

    ////Get Area
    //[WebMethod]
    //public static string[] getArea(string searchPrefixText, string data, string pincode)
    //{
    //    return (new CommFunctions()).getArea(searchPrefixText, data, pincode);
    //}

    //Get Area in Dropdown List
    [WebMethod]
    public static List<FullAddress> getArea(int pincode)
    {
        return (new CommFunctions()).getArea(pincode);
    }

    //Get Customer Code
    [WebMethod]
    public static string[] getCustomerCode(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getCustomerCode(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    // Auto Fill details on Customer Code
    [WebMethod]
    public static string[] getCCustomerDetail(string customerID)
    {
        HttpContext.Current.Application["custID"] = customerID;
        HttpContext.Current.Application["MaterialName"] = null;
        return (new PickReqFunctions()).getCCustomerDetail(customerID, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    //Get Corporate Customer Names
    [WebMethod]
    public static string[] getCustName(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getCustName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }

    //Get Walkin Customer Names
    [WebMethod]
    public static string[] getWalkinCustName(string searchPrefixText, string data = null)
    {
        HttpContext.Current.Application["custID"] = "";
        return (new PickReqFunctions()).getWalkinCustName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    //Get Searchable Customer Code
    //[WebMethod]
    //public static string[] getSearchCustCode(string searchPrefixText, string data)
    //{
    //    return (new PickReqFunctions()).getSearchableCustCode(searchPrefixText, data);
    //}
    //Get Searchable Customer Names
    //[WebMethod]
    //public static string[] getSearchCustName(string searchPrefixText, string data)
    //{
    //    return (new PickReqFunctions()).getSearchableCustName(searchPrefixText, data);
    //}

    //Auto Fill details on Walkin customer name
    [WebMethod]
    public static string[] getWCustomerDetail(string WcustID)
    {
        HttpContext.Current.Application["MaterialName"] = null;
        return (new PickReqFunctions()).getWCustomerDetail(WcustID);
    }
    //Get Corporate Customer Names
    [WebMethod]
    public static string[] getConsigneeName(string searchPrefixText, string data)
    {
        return (new PickReqFunctions()).getConsigneeName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    //Auto Fill details on Consignee name
    [WebMethod]
    public static string[] getConsigneeNameDetail(string Name)
    {
        return (new PickReqFunctions()).getConsigneeNameDetail(Name);
    }
    //Get Material 
    [WebMethod]
    public static string[] getMaterial(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getMaterial(searchPrefixText, data, (HttpContext.Current.Application["custID"]).ToString());
    }
    [WebMethod]
    public static string[] getMaterialDetails(string materialId)
    {
        return (new PickReqFunctions()).getMaterialDetail(materialId);
    }
    //Get Packages
    [WebMethod]
    public static string[] getPackages(string searchPrefixText, string data)
    {
        return (new PickReqFunctions()).getPackages(searchPrefixText, data);
    }

    // Fill summary in View panel
    public void FillSummary()
    {
        PickSummary ps = new PickSummary();
        int branchId = Convert.ToInt32(Session["branchId"]);
        ps = new PickReqFunctions().getSummary(branchId);
        Lbl_TotalNoOfPackage.Text = ps.TotalPackage.ToString();
        Lbl_TotalWeight.Text = ps.TotalWeight.ToString();
    }

    //private void AddDefaultFirstRecord()
    //{
    //    //creating dataTable   
    //    DataTable dt = new DataTable();
    //    DataRow dr;
    //    dt.TableName = "Detail";
    //    dt.Columns.Add(new DataColumn("MaterialID", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("MaterialType", typeof(String)));
    //    dt.Columns.Add(new DataColumn("PackageID", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("PackageType", typeof(String)));
    //    dt.Columns.Add(new DataColumn("Unit", typeof(String)));
    //    dt.Columns.Add(new DataColumn("Length", typeof(Double)));
    //    dt.Columns.Add(new DataColumn("Breadth", typeof(Double)));
    //    dt.Columns.Add(new DataColumn("Height", typeof(Double)));
    //    dt.Columns.Add(new DataColumn("CFT", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("ActWeight", typeof(Double)));
    //    dt.Columns.Add(new DataColumn("NoOfPackages", typeof(Int32)));
    //    dr = dt.NewRow();
    //    dt.Rows.Add(dr);
    //    //saving databale into viewstate   
    //    ViewState["Detail"] = dt;
    //    //bind Gridview  
    //    GV_Detail.DataSource = dt;
    //    GV_Detail.DataBind();
    //    //MaterialDataTable.Visible = false;
    //}
    //private void AddNewRecordRowToGrid()
    //{
    //    PickReqDetail detail = new PickReqDetail();
    //    if (Txt_MaterialType.Text != "SELECT" && Txt_PackageType.Text != "SELECT" && Ddl_Unit.SelectedItem.Text != "SELECT" && Txt_Length.Text != "" && Txt_Breadth.Text != "" && Txt_Height.Text != "" && Txt_CFT.Text != "" && Txt_NoOfPackage.Text != "")
    //    {
    //        detail.MaterialType = Txt_MaterialType.Text.ToString();
    //        detail.PackageType = Txt_PackageType.Text.ToString();
    //        detail.Unit = Ddl_Unit.SelectedItem.Text.ToString();
    //        detail.Length = Convert.ToDouble(Txt_Length.Text);
    //        detail.Breadth = Convert.ToDouble(Txt_Breadth.Text);
    //        detail.Height = Convert.ToDouble(Txt_Height.Text);
    //        detail.CFT = Convert.ToInt32(Txt_CFT.Text);
    //        detail.ActualWeight = Convert.ToDouble(Txt_ActWeight.Text);
    //        detail.NoOfPackage = Convert.ToInt32(Txt_NoOfPackage.Text);
    //    }
    //    // check view state is not null  
    //    if (ViewState["Detail"] != null)
    //    {
    //        //get datatable from view state   
    //        DataTable dtCurrentTable = (DataTable)ViewState["Detail"];
    //        DataRow drCurrentRow = null;
    //        if (dtCurrentTable.Rows.Count > 0)
    //        {
    //            for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
    //            {
    //                //add each row into data table  
    //                drCurrentRow = dtCurrentTable.NewRow();
    //                drCurrentRow["MaterialID"] = materialID;
    //                drCurrentRow["MaterialType"] = detail.MaterialType;
    //                drCurrentRow["PackageID"] = packageID;
    //                drCurrentRow["PackageType"] = detail.PackageType;
    //                drCurrentRow["Unit"] = detail.Unit;
    //                drCurrentRow["Length"] = detail.Length;
    //                drCurrentRow["Breadth"] = detail.Breadth;
    //                drCurrentRow["Height"] = detail.Height;
    //                drCurrentRow["CFT"] = detail.CFT;
    //                drCurrentRow["ActWeight"] = detail.ActualWeight;
    //                drCurrentRow["NoOfPackages"] = detail.NoOfPackage;
    //            }
    //            //Remove initial blank row  
    //            if (dtCurrentTable.Rows[0][0].ToString() == "")
    //            {
    //                dtCurrentTable.Rows[0].Delete();
    //                dtCurrentTable.AcceptChanges();
    //            }
    //            //add created Rows into dataTable  
    //            dtCurrentTable.Rows.Add(drCurrentRow);
    //            //Save Data table into view state after creating each row  
    //            ViewState["Detail"] = dtCurrentTable;
    //            //Bind Gridview with latest Row  
    //            GV_Detail.DataSource = dtCurrentTable;
    //            GV_Detail.DataBind();
    //        }
    //    }
    //}
    /*----------------Fill Data in Gridview Code with sorting--------------------*/
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    public void SearchingDataInGridview()
    {
        String Fromdate = Txt_SearchFromDate.Text.ToString().Trim();
        Fromdate = Fromdate == "" ? null : Txt_SearchFromDate.Text.ToString().Trim();
        String finalFromDate = null;
        if (Fromdate != null)
        {
            string[] dateFormat1 = Fromdate.Split('-');

            for (int i = dateFormat1.Count() - 1; i >= 0; i--)
            {
                if (i == 0)
                {
                    finalFromDate += dateFormat1[i].ToString();
                }
                else
                {
                    finalFromDate += dateFormat1[i].ToString() + "/";
                }
            }
        }
        String Todate = Txt_SearchToDate.Text.ToString().Trim();
        Todate = Todate == "" ? null : Txt_SearchToDate.Text.ToString().Trim();
        String finalToDate = null;
        if (Todate != null)
        {
            string[] dateFormat2 = Todate.Split('-');

            for (int i = dateFormat2.Count() - 1; i >= 0; i--)
            {
                if (i == 0)
                {
                    finalToDate += dateFormat2[i].ToString();
                }
                else
                {
                    finalToDate += dateFormat2[i].ToString() + "/";
                }
            }
        }
        String status = Ddl_SearchStatus.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchStatus.SelectedItem.ToString();
        //  String customerCode = Ddl_SearchCustomerCode.SelectedItem.ToString();
        // String customerName = Ddl_SearchCustomerName.SelectedItem.ToString();

        if ((Fromdate != null) || (Todate != null) || (status != null))
        {
            PickReq pr = new PickReq();
            pr.date.FromDate = finalFromDate;
            pr.date.ToDate = finalToDate;
            pr.Status = status;
            pr.Id = Convert.ToInt32(Session["BranchId"]);
            //pr.CustCode = customerCode;
            //pr.CustName = customerName;
            //DataTable dt = (new PickReqFunctions()).SearchData(pr);
            //gridViewPickupRequestDetail.DataSource = dt;
            //GV_Export.DataSource = dt;
            //gridViewPickupRequestDetail.DataBind();
            //GV_Export.DataBind();

            gridViewPickupRequestDetail.DataSource = (new PickReqFunctions()).ViewPickupData(pr);
            gridViewPickupRequestDetail.DataBind();
        }
        else
        {
            (new CFunctions()).showalert("Btn_Search", "SEARCH", this);
        }
    }

    [WebMethod]
    public static int SaveConsignorConsignee(ConsingorConsignee Details)
    {
        return (new PickReqFunctions()).SaveConsignorConsignee(Details);
    }
    [WebMethod]
    public static bool SavePickReqData(PickReq PickReqHeader, List<PickReqDetail> PickReqDetail)
    {
        return (new PickReqFunctions()).SavePickupRequest(PickReqHeader, PickReqDetail);
    }

    protected void Delete_MaterialDetail_Click(object sender, EventArgs e)
    {
        PickReqDetail detail = new PickReqDetail();
        detail.MaterialType = (sender as LinkButton).CommandArgument;
        DataTable Alldt = (DataTable)ViewState["Detail"];
        foreach (DataRow orow in Alldt.Rows)
        {
            if (orow["MaterialType"].ToString().Equals(detail.MaterialType))
            {
                Alldt.Rows.Remove(orow);
                break;
            }
        }
        ViewState["Detail"] = Alldt;
        if (Alldt.Rows.Count == 0)
        {
            // AddDefaultFirstRecord();
        }
        else
        {
            GV_Detail.DataSource = Alldt;
            GV_Detail.DataBind();
        }
    }

    protected void gridViewPickupRequestDetail_Sorting(object sender, GridViewSortEventArgs e)
    {
        // FillGrid(e.SortExpression);
    }

    protected void gridViewPickupRequestDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewPickupRequestDetail.PageIndex = e.NewPageIndex;
        SearchingDataInGridview();
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Search.Value == "1")
        {
            SearchingDataInGridview();
            HiddenField_Btn_Search.Value = "";
        }

    }

    //protected void Btn_ChangeStatus_Click(object sender, EventArgs e)
    //{
    //    string pickupID = (sender as LinkButton).CommandArgument;
    //    pickID = Convert.ToInt32(pickupID);

    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);

    //   // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "none", "<script>$('#modalForChangeStatus').modal('show');</script>", false);
    //}
    protected void Btn_popupChangeStatus_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < gridViewPickupRequestDetail.Rows.Count; i++)
        {
            HiddenField hfPickValue = (HiddenField)gridViewPickupRequestDetail.Rows[i].FindControl("hfPickUpIDValue");
            pickUpID = Convert.ToInt32(hfPickValue.Value.ToString());
            int pickIDCell = Convert.ToInt32(gridViewPickupRequestDetail.Rows[i].Cells[2].Text);
            if (pickUpID == pickIDCell)
            {
                PickReq pr = new PickReq();
                pr.Id = pickUpID;
                pr.Status = Ddl_popupChangeStatus.SelectedItem.Text;
                pr.Remark = Txt_popupRemark.Text.ToString().ToUpper();

                bool alertMsg = (new PickReqFunctions()).SavePopupModalForStatusCancel(pr);

                if (alertMsg)
                {
                    (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                    Ddl_popupChangeStatus.SelectedItem.Text = "";
                    Txt_popupRemark.Text = "";
                    SearchingDataInGridview();
                    FillSummary();
                }
                break;
            }
            else
            {
                continue;
            }

        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Reset.Value == "1")
        {
            Response.Redirect(Request.Url.AbsoluteUri);
            HiddenField_Btn_Reset.Value = "";
        }
    }



    //protected void gridViewPickupRequestDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "VALUE")
    //    {
    //        int rowIndex = Convert.ToInt32(e.CommandArgument);

    //        GridViewRow row = gridViewPickupRequestDetail.Rows[rowIndex];
    //        pickUpID = Convert.ToInt32(row.Cells[2].Text);       
    //    }
    //}



    protected void lnk_CreateWaybill_Click(object sender, EventArgs e)
    {
        CFunctions.setID(Convert.ToInt32((sender as LinkButton).CommandArgument));
        string pickupID = CFunctions.ID.ToString();
           Response.Redirect("PickReqWareHouse.aspx?PickUpId=" + pickupID +"");
      
    }
}