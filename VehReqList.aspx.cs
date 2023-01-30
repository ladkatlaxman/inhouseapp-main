using System;
using System.Collections.Generic;
using System.Data; 
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
public partial class VehReqList : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";
        lblError.Text = ""; 
        if (!IsPostBack)
        {
            GetBranchList();
            fromfinalDate = DateTime.Now.AddDays(-1).ToString("dd") + @"/" + DateTime.Now.AddDays(-1).ToString("MM") + @"/" + DateTime.Now.AddDays(-1).ToString("yyyy");
            tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");

            DataTable dt = (new CommFunctions()).GetRoutes();
            DataRow dr = dt.NewRow();
            dr["routeId"] = 0;
            dr["routeName"] = "All";
            dt.Rows.Add(dr);
            cmbRoute.DataTextField = "routeName"; 
            cmbRoute.DataValueField = "routeID";
            cmbRoute.DataSource = dt;
            cmbRoute.DataBind(); 
            /*dt.Columns["routeID"].ColumnName = "SR.NO";
            dt.Columns["routeName"].ColumnName = "ROUTE NAME";*/
           
        }
        else
        {
            if (Txt_FromDate.Text.ToString().Trim() != "") fromfinalDate = Txt_FromDate.Text.ToString();
            if (Txt_ToDate.Text.ToString().Trim() != "") tofinalDate = Txt_ToDate.Text.ToString();
        }
        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
              "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');";
        (new CFunctions()).GetJavascriptFunction(this, "TxtVendorName", "hfVendorName", "Contract_VendorMaster.aspx/getVendorName", "GetData", "});});");
        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        gvFirstGrid.DataSource = (new VehicleRequestFunction()).ViewVehicleVendorRequests(Txt_FromDate.Text, Txt_ToDate.Text, "", hfVendorName.Value.ToString(), cmbBranch.SelectedValue.ToString(), txtVehicleNo.Text, cmbRoute.SelectedValue.ToString()); 
        gvFirstGrid.DataBind();
    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = new CFunctions().CurrentDateTime();
        string ReportName = HeaderName.InnerText;
        gvFirstGrid.Visible = true;
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Report_" + fromfinalDate + ":" + tofinalDate + CurrentDateTime + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        gvFirstGrid.GridLines = GridLines.Both;
        gvFirstGrid.HeaderStyle.Font.Bold = true;
        gvFirstGrid.RenderControl(htmltextwrtter);

        Response.Write(strwritter.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btnCreateBill_Click(object sender, EventArgs e) 
    {
        String strVendorId = String.Empty, strVehicleRequestIds = String.Empty; 
        foreach (GridViewRow row in gvFirstGrid.Rows) 
        { 
            CheckBox chk = (CheckBox)row.FindControl("chkSelect");
            if (chk.Checked == true)
            {
                HiddenField hVehicleRequestId = (HiddenField)row.FindControl("hvehicleRequestId");
                HiddenField hVendorId = (HiddenField)row.FindControl("hvendorId");
                if (strVendorId == String.Empty)
                {
                    strVendorId = hVendorId.Value.ToString();
                }
                else
                {
                    if (strVendorId != hVendorId.Value.ToString())
                    {
                        lblError.Text = "Select a single Vendor for Creating an Invoice.";
                        return;
                    }
                }
                strVehicleRequestIds += hVehicleRequestId.Value.ToString() + ", ";
            }
        }
        if(strVendorId == "")
        {
            lblError.Text = "Select a single Vendor for Creating an Invoice.";
            return; 
        }
        Context.Items.Add("VendorId", strVendorId);
        Context.Items.Add("FromDate", Txt_FromDate.Text);
        Context.Items.Add("ToDate", Txt_ToDate.Text);
        Context.Items.Add("VehicleRequestIds", strVehicleRequestIds.Substring(0, strVehicleRequestIds.Length - 2)); 

        Server.Transfer("VendorInvoice.aspx");
    }
    public void GetBranchList()
    {
        cmbBranch.DataSource = (new CommFunctions()).GetBranch();
        cmbBranch.DataTextField = "branchName";
        cmbBranch.DataValueField = "branchId";
        cmbBranch.DataBind();
        ListItem listItem = new ListItem("SELECT", "");
        cmbBranch.Items.Insert(0, listItem);
    }
} 