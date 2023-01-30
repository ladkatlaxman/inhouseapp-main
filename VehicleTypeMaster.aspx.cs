using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using NameSpaceConnection;

public partial class VehicleTypeMaster : System.Web.UI.Page
{
    int val;
    String PkFieldId, result;
    /*- PkFieldId Store DatakeyValue of Gridview,
      - result store Code Alpha Value*/

    /*Create Object of Connecton and BindDropdownlist Class*/
    Connection con = new Connection();
    CFunctions cmf = new CFunctions();

    // BindDropdownlist bd = new BindDropdownlist();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                /*Auto Focus*/
                Txt_VehicleTypeName.Focus();

                /*Set Variable*/
                CFunctions.setTabStatus(0);

                SearchableView();

                /*Calling DropBindDropdownDoubleParameter using object of BindDropdownlist*/
                //cmf1.BindDataValueInListTripleParameter("", RadioButtonList_SearchVehicleTypeName, null, null, "ssp_GetVehicleTypeList", "@Event", "ddl_VehicleType", "@VehicleType", "", "", "", "VehicleType", "VehicleType", Txt_SearchVehicleTypeName);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
    #region /*---------------------------------------------------------------------All Function Defination------------------------------------------------------------------------------*/

    /*----------------Fill Data in Gridview Code with sorting--------------------*/

    //private string SortDirection
    //{
    //    get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
    //    set { ViewState["SortDirection"] = value; }
    //}

    //private void FillGrid(string sortExpression = null)
    //{
    //    if (con1.State == ConnectionState.Closed)
    //    {
    //        con1.Open();
    //    }
    //    con.cmd = new SqlCommand("spViewVehicleTypeMaster", con1);
    //    con.cmd.CommandType = CommandType.StoredProcedure;
    //    con.cmd.Parameters.AddWithValue("@Event", "View_VehicleType");
    //    con.cmd.Parameters.AddWithValue("@VehicleTypeId", "");
    //    con.DA = new SqlDataAdapter(con.cmd);
    //    con.Dt = new DataTable();
    //    con.DA.Fill(con.Dt);
    //    if (sortExpression != null)
    //    {
    //        DataView dv = con.Dt.AsDataView();
    //        this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
    //        dv.Sort = sortExpression + " " + this.SortDirection;
    //        GV_VehicleType.DataSource = dv;
    //        GV_Export.DataSource = dv;
    //    }
    //    else
    //    {
    //        GV_VehicleType.DataSource = con.Dt;
    //        GV_Export.DataSource = con.Dt;
    //    }
    //    GV_VehicleType.DataBind();
    //    GV_Export.DataBind();

    //}

    /*----------------ClearText Code--------------------*/
    //tab1 Clear
    public void ClearVehicleTypeData()
    {
        Txt_VehicleTypeName.Text = "";
        SearchableView();
        //  ViewData.Visible = false;
    }

    /*----------------Load Data Into Text Code--------------------*/
    public void LoadFinalDataIntoText()
    {
        if (con.State == ConnectionState.Closed)
        {
            con.open();
        }
        con.cmd = new SqlCommand("ssp_GetVehicleType", con.con);
        con.cmd.CommandType = CommandType.StoredProcedure;
        con.cmd.Parameters.AddWithValue("@VehicleTypeId", PkFieldId);
        con.DA = new SqlDataAdapter(con.cmd);
        con.Dt = new DataTable();
        con.DA.Fill(con.Dt);
        GV_VehicleType.DataSource = con.Dt;
        if (con.Dt.Rows.Count > 0)
        {
            Txt_VehicleTypeName.Text = con.Dt.Rows[0]["VehicleType"].ToString();
        }
    }
    #endregion

    #region     /*----------------------------------------------------------------------Tab1 Start Code / Vehicle Type--------------------------------------------------------------------*/

    /* Add Vehicle Type */
    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = cmf.CurrentDateTime();
        if (con.State == ConnectionState.Closed)
        {
            con.open();
        }
        if (CFunctions.tabstatus == 0)
        {
            //    InsertUpdate.InsertUpdateParameters10("ssp_CreateOrUpdateVehicleType", "@check", CFunctions.tabstatus, "@VehicleTypeId", "", "@VehicleTypeName", Txt_VehicleTypeName.Text.ToString().ToUpper(), "@userID", Session["userID"].ToString(),
            //      "@branchID", Session["branchId"].ToString(), "@creationDateTime", CurrentDateTime, "", "", "", "", "", "", "", "");
            con.cmd = new SqlCommand("ssp_CreateOrUpdateVehicleType", con.con);
            con.cmd.CommandType = CommandType.StoredProcedure;
            con.cmd.Parameters.AddWithValue("@check", "Insert");
            con.cmd.Parameters.AddWithValue("@VehicleTypeId", "");
            con.cmd.Parameters.AddWithValue("@VehicleTypeName", Txt_VehicleTypeName.Text.ToString().ToUpper());
            con.cmd.Parameters.AddWithValue("@userID", Session["userID"].ToString());
            con.cmd.Parameters.AddWithValue("@branchID", Session["branchId"].ToString());
            con.cmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime);
            con.cmd.ExecuteNonQuery();
            cmf.showalert("Button_Submit1", "SAVE", this);
        }
        else if (CFunctions.tabstatus == 1)
        {
            //InsertUpdate.InsertUpdateParameters10("ssp_CreateOrUpdateVehicleType", "@check", statusClass1.tab1Status, "@VehicleTypeId", statusClass1.code, "@VehicleTypeName", Txt_VehicleTypeName.Text.ToString().ToUpper(), "@userID", "",
            //  "@branchID", "", "@creationDateTime", "", "", "", "", "", "", "", "", "");
            con.cmd = new SqlCommand("ssp_CreateOrUpdateVehicleType", con.con);
            con.cmd.CommandType = CommandType.StoredProcedure;
            con.cmd.Parameters.AddWithValue("@check", "Update");
            con.cmd.Parameters.AddWithValue("@VehicleTypeId", CFunctions.ID);
            con.cmd.Parameters.AddWithValue("@VehicleTypeName", Txt_VehicleTypeName.Text.ToString().ToUpper());
            con.cmd.Parameters.AddWithValue("@userID", "");
            con.cmd.Parameters.AddWithValue("@branchID", "");
            con.cmd.Parameters.AddWithValue("@creationDateTime", "");
            con.cmd.ExecuteNonQuery();
            cmf.ButtonopacityHideShow(1, "RESET", Reset);
            cmf.ButtonopacityHideShow(1, "SUBMIT", Button_Submit1);

            cmf.showalert("Button_Submit1", "UPDATE", this);
        }
        CFunctions.setTabStatus(0);
        ClearVehicleTypeData();
        // cmf1.BindDataValueInListTripleParameter("", RadioButtonList_SearchVehicleTypeName, null, null, "ssp_GetVehicleTypeList", "@Event", "ddl_VehicleType", "@VehicleType", "", "", "", "VehicleType", "VehicleType", Txt_SearchVehicleTypeName);
        Txt_VehicleTypeName.Focus();
    }
    protected void Reset_Click(object sender, EventArgs e)
    {
        ClearVehicleTypeData();
    }
    #endregion

    #region     /*----------------------------------------------------------------------Tab2 Start Code /View--------------------------------------------------------------------*/

    #region  /*Searchable Vehicle Type code*/

    //protected void RadioButtonList_SearchVehicleTypeName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //for (int i = 0; i < RadioButtonList_SearchVehicleTypeName.Items.Count; i++)
    //    //{
    //    //    if (RadioButtonList_SearchVehicleTypeName.Items[i].Selected)
    //    //    {
    //    //        Txt_SearchVehicleTypeName.Text = RadioButtonList_SearchVehicleTypeName.Items[i].Text;

    //    //        if (Txt_SearchVehicleTypeName.Text.ToString() == "SELECT")
    //    //        {
    //    //            Txt_SearchVehicleTypeName.Focus();
    //    //        }
    //    //        else
    //    //        {
    //    //            Btn_Search.Focus();
    //    //        }

    //    //    }
    //    //}
    //    //PopupControlExtender_SearchVehicleTypeName.Commit(RadioButtonList_SearchVehicleTypeName.SelectedValue);
    //}
    //protected void Txt_SearchVehicleTypeName_Search_TextChanged(object sender, EventArgs e)
    //{
    //    //if (Txt_SearchVehicleTypeName_Search.Text != "")
    //    //{
    //    //    cmf1.Datalist_Searchable("", Txt_SearchVehicleTypeName_Search, RadioButtonList_SearchVehicleTypeName, null, null, "ssp_GetVehicleTypeList", "@Event", "ddl_Search_VehicleType", "@VehicleType", Txt_SearchVehicleTypeName_Search.Text.ToString(), "", "", "VehicleType", "VehicleType", Txt_SearchVehicleTypeName);
    //    //    Txt_SearchVehicleTypeName_Search.Focus();
    //    //}
    //    //else if (Txt_SearchVehicleTypeName_Search.Text == "")
    //    //{
    //    //    cmf1.Datalist_Searchable("", Txt_SearchVehicleTypeName_Search, RadioButtonList_SearchVehicleTypeName, null, null, "ssp_GetVehicleTypeList", "@Event", "ddl_VehicleType", "@VehicleType", "", "", "", "VehicleType", "VehicleType", Txt_SearchVehicleTypeName);
    //    //    Txt_SearchVehicleTypeName_Search.Focus();
    //    //}
    //}

    #endregion

    #region /* Searchable Data */
    //protected void Btn_Search_Click(object sender, EventArgs e)
    //{
    //    if (Txt_SearchVehicleTypeName.Text.ToString() == "SELECT")
    //    {
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Select VehicleType!');", true);
    //       // ViewData.Visible = false;
    //    }
    //    else
    //    {
    //        SearchableView();
    //       // ViewData.Visible = true;
    //    }
    //}

    //Searchable View Function
    private void SearchableView()
    {
        if (con.con.State == ConnectionState.Closed)
        {
            con.open();
        }
        // String VehicleType = Txt_SearchVehicleTypeName.Text.ToString().Trim();
        con.cmd = new SqlCommand("ssp_ViewVehicleType", con.con);
        con.cmd.CommandType = CommandType.StoredProcedure;
        //con.cmd.Parameters.AddWithValue("@VehicleType", VehicleType);
        con.DA = new SqlDataAdapter(con.cmd);
        con.Dt = new DataTable();
        con.DA.Fill(con.Dt);
        GV_VehicleType.DataSource = con.Dt;
        GV_VehicleType.DataBind();
        GV_Export.DataSource = con.Dt;
        GV_Export.DataBind();
        con.close();
    }
    #endregion

    //Shorting View Code
    //protected void gridViewVehicleType_Sorting(object sender, GridViewSortEventArgs e)
    //{
    //    FillGrid(e.SortExpression);
    //}

    // Paging View Code
    protected void gridViewVehicleType_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_VehicleType.PageIndex = e.NewPageIndex;
        SearchableView();

        //  if (Txt_SearchVehicleTypeName.Text.ToString() == "SELECT")
        // {
        //     FillGrid();
        // }
        // else
        //  {
        //  }
    }

    //Edit View Data In TextBox
    protected void editViewVehicleType_Click(object sender, EventArgs e)
    {
        CFunctions.setTabStatus(1);
        PkFieldId = Convert.ToString((sender as LinkButton).CommandArgument);
        CFunctions.setID(Convert.ToInt32(PkFieldId));
        LoadFinalDataIntoText();
        cmf.ButtonopacityHideShow(1, "UPDATE", Button_Submit1);
        cmf.ButtonopacityHideShow(0, "RESET", Reset);
    }

    /* Export To Excel Start */
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btn_ExporttoExcel_Click(object sender, ImageClickEventArgs e)
    {
        string CurrentDateTime = cmf.CurrentDateTime();
        GV_Export.Visible = true;
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Vehicle_TypeCreation" + CurrentDateTime + ".xls";
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


    #endregion

}