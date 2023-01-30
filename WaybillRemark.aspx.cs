using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WaybillRemark : System.Web.UI.Page
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

            (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchWaybillNo", "hfWaybillID", "WaybillRemark.aspx/getWayBillNo", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
    }
    [WebMethod]
    public static string[] getWayBillNo(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getWaybillNo(searchPrefixText, data);
    }
    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        bool alert = new PickReqFunctions().SaveWaybillRemark(Convert.ToInt32(hfWaybillID.Value),Txt_Remark.Text.ToString(),Convert.ToInt32(Session["BranchId"]));
        if(alert)
        {
            Txt_SearchWaybillNo.Text = "";
            hfWaybillID.Value = "";
            Txt_Remark.Text = "";
            string a = "Button_Submit1";
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
}