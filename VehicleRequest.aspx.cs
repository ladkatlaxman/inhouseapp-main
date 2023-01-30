using System;
using System.Collections.Generic;
using System.Data; 
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
public partial class VehicleRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            (new CFunctions()).dropdwnlist(null, null, ddlTranshipmentRoute, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteName(Session["userBranch"].ToString())));
            (new CFunctions()).dropdwnlist(null, null, ddlDeliveryRoute, null, "routeName", "routeID", (new RouteMasterFunctions().getDeliveryRouteName(Convert.ToInt32(Session["BranchId"]))));
            List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewData(Convert.ToInt32(Session["BranchId"]), "PD");
            GV_PickDelView.DataSource = ViewList;
            GV_PickDelView.DataBind();
            List<VehicleRequestProperties> ViewList1 = (new VehicleRequestFunction()).ViewData(Convert.ToInt32(Session["BranchId"]), "RT");
            GV_TranshipView.DataSource = ViewList1;
            GV_TranshipView.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", @"$(""[id$= Txt_HiringDate]"").datepicker({ dateFormat: 'dd/mm/yy', minDate: 0 }).datepicker(""setDate"", new Date());", true);
        }
        try
        {
            if (Request["q"] == "RT") Ddl_Condition.SelectedValue = "RT"; 
        }
        catch { } 
    }

    [WebMethod]
    public static string[] getVehicles(string searchPrefixText)
    {
        return (new BLFunctions.VehicleRequest()).getVehicles(searchPrefixText); 
    }
    [WebMethod]
    public static string[] getVehicleDetail(string searchPrefixText)
    {
        return (new BLFunctions.VehicleRequest()).getVehicleDetail(searchPrefixText);
    }
    [WebMethod]
    public static string[] getRouteSchedules(string searchPrefixText)
    {
        return (new BLFunctions.VehicleRequest()).getRouteSchedules(searchPrefixText);
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        // Submits the Page for a new Vehicle Creation 
        if (hVehicleId.Value == "")
        {
            return; 
        }
        if(Ddl_Condition.SelectedValue == "RT")
        {
            if (ddlTranshipmentRoute.SelectedValue == "" || Ddl_RouteSchedule.SelectedValue == "")
                return; 
        }
        IDataReader dr = (new BLFunctions.VehicleRequest()).SaveVehicleRequest(hVehicleId.Value.ToString(), Ddl_Condition.SelectedValue.ToString(),
                        hdHiringDate.Value.ToString(), Session["BranchId"].ToString(), ddlTranshipmentRoute.SelectedValue.ToString(),
                        hdRouteSchedule.Value.ToString(), ddlDeliveryRoute.SelectedValue.ToString(), Session["UserId"].ToString(),
                        new CFunctions().CurrentDateTime());
        while (dr.Read())
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "showSubmit('" + dr["Message"].ToString() + "');", true);
        }
        txtVehicleNo.Text = "";
        hVehicleId.Value = ""; 
    }
}