using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;

public partial class Locations : System.Web.UI.Page
{
    int intLocId = 0; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null) Server.Transfer("Login.aspx"); // Response.Redirect("Login.aspx");

        if (!IsPostBack)
        {
            List<Branch> branches = new List<Branch>();
            branches = (new CommFunctions()).GetBranch(); 
            Branch all = new Branch();
            all.branchId = 0;
            all.branchName = "All";
            branches.Insert(0, all); 
            ddlBranches.DataSource = branches;
            ddlBranches.DataValueField = "BranchId";
            ddlBranches.DataTextField = "BranchName";
            ddlBranches.DataBind();
            ddlBranches.SelectedValue = Session["branchID"].ToString(); 
        }
        else
        {
        }
    }

    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }

    protected void btnGetLocations_Click(object sender, EventArgs e)
    {
        gvFirstGrid.DataSource = (new Invoicing()).getAllLocations(ddlBranches.SelectedValue.ToString()); 
        gvFirstGrid.DataBind();
    }
    protected void btnPINCode_Click(object sender, EventArgs e)
    {
        if (txtPINCode.Text.Trim() == "") return; 
        gvFirstGrid.DataSource = (new Invoicing()).getAllLocations("0", txtPINCode.Text);
        gvFirstGrid.DataBind();
    }

    protected void setODA_Click(object sender, EventArgs e)
    {
        intLocId = Convert.ToInt32((sender as LinkButton).CommandArgument);
        (new Invoicing()).setLocationDefinition(intLocId.ToString(), "ODA");
        btnGetLocations_Click(sender, e);
    }

    protected void removeODA_Click(object sender, EventArgs e)
    {
        intLocId = Convert.ToInt32((sender as LinkButton).CommandArgument);
        (new Invoicing()).setLocationDefinition(intLocId.ToString(), "REGULAR");
        btnGetLocations_Click(sender, e);
    }

    protected void setNS_Click(object sender, EventArgs e)
    {
        intLocId = Convert.ToInt32((sender as LinkButton).CommandArgument);
        (new Invoicing()).setLocationDefinition(intLocId.ToString(), "NON-SERVICE");
        btnGetLocations_Click(sender, e);
    }

    private int getLocIdIndex()
    {
        for(int iCol = 0; iCol < gvFirstGrid.Columns.Count - 1; iCol++)
        {
            if(gvFirstGrid.Columns[iCol].HeaderText == "locId")
            {
                return iCol; 
            }
        }
        return 0; 
    }
}