using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;

public partial class RouteMasterSchedule : System.Web.UI.UserControl
{
    int count = 0; bool alert;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                new CFunctions().dropdwnlist(null, null, Ddl_RouteName, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteName(Session["userBranch"].ToString())));
            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void Ddl_RouteName_SelectedIndexChanged(object sender, EventArgs e)
    {
        List<RouteScheduleGrid> dt = (new RouteMasterFunctions()).ShowRouteScheduleList(Convert.ToInt32(Ddl_RouteName.SelectedValue));
        Gv_RouteSchedule.DataSource = dt;
        Gv_RouteSchedule.DataBind();
    }

    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        RouteScheduleGrid RouteSchedule = new RouteScheduleGrid();
        RouteSchedule.routeDetailID = Convert.ToInt32(Ddl_RouteName.SelectedValue);
        RouteSchedule.scheduleName = Txt_ScheduleName.Text.ToString();
        RouteSchedule.remark = Txt_Remark.Text.ToString();
        RouteSchedule.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
        RouteSchedule.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
        RouteSchedule.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
        List<RouteScheduleGrid> lstRoutes = new List<RouteScheduleGrid>();
        foreach (GridViewRow drRow in Gv_RouteSchedule.Rows)
        {
            RouteScheduleGrid Routes = new RouteScheduleGrid();
            Routes.routeDetailID = Convert.ToInt32(drRow.Cells[1].Text.ToString());
            DropDownList day = (DropDownList)drRow.FindControl("ddl_Day");
            if (day.SelectedIndex == 0)
                count = 1;
            else
                Routes.routeDay = day.SelectedItem.ToString();
            DropDownList leavingHour = (DropDownList)drRow.FindControl("ddl_LHours");
            DropDownList leavingMinute = (DropDownList)drRow.FindControl("ddl_LMinutes");
            if (leavingHour.SelectedIndex == 0 || leavingMinute.SelectedIndex == 0)
                count = 1;
            else
                Routes.leaveTime = leavingHour.SelectedItem.ToString() + ":" + leavingMinute.SelectedItem.ToString();
            DropDownList reachHour = (DropDownList)drRow.FindControl("ddl_RHours");
            DropDownList reachMinute = (DropDownList)drRow.FindControl("ddl_RMinutes");
            if (reachHour.SelectedIndex == 0 || reachMinute.SelectedIndex == 0)
                count = 1;
            else
                Routes.reachTime = reachHour.SelectedItem.ToString() + ":" + reachMinute.SelectedItem.ToString();
            lstRoutes.Add(Routes);
        }
        RouteSchedule.routeScheduleDetails = lstRoutes;
        if (count != 1)
        {
            alert = (new RouteMasterFunctions()).SaveRouteSchedule(RouteSchedule);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please Field All Data');", true);
        }
        if (alert)
        {
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Data Sucessfully Added...');", true);
            Ddl_RouteName.SelectedIndex = 0;
            Txt_Remark.Text = "";
            Txt_ScheduleName.Text = "";
            Gv_RouteSchedule.DataSource = null;
            Gv_RouteSchedule.DataBind();
        }
    }
}