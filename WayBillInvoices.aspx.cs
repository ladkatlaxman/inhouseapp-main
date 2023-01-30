using System;
using System.Collections.Generic;
using System.Data; 
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class WayBillInvoices : System.Web.UI.Page
{
    string fromfinalDate = "", tofinalDate = "", str;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fromfinalDate = DateTime.Now.AddDays(-1).ToString("dd") + @"/" + DateTime.Now.AddDays(-1).ToString("MM") + @"/" + DateTime.Now.AddDays(-1).ToString("yyyy");
            tofinalDate   = DateTime.Now.AddDays(-1).ToString("dd") + @"/" + DateTime.Now.AddDays(-1).ToString("MM") + @"/" + DateTime.Now.AddDays(-1).ToString("yyyy");
        }
        else
        {
            if (Txt_FromDate.Text.ToString().Trim() == "") fromfinalDate = "new Date()"; else fromfinalDate = Txt_FromDate.Text.ToString();
            if (Txt_ToDate.Text.ToString().Trim() == "") tofinalDate = "new Date()"; else tofinalDate = Txt_ToDate.Text.ToString();
        }
        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
              "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');});";

        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        string strStartDate = Txt_FromDate.Text, strEndDate = Txt_ToDate.Text;
        IDataReader dr = (new BLFunctions.CommFunctions()).ViewInvoiceWayBillsReport(strStartDate, strEndDate);
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
}