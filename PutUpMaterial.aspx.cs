using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PutUpMaterial : System.Web.UI.Page
{
    List<BLProperties.Bay> bays;
    protected void Page_Load(object sender, EventArgs e)
    {      
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                GV_PutUpMaterial.DataSource = new MasterFormFunctions().GetGoodsReceiptNoteDetails(Convert.ToInt32(Session["BranchId"]));
                GV_PutUpMaterial.DataBind();
            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void GV_PutUpMaterial_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        {
            foreach (TableCell c in e.Row.Cells)
            {
                //.Controls
                DropDownList Ddl_BayName = (c.FindControl("ddlBay") as DropDownList);
                if (Ddl_BayName != null)
                {
                    if (bays == null) bays = new PickReqFunctions().getBayName(Convert.ToInt32(Session["BranchId"]));

                    Ddl_BayName.DataSource = bays;
                    Ddl_BayName.DataTextField = "bayName";
                    Ddl_BayName.DataValueField = "ID";
                    Ddl_BayName.DataBind();
                }
            }
        }
    }

    //protected void BaySet_Click(object sender, EventArgs e)
    //{
    //    string id = (sender as LinkButton).CommandArgument;
    //    PutUpMaterials PM = new PutUpMaterials();
    //    foreach (GridViewRow row in GV_PutUpMaterial.Rows)
    //    {
    //        if (!string.IsNullOrEmpty(((TextBox)row.FindControl("PutUpQty")).Text))
    //        { 
    //            string bayId = ((DropDownList)row.FindControl("ddlBay")).SelectedValue;
    //            PM.BayMasterId = Convert.ToInt32(bayId);
    //            PM.grnId = Convert.ToInt32(id);
    //            string qty = ((TextBox)row.FindControl("PutUpQty")).Text;
    //            PM.putUpQty = Convert.ToInt32(qty);
    //        }
    //    }
    //    bool alert = (new MasterFormFunctions()).SavePutUpMaterials(PM);
    //    if (alert)
    //    {
    //        (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
    //        GV_PutUpMaterial.DataSource = new MasterFormFunctions().GetGoodsReceiptNoteDetails(Convert.ToInt32(Session["BranchId"]));
    //        GV_PutUpMaterial.DataBind();
    //    }
    //}

    protected void GV_PutUpMaterial_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "SET")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GV_PutUpMaterial.Rows[rowIndex];
            PutUpMaterials PM = new PutUpMaterials();
           // string bayId = ((DropDownList)row.FindControl("ddlBay")).SelectedValue;
            string bayId = (row.FindControl("ddlBay") as DropDownList).SelectedValue;
            PM.BayMasterId = Convert.ToInt32(bayId);
            PM.grnId = Convert.ToInt32(row.Cells[1].Text);
           // string qty = ((TextBox)row.FindControl("PutUpQty")).Text;
            string qty = (row.FindControl("PutUpQty") as TextBox).Text;
            PM.putUpQty = Convert.ToInt32(qty);
         
            bool alert = (new MasterFormFunctions()).SavePutUpMaterials(PM);
            if (alert)
            {
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                GV_PutUpMaterial.DataSource = new MasterFormFunctions().GetGoodsReceiptNoteDetails(Convert.ToInt32(Session["BranchId"]));
                GV_PutUpMaterial.DataBind();
            }

        }
    }
}