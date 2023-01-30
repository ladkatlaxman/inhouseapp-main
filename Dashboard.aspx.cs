using System;
using BLFunctions; 
using System.Web.UI;
using System.Collections.Generic;
using BLProperties;

public partial class Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null) Server.Transfer("Login.aspx"); // Response.Redirect("Login.aspx");
        if (!Page.IsPostBack)
        {
            lblEmployeeDetails.Text = "User: " + Session["username"].ToString();
            lblBranch.Text = "Branch: " + Session["userBranch"].ToString();

            List<DdlBranch> ddlBranches = (new BranchFunctions()).getBranches(Convert.ToInt32(Session["userId"].ToString()));

            lstBranch.DataSource = ddlBranches;
            lstBranch.DataTextField = "Branch";
            lstBranch.DataValueField = "BranchId";
            lstBranch.DataBind();

            int selBranchId = (new CommFunctions()).getUserLastLoginBranch(Session["userID"].ToString());
            lstBranch.SelectedValue = selBranchId.ToString();
            setBranch_Click(null,  null);

            pickupDetails();
            vehicleDetails();
            dashDetails();
        }
    }

    public void pickupDetails()
    {
        string str = (new BranchFunctions()).getNotifications(Convert.ToInt32(Session["branchId"].ToString()));
        //lblNotifications.Text = "<marquee> " + str + " </marquee>";
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.RemoveAll();
        Server.Transfer("Login.aspx");
        //Response.Redirect("Login.aspx");
    }

    protected void setBranch_Click(object sender, EventArgs e)
    {
        //Session.RemoveAll();
        Session["BranchId"] = lstBranch.SelectedItem.Value;
        Session["userBranch"] = lstBranch.SelectedItem.Text;
        lblBranch.Text = "Branch: " + Session["userBranch"].ToString();
        ((System.Web.UI.WebControls.Label)Master.FindControl("lblBranch")).Text = "Branch : " + Session["userBranch"].ToString();
        (new BranchFunctions()).getBranches(Convert.ToInt32(Session["userId"].ToString()));
        (new CommFunctions()).SetUserBranch(Session["userID"].ToString(), Session["BranchId"].ToString());
        pickupDetails();
        vehicleDetails();
        dashDetails();
    }

    private void vehicleDetails()	
    {	
        try	
        {	
            gvVehicles.DataSource = (new BranchFunctions()).ViewBranchRelatedVehicles(Convert.ToInt16(Session["BranchId"]));	
            gvVehicles.DataBind();	
        }	
        catch { } 	
    }
    private void dashDetails()
    {
        try
        {
            DdlBranch dl = new DdlBranch();
            dl.BranchId = Convert.ToInt32(Session["BranchId"].ToString()); 
            List<DdlBranch> dlList = new List<DdlBranch>(); 
            dlList.Add(dl);
            gdDash.DataSource = (new dashDetails()).GetDashBranches(dlList);
            gdDash.DataBind();
        }
        catch { }
    }
}