using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
public partial class WBSRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ResetPage(); 
        }
    }

    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        if (txtQty.Text.Length < 2)
        {
            lblError.Text = "Please provide the Required no of Waybills.";
            return;
        }
        int input = 0;
        try
        {
            input = int.Parse(txtQty.Text); //Try to change string to integer
        }
        catch
        {
            lblError.Text = "Please provide the Required no of Waybills as a Number.";
            return;
        }
        string sValue = txtQty.Text.Substring(txtQty.Text.Length - 2);
        if (sValue != "50" && sValue != "00")
        {
            lblError.Text = "Please provide the Required no of Waybills in multiples of Fifty.";
            return;
        }
        //Save the Request 
        string strResult = new clsStationaryRequest().AddStationaryRequest(HttpContext.Current.Session["BranchId"].ToString(), txtQty.Text, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["userBranch"].ToString());
        ResetPage();
        lblResult.Text = strResult;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }


    protected void gvFirstGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandArgument.ToString() != "")
        {
            // Update this to Completed 
            (new clsStationaryRequest()).SetStationaryRequestStatus(e.CommandArgument.ToString(), "CLOSED", HttpContext.Current.Session["UserId"].ToString()); 
            ResetPage(); 
        }
    }

    private void ResetPage()
    {
        lblError.Text = "";
        lblResult.Text = "";
        gvFirstGrid.DataSource = (new clsStationaryRequest()).CurrentStationary(HttpContext.Current.Session["BranchId"].ToString());
        gvFirstGrid.DataBind();
    }
}
