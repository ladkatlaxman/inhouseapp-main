using BLFunctions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VendorTrips : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";

        fromfinalDate = @"01/" + DateTime.Now.AddMonths(-1).ToString("MM") + @"/" + DateTime.Now.AddMonths(-1).ToString("yyyy");
        tofinalDate = DateTime.Now.AddDays(-1 * DateTime.Now.Day).ToString("dd") + @"/" + DateTime.Now.AddMonths(-1).ToString("MM") + @"/" + DateTime.Now.AddMonths(-1).ToString("yyyy");
        //if (Session["userID"].ToString() == "188") tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
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
        gvFirstGrid.DataSource = (new clsVendorInvoice()).ViewTrips(fromfinalDate, tofinalDate);
        gvFirstGrid.DataBind();
    }
    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        HyperLink hLInkName = new HyperLink();
        hLInkName.NavigateUrl = "VendorBill.aspx?vendorId=" + e.Row.Cells[0].Text.ToString() + "&FromDate=" + fromfinalDate + "&ToDate=" + tofinalDate;
        hLInkName.Text = "Create Invoice"; //e.Row.Cells[4].Text.ToString();
        hLInkName.Target = "_blank";
        TableCell tcLink = new TableCell();
        tcLink.Controls.Add(hLInkName); 
        e.Row.Cells.Add(tcLink);
        e.Row.Cells[0].Visible = false; 
    }
}