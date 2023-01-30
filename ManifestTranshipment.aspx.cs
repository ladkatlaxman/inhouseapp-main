using BLFunctions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManifestTranshipment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                
                (new CFunctions()).dropdwnlist(null, null, Ddl_Route, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteName(Session["userBranch"].ToString())));
               
            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void Ddl_Route_SelectedIndexChanged(object sender, EventArgs e)
    {
        DivSelectedWaybills.Visible = false;
        DivWaybillsList.Visible = false;
        if (Ddl_Route.SelectedItem.ToString() != "SELECT")
        {
            (new CFunctions()).dropdwnlist(null, null, Ddl_Branch, null, "Branch", "BranchId", (new RouteMasterFunctions().getRouteBranchName(Convert.ToInt32(Ddl_Route.SelectedValue))));
        }       
    }

    protected void Btn_SearchWaybills_Click(object sender, EventArgs e)
    {
        if (Ddl_Route.SelectedItem.Text != "SELECT")
        {
            if (Ddl_Branch.SelectedItem.Text != "SELECT")
            {
                DivWaybillsList.Visible = true;              
                GV_ManifestTranshipment.DataSource = (new LoadingUnloadingFunctions()).GetManifestWayBillDetails(Ddl_Route.SelectedValue.ToString(), Session["BranchId"].ToString(), Ddl_Branch.SelectedValue.ToString());
                GV_ManifestTranshipment.DataBind();
                DivSelectedWaybills.Visible = true;
                GV_SelectedWaybillsManifest.DataSource = (new LoadingUnloadingFunctions()).GetManifestSelectedWayBillDetails(Convert.ToInt32(Session["BranchId"].ToString()), Convert.ToInt32(Ddl_Route.SelectedValue));
                GV_SelectedWaybillsManifest.DataBind();

            }
        }
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        Manifest headerDetail = new Manifest();
        headerDetail.date = Txt_Date.Text.ToString();
        headerDetail.routeId = Convert.ToInt32(Ddl_Route.SelectedValue);
        headerDetail.remark = Txt_Remark.Text.ToString().ToUpper();

        List<ManifestDetails> List = new List<ManifestDetails>();
        foreach (GridViewRow row in GV_ManifestTranshipment.Rows)
        {
            if (!string.IsNullOrEmpty(((TextBox)row.FindControl("ItemQty")).Text))
            {
                ManifestDetails details = new ManifestDetails();
                details.waybillId= Convert.ToInt32(row.Cells[1].Text);
                details.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                string Itemqty = ((TextBox)row.FindControl("ItemQty")).Text;
                details.qty = Convert.ToInt32(Itemqty);
                List.Add(details);
             }    
        }
        headerDetail.ManifestDetail = List;
        bool alertMsg = (new LoadingUnloadingFunctions()).SaveManifestTranshipment(headerDetail);
        if (alertMsg)
        {
            DivSelectedWaybills.Visible = true;
            GV_SelectedWaybillsManifest.DataSource = (new LoadingUnloadingFunctions()).GetManifestSelectedWayBillDetails(Convert.ToInt32(Session["BranchId"].ToString()), Convert.ToInt32(Ddl_Route.SelectedValue));
            GV_SelectedWaybillsManifest.DataBind();
            (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
        }
    }

    protected void Remove_Click(object sender, EventArgs e)
    {
        string id = (sender as LinkButton).CommandArgument;
        bool alert = (new LoadingUnloadingFunctions()).DeleteManifestTranshipment(id);
        if(alert)
        {
            (new CFunctions()).showalert("Delete_Data1", "DELETE", this);
            GV_SelectedWaybillsManifest.DataSource = (new LoadingUnloadingFunctions()).GetManifestSelectedWayBillDetails(Convert.ToInt32(Session["BranchId"].ToString()), Convert.ToInt32(Ddl_Route.SelectedValue));
            GV_SelectedWaybillsManifest.DataBind();
        }

    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void Ddl_Branch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DivSelectedWaybills.Visible = false;
        DivWaybillsList.Visible = false;
    }
}