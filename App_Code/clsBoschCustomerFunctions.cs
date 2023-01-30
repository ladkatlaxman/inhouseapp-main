using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
//using BLProperties;
using NameSpaceConnection;

/// <summary>
/// Summary description for clsBoschCustomerFunctions
/// </summary>
public class clsBoschCustomerFunctions
{
    public clsBoschCustomerFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IDataReader getCustomerList()
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("NameParam", "bosch"));
        return (new Connection()).ReadSp("ssp_GetCustomerList", paramList);
    }
    public DataTable getCustomerListTable()
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("NameParam", "bosch"));
        return (new Connection()).Fillsp("ssp_GetCustomerList", paramList);
    }
    public DataTable getWayBillListTable(string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("fromDate", fromDate));
        paramList.Add(new Parameters("todate", toDate));
        return (new Connection()).Fillsp("ssp_GetBoschCustomerWayBills", paramList);
    }
}