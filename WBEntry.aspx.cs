using BLFunctions;
using BLFunctionss;
using BLProperties;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;
using System.Web.UI.WebControls;
using System.Web.DynamicData;
//using static iTextSharp.text.pdf.events.IndexEvents;
//using static iTextSharp.text.pdf.events.IndexEvents;

public partial class WBEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        SetInitialRowItemForEWayBillMaterial();
        DataTable dt = new DataTable();
        ((GridView)WaybillEntry.FindControl("GV_WaybillDetail")).DataSource = dt; 
        ((GridView)WaybillEntry.FindControl("GV_WaybillDetail")).DataBind(); 
    }
    private void SetInitialRowItemForEWayBillMaterial()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.AddRange(new DataColumn[] { new DataColumn("SR NO", typeof(Int32)),     new DataColumn("MATERIAL TYPE", typeof(String)),
                                               new DataColumn("PACKAGE TYPE", typeof(Double)), new DataColumn("UNIT", typeof(String)), 
                                               new DataColumn("WEIGHT", typeof(String)),  new DataColumn("QTY", typeof(String)),
                                               new DataColumn("INVOICE NO", typeof(String)),  new DataColumn("INVOICE DATE", typeof(String)),
                                               new DataColumn("INVOICE VALUE", typeof(String)) }); 
        //ViewState["CurrentTable"] = dt;
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        GV_EwayBillMaterial.DataSource = dt;
        GV_EwayBillMaterial.DataBind();
    }
    private string[] GetEWaybillInvoice(string EWayBillNo)
    {
        return null;
    }
    [WebMethod]
    public static string[] CheckWaybillNo(string waybillNo)
    {
        return (new WBEntryClass()).getBranchStationary(waybillNo, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] GetPreviousWayBillNo()
    {
        return (new WBEntryClass()).GetPreviousWayBillNo(Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] FillPickUPDataForWaybill(string strPickUpRequestId)
    {
        return (new WBEntryClass()).LoadPickUpHeaderForWayBill(strPickUpRequestId);
    }
    [WebMethod]
    public static string[] GetWaybillInvoice(string type)
    {
        return (new WBEntryClass()).GetWaybillInvoice(type);
    }
    [WebMethod]
    public static string[] GetWaybillHeaderData(int WaybillId)
    {
        return (new WBEntryClass()).LoadWaybillHeaderData(WaybillId);
    }
    [WebMethod]
    public static List<FullAddress> getArea(int pincode)
    {
        return (new WBEntryClass()).getArea(pincode);
    }
    [WebMethod]
    public static string[] GetWaybillDetailsData(int WaybillId)
    {
        return (new WBEntryClass()).LoadWaybillDetailsData(WaybillId);
    }
    [WebMethod]
    public static string[] GetWaybillInvoiceDetailsData(int WaybillId)
    {
        return (new WBEntryClass()).LoadWaybillInvoiceDetailsData(WaybillId);
    }
    [WebMethod]
    public static string[] getCustomerCode(string searchPrefixText, string data = null)
    {
        return (new WBEntryClass()).getCustomerCode(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] getConsigneeName(string searchPrefixText, string data)
    {
        if (searchPrefixText.IndexOf("|") > 0) 
            searchPrefixText = searchPrefixText.Substring(0, searchPrefixText.IndexOf("|")); 
        return (new WBEntryClass()).getConsigneeName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    [WebMethod]
    public static string[] GetEwayBillData(string sEWayBillNo)
    {
        List<string> strItemList = new List<string>();
        /*if("1" == "1") 
        {
            strItemList.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}", "1", "7", "ACCESSORIES", "2", "BOXES", "PCS", "", "108", "29/07/2022", "22SIBH/2212491", "1000"));
            return strItemList.ToArray(); 
        }*/
        try
        {
            Task<string> sJSONEWayBill = Task.Run(() => (new EWayBill().getEWBDetails(sEWayBillNo)));
            string sEWayBillExpiryDate = "";
            string strReturn = JsonConvert.SerializeObject(sJSONEWayBill);
            var mObjects = JArray.Parse("[" + strReturn + "]");
            foreach (JObject mroot in mObjects)
            {
                foreach (KeyValuePair<String, JToken> app in mroot)
                {
                    var appName = app.Key;
                    if (appName.ToString() == "ewayBillDate")
                    {
                        sEWayBillExpiryDate = app.Value.ToString();
                    }
                }
            }
        string srNo = "", sMatTypeId = "", sMatType = "", sPackTypeId = "", sPackType = "";
        string sUnit = "", sWeight = "", sQty = "", sInvoiceNo = "", sInvoiceDate = "", sInvoiceValue = ""; 
        dynamic baseroot = JsonConvert.DeserializeObject(strReturn);
        dynamic result = baseroot.Result;

        var objects = JArray.Parse("[" + result + "]"); // parse as array  
        foreach (JObject root in objects)
        {
            foreach (KeyValuePair<String, JToken> app in root)
            {
                var appName = app.Key;
                if (appName.ToString() == "ewayBillDate")
                {
                    sEWayBillExpiryDate = app.Value.ToString();
                }
                if (appName.ToString() == "docNo")
                {
                    sInvoiceNo = app.Value.ToString();
                }
                if (appName.ToString() == "docDate")
                {
                    sInvoiceDate = app.Value.ToString(); 
                }
                if(appName.ToString() == "itemList")
                {
                    //System.Diagnostics.Debug.WriteLine(app.ToString());
                    var strItem = app.ToString().Substring(14);
                    strItem = strItem.ToString().Substring(0, strItem.ToString().Length - 4);
                    strItem = strItem.Replace(System.Environment.NewLine, string.Empty);
                    strItem = strItem.Replace(@"\""", string.Empty);
                    strItem = strItem.Replace("\\\"", "\"");
                    var itemObjects = JArray.Parse("[" + strItem + "]"); // parse as array  
                    foreach (JObject subItem in itemObjects)
                    {
                        foreach (KeyValuePair<String, JToken> items in subItem)
                        {
                            System.Diagnostics.Debug.WriteLine(items.Value);
                            if (items.Key == "itemNo") {
                                srNo = items.Value.ToString();
                            }
                            if (items.Key == "hsnCode")
                            {
                                //Electronic Goods 
                                if (items.Value.ToString().Substring(0, 4) == "9613")
                                {
                                    //Electronic Goods
                                    sMatTypeId = "1"; 
                                    sMatType = "E Goods";
                                }
                                else 
                                {
                                    sMatTypeId = "7"; 
                                    sMatType = "ACCESSORIES";
                                }
                            }
                            if (items.Key == "quantity")
                            {
                                sQty = items.Value.ToString();
                            }
                            if (items.Key == "qtyUnit")
                            {
                                sUnit = items.Value.ToString();
                            }
                            sPackTypeId = "2";
                            sPackType = "BOXES";
                            //sUnit = "PCS";
                            if (items.Key == "sInvoiceNo")
                            {
                                sInvoiceNo = items.Value.ToString();
                            }
                            if (items.Key == "taxableAmount")
                            {
                                sInvoiceValue = items.Value.ToString();
                            }
                        }
                        if (sQty == "0") sQty = "1"; 
                                                                                                        // "1", "7", "ACCESSORIES", "2",       "BOXES",   "PCS", "",        "108", "29/07/2022", "22SIBH/2212491", "1000"));
                        strItemList.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}", srNo, sMatTypeId, sMatType, sPackTypeId, sPackType, sUnit, sWeight, sQty, sInvoiceNo, sInvoiceDate, sInvoiceValue, sEWayBillExpiryDate)); 
                    }
                }
                //System.Diagnostics.Debug.WriteLine(appName.ToString());
            }
        }
        return strItemList.ToArray();
        }
        catch (Exception ex)
        {
            (new EWayBill()).SaveError(ex.Message);
            return null; 
        }
    }
    [WebMethod]
    public static string[] getConsigneeNameDetail(string Name)
    {
        return (new PickReqFunctions()).getConsigneeNameDetail(Name);
    }

}