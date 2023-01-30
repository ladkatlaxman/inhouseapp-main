using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using System.Data;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.ServiceModel.Channels;

public partial class PickReqWareHouse : System.Web.UI.Page
{
    public static string PopupValue = String.Empty;
    public static string ContactNo = String.Empty, Pincode = String.Empty, Area = String.Empty, Address = String.Empty;
    public static int consigneeId, ccustId, wcustId, materialID, packageID;
    public static int pickUpID, branchID;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                if (Session["userBranch"].ToString() == "WAGHOLI") Response.Redirect("WBEntry.aspx");
                if (Session["userBranch"].ToString() == "BHIWANDI") Response.Redirect("WBEntry.aspx"); 
                //DataTable dt = DummyData();
                //GV_Detail.DataSource = dt;
                //GV_Detail.DataBind();

                //FillSummary();
                //if (!string.IsNullOrWhiteSpace(Request.QueryString["PickUpId"]))
                //{
                //    if (Request.QueryString["PickUpId"].ToString() != "")
                //    {                    
                //      //  Page.ClientScript.RegisterStartupScript(this.GetType(), "dis", "getCustomerType();", true);
                //        FillPickUPData(Request.QueryString["PickUpId"].ToString());
                //    }
                //}

              //  Page.ClientScript.RegisterStartupScript(this.GetType(), "dis", "getPickupIDFromURL();", true);
                HttpContext.Current.Application["CustCode"] = null;
                HttpContext.Current.Application["CustName"] = null;
                HttpContext.Current.Application["Pincode"] = null;
                HttpContext.Current.Application["consignorName"] = null;
                HttpContext.Current.Application["consigneeName"] = null;
                HttpContext.Current.Application["MaterialName"] = null;
                HttpContext.Current.Application["PackageName"] = null;
            }   
            else
                Response.Redirect("Login.aspx");
          
        }
        string str = "$(\"[id *=Txt_EWaybillDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker();" + "\n" +
        "$(\"[id *=Txt_EWaybillExpiryDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker();" + "\n" +
         "$(\"[id *=Txt_WaybillDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0, minDate: -1}).datepicker(\"setDate\", new Date());" + "\n" +
        "$(\"[id *=Txt_InvoiceDate1]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker();" + "\n" +

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
    
         "InvoiceDetailForWalkin($(\"[id *=Ddl_PaymentMode]\").val());" +
        "$(\"[id$= CustomerCodeDiv]\").show();" +
        "$(\"[id$=CorporateCustomerDiv]\").show();" +
        "$(\"[id$=WalkinCustomerDiv]\").hide();" +
        "$(\"[id$=Btn_AddInSameInvoice]\").hide();" +
        "$(\"[id$=Btn_Update]\").hide();" +
        "$(\"[id$=Btn_EditData]\").hide();" +
        "$(\"[id$=TelephoneNo]\").hide();" +
        "$(\"[id$=Email]\").hide();" +
        "$(\"[id$=materialUpdate]\").hide();" +
        "$(\"[id$=Btn_AddNewInvoice]\").hide();" +
        " $(\"[id *= Txt_TotalAmt]\").attr(\"disabled\", \"disabled\");" +
        " $(\"[id *= Txt_GSTAmt]\").attr(\"disabled\", \"disabled\");" +
        " $(\"[id *= Txt_GrandTotalAmt]\").attr(\"disabled\", \"disabled\");" +
        " $(\"[id *= SameAdd]\").attr(\"disabled\", \"disabled\");" +    
      "  $(\".Ddl_PaymentMode option[value = 'PAID']\").remove();" +
      "  $(\".Ddl_PaymentMode option[value = 'TO PAY']\").remove();" +

        "CurrentWaybillNo();" +
        "GetPrevWayBillNo();" +
        "getPickupIDFromURL();";

         string CFT = "$('.CFT').change(function() {" +
                  "var unit;" +
                   "console.log($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val());" +
                   "console.log($(\"[id$=Txt_Length]\").val());" +
                   "console.log($(\"[id$=Txt_Breadth]\").val());" +
                   "console.log($(\"[id$=Txt_Height]\").val());" +
                   "if ($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val() != \"SELECT\" && $(\"[id$=Txt_Length]\").val() != \"\" && $(\"[id$=Txt_Breadth]\").val() != \"\" && $(\"[id$=Txt_Height]\").val() != \"\") {" +
                   "if ($(\"[id$=Ddl_Unit]\").children(\"option:selected\").val() == \"CM\") { unit = 27000 } else { unit = 1728 }" +                   
                     "if($(\"[id$=Ddl_CustomerType]\").val()==\"CORPORATE\"){" +
                        "if($(\"[id$=hfCFTValue]\").val()!=\"\"){" +
                            "$(\"[id$=Txt_CFT]\").val((($(\"[id$=Txt_Length]\").val() * $(\"[id$=Txt_Breadth]\").val() * $(\"[id$=Txt_Height]\").val() * $(\"[id$=hfCFTValue]\").val()) / unit).toFixed(5));" +
                        "}" +
                        "else{" +
                           "$(\"[id$=Txt_CFT]\").val((($(\"[id$=Txt_Length]\").val() * $(\"[id$=Txt_Breadth]\").val() * $(\"[id$=Txt_Height]\").val() * 10) / unit).toFixed(5));" +
                        "}" +
                     "}" +
                     "else{" +
                       "$(\"[id$=Txt_CFT]\").val((($(\"[id$=Txt_Length]\").val() * $(\"[id$=Txt_Breadth]\").val() * $(\"[id$=Txt_Height]\").val() * 10) / unit).toFixed(5));" +
                     "}" +
                    "$(\"[id$=Txt_CFT]\").attr(\"disabled\",\"disabled\");" +
                    "$(\"[id$=Txt_NoOfPackage]\").val(\"\");" +
                   "}" +
                   "});";


        string chargeW8 = "$(\"[id$=Txt_NoOfPackage]\").change(function() {" +
                     "$(\"[id$=Txt_ChargeWeight]\").val((($(\"[id$=Txt_NoOfPackage]\").val()) * (($(\"[id$=Txt_CFT]\").val()))).toFixed(2));" +
                     "$(\"[id$=Txt_ChargeWeight]\").attr(\"disabled\",\"disabled\");" +
                     "console.log((($(\"[id$=Txt_NoOfPackage]\").val()) * (($(\"[id$=Txt_CFT]\").val()) * 10)).toFixed(2));" +
                    "});";

        string EditCFT = "$('.EditCFT').change(function() {" +
                "var unit;" +
                 "console.log($(\"[id$=Ddl_EditUnit]\").children(\"option:selected\").val());" +
                 "console.log($(\"[id$=Txt_EditLength]\").val());" +
                 "console.log($(\"[id$=Txt_EditBreadth]\").val());" +
                 "console.log($(\"[id$=Txt_EditHeight]\").val());" +
                 "if ($(\"[id$=Ddl_EditUnit]\").children(\"option:selected\").val() != \"SELECT\" && $(\"[id$=Txt_EditLength]\").val() != \"\" && $(\"[id$=Txt_EditBreadth]\").val() != \"\" && $(\"[id$=Txt_EditHeight]\").val() != \"\") {" +
                 "if ($(\"[id$=Ddl_EditUnit]\").children(\"option:selected\").val() == \"CM\") { unit = 27000 } else { unit = 1728 }" +
                 
                   "if($(\"[id$=Ddl_CustomerType]\").val()==\"CORPORATE\"){" +
                       "if($(\"[id$=hfCFTValue]\").val()!=\"\"){" +
                         "$(\"[id$=Txt_EditCFT]\").val((($(\"[id$=Txt_EditLength]\").val() * $(\"[id$=Txt_EditBreadth]\").val() * $(\"[id$=Txt_EditHeight]\").val() * $(\"[id$=hfCFTValue]\").val()) / unit).toFixed(5));" +
                       "}" +
                       "else{" +
                        "$(\"[id$=Txt_EditCFT]\").val((($(\"[id$=Txt_EditLength]\").val() * $(\"[id$=Txt_EditBreadth]\").val() * $(\"[id$=Txt_EditHeight]\").val() * 10) / unit).toFixed(5));" +
                       "}" +
                   "}" +
                   "else{" +
                    "$(\"[id$=Txt_EditCFT]\").val((($(\"[id$=Txt_EditLength]\").val() * $(\"[id$=Txt_EditBreadth]\").val() * $(\"[id$=Txt_EditHeight]\").val() * 10) / unit).toFixed(5));" +
                   "}" +

                  "$(\"[id$=Txt_EditCFT]\").attr(\"disabled\",\"disabled\");" +
                  "$(\"[id$=Txt_EditNoOfPackage]\").val(\"\");" +
                 "}" +
                 "});";


        string EditchargeW8 = "$(\"[id$=Txt_EditNoOfPackage]\").change(function() {" +
                    "$(\"[id$=Txt_EditChrgWeight]\").val((($(\"[id$=Txt_EditNoOfPackage]\").val()) * (($(\"[id$=Txt_EditCFT]\").val()))).toFixed(2));" +
                    "$(\"[id$=Txt_EditChrgWeight]\").attr(\"disabled\",\"disabled\");" +
                    "console.log((($(\"[id$=Txt_EditNoOfPackage]\").val()) * (($(\"[id$=Txt_EditCFT]\").val()) * 10)).toFixed(2));" +
                   "});";      

        #region    

        string strDataTable = "$(function() {" + "\n" +
                      "var Index=0;" + "\n" +
                      "var temp=0;" +
                      
       "$(\"[id*=Btn_AddWaybillItem]\").click(function() {" + "\n" +
        "var totalWeight=0;" +
         "var finalFreightCharge;" +
   
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

       "var linkDelete= '<a href=\"\" class=\"remove\" ><i style=\"font - size: 25px; color: red\" class=\"fa fa-trash\"></i></a>';" +
       //  "var linkDelete= '<input type=\"button\" id=\"\" onclick=\"CallMe('+Index+');\" value=\"Delete\">';" + "\n" +
       "SetValue1(row, 20, \"Delete\", linkDelete);" + "\n" +

       "var AW = parseInt($(\"[id*=Txt_ActWeight]\").val(),10);" + "\n" +
       "var CW = parseInt($(\"[id*=Txt_ChargeWeight]\").val(),10);" + "\n" +

       //   "if (AW > CW){ alert(\"Actual weight is larger\"); return true; } else{ gridView.append(row); }" +

       "if (AW > CW){ " +
        "$(\"[id$=Txt_ChargeWeight]\").val(AW);" +
		//"if (Index == 1){ " +	
        //   "console.log(\"Index1:\"+Index);" +	
            // "alert(\"Actual weight is larger\"); " +	
       		//"return true; " +	
       	//"} else{" +	
        // "console.log(\"IndexNot1:\"+Index);" +	
            //"SetValue(row, 0, \"Index\", Index);" + "\n" +	
        	//"alert(\"Actual weight is larger\"); " +	
       		//"return false; " +	
       	//" }" +	
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

                  "SubDetail.MaterialID=         $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.PackageID =         $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Unit =              $(this).find(\"td\").eq(5).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Length =            $(this).find(\"td\").eq(6).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Breadth =           $(this).find(\"td\").eq(7).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.Height =            $(this).find(\"td\").eq(8).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.CFT =               $(this).find(\"td\").eq(9).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.ActualWeight=       $(this).find(\"td\").eq(10).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.ChargeWeight =      $(this).find(\"td\").eq(11).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.NoOfPackage =       $(this).find(\"td\").eq(12).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.NoOfInnerPackage =  $(this).find(\"td\").eq(13).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.InvoiceNo =         $(this).find(\"td\").eq(14).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.InvoiceDate =       $(this).find(\"td\").eq(15).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.InvoiceValue =      $(this).find(\"td\").eq(16).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.EWaybillNo =        $(this).find(\"td\").eq(17).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.EWaybillDate =      $(this).find(\"td\").eq(18).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.EWaybillExpiryDate =$(this).find(\"td\").eq(19).find(\"input\").eq(0).val();" + "\n" +
                  "SubDetail.txtDeleteNo =       $(this).find(\"td\").eq(20).find(\"input\").eq(0).val();" + "\n" +
                "if (SubDetail.Unit != \"KG\"){" + "\n" +
                "var unit;" + "\n" +
                "if(SubDetail.Unit == \"CM\"){unit=6000}else{unit= 1728}" + "\n" +
                "SubDetail.KgperItem = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;" + "\n" +
                "}else{" + "\n" +
                "SubDetail.KgperItem = 0;" + "\n" +
                "}" + "\n" +
    
        "$(\"[id*=hfInvoiceNo]\").val(SubDetail.InvoiceNo);" + "\n" +
        "$(\"[id*=hfInvoiceDate]\").val(SubDetail.InvoiceDate);" + "\n" +
        "$(\"[id*=hfInvoiceValue]\").val(SubDetail.InvoiceValue);" + "\n" +
        "$(\"[id*=hfEwaybillNo]\").val(SubDetail.EWaybillNo);" + "\n" +
        "$(\"[id*=hfEwaybillDate]\").val(SubDetail.EWaybillDate);" + "\n" +
        "$(\"[id*=hfEwaybillExpiryDate]\").val(SubDetail.EWaybillExpiryDate);" + "\n" +
        "var chargeweight=(SubDetail.ChargeWeight);" +
      //  "chargeweight.toFixed(2);" +

         "if (Index == 1){ " +
           "totalWeight = chargeweight;" + "\n" +
       "} else{" +
          "totalWeight = parseFloat($(\"[id*=Txt_Weight]\").val(),10) + parseFloat(chargeweight,10);" + "\n" +          
       " }" +

        "if ($(\"[id$=Ddl_PaymentMode]\").val() != \"FREE\"){ " +
         "var freightCharge = (totalWeight * $(\"[id$=Txt_Rate]\").val());" +
         "finalFreightCharge = freightCharge.toFixed(2);" +
         "console.log(\"Freight charges:\"+finalFreightCharge);" +
           "}" +
        //++++++++++++++++++++++++++++++
        "PickReqDetail.push(SubDetail);" + "\n" +
                 "return false;" +

                "}" + "\n" +

        "});" + "\n" +

          "});" + "\n" +
        "console.log(PickReqDetail);" +
        "var paymentMode= $(\"[id$=Ddl_PaymentMode]\").val();" +
           "if (paymentMode != \"FREE\"){ " +
             "InvoiceDetailForWalkinUpdateValue(finalFreightCharge,paymentMode);" +
           "}" +
        "$(\"[id*=Txt_Weight]\").val(totalWeight);" + "\n" +

       "$(\"[id*=hfWaybillSubmit]\").val(1);" + "\n" +
       "MaterialID.val(\"\");" + "\n" +
       "MaterialType.val(\"\");" + "\n" +
       "PackageID.val(\"\");" + "\n" +
       "PackageType.val(\"\");" + "\n" +
       "Unit.val(\"INCH\");" + "\n" +
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
       "$(\"[id*= Txt_CustCode]\").attr(\"disabled\", \"disabled\");" + "\n" +
       "$(\"[id*= Txt_CCustName]\").attr(\"disabled\", \"disabled\");" + "\n" +
       "$(\"[id*= Txt_WCustName]\").attr(\"disabled\", \"disabled\");" + "\n" +
       "$(\"[id*= Txt_CustMobileNo]\").attr(\"disabled\", \"disabled\");" + "\n" +
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


          "function SetValue1(row, index, name, textbox)" + "\n" +
       "{" + "\n" +
       "row.find(\"td\").eq(index).html(textbox);" + "\n" +
       "var input = $(\"<input type = 'hidden' />\");" + "\n" +
       "input.prop(\"name\", name);" + "\n" +
       //     "input.val(textbox.val());" + "\n" +
       "row.find(\"td\").eq(index).append(input);" + "\n" +

        "}" + "\n" +

     // Delete a record
        "$(\"[id*=GV_WaybillDetail]\").on('click', 'a.remove', function(e) {" +
           " e.preventDefault();" +
              " DeleteDetails($(this).closest(\"tr\"));" + "\n" +

             "if ($(\"[id*=Txt_Weight]\").val()==\"0.00\") {" + "\n" +         
                "console.log(\"blank row\");" +
                "console.log(7856);" +
                "var newRow = \"<tr><td class='gvItemStyle'></td><td class='hidden'></td><td class='gvItemStyle'></td><td class='hidden'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td></tr>\";" +
                "$(\"[id*=GV_WaybillDetail]\").append(newRow);" +
                "}" +

        "} );" +

         " function DeleteDetails(row) {" +
            "var message = \"\";" +
            "message += 'Are you sure you wish to remove this record?'," + "\n" +
            "message += \"  \" + \"Material: \" + $(\"td\", row).eq(0).find(\"input\").eq(0).val();" +
            "console.log($(\"td\", row).eq(11).find(\"input\").eq(0).val());" +
            "message += \"  \" + $(\"td\", row).eq(2).find(\"input\").eq(0).val();" +

           " if (confirm(message))" +
            " {" +
                  "var chargeWeight = ($(\"td\", row).eq(11).find(\"input\").eq(0).val());" +
                  "var totalWeight = parseFloat($(\"[id*=Txt_Weight]\").val(),10) - parseFloat(chargeWeight,10);" +
                  "var finalTotalWeight=totalWeight.toFixed(2);" +
                    "console.log(totalWeight);" +
                  "$(\"[id*=Txt_Weight]\").val(finalTotalWeight);" + "\n" +
                    "var freightCharge = (finalTotalWeight * $(\"[id$=Txt_Rate]\").val());" +
                     "finalFreightCharge = freightCharge.toFixed(2);" +
                     "var paymentMode= $(\"[id$=Ddl_PaymentMode]\").val();" +
                     "if (paymentMode != \"FREE\"){ " +
                       "InvoiceDetailForWalkinUpdateValue(finalFreightCharge,paymentMode);" +
                     "}" +
                   
                   "row.remove(); return true;" +

             //   "if(!$(\"[id*=GV_WaybillDetail] tr\").length)" +

             "}" + "\n" +
           " else{return false}" +


         " }" +
        "}),";

        String savedata = "$(function () {" + "\n" +
                "$(\"[id*=Button_Submit]\").bind(\"click\", function() {" + "\n" +
                 "var hfWaybillSubmit = $(\"[id*=hfWaybillSubmit]\");" + "\n" +
                 "console.log(hfWaybillSubmit.val());" +
        #region
                "if(hfWaybillSubmit.val()==1){" + "\n" +
                "$(\"[id*=LoadingImage]\").show();" + "\n" +
                "var PickReqHeader = { };" + "\n" +
                "var PickReqDetail=[];var Count;" +
                 "var pickReqInvoice=[];var Count1;" +

               "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
                "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
                "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
                "PickReqHeader.CustType = $(\"[id*=Ddl_CustomerType]\").val();" + "\n" +
                "PickReqHeader.PaymentMode= $(\"[id*=Ddl_PaymentMode]\").val();" + "\n" +
                "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
                "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
                "PickReqHeader.walkinCustId=0;" + "\n" +
                "}" + "\n" +
                "else{PickReqHeader.walkinCustId =$(\"[id$=hfWCustID]\"). val();" + "\n" +
                 "console.log('Consignor ID :- '+$(\"[id$=hfWCustID]\").val());" +
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
                "PickReqHeader.ConsigneeID=$(\"[id$=hfConsigneeID]\").val();" + "\n" +
                "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
                "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
                "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
                "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
                "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +              

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
                        "if(SubDetail.Unit == \"CM\"){unit=6000}else{unit=1728}" + "\n" +
                        "SubDetail.KgperItem = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;" + "\n" +
                        "}else{" + "\n" +
                        "SubDetail.KgperItem = 0;" + "\n" +
                        "}" + "\n" +
                        "PickReqDetail.push(SubDetail);" + "\n" +
                        "t+=\",\"+$(this).find(\"td\").eq(0).find(\"input\").eq(0).val();" +
                        "}" +
                "}" +
        "});" + "\n" +

        //Invoice Details
         "if(PickReqHeader.PaymentMode!=\"FREE\"){" + "\n" +             

                "t1=0;" +

                "$(\"[id*=GV_Invoice] tr\").each(function() {" + "\n" +
                "Count1=($(this).length)-1;" + "\n" +
                "if (!this.rowIndex) return;" + "\n" +
                "var SubDetail1={};" + "\n" +

                "console.log(\"length:\"+$(this).length);" + "\n" +
                "if ($.trim($(this).find(\"td\").eq(1).html()) == \"&nbsp;\" || $(this).find(\"td\").eq(1).find(\"input\").eq(0).val() ==\"\") {" + "\n" +
                "}else{" + "\n" +
                "console.log(\"R1:\"+$(this).find(\"td\").eq(1).html());" + "\n" +
                "console.log(\"R2:\"+$(this).find(\"td\").eq(1).find(\"input\").eq(0).val());" + "\n" +
                "console.log(\"t1:\"+t1);" + "\n" +
                  "t1+=\",\"+0;" + "\n" +
                 "var a = t1.indexOf($(this).find(\"td\").eq(0).html());" + "\n" +
               //   "var a = t1.indexOf($(this).find(\"td\").eq(0).find(\"input\").eq(0).val());" + "\n" +
                 "console.log(\"a:\" + a);" + "\n" +
                   "if(a == -1 && $.trim($(this).find(\"td\").eq(0).html()) != \"&nbsp;\" )" + "\n" +
                   "{" +
                        "SubDetail1.RateID= $(this).find(\"td\").eq(1).html();" + "\n" +
                        "SubDetail1.Value = $(this).find(\"td\").eq(3).find(\"input\").eq(0).val();" + "\n" +
                        "pickReqInvoice.push(SubDetail1);" + "\n" +
                        "t1+=\",\"+$(this).find(\"td\").eq(0).html();" + "\n" +
                       //  "t1+=\",\"+$(this).find(\"td\").eq(0).find(\"input\").eq(0).val();" + "\n" +
                   "}" +
                "}" + //else
        "});" + "\n" +

             "}" + "\n" +



        "console.log(PickReqHeader);" +
        "console.log(PickReqDetail);" +
         "console.log(pickReqInvoice);" +

        "$.ajax({" + "\n" +
        "url: \"PickReqWareHouse.aspx/SavePickReqData\"," + "\n" +
        "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + ', pickReqInvoice:' + JSON.stringify(pickReqInvoice) + '}'," + "\n" +
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
                 "$.ajax({" + "\n" +
                            "type: \"POST\"," + "\n" +
                            "url: 'PickReqWareHouse.aspx/CheckWaybillMaterialDetails'," + "\n" +
                            "data: '{waybillId: \"' + data + '\" }'," + "\n" +
                            "contentType: 'application/json'," + "\n" +
                            "dataType: \"json\"," + "\n" +
                            "success: function(response) {" + "\n" +
                            "var data1 = response.d;" + "\n" +
                            "$.each(data1, function(index, item) {" + "\n" +
                            "console.log(item.split('ʭ')[0]);" +
                                "if (item.split('ʭ')[0] == '1')" + "\n" +
                                "{" + "\n" +
                                      // "clearData();" + "\n" +
                                      "$(\"[id*=LoadingImage]\").hide();" + "\n" +

                                      // "if()"+
                                      // alert msg
                                      "newFunction(\"Button_Tab1Save\",\"SAVE\")" + "\n" +

                                     // "alert(\"Data Added Successfully...\");" + "\n" +
                                     // For clear Query String value from url
                                     " var uri = window.location.toString();" +
                                     "if (uri.indexOf(\"?\") > 0)" +
                                     "{" +
                                      "var clean_uri = uri.substring(0, uri.indexOf(\"?\"));" +
                                      "window.history.replaceState({ }, document.title, clean_uri);" +
                                     " }" +
                                     "location.reload(true);" + "\n" +  // for reload page after submition
                                                       "}" + "\n" +
                                "else{" + "\n" +
                                      "alert(\"Data could not Submitted...\");" + "\n" +
                                      "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                                  "}" + "\n" +
                               "});" + "\n" +
                             "}" + "\n" +
                           "});" + "\n" +//end ajax
             
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
        "function clearData() {" + "\n" +
       "console.log(\"clear\");" + "\n" +
       "$(\"[id*=Txt_WaybillNo]\").val(\"\");" + "\n" +
        "$(\"[id*=Ddl_PickType]\").val(\"GODOWN\");" + "\n" +
       "$(\"[id*=Ddl_CustomerType]\").val(\"CORPORATE\");" + "\n" +
       "$(\"[id*=Ddl_PaymentMode]\").val(\"CREDIT\");" + "\n" +
       "$(\"[id*=Txt_CustCode]\").val(\"\");" + "\n" +
       "$(\"[id*=hfCustID]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_CCustName]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_WCustName]\").val(\"\");" + "\n" +
       "$(\"[id*=hfWCustID]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_CustMobileNo]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_CustTelephoneNo]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_EmailId]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_CustPin]\").val(\"\");" + "\n" +
       "$(\"[id*=hfCustPinID]\").val(\"\");" + "\n" +
       "$(\"[id*=Ddl_CustArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
       "$(\"[id*=Txt_CustAdd]\").val(\"\");" + "\n" +
       "$(\"[id*=SameAdd]\").prop(\"checked\", false);" + "\n" +
       "$(\"[id$=Txt_EmailId]\").removeAttr(\"disabled\");" + "\n" +
       "$(\"[id$=Txt_CustPin]\").removeAttr(\"disabled\");" + "\n" +
       "$(\"[id$=Ddl_CustArea]\").removeAttr(\"disabled\");" + "\n" +
       "$(\"[id$=Txt_CustAdd]\").removeAttr(\"disabled\");" + "\n" +
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
       "$(\"[id*=Txt_EWaybillNo]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_EWaybillDate]\").val(\"\");" + "\n" +
       "$(\"[id *=Txt_EWaybillDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
       "$(\"[id*=Txt_EWaybillExpiryDate]\").val(\"\");" + "\n" +
       "AddGridviewRow();" +
       "$(\"[id*=hfWaybillSubmit]\").val(0);" + "\n" +
        "};" +
         // function for Add Blank DataTable Row after Submit
         "function AddGridviewRow()" +
                "{" +
                    "var hfWaybillSubmit = $(\"[id*=hfWaybillSubmit]\");" + "\n" +
                    "console.log(\"add\"+hfWaybillSubmit);" +
                    "if(hfWaybillSubmit.val() !=0){" +
                    "var gridView = $(\"[id*=GV_WaybillDetail]\");" + "\n" +
                    "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                    "$(\"[id*=GV_WaybillDetail]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
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

         string FillWaybillDetails = "$(function () {" + "\n" +
              "$(\"[id*=Btn_EditData]\").bind(\"click\", function() {" + "\n" +
                "var hdnEditWayBill = $(\"[id*=hdnEditWayBill]\");" + "\n" +
                 "console.log(hdnEditWayBill.val());" +
                  "if(hdnEditWayBill.val()==1){" + "\n" +
                  "var EditWayBillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
                   "$.ajax({" + "\n" +
                     "type: \"POST\"," + "\n" +
                     "url: 'PickReqWareHouse.aspx/GetBranchAndManifest'," + "\n" +
                     "data: '{WaybillNo: \"' + EditWayBillNo + '\" }'," + "\n" +
                     "contentType: 'application/json'," + "\n" +
                     "dataType: \"json\"," + "\n" +
                     "success: function(response) {" + "\n" +
                     "var data = response.d;" + "\n" +
                     "$.each(data, function(index, item) {" + "\n" +
                     "console.log(item.split('ʭ')[0]);" +
                         "if (item.split('ʭ')[0] != 'EDIT')" + "\n" +
                         "{" + "\n" +
                         /////////////////////////////
                           "$.ajax({" + "\n" +
                           "type: \"POST\"," + "\n" +
                           "url: 'PickReqWareHouse.aspx/GetUserForEditManifest'," + "\n" +
                           "data: '{}'," + "\n" +
                           "contentType: 'application/json'," + "\n" +
                           "dataType: \"json\"," + "\n" +
                           "success: function(response) {" + "\n" +
                           "var data1 = response.d;" + "\n" +
                           "$.each(data1, function(index1, item1) {" + "\n" +
                           "console.log(item1.split('ʭ')[0]);" +
                               "if (item1.split('ʭ')[0] == 'DO NOT EDIT')" + "\n" +
                               "{" + "\n" +
                                  "$(\"[id*=Lbl_ErrorMsg]\").text(item.split('ʭ')[0]);" + "\n" +
                                   "$(\"[id*=Lbl_ErrorMsg]\").show();" + "\n" +
                               "}" + "\n" +
                               "else{" + "\n" +
                                  "WaybillEdit(EditWayBillNo);" + "\n" +
                                  "$(\"[id*=Lbl_ErrorMsg]\").hide();" + "\n" +
                                 "}" + "\n" +
                              "});" + "\n" +
                            "}" + "\n" +
                           "});" + "\n" +//end ajax
                        ////////////////////////////         
                            //"$(\"[id*=Lbl_ErrorMsg]\").text(item.split('ʭ')[0]);" + "\n" +
                            //"$(\"[id*=Lbl_ErrorMsg]\").show();" + "\n" +
                         "}" + "\n" +
                         "else{" + "\n" +
                            "WaybillEdit(EditWayBillNo);" + "\n" +
                            "$(\"[id*=Lbl_ErrorMsg]\").hide();" + "\n" +
                           "}" + "\n" +
                        "});" + "\n" +
                      "}" + "\n" +
                    "});" + "\n" +//end ajax
                  "}" + "\n" +
                "});" + "\n" +
            "})," + "\n";

        string UpdateWaybillDetails = "$(function () {" + "\n" +
            "$(\"[id*=Btn_WaybillUpdate]\").bind(\"click\", function() {" + "\n" +
              "var hfWaybillUpdate = $(\"[id*=hfWaybillUpdate]\");" + "\n" +
               "console.log(hfWaybillUpdate.val());" +
                "if(hfWaybillUpdate.val()==1){" + "\n" +

                "$(\"[id*=LoadingImage]\").show();" + "\n" +
                "var PickReqHeader = { };" + "\n" +
        #region
                "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
                "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
                "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
                "PickReqHeader.CustType = $(\"[id*=Ddl_CustomerType]\").val();" + "\n" +
                "PickReqHeader.PaymentMode= $(\"[id*=Ddl_PaymentMode]\").val();" + "\n" +
                "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
                "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
                "PickReqHeader.walkinCustId=0;" + "\n" +
                "}" + "\n" +
                "else{PickReqHeader.walkinCustId =$(\"[id$=hfWCustID]\"). val();" + "\n" +
                 "console.log('Consignor ID :- '+$(\"[id$=hfWCustID]\").val());" +
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
                "PickReqHeader.ConsigneeID=$(\"[id$=hfConsigneeID]\").val();" + "\n" +
                "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
                "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
                "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
                "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
                "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
        #endregion
                    "$.ajax({" + "\n" +
                    "url: \"PickReqWareHouse.aspx/UpdatePickReqData\"," + "\n" +
                    "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + '}'," + "\n" +
                    "type: \"POST\"," + "\n" +
                    "dataType: \"json\"," + "\n" +
                    "contentType: \"application/json; charset=utf-8\"," + "\n" +
        #region
                    "success: function(response) {" + "\n" +
                    "var data=response.d;" + "\n" +
                    "console.log(\"data:\"+ data);" + "\n" +
        #region
                    "if(data == -1)" +
                    "{" +
                        "alert(\"Data could not Update...\");" + "\n" +
                        "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                    "}" +
                    "else{" +
                            "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                            // alert msg
                            "newFunction(\"Button_Tab1Save\",\"UPDATE\")" + "\n" +
                           // For clear Query String value from url
                           " var uri = window.location.toString();" +
                           "if (uri.indexOf(\"?\") > 0)" +
                           "{" +
                            "var clean_uri = uri.substring(0, uri.indexOf(\"?\"));" +
                            "window.history.replaceState({ }, document.title, clean_uri);" +
                           " }" +
                           "location.reload(true);" + "\n" +  // for reload page after submition
                         "}" +
        #endregion
                     "}," + "\n" + //  // end of success
                      "error: function(response) {" + "\n" +
                            "alert(response.responseText);" + "\n" +
                             "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                      "}," + "\n" + // end of error
                      "failure: function(response) {" + "\n" +
                      "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                      "alert(response.responseText);" + "\n" +
                     "}" + "\n" +  // end of failure
        #endregion
                    "});" + "\n" +  // end of ajax
                  "}" + "\n" + // end  if(hfWaybillUpdate.val()==1)
                  "return false;" + "\n" +
                  "});" + "\n" + // end button click
             "}),"; // end function

        string UpdateWaybillMaterialDetails = "$(function () {" + "\n" +
           "$(\"[id*=Btn_MaterialUpdate]\").bind(\"click\", function() {" + "\n" +
             "var hfMaterialUpdate = $(\"[id*=hfMaterialUpdate]\");" + "\n" +
              "console.log(hfMaterialUpdate.val());" +
               "if(hfMaterialUpdate.val()==1){" + "\n" +

               "$(\"[id*=LoadingImage]\").show();" + "\n" +
               "var SubDetail = { };" + "\n" +
        #region 
               "SubDetail.Id=                $(\"[id$=hfWaybillItemID]\").val();" + "\n" +
               "SubDetail.MaterialID=        $(\"[id$=hfMatID1]\").val();" + "\n" +
               "SubDetail.PackageID =        $(\"[id$=hfPackID1]\").val();" + "\n" +
               "SubDetail.Unit =             $(\"[id$=Ddl_EditUnit]\").val();" + "\n" +
               "SubDetail.Length =           $(\"[id$=Txt_EditLength]\").val();" + "\n" +
               "SubDetail.Breadth =          $(\"[id$=Txt_EditBreadth]\").val();" + "\n" +
               "SubDetail.Height =           $(\"[id$=Txt_EditHeight]\").val();" + "\n" +
               "SubDetail.CFT =              $(\"[id$=Txt_EditCFT]\").val();" + "\n" +
               "SubDetail.ActualWeight=      $(\"[id$=Txt_EditActWeight]\").val();" + "\n" +
               "SubDetail.ChargeWeight=      $(\"[id$=Txt_EditChrgWeight]\").val();" + "\n" +
               "SubDetail.NoOfPackage =      $(\"[id$=Txt_EditNoOfPackage]\").val();" + "\n" +
               "SubDetail.NoOfInnerPackage = $(\"[id$=Txt_EditNoOfInnerPakage]\").val();" + "\n" +
               "SubDetail.InvoiceNo =        $(\"[id$=Txt_EditInvoiceNo]\").val();" + "\n" +
               "SubDetail.InvoiceDate =      $(\"[id$=Txt_EditInvoiceDate]\").val();" + "\n" +
               "SubDetail.InvoiceValue =     $(\"[id$=Txt_EditInvoiceValue]\").val();" + "\n" +
                "if (SubDetail.EWaybillNo != \"NA\"){" + "\n" +
                  "SubDetail.EWaybillNo =        $(\"[id$=Txt_EditEWaybillNo]\").val();" + "\n" +
                  "SubDetail.EWaybillDate =      $(\"[id$=Txt_EditEWaybillDate]\").val();" + "\n" +
                  "SubDetail.EWaybillExpiryDate =$(\"[id$=Txt_EditEWaybillExpiryDate]\").val();" + "\n" +
                "}else{" + "\n" +
                 "SubDetail.EWaybillNo = (\"NA\");" + "\n" +
                 "SubDetail.EWaybillDate =      (\"\");" + "\n" +
                 "SubDetail.EWaybillExpiryDate =(\"\");" + "\n" +
                  "}" + "\n" +
               "if (SubDetail.Unit != \"KG\"){" + "\n" +
               "var unit;" + "\n" +
               "if(SubDetail.Unit == \"CM\"){unit=6000}else{unit=1728}" + "\n" +
               "SubDetail.KgperItem = ((SubDetail.Length * SubDetail.Breadth * SubDetail.Height) / unit) * SubDetail.CFT;" + "\n" +
               "}else{" + "\n" +
               "SubDetail.KgperItem = 0;" + "\n" +
               "}" + "\n" +

        #endregion
                    "$.ajax({" + "\n" +
                   "url: \"PickReqWareHouse.aspx/UpdatePickReqMaterialData\"," + "\n" +
                   "data: '{PickDetails: ' + JSON.stringify(SubDetail) + '}'," + "\n" +
                   "type: \"POST\"," + "\n" +
                   "dataType: \"json\"," + "\n" +
                   "contentType: \"application/json; charset=utf-8\"," + "\n" +
        #region
                    "success: function(response) {" + "\n" +
                   "var data=response.d;" + "\n" +
                   "console.log(\"data:\"+ data);" + "\n" +
        #region
                    "if(data == -1)" +
                   "{" +
                       "alert(\"Data could not Update...\");" + "\n" +
                       "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                   "}" +
                   "else{" +
                           "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                           // alert msg
                           "newFunction(\"Button_Tab1Save\",\"UPDATE\")" + "\n" +
                           // For clear Query String value from url
                           " var uri = window.location.toString();" +
                           "if (uri.indexOf(\"?\") > 0)" +
                           "{" +
                            "var clean_uri = uri.substring(0, uri.indexOf(\"?\"));" +
                            "window.history.replaceState({ }, document.title, clean_uri);" +
                           " }" +
                           "location.reload(true);" + "\n" +  // for reload page after submition
                                                              // "ClearData();"+ 
                        "}" +
        #endregion
                     "}," + "\n" + //  // end of success
                     "error: function(response) {" + "\n" +
                           "alert(response.responseText);" + "\n" +
                            "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                     "}," + "\n" + // end of error
                     "failure: function(response) {" + "\n" +
                     "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                     "alert(response.responseText);" + "\n" +
                    "}" + "\n" +  // end of failure
        #endregion
                    "});" + "\n" +  // end of ajax
                 "}" + "\n" + // end  if(hfWaybillUpdate.val()==1)
                 "return false;" + "\n" +
                 "});" + "\n" + // end button click

                  "function ClearData()" + "\n" +
                    "{" + "\n" +
                       "$(\"[id$=hfWaybillItemID]\").val(\"\");" + "\n" +
                       "$(\"[id$=Ddl_WaybillItemID]\").val(\"SELECT\");" + "\n" +
                       "$(\"[id$=Txt_MatType1]\").val(\"\");" + "\n" +
                       "$(\"[id$=hfMatID1]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_PackType1]\").val(\"\");" + "\n" +
                       "$(\"[id$=hfPackID1]\").val(\"\");" + "\n" +
                       "$(\"[id$=Ddl_EditUnit]\").val(\"SELECT\");" + "\n" +
                       "$(\"[id$=Txt_EditLength]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditBreadth]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditHeight]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditCFT]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditNoOfPackage]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditNoOfInnerPakage]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditActWeight]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditChrgWeight]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditInvoiceNo]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditInvoiceDate]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditInvoiceValue]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditEWaybillNo]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditEWaybillDate]\").val(\"\");" + "\n" +
                       "$(\"[id$=Txt_EditEWaybillExpiryDate]\").val(\"\");" + "\n" +
                       "$(\"[id*=hfMaterialUpdate]\").val(0);" + "\n" +
                    "}" + "\n" + // end clearData
            "}),"; // end function
        #endregion

        CFunctions.setjavascript(CFunctions.javascript + str + CFT + chargeW8 + EditCFT + EditchargeW8 + strDataTable + savedata + FillWaybillDetails + UpdateWaybillDetails + UpdateWaybillMaterialDetails);
        SaveJavaScriptConsignorConsignee("LoadingImage", "CONSIGNOR", "hfPopupConsignorSubmit", "Btn_PopupConsignorSubmit", "Txt_PopupConsignorName", "Txt_PopupContactNo", "hfPopupConsignorPincode", "Txt_PopupConsignorPincode", "Ddl_PopupConsignorArea", "Txt_PopupConsignorAddress", "Txt_PopupConsignorGST",
                                                                                                                            "hfWCustID", "Txt_WCustName", "Txt_CustMobileNo", "hfCustPinID", "Txt_CustPin", "Ddl_CustArea", "Txt_CustAdd");
        SaveJavaScriptConsignorConsignee("LoadingImage", "CONSIGNEE", "hfConsigneeSubmit", "Btn_ConsigneeSubmit", "Txt_PopConsigneeName", "Txt_PopConsigneeContactNo", "hfPopConsigneePincode", "Txt_PopConsigneePincode", "Ddl_PopConsigneeArea", "Txt_popConsigneeAddress", "Txt_PopGSTNoOfConsignee",
                                                                                                                  "hfConsigneeID", "Txt_ConsigneeName", "Txt_ConsigneeContNo", "hfDelPinID", "Txt_DelPin", "Ddl_DelArea", "Txt_DelAdd");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_CustPin", "hfCustPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PickPin", "hfPickPinID", "PickReqCRMBranch.aspx/getConsignorPincode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_DelPin", "hfDelPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_MaterialType", "hfMaterialID", "PickReqCRMBranch.aspx/getMaterial", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PackageType", "hfPackageID", "PickReqCRMBranch.aspx/getPackages", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_MatType1", "hfMatID1", "PickReqCRMBranch.aspx/getMaterial", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PackType1", "hfPackID1", "PickReqCRMBranch.aspx/getPackages", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_CustCode", "hfCustID", "PickReqCRMBranch.aspx/getCustomerCode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_CCustName", "hfCustID", "PickReqCRMBranch.aspx/getCustName", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_ConsigneeName", "hfConsigneeID", "PickReqCRMBranch.aspx/getConsigneeName", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PopupConsignorPincode", "hfPopupConsignorPincode", "PickReqCRMBranch.aspx/getConsignorPincode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_PopConsigneePincode", "hfPopConsigneePincode", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
      //  (new CFunctions()).GetJavascriptFunction(this, "Txt_RateType", "hfRateType", "PickReqWareHouse.aspx/getRateType", "GetData", "});");
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
                                                //"FillData();" + "\n" +
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
                      "console.log($(\"[id*='" + hfpincode + "']\").val());"+ "\n" +
                      "getDeliveryBranch('"+fillhfpincode+"');" + "\n" +
                      "$(\"[id*='" + filladdress + "']\").val($(\"[id*='" + address + "']\").val());" + "\n" +
                      "$(\"[id$= SameAdd]\").removeAttr(\"disabled\");" +
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
                      "$(\"[id*=Txt_PopConsigneeDistrict]\").val(\"AUTO\");" + "\n" +
                      "$(\"[id*=Txt_PopConsigneeCity]\").val(\"AUTO\");" + "\n" +
                      "$(\"[id*=Txt_PopupConsignorDistrict]\").val(\"AUTO\");" + "\n" +
                      "$(\"[id*=Txt_PopupConsignorCity]\").val(\"AUTO\");" + "\n" +
                    "};" +
                  "}),");
    }

    ////Dummy Entry
    //public DataTable DummyData()
    //{
    //    DataTable dt = new DataTable();
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
    //    dt.Columns.Add(new DataColumn("NoOfPackage", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("NoOfInnerPackage", typeof(Int32)));
    //    dt.Columns.Add(new DataColumn("InvoiceNo", typeof(String)));
    //    dt.Columns.Add(new DataColumn("InvoiceDate", typeof(String)));
    //    dt.Columns.Add(new DataColumn("InvoiceValue", typeof(Double)));
    //    dt.Rows.Add();
    //    return dt;
    //}
    // Get Pincode

    [WebMethod]
    public static string[] CheckWaybillNo(string waybillNo)
    {
        return (new PickReqFunctions()).getBranchStaionary(waybillNo, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] GetCurrentWaybillNo()
    {
        return (new PickReqFunctions()).GetCurrentWaybillNo(Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] GetPreviousWayBillNo()
    {
        return (new PickReqFunctions()).GetPreviousWayBillNo(Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] FillPickUPDataForWaybill(string strPickUpRequestId)
    {
        return (new PickReqFunctions()).LoadPickUpHeaderForWayBill(strPickUpRequestId);
    }
    //Get Account Name 
    [WebMethod]
    public static string[] getRateType(string searchPrefixText, string data)
    {
        return (new VehicleRequestFunction()).getWaybillRateType(searchPrefixText, data);
    }
    private void FillPickUPData(string strPickUpRequestId)
    {
        PickReq PR = (new PickReqFunctions()).LoadPickUpHeader(strPickUpRequestId);
        ((DropDownList)WaybillEntry.FindControl("Ddl_CustomerType")).Text = PR.CustType.ToString();      
        if (PR.CustType.ToString() == "CORPORATE")
        {
             WaybillEntry.FindControl("WalkinCustomerDiv").Visible = false;
            ((HiddenField)WaybillEntry.FindControl("hfCustID")).Value = PR.CustID.ToString();
            ((TextBox)WaybillEntry.FindControl("Txt_CustCode")).Text = PR.CustCode.ToString();
            ((TextBox)WaybillEntry.FindControl("Txt_CCustName")).Text = PR.CustName.ToString();
        }
        else
        {
            WaybillEntry.FindControl("CustomerCodeDiv").Visible = false;
            WaybillEntry.FindControl("CorporateCustomerDiv").Visible = false;
            WaybillEntry.FindControl("WalkinCustomerDiv").Visible = true;      
            ((HiddenField)WaybillEntry.FindControl("hfWCustID")).Value = PR.CustID.ToString();
            ((TextBox)WaybillEntry.FindControl("Txt_WCustName")).Text = PR.CustName.ToString();
        }

        ((TextBox)WaybillEntry.FindControl("Txt_CustMobileNo")).Text = PR.CustContactNo.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_CustTelephoneNo")).Text = PR.CustTelephone.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_EmailId")).Text = PR.CustEmailId.ToString();

        ((HiddenField)WaybillEntry.FindControl("hfCustPinID")).Value = PR.CustLocID.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_CustPin")).Text = PR.CustPINCode.ToString();
        ((DropDownList)WaybillEntry.FindControl("Ddl_CustArea")).SelectedValue = PR.CustAreaID.ToString();
        ((DropDownList)WaybillEntry.FindControl("Ddl_CustArea")).SelectedItem.Text = PR.CustArea.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_CustAdd")).Text = PR.CustAddress.ToString();

        ((HiddenField)WaybillEntry.FindControl("hfPickPinID")).Value = PR.PickLocID.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_PickPin")).Text = PR.PickPINCode.ToString();
        ((DropDownList)WaybillEntry.FindControl("Ddl_PickArea")).SelectedValue = PR.PickAreaID.ToString();
        ((DropDownList)WaybillEntry.FindControl("Ddl_PickArea")).SelectedItem.Text = PR.pickupArea.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_PickAdd")).Text = PR.PickAddress.ToString();
        ((HiddenField)WaybillEntry.FindControl("hfPickupBranch")).Value = PR.pickUpBranchId.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_PickupBranch")).Text = PR.PickupBranch.ToString();

        ((HiddenField)WaybillEntry.FindControl("hfConsigneeID")).Value = PR.ConsigneeID.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_ConsigneeName")).Text = PR.ConsigneeName.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_ConsigneeContNo")).Text = PR.ConsigneeContactNo.ToString();
        ((HiddenField)WaybillEntry.FindControl("hfDelPinID")).Value = PR.DelLocID.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_DelPin")).Text = PR.DelPINCode.ToString();
        ((DropDownList)WaybillEntry.FindControl("Ddl_DelArea")).SelectedValue = PR.DelAreaID.ToString();
        ((DropDownList)WaybillEntry.FindControl("Ddl_DelArea")).SelectedItem.Text = PR.DelArea.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_DelAdd")).Text = PR.DelAddress.ToString();
        ((HiddenField)WaybillEntry.FindControl("hfDeliveryBranch")).Value = PR.DelBranchId.ToString();
        ((TextBox)WaybillEntry.FindControl("Txt_DeliveryBranch")).Text = PR.DeliveryBranch.ToString();

        ((DropDownList)WaybillEntry.FindControl("Ddl_CustomerType")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_CustCode")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_CCustName")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_CustPin")).Enabled = false;
        ((DropDownList)WaybillEntry.FindControl("Ddl_CustArea")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_CustMobileNo")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_CustAdd")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_WCustName")).Enabled = false;
        ((CheckBox)WaybillEntry.FindControl("SameAdd")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_PickPin")).Enabled = false;
        ((DropDownList)WaybillEntry.FindControl("Ddl_PickArea")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_PickAdd")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_ConsigneeName")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_ConsigneeContNo")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_DelPin")).Enabled = false;
        ((DropDownList)WaybillEntry.FindControl("Ddl_DelArea")).Enabled = false;
        ((TextBox)WaybillEntry.FindControl("Txt_DelAdd")).Enabled = false;
        ((ImageButton)WaybillEntry.FindControl("Img_WCustName")).Enabled = false;
        ((ImageButton)WaybillEntry.FindControl("Img_ConsigneeName")).Enabled = false;

    }
   
    [WebMethod]
    public static string[] getPincode(string searchPrefixText, string data=null)
    {
        return (new CommFunctions()).getPincode(searchPrefixText, data);
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

    [WebMethod]
    public static string[] getDeliveryBranch(string pincode)
    {
        return (new PickReqFunctions()).getDeliveryBranch(pincode);
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
    public static string[] getCustomerCode(string searchPrefixText, string data=null)
    {
        return (new PickReqFunctions()).getCustomerCode(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    // Auto Fill details on Customer Code
    [WebMethod]
    public static string[] getCCustomerDetail(string customerID)
    {
        return (new PickReqFunctions()).getCCustomerDetail(customerID, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    //Get Corporate Customer Names
    [WebMethod]
    public static string[] getCustName(string searchPrefixText, string data=null)
    {
        return (new PickReqFunctions()).getCustName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    //Get Walkin Customer Names
    [WebMethod]
    public static string[] getWalkinCustName(string searchPrefixText, string data=null)
    {
        return (new PickReqFunctions()).getWalkinCustName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    //Auto Fill details on Walkin customer name
    [WebMethod]
    public static string[] getWCustomerDetail(string WcustID)
    {
        return (new PickReqFunctions()).getWCustomerDetail(WcustID);
    }
    //Get Corporate Customer Names
    [WebMethod]
    public static string[] getConsigneeName(string searchPrefixText,string data=null)
    {
        return (new PickReqFunctions()).getConsigneeName(searchPrefixText,data, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    //Auto Fill details on Consignee name
    [WebMethod]
    public static string[] getConsigneeNameDetail(string Name)
    {
        return (new PickReqFunctions()).getConsigneeNameDetail(Name);
    }
    //Get Material 
    [WebMethod]
    public static string[] getMaterial(string searchPrefixText,string data=null)
    {       
        return (new PickReqFunctions()).getMaterial(searchPrefixText,data, (HttpContext.Current.Application["custID"]).ToString());
    }
    [WebMethod]
    public static string[] getMaterialDetails(string materialId)
    {
        return (new PickReqFunctions()).getMaterialDetail(materialId);
    }
    //Get Packages
    [WebMethod]
    public static string[] getPackages(string searchPrefixText,string data=null)
    {
        return (new PickReqFunctions()).getPackages(searchPrefixText,data);
    }
    [WebMethod]
    public static string[] GetWaybillInvoice(string type)
    {
        return (new PickReqFunctions()).GetWaybillInvoice(type);
    }
    // Fill summary in View panel
    public void FillSummary()
    {
        PickSummary ps = new PickSummary();
        int branchId = Convert.ToInt32(Session["branchId"]);
        ps = new PickReqFunctions().getWaybillSummary(branchId);
        Lbl_TotalNoOfPackage.Text = ps.TotalPackage.ToString();
        Lbl_TotalWeight.Text = ps.TotalWeight.ToString();
    }
    /*----------------Fill Data in Gridview Code with sorting--------------------*/
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

            GV_ViewWaybillDetail.DataSource = (new PickReqFunctions()).SearchWaybillData(pr);
            GV_ViewWaybillDetail.DataBind();
        }
        else
            (new CFunctions()).showalert("Btn_Search", "SEARCH", this);
    }

    [WebMethod]
    public static int SaveConsignorConsignee(ConsingorConsignee Details)
    {
        return (new PickReqFunctions()).SaveConsignorConsignee(Details);
    }
    [WebMethod]
    public static int SavePickReqData(PickReq PickReqHeader, List<PickReqDetail> PickReqDetail, List<PickReqInvoice> pickReqInvoice)
    {      
        return (new PickReqFunctions()).SavePickupRequestWareHouse(PickReqHeader, PickReqDetail, pickReqInvoice);
    }
    protected void gridViewPickupRequestDetail_Sorting(object sender, GridViewSortEventArgs e)
    {
        // FillGrid(e.SortExpression);
    }
    protected void gridViewPickupRequestDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_ViewWaybillDetail.PageIndex = e.NewPageIndex;
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
    [WebMethod]
    public static string[] GetWaybillHeaderData(int WaybillId)
    {
        return (new PickReqFunctions()).LoadWaybillHeaderData(WaybillId);
    }
    [WebMethod]
    public static string[] GetWaybillDetailsData(int WaybillId)
    {
        return (new PickReqFunctions()).LoadWaybillDetailsData(WaybillId);
    }
    [WebMethod]
    public static string[] GetWaybillInvoiceDetailsData(int WaybillId)
    {
        return (new PickReqFunctions()).LoadWaybillInvoiceDetailsData(WaybillId);
    }
    [WebMethod]
    public static string[] GetWaybillHeaderDataForEdit(string WaybillNo)
    {
        return (new PickReqFunctions()).LoadWaybillHeaderDataForEdit(WaybillNo);
    }
    [WebMethod]
    public static string[] GetWaybillDetailsDataForEdit(string WaybillNo)
    {
        return (new PickReqFunctions()).LoadWaybillDetailsDataForEdit(WaybillNo);
    }
    //Get Waybill in Dropdown List
    [WebMethod]
    public static List<PickReqDetail> GetWaybillItemIDForEdit(string WaybillNo)
    {
        return (new PickReqFunctions()).getWaybillItemIDForEdit(WaybillNo);
    }
    // Fill Material and Package name
    [WebMethod]
    public static string[] getMaterialPackageName(int id)
    {
        return (new PickReqFunctions()).getMaterialPackageName(id);
    }
    [WebMethod]
    public static int UpdatePickReqData(PickReq PickReqHeader)
    {
        return (new PickReqFunctions()).UpdatePickupRequestWareHouse(PickReqHeader);
    }
    [WebMethod]
    public static int UpdatePickReqMaterialData(PickReqDetail PickDetails)
    {
        return (new PickReqFunctions()).UpdatePickupRequestWareHouseMaterial(PickDetails);
    }
    [WebMethod]
    public static string[] GetBranchAndManifest(string WaybillNo)
    {
        return (new PickReqFunctions()).GetBranchAndManifest(WaybillNo, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    [WebMethod]
    public static string[] GetUserForEditManifest()
    {
        return (new PickReqFunctions()).GetUserForEditManifest(Convert.ToInt32(HttpContext.Current.Session["userID"]));
    }
    [WebMethod]
    public static string[] CheckWaybillMaterialDetails(int waybillId)
    {
        return (new PickReqFunctions()).CheckWaybillDetails(waybillId);
    }   
}