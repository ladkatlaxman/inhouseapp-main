using BLProperties;
using System;
using System.Collections.Generic;
using System.Data; 
using System.Linq;
using System.Web;
using NameSpaceConnection; 

/// <summary>
/// Summary description for dashBranch
/// </summary>
public class dashBranch
{

    public dashBranch()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string sBranch { get; set;  }
    public string Range { get; set; }

    public string ChargedWeight { get; set; }
    public string Freight { get; set; }
}

public class dashDetails
{
    public List<dashBranch> GetDashBranches(List<DdlBranch> branches)
    {
        IDataReader dr;
        List<dashBranch> dashBranches = new List<dashBranch>();
        List<Parameters> paramList;
        dashBranch dashbranch;
        int icount = 0 ; 

        string strYesterdayDateTime = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
        string strStartDateTime = DateTime.Now.AddDays(-1).ToString("01/MM/yyyy");

        foreach (DdlBranch ddlBranch in branches)
        {
            icount++; 
            paramList = new List<Parameters>();
            paramList.Add(new Parameters("BranchId", ddlBranch.BranchId.ToString()));
            paramList.Add(new Parameters("@ToDate", strYesterdayDateTime));

            dr = (new Connection()).ReadSp("ssp_GetWayBillBookingBranchSummary", paramList);
            while (dr.Read())
            {
                dashbranch = new dashBranch();
                dashbranch.sBranch = dr["Branch"].ToString();
                dashbranch.ChargedWeight = dr["Charged Weight"].ToString();
                dashbranch.Freight = dr["Freight"].ToString();
                dashbranch.Range = "Till Date : " + strYesterdayDateTime; 

                dashBranches.Add(dashbranch);
                break;
            }

            paramList.Add(new Parameters("@FromDate", strYesterdayDateTime));
            dr = (new Connection()).ReadSp("ssp_GetWayBillBookingBranchSummary", paramList);
            while (dr.Read())
            {
                dashbranch = new dashBranch();
                dashbranch.sBranch = dr["Branch"].ToString();
                dashbranch.ChargedWeight = dr["Charged Weight"].ToString();
                dashbranch.Freight = dr["Freight"].ToString();
                dashbranch.Range = "On Date : " + strYesterdayDateTime;

                dashBranches.Add(dashbranch);
                break;
            }
            if(icount >= 8) break; 
        }
        return dashBranches;
    }

}