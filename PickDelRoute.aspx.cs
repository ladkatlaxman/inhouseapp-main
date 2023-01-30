using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PickDelRoute : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                FillGrid();
            }
            else
                Response.Redirect("Login.aspx");          
        }
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        bool alert = new PickReqFunctions().SavePickDelRoute(txtRouteName.Text.ToString(), Convert.ToInt32(txtTotalDistance.Text), Convert.ToInt32(Session["BranchId"]));
        if (alert)
        {
            FillGrid();
            txtRouteName.Text = "";
            txtTotalDistance.Text = "";
            string a = "Button_Submit1";
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    private void FillGrid(string sortExpression = null)
    {
        DataTable dt = (new PickReqFunctions().ViewPickDelRoute(Convert.ToInt32(Session["BranchId"])));
        if (sortExpression != null)
        {
            DataView dv = dt.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            GV_RouteMaster.DataSource = dv;                               
        }
        else
        {
            GV_RouteMaster.DataSource = dt;
        }
        GV_RouteMaster.DataBind();      
    }
    protected void GV_RouteMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_RouteMaster.PageIndex = e.NewPageIndex;
        FillGrid();
    }
}