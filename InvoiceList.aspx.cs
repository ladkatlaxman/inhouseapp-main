using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InvoiceList : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";
        fromfinalDate = @"01/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
        tofinalDate = DateTime.Now.AddDays(-1 * DateTime.Now.Day).ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");

        if (!IsPostBack)
        {
        }
        else
        {
            if (Txt_FromDate.Text.ToString().Trim() != "") fromfinalDate = Txt_FromDate.Text.ToString();
            if (Txt_ToDate.Text.ToString().Trim() != "") tofinalDate = Txt_ToDate.Text.ToString();
        }
        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
              "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');})";
        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);

        //gvFirstGrid.DataSource = (new BLFunctions.CommFunctions()).ViewInvoiceList("", Txt_FromDate.Text, Txt_ToDate.Text);
        /*gvFirstGrid.DataSource = (new BLFunctions.CommFunctions()).ViewInvoiceList("", fromfinalDate, tofinalDate);
        gvFirstGrid.DataBind();*/
        Btn_Search_Click(sender, e); 
    }

    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string strLink = ""; 
        e.Row.Cells[1].Visible = false;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //strLink = "CustomerInvoice.aspx?InvoiceId=" + e.Row.Cells[1].Text.ToString() + "&CustomerId=" + e.Row.Cells[16].Text.ToString() + "&BranchId=" + e.Row.Cells[17].Text.ToString(); 
            strLink = "CustomerInvoice.aspx?InvoiceId=" + e.Row.Cells[1].Text.ToString(); // + "&CustomerId=" + e.Row.Cells[16].Text.ToString() + "&BranchId=" + e.Row.Cells[17].Text.ToString();
            HyperLink hLInk = new HyperLink();
            hLInk.NavigateUrl = strLink; // "CustomerInvoice.aspx?InvoiceId=" + e.Row.Cells[1].Text.ToString();
            hLInk.Text = e.Row.Cells[0].Text.ToString() + ":";
            e.Row.Cells[0].Text = "";
            e.Row.Cells[0].Controls.Add(hLInk);

            HyperLink hLInkName = new HyperLink();
            hLInkName.NavigateUrl = strLink; //"CustomerInvoice.aspx?InvoiceId=" + e.Row.Cells[1].Text.ToString();
            hLInkName.Text = e.Row.Cells[3].Text.ToString();
            e.Row.Cells[3].Text = "";
            e.Row.Cells[3].Controls.Add(hLInkName);
        }
		for (int iColNo = 12; iColNo <= e.Row.Cells.Count; iColNo++)
        {
            e.Row.Cells[iColNo - 1].Visible = false;
        }
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        gvFirstGrid.DataSource = (new BLFunctions.CommFunctions()).ViewInvoiceList("", fromfinalDate, tofinalDate);
        gvFirstGrid.DataBind();
    }
}