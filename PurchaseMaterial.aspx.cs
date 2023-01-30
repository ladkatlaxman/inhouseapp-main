using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using System.Data;

public partial class PurchaseMaterial : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                (new CFunctions()).dropdwnlist(null, null, Ddl_Branch, null, "branchName", "branchId", ((new CommFunctions()).GetBranch()));
                (new CFunctions()).dropdwnlist(null, null, Ddl_Department, null, "Name", "Id", ((new CommFunctions()).getDepartmentName()));
                (new CFunctions()).dropdwnlist(null, null, Ddl_Material, null, "Name", "Id", ((new CommFunctions()).getMaterialName()));
            }
            else
            {
                Response.Redirect("Login.aspx");
            }         
        }
        string str = "$(\"[id *=Txt_ExpectedDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker();"+
                     "});";

        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("materialId", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("materialName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("qty", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("unit", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("expectedDate", typeof(String)));
       
        if (ViewState["CurrentData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["CurrentData"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = Ddl_Material.SelectedValue.ToString();
            dr[1] = Ddl_Material.SelectedItem.Text.ToString();
            dr[2] = Txt_Qty.Text.ToString().ToUpper();
            dr[3] = Ddl_UOM.SelectedItem.Text.ToString();
            dr[4] = Txt_ExpectedDate.Text.ToString();            
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = Ddl_Material.SelectedValue.ToString();
            dr[1] = Ddl_Material.SelectedItem.Text.ToString();
            dr[2] = Txt_Qty.Text.ToString().ToUpper();
            dr[3] = Ddl_UOM.SelectedItem.Text.ToString();
            dr[4] = Txt_ExpectedDate.Text.ToString();
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["CurrentData"] != null)
        {
            Add_DataTable_GridView.DataSource = (DataTable)ViewState["CurrentData"];
            Add_DataTable_GridView.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable
            Add_DataTable_GridView.DataSource = dt;
            Add_DataTable_GridView.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["CurrentData"] = dt;
    }
    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        if (ViewState["CurrentData"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentData"];
            int count = dt.Rows.Count;
            BindGrid(count);
        }
        else
        {
            BindGrid(1);
        }
        Ddl_Material.SelectedIndex = 0;
        Txt_Qty.Text = "";
        Ddl_UOM.SelectedIndex = 0;
        Txt_ExpectedDate.Text = "";
    }
    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        PurchaseMaterials headerDetail = new PurchaseMaterials();
        headerDetail.branchId = Convert.ToInt32(Ddl_Branch.SelectedValue);
        headerDetail.departmentId = Convert.ToInt32(Ddl_Department.SelectedValue);
        headerDetail.remark = Txt_Remark.Text.ToString().ToUpper();

        if (ViewState["CurrentData"] != null)
        {
            List<PurchaseMaterialDetails> List = new List<PurchaseMaterialDetails>();
            foreach (GridViewRow drRow in Add_DataTable_GridView.Rows)
            {
                PurchaseMaterialDetails materialDetail = new PurchaseMaterialDetails();
                materialDetail.materialId = Convert.ToInt32(drRow.Cells[1].Text);
                materialDetail.qty = Convert.ToInt32(drRow.Cells[3].Text);
                materialDetail.unit = drRow.Cells[4].Text;
                materialDetail.expectedDate = drRow.Cells[5].Text;
                List.Add(materialDetail);
            }
            headerDetail.MaterialDetail = List;

            bool reader = (new CommFunctions()).SavePurchaseMaterial(headerDetail);
            if (reader)
            {
                (new CFunctions()).showalert("Button_Submit1", "SAVE", this);
                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }  
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
}