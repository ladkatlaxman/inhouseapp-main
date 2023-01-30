using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using NameSpaceConnection;
using BLProperties;
using BLFunctions;

/// <summary>
/// Summary description for WayBillPrint
/// </summary>
public class clsWayBillPrint
{
    public clsWayBillPrint()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string getPrintDataText(string Code)
    {
        string strDataText = string.Empty; 
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Code", Code));
        IDataReader dt = (new Connection()).ReadSp("ssp_GetPrintDataCode", paramList);
        while(dt.Read())
        {
            strDataText = dt["HTMLText"].ToString(); 
        }
        return strDataText;
    }
    public DataTable ViewCustomerForEmail(string BranchId, string FromDate, string ToDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        if(BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
        if(FromDate!= "") paramList.Add(new Parameters("@FromDate", FromDate));
        if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));
        DataTable dt = (new Connection()).Fillsp("ssp_GetCustomerForEmail", paramList);
        return dt;
    }
    public IDataReader ViewWayBillsForCustomer(string CustomerId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@CustomerId", CustomerId));
        IDataReader dt = (new Connection()).ReadSp("ssp_GetCustomerWayBillForEmail", paramList);
        return dt;
    }

    public string getHTMLString(string WayBillId)
    {
        string strHTML = getPrintDataText("WAYBILL"); //System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("/WaybillPrint.html"));
        strHTML = strHTML.Replace("@@logoimage@@", HttpContext.Current.Server.MapPath("") + "/images/dexterLogo.png");

        PickReq wbHeader = new PickReq();
        wbHeader = (new MasterFormFunctions()).getWaybillHeaderDetails(WayBillId);

        strHTML = strHTML.Replace("@@PickUpLocation@@", wbHeader.PickupBranch);
        strHTML = strHTML.Replace("@@WayBillNo@@", wbHeader.WaybillNo.ToString());
        strHTML = strHTML.Replace("@@DeliveryLocation@@", wbHeader.DeliveryBranch);
        strHTML = strHTML.Replace("@@WaybillDate@@", wbHeader.WaybillDate);
        strHTML = strHTML.Replace("@@ConsignorName@@", wbHeader.CustName);
        strHTML = strHTML.Replace("@@ConsigneeName@@", wbHeader.ConsigneeName);
        strHTML = strHTML.Replace("@@ConsignorAddress@@", wbHeader.CustAddress + "<br />" + wbHeader.CustArea + "<br />" + wbHeader.CustPINCode);
        strHTML = strHTML.Replace("@@ConsigneeAddress@@", wbHeader.DelAddress + "<br />" + wbHeader.DelCity + "<br />" + wbHeader.DelArea + "<br />" + wbHeader.DelPINCode);
        strHTML = strHTML.Replace("@@ConsginorContact@@", wbHeader.CustContactNo);
        strHTML = strHTML.Replace("@@ConsigneeContact@@", wbHeader.ConsigneeContactNo);


        string strMaterialDetail = "<table><tr><th>Sr</th><th>Invoice No</th><th>Date</th><th>Value</th><th>Material</th><th>Package</th><th>Qty</th><th>Actual Wt</th><th>Charged Wt</th></tr>";

        List<PickReqDetail> pickReqDetails = (new MasterFormFunctions()).getWaybillDetails(WayBillId.ToString());
        int iCount = 0;
        foreach (PickReqDetail pDetail in pickReqDetails)
        {
            iCount++;

            strMaterialDetail += "<tr><td>" + iCount.ToString() + "</td>";
            strMaterialDetail += "<td>" + pDetail.InvoiceNo + "</td>";
            strMaterialDetail += "<td>" + pDetail.InvoiceDate + "</td>";
            strMaterialDetail += "<td>" + pDetail.InvoiceValue + "</td>";
            strMaterialDetail += "<td width=20%>" + pDetail.MaterialType + "</td>";
            strMaterialDetail += "<td>" + pDetail.PackageType + "</td>";
            strMaterialDetail += "<td>" + pDetail.NoOfPackage.ToString() + "</td>";
            strMaterialDetail += "<td>" + pDetail.ActualWeight + "</td>";
            strMaterialDetail += "<td>" + pDetail.ChargeWeight + "</td>";
            strMaterialDetail += "</tr>";
        }
        strMaterialDetail += "</table>";
        strHTML = strHTML.Replace("@@MaterialTable@@", strMaterialDetail);
        return strHTML;
    }
    public string getWayBillId(string WayBillNo)
    {

        string strDataText = string.Empty;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillNo", WayBillNo));
        IDataReader dt = (new Connection()).ReadSp("ssp_ReportWaybillStatusHeader", paramList);
        while (dt.Read())
        {
            strDataText = dt["WayBillId"].ToString();
        }
        return strDataText;
    }
}