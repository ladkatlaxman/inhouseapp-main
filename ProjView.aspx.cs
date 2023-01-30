using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProjView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        rptprojects.DataSource = (new project()).ViewProjects("1");
        rptprojects.DataBind();
    }

    protected void btnResult_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjAdd.aspx"); 
    }


    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btnAddProject_Click(object sender, EventArgs e)
    {
        Response.Redirect("ProjAdd.aspx");
    }


    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string projectid = ""; 
        projectid = e.ToString();
        Response.Redirect("ProjEdit.aspx?pid=" + projectid); 
    }

    protected void rptprojects_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //
        //Label lblId = (Label)e.Item.FindControl("lblProjectId");
        //string projectid = lblId.Text;
        LinkButton ButtonEdit = (LinkButton)e.Item.FindControl("btnEdit");
        string projectid = ButtonEdit.CommandArgument;

        switch (e.CommandName)
        {
            case "btnEdit":
                // get the ID of the button clicked from the argumenmt
                Response.Redirect("ProjEdit.aspx?pid=" + projectid);
                break;
            case "btnAddSubItem":
                Response.Redirect("ProjAdd.aspx?pid=" + projectid);
                break;

        }

    }

    protected void rptprojects_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
    }
}