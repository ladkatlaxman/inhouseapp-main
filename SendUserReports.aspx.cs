using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Input;
using System.Windows.Markup.Localizer;
using NameSpaceConnection; 
public partial class SendUserReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return; 
        DataTable dt = GetUserReports();

        String DailyReportId = "", EmailId = "", ReportName= "", duration = "";
        int starting = 0, ending = 0;
        string startDate = "", endingdate = ""; 

        foreach (DataRow row in dt.Rows)
        {
            EmailId = row["EmailId"].ToString();
            ReportName = row["ReportName"].ToString();
            duration = row["Duration"].ToString();
            DailyReportId = row["DailySalesReportId"].ToString();

            if (duration == "DAYS")
            {
                starting = Convert.ToInt32(row["Starting"].ToString()); 
                ending= Convert.ToInt32(row["Ending"].ToString());
                startDate = DateTime.Now.AddDays(starting).ToString(@"dd/MM/yyyy").Replace("-",@"/");
                endingdate = DateTime.Now.AddDays(ending).ToString(@"dd/MM/yyyy").Replace("-", @"/");
            }
            DataTable dataTable = new DataTable();
            if (ReportName == "DAILY")
            {
                bool blPop = false; string branchId = ""; 
                DataTable dtBranches = GetDataTable(DailyReportId);
                foreach (DataRow dtBranchesRow in dtBranches.Rows)
                {
                    branchId = dtBranchesRow["BranchId"].ToString(); 
                    //Create the Report 
                    if (!blPop)
                    {
                        dataTable = ViewWayBillBookingReport(branchId, startDate, endingdate);
                        blPop = true;
                    }
                    else
                    {
                        dataTable.Merge(ViewWayBillBookingReport(branchId, startDate, endingdate));
                    }
                }
            }
            gvUserGrid.DataSource = dataTable;
            gvUserGrid.DataBind();
            ExportGridView();
            (new SendMail()).MailExecuteNew("File Export", EmailId, Server.MapPath("Excel") + @"UserFile.xls", "Daily Mail File"); 
        }
    }
    public DataTable GetDataTable(string DailySalesReportId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@DailySalesReportId", DailySalesReportId));
        DataTable dt = (new Connection()).Fillsp("ssp_GetDailySalesReportBranches", paramList);
        return dt;
    }

    public DataTable GetUserReports()
    {
        List<Parameters> paramList = new List<Parameters>();
        DataTable dt = (new Connection()).Fillsp("ssp_GetUserReports", paramList);
        return dt;
    }
    private void ExportGridView()
    {
        System.IO.StringWriter sw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);

        // Render grid view control.
        gvUserGrid.RenderControl(htw);

        // Write the rendered content to a file.
        string renderedGridView = sw.ToString();
        System.IO.File.WriteAllText(Server.MapPath("Excel") + @"UserFile.xls", renderedGridView);
    }
    private void CreateReport()
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "UserReport.xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);

        gvUserGrid.GridLines = GridLines.Both;
        gvUserGrid.HeaderStyle.Font.Bold = true;
        gvUserGrid.RenderControl(htmltextwrtter);

        Response.Write(strwritter.ToString());
        Response.End();
    }
    public DataTable ViewWayBillBookingReport(string BranchId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchID", BranchId));
        paramList.Add(new Parameters("@fromDate", fromDate));
        paramList.Add(new Parameters("@toDate", toDate));
        DataTable dt = (new Connection()).Fillsp("ssp_ReportWayBillsBookingReport", paramList);
        return dt;
    }
    public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
}
