using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using System.Data;

public partial class PrintScreen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gvDeliveryLoadingDetails.Visible = false;
        string strType = "", strValue = "";
        tc_PrintCurrentDate.Text= "DATE: " + (new CFunctions()).CurrentDateTime().ToUpper();
        try
        {
            strType = Request["Type"].ToString().ToUpper();
        }
        catch { }
        try
        {
            strValue = Request["Value"].ToString().ToUpper();
        } catch { }
        if (strType == "DELIVERYLOAD")
        {
           tc_PrintTitle.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "DELIVERY LOADING SHEET";           
            List<WayBillDetails> dt= (new LoadingUnloadingFunctions()).GetDeliveryLoadingWayBillDetails(Convert.ToInt32(Session["BranchId"].ToString()));
            gvDeliveryLoadingDetails.DataSource = dt;
            gvDeliveryLoadingDetails.DataBind();
            gvDeliveryLoadingDetails.Visible = true;
            tc_TotalQty.Text = "TOTAL QTY :" + (dt.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
            tc_TotalWeight.Text = "TOTAL WEIGHT :" + (dt.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
        }
        if(strType == "DRS")
        {
            tr_TranshipDetail.Visible = true;

             tc_PrintTitle.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "DELIVERY RUN SHEET";
            if (strValue == "") return;
            List<WayBillDetails> dt = (new LoadingUnloadingFunctions()).GetDeliveryLoadedWayBills(Convert.ToInt32(strValue));
            gvDRS.DataSource = dt;
            gvDRS.DataBind();
            gvDRS.Visible = true;
            tc_Branch.Text = "DRS DATE :" + dt.First<WayBillDetails>().VehicleHiringDate;
            tc_VehicleNo.Text = "VEHICLE NO :" + dt.First<WayBillDetails>().VehicleNo;
            tc_VendorName.Text = "VENDOR NAME :" + dt.First<WayBillDetails>().VendorName;
            tc_PrintNo.Text = "DRS NO : D" + (100000000 + Convert.ToInt32(strValue)).ToString().Substring(1);            
            tc_TotalQty.Text = "TOTAL QTY :" + (dt.Sum(item => (Convert.ToInt32(item.itemQty)))).ToString();
            tc_TotalWeight.Text = "TOTAL WEIGHT :" + (dt.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
        }
	if (strType == "TSLOADED")
	{
            string strBranch = ""; 
	    tr_TranshipDetail.Visible = true;
            tc_PrintTitle.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "TRANSHIP LOADED SHEET";
            DataTable dt = new DataTable();
            //dt = new VehicleRequestFunction().GetReceivedItemList(Convert.ToInt32(strValue), 4, Convert.ToInt32(Session["branchId"].ToString()));
	    dt = new VehicleRequestFunction().GetReceivedItemList(Convert.ToInt32(strValue), 4, 0);
            tc_Branch.Text = "ROUTE:" + dt.Rows[0]["routeName"].ToString();
            tc_VehicleNo.Text = "VEHICLE NO:" + dt.Rows[0]["vehicleNo"].ToString();
            tc_PrintNo.Text ="MANIFEST NO :" + "M" + (100000000 + Convert.ToInt32(strValue)).ToString().Substring(1); //Session["ManifestNo"].ToString();           
            Int32 intLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
            decimal dblLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
            tc_TotalQty.Text = "TOTAL QTY :" + intLoadedQty.ToString();
            tc_TotalWeight.Text = "TOTAL WEIGHT :" + dblLoadedWT.ToString();  
            dt.Columns.Remove("routeName");
            dt.Columns.Remove("ActualQty");
            dt.Columns["vehicleNo"].ColumnName = "SR NO";
            dt.Columns["wayBillNo"].ColumnName = "WAYBILL NO";
            dt.Columns["WaybillDate"].ColumnName = "WAYBILL DATE";
            dt.Columns["pickUpBranchName"].ColumnName = "PICKUP BRANCH";
            dt.Columns["DeliveryBranchName"].ColumnName = "DELIVERY BRANCH";
            dt.Columns["materialName"].ColumnName = "MATERIAL";
            dt.Columns["typeOfPackage"].ColumnName = "PACKAGE";
            dt.Columns["valueActualWt"].ColumnName = "ACTUAL WT"; 
            dt.Columns["valueChargedWt"].ColumnName = "CHARGE WT";           
            dt.Columns["Qty"].ColumnName = "QTY";
            dt.Columns["InvoiceNo"].ColumnName = "INVOICE NO";
            dt.Columns["Remark"].ColumnName = "REMARK";
            dt.Columns["ManifestBranch"].ColumnName = "MANIFEST";
            int counter = 1;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["SR NO"] = (counter++).ToString();               
            }
	    strBranch = Request["branch"].ToString(); 
            if(strBranch.ToLower() != "all" & strBranch != "")
            {
            	string strBranchNo = (new CommFunctions()).getBranchNo(strBranch);
            	tc_PrintNo.Text = "M" + (100000000 + Convert.ToInt32(strValue)).ToString().Substring(1) + "/" + strBranchNo; //Session["ManifestNo"].ToString();
            	dt = dt.AsEnumerable().Where(A => A.Field<String>("MANIFEST").ToLower() == strBranch.ToLower()).CopyToDataTable();
            }
            gvLoadingSheet.DataSource = dt;
            gvLoadingSheet.DataBind();          
            gvLoadingSheet.Visible = true;
	}
	if(strType == "PICKUNLOAD")
        {
            tc_PrintTitle.Text = "PICKUP UNLOADING SHEET";
            gvLoadingSheet.DataSource = (new CommFunctions()).GetPickUnloadWayBillDetails(strValue, Session["branchId"].ToString());
            gvLoadingSheet.DataBind();
            gvLoadingSheet.Visible = true;
        }
        if (strType == "TSUNLOAD")
        {
            tc_PrintTitle.Text = "TRANSHIP UNLOADING SHEET";
            gvLoadingSheet.DataSource = (new CommFunctions()).GetTranshipUnloadWayBillDetails(strValue, Session["branchId"].ToString());
            gvLoadingSheet.DataBind();
            gvLoadingSheet.Visible = true;
        }
        if (strType == "TSLOAD")
        {
            tc_PrintNo.Visible = false;
            tc_PrintTitle.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +"TRANSHIP LOADING SHEET";
            List<WayBillDetails> ManifestDetails= (new LoadingUnloadingFunctions()).GetLoadingWayBillDetails(strValue, Session["branchId"].ToString(), "", "");
            gvTranshipLoadingSheet.DataSource = ManifestDetails;
            gvTranshipLoadingSheet.DataBind();
            gvTranshipLoadingSheet.Visible = true;
            tc_TotalQty.Text = "TOTAL QTY :" + (ManifestDetails.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
            tc_TotalWeight.Text = "TOTAL WEIGHT :" + (ManifestDetails.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
        }
	if(strType == "PICKUP")	
        {	
            tc_PrintNo.Visible = false; 	
            tc_PrintTitle.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 	
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PICK UP LOADING SHEET"; 	
            DataTable dt = new DataTable(); 	
            dt = new ReportFunctions().ReportViewPickUpWayBills(Session["BranchId"].ToString()); 	
            gvLoadingSheet.DataSource = dt;	
            gvLoadingSheet.DataBind();
            gvLoadingSheet.Visible = true;
        }
        if (strType == "PICKUPMEMO")	
        {	
            tc_PrintNo.Visible = false;	
            tc_PrintTitle.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +	
                "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PICK UP LOADING SHEET";	
            DataTable dtVehicle = (new CommFunctions()).ViewVehicleMovements(strValue);
            for(int iRow = 0; iRow < dtVehicle.Rows.Count; iRow++)
            {
                tr_TranshipDetail.Visible = true;
                tc_Branch.Text = "Branch : " + dtVehicle.Rows[iRow]["Branch"].ToString();
                tc_VehicleNo.Text = "Vehicle No : " + dtVehicle.Rows[iRow]["Vehicle No"].ToString();
                tc_VendorName.Text = dtVehicle.Rows[iRow]["Vendor"].ToString(); 
            }
            DataTable dt = new DataTable();	
            dt = new ReportFunctions().ReportViewPickUpMemoWayBills(strValue);	
            gvLoadingSheet.DataSource = dt;	
            gvLoadingSheet.DataBind();	
            gvLoadingSheet.Visible = true;
            Decimal TotalQty = Convert.ToDecimal(dt.Compute("SUM(Qty)", string.Empty));
            Decimal TotalWt = Convert.ToDecimal(dt.Compute("SUM(Weight)", string.Empty));
            tc_TotalQty.Text = "TOTAL QTY :" + TotalQty.ToString();
            tc_TotalWeight.Text = "TOTAL WEIGHT :" + TotalWt.ToString();
            tc_TotalQty.Visible = true;
            tc_TotalWeight.Visible = true;
        }
    }
}
