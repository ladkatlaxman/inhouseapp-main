using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 

public partial class CustomerWayBillList : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";

        fromfinalDate = @"01/" + DateTime.Now.AddMonths(-1).ToString("MM") + @"/" + DateTime.Now.AddMonths(-1).ToString("yyyy");
        tofinalDate = DateTime.Now.AddDays(-1 * DateTime.Now.Day).ToString("dd") + @"/" + DateTime.Now.AddMonths(-1).ToString("MM") + @"/" + DateTime.Now.AddMonths(-1).ToString("yyyy"); 
	if(Session["userID"].ToString() == "188") tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
        if (!IsPostBack)
        {
        }
        else
        {
            if (Txt_FromDate.Text.ToString().Trim() != "")  fromfinalDate = Txt_FromDate.Text.ToString();
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
        //gvFirstGrid.DataSource = (new Invoicing()).ViewInvoiceList(Txt_FromDate.Text, Txt_ToDate.Text);
        gvFirstGrid.DataBind(); 
    }

    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false; 

        if (Txt_FromDate.Text != "") fromfinalDate = Txt_FromDate.Text;
        if (Txt_ToDate.Text != "") tofinalDate = Txt_ToDate.Text;

        HyperLink hLInkName = new HyperLink(), hMISlink = new HyperLink();
        //hLInkName.NavigateUrl = "CustomerInvoice.aspx?CustomerId=" + e.Row.Cells[0].Text.ToString() + "&BranchId=" + e.Row.Cells[1].Text.ToString() + "&FromDate=" + Txt_FromDate.Text + "&ToDate=" + Txt_ToDate.Text;
	    hLInkName.NavigateUrl = "CustomerInvoice.aspx?CustomerId=" + e.Row.Cells[0].Text.ToString() + "&BranchId=" + e.Row.Cells[1].Text.ToString() + "&FromDate=" + fromfinalDate + "&ToDate=" + tofinalDate; 
        hLInkName.Text = "Create Invoice"; //e.Row.Cells[4].Text.ToString();
	    hLInkName.Target = "_blank";
	    hMISlink.Target = "_blank";
        hMISlink.NavigateUrl = "WayBillMIS.aspx?CustomerId=" + e.Row.Cells[0].Text.ToString() + "&BranchId=" + e.Row.Cells[1].Text.ToString() + "&FromDate=" + Txt_FromDate.Text; //+ "&ToDate=" + Txt_ToDate.Text;
        hMISlink.Text = "MIS Report"; 
        //e.Row.Cells[4].Text = "";
        //e.Row.Cells[4].Controls.Add(hLInkName);

        TableCell tcLink = new TableCell(), tcMISLink = new TableCell();
        if(Session["userID"].ToString() != "188") tcLink.Controls.Add(hLInkName);tcLink.Controls.Add(hLInkName); 
	    tcMISLink.Controls.Add(hMISlink); 
        e.Row.Cells.Add(tcLink); 
	    e.Row.Cells.Add(tcMISLink);
    }
}