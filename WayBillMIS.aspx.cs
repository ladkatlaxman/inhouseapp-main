using System;
using System.Collections.Generic;
using System.Data; 
using System.IO; 
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/*using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;*/
using BLProperties;
using BLFunctions;

public partial class WayBillMIS : System.Web.UI.Page
{
    string fromfinalDate = "", tofinalDate = "", str;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchCustName", "hfSearchCustName", "ReportData.aspx/getCustomerName", "GetData", "});");
            if (!IsPostBack)
            {
                fromfinalDate = "01" + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
                tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
            }
            else
            {
                if (Txt_FromDate.Text.ToString().Trim() == "") fromfinalDate = "new Date()"; else fromfinalDate = Txt_FromDate.Text.ToString();
                if (Txt_ToDate.Text.ToString().Trim() == "") tofinalDate = "new Date()"; else tofinalDate = Txt_ToDate.Text.ToString();
            }
            try
            { 
                if(Request["CustomerId"].ToString() != "") 
                { 
                    hfSearchCustName.Value = Request["CustomerId"].ToString(); 
                    hfBranchId.Value = Request["BranchId"].ToString(); 
                    CustomerHeader custHead = (new PartyCustomerFunctions()).getCustomerDetails(hfSearchCustName.Value, hfBranchId.Value); 
                    Txt_SearchCustName.Text = custHead.Name; 
                    txtBranchName.Text = custHead.BranchName; 
                    //hfBranchAddress.Value = custHead.BranchAddress; 
                    //hfCustomerAddress.Value = custHead.BillingAddress; 
                    fromfinalDate = Request["FromDate"].ToString(); 
                    //Txt_FromDate.Text = fromfinalDate; 
                    //tofinalDate = Request["ToDate"].ToString(); 
                    //Txt_ToDate.Text = tofinalDate; 
                    Btn_Search_Click(sender, null); 
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message; 
            }
            str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
                  "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');";
            (new CFunctions()).GetJavascriptFunction(this, "txtBranchName", "hfBranchId", "RouteMaster.aspx/GetBranch", "GetData", "});});");
            CFunctions.setjavascript(CFunctions.javascript + str);
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        string strStartDate = Txt_FromDate.Text, strEndDate = Txt_ToDate.Text;
        System.Data.IDataReader dr = (new BLFunctions.CommFunctions()).ViewMIS(strStartDate, strEndDate, hfSearchCustName.Value.ToString(), hfBranchId.Value.ToString()); 
        gvFirstGrid.DataSource = dr; 
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
    public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
    {
        /* Verifies that the control is rendered */
    }

}