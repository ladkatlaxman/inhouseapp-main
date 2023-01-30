using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class OPERATIONS_PackageMaster : System.Web.UI.Page
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
                Txt_TypeOfPackage.Focus();

                //CurrentDateTime();
                DatafillForPackageViewDetails();
                Search_PackageDetails_View.Visible = false;
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
        SqlDataAdapter sqlda = new SqlDataAdapter("spViewPackageDetails", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        if (sortExpression != null)
        {
            DataView dv = dtbl.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            gridViewPackage.DataSource = dv;
            GV_Export.DataSource = dv;
        }
        else
        {
            gridViewPackage.DataSource = dtbl;
            GV_Export.DataSource = dtbl;
        }
        gridViewPackage.DataBind();
        GV_Export.DataBind();
        con.Close();
    }

    protected void Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    void clear()
    {
        // CurrentDateTime();
        hfpackageID.Value = "";
        Txt_TypeOfPackage.Text = "";
        Search_PackageDetails_View.Visible = false;
        Txt_TypeOfPackage.Focus();
        Txt_SearchTypeOFPackage.Text = "SELECT";
        Txt_SearchTypeOFPackage_Search.Text = "";
        Button_Submit1.Text = "SUBMIT <i class='fa fa-save'></i>";
    }

    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = cmf.CurrentDateTime();
        con.Open();

        SqlCommand cmd = new SqlCommand("spCreateOrUpdatePackage", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@bool", CFunctions.tabstatus);
        cmd.Parameters.AddWithValue("@packID", (hfpackageID.Value == "" ? 0 : Convert.ToInt32(hfpackageID.Value)));
        cmd.Parameters.AddWithValue("@typeOfPackage", Txt_TypeOfPackage.Text.Trim().ToString().ToUpper());
        cmd.Parameters.AddWithValue("@employeeNo", Session["employeeNo"].ToString());
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

    protected void editBranchDetails_Click(object sender, EventArgs e)
    {
        int packID = Convert.ToInt32((sender as LinkButton).CommandArgument);

        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spEditPackage", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@packID", packID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        con.Close();

        hfpackageID.Value = packID.ToString();
        Txt_TypeOfPackage.Text = dtbl.Rows[0]["typeOfPackage"].ToString();
        CFunctions.setTabStatus(1);

        Reset.Enabled = false;
        Reset.Style.Add("opacity", "0.3");
        Button_Submit1.Text = "UPDATE <i class='fa fa-save'></i>";
    }
    protected void Delete_Data1_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        //getting particular row linkbutton
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;

        int packid = Convert.ToInt32(gridViewPackage.DataKeys[gvrow.RowIndex].Value.ToString());
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Update tblPackage set setDelete='TRUE' where packID=" + packid, con);
            cmd.ExecuteNonQuery();
            DatafillForPackageViewDetails();
            con.Close();

            string a = "Delete_Data1";
            string b = "DELETE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
        displayDataInGridView();
    }
    public void DatafillForPackageViewDetails()
    {
        SqlCommand cmd_pack = new SqlCommand("Select typeOfPackage from tblPackage where setDelete='FALSE'", con);
        con.Open();
        RadioButtonList_SearchTypeOFPackage.DataSource = cmd_pack.ExecuteReader();
        RadioButtonList_SearchTypeOFPackage.DataTextField = "typeOfPackage";
        RadioButtonList_SearchTypeOFPackage.DataBind();
        RadioButtonList_SearchTypeOFPackage.Items.Insert(0, "SELECT");
        foreach (ListItem listofpckage in RadioButtonList_SearchTypeOFPackage.Items)
        {
            listofpckage.Text = listofpckage.Text.ToUpper();
        }
        RadioButtonList_SearchTypeOFPackage.SelectedIndex = 0;
        Txt_SearchTypeOFPackage.Text = "SELECT";
        Txt_SearchTypeOFPackage_Search.Text = "";
        con.Close();
    }
    protected void Txt_SearchTypeOFPackage_Search_TextChanged(object sender, EventArgs e)
    {
        if (Txt_SearchTypeOFPackage_Search.Text != "")
        {
            string search = Txt_SearchTypeOFPackage_Search.Text;
            string searchTxt = "SELECT distinct typeOfPackage FROM tblPackage WHERE typeOfPackage LIKE '%" + search + "%' AND setDelete='FALSE'";

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
            sqlda.SelectCommand.CommandType = CommandType.Text;
            DataTable dt = new DataTable();
            sqlda.Fill(dt);

            RadioButtonList_SearchTypeOFPackage.DataSource = dt;
            RadioButtonList_SearchTypeOFPackage.DataTextField = "typeOfPackage";
            RadioButtonList_SearchTypeOFPackage.DataValueField = "typeOfPackage";
            RadioButtonList_SearchTypeOFPackage.DataBind();
            RadioButtonList_SearchTypeOFPackage.Items.Insert(0, "SELECT");
            foreach (ListItem listofitem in RadioButtonList_SearchTypeOFPackage.Items)
            {
                listofitem.Text = listofitem.Text.ToUpper();
            }
            Txt_SearchTypeOFPackage_Search.Focus();
            con.Close();

            for (int i = 0; i < RadioButtonList_SearchTypeOFPackage.Items.Count; i++)
            {
                if (Txt_SearchTypeOFPackage.Text == RadioButtonList_SearchTypeOFPackage.Items[i].Text)
                {
                    RadioButtonList_SearchTypeOFPackage.Items[i].Selected = true;
                    break;
                }
            }

            if (Txt_SearchTypeOFPackage.Text == "")
            {
                RadioButtonList_SearchTypeOFPackage.SelectedIndex = 0;
            }

        }

        else if (Txt_SearchTypeOFPackage_Search.Text == "")
        {

            string searchTxt = "SELECT distinct typeOfPackage FROM tblPackage WHERE setDelete='FALSE'";

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
            sqlda.SelectCommand.CommandType = CommandType.Text;
            DataTable dt = new DataTable();
            sqlda.Fill(dt);
            RadioButtonList_SearchTypeOFPackage.DataSource = dt;
            RadioButtonList_SearchTypeOFPackage.DataTextField = "typeOfPackage";
            RadioButtonList_SearchTypeOFPackage.DataValueField = "typeOfPackage";
            RadioButtonList_SearchTypeOFPackage.DataBind();
            RadioButtonList_SearchTypeOFPackage.Items.Insert(0, "SELECT");
            foreach (ListItem listofitem in RadioButtonList_SearchTypeOFPackage.Items)
            {
                listofitem.Text = listofitem.Text.ToUpper();
            }
            Txt_SearchTypeOFPackage_Search.Focus();
            con.Close();

            for (int i = 0; i < RadioButtonList_SearchTypeOFPackage.Items.Count; i++)
            {
                if (Txt_SearchTypeOFPackage.Text == RadioButtonList_SearchTypeOFPackage.Items[i].Text)
                {
                    RadioButtonList_SearchTypeOFPackage.Items[i].Selected = true;
                    break;
                }
            }

            if (Txt_SearchTypeOFPackage.Text == "")
            {
                RadioButtonList_SearchTypeOFPackage.SelectedIndex = 0;
            }

        }
    }
    protected void RadioButtonList_SearchTypeOFPackage_SelectedIndexChanged(object sender, EventArgs e)
    {
        for (int i = 0; i < RadioButtonList_SearchTypeOFPackage.Items.Count; i++)
        {
            if (RadioButtonList_SearchTypeOFPackage.Items[i].Selected)
            {
                Txt_SearchTypeOFPackage.Text = RadioButtonList_SearchTypeOFPackage.Items[i].Text;
                if (Txt_SearchTypeOFPackage.Text.ToString() == "SELECT")
                {
                    Txt_SearchTypeOFPackage.Focus();
                }
                else
                {
                    Btn_Search.Focus();
                }
            }

        }

        PopupControlExtender_SearchTypeOFPackage.Commit(RadioButtonList_SearchTypeOFPackage.SelectedValue);
    }
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        Search_PackageDetails_View.Visible = true;
        searchMaterial();
    }
    public void searchMaterial()
    {
        String packName = Txt_SearchTypeOFPackage.Text.ToString().Trim();

        if ((Txt_SearchTypeOFPackage.Text.ToString() != "SELECT"))
        {
            string str = "Select * from tblPackage where (setDelete='FALSE') AND (typeOfPackage like '%" + packName + "%')";
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter();

            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            gridViewPackage.DataSource = ds;
            gridViewPackage.DataBind();
            GV_Export.DataSource = ds;
            GV_Export.DataBind();
            con.Close();
        }
        else
        {
            displayDataInGridView();
        }

    }

    protected void gridViewPackage_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewPackage.PageIndex = e.NewPageIndex;
        searchMaterial();
    }

    protected void gridViewPackage_Sorting(object sender, GridViewSortEventArgs e)
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
        string FileName = "Package_Creation" + CurrentDateTime + ".xls";
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