using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
public partial class VehicleExpenses : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";

        //fromfinalDate = DateTime.Now.AddDays(-7).ToString("dd") + @"/" + DateTime.Now.AddDays(-7).ToString("MM") + @"/" + DateTime.Now.AddDays(-7).ToString("yyyy"); 
        fromfinalDate = @"01/" + DateTime.Now.AddDays(-7).ToString("MM") + @"/" + DateTime.Now.AddDays(-7).ToString("yyyy"); 
        tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy"); 
        if (!IsPostBack) 
        {
            (new CFunctions()).dropdwnlist(null, null, cmbBranchList, null, "branchName", "branchId", (new CommFunctions().GetBranch()));
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
        if (!IsPostBack) Btn_Search_Click(sender, e); 
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        DataTable dt = null;
        if (cmbBranchList.SelectedIndex == 0)
            //dt = (new ReportFunctions()).ViewVehiclesRequests(0, fromfinalDate, tofinalDate);
            dt = (new VehicleRequestFunction()).ViewVehicleMovementsNew("", "", fromfinalDate, tofinalDate, ddlRouteType.SelectedValue.ToString(), ddlVehicleType.SelectedValue.ToString(), txtVehicleNo.Text);
        else
            //dt = (new ReportFunctions()).ViewVehiclesRequests(Convert.ToInt32(cmbBranchList.SelectedValue.ToString()), fromfinalDate, tofinalDate);
            dt = (new VehicleRequestFunction()).ViewVehicleMovementsNew("", cmbBranchList.SelectedValue.ToString(), fromfinalDate, tofinalDate, ddlRouteType.SelectedValue.ToString(), ddlVehicleType.SelectedValue.ToString(), txtVehicleNo.Text);
        gvFirstGrid.DataSource = dt; 
        gvFirstGrid.DataBind(); 
    }


    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        HyperLink hLInkName = new HyperLink(); 
        hLInkName = (HyperLink)e.Row.FindControl("lnkBtnEdit"); 
        if (hLInkName != null) 
        {
            hLInkName.NavigateUrl ="RouteExpense.aspx?V=" + DataBinder.Eval(e.Row.DataItem, "VehicleRequestId").ToString(); 
            //hLInkName.Text = "Edit";
        }
    }
}