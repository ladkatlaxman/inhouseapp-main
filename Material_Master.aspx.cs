using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class OPERATIONS_ItemMaster : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    CFunctions cmf = new CFunctions();
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    string strcmd = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                Txt_MaterialName.Focus();
                DatafillForMaterialViewDetails();
                Search_MaterialDetails_View.Visible = false;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }


        }

    }
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    public void displayDataInGridView(string sortExpression = null)
    {
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spViewMaterialDetails", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        if (sortExpression != null)
        {
            DataView dv = dtbl.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            gridViewMaterial.DataSource = dv;
            GV_Export.DataSource = dv;
        }
        else
        {
            gridViewMaterial.DataSource = dtbl;
            GV_Export.DataSource = dtbl;
        }

        gridViewMaterial.DataBind();
        GV_Export.DataBind();
        con.Close();
    }
    protected void Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    void clear()
    {
        //CurrentDateTime();
        hfmaterialID.Value = "";
        Txt_MaterialName.Text = "";
        Search_MaterialDetails_View.Visible = false;
        Txt_MaterialName.Focus();
        Txt_SearchItemName.Text = "SELECT";
        Txt_SearchItemName_Search.Text = "";
        Button_Submit1.Text = "SUBMIT <i class='fa fa-save'></i>";

    }

    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = cmf.CurrentDateTime();
        con.Open();

        SqlCommand cmd = new SqlCommand("spCreateOrUpdateMaterial", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@bool", CFunctions.tabstatus);
        cmd.Parameters.AddWithValue("@materialID", (hfmaterialID.Value == "" ? 0 : Convert.ToInt32(hfmaterialID.Value)));
        cmd.Parameters.AddWithValue("@materialName", Txt_MaterialName.Text.Trim().ToString().ToUpper());
        cmd.Parameters.AddWithValue("@employeeNo", Session["userId"].ToString());
        cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
        cmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime);
        cmd.Parameters.AddWithValue("@userBranch", Session["userBranch"].ToString());
        cmd.ExecuteNonQuery();
        CFunctions.setTabStatus(0);
        con.Close();
        string a = "Button_Submit1";
        string b = "SAVE";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

        clear();

        displayDataInGridView();

    }
    public void DatafillForMaterialViewDetails()
    {
        SqlCommand cmd_bname = new SqlCommand("Select materialName from tblMaterial", con);
        con.Open();
        RadioButtonList_SearchItemName.DataSource = cmd_bname.ExecuteReader();
        RadioButtonList_SearchItemName.DataTextField = "materialName";
        RadioButtonList_SearchItemName.DataBind();
        RadioButtonList_SearchItemName.Items.Insert(0, "SELECT");
        foreach (ListItem listofitem in RadioButtonList_SearchItemName.Items)
        {
            listofitem.Text = listofitem.Text.ToUpper();
        }
        RadioButtonList_SearchItemName.SelectedIndex = 0;
        Txt_SearchItemName.Text = "SELECT";
        Txt_SearchItemName_Search.Text = "";
        con.Close();

        //string a = "Button_Submit1";
        //string b = "UPDATE";
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

    }
    protected void Txt_SearchItemName_Search_TextChanged(object sender, EventArgs e)
    {
        if (Txt_SearchItemName_Search.Text != "")
        {
            string search = Txt_SearchItemName_Search.Text;
            string searchTxt = "SELECT materialName FROM tblMaterial WHERE materialName LIKE '%" + search + "%'";

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
            sqlda.SelectCommand.CommandType = CommandType.Text;
            DataTable dt = new DataTable();
            sqlda.Fill(dt);

            RadioButtonList_SearchItemName.DataSource = dt;
            RadioButtonList_SearchItemName.DataTextField = "materialName";
            RadioButtonList_SearchItemName.DataValueField = "materialName";
            RadioButtonList_SearchItemName.DataBind();
            RadioButtonList_SearchItemName.Items.Insert(0, "SELECT");
            foreach (ListItem listofitem in RadioButtonList_SearchItemName.Items)
            {
                listofitem.Text = listofitem.Text.ToUpper();
            }
            Txt_SearchItemName_Search.Focus();
            con.Close();


            for (int i = 0; i < RadioButtonList_SearchItemName.Items.Count; i++)
            {
                if (Txt_SearchItemName.Text == RadioButtonList_SearchItemName.Items[i].Text)
                {
                    RadioButtonList_SearchItemName.Items[i].Selected = true;
                    break;
                }
            }

            if (Txt_SearchItemName.Text == "")
            {
                RadioButtonList_SearchItemName.SelectedIndex = 0;
            }

        }

        else if (Txt_SearchItemName_Search.Text == "")
        {

            string searchTxt = "SELECT materialName FROM tblMaterial";

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
            sqlda.SelectCommand.CommandType = CommandType.Text;
            DataTable dt = new DataTable();
            sqlda.Fill(dt);
            RadioButtonList_SearchItemName.DataSource = dt;
            RadioButtonList_SearchItemName.DataTextField = "materialName";
            RadioButtonList_SearchItemName.DataValueField = "materialName";
            RadioButtonList_SearchItemName.DataBind();
            RadioButtonList_SearchItemName.Items.Insert(0, "SELECT");
            foreach (ListItem listofitem in RadioButtonList_SearchItemName.Items)
            {
                listofitem.Text = listofitem.Text.ToUpper();
            }
            Txt_SearchItemName_Search.Focus();
            con.Close();

            for (int i = 0; i < RadioButtonList_SearchItemName.Items.Count; i++)
            {
                if (Txt_SearchItemName.Text == RadioButtonList_SearchItemName.Items[i].Text)
                {
                    RadioButtonList_SearchItemName.Items[i].Selected = true;
                    break;
                }
            }

            if (Txt_SearchItemName.Text == "")
            {
                RadioButtonList_SearchItemName.SelectedIndex = 0;
            }

        }
    }

    protected void RadioButtonList_SearchItemName_SelectedIndexChanged(object sender, EventArgs e)
    {
        for (int i = 0; i < RadioButtonList_SearchItemName.Items.Count; i++)
        {
            if (RadioButtonList_SearchItemName.Items[i].Selected)
            {
                Txt_SearchItemName.Text = RadioButtonList_SearchItemName.Items[i].Text;
                if (Txt_SearchItemName.Text.ToString() == "SELECT")
                {
                    Txt_SearchItemName.Focus();
                }
                else
                {
                    Btn_Search.Focus();
                }

            }

        }


        PopupControlExtender_SearchItemName.Commit(RadioButtonList_SearchItemName.SelectedValue);
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        Search_MaterialDetails_View.Visible = true;
        searchMaterial();
    }
    public void searchMaterial()
    {
        String materialName = Txt_SearchItemName.Text.ToString().Trim();

        if ((Txt_SearchItemName.Text.ToString() != "SELECT"))
        {
            string str = "Select * from tblMaterial where materialName like '%" + materialName + "%'";
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter();

            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            gridViewMaterial.DataSource = ds;
            gridViewMaterial.DataBind();

            GV_Export.DataSource = ds;
            GV_Export.DataBind();
            con.Close();
        }
        else
        {
            displayDataInGridView();
        }

    }

    //protected void Delete_Data1_Click(object sender, EventArgs e)
    //{
    //    LinkButton lnkbtn = sender as LinkButton;
    //    //getting particular row linkbutton
    //    GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;

    //    int materialid = Convert.ToInt32(gridViewMaterial.DataKeys[gvrow.RowIndex].Value.ToString());
    //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString))
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("Update tblMaterial set setDelete='TRUE' where materialID=" + materialid, con);
    //        cmd.ExecuteNonQuery();
    //        DatafillForMaterialViewDetails();
    //        con.Close();

    //        string a = "Delete_Data1";
    //        string b = "DELETE";
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);


    //    }

    //    displayDataInGridView();

    //}

    //protected void editBranchDetails_Click(object sender, EventArgs e)
    //{
    //    int materialID = Convert.ToInt32((sender as LinkButton).CommandArgument);

    //    con.Open();
    //    SqlDataAdapter sqlda = new SqlDataAdapter("spEditMaterial", con);
    //    sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sqlda.SelectCommand.Parameters.AddWithValue("@materialID", materialID);
    //    DataTable dtbl = new DataTable();
    //    sqlda.Fill(dtbl);
    //    con.Close();

    //    hfmaterialID.Value = materialID.ToString();
    //    Txt_MaterialName.Text = dtbl.Rows[0]["materialName"].ToString();
    //    globalVar.setStatus(1);

    //    Reset.Enabled = false;
    //    Reset.Style.Add("opacity", "0.3");
    //    Button_Submit1.Text = "UPDATE <i class='fa fa-save'></i>";
    //}

    protected void gridViewMaterial_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewMaterial.PageIndex = e.NewPageIndex;
        searchMaterial();

    }

    protected void gridViewMaterial_Sorting(object sender, GridViewSortEventArgs e)
    {
        displayDataInGridView(e.SortExpression);
    }


    /* Export To Excel Start */
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btn_ExporttoExcel_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = cmf.CurrentDateTime();

        GV_Export.Visible = true;
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Material_Creation" + CurrentDateTime + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GV_Export.GridLines = GridLines.Both;
        GV_Export.HeaderStyle.Font.Bold = true;
        GV_Export.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();
        GV_Export.Visible = false;
    }
    /* Export To Excel End */




}
