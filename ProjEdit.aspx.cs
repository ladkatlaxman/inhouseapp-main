using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProjEdit : System.Web.UI.Page
{
    string projectid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        projectid = Request["pid"].ToString();

        rptprojectsstatus.DataSource = (new project()).ViewProjectStatus(projectid);
        rptprojectsstatus.DataBind();

        if (!IsPostBack)
        {
            rptprojects.DataSource = (new project()).ViewProjectOnId(projectid);
            rptprojects.DataBind();

            ddlStatus.DataTextField = "status";
            ddlStatus.DataValueField = "ProjectStatusId";
            ddlStatus.DataSource = (new project()).ViewProjectStatusMaster();
            ddlStatus.DataBind();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblErrorMessage.Text = "";

        if (txtAddComment.Text.Trim().Length == 0)
        {
            lblErrorMessage.Text = "Please provide the Comment.";
            return; ;
        }
        string projectid = "";
        projectid = Request["pid"].ToString();

        string creationDate = (new CFunctions()).CurrentDateTime();

        //Create a new Project with Open Status. 
        IDataReader dr = (new project()).CreateProjectUpdate(txtAddComment.Text, projectid, "", "", creationDate, ddlStatus.SelectedItem.Value,
                Session["UserId"].ToString());

        Page_Load(sender, e);
    }

    protected void rptprojects_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (!IsPostBack)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddlProjectStatus = (e.Item.FindControl("ddlProjectSTatus") as DropDownList);
                ddlProjectStatus.DataTextField = "status";
                ddlProjectStatus.DataValueField = "ProjectStatusId";
                ddlProjectStatus.DataSource = (new project()).ViewProjectStatusMaster();
                ddlProjectStatus.DataBind();
            }
        }
        //
    }
    protected void rptprojects_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //Do Nothing
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btnUpdateProjectStatus_Click(object sender, EventArgs e)
    {
    }
}