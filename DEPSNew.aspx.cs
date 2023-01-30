using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DEPSNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                SetInitialRowItem();
            }
            else
                Response.Redirect("Login.aspx");         
        }
       
      //  string str = "$(\"[id*=Btn_SearchWaybill]\").Attributes.Add(\"onclick\", \"FillWaybillDetails(); \");";
        // string str = "$(\"[id$=WaybillDetailsDiv]\").hide();";

        String savedata = "$(function () {" + "\n" +
                 "$(\"[id*=Button_DEPSSubmit]\").bind(\"click\", function() {" + "\n" +
                  "var hfDEPSSubmit = $(\"[id*=hfDEPSSubmit]\");" + "\n" +
                  "console.log(hfDEPSSubmit.val());" +

                 "if(hfDEPSSubmit.val()==1){" + "\n" +
                 "$(\"[id*=LoadingImage]\").show();" + "\n" +
                 "var deps = { };" + "\n" +

                 "deps.waybillItemID = $(\"[id*=Ddl_WaybillItemID]\").val();" + "\n" +
                 "deps.statusID = $(\"[id*=hfStatusID]\").val();" + "\n" +
                 "deps.itemQty = $(\"[id*=Txt_DepsQty]\").val();" + "\n" +
                 "deps.vehicleRequestID = $(\"[id*=hfVehicleRequestID]\").val();" + "\n" +
                 "deps.depsType = $(\"[id*=Ddl_DepsType]\").val();" + "\n" +
                 "deps.remark=$(\"[id$=Txt_Remark]\").val();" + "\n" +

                 "console.log(deps);" +

                 "$.ajax({" + "\n" +
                 "url: \"DEPSNew.aspx/SaveDeps\"," + "\n" +
                 "data: '{deps: ' + JSON.stringify(deps) + '}'," + "\n" +
                 "type: \"POST\"," + "\n" +
                 "dataType: \"json\"," + "\n" +
                 "contentType: \"application/json; charset=utf-8\"," + "\n" +
                 "success: function(response) {" + "\n" +
                // "clearData();" + "\n" +
                 "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                 "alert(\"Data Added Successfully...\");" + "\n" +
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
     
            "});";

        CFunctions.setjavascript(CFunctions.javascript + savedata); // + str  

        (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchWaybillNo", "hfWaybillID", "~/DEPSNew.aspx/getWayBillNo", "GetData", "});});");    
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    //Add First Row Or Clear Row in Dynamically For Add Waybill CFT Code
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
                                                new DataColumn("InvoiceValue", typeof(Double)),new DataColumn("EWaybillNo", typeof(String)),new DataColumn("EWaybillDate", typeof(String)),new DataColumn("EWaybillExpiryDate", typeof(String))});
        //ViewState["CurrentTable"] = dt;
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        GV_WaybillDetail.DataSource = dt;
        GV_WaybillDetail.DataBind();
    }
    [WebMethod]
    public static string[] GetWaybillHeaderData(int WaybillId)
    {
        return (new PickReqFunctions()).LoadWaybillHeaderData(WaybillId);
    }
    [WebMethod]
    public static List<FullAddress> getArea(int pincode)
    {
        return (new CommFunctions()).getArea(pincode);
    }
    [WebMethod]
    public static string[] GetWaybillDetailsData(int WaybillId)
    {
        return (new PickReqFunctions()).DEPSWaybillDetailsData(WaybillId);
    }

    [WebMethod]
    public static string[] getWayBillNo(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getWaybillNo(searchPrefixText, data);
    }
    //Get Waybill in Dropdown List
    [WebMethod]
    public static List<PickReqDetail> GetWaybillItemID(int waybillID)
    {
        return (new PickReqFunctions()).getWaybillItemID(waybillID);
    }
    // Fill Material and Package name
    [WebMethod]
    public static string[] getMaterialPackageName(int id)
    {
        return (new PickReqFunctions()).getMaterialPackageName(id);
    }
    [WebMethod]
    public static bool SaveDeps(DEPSDetail deps)
    {
        return (new PickReqFunctions()).SaveDeps(null, deps);
    }
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }


   
}