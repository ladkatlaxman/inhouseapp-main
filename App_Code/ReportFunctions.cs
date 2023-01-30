//using System;
using System.Collections.Generic;
using System.Data;
using NameSpaceConnection;

/// <summary>
/// Summary description for ReportFunctions
/// </summary>
public class ReportFunctions
{
    public ReportFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public DataTable ReportViewVehicleWaybillExecDate(string FromDate = "", string ToDate = "")
    {
        List<Parameters> paramList = new List<Parameters>();
        if (FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate));
        if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportVehicleMaterial", paramList);
        return dt;
    }
    public DataTable ReportViewVehicleWaybillWayBillDate(string FromDate = "", string ToDate = "")
    {
        List<Parameters> paramList = new List<Parameters>();
        if (FromDate != "") paramList.Add(new Parameters("@WayBillFromDate", FromDate));
        if (ToDate != "") paramList.Add(new Parameters("@WayBillToDate", ToDate));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportVehicleMaterial", paramList);
        return dt;
    }
    public DataTable ReportViewPickUpWayBills(string BranchId = "")
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportPickUPDetails", paramList);
        return dt;
    }
    public DataTable ReportViewPickUpMemoWayBills(string vehicleRequestId = "")
    {
        List<Parameters> paramList = new List<Parameters>();
        if (vehicleRequestId != "") paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportPickUPMEMODetails", paramList);
        return dt;
    }
    public DataTable getPickDelWeight(string BranchId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("@branchID", BranchId.ToString()));
        paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportPickDeliveryWeight", paramList);
        return dt;
    }
    public DataTable ReportViewVehicleContractConditions()
    {
        List<Parameters> paramList = new List<Parameters>();
        DataTable dt = (new Connection()).Fillsp("ssp_ReportVehicleContractConditions", paramList);
        return dt;
    }
	public DataTable ReportMovingVehicleData(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportVehicleInMovement", paramList);
        return dt;
    }
    public DataTable getBranchLoad(string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>(); 
        paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
        paramList.Add(new Parameters("@toDate", toDate.ToString())); 
        DataTable dt = (new Connection()).Fillsp("ssp_ReportLoadSummary", paramList); 
        return dt; 
    }
    public DataTable ViewWayBillBookingReportDeliveryBranch(int BranchId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId > 0) paramList.Add(new Parameters("@DeliverybranchID", BranchId.ToString()));
        paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportWayBillsBookingReport", paramList);
        return dt;
    }
    public DataTable ViewWayTransition(int BranchId, string fromDate, string toDate, string Type = "D")
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        if (BranchId > 0) paramList.Add(new Parameters("@BranchId", BranchId.ToString())); 
        paramList.Add(new Parameters("@Type", Type)); 
        DataTable dt = (new Connection()).Fillsp("ssp_ReportBranchWayBillPerfNew", paramList); 
        return dt;
    }
    public DataTable ViewWayBillMovementSummary(int BranchId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        if (BranchId > 0) paramList.Add(new Parameters("@branchID", BranchId.ToString()));
	paramList.Add(new Parameters("@Type", "G")); 
        //DataTable dt = (new Connection()).Fillsp("ssp_ReportBranchWayBillPerfGroup", paramList);
	DataTable dt = (new Connection()).Fillsp("ssp_ReportBranchWayBillPerfNew", paramList); 
        return dt;
    }
    public DataTable DashBoardPendingDeliveries(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        paramList.Add(new Parameters("Type", "D"));
        DataTable dt = (new Connection()).Fillsp("ssp_DashBoardPendingDeliveryDetails", paramList);
        return dt;
    }
    public DataTable DashBoardPendingTranshipmentDetails(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (BranchId != "") paramList.Add(new Parameters("BranchId", BranchId));
        DataTable dt = (new Connection()).Fillsp("ssp_DashBoardPendingTranshipmentDetails", paramList);
        return dt;
    }
}