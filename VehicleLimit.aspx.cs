using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
public partial class VehicleLimit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            new CFunctions().dropdwnlist(null, null, Ddl_AccessBranch, null, "branchName", "branchId", (new CommFunctions().GetBranch()));
            new CFunctions().dropdwnlist(null, null, ddlTranshipmentRoute, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteNameForContract()));
        }
        if (IsPostBack)
        {
            //gvVehicleLimit.DataSource = (new BLFunctions.VehicleRequest()).getVehicleLimits(hVehicleId.Value.ToString()); 
        }
    }
    [WebMethod]
    public static string[] getVehicleLimits(string VehicleId)
    {
        return (new BLFunctions.VehicleRequest()).getVehicleLimits(VehicleId); 
    }
    protected void Button_Submit_Limit_Click(object sender, EventArgs e)
    {
        (new VehicleRequest()).SaveVehicleLimit(hVehicleId.Value.ToString(), Ddl_AccessBranch.SelectedValue.ToString(), ddlTranshipmentRoute.SelectedValue.ToString());
        txtVehicleNo.Text = ""; 
    }
}