using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PickUpMaterial : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                GV_PickUpMaterial.DataSource = new MasterFormFunctions().GetPutUpMaterialDetails(Convert.ToInt32(Session["BranchId"]));
                GV_PickUpMaterial.DataBind();
            }
            else
                Response.Redirect("Login.aspx");
        }
    }

  
    protected void GV_PickUpMaterial_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "PICKUP")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GV_PickUpMaterial.Rows[rowIndex];
            PickUpMaterials PM = new PickUpMaterials();
            PM.putUpMaterialId = Convert.ToInt32(row.Cells[1].Text);          
            string qty = (row.FindControl("PickUpQty") as TextBox).Text;
            PM.pickUpQty = Convert.ToInt32(qty);

            bool alert = (new MasterFormFunctions()).SavePickUpMaterials(PM);
            if (alert)
            {
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                GV_PickUpMaterial.DataSource = new MasterFormFunctions().GetPutUpMaterialDetails(Convert.ToInt32(Session["BranchId"]));
                GV_PickUpMaterial.DataBind();
            }

        }
    }
}