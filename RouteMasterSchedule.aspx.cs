using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
public partial class RouteMasterSchedule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            new CFunctions().dropdwnlist(null, null, Ddl_ViewRouteName, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteName(Session["userBranch"].ToString())));
    }

    /*----------------Fill Data in Gridview with sorting--------------------*/
    //private string SortDirection
    //{
    //    get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
    //    set { ViewState["SortDirection"] = value; }
    //}string sortExpression = null
    private void FillGrid()
    {
        List<RouteScheduleGrid> dt = (new RouteMasterFunctions()).SearchRouteScheduleList(Ddl_ViewRouteName.SelectedItem.Text);
        GV_RouteMasterSchedule.DataSource = dt;
        GV_RouteMasterSchedule.DataBind();
    }

    protected void GV_RouteMasterSchedule_Sorting(object sender, GridViewSortEventArgs e)
    {
        FillGrid();
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        FillGrid();
        GridViewHelper helper = new GridViewHelper(this.GV_RouteMasterSchedule);
        helper.RegisterGroup("routeName", true, true);
        helper.RegisterGroup("scheduleName", true, true);
        helper.ApplyGroupSort();
    }
}