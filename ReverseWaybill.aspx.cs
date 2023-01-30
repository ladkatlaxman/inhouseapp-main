using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReverseWaybill : System.Web.UI.Page
{   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                HttpContext.Current.Application["ReverseConsigneeName"] = null;
                HttpContext.Current.Application["consignorName"] = null;
                HttpContext.Current.Application["MaterialName"] = null;
                HttpContext.Current.Application["PackageName"] = null;
                HttpContext.Current.Application["ReverseWayBillNo"] = null;
            }
            else
                Response.Redirect("Login.aspx");

            string str = "$(\"[id*= CustomerCodeDiv]\").hide();" +
                 "$(\"[id*=CorporateCustomerDiv]\").show();" +
                 "$(\"[id*=WalkinCustomerDiv]\").hide();" +
                 "$(\"[id*=Btn_AddInSameInvoice]\").hide();" +
                 "$(\"[id*=Btn_Update]\").hide();" +
                 "$(\"[id*=Btn_EditData]\").hide();" +
                 "$(\"[id*=TelephoneNo]\").hide();" +
                 "$(\"[id*=InvoiceDetailDiv]\").hide();" +
                 "$(\"[id*=PrevWayBill]\").hide();" +
                 "$(\"[id*=Img_ConsigneeName]\").hide();" +
                 "$(\"[id*=divWaybill]\").hide();" +
                 "$(\"[id*=WaybillDetailsDiv]\").hide();" +                             
                 "$(\"[id*= SameAdd]\").attr(\"disabled\", \"disabled\");" +
                 "$(\"[id*= Ddl_PaymentMode]\").val(\"CREDIT\");" +
                 "$(\"[id*= Ddl_PaymentMode]\").attr(\"disabled\", \"disabled\");" +
                 "$(\"[id*=Txt_WaybillDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", new Date());" + "\n" +                
                 "CurrentWaybillNo();";

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
                       "SetValue1(row, 20, \"Delete\", linkDelete);" + "\n" +

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
                     
                        //++++++++++++++++++++++++++++++
                        "PickReqDetail.push(SubDetail);" + "\n" +
                                 "return false;" +

                                "}" + "\n" +

                        "});" + "\n" +

                          "});" + "\n" +
                        "console.log(PickReqDetail);" +
                       
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

            #region
                      "function SetValue1(row, index, name, textbox)" + "\n" +
                       "{" + "\n" +
                       "row.find(\"td\").eq(index).html(textbox);" + "\n" +
                       "var input = $(\"<input type = 'hidden' />\");" + "\n" +
                       "input.prop(\"name\", name);" + "\n" +
                       //     "input.val(textbox.val());" + "\n" +
                       "row.find(\"td\").eq(index).append(input);" + "\n" +

                        "}" + "\n" +
                  //------------------------CREATE NEW ROW FOR MATERIAL------------------------------
                  // function for Add Blank DataTable Row after Submit
                  "function AddGridviewRow()" +
                  "{" +
                  //"var hfWaybillSubmit = $(\"[id*=hfWaybillSubmit]\");" + "\n" +
                  //"console.log(\"add\"+hfWaybillSubmit);" +
                  //  "if(hfWaybillSubmit.val() !=0){" +
                    "console.log(\"addRow\");" +
                    "var gridView = $(\"[id*=GV_WaybillDetail]\");" + "\n" +
                    "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                    "$(\"[id*=GV_WaybillDetail]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
                    "Index=1;" + "\n" +
                     "console.log(\"Index\"+Index);" +
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
                    "var EWaybillNo = $(\"[id*=Txt_EWaybillNo]\");" + "\n" +
                    "SetValue(row, 17, \"EWaybillNo\", EWaybillNo);" + "\n" +
                    "var EWaybillDate = $(\"[id*=Txt_EWaybillDate]\");" + "\n" +
                    "SetValue(row, 18, \"EWaybillDate\", EWaybillDate);" + "\n" +
                    "var EWaybillExpiryDate = $(\"[id*=Txt_EWaybillExpiryDate]\");" + "\n" +
                    "SetValue(row, 19, \"EWaybillExpiryDate\", EWaybillExpiryDate);" + "\n" +
                    "var linkDelete= '<a href=\"\" class=\"remove\" ><i style=\"font - size: 25px; color: red\" class=\"fa fa-trash\"></i></a>';" +
                    "SetValue1(row, 20, \"Delete\", linkDelete);" + "\n" +
                    "gridView.append(row);" + "\n" +

                  //  "};" +
                 "};" +
                        //--------------------------------------------------------

                        // Delete a record
                        "$(\"[id*=GV_WaybillDetail]\").on('click', 'a.remove', function(e) {" +
                          " e.preventDefault();" +
                           //   " DeleteDetails($(this).closest(\"tr\"));" + "\n" +
                           " var target_row = $(this).closest(\"tr\").get(0);" +
                         //  "target_row.remove();" +
                         " DeleteDetails(target_row);" + "\n" +

                        "if ($(\"[id*=Txt_Weight]\").val()==\"0.00\") {" + "\n" +
                                "console.log(\"blank row\");" +
                                "AddGridviewRow();" +                        
                             // "var newRow = \"<tr><td class='gvItemStyle'></td><td class='hidden'></td><td class='gvItemStyle'></td><td class='hidden'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td><td class='gvItemStyle'></td></tr>\";" +
                             //   "$(\"[id*=GV_WaybillDetail]\").append(newRow);" +
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

                                   "row.remove();" +
                                   "return true;" +

                             "}" + "\n" +
                           " else{return false}" +
                         " }" +
            #endregion
                    "}),";


            string FillWaybillDetail = "$(function () {" + "\n" +
              "$(\"[id*=Btn_SearchWaybill]\").bind(\"click\", function() {" + "\n" +
                "clearData();" +
                 "$(\"[id$=materialUpdate]\").hide();" +
                 "$(\"[id$=Btn_Update]\").hide();" +
                 "$(\"[id$=Btn_EditData]\").hide();" +
                "var hfWaybillID = $(\"[id*=hfWaybillID]\");" + "\n" +
                 "console.log(hfWaybillID.val());" +
                 "if($(\"[id*= Ddl_Reverse]\").val() == \"WAYBILL NO\")" + "\n" +
                 "{" + "\n" +
                  "if(hfWaybillID.val()!=\"\"){" + "\n" +
                   "var WayBillNo = $(\"[id*=Txt_SearchWaybillNo]\").val();" + "\n" +
                   "FillWaybillDetails(WayBillNo);" +
                   "}" +
                  "}" +
                  "else if($(\"[id *= Ddl_Reverse]\").val() == \"CUSTOMER\")" + "\n" +
                   "{" + "\n" +
                       "$(\"[id*=WaybillDetailsDiv]\").show();" +
                       "$(\"[id*=CorporateCustomerDiv]\").hide();" +
                       "$(\"[id*=WalkinCustomerDiv]\").show();" +
                       "$(\"[id*= Ddl_CustomerType]\").val(\"WALKIN\");" +
                       "$(\"[id*= Ddl_CustomerType]\").attr(\"disabled\", \"disabled\");" +
                       "changeConsigneeOnChangeEvent();" +
                   "}" +
                "});" +

            #region
            // Clear Data--------------------------------------------------------------------------
                 "function clearData() {" + "\n" +
                   "console.log(\"clear\");" + "\n" +       
                   "$(\"[id*=Ddl_PickType]\").val(\"GODOWN\");" + "\n" +
                   "$(\"[id*=hfCustID]\").val(\"\");" + "\n" +
                   "$(\"[id*=Txt_CCustName]\").val(\"\");" + "\n" +
                   "$(\"[id*=Txt_WCustName]\").val(\"\");" + "\n" +
                   "$(\"[id*=hfWCustID]\").val(\"\");" + "\n" +
                   "$(\"[id*=Txt_CustMobileNo]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_CustMobileNo]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=Txt_EmailId]\").val(\"\");" + "\n" +
                   "$(\"[id*=Txt_CustPin]\").val(\"\");" + "\n" +
                   "$(\"[id*=hfCustPinID]\").val(\"\");" + "\n" +
                   "$(\"[id*=Ddl_CustArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
                   "$(\"[id*=Txt_CustAdd]\").val(\"\");" + "\n" +
                   "$(\"[id*=SameAdd]\").prop(\"checked\", false);" + "\n" +
                   "$(\"[id$=Txt_EmailId]\").removeAttr(\"disabled\");" + "\n" +                                                   
                   "$(\"[id$=Txt_PickPin]\").val(\"\");" + "\n" +
                   "$(\"[id$=hfPickPinID]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_PickPin]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=Ddl_PickArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
                   "$(\"[id$=Ddl_PickArea]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id$=Txt_PickAdd]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_PickAdd]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=Txt_ConsigneeName]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_ConsigneeName]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=hfConsigneeID]\").val(\"\");" + "\n" +
                   "$(\"[id*=Txt_ConsigneeContNo]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_ConsigneeContNo]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=Txt_DelPin]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_DelPin]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=hfDelPinID]\").val(\"\");" + "\n" +
                   "$(\"[id*=Ddl_DelArea]\").empty().append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
                   "$(\"[id$=Ddl_DelArea]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id*=Txt_DelAdd]\").val(\"\");" + "\n" +
                   "$(\"[id$=Txt_DelAdd]\").removeAttr(\"disabled\");" + "\n" +
                   "$(\"[id$=Txt_PickupBranch]\").val(\"AUTO\"); " + "\n" +
                   "$(\"[id$=hfPickupBranch]\").val(\"\"); " + "\n" +
                   "$(\"[id*=CorporateCustomerDiv]\").show();"+
                   "$(\"[id*=WalkinCustomerDiv]\").hide();"+
                   "$(\"[id*=Btn_AddInSameInvoice]\").hide();"+           
                   "$(\"[id*= SameAdd]\").attr(\"disabled\", \"disabled\");"+
                   "$(\"[id*=Txt_WaybillDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate: 0}).datepicker(\"setDate\", new Date());"+
                   "CurrentWaybillNo();"+
                   "$(\"[id*=Txt_Weight]\").val(\"\");"+
                   "$(\"[id*=Txt_DeliveryBranch]\").val(\"AUTO\");" +
                   "$(\"[id*=hfDeliveryBranch]\").val(\"\");" +
                   "$(\"[id*=SameAdd]\").show();" +
                   "$(\"[id*=SameAsText]\").show();"+
                   "$(\"[id*=hl_consignor]\").show();"+      
                   "$(\"[id*=hl_walkinConsignor]\").show();"+      
                   "$(\"[id*=hl_consignee]\").show();"+
                  
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
                    "var EWaybillNo = $(\"[id*=Txt_EWaybillNo]\");" + "\n" +
                    "SetValue(row, 17, \"EWaybillNo\", EWaybillNo);" + "\n" +
                    "var EWaybillDate = $(\"[id*=Txt_EWaybillDate]\");" + "\n" +
                    "SetValue(row, 18, \"EWaybillDate\", EWaybillDate);" + "\n" +
                    "var EWaybillExpiryDate = $(\"[id*=Txt_EWaybillExpiryDate]\");" + "\n" +
                    "SetValue(row, 19, \"EWaybillExpiryDate\", EWaybillExpiryDate);" + "\n" +
                    "var linkDelete= '<a href=\"\" class=\"remove\" ><i style=\"font - size: 25px; color: red\" class=\"fa fa-trash\"></i></a>';" +            
                    "SetValue1(row, 20, \"Delete\", linkDelete);" + "\n" +
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

                   "function SetValue1(row, index, name, textbox)" + "\n" +
                   "{" + "\n" +
                     "row.find(\"td\").eq(index).html(textbox);" + "\n" +
                     "var input = $(\"<input type = 'hidden' />\");" + "\n" +
                     "input.prop(\"name\", name);" + "\n" +
                      //     "input.val(textbox.val());" + "\n" +
                     "row.find(\"td\").eq(index).append(input);" + "\n" +
                    "}" + "\n" +
               //-----------------------------------------------------------------------------------
            #endregion
               "}),";


            String savedata = "$(function () {" + "\n" +
          "$(\"[id*=Button_Submit]\").bind(\"click\", function() {" + "\n" +
           "var hfWaybillSubmit = $(\"[id*=hfWaybillSubmit]\");" + "\n" +
           "console.log(hfWaybillSubmit.val());" +
            #region
              "if(hfWaybillSubmit.val()==1){" + "\n" +
          "$(\"[id*=LoadingImage]\").show();" + "\n" +
          "var PickReqHeader = { };var ConsignorN = { };" + "\n" +
          "var PickReqDetail=[];var Count; var RconsigneeID; var RconsignorID;" +

           "if($(\"[id$=Ddl_Reverse]\").val() == \"WAYBILL NO\")" +
            "{" +
                 "var customerId = $(\"[id$=hfConsigneeID]\").val(); " + "\n" +
                 "ConsignorN     = $(\"[id$=Txt_WCustName]\").val(); " + "\n" +
                 "var ConsignorP = $(\"[id$=hfCustPinID]\").val(); " + "\n" +
                 "var ConsignorA = $(\"[id$=Ddl_CustArea]\").val(); " + "\n" +
                
            //start of Consignor
            #region
            // for checking consignor
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/GetConsignorId\"," + "\n" +
            "data: '{consignorName: ' + JSON.stringify(ConsignorN) + ' , consignorPinId: ' + ConsignorP + ' , consignorAreaId: ' + ConsignorA + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"EnteredConsignor\");" +
            "var Condata=response.d;" + "\n" +
            "console.log(\"dataConsignorId:\"+ Condata);" + "\n" +
            "if(Condata == 0)" +
            "{" +
              // create new consignor
             "var ConsignorDetails = { };" + "\n" +
             "ConsignorDetails.value = \"CONSIGNOR\";" + "\n" +           
             "ConsignorDetails.Name = $(\"[id*=Txt_WCustName]\").val();" + "\n" +
             "ConsignorDetails.ContactNo = $(\"[id*=Txt_CustMobileNo]\").val();" + "\n" +
             "ConsignorDetails.LocID = $(\"[id*=hfCustPinID]\").val();" + "\n" +
             "ConsignorDetails.AreaID = $(\"[id$=Ddl_CustArea]\").val();" + "\n" +
             "ConsignorDetails.Address = $(\"[id*=Txt_CustAdd]\").val();" + "\n" +
             "ConsignorDetails.GSTNo = \"NA\";" + "\n" +

              "$.ajax({" + "\n" +
               "url: \"ReverseWaybill.aspx/SaveConsignorConsignee\"," + "\n" +
               "data: '{Details: ' + JSON.stringify(ConsignorDetails) + '}'," + "\n" +
               "type: \"POST\"," + "\n" +
               "dataType: \"json\"," + "\n" +
               "contentType: \"application/json; charset=utf-8\"," + "\n" +

                   "success: function(response) {" + "\n" +
                   "var successConData=response.d;" + "\n" +
                   "console.log(\"ConsignorIDSaveSuccess\"+successConData);" + "\n" +
                   "RconsignorID = successConData;" + "\n" +
                       /////////////////code{}
                      #region
            // for checking consignee
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/GetConsigneeId\"," + "\n" +
            "data: '{customerId: ' + customerId + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
            "var Cdata=response.d;" + "\n" +
            "console.log(\"dataConsigneeId:\"+ Cdata);" + "\n" +
            "if(Cdata == 0)" +
            "{" +
               // create new consignee
            #region
               "var Details = { };" + "\n" +
             "var Branch = { };" + "\n" +

             "Details.value = \"CONSIGNEE\";" + "\n" +
             "Details.Id = customerId;" + "\n" +
             "Details.Name = $(\"[id*=Txt_ConsigneeName]\").val();" + "\n" +
             "Details.ContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
             "Details.LocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
             "Details.AreaID = $(\"[id$=Ddl_DelArea]\").val();" + "\n" +
             "Details.Address = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
             "Branch.branchId = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
             "console.log(Branch.branchId);" +

              "$.ajax({" + "\n" +
               "url: \"ReverseWaybill.aspx/SaveConsignee\"," + "\n" +
               "data: '{Details: ' + JSON.stringify(Details) + ', BranchID: ' + Branch.branchId + '}'," + "\n" +
               "type: \"POST\"," + "\n" +
               "dataType: \"json\"," + "\n" +
               "contentType: \"application/json; charset=utf-8\"," + "\n" +

                   "success: function(response) {" + "\n" +
                   "var successData=response.d;" + "\n" +
                   "console.log(\"ConsigneeIDSaveSuccess\"+successData);" + "\n" +
                   "RconsigneeID = successData;" + "\n" +
                   "$(\"[id$=hfReverseConsigneeID]\").val(successData);" + "\n" +
            #region
            #region
          // header details
          "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
          "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
          "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
          "PickReqHeader.CustType = \"WALKIN\";" + "\n" +
          "PickReqHeader.PaymentMode= \"CREDIT\";" + "\n" +
          "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
          "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
          "PickReqHeader.walkinCustId=0;" + "\n" +
          "}" + "\n" +
          "else{PickReqHeader.walkinCustId = RconsignorID;" + "\n" +
           "console.log('Consignor ID :- '+ RconsignorID);" +
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
          "PickReqHeader.ConsigneeID = $(\"[id$=hfReverseConsigneeID]\").val();" + "\n" +
          "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
          "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
          "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
          "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
          "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
          "PickReqHeader.ReverseWaybillNo = $(\"[id*=Txt_SearchWaybillNo]\").val();" + "\n" +

           "console.log('1:::' + PickReqHeader.ReverseWaybillNo);" +
            #endregion

            //Material Details 
            #region
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
            #endregion

            #region          

            "console.log(PickReqHeader);" +
            "console.log(PickReqDetail);" +
            "console.log(\"Entry\");" +
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/SaveReverseWaybillData\"," + "\n" +
            "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
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
          "});" + "\n" + //end of ajax saveReverseWaybill
            #endregion

            #endregion
                 "}," + "\n" + //  // end of success of Consignee Creation
                 "error: function(response) {" + "\n" +
                       "alert(response.responseText);" + "\n" +
                 "}," + "\n" + // end of error
                               // "failure: function(response) {" + "\n" +                   
                               // "alert(response.responseText);" + "\n" +
                               //"}" + "\n" +  // end of failure

                    "});" + "\n" +  // end of ajax
            #endregion
            // end create new consignee 
            "}" +
            "else{" +
                   // get consignee Id
                   "console.log(\"ConsigneeIDOld\"+Cdata);" + "\n" +
                   "RconsigneeID = Cdata;" + "\n" +
                    "$(\"[id$=hfReverseConsigneeID]\").val(Cdata);" + "\n" +
                     "console.log(\"ConsigneeIDOld\"+ $(\"[id$=hfReverseConsigneeID]\").val());" + "\n" +
            #region
          // header details
          "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
          "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
          "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
          "PickReqHeader.CustType = \"WALKIN\";" + "\n" +
          "PickReqHeader.PaymentMode= \"CREDIT\";" + "\n" +
          "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
          "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
          "PickReqHeader.walkinCustId=0;" + "\n" +
          "}" + "\n" +
          "else{PickReqHeader.walkinCustId = RconsignorID;" + "\n" +
           "console.log('Consignor ID :- '+ RconsignorID);" +
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
          "PickReqHeader.ConsigneeID = $(\"[id$=hfReverseConsigneeID]\").val();" + "\n" +
          "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
          "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
          "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
          "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
          "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
          "PickReqHeader.ReverseWaybillNo = $(\"[id*=Txt_SearchWaybillNo]\").val();" + "\n" +

           "console.log('1:::' + PickReqHeader.ReverseWaybillNo);" +
            #endregion

            //Material Details 
            #region
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
            #endregion

            #region          

            "console.log(PickReqHeader);" +
            "console.log(PickReqDetail);" +
            "console.log(\"Entry\");" +
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/SaveReverseWaybillData\"," + "\n" +
            "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
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
          "});" + "\n" + //end of ajax saveReverseWaybill
            #endregion
                   "}" +

             "}," + "\n" +
              "error: function(response) {" + "\n" +
                    "alert(response.responseText);" + "\n" +
              "}," + "\n" +
          // "failure: function(response) {" + "\n" +                 
          // "alert(response.responseText);" + "\n" +
          //"}" + "\n" +
          "});" + "\n" +
            #endregion

                    "}," + "\n" + //  // end of success of Consignor Creation
                 "error: function(response) {" + "\n" +
                       "alert(response.responseText);" + "\n" +
                 "}," + "\n" + // end of error
                               // "failure: function(response) {" + "\n" +                   
                               // "alert(response.responseText);" + "\n" +
                               //"}" + "\n" +  // end of failure

                    "});" + "\n" +  // end of ajax

             // end create new consignor
             "}" +
            "else{" +
                 // get consignor Id
                 "console.log(\"ConsignorIDOld\"+Condata);" + "\n" +
                   "RconsignorID = Condata;" + "\n" +
                    #region
            // for checking consignee
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/GetConsigneeId\"," + "\n" +
            "data: '{customerId: ' + customerId + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
            "var Cdata=response.d;" + "\n" +
            "console.log(\"dataConsigneeId:\"+ Cdata);" + "\n" +
            "if(Cdata == 0)" +
            "{" +
               // create new consignee
            #region
               "var Details = { };" + "\n" +
             "var Branch = { };" + "\n" +

             "Details.value = \"CONSIGNEE\";" + "\n" +
             "Details.Id = customerId;" + "\n" +
             "Details.Name = $(\"[id*=Txt_ConsigneeName]\").val();" + "\n" +
             "Details.ContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
             "Details.LocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
             "Details.AreaID = $(\"[id$=Ddl_DelArea]\").val();" + "\n" +
             "Details.Address = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
             "Branch.branchId = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
             "console.log(Branch.branchId);" +

              "$.ajax({" + "\n" +
               "url: \"ReverseWaybill.aspx/SaveConsignee\"," + "\n" +
               "data: '{Details: ' + JSON.stringify(Details) + ', BranchID: ' + Branch.branchId + '}'," + "\n" +
               "type: \"POST\"," + "\n" +
               "dataType: \"json\"," + "\n" +
               "contentType: \"application/json; charset=utf-8\"," + "\n" +

                   "success: function(response) {" + "\n" +
                   "var successData=response.d;" + "\n" +
                   "console.log(\"ConsigneeIDSaveSuccess\"+successData);" + "\n" +
                   "RconsigneeID = successData;" + "\n" +
                   "$(\"[id$=hfReverseConsigneeID]\").val(successData);" + "\n" +
            #region
            #region
          // header details
          "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
          "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
          "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
          "PickReqHeader.CustType = \"WALKIN\";" + "\n" +
          "PickReqHeader.PaymentMode= \"CREDIT\";" + "\n" +
          "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
          "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
          "PickReqHeader.walkinCustId=0;" + "\n" +
          "}" + "\n" +
          "else{PickReqHeader.walkinCustId = RconsignorID;" + "\n" +
           "console.log('Consignor ID :- '+ RconsignorID);" +
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
          "PickReqHeader.ConsigneeID = $(\"[id$=hfReverseConsigneeID]\").val();" + "\n" +
          "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
          "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
          "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
          "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
          "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
          "PickReqHeader.ReverseWaybillNo = $(\"[id*=Txt_SearchWaybillNo]\").val();" + "\n" +

           "console.log('1:::' + PickReqHeader.ReverseWaybillNo);" +
            #endregion

            //Material Details 
            #region
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
            #endregion

            #region          

            "console.log(PickReqHeader);" +
            "console.log(PickReqDetail);" +
            "console.log(\"Entry\");" +
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/SaveReverseWaybillData\"," + "\n" +
            "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
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
          "});" + "\n" + //end of ajax saveReverseWaybill
            #endregion

            #endregion
                 "}," + "\n" + //  // end of success of Consignee Creation
                 "error: function(response) {" + "\n" +
                       "alert(response.responseText);" + "\n" +
                 "}," + "\n" + // end of error
                               // "failure: function(response) {" + "\n" +                   
                               // "alert(response.responseText);" + "\n" +
                               //"}" + "\n" +  // end of failure

                    "});" + "\n" +  // end of ajax
            #endregion
            // end create new consignee 
            "}" +
            "else{" +
                   // get consignee Id
                   "console.log(\"ConsigneeIDOld\"+Cdata);" + "\n" +
                   "RconsigneeID = Cdata;" + "\n" +
                    "$(\"[id$=hfReverseConsigneeID]\").val(Cdata);" + "\n" +
                     "console.log(\"ConsigneeIDOld\"+ $(\"[id$=hfReverseConsigneeID]\").val());" + "\n" +
            #region
          // header details
          "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
          "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
          "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
          "PickReqHeader.CustType = \"WALKIN\";" + "\n" +
          "PickReqHeader.PaymentMode= \"CREDIT\";" + "\n" +
          "if(PickReqHeader.CustType==\"CORPORATE\"){" + "\n" +
          "PickReqHeader.CustID=$(\"[id$=hfCustID]\").val();" + "\n" +
          "PickReqHeader.walkinCustId=0;" + "\n" +
          "}" + "\n" +
          "else{PickReqHeader.walkinCustId = RconsignorID;" + "\n" +
           "console.log('Consignor ID :- '+ RconsignorID);" +
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
          "PickReqHeader.ConsigneeID = $(\"[id$=hfReverseConsigneeID]\").val();" + "\n" +
          "PickReqHeader.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
          "PickReqHeader.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
          "PickReqHeader.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
          "PickReqHeader.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +
          "PickReqHeader.PickupBranch = $(\"[id*=hfPickupBranch]\").val();" + "\n" +
          "PickReqHeader.ReverseWaybillNo = $(\"[id*=Txt_SearchWaybillNo]\").val();" + "\n" +

           "console.log('1:::' + PickReqHeader.ReverseWaybillNo);" +
            #endregion

            //Material Details 
            #region
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
            #endregion

            #region          

            "console.log(PickReqHeader);" +
            "console.log(PickReqDetail);" +
            "console.log(\"Entry\");" +
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/SaveReverseWaybillData\"," + "\n" +
            "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
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
          "});" + "\n" + //end of ajax saveReverseWaybill
            #endregion
                   "}" +

             "}," + "\n" +
              "error: function(response) {" + "\n" +
                    "alert(response.responseText);" + "\n" +
              "}," + "\n" +
          // "failure: function(response) {" + "\n" +                 
          // "alert(response.responseText);" + "\n" +
          //"}" + "\n" +
          "});" + "\n" +
            #endregion

                "}" +

            "}," + "\n" +
              "error: function(response) {" + "\n" +
                    "alert(response.responseText);" + "\n" +
              "}," + "\n" +
          // "failure: function(response) {" + "\n" +                 
          // "alert(response.responseText);" + "\n" +
          //"}" + "\n" +
          "});" + "\n" +        
            #endregion
          //end of Consignor
          //******************************************************************************************************************//        
            "}" +
             "else{" +
             "console.log(\"CustomerReverseEntry\");" + "\n" +
            #region
          // header details
          "PickReqHeader.PickType= $(\"[id$=Ddl_PickType]\").val();" + "\n" +
          "PickReqHeader.WaybillNo = $(\"[id*=Txt_WaybillNo]\").val();" + "\n" +
          "PickReqHeader.WaybillDate= $(\"[id$=Txt_WaybillDate]\").val();" + "\n" +
          "PickReqHeader.CustType = \"WALKIN\";" + "\n" +
          "PickReqHeader.PaymentMode= \"CREDIT\";" + "\n" +
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
          "PickReqHeader.ReverseWaybillNo = \'CUSTREVERSE\';" + "\n" +

          "console.log('1:::' + PickReqHeader.ReverseWaybillNo);" +
            #endregion

            //Material Details 
            #region
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
            #endregion

            #region          

            "console.log(PickReqHeader);" +
            "console.log(PickReqDetail);" +
            "console.log(\"Entry\");" +
            "$.ajax({" + "\n" +
            "url: \"ReverseWaybill.aspx/SaveReverseWaybillData\"," + "\n" +
            "data: '{PickReqHeader: ' + JSON.stringify(PickReqHeader) + ', PickReqDetail:' + JSON.stringify(PickReqDetail) + '}'," + "\n" +
            "type: \"POST\"," + "\n" +
            "dataType: \"json\"," + "\n" +
            "contentType: \"application/json; charset=utf-8\"," + "\n" +
            "success: function(response) {" + "\n" +
             "console.log(\"Entered\");" +
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
          "});" + "\n" + //end of ajax saveReverseWaybill
            #endregion

                  "}" +//end of else (if waybillNo)

          "}" + "\n" +
          "return false;" + "\n" +
          "});" + "\n" +
            #endregion
            "}),";


            CFunctions.setjavascript(CFunctions.javascript + str + CFT + chargeW8 + strDataTable + FillWaybillDetail + savedata);
            SaveJavaScriptConsignorConsignee("LoadingImage", "CONSIGNOR", "hfPopupConsignorSubmit", "Btn_PopupConsignorSubmit", "Txt_PopupConsignorName", "Txt_PopupContactNo", "hfPopupConsignorPincode", "Txt_PopupConsignorPincode", "Ddl_PopupConsignorArea", "Txt_PopupConsignorAddress", "Txt_PopupConsignorGST",
                                                                                                                           "hfWCustID", "Txt_WCustName", "Txt_CustMobileNo", "hfCustPinID", "Txt_CustPin", "Ddl_CustArea", "Txt_CustAdd");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchWaybillNo", "hfWaybillID", "ReverseWaybill.aspx/getWayBillNo", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_CustPin", "hfCustPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_PickPin", "hfPickPinID", "PickReqCRMBranch.aspx/getConsignorPincode", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_DelPin", "hfDelPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_MaterialType", "hfMaterialID", "PickReqCRMBranch.aspx/getMaterial", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_PackageType", "hfPackageID", "PickReqCRMBranch.aspx/getPackages", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_CCustName", "hfCustID", "PickReqCRMBranch.aspx/getCustName", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_ConsigneeName", "hfConsigneeID", "ReverseWaybill.aspx/getConsigneeNameReverse", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_PopupConsignorPincode", "hfPopupConsignorPincode", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_WCustName", "hfWCustID", "PickReqCRMBranch.aspx/getWalkinCustName", "GetData", "});});");
           
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
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
                      "console.log($(\"[id*='" + hfpincode + "']\").val());" + "\n" +
                      "getDeliveryBranch('" + fillhfpincode + "');" + "\n" +
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
    [WebMethod]
    public static string[] getWayBillNo(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getReverseWaybillNo(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] getConsigneeNameReverse(string searchPrefixText, string data)
    {
       return (new PickReqFunctions()).getReverseConsigneeName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static int SaveConsignorConsignee(ConsingorConsignee Details)
    {
        return (new PickReqFunctions()).SaveConsignorConsignee(Details);
    }
    [WebMethod]
    public static int SaveConsignee(ConsingorConsignee Details, string BranchID)
    {
        return (new PickReqFunctions()).SaveConsignorConsignee(Details, BranchID);
    }
    //Auto Fill details on Reverse Consignee name
    [WebMethod]
    public static string[] getConsigneeNameReverseDetail(string Name)
    {
        return (new PickReqFunctions()).getConsigneeNameReverseDetail(Name);
    }
    [WebMethod]
    public static int GetConsignorId(string consignorName, string consignorPinId, string consignorAreaId)
    {
        return (new PickReqFunctions()).GetConsignorID(consignorName, consignorPinId, consignorAreaId, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static int GetConsigneeId(string customerId)
    {
        return (new PickReqFunctions()).GetConsigneeID(customerId, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static int SaveReverseWaybillData(PickReq PickReqHeader, List<PickReqDetail> PickReqDetail)
    {
        return (new PickReqFunctions()).SavePickupRequestWareHouse(PickReqHeader, PickReqDetail);
    }
     
}