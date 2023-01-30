using System;
using System.Data; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;

public partial class PrintLHS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strLHSNo = "";
        try
        {
            strLHSNo = Request["Value"].ToString();
        }
        catch  { }
        if (strLHSNo == "") return;
        DataTable dt = (new CommFunctions()).getLHSData(strLHSNo); 
        foreach(DataRow dr in dt.Rows)
        {
            tc_VendorName.Text = "Vendor Name : - " + dr["vendorName"].ToString(); 
            tc_VehicleNo.Text = "Vehicle No : - " + dr["vehicleNo"].ToString();
            tc_VehicleType.Text = "Vehicle Type : - " + dr["VehicleType"].ToString();
            tc_vehicleNature.Text = "Vehicle Nature : - " + dr["vehicleCategory"].ToString();
            break;
        }
        gvLHSSummary.DataSource = dt;
        gvLHSSummary.DataBind(); 
    }
}