using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VRWayBills : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        divCustomerName.Visible = false; 
        divVendorName.Visible = false;
        divVehicle.Visible = false; 
        divDates.Visible = false;
        if (Request.QueryString["VRId"] != null)
        {
            string strVehicleRequestId = Request.QueryString["VRId"].ToString(); 
            divVehicle.Visible = true;
            IDataReader idr = (new clsVendorInvoice()).getVehicledetails(strVehicleRequestId);
            while(idr.Read())
            {
                lblVehicleNo.Text = idr["vehicleNo"].ToString(); 
                lblRoute.Text = idr["routeName"].ToString();
                lblHiringDate.Text = idr["HiringDate"].ToString();
            }
            idr.Close();
            idr = null;
            IDataReader data = (new clsVendorInvoice()).getWayBillExpenses(strVehicleRequestId);
            gvFirstGrid.DataSource = data;
            gvFirstGrid.DataBind(); 
            //data.Close();
            //data = null; 
        }
    }
}