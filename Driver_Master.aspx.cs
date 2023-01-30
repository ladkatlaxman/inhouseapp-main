using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
public partial class OPERATIONS_DriverMaster : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    CFunctions cmf = new CFunctions();
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    string strcmd = string.Empty;
    static String fileName1, fileName2, fileName3;
    public static string editDriverNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {

                CFunctions.setTab(1);
                CFunctions.setTabStatus(0);
                Btn_Next.Enabled = false;
                Btn_Next.Style.Add("color", "white");
                Btn_Next.Style.Add("opacity", "0.3");
                DatafillForDriverViewDetails();
                DatafillForBelongToBranch();
                fillState();

                Search_DriverDetails_View.Visible = false;
                Txt_DriverName.Focus();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
    }
    public void fillState()
    {
        con.Open();

        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetStateList", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);

        ddl_State.DataSource = dt;
        ddl_State.DataTextField = "stateName";
        ddl_State.DataValueField = "stateId";
        ddl_State.DataBind();
        ddl_State.Items.Insert(0, "SELECT");
        foreach (ListItem listofstate in ddl_State.Items)
        {
            listofstate.Text = listofstate.Text.ToUpper();
        }
        con.Close();
        ddl_State.SelectedIndex = 0;
        // Txt_State_Search.Focus();

    }
    //protected void Txt_State_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_State_Search.Value == "1")
    //    {
    //        if (Txt_State_Search.Text != "")
    //        {
    //            string search = Txt_State_Search.Text;
    //            string searchTxt = "SELECT stateId,stateName FROM tblStateMaster WHERE stateName LIKE '%" + search + "%'";
    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            RadioButtonList_State.DataSource = dt;
    //            RadioButtonList_State.DataTextField = "stateName";
    //            RadioButtonList_State.DataValueField = "stateId";
    //            RadioButtonList_State.DataBind();
    //            RadioButtonList_State.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofstate in RadioButtonList_State.Items)
    //            {
    //                listofstate.Text = listofstate.Text.ToUpper();
    //            }
    //            Txt_State_Search.Focus();
    //            con.Close();
    //            for (int i = 0; i < RadioButtonList_State.Items.Count; i++)
    //            {
    //                if (Txt_State.Text == RadioButtonList_State.Items[i].Text)
    //                {
    //                    RadioButtonList_State.Items[i].Selected = true;
    //                    break;
    //                }
    //            }
    //        }
    //        else if (Txt_State_Search.Text == "")
    //        {
    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetStateList", con);
    //            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            RadioButtonList_State.DataSource = dt;
    //            RadioButtonList_State.DataTextField = "stateName";
    //            RadioButtonList_State.DataValueField = "stateId";
    //            RadioButtonList_State.DataBind();
    //            RadioButtonList_State.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofstate in RadioButtonList_State.Items)
    //            {
    //                listofstate.Text = listofstate.Text.ToUpper();
    //            }
    //            Txt_State_Search.Focus();
    //            con.Close();
    //            for (int i = 0; i < RadioButtonList_State.Items.Count; i++)
    //            {
    //                if (Txt_State.Text == RadioButtonList_State.Items[i].Text)
    //                {
    //                    RadioButtonList_State.Items[i].Selected = true;
    //                    break;
    //                }
    //            }
    //        }
    //        HiddenField_Txt_State_Search.Value = "";
    //    }
    //}

    //protected void RadioButtonList_State_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_State.Value == "1")
    //    {
    //        for (int i = 0; i < RadioButtonList_State.Items.Count; i++)
    //        {
    //            if (RadioButtonList_State.Items[i].Selected)
    //            {
    //                Txt_State.Text = RadioButtonList_State.Items[i].Text;
    //                if (Txt_State.Text.ToString() == "SELECT")
    //                {
    //                    Txt_State.Focus();
    //                }
    //                else
    //                {
    //                    Button_Tab1Save.Focus();
    //                }
    //            }
    //        }
    //        PopupControlExtender_State.Commit(RadioButtonList_State.SelectedValue);
    //        HiddenField_RadioButtonList_State.Value = "";
    //    }
    //}
    protected void Btn_DocReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_DocReset.Value == "1")
        {
            Txt_LicenceId.Text = "";
            Txt_LicenceValidDateFrom.Text = "";
            Txt_LicenceValidDateTo.Text = "";
            Driver_LicenceNo_Label.InnerHtml = "";
            Txt_PanCardNo.Text = "";
            Driver_PanCard_Label.InnerHtml = "";
            Txt_AdharcardNo.Text = "";
            Driver_AadhaarCard_Label.InnerHtml = "";
            HiddenField_Btn_DocReset.Value = "";
        }

    }
    public void clearAll()
    {
        Txt_DriverName.Text = "";
        Txt_DriverName.Enabled = true;
        Txt_DriverContactNo.Text = "";
        Txt_DriverEmailId.Text = "";
        //Txt_State.Text = "SELECT";
        ddl_State.SelectedIndex = 0;
        //Txt_State_Search.Text = "";
        fillState();
        Txt_City.Text = "";
        Txt_Pincode.Text = "";
        Txt_DriverAddress.Text = "";
        //Txt_BelongToBranch.Text = "SELECT";
        ddl_BelongToBranch.SelectedIndex = 0;
        //Txt_BelongToBranch_Search.Text = "";
        DatafillForBelongToBranch();
        Txt_LicenceId.Text = "";
        Txt_LicenceValidDateFrom.Text = "";
        Txt_LicenceValidDateTo.Text = "";
        Driver_LicenceNo_Label.InnerHtml = "";
        Txt_PanCardNo.Text = "";
        Driver_PanCard_Label.InnerHtml = "";
        Txt_AdharcardNo.Text = "";
        Driver_AadhaarCard_Label.InnerHtml = "";

        Button_Tab1Save.Text = "SAVE <i class='fa fa-save'></i>";

        //Txt_SearchDriverName.Text = "SELECT";
        //Txt_SearchDriverName_Search.Text = "";

        Btn_Next.Enabled = false;
        Btn_Next.Style.Add("color", "white");
        Btn_Next.Style.Add("opacity", "0.3");

        Btn_Reset.Enabled = true;
        Btn_Reset.CssClass = "btn btn-info largeButtonStyle";
        Btn_Reset.Style.Add("color", "white");
        Btn_Reset.Style.Remove("opacity");

        Btn_DocReset.Enabled = true;
        Btn_DocReset.CssClass = "btn btn-info largeButtonStyle";
        Btn_DocReset.Style.Add("color", "white");
        Btn_DocReset.Style.Remove("opacity");

        Search_DriverDetails_View.Visible = false;
        Txt_DriverName.Focus();

        // Response.Redirect(Request.Url.AbsoluteUri);
    }
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Reset.Value == "1")
        {
            Response.Redirect(Request.Url.AbsoluteUri);
            HiddenField_Btn_Reset.Value = "";
        }

    }
    //protected void Txt_BelongToBranch_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_BelongToBranch_Search.Value == "1")
    //    {
    //        if (Txt_BelongToBranch_Search.Text != "")
    //        {
    //            string search = Txt_BelongToBranch_Search.Text;
    //            string searchTxt = "SELECT branchID,branchName FROM tblBranchCreation WHERE branchName LIKE '%" + search + "%' AND status='ACTIVE' order by branchName ASC";
    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            RadioButtonList_BelongToBranch.DataSource = dt;
    //            RadioButtonList_BelongToBranch.DataTextField = "branchName";
    //            RadioButtonList_BelongToBranch.DataValueField = "branchID";
    //            RadioButtonList_BelongToBranch.DataBind();
    //            RadioButtonList_BelongToBranch.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofbranch in RadioButtonList_BelongToBranch.Items)
    //            {
    //                listofbranch.Text = listofbranch.Text.ToUpper();
    //            }
    //            Txt_BelongToBranch_Search.Focus();
    //            con.Close();
    //            for (int i = 0; i < RadioButtonList_BelongToBranch.Items.Count; i++)
    //            {
    //                if (Txt_BelongToBranch.Text == RadioButtonList_BelongToBranch.Items[i].Text)
    //                {
    //                    RadioButtonList_BelongToBranch.Items[i].Selected = true;
    //                    break;
    //                }
    //            }
    //        }

    //        else if (Txt_BelongToBranch_Search.Text == "")
    //        {
    //            con.Open();
    //            //string search = TextBox2.Text;
    //            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
    //            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);

    //            RadioButtonList_BelongToBranch.DataSource = dt;
    //            RadioButtonList_BelongToBranch.DataTextField = "branchName";
    //            RadioButtonList_BelongToBranch.DataValueField = "branchID";
    //            RadioButtonList_BelongToBranch.DataBind();
    //            RadioButtonList_BelongToBranch.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofbranch in RadioButtonList_BelongToBranch.Items)
    //            {
    //                listofbranch.Text = listofbranch.Text.ToUpper();
    //            }
    //            Txt_BelongToBranch_Search.Focus();
    //            con.Close();

    //            for (int i = 0; i < RadioButtonList_BelongToBranch.Items.Count; i++)
    //            {
    //                if (Txt_BelongToBranch.Text == RadioButtonList_BelongToBranch.Items[i].Text)
    //                {
    //                    RadioButtonList_BelongToBranch.Items[i].Selected = true;
    //                    break;
    //                }
    //            }
    //        }
    //        HiddenField_Txt_BelongToBranch_Search.Value = "";
    //    }
    //}
    //protected void RadioButtonList_BelongToBranch_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_BelongToBranch.Value == "1")
    //    {
    //        for (int i = 0; i < RadioButtonList_BelongToBranch.Items.Count; i++)
    //        {
    //            if (RadioButtonList_BelongToBranch.Items[i].Selected)
    //            {
    //                Txt_BelongToBranch.Text = RadioButtonList_BelongToBranch.Items[i].Text;
    //                if (Txt_BelongToBranch.Text.ToString() == "SELECT")
    //                {
    //                    Txt_BelongToBranch.Focus();
    //                }
    //                else
    //                {
    //                    Button_Tab1Save.Focus();
    //                }
    //            }
    //        }
    //        PopupControlExtender_BelongToBranch.Commit(RadioButtonList_BelongToBranch.SelectedValue);
    //        HiddenField_RadioButtonList_BelongToBranch.Value = "";
    //    }
    //    //Button_Tab1Save.Focus();
    //}
    public void DatafillForBelongToBranch()
    {
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);

        ddl_BelongToBranch.DataSource = dt;
        ddl_BelongToBranch.DataTextField = "branchName";
        ddl_BelongToBranch.DataValueField = "branchID";
        ddl_BelongToBranch.DataBind();
        ddl_BelongToBranch.Items.Insert(0, "SELECT");
        foreach (ListItem listofState in ddl_BelongToBranch.Items)
        {
            listofState.Text = listofState.Text.ToUpper();
        }
        con.Close();
        ddl_BelongToBranch.SelectedIndex = 0;
    }
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

 
    public void NonEditableFieldsOfDriver()
    {
        Txt_DriverName.Enabled = false;
        Txt_DriverContactNo.Enabled = false;
        //Panel_BelongToBranch.Visible = false;
        //Txt_BelongToBranch.Style.Remove("background-color");
        ddl_BelongToBranch.Attributes.Add("disabled", "disabled");
        Txt_DriverEmailId.Enabled = false;
        Txt_City.Enabled = false;
        Txt_Pincode.Enabled = false;
        Txt_DriverAddress.Enabled = false;
        //Panel_State.Visible = false;
        //Txt_State.Style.Remove("background-color");
        ddl_State.Attributes.Add("disabled", "disabled");
        Button_Tab1Save.Enabled = false;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Add("opacity", "0.3");
        Btn_Reset.Enabled = false;
        Btn_Reset.Style.Add("color", "white");
        Btn_Reset.Style.Add("opacity", "0.3");
        Btn_Next.CssClass = "btn btn-info largeButtonStyle next-step";
        Btn_Next.Style.Remove("opacity");
    }
    //************************************************Set setFinalSubmit False(At the time of Editing)******************************************************
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {
        if (HiddenField_Tab1Save.Value == "1")
        {
            string CurrentDateTime = cmf.CurrentDateTime();
            if (CFunctions.tab == 1)
            {
                if (CFunctions.tabstatus == 0)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateDriver", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@driverTab", CFunctions.tab);
                    cmd.Parameters.AddWithValue("@drivercheck", CFunctions.tabstatus);
                    cmd.Parameters.AddWithValue("@DriverID", "");
                    cmd.Parameters.AddWithValue("@driverName", Txt_DriverName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@driverContactNo", Txt_DriverContactNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@driverEmailID", Txt_DriverEmailId.Text.Trim());
                    cmd.Parameters.AddWithValue("@stateID", ddl_State.SelectedValue.Trim().ToString());
                    cmd.Parameters.AddWithValue("@cityName", Txt_City.Text.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@pincode", Txt_Pincode.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@address", Txt_DriverAddress.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@belongToBranchID", ddl_BelongToBranch.SelectedValue.Trim().ToString());
                    cmd.Parameters.AddWithValue("@userID", Session["userID"].ToString());
                    cmd.Parameters.AddWithValue("@branchID", Session["BranchId"].ToString());
                    cmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime);
                    cmd.Parameters.AddWithValue("@licenceNo", "");
                    cmd.Parameters.AddWithValue("@licenceValidFromDate", "");
                    cmd.Parameters.AddWithValue("@licenceValidToDate", "");
                    cmd.Parameters.AddWithValue("@panCardNo", "");
                    cmd.Parameters.AddWithValue("@aadharCardNo", "");
                    cmd.Parameters.AddWithValue("@licenceFileName", "");
                    cmd.Parameters.AddWithValue("@panCardFileName", "");
                    cmd.Parameters.AddWithValue("@aadharCardFileName", "");

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                        CFunctions.setID(Convert.ToInt32(dr["ID"]));
                    con.Close();

                    string a = "Button_Tab1Save";
                    string b = "SAVE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
                }
                else if (CFunctions.tabstatus == 1)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateDriver", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@driverTab", CFunctions.tab);
                    cmd.Parameters.AddWithValue("@drivercheck", CFunctions.tabstatus);
                    cmd.Parameters.AddWithValue("@DriverID", CFunctions.ID);
                    cmd.Parameters.AddWithValue("@driverName", Txt_DriverName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@driverContactNo", Txt_DriverContactNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@driverEmailID", Txt_DriverEmailId.Text.Trim());
                    cmd.Parameters.AddWithValue("@stateID", ddl_State.SelectedValue.Trim().ToString());
                    cmd.Parameters.AddWithValue("@cityName", Txt_City.Text.Trim());
                    cmd.Parameters.AddWithValue("@pincode", Txt_Pincode.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@address", Txt_DriverAddress.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@belongToBranchID", ddl_BelongToBranch.SelectedValue.Trim().ToString());
                    cmd.Parameters.AddWithValue("@userID", "");
                    cmd.Parameters.AddWithValue("@branchID", "");
                    cmd.Parameters.AddWithValue("@creationDateTime", "");
                    cmd.Parameters.AddWithValue("@licenceNo", "");
                    cmd.Parameters.AddWithValue("@licenceValidFromDate", "");
                    cmd.Parameters.AddWithValue("@licenceValidToDate", "");
                    cmd.Parameters.AddWithValue("@panCardNo", "");
                    cmd.Parameters.AddWithValue("@aadharCardNo", "");
                    cmd.Parameters.AddWithValue("@licenceFileName", "");
                    cmd.Parameters.AddWithValue("@panCardFileName", "");
                    cmd.Parameters.AddWithValue("@aadharCardFileName", "");
                    cmd.ExecuteNonQuery();
                    con.Close();
                    NonEditableFieldsOfDriver();
                    string a = "Button_Tab1Save";
                    string b = "UPDATE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
                }
            }
            NonEditableFieldsOfDriver();
            DatafillForDriverViewDetails();
            HiddenField_Tab1Save.Value = "";
        }
    }

    public void RemoveNonEditableFieldsOfDriver()
    {
        Txt_DriverName.Enabled = true;
        Txt_DriverContactNo.Enabled = true;
        //Panel_BelongToBranch.Visible = true;
        //Txt_BelongToBranch.Style.Add("background-color", "White");
        ddl_BelongToBranch.Attributes.Remove("disabled");
        Txt_DriverEmailId.Enabled = true;
        //Panel_State.Visible = true;
        //Txt_State.Style.Add("background-color", "White");
        ddl_State.Attributes.Remove("disabled");
        Txt_City.Enabled = true;
        Txt_Pincode.Enabled = true;
        Txt_DriverAddress.Enabled = true;

        Button_Tab1Save.Enabled = true;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Remove("opacity");

    }

    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        if (HiddenField_Submit1.Value == "1")
        {
            HiddenField_Submit1.Value = "";
        }
        string licenceFileName;
        string panCardFileName;
        string aadharCardFileName;
        if (fileName1 == null)
        {
            licenceFileName = "";
        }
        else
        {
            licenceFileName = fileName1;
            fileName1 = null;
        }

        if (fileName2 == null)
        {
            panCardFileName = "";
        }
        else
        {
            panCardFileName = fileName2;
            fileName2 = null;
        }

        if (fileName3 == null)
        {
            aadharCardFileName = "";
        }
        else
        {
            aadharCardFileName = fileName3;
            fileName3 = null;
        }
        CFunctions.setTab(2);
        if (CFunctions.tab == 2)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateDriver", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@driverTab", CFunctions.tab);
            cmd.Parameters.AddWithValue("@drivercheck", CFunctions.tabstatus);
            cmd.Parameters.AddWithValue("@DriverID", CFunctions.ID);
            cmd.Parameters.AddWithValue("@driverName", "");
            cmd.Parameters.AddWithValue("@driverContactNo", "");
            cmd.Parameters.AddWithValue("@driverEmailID", "");
            cmd.Parameters.AddWithValue("@stateID", "");
            cmd.Parameters.AddWithValue("@cityName", "");
            cmd.Parameters.AddWithValue("@pincode", "");
            cmd.Parameters.AddWithValue("@address", "");
            cmd.Parameters.AddWithValue("@belongToBranchID", "");
            cmd.Parameters.AddWithValue("@userID", "");
            cmd.Parameters.AddWithValue("@branchID", "");
            cmd.Parameters.AddWithValue("@creationDateTime", "");
            cmd.Parameters.AddWithValue("@licenceNo", Txt_LicenceId.Text.Trim().ToString().ToUpper());
            cmd.Parameters.AddWithValue("@licenceValidFromDate", Txt_LicenceValidDateFrom.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@licenceValidToDate", Txt_LicenceValidDateTo.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@panCardNo", Txt_PanCardNo.Text.Trim().ToString().ToUpper());
            cmd.Parameters.AddWithValue("@aadharCardNo", Txt_AdharcardNo.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@licenceFileName", licenceFileName);
            cmd.Parameters.AddWithValue("@panCardFileName", panCardFileName);
            cmd.Parameters.AddWithValue("@aadharCardFileName", aadharCardFileName);
            cmd.ExecuteNonQuery();
            con.Close();
            if (CFunctions.tabstatus == 0)
            {
                string a = "Button_Submit1";
                string b = "SAVE";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
            }
            else if (CFunctions.tabstatus == 1)
            {
                string a = "Button_Submit1";
                string b = "UPDATE";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
            }

            DatafillForDriverViewDetails();
            RemoveNonEditableFieldsOfDriver();
            CFunctions.setTab(1);
            CFunctions.setTabStatus(0);
            clearAll();
        }
        if (CFunctions.form == 1)
        {
            CFunctions.setform(0);
            if (Session["URI"] != null)
            {
                Response.Redirect(Session["URI"].ToString());
            }
        }
    }
    protected void editDriverDetails_Click(object sender, EventArgs e)
    {
        CFunctions.setTabStatus(1);
        CFunctions.setID(Convert.ToInt32((sender as LinkButton).CommandArgument));
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetDriverCreation", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@DriverID", CFunctions.ID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        con.Close();
        Txt_DriverName.Enabled = false;
        Txt_DriverName.Text = dtbl.Rows[0]["driverName"].ToString();
        Txt_DriverContactNo.Text = dtbl.Rows[0]["driverContactNo"].ToString();
        Txt_DriverEmailId.Text = dtbl.Rows[0]["driverEmailID"].ToString();
        ddl_State.SelectedItem.Text = dtbl.Rows[0]["stateName"].ToString();
        ddl_State.SelectedValue = dtbl.Rows[0]["stateID"].ToString();
        //foreach (ListItem list in ddl_State.Items)
        //{
        //    list.Text = list.Text.ToUpper();
        //    if (list.Text == dtbl.Rows[0]["stateName"].ToString())
        //    {
        //        ddl_State.SelectedItem.Text = list.Text;
        //        ddl_State.SelectedValue = dtbl.Rows[0]["stateID"].ToString();

        //        list.Selected = true;
        //        list.Value = dtbl.Rows[0]["stateID"].ToString();
        //    }
        //}
        //ddl_State.Text = dtbl.Rows[0]["stateName"].ToString();
        Txt_City.Text = dtbl.Rows[0]["cityName"].ToString();
        Txt_Pincode.Text = dtbl.Rows[0]["pinCode"].ToString();
        Txt_DriverAddress.Text = dtbl.Rows[0]["address"].ToString();
        ddl_BelongToBranch.SelectedItem.Text = dtbl.Rows[0]["branchName"].ToString();
        ddl_BelongToBranch.SelectedValue = dtbl.Rows[0]["belongTobranchID"].ToString();
        //foreach (ListItem list in ddl_BelongToBranch.Items)
        //{
        //    list.Text = list.Text.ToUpper();
        //    if (list.Text == dtbl.Rows[0]["branchName"].ToString())
        //    {
        //        list.Selected = true;
        //        list.Value = dtbl.Rows[0]["belongTobranchID"].ToString();
        //    }
        //}
        Txt_LicenceId.Text = dtbl.Rows[0]["licenceNo"].ToString();
        Txt_LicenceValidDateFrom.Text = dtbl.Rows[0]["licenceValidFromDate"].ToString();
        Txt_LicenceValidDateTo.Text = dtbl.Rows[0]["licenceValidToDate"].ToString();
        //    Driver_LicenceNo_Label.Text = dtbl.Rows[0]["licenceFileName"].ToString(); 
        Driver_LicenceNo_Label.InnerHtml = dtbl.Rows[0]["licenceFileName"].ToString();
        Driver_LicenceNo_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["licenceFileName"].ToString());

        Txt_PanCardNo.Text = dtbl.Rows[0]["panCardNo"].ToString();
        //    Driver_PanCard_Label.Text = dtbl.Rows[0]["panCardFileName"].ToString(); 
        Driver_PanCard_Label.InnerHtml = dtbl.Rows[0]["panCardFileName"].ToString();
        Driver_PanCard_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["panCardFileName"].ToString());

        Txt_AdharcardNo.Text = dtbl.Rows[0]["aadharCardNo"].ToString();
        //    Driver_AadhaarCard_Label.Text = dtbl.Rows[0]["aadharCardFileName"].ToString();
        Driver_AadhaarCard_Label.InnerHtml = dtbl.Rows[0]["aadharCardFileName"].ToString();
        Driver_AadhaarCard_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["aadharCardFileName"].ToString());

        Btn_Reset.Enabled = false;
        Btn_Reset.Style.Add("opacity", "0.3");
        Btn_DocReset.Enabled = false;
        Btn_DocReset.Style.Add("opacity", "0.3");
        Button_Tab1Save.Text = "UPDATE <i class='fa fa-save'></i>";

        RemoveNonEditableFieldsOfDriver();
    }
    public void DatafillForDriverViewDetails()
    {
        SqlCommand cmd_cname = new SqlCommand("ssp_GetDriverList", con);
        con.Open();
        Ddl_SearchablrDriverName.DataSource = cmd_cname.ExecuteReader();
        Ddl_SearchablrDriverName.DataTextField = "driverName";
        Ddl_SearchablrDriverName.DataValueField = "driverID";
        Ddl_SearchablrDriverName.DataBind();
        Ddl_SearchablrDriverName.Items.Insert(0, "SELECT");
        foreach (ListItem listofdriver in Ddl_SearchablrDriverName.Items)
        {
            listofdriver.Text = listofdriver.Text.ToUpper();
        }
        Ddl_SearchablrDriverName.SelectedIndex = 0;
        con.Close();
    }

    //protected void Txt_SearchDriverName_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_SearchDriverName_Search.Value == "1")
    //    {
    //        if (Txt_SearchDriverName_Search.Text != "")
    //        {
    //            string search = Txt_SearchDriverName_Search.Text;
    //            string searchTxt = "SELECT driverID,driverName FROM tblDriverCreation WHERE driverName LIKE '%" + search + "%' AND status='ACTIVE'";

    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);

    //            RadioButtonList_SearchDriverName.DataSource = dt;
    //            RadioButtonList_SearchDriverName.DataTextField = "driverName";
    //            RadioButtonList_SearchDriverName.DataValueField = "driverID";
    //            RadioButtonList_SearchDriverName.DataBind();
    //            RadioButtonList_SearchDriverName.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofitem in RadioButtonList_SearchDriverName.Items)
    //            {
    //                listofitem.Text = listofitem.Text.ToUpper();
    //            }
    //            Txt_SearchDriverName_Search.Focus();
    //            con.Close();

    //            for (int i = 0; i < RadioButtonList_SearchDriverName.Items.Count; i++)
    //            {
    //                if (Txt_SearchDriverName.Text == RadioButtonList_SearchDriverName.Items[i].Text)
    //                {
    //                    RadioButtonList_SearchDriverName.Items[i].Selected = true;
    //                    break;
    //                }
    //            }
    //        }

    //        else if (Txt_SearchDriverName_Search.Text == "")
    //        {
    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetDriverList", con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            RadioButtonList_SearchDriverName.DataSource = dt;
    //            RadioButtonList_SearchDriverName.DataTextField = "driverName";
    //            RadioButtonList_SearchDriverName.DataValueField = "driverID";
    //            RadioButtonList_SearchDriverName.DataBind();
    //            RadioButtonList_SearchDriverName.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofitem in RadioButtonList_SearchDriverName.Items)
    //            {
    //                listofitem.Text = listofitem.Text.ToUpper();
    //            }
    //            Txt_SearchDriverName_Search.Focus();
    //            con.Close();

    //            for (int i = 0; i < RadioButtonList_SearchDriverName.Items.Count; i++)
    //            {
    //                if (Txt_SearchDriverName.Text == RadioButtonList_SearchDriverName.Items[i].Text)
    //                {
    //                    RadioButtonList_SearchDriverName.Items[i].Selected = true;
    //                    break;
    //                }
    //            }
    //        }

    //        HiddenField_Txt_SearchDriverName_Search.Value = "";
    //    }
    //}

    //protected void RadioButtonList_SearchDriverName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_SearchDriverName.Value == "1")
    //    {

    //        for (int i = 0; i < RadioButtonList_SearchDriverName.Items.Count; i++)
    //        {
    //            if (RadioButtonList_SearchDriverName.Items[i].Selected)
    //            {
    //                Txt_SearchDriverName.Text = RadioButtonList_SearchDriverName.Items[i].Text;
    //                if (Txt_SearchDriverName.Text.ToString() == "SELECT")
    //                {
    //                    Txt_SearchDriverName.Focus();
    //                }
    //                else
    //                {
    //                    Btn_Search.Focus();
    //                }
    //            }
    //        }
    //        PopupControlExtender_SearchDriverName.Commit(RadioButtonList_SearchDriverName.SelectedValue);
    //        HiddenField_RadioButtonList_SearchDriverName.Value = "";
    //    }
    //}
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Search.Value == "1")
        {
            if (Ddl_SearchablrDriverName.SelectedItem.Text.ToString() != "SELECT")
            {
                Search_DriverDetails_View.Visible = true;
                searchData();
            }
            //searchData();
            HiddenField_Btn_Search.Value = "";
        }
    }
    public void searchData(string sortExpression = null)
    {
        int drivername = Convert.ToInt32(Ddl_SearchablrDriverName.SelectedValue.Trim());
        if ((Ddl_SearchablrDriverName.SelectedItem.Text.ToString() != "SELECT"))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ssp_ViewDriverCreation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@driverId", drivername);
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataTable dtbl = new DataTable();
            DA.Fill(dtbl);
            if (sortExpression != null)
            {
                DataView dv = dtbl.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewDriver.DataSource = dv;
                //GV_Export.DataSource = dv;
            }
            else
            {
                gridViewDriver.DataSource = dtbl;
                // GV_Export.DataSource = dtbl;
            }
            gridViewDriver.DataBind();
            //GV_Export.DataBind();
            con.Close();
        }
       
    }

    protected void gridViewDriver_Sorting(object sender, GridViewSortEventArgs e)
    {
        searchData(e.SortExpression);

    }

    protected void gridViewDriver_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewDriver.PageIndex = e.NewPageIndex;
        searchData();
    }
    /* Ajax File Upload Start*/

    protected void Driver_LicenceNo_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Driver_LicenceNo_Uploader.SaveAs(fileNameToUpload);
        fileName1 = e.FileName.ToString();
    }

    protected void Driver_PanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Driver_PanCard_Uploader.SaveAs(fileNameToUpload);
        fileName2 = e.FileName.ToString();
    }

    protected void Driver_AadhaarCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Driver_AadhaarCard_Uploader.SaveAs(fileNameToUpload);
        fileName3 = e.FileName.ToString();
    }
    /* Ajax File Upload End*/

    /* Export To Excel Start */
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btn_ExporttoExcel_Click(object sender, EventArgs e)
    {
        //string CurrentDateTime = cmf.CurrentDateTime();

        //GV_Export.Visible = true;
        //Response.Clear();
        //Response.Buffer = true;
        //Response.ClearContent();
        //Response.ClearHeaders();
        //Response.Charset = "";
        //string FileName = "Driver_Creation" + CurrentDateTime + ".xls";
        //StringWriter strwritter = new StringWriter();
        //HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        //GV_Export.GridLines = GridLines.Both;
        //GV_Export.HeaderStyle.Font.Bold = true;
        //GV_Export.RenderControl(htmltextwrtter);
        //Response.Write(strwritter.ToString());
        //Response.End();
        //GV_Export.Visible = false;
    }
    /* Export To Excel End */

    protected void Txt_LicenceValidDateTo_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_LicenceValidDateTo.Value == "1")
        {
            int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

            String FromDate = Txt_LicenceValidDateFrom.Text.Trim();
            string[] splitDate = FromDate.Split('-');
            String ToDate = Txt_LicenceValidDateTo.Text.Trim();
            string[] splitDate1 = ToDate.Split('-');
            Fyear = Int32.Parse(splitDate[0]);
            Fmonth = Int32.Parse(splitDate[1]);
            Fday = Int32.Parse(splitDate[2]);
            Tyear = Int32.Parse(splitDate1[0]);
            Tmonth = Int32.Parse(splitDate1[1]);
            Tday = Int32.Parse(splitDate1[2]);

            if (Fyear <= Tyear)
            {
                if ((Fmonth <= Tmonth && Fyear <= Tyear) || (Fmonth >= Tmonth || Fmonth <= Tmonth) && Fyear < Tyear)
                {
                    if ((Fday < Tday && Fmonth <= Tmonth && Fyear <= Tyear) || ((Fday >= Tday || Fday <= Tday) && Fmonth < Tmonth && Fyear <= Tyear) || ((Fday >= Tday || Fday <= Tday) && (Fmonth <= Tmonth || Fmonth >= Tmonth) && Fyear < Tyear))
                    {
                        Txt_PanCardNo.Focus();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                        Txt_LicenceValidDateTo.Text = "";
                        Txt_LicenceValidDateTo.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                    Txt_LicenceValidDateTo.Text = "";
                    Txt_LicenceValidDateTo.Focus();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                Txt_LicenceValidDateTo.Text = "";
                Txt_LicenceValidDateTo.Focus();
            }

            HiddenField_Txt_LicenceValidDateTo.Value = "";
        }
    }






}