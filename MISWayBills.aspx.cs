using System;
using System.Collections.Generic;
using System.Data; 
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;

public partial class MISWayBills : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";

        fromfinalDate = @"01/" + DateTime.Now.AddMonths(-1).ToString("MM") + @"/" + DateTime.Now.AddMonths(-1).ToString("yyyy");
        tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
        if (!IsPostBack)
        {
        }
        else
        {
            if (Txt_FromDate.Text.ToString().Trim() != "") fromfinalDate = Txt_FromDate.Text.ToString();
            if (Txt_ToDate.Text.ToString().Trim() != "") tofinalDate = Txt_ToDate.Text.ToString();
        }
        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
              "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');});";
        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        Btn_Search_Click(sender, e);
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (Txt_FromDate.Text != "") fromfinalDate = Txt_FromDate.Text;
        if (Txt_ToDate.Text != "") tofinalDate = Txt_ToDate.Text;
        gvFirstGrid.DataSource = (new Invoicing()).ViewInvoiceList(fromfinalDate, tofinalDate);
        gvFirstGrid.DataBind();
    }

    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;

        HyperLink hMISlink = new HyperLink();
        hMISlink.Target = "_blank";
        hMISlink.NavigateUrl = "WayBillMIS.aspx?CustomerId=" + e.Row.Cells[0].Text.ToString() + "&BranchId=" + e.Row.Cells[1].Text.ToString() + "&FromDate=" + fromfinalDate; //+ "&ToDate=" + Txt_ToDate.Text; 
        hMISlink.Text = "MIS Report";
        TableCell tcMISLink = new TableCell();
        tcMISLink.Controls.Add(hMISlink);
        e.Row.Cells.Add(tcMISLink);
    }
    protected void btn_ExportAll_Click(object sender, EventArgs e)
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
        string strStartDate = Txt_FromDate.Text, strEndDate = Txt_ToDate.Text;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);

        DataTable dt = (new BLFunctions.CommFunctions()).ViewMISdt(strStartDate, strEndDate, "", "");
        string tab = "";
        foreach (DataColumn dc in dt.Columns)
        {
            Response.Write(tab + dc.ColumnName);
            tab = "\t";
        }
        Response.Write("\n");
        int i;
        foreach (DataRow dr in dt.Rows)
        {
            tab = "";
            for (i = 0; i < dt.Columns.Count; i++)
            {
                Response.Write(tab + dr[i].ToString());
                tab = "\t";
            }
            Response.Write("\n");
        }

        Response.Write(strwritter.ToString());
        Response.End();
    }
}