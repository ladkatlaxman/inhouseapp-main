using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AssignStationary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                (new CFunctions()).dropdwnlist(null, null, Ddl_Stationary, null, "startEndNo", "WayBillStationaryId", (new PickReqFunctions().getStationary(Session["BranchId"].ToString())));
                (new CFunctions()).dropdwnlist(null, null, Ddl_AssignBranch, null, "branchName", "branchId", (new PickReqFunctions().getBranch(Session["BranchId"].ToString())));

            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void Button_Assign_Click(object sender, EventArgs e)
    {
        bool alert = new PickReqFunctions().SaveStationary(Convert.ToInt32(Ddl_AssignBranch.SelectedValue),Convert.ToInt32(Ddl_Stationary.SelectedValue));
        if(alert)
        {
            (new CFunctions()).showalert("Button_Tab1Save", "ASSIGN", this);
        }
    }
}