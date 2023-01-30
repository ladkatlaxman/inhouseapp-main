using BLFunctions;
using System;
using System.Data; 
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DashDetails : System.Web.UI.Page
{
    string strType = ""; 
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Web.UI.HtmlControls.HtmlGenericControl menu = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("NavBar");
        menu.Visible = false;
        menu.Attributes.Add("height", "0px"); 

        string strReport = "", branchID = "", sType = ""; 
        try
        {
            if (Request["T"] != null)
            {
                strReport = Request["T"]; 
            }
            if (Request["B"] != null)
            {
                branchID = Request["B"]; 
                string branchName = (new BranchFunctions()).GetBranchNameFromId(branchID);
                if (branchName == "") branchName = "All";
                lblBranchName.Text = "Branch : " + branchName; 
            }
            if (Request["S"] != null)
            {
                sType = Request["S"];
            }
        }
        catch { } 
        if(strReport == "PD")
        {
            lblReportName.Text = "Pending Deliveries";
            DataTableCollection dt = (new DashBoard()).DashBoardPendingDeliveryDetailsTable(branchID, sType);
            gvFirstGrid.DataSource = dt[0]; 
            gvFirstGrid.DataBind();

            try
            {
                if (dt[1] != null)
                {
                    gvSecondGrid.DataSource = dt[1];
                    gvSecondGrid.DataBind();
                }
            }
            catch { }
            try
            {
                if (dt[2] != null)
                {
                    gvThirdGrid.DataSource = dt[2];
                    gvThirdGrid.DataBind();
                }
            }
            catch { }
        }
        if (strReport == "PT")
        {
            lblReportName.Text = "Pending Transhipments";
            gvFirstGrid.DataSource = (new DashBoard()).DashBoardPendingTranshipmentDetails(branchID);
            gvFirstGrid.DataBind();
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        string strReport = "", branchID = "";
        strReport = lblReportName.Text;
        branchID = lblBranchName.Text;

        string CurrentDateTime = new CFunctions().CurrentDateTime();
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = lblReportName.Text + "_" + lblBranchName.Text + "_" + CurrentDateTime + ".xls";
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