using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using NameSpaceConnection;

public partial class WaybillCharges : System.Web.UI.Page
{
    int s = 0;
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
    [WebMethod]
    public static string[] getWayBillNo(string searchPrefixText, string data = null)
    {
        //return (new PickReqFunctions()).getWaybillNo(searchPrefixText, data);
        List<string> WaybillNo = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillNo", searchPrefixText)); 
        DataTable dtTable = (new Connection()).Fillsp("ssp_GetWaybillNoListOne", paramList); 
        //HttpContext.Current.Application["WayBillNo"] = dtTable; 
        foreach (DataRow dr in dtTable.Rows) 
        { 
            WaybillNo.Add(string.Format("{0}ʭ{1}", dr["wayBillNo"].ToString(), dr["waybillID"].ToString())); 
            break; 
        } 
        return WaybillNo.ToArray(); 
    }
    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("WayBillId", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("WaybillNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("RateTypeId", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("RateTypeName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Value", typeof(String)));

        if (ViewState["ChargesDetails"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["ChargesDetails"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = hfWaybillID.Value.ToString();
            dr[1] = Txt_SearchWaybillNo.Text.ToString();
            dr[2] = Ddl_WaybillCharges.SelectedValue.ToString();
            dr[3] = Ddl_WaybillCharges.SelectedItem.ToString().ToUpper();
            dr[4] = Txt_RateValue.Text.ToString();
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = hfWaybillID.Value.ToString();
            dr[1] = Txt_SearchWaybillNo.Text.ToString();
            dr[2] = Ddl_WaybillCharges.SelectedValue.ToString();
            dr[3] = Ddl_WaybillCharges.SelectedItem.ToString().ToUpper();
            dr[4] = Txt_RateValue.Text.ToString();
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["ChargesDetails"] != null)
        {
            GV_WaybillCharges.DataSource = (DataTable)ViewState["ChargesDetails"];
            GV_WaybillCharges.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_WaybillCharges.DataSource = dt;
            GV_WaybillCharges.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["ChargesDetails"] = dt;
    }
    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        divWaybillCharges.Visible = true;
        if (ViewState["ChargesDetails"] != null)
        {
            DataTable dt = (DataTable)ViewState["ChargesDetails"];
            int count = dt.Rows.Count;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if ((dt.Rows[i]["RateTypeName"]).ToString() == Ddl_WaybillCharges.SelectedItem.ToString())
                {
                    s = 1;
                    //  Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('This is Already Selected');return false;}</script>");

                    string a = "Btn_Add";
                    string b = "ADD1";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);


                    break;
                }

            }
            if (s == 0)
            {
                BindGrid(count);
            }
            else
                s = 0;

        }
        else
        {
            BindGrid(1);
        }

        Ddl_WaybillCharges.SelectedIndex = 0;
        Txt_RateValue.Text = "";
    }
    protected void Delete_Data1_Click(object sender, EventArgs e)
    {
        String delete = (sender as LinkButton).CommandArgument;
        DataTable dt = (DataTable)ViewState["ChargesDetails"];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if ((dt.Rows[i]["RateTypeId"]).ToString() == delete)
            {
                dt.Rows[i].Delete();
            }
        }
        GV_WaybillCharges.DataSource = dt;
        GV_WaybillCharges.DataBind();
        Ddl_WaybillCharges.SelectedIndex = 0;
        Txt_RateValue.Text = "";

        string a = "Delete_Data1";
        string b = "DELETE";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    }
    protected void Button_Submit_Click(object sender, EventArgs e)
    {

        DataTable dt = (DataTable)ViewState["ChargesDetails"];
        if(ViewState["ChargesDetails"] != null)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                PickReqInvoice PRI = new PickReqInvoice();
                PRI.WaybillId = Convert.ToInt32(dt.Rows[i]["WayBillId"]);
                PRI.RateID = Convert.ToInt32(dt.Rows[i]["RateTypeId"]);
                PRI.Value = dt.Rows[i]["Value"].ToString();
                new PickReqFunctions().SaveWaybillCharges(PRI);
            }
            Txt_SearchWaybillNo.Text = "";
            hfWaybillID.Value = "";
            Ddl_WaybillCharges.SelectedIndex = 0;
            Txt_RateValue.Text = "";
            dt.Rows.Clear();
            divWaybillCharges.Visible = false;
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