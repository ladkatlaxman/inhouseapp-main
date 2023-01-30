using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VendorBill : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) loadInvoice(); 
    }

    private void loadInvoice()
    {
        try
        {
            hfVendorId.Value = Request["vendorId"].ToString();
            Vendor vendor = (new clsVendorInvoice()).getVendorName(hfVendorId.Value.ToString());
            Txt_VendorName.Text = vendor.Name;
            Txt_FromDate.Text = Request["FromDate"].ToString();
            Txt_ToDate.Text = Request["ToDate"].ToString();

            DataTable dtTripList = (new clsVendorInvoice()).ViewTripList(hfVendorId.Value.ToString(), Txt_FromDate.Text, Txt_ToDate.Text);
            gvFirstGrid.DataSource = dtTripList;
            gvFirstGrid.DataBind();
            try
            {
                int totalWeight = Convert.ToInt32(dtTripList.Compute("SUM(ActualWt)", string.Empty)); 
                lblWeight.Text = totalWeight.ToString(); 
                int totalDockets = Convert.ToInt32(dtTripList.Compute("SUM(WayBillNo)", string.Empty)); 
                lblNoOfDockets.Text = totalDockets.ToString(); 
                int totalNoOfItems = Convert.ToInt32(dtTripList.Compute("SUM(NoOfItems)", string.Empty)); 
                lblNoOfItems.Text = totalNoOfItems.ToString(); 
                int NoOfTrips = Convert.ToInt32(dtTripList.Compute("COUNT(ROUTE)", string.Empty)); 
                lblNoOfTrips.Text = NoOfTrips.ToString(); 
                decimal decAmount = Convert.ToInt32(dtTripList.Compute("SUM(Amount)", string.Empty)); 
                lblValue.Text = decAmount.ToString(); 
                //int NoOfDays = Convert.ToInt32(dtTripList.Compute("COUNT DISTINCT(DATE)", string.Empty));
                //lblNoOfDays.Text = NoOfDays.ToString(); 
            }
            catch
            { }
            IDataReader dr = (new clsVendorInvoice()).ViwVendorFixBill(hfVendorId.Value.ToString());
            while (dr.Read())
            {
                lblFixCost.Text = "Fixed Cost : " + dr["Value"].ToString();
            }
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message; 
        }
    }

    protected void btnSaveKMDetails_Click(object sender, EventArgs e)
    {
        lblInvoiceValue.Text = "";
        foreach (GridViewRow dr in gvFirstGrid.Rows)
        {
            TextBox txtKMS = ((TextBox)dr.FindControl("txtKMS"));
            HiddenField hfVehicleRequestId = (HiddenField)dr.FindControl("hfVehicleRequestId");
            //lblInvoiceValue.Text += hfVehicleRequestId.Value.ToString() + ":" + txtKMS.Text + ":::::"; 
            (new clsVendorInvoice()).saveVehicleRequestsKMS(hfVehicleRequestId.Value.ToString(), txtKMS.Text); 
        }
        loadInvoice(); 
    }

    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        HyperLink lnkVRWayBills = ((HyperLink)e.Row.FindControl("lnkRouteId"));
        if (lnkVRWayBills != null)
        {
            lnkVRWayBills.Text = ((Label)e.Row.FindControl("lnkVehicleRequestId")).Text; 
            lnkVRWayBills.NavigateUrl = "VRWayBills.aspx?VRId=" + lnkVRWayBills.Text; 
        }
    }

    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        if(lblFixCost.Text.Equals(""))
        {
            (new clsVendorInvoice()).createVehicleFreightALL(hfVendorId.Value.ToString(), Txt_FromDate.Text, Txt_ToDate.Text);
        }
        else
        {
            (new clsVendorInvoice()).createVehicleFreightKMS(hfVendorId.Value.ToString(), Txt_FromDate.Text, Txt_ToDate.Text);
        }
        loadInvoice();
    }
}