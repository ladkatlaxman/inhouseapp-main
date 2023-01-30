using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FreeWaybillEntry : System.Web.UI.Page
{
    public static int LocId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                FillSummary();                
                // CurrentWaybillNo();           
                LocId = new PickReqFunctions().getLocIdFromBranch(Convert.ToInt32(Session["BranchId"]));               
            }
            else
            {
                Response.Redirect("Login.aspx");
            }           
        }
        hfPickupBranch.Value = LocId.ToString();
        SetInitialRowItem();
        string str = "$(\"[id *=Txt_InvoiceDate]\").datepicker({ dateFormat: 'dd/mm/yy', maxDate:0}).datepicker();" + "\n" +
                     "$(\"[id *=Txt_WaybillDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
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
                         "$(\"[id$=Btn_AddInSameInvoice]\").hide();" +
                   "GetBranchPickupArea();" +
                   "CurrentWaybillNo();";

        string CFT = "$('.CFT').change(function() {" +
                   "var unit;" +
                    "console.log($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val());" +
                    "console.log($(\"[id$=Txt_Length]\").val());" +
                    "console.log($(\"[id$=Txt_Breadth]\").val());" +
                    "console.log($(\"[id$=Txt_Height]\").val());" +
                    "if ($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val() != \"SELECT\" && $(\"[id$=Txt_Length]\").val() != \"\" && $(\"[id$=Txt_Breadth]\").val() != \"\" && $(\"[id$=Txt_Height]\").val() != \"\") {" +
                    "if ($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val() == \"CM\") { unit = 6000 } else { unit = 1728 }" +
                    "$(\"[id$=Txt_CFT]\").val((($(\"[id$=Txt_Length]\").val() * $(\"[id$=Txt_Breadth]\").val() * $(\"[id$=Txt_Height]\").val()) / unit).toFixed(5));" +
                     "$(\"[id$=Txt_CFT]\").attr(\"disabled\",\"disabled\");" +
                     "$(\"[id$=Txt_NoOfPackage]\").val(\"\");" +
                    "}" +
                    "});";

        string chargeW8 = "$(\"[id$=Txt_NoOfPackage]\").change(function() {" +
                    "$(\"[id$=Txt_ChargeWeight]\").val(($(\"[id$=Txt_NoOfPackage]\").val()) * (($(\"[id$=Txt_CFT]\").val()) * 10));" +
                    "console.log(($(\"[id$=Txt_NoOfPackage]\").val()) * (($(\"[id$=Txt_CFT]\").val()) * 10));" +
                    "});";


        string strDataTable = "$(function() {" + "\n" +
                     "var Index=0;" + "\n" +
                     "var temp=0;" +
                      "$(\"[id*=Btn_AddWaybillItem]\").click(function() {" + "\n" +
                        #region
                       "var hfAddWaybillItem = $(\"[id*=hfAddWaybillItem]\");" + "\n" +
                      "if(hfAddWaybillItem.val() !=0){" +
                      "var gridView = $(\"[id*=GV_WaybillDetail]\");" + "\n" +
                      "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                      "var rowData= row.find(\"td\").eq(1).find(\"input\").eq(0).val()" + "\n" +
                      "if ($.trim(row.find(\"td\").eq(1).html()) == \"&nbsp;\" || rowData==\"\") {" + "\n" +
                      "row.remove();" + "\n" +
                      "Index=0;" +
                      "temp=0;" +
                      "}" + "\n" +
                      "row = row.clone(true);" + "\n" +
                      "Index=Index+1;" + "\n" +
                      "if(temp==0)" +
                      "{" +
                             "console.log(\"index0\");" +
                            "temp=Index;" +
                      "}else" +
                      "{" +
                           "console.log(\"index1\");" +
                           "temp+=\",\"+Index" +
                       "}" +

                      "console.log(\"temp\"+temp);" +
                      "console.log(\"Table\"+Index);" +
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

                       "var ChargeWeight = $(\"[id*=Txt_ChargeWeight]\");" + "\n" +
                      "SetValue(row, 11, \"ChargeWeight\", ChargeWeight);" + "\n" +

                      "var NoOfPackage = $(\"[id*=Txt_NoOfPackage]\");" + "\n" +
                      "SetValue(row, 12, \"NoOfPackage\", NoOfPackage);" + "\n" +

                      "var NoOfInnerPackage = $(\"[id*=Txt_NoOfInnerPakage]\");" + "\n" +
                      "SetValue(row, 13, \"NoOfInnerPackage\", NoOfInnerPackage);" + "\n" +

                      "var InvoiceNo = $(\"[id*=Txt_InvoiceNo]\");" + "\n" +
                      "SetValue(row, 14, \"InvoiceNo\", InvoiceNo);" + "\n" +

                      "var InvoiceDate = $(\"[id*=Txt_InvoiceDate]\");" + "\n" +
                      "SetValue(row, 15, \"InvoiceDate\", InvoiceDate);" + "\n" +

                      "var InvoiceValue = $(\"[id*=Txt_InvoiceValue]\");" + "\n" +
                      "SetValue(row, 16, \"InvoiceValue\", InvoiceValue);" + "\n" +

                      "var EWaybillNo = $(\"[id*=Txt_EWaybillNo]\");" + "\n" +
                      "SetValue(row, 17, \"EWaybillNo\", EWaybillNo);" + "\n" +

                      "var EWaybillDate = $(\"[id*=Txt_EWaybillDate]\");" + "\n" +
                      "SetValue(row, 18, \"EWaybillDate\", EWaybillDate);" + "\n" +

                      "var EWaybillExpiryDate = $(\"[id*=Txt_EWaybillExpiryDate]\");" + "\n" +
                      "SetValue(row, 19, \"EWaybillExpiryDate\", EWaybillExpiryDate);" + "\n" +                 

                      "var AW = parseInt($(\"[id*=Txt_ActWeight]\").val(),10);" + "\n" +
                      "var CW = parseInt($(\"[id*=Txt_ChargeWeight]\").val(),10);" + "\n" +

                     "if (AW > CW){ " +
                    "$(\"[id$=Txt_ChargeWeight]\").val(AW);" +
                  
                     "$(\"[id$=Txt_CFT]\").attr(\"disabled\",\"disabled\");" +
                     "$(\"[id$=Txt_ChargeWeight]\").attr(\"disabled\",\"disabled\");" +
                     "var ChargeWeight = $(\"[id*=Txt_ChargeWeight]\");" + "\n" +
                     "SetValue(row, 11, \"ChargeWeight\", ChargeWeight);" + "\n" +
                   "} " +
                    //"    else{ }" + 	
                    "  gridView.append(row); " +
                       "\n" +
                       "var PickReqDetail=[];" + "\n" +
                     "temp+=\",\"+0;" + "\n" +
                      "var n=temp.indexOf(0);" +
                      "console.log(\"n:\"+n);" +
                     "var nameArr = temp.split(',');" + "\n" +
                     "$.each(nameArr, function(i){" + "\n" +
                       "$(\"[id*=GV_WaybillDetail] tr\").each(function() {" + "\n" +
                               "Count=($(this).length)-1;" + "\n" +
                               "if (!this.rowIndex) return;" + "\n" +
                               "var SubDetail={};" + "\n" +

                                 "if(nameArr[i] ==$(this).find(\"td\").eq(0).find(\"input\").eq(0).val())" + "\n" +
                                 "{" + "\n" +
                                  "console.log(\"nameArr:\"+nameArr[i]);" +
                                 "console.log(\"index:\"+$(this).find(\"td\").eq(0).find(\"input\").eq(0).val());" +

                                 "SubDetail.MaterialID=        $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.PackageID =        $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.Unit =             $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.Length =           $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.Breadth =          $(this).find(\"td\").eq(7).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.Height =           $(this).find(\"td\").eq(8).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.CFT =              $(this).find(\"td\").eq(9).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.ActualWeight=      $(this).find(\"td\").eq(10).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.ChargeWeight =     $(this).find(\"td\").eq(11).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.NoOfPackage =      $(this).find(\"td\").eq(12).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.NoOfInnerPackage = $(this).find(\"td\").eq(13).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.InvoiceNo =        $(this).find(\"td\").eq(14).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.InvoiceDate =      $(this).find(\"td\").eq(15).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.InvoiceValue =     $(this).find(\"td\").eq(16).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.EWaybillNo =        $(this).find(\"td\").eq(17).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.EWaybillDate =      $(this).find(\"td\").eq(18).find(\"input\").eq(0).val();" + "\n" +
                                 "SubDetail.EWaybillExpiryDate =$(this).find(\"td\").eq(19).find(\"input\").eq(0).val();" + "\n" +
                              
                               "if (SubDetail.Unit != \"KG\"){" + "\n" +
                               "var unit;" + "\n" +
                               "if(SubDetail.Unit == \"CM\"){unit=6000}else{unit= 1728}" + "\n" +
                               "SubDetail.KgperItem = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;" + "\n" +
                               "}else{" + "\n" +
                               "SubDetail.KgperItem = 0;" + "\n" +
                               "}" + "\n" +

                        //++++++++++++++++++++++++++++++++++++++++++++++
                        "$(\"[id*=hfInvoiceNo]\").val(SubDetail.InvoiceNo);" + "\n" +
                        "$(\"[id*=hfInvoiceDate]\").val(SubDetail.InvoiceDate);" + "\n" +
                        "$(\"[id*=hfInvoiceValue]\").val(SubDetail.InvoiceValue);" + "\n" +
                        "$(\"[id*=hfEwaybillNo]\").val(SubDetail.EWaybillNo);" + "\n" +
                        "$(\"[id*=hfEwaybillDate]\").val(SubDetail.EWaybillDate);" + "\n" +
                        "$(\"[id*=hfEwaybillExpiryDate]\").val(SubDetail.EWaybillExpiryDate);" + "\n" +
                     
                                //++++++++++++++++++++++++++++++
                                "PickReqDetail.push(SubDetail);" + "\n" +
                                "return false;" +
                               "}" + "\n" +
                       "});" + "\n" +
                         "});" + "\n" +
                       "console.log(PickReqDetail);" +

                      "$(\"[id*=hfWaybillSubmit]\").val(1);" + "\n" +
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
                      "ChargeWeight.val(\"\");" + "\n" +
                      "NoOfPackage.val(\"\");" + "\n" +
                      "NoOfInnerPackage.val(\"\");" + "\n" +
                      "InvoiceNo.val(\"\");" + "\n" +
                      "InvoiceDate.val(\"\");" + "\n" +
                      "InvoiceValue.val(\"\");" + "\n" +
                      "EWaybillNo.val(\"\");" + "\n" +
                      "EWaybillDate.val(\"\");" + "\n" +
                      "EWaybillExpiryDate.val(\"\");" + "\n" +
                      "$(\"[id$=Btn_AddInSameInvoice]\").show();" + "\n" +
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

        string savedata = "$(function () {" + "\n" +
                  "$(\"[id*=Button_Submit]\").bind(\"click\", function() {" + "\n" +
                   "var hfWaybillSubmit = $(\"[id*=hfWaybillSubmit]\");" + "\n" +
                   "console.log(hfWaybillSubmit.val());" +
        #region
                 "if(hfWaybillSubmit.val()==1){" + "\n" +
                "$(\"[id*=LoadingImage]\").show();" + "\n" +
                "var PickReqHeader = { };" + "\n" +
                "var PickReqDetail=[];var Count;" +

                  "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
                  "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
                  "PickReqHeader.PaymentMode= (\"FREE\");" + "\n" +
                  "PickReqHeader.PickType= (\"GODOWN\");" + "\n" +
                  "PickReqHeader.PickLocID = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
                  "PickReqHeader.PickAreaID = $(\"[id*=hfPickupArea]\").val();" + "\n" +
                  "PickReqHeader.DelLocID = $(\"[id*=hfDeliveryBranch]\").val();" + "\n" +
                  "PickReqHeader.DelAreaID = $(\"[id*=hfDeliveryArea]\").val();" + "\n" +
                  "PickReqHeader.Remark = $(\"[id*=Txt_Remark]\").val();" + "\n" +
                  //Material Details                            
                  "t=0;" +

                   "$(\"[id*=GV_WaybillDetail] tr\").each(function() {" + "\n" +
                "Count=($(this).length)-1;" + "\n" +
                "if (!this.rowIndex) return;" + "\n" +
                "var SubDetail={};" + "\n" +

                "console.log(\"length:\"+$(this).length);" +
                "if ($.trim($(this).find(\"td\").eq(1).html()) == \"&nbsp;\" || $(this).find(\"td\").eq(1).find(\"input\").eq(0).val() ==\"\") {" + "\n" +
                "}else{" +
                "console.log($(this).find(\"td\").eq(1).html());" +
                "console.log($(this).find(\"td\").eq(1).find(\"input\").eq(0).val());" + "\n" +
                "console.log(\"t:\"+t);" +
                  "t+=\",\"+0;" + "\n" +
                 "var a = t.indexOf($(this).find(\"td\").eq(0).find(\"input\").eq(0).val());" +
                 "console.log(\"a:\" + a);" +
                   "if(a == -1 && $.trim($(this).find(\"td\").eq(0).html()) != \"&nbsp;\" )" +
                   "{" +
                        "SubDetail.MaterialID=        $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.PackageID =        $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.Unit =             $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.Length =           $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.Breadth =          $(this).find(\"td\").eq(7).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.Height =           $(this).find(\"td\").eq(8).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.CFT =              $(this).find(\"td\").eq(9).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.ActualWeight=      $(this).find(\"td\").eq(10).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.ChargeWeight=      $(this).find(\"td\").eq(11).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.NoOfPackage =      $(this).find(\"td\").eq(12).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.NoOfInnerPackage = $(this).find(\"td\").eq(13).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.InvoiceNo =        $(this).find(\"td\").eq(14).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.InvoiceDate =      $(this).find(\"td\").eq(15).find(\"input\").eq(0).val();" + "\n" +
                        "SubDetail.InvoiceValue =     $(this).find(\"td\").eq(16).find(\"input\").eq(0).val();" + "\n" +
                          "if (SubDetail.EWaybillNo != \"NA\"){" + "\n" +
                           "SubDetail.EWaybillNo =        $(this).find(\"td\").eq(17).find(\"input\").eq(0).val();" + "\n" +
                           "SubDetail.EWaybillDate =      $(this).find(\"td\").eq(18).find(\"input\").eq(0).val();" + "\n" +
                           "SubDetail.EWaybillExpiryDate =$(this).find(\"td\").eq(19).find(\"input\").eq(0).val();" + "\n" +
                         "}else{" + "\n" +
                          "SubDetail.EWaybillNo = (\"NA\");" + "\n" +
                          "SubDetail.EWaybillDate =      (\"\");" + "\n" +
                          "SubDetail.EWaybillExpiryDate =(\"\");" + "\n" +
                           "}" + "\n" +
                        "if (SubDetail.Unit != \"KG\"){" + "\n" +
                        "var unit;" + "\n" +
                        "if(SubDetail.Unit == \"CM\"){unit=6000}else{unit= 1728}" + "\n" +
                        "SubDetail.KgperItem = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;" + "\n" +
                        "}else{" + "\n" +
                        "SubDetail.KgperItem = 0;" + "\n" +
                        "}" + "\n" +
                        "PickReqDetail.push(SubDetail);" + "\n" +
                        "t+=\",\"+$(this).find(\"td\").eq(0).find(\"input\").eq(0).val();" +
                        "}" +
                "}" +
        "});" + "\n" +
        "console.log(PickReqHeader);" +
        "console.log(PickReqDetail);" +
        "$.ajax({" + "\n" +
            // "url: \"PickReqWareHouse.aspx/SavePickReqData\"," + "\n" +
            "url: \"FreeWaybillEntry.aspx/CreateFreeWaybills\"," + "\n" +
            "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
            "var data=response.d;" + "\n" +
            "console.log(\"data:\"+ data);" + "\n" +
            "if(data == -1)" +
            "{" +
              "alert(\"Data could not Add...\");" + "\n" +
              "$(\"[id*=LoadingImage]\").hide();" + "\n" +
            "}" +
            "else{" +
                  // "clearData();" + "\n" +
                  "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                  "alert(\"Data Added Successfully...\");" + "\n" +
                   "location.reload(true);" + "\n" +  // for reload page after submition
            "}" +
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
                    #endregion
            "}),";

        CFunctions.setjavascript(CFunctions.javascript + str + CFT + chargeW8 + strDataTable + savedata);
            (new CFunctions()).GetJavascriptFunction(this, "Txt_MaterialType", "hfMaterialID", "~/PickReqCRMBranch.aspx/getMaterial", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_PackageType", "hfPackageID", "~/PickReqCRMBranch.aspx/getPackages", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_DeliveryBranch", "hfDeliveryBranch", "FreeWaybillEntry.aspx/getDeliveryBranchName", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        
    }
    public void CurrentWaybillNo()
    {
        int count = 0;
        int sum = 0;
        IDataReader reader = (new PickReqFunctions().CurrentWaybillSeries(Convert.ToInt32(Session["branchID"].ToString())));
        while (reader.Read())
        {
            count++;
            sum = Convert.ToInt32(reader["currentNo"]);
            if (count == 1)
            {
                Label1.Text = "";
                Label1.Text = Label1.Text + sum;
            }
            else
                Label1.Text = Label1.Text + "," + sum;
        }
    }
    private void SetInitialRowItem()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.AddRange(new DataColumn[19] { new DataColumn("MaterialID", typeof(Int32)), new DataColumn("MaterialType", typeof(String)),
                                                new DataColumn("PackageID", typeof(Int32)), new DataColumn("PackageType", typeof(String)),
                                                new DataColumn("Unit", typeof(String)), new DataColumn("Length", typeof(Double)),
                                                new DataColumn("Breadth", typeof(Double)), new DataColumn("Height", typeof(Double)),
                                                new DataColumn("CFT", typeof(Int32)), new DataColumn("ActWeight", typeof(Double)),new DataColumn("ChargeWeight", typeof(Double)),
                                                new DataColumn("NoOfPackage", typeof(Int32)), new DataColumn("NoOfInnerPackage", typeof(Int32)),
                                                new DataColumn("InvoiceNo", typeof(String)), new DataColumn("InvoiceDate", typeof(String)),
                                                new DataColumn("InvoiceValue", typeof(Double)),new DataColumn("EWaybillNo", typeof(String)),
                                                new DataColumn("EWaybillDate", typeof(String)),new DataColumn("EWaybillExpiryDate", typeof(String))
                                                });
        //ViewState["CurrentTable"] = dt;
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        GV_WaybillDetail.DataSource = dt;
        GV_WaybillDetail.DataBind();
    }
    [WebMethod]
    public static string[] getBranchPickupArea()
    {
        return (new PickReqFunctions()).getBranchArea(Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] getBranchDeliveryArea(int locId)
    {
        return (new PickReqFunctions()).getBranchDeliveryArea(locId);
    }
    [WebMethod]
    public static string[] getDeliveryBranchName(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getBranchNameForWaybills(searchPrefixText, data);
    }
    [WebMethod]
    public static int CreateFreeWaybills(PickReq PickReqHeader, List<PickReqDetail> PickReqDetail)
    {
        return (new PickReqFunctions()).SaveFreeBranchToBranchWaybill(PickReqHeader, PickReqDetail);
    }
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    // Fill summary in View panel
    public void FillSummary()
    {
        PickSummary ps = new PickSummary();
        int branchId = Convert.ToInt32(Session["branchId"]);
        ps = new PickReqFunctions().getFreeWaybillSummary(branchId);
        Lbl_TotalNoOfPackage.Text = ps.TotalPackage.ToString();
        Lbl_TotalWeight.Text = ps.TotalWeight.ToString();
    }
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        SearchingDataInGridview();
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
                if (i == 0) { finalFromDate += dateFormat1[i].ToString(); }
                else { finalFromDate += dateFormat1[i].ToString() + "/"; }
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
                if (i == 0) { finalToDate += dateFormat2[i].ToString(); }
                else { finalToDate += dateFormat2[i].ToString() + "/"; }
            }
        }
        if ((Fromdate != null) || (Todate != null))
        {
            PickReq pr = new PickReq();
            pr.date.FromDate = finalFromDate;
            pr.date.ToDate = finalToDate;
            pr.Id = Convert.ToInt32(Session["branchId"]);
            IDataReader dr= (new PickReqFunctions()).SearchFreeWaybillData(pr);
            gridViewFreeWaybillDetail.DataSource = dr;
            gridViewFreeWaybillDetail.DataBind();
        }
        else
            (new CFunctions()).showalert("Btn_Search", "SEARCH", this);
    }
}