using BLFunctions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillGrid();
        }
    }
    public void fillGrid()
    {
        string strGetType = Request["Type"].ToString();
        DataTable dt;
        switch (strGetType)
        {
            case "Customer":
                HeaderName.InnerText = "CONSIGNOR LIST";
                dt = (new CommFunctions()).ViewCustomerList(Convert.ToInt32(Session["branchID"].ToString()));
                GV_CustomerList.DataSource = dt;
                GV_CustomerList.DataBind();
                break;
            case "Consignor":
                HeaderName.InnerText = "WALKIN CONSIGNOR LIST";
                dt = (new CommFunctions()).ViewWalkinCustomerList(Convert.ToInt32(Session["branchID"].ToString()));
                GV_CustomerList.DataSource = dt;
                GV_CustomerList.DataBind();
                break;
            case "Consignee":
                HeaderName.InnerText = "CONSIGNEE LIST";
                dt = (new CommFunctions()).ViewConsigneeList(Convert.ToInt32(Session["branchID"].ToString()));
                GV_CustomerList.DataSource = dt;
                GV_CustomerList.DataBind();
                break;
            case "BillingParty":
                HeaderName.InnerText = "BILLING PARTY LIST";
                dt = (new CommFunctions()).ViewBillingParty();
                GV_CustomerList.DataSource = dt;
                GV_CustomerList.DataBind();
                break;
            default:
                break;
        }
    }
}