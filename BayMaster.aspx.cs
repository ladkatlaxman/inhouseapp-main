using System;
using BLFunctions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLProperties;

public partial class BayMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
               
            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        Bay bay = new Bay();
        bay.branchID = Convert.ToInt32(Session["BranchId"]);
        bay.bayName = Txt_BayName.Text.ToString().ToUpper();
        bay.maxQty = Convert.ToInt32(Txt_Qty.Text);
        bay.maxWt = Convert.ToDecimal(Txt_Weight.Text);
        bay.maxUOM = Ddl_Unit.SelectedItem.Text.ToString().ToUpper();
        bool alert = new PickReqFunctions().SaveBay(bay);
        if (alert)
        {
            (new CFunctions()).showalert("Button_Submit1", "SAVE", this);
            Txt_BayName.Text = "";
            Txt_Qty.Text = "";
            Txt_Weight.Text = "";
            Ddl_Unit.SelectedIndex = 0;
        }
    }
}