using System;
using System.Data; 
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
using BLFunctions;

public partial class WayBillInvoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";
        if (!IsPostBack)
        {
            str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", new Date());" + "\n" +
                "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", new Date());});";
            CFunctions.setjavascript(CFunctions.javascript + str);
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
            cmbCustomers.DataValueField = "CustomerId";
            cmbCustomers.DataTextField = "CustomerName";
            cmbCustomers.DataSource = (new CommFunctions()).ViewCustomerList(Convert.ToInt32(Session["branchID"].ToString()));
            cmbCustomers.DataBind();
        }
    }
    protected void GV_CustomerList_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {

    }

    protected void btnShowInvoice_Click(object sender, EventArgs e)
    {
        DataTable dt;
        dt = (new CommFunctions()).ViewWayBillInvoices(cmbCustomers.SelectedValue.ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
        gvInvoiceGrid.DataSource = dt;
        gvInvoiceGrid.DataBind();
        /*IDataReader iDR = (new CommFunctions()).drViewWayBillInvoices(cmbCustomers.SelectedValue.ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
        gvInvoiceGrid.DataSource = iDR;
        gvInvoiceGrid.DataBind();*/
    }

    protected void btnCreateInvoice_Click(object sender, EventArgs e)
    {

    }
}