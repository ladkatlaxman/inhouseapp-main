using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WayBillChargesNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                (new CFunctions()).dropdwnlist(null, null, Ddl_WaybillCharges, null, "RateType", "RateID", (new PickReqFunctions().getRateType()));
            }
            else
                Response.Redirect("Login.aspx");

            (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchWaybillNo", "hfWaybillID", "WaybillCharges.aspx/getWayBillNo", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
    }

    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        if (Txt_SearchWaybillNo.Text.Trim().Equals("")) return;
        if (Ddl_WaybillCharges.SelectedIndex == -1) return;
        if (Txt_RateValue.Text.Trim().Equals("")) return; 
        (new WayBillCharges()).saveWayBillCharges(Txt_SearchWaybillNo.Text, Ddl_WaybillCharges.SelectedValue.ToString(), Txt_RateValue.Text);
        Btn_View_Click(sender, e); 
    }

    protected void Delete_Data1_Click(object sender, EventArgs e)
    {

    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {

    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {

    }

    protected void Btn_View_Click(object sender, EventArgs e)
    {
        GV_WaybillCharges.DataSource = (new WayBillCharges()).getWayBillCharges(Txt_SearchWaybillNo.Text);
        GV_WaybillCharges.DataBind(); 
    }
}