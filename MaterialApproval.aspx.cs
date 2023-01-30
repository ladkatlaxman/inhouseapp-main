using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using System.Data;
using System.Linq;

public partial class MaterialApproval : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                (new CFunctions()).dropdwnlist(null, null, Ddl_Branch, null, "branchName", "branchId", ((new CommFunctions()).GetBranch()));             
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        //string str = "$(\"[id *=Txt_SearchFromDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
        //             "$(\"[id *=Txt_SearchToDate]\").datepicker({ dateFormat: 'dd/mm/yy',maxDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
        //             "});";

        //CFunctions.setjavascript(CFunctions.javascript + str);
        //(new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    public void FillGrid()
    {
        String Fromdate = Txt_SearchFromDate.Text.ToString().Trim();
        Fromdate = Fromdate == "" ? null : Txt_SearchFromDate.Text.ToString().Trim();
        String finalFromDate = null;
        if (Fromdate != null)
        {
            string[] dateFormat1 = Fromdate.Split('-');
            for (int i = dateFormat1.Count() - 1; i >= 0; i--)
            {
                if (i == 0) { finalFromDate += dateFormat1[i].ToString(); }
                else { finalFromDate += dateFormat1[i].ToString() + "/"; }
            }
        }
        String Todate = Txt_SearchToDate.Text.ToString().Trim();
        Todate = Todate == "" ? null : Txt_SearchToDate.Text.ToString().Trim();
        String finalToDate = null;
        if (Todate != null)
        {
            string[] dateFormat2 = Todate.Split('-');
            for (int i = dateFormat2.Count() - 1; i >= 0; i--)
            {
                if (i == 0) { finalToDate += dateFormat2[i].ToString(); }
                else { finalToDate += dateFormat2[i].ToString() + "/"; }
            }
        }
        if ((Fromdate != null) || (Todate != null))
        {
            string ID = Ddl_Branch.SelectedItem.ToString() == "SELECT" ? null : Ddl_Branch.SelectedValue.ToString();
            int statusId = Convert.ToInt32(Ddl_Status.SelectedValue);          
            GV_PurachaseMaterialDetailList.DataSource = (new CommFunctions()).SearchMaterialPurchaseDetails(finalFromDate, finalToDate, ID, statusId);
            GV_PurachaseMaterialDetailList.DataBind();                  
        }
        else
            (new CFunctions()).showalert("Btn_Search", "SEARCH", this);
    }
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        FillGrid();
    } 
    protected void Approved_Click(object sender, EventArgs e)
    {              
        int id = Convert.ToInt32(Convert.ToString((sender as LinkButton).CommandArgument));
        int alertMsg = (new CommFunctions()).SaveStatusOfApprovalMaterial(id, 2);
        if (alertMsg == 1)
           (new CFunctions()).showalert("Button_Tab1Save", "APPROVE", this);
        FillGrid();     
    }

    protected void Rejected_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(Convert.ToString((sender as LinkButton).CommandArgument));
        int alertMsg = (new CommFunctions()).SaveStatusOfApprovalMaterial(id, 3);
        if (alertMsg == 1)
            (new CFunctions()).showalert("Button_Tab1Save", "REJECT", this);
        FillGrid();
    }

    protected void GV_PurachaseMaterialDetailList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int statusId = Convert.ToInt32(Ddl_Status.SelectedValue);
        if (statusId == 1)
        {
            e.Row.Cells[0].Visible = true;
            e.Row.Cells[1].Visible = true;
        }
        else
        {
            e.Row.Cells[0].Visible = false;
            e.Row.Cells[1].Visible = false;
        }  
    }
}