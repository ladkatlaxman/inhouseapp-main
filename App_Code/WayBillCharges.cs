using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for WayBillCharges
/// </summary>
public class WayBillCharges
{
    public WayBillCharges()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string getWayBillId(string waybillno)
    {
        List<string> WaybillNo = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillNo", waybillno));
        DataTable dtTable = (new Connection()).Fillsp("ssp_GetWaybillNoListOne", paramList);
        foreach (DataRow dr in dtTable.Rows)
        {
            return dr["wayBillId"].ToString(); 
        }
        return ""; 
    }
    public IDataReader getWayBillCharges(string waybillno)
    {
        List<string> WaybillNo = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillNo", waybillno));
        return (new Connection()).ReadSp("ssp_GetWayBillCharges", paramList); 
    }
    public void saveWayBillCharges(string WayBillNo, string RateId, string FreightValue)
    {
        List<string> WaybillNo = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillNo", getWayBillId(WayBillNo)))    ;
        paramList.Add(new Parameters("@RateId", RateId));
        paramList.Add(new Parameters("@FreightValue", FreightValue));
        (new Connection()).ReadSp("ssp_CreateWayBillInvoiceDetail", paramList);
    }
}