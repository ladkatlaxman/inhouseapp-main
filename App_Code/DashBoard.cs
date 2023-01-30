using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using BLProperties;
using NameSpaceConnection;

/// <summary>
/// Summary description for DashBoard
/// </summary>
public class DashBoard
{
    public DashBoard()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public IDataReader ReportAreaBookings(string DateTime)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("DateTime", DateTime));
        return Reader = (new Connection()).ReadSp("ssp_ReportAreaBookings", paramList);
    }
    public IDataReader ReportBranchBookings(string DateTime)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("ToDate", DateTime));
        return Reader = (new Connection()).ReadSp("ssp_GetWayBillBookingBranchSummary", paramList);
    }
    public IDataReader getBranchEmailList()
    {
        List<Parameters> paramList = new List<Parameters>();
        return (new Connection()).ReadSp("ssp_GetBranchEmailList", paramList);
    }
    public IDataReader getStationaryDates(string branchID, string FromDate = "", string ToDate = "")
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        paramList.Add(new Parameters("@fromDate", FromDate));
        paramList.Add(new Parameters("@toDate", ToDate));

        return (new Connection()).ReadSp("ssp_GetStationaryBranchDates", paramList); 
    }

    public IDataReader DashBoardDailyBookings(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if(BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardBooking", paramList);
    }

    public DataTable DashBoardDailyBookingsTable(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return (new Connection()).Fillsp("ssp_DashBoardBooking", paramList);
    }
    public IDataReader DashBoardMonthlyBookings(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardMonthlyBooking", paramList);
    }
    public DataTable DashBoardMonthlyBookingsTable(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return (new Connection()).Fillsp("ssp_DashBoardMonthlyBooking", paramList);
    }
    public DataTable DashBoardMonthlyAverageBookingsTable(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return (new Connection()).Fillsp("ssp_DashBoardMonthlyAverageBooking", paramList);
    }
    public IDataReader DashBoardMonthlydeliveries(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardMonthlyDeliveries", paramList);
    }
    public IDataReader DashBoardMonthlyTillDateBookings(string BranchId, string date)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        if (date != "") paramList.Add(new Parameters("@TillDate", date));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardNthDateBooking", paramList);
    }
    public DataTable DashBoardMonthlyTillDateBookingsTable(string BranchId, string date)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        if (date != "") paramList.Add(new Parameters("@TillDate", date));
        return (new Connection()).Fillsp("ssp_DashBoardNthDateBooking", paramList);
    }
    public IDataReader DashBoardDeliveries(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardDeliveries", paramList);
    }
    public IDataReader DashBoardTranshipments(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardTranshipments", paramList);
    }
    public IDataReader DashBoardPOD(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardPODUploaded", paramList);
    }
    public IDataReader DashBoardPendingDeliveryDetails(string BranchId)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        return Reader = (new Connection()).ReadSp("ssp_DashBoardPendingDeliveryDetails", paramList);
    }
    public DataTableCollection DashBoardPendingDeliveryDetailsTable(string BranchId, string sType = "") 
    { 
        DataTableCollection dt; 
        List<Parameters> paramList = new List<Parameters>(); 
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId)); 
        if (sType != "") paramList.Add(new Parameters("Type", sType)); 
        DataSet ds = (new Connection()).FillDataSetSP("ssp_DashBoardPendingDeliveryDetails", paramList); 
        dt = ds.Tables; 
        return dt; 
    } 
    public IDataReader DashBoardPendingTranshipments(string BranchId, string NoOfDays) 
    { 
        IDataReader Reader = null; 
        List<Parameters> paramList = new List<Parameters>(); 
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId)); 
        if (NoOfDays != "") paramList.Add(new Parameters("NoOfDays", NoOfDays)); 
        return Reader = (new Connection()).ReadSp("ssp_DashBoardPendingTranshipments", paramList); 
    }
    public IDataReader DashBoardPendingDeliveries(string BranchId, string NoOfDays)
    {
        IDataReader Reader = null; 
        List<Parameters> paramList = new List<Parameters>(); 
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId)); 
        if (NoOfDays != "") paramList.Add(new Parameters("NoOfDays", NoOfDays)); 
        return Reader = (new Connection()).ReadSp("ssp_DashBoardPendingDeliveries", paramList); 
    }
    public IDataReader DashBoardPendingTranshipmentDetails(string BranchId)
    {
        IDataReader Reader = null; 
        List<Parameters> paramList = new List<Parameters>(); 
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId)); 
        return Reader = (new Connection()).ReadSp("ssp_DashBoardPendingTranshipmentDetails", paramList); 
    }
}