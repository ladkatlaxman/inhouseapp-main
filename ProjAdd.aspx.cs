using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ProjAdd : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string projectId = "";
        if (!IsPostBack)
        {

            try
            {
            if (Request["pid"]!= null)
            {
                projectId = Request["pid"].ToString();
            }
        }
        catch { }

        if(projectId == "")
        {
            lblHeading.Text = "ADD NEW PROJECT DETAILS";
            lblUser.Text = Session["username"].ToString();
        }


        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblErrorMessage.Text = "";
        if (txtAddProject.Text.Trim().Length == 0) { 
            lblErrorMessage.Text = "Please Provide the Project Details.";
            return;
        }

        if (txtAddStartDate.Text.Trim().Length == 0)
        {
            lblErrorMessage.Text = "Please Provide the Project Start Date.";
            return;
        }

        if (txtAddEndDate.Text.Trim().Length == 0)
        {
            lblErrorMessage.Text = "Please Provide the Project End Date.";
            return;
        }

        //Save the Details of the Project 
        {
            string creationDate = (new CFunctions()).CurrentDateTime();

            //Create a new Project with Open Status. 
            IDataReader dr =  (new project()).CreateProject(txtAddProject.Text, "1", creationDate, txtAddStartDate.Text, txtAddEndDate.Text,
                    null, Session["UserId"].ToString());

            string sProjectId = "";
            //Move to the Project Edit Page. 
            while(dr.Read()) 
            {
                sProjectId = dr["ProjectId"].ToString(); 
            }
            //if(sProjectId != "") Response.Redirect("ProjEdit.aspx?pid=" + sProjectId); 
            Response.Redirect("ProjView.aspx");
        }
    }

}
