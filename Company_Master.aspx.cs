using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using CheckTabAndButtonStatus;
//using Global;
//using InHouse;
using System.IO;
using CommonLibrary;

public partial class OPERATIONS_CompanyMaster : System.Web.UI.Page
{
    static int count;
    int a = 0, b = 0, c = 0, d = 0;
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    CommonFunctions cmf = new CommonFunctions();
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    string strcmd = string.Empty;
    static String fileName1;
    static String fileName2;
    public static string editCompanyNo = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                Txt_CompanyName.Focus();
                
                generateCompanyCode();
                //CurrentDateTime();
                globalVar.code = "";
                statusClass.setBtnSubmit(0);
                statusClass.setBtnSubmit1(0);
                statusClass.setTab1Status(0);
                statusClass.setTab2Status(0);
                Btn_Next.Enabled = false;
                Btn_Next.Style.Add("color", "white");
                Btn_Next.Style.Add("opacity", "0.3");
                fillDeliveryPincode();
                displayDataInGridView();
                DatafillForCompanyViewDetails();
                Search_CompanyDetails_View.Visible = false;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }

   
   /* public void CurrentDateTime()
    {
        DateTime dt = DateTime.Now;
        string Day = dt.Day.ToString();
        string Month = dt.ToString("MM");
        string Year = dt.ToString("yyyy");

        string Hour = dt.Hour.ToString();
        string Minute = dt.ToString("mm");
        string Seconds = dt.ToString("ss");
        Lbl_CurrentDateTime.Text = Day + "/" + Month + "/" + Year + "   " + Hour + ":" + Minute + ":" + Seconds;
    }*/
    /*File Upload Section Start*/

    //protected void Company_GST_Uploader_FileUploaded(object sender, CuteWebUI.UploaderEventArgs args)
    //{
    //    Company_GST_Label.Text = (args.FileName);
    //    args.CopyTo("~/UploadDocuments/" + args.FileName);
    //}

    //protected void Company_CIN_Uploader_FileUploaded(object sender, CuteWebUI.UploaderEventArgs args)
    //{
    //    Company_CIN_Label.Text = (args.FileName);
    //    args.CopyTo("~/UploadDocuments/" + args.FileName);
    //}
    /*File Upload Section End*/

    public void fillDeliveryPincode()
    {

        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spGetDeliveryPincode", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);
        RadioButtonList_PinCode.DataSource = dt;
        RadioButtonList_PinCode.DataTextField = "Delivery Pincode";
        RadioButtonList_PinCode.DataValueField = "Delivery Pincode";
        RadioButtonList_PinCode.DataBind();
        RadioButtonList_PinCode.Items.Insert(0, "SELECT");
        con.Close();
        for (int i = 0; i < RadioButtonList_PinCode.Items.Count; i++)
        {
            if (RadioButtonList_PinCode.Items[i].ToString() == "SELECT")
            {
                RadioButtonList_PinCode.Items[i].Selected = true;
				break;												
            }
        }
    }
    protected void Btn_DocReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_DocReset.Value == "1")
        {
            Txt_CompanyGSTCertificates.Text = "";
            Company_GST_Label.InnerHtml = "";

            Txt_CompanyCIN.Text = "";
            Company_CIN_Label.InnerHtml = "";
            HiddenField_DocReset.Value = "";
        }   
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Reset.Value == "1")
        {
            Response.Redirect(Request.Url.AbsoluteUri);
            HiddenField_Reset.Value = "";
        }
    }

    public void clearAll()
    {
        generateCompanyCode();
        //CurrentDateTime();
        globalVar.code = "";

        Txt_CompanyName.Text = "";
        Txt_CompanyName.Enabled = true;
        Txt_OwnerName.Text = "";
        Txt_OwnerContactNo.Text = "";
        Txt_EmailId.Text = "";
        Txt_PinCode.Text = "SELECT";
        RadioButtonList_PinCode.SelectedIndex = 0;
        Txt_PinCode_Search.Text = "";
        fillDeliveryPincode();
        Txt_State.Text = "AUTO";
        Txt_District.Text = "AUTO";
        Txt_City.Text = "AUTO";
        Txt_Taluka.Text = "";
        Txt_Area.Text = "SELECT";
        RadioButtonList_Area.SelectedIndex = 0;
        Txt_Area_Search.Text = "";
        Img_AddArea.Visible = false;
        Txt_CompanyAddress.Text = "";
        Txt_Remark.Text = "";
        Txt_CompanyGSTCertificates.Text = "";
        Company_GST_Label.InnerHtml = "";

        Txt_CompanyCIN.Text = "";
        Company_CIN_Label.InnerHtml = "";

        Button_Tab1Save.Text = "SAVE <i class='fa fa-save'></i>";

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

        Search_CompanyDetails_View.Visible = false;
        Txt_CompanyName.Focus();

        //Response.Redirect(Request.Url.AbsoluteUri);
    }

    public void generateCompanyCode()

    {
        string result = "DEX";
        int h = 0;
        int m = 0;
        int s = 0;
        //string str = Txt_CompanyName.Text;
        //if (str.Length >= 4)
        //{
        //    result = str.Substring(0, 4);
        //}
        //else
        //{
        //    result = str;
        //}
        //TimeZoneInfo tmz;
        //DateTime dt;
        //tmz = TimeZoneInfo.FindSystemTimeZoneById("Indian Standard Time");
        //dt = TimeZoneInfo.ConvertTime(DateTime.Now, tmz);
        //Txt_ComapnyCode.Text = result + dt.ToString("ddMMyyHHmmss");
        //DateTime dt = DateTime.UtcNow.Date;
			 TimeZoneInfo tmz;
            DateTimeOffset dt;
            tmz = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
            DateTimeOffset local = DateTimeOffset.Now;
            dt = TimeZoneInfo.ConvertTime(local, tmz);
        result += dt.ToString("ddMMyy");
        h = dt.Hour;
        m = dt.Minute;
        s = dt.Second;
        if (h < 10)
        {
            result += "0" + h;
        }
        else { result += h; }
        if (m < 10)
        {
            result += "0" + m;
        }
        else { result += m; }
        if (s < 10)
        {
            result += "0" + s;
        }
        else { result += s; }

        Txt_ComapnyCode.Text = result;
        //Txt_ComapnyCode.Text = result + dt.ToString("ddMMyy") + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second;
        //Txt_ComapnyCode.Text = result + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second;
    }

    protected void Txt_PinCode_Search_TextChanged(object sender, EventArgs e)
    {
       
        if (HiddenField_PinCode_Search.Value == "1")
        {
            if (Txt_PinCode_Search.Text != "")
            {
                string search = Txt_PinCode_Search.Text;
                string searchTxt = "SELECT DISTINCT [Delivery Pincode] " + "FROM tblERPDataFile " + "WHERE [Delivery Pincode] LIKE '%" + search + "%' ";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_PinCode.DataSource = dt;
                RadioButtonList_PinCode.DataTextField = "Delivery Pincode";
                RadioButtonList_PinCode.DataValueField = "Delivery Pincode";
                RadioButtonList_PinCode.DataBind();
                RadioButtonList_PinCode.Items.Insert(0, "SELECT");
                Txt_PinCode_Search.Focus();

                for (int i = 0; i < RadioButtonList_PinCode.Items.Count; i++)
                {
                    if (Txt_PinCode.Text == RadioButtonList_PinCode.Items[i].Text)
                    {
                        RadioButtonList_PinCode.Items[i].Selected = true;
						break;
                    }
                }

            }

            else if (Txt_PinCode_Search.Text == "")
            {
                //string search = TextBox2.Text;
                string searchTxt = "SELECT DISTINCT [Delivery Pincode] " + "FROM tblERPDataFile ";


                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_PinCode.DataSource = dt;
                RadioButtonList_PinCode.DataTextField = "Delivery Pincode";
                RadioButtonList_PinCode.DataValueField = "Delivery Pincode";
                RadioButtonList_PinCode.DataBind();
                RadioButtonList_PinCode.Items.Insert(0, "SELECT");
                Txt_PinCode_Search.Focus();

                for (int i = 0; i < RadioButtonList_PinCode.Items.Count; i++)
                {
                    if (Txt_PinCode.Text == RadioButtonList_PinCode.Items[i].Text)
                    {
                        RadioButtonList_PinCode.Items[i].Selected = true;
						break;												
                    }
                }
            }

            HiddenField_PinCode_Search.Value = "";
        }
    }

    protected void RadioButtonList_PinCode_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        if (HiddenField_PinCode.Value == "1")
        {
            for (int i = 0; i < RadioButtonList_PinCode.Items.Count; i++)
            {
                if (RadioButtonList_PinCode.Items[i].Selected)
                {
                    Txt_PinCode.Text = RadioButtonList_PinCode.Items[i].Text;
                    if (Txt_PinCode.Text != "SELECT")
                    {
                        con.Open();
                        int pincode = Convert.ToInt32(Txt_PinCode.Text.ToString());

                        SqlDataAdapter sqlda = new SqlDataAdapter("spGetAreaOnPincode", con);
                        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
                        sqlda.SelectCommand.Parameters.AddWithValue("@pincode", pincode);
                        DataTable dt = new DataTable();
                        sqlda.Fill(dt);
                        RadioButtonList_Area.DataSource = dt;
                        RadioButtonList_Area.DataValueField = "Delivery Area";
                        RadioButtonList_Area.DataTextField = "Delivery Area";
                        RadioButtonList_Area.DataBind();
                        RadioButtonList_Area.Items.Insert(0, "SELECT");
                        RadioButtonList_Area.SelectedIndex = 0;
                        Txt_Area.Text = RadioButtonList_Area.Items[0].Text.ToString();
                        con.Close();
                        foreach (ListItem listofArea in RadioButtonList_Area.Items)
                        {
                            listofArea.Text = listofArea.Text.ToUpper();
                        }

                        Img_AddArea.Visible = true;
                        Demo_AREA.Visible = false;
                        Area.Visible = true;

                        con.Open();
                        int pincode1 = Convert.ToInt32(Txt_PinCode.Text.ToString());
                        SqlDataAdapter sqlda1 = new SqlDataAdapter("spAutoState_District_City_OnDeliveryPincode", con);
                        sqlda1.SelectCommand.CommandType = CommandType.StoredProcedure;
                        sqlda1.SelectCommand.Parameters.AddWithValue("@pincode", pincode1);
                        SqlDataReader reader = sqlda1.SelectCommand.ExecuteReader();
                        if (reader.Read())
                        {
                            Txt_State.Text = reader["Delivery State"].ToString().ToUpper();
                            Txt_District.Text = reader["Delivery  District"].ToString().ToUpper();
                            Txt_City.Text = reader["Delivery City"].ToString().ToUpper();
                            reader.Close();
                        }
                        con.Close();
                        RadioButtonList_PinCode.Focus();
                    }
                    else
                    {
                        Txt_State.Text = "AUTO";
                        Txt_District.Text = "AUTO";
                        Txt_City.Text = "AUTO";
                        Txt_Area.Text = "SELECT";
                        RadioButtonList_Area.Items.Clear();
                        RadioButtonList_Area.Items.Insert(0, "SELECT");
                        RadioButtonList_Area.SelectedIndex = 0;
                        Txt_PinCode.Focus();
                        Img_AddArea.Visible = false;
                        Demo_AREA.Visible = true;
                        Area.Visible = false;
                    }
                    break;
                }
            }
            PopupControlExtender_PinCode.Commit(RadioButtonList_PinCode.SelectedValue);
            Txt_Taluka.Focus();
            HiddenField_PinCode.Value = "";
        }
    }


    //protected void FillArea()
    //{
    //    int pincode = Convert.ToInt32(Txt_PinCode.Text.ToString());
    //    con.Open();
    //    SqlDataAdapter sqlda = new SqlDataAdapter("spGetAreaOnPincode", con);
    //    sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sqlda.SelectCommand.Parameters.AddWithValue("@pincode", pincode);
    //    DataTable dt = new DataTable();
    //    sqlda.Fill(dt);
    //    Ddl_Area.DataSource = dt;
    //    Ddl_Area.DataValueField = "Delivery Area";
    //    Ddl_Area.DataTextField = "Delivery Area";
    //    Ddl_Area.DataBind();
    //    Ddl_Area.Items.Insert(0, "SELECT");
    //    con.Close();
    //    foreach (ListItem listofArea in Ddl_Area.Items)
    //    {
    //        listofArea.Text = listofArea.Text.ToUpper();
    //    }
    //}
    protected void FillArea()
    {
        con.Open();
        int pincode = Convert.ToInt32(Txt_PinCode.Text.ToString());

        SqlDataAdapter sqlda = new SqlDataAdapter("spGetAreaOnPincode", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@pincode", pincode);
        DataTable dt = new DataTable();
        sqlda.Fill(dt);
        RadioButtonList_Area.DataSource = dt;
        RadioButtonList_Area.DataValueField = "Delivery Area";
        RadioButtonList_Area.DataTextField = "Delivery Area";
        RadioButtonList_Area.DataBind();
        RadioButtonList_Area.Items.Insert(0, "SELECT");
        con.Close();
        foreach (ListItem listofArea in RadioButtonList_Area.Items)
        {
            listofArea.Text = listofArea.Text.ToUpper();
        }
        //  RadioButtonList_Area.SelectedIndex = 0;
    }
    protected void Txt_Area_Search_TextChanged(object sender, EventArgs e)
    {     
        if (HiddenField_Area_Search.Value == "1")
        {
            if (Txt_Area_Search.Text != "")
            {
                string search = Txt_Area_Search.Text;
                string searchTxt = "SELECT DISTINCT [Delivery Area] " + "FROM tblERPArea " + "WHERE [Delivery Area] LIKE '%" + search + "%' AND [Delivery Pincode]='" + Txt_PinCode.Text.ToString() + "'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_Area.DataSource = dt;
                RadioButtonList_Area.DataTextField = "Delivery Area";
                RadioButtonList_Area.DataValueField = "Delivery Area";
                RadioButtonList_Area.DataBind();
                RadioButtonList_Area.Items.Insert(0, "SELECT");
                foreach (ListItem listofArea in RadioButtonList_Area.Items)
                {
                    listofArea.Text = listofArea.Text.ToUpper();
                }
                Txt_Area_Search.Focus();
                con.Close();


                for (int i = 0; i < RadioButtonList_Area.Items.Count; i++)
                {
                    if (Txt_Area.Text == RadioButtonList_Area.Items[i].Text)
                    {
                        RadioButtonList_Area.Items[i].Selected = true;
						break;											 
                    }
                }
            }

            else if (Txt_Area_Search.Text == "")
            {
                //string search = TextBox2.Text;
                string searchTxt = "SELECT DISTINCT [Delivery Area] FROM tblERPArea WHERE [Delivery Pincode] ='" + Txt_PinCode.Text.ToString() + "'";


                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_Area.DataSource = dt;
                RadioButtonList_Area.DataTextField = "Delivery Area";
                RadioButtonList_Area.DataValueField = "Delivery Area";
                RadioButtonList_Area.DataBind();
                RadioButtonList_Area.Items.Insert(0, "SELECT");
                foreach (ListItem listofArea in RadioButtonList_Area.Items)
                {
                    listofArea.Text = listofArea.Text.ToUpper();
                }
                Txt_Area_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_Area.Items.Count; i++)
                {
                    if (Txt_Area.Text == RadioButtonList_Area.Items[i].Text)
                    {
                        RadioButtonList_Area.Items[i].Selected = true;
						break;
                    }
                }
            }
            HiddenField_Area_Search.Value = "";
        }
    }

    protected void RadioButtonList_Area_SelectedIndexChanged(object sender, EventArgs e)
    {      
        if (HiddenField_Area.Value == "1")
        {
            Txt_Area.Text = RadioButtonList_Area.SelectedValue.ToString().ToUpper();
            if (Txt_Area.Text.ToString() == "SELECT")
            {
                Img_AddArea.Visible = true;
                Txt_Area.Focus();
            }
            else
            {
                Img_AddArea.Visible = false;
                RadioButtonList_Area.Focus();
            }

            for (int i = 0; i < RadioButtonList_Area.Items.Count; i++)
            {
                if (RadioButtonList_Area.Items[i].Selected)
                {
                    Txt_Area.Text = RadioButtonList_Area.Items[i].Text.ToUpper();
					break;											 
                }

            }

            PopupControlExtender_Area.Commit(RadioButtonList_Area.SelectedValue);

            Txt_CompanyAddress.Focus();

            HiddenField_Area.Value = "";
        }
    }


    //protected void DDL_PinCode_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    con.Open();
    //    int pincode = Convert.ToInt32(DDL_PinCode.SelectedValue.ToString());

    //    SqlDataAdapter sqlda = new SqlDataAdapter("spGetAreaOnPincode", con);
    //    sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sqlda.SelectCommand.Parameters.AddWithValue("@pincode", pincode);
    //    DataTable dt = new DataTable();
    //    sqlda.Fill(dt);
    //    Ddl_Area.DataSource = dt;
    //    Ddl_Area.DataValueField = "Delivery Area";
    //    Ddl_Area.DataTextField = "Delivery Area";
    //    Ddl_Area.DataBind();
    //    Ddl_Area.Items.Insert(0, "SELECT");
    //    con.Close();
    //    foreach (ListItem listofArea in Ddl_Area.Items)
    //    {
    //        listofArea.Text = listofArea.Text.ToUpper();
    //    }

    //    con.Open();
    //    int pincode1 = Convert.ToInt32(DDL_PinCode.SelectedItem.ToString());
    //    SqlDataAdapter sqlda1 = new SqlDataAdapter("spAutoState_District_City_OnDeliveryPincode", con);
    //    sqlda1.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sqlda1.SelectCommand.Parameters.AddWithValue("@pincode", pincode1);
    //    SqlDataReader reader = sqlda1.SelectCommand.ExecuteReader();
    //    if (reader.Read())
    //    {
    //        Txt_State.Text = reader["Delivery State"].ToString().ToUpper();
    //        Txt_District.Text = reader["Delivery  District"].ToString().ToUpper();
    //        Txt_City.Text = reader["Delivery City"].ToString().ToUpper();
    //        reader.Close();
    //    }
    //    con.Close();
    //}
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    void displayDataInGridView(string sortExpression = null)
    {
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spViewCompanyDetails", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        if (sortExpression != null)
        {
            DataView dv = dtbl.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            gridViewCompany.DataSource = dv;
            GV_Export.DataSource = dv;
        }
        else
        {
            gridViewCompany.DataSource = dtbl;
            GV_Export.DataSource = dtbl;
        }
        gridViewCompany.DataBind();
        GV_Export.DataBind();
        con.Close();
    }

    public void NonEditableFieldsOfCompany()
    {
        Txt_CompanyName.Enabled = false;
        Txt_OwnerName.Enabled = false;
        Txt_PinCode.Style.Remove("background-color");
        Panel_PinCode.Visible = false;
        //  DDL_PinCode.Attributes.Add("disabled", "disabled");
        Txt_OwnerContactNo.Enabled = false;
        Txt_EmailId.Enabled = false;
        Txt_Taluka.Enabled = false;
        Txt_Area.Style.Remove("background-color");
        Panel_Area.Visible = false;
        // Ddl_Area.Attributes.Add("disabled", "disabled");
        Txt_CompanyAddress.Enabled = false;
        Txt_Remark.Enabled = false;

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
    public void UpdateSubmitStatus()
    {
        con.Open();
        cmd = new SqlCommand("spSetFinalSubmitFalse", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@event", "Company");
        cmd.Parameters.AddWithValue("@employeeNo", "");
        cmd.Parameters.AddWithValue("@branchNo", "");
        cmd.Parameters.AddWithValue("@companyNo", editCompanyNo);
        cmd.Parameters.AddWithValue("@driverNo", "");
        cmd.ExecuteNonQuery();
    }
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {
        if (HiddenField_Tab1Save.Value == "1")
        {
			string CurrentDateTime = cmf.CurrentDateTime();

            globalVar.setCode(Txt_ComapnyCode.Text == "" ? "0" : Txt_ComapnyCode.Text.ToString());
            statusClass.setTab(1);

            if (statusClass.tab == 1)
            {
                if (statusClass.btnSubmit == 0)
                {

                    con.Open();
                    SqlCommand cmd = new SqlCommand("spCreateOrUpdateCompany1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@company", statusClass.Tab1);
                    cmd.Parameters.AddWithValue("@companybool", statusClass.Tab1Status);
                    cmd.Parameters.AddWithValue("@upload", -1);
                    cmd.Parameters.AddWithValue("@uploadbool", -1);

                    cmd.Parameters.AddWithValue("@companyNo", globalVar.code.ToString());
                    cmd.Parameters.AddWithValue("@companyName", Txt_CompanyName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@ownerName", Txt_OwnerName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@ownerContactNo", Txt_OwnerContactNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@emailID", Txt_EmailId.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@pincode", Txt_PinCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@area", Txt_Area.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@city", Txt_City.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@taluka", Txt_Taluka.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@district", Txt_District.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@state", Txt_State.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@companyAddress", Txt_CompanyAddress.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@remark", Txt_Remark.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@employeeNo", Session["employeeNo"].ToString());
                    cmd.Parameters.AddWithValue("@username", Session["username"].ToString());
                    cmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime);
                    cmd.Parameters.AddWithValue("@userBranch", Session["userBranch"].ToString());
                    cmd.Parameters.AddWithValue("@GST_CertificateNo", "");
                    cmd.Parameters.AddWithValue("@cin", "");
                    cmd.Parameters.AddWithValue("@GSTFileName", "");
                    cmd.Parameters.AddWithValue("@CINFileName", "");

                    cmd.ExecuteNonQuery();
                    statusClass.setTab1Status(0);
                    con.Close();
                    NonEditableFieldsOfCompany();
                    DatafillForCompanyViewDetails();
                    displayDataInGridView();

                    string a = "Button_Tab1Save";
                    string b = "SAVE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
                }
                else if (statusClass.btnSubmit == 1)
                {
                    con.Open();
                    statusClass.setTab1Status(1);
                    SqlCommand cmd = new SqlCommand("spCreateOrUpdateCompany1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@company", statusClass.Tab1);
                    cmd.Parameters.AddWithValue("@companybool", statusClass.Tab1Status);
                    cmd.Parameters.AddWithValue("@upload", -1);
                    cmd.Parameters.AddWithValue("@uploadbool", -1);

                    cmd.Parameters.AddWithValue("@companyNo", globalVar.code.ToString());
                    cmd.Parameters.AddWithValue("@companyName", Txt_CompanyName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@ownerName", Txt_OwnerName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@ownerContactNo", Txt_OwnerContactNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@emailID", Txt_EmailId.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@pincode", Txt_PinCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@area", Txt_Area.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@city", Txt_City.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@taluka", Txt_Taluka.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@district", Txt_District.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@state", Txt_State.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@companyAddress", Txt_CompanyAddress.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@remark", Txt_Remark.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@employeeNo", "");
                    cmd.Parameters.AddWithValue("@username", "");
                    cmd.Parameters.AddWithValue("@creationDateTime", "");
                    cmd.Parameters.AddWithValue("@userBranch", "");
                    cmd.Parameters.AddWithValue("@GST_CertificateNo", "");
                    cmd.Parameters.AddWithValue("@cin", "");
                    cmd.Parameters.AddWithValue("@GSTFileName", "");
                    cmd.Parameters.AddWithValue("@CINFileName", "");

                    cmd.ExecuteNonQuery();
                    con.Close();
                    NonEditableFieldsOfCompany();
                    statusClass.setTab1Status(0);
                    statusClass.setBtnSubmit(0);

                    DatafillForCompanyViewDetails();

                    string a = "Button_Tab1Save";
                    string b = "UPDATE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
                }
            }
            // cmd.Parameters.AddWithValue("@bool", Class1.companystatus);
            displayDataInGridView();
            HiddenField_Tab1Save.Value = "";
        }
        
    }

    public void RemoveNonEditableFieldsOfCompany()
    {
        Txt_CompanyName.Enabled = false;
        Txt_OwnerName.Enabled = true;
        Txt_PinCode.Style.Add("background-color", "white");
        Panel_PinCode.Visible = true;
        //  DDL_PinCode.Attributes.Remove("disabled");
        Txt_OwnerContactNo.Enabled = true;
        Txt_EmailId.Enabled = true;
        Txt_Taluka.Enabled = true;
        Txt_Area.Style.Add("background-color", "white");
        Panel_Area.Visible = true;
        Demo_AREA.Visible = true;
        Area.Visible = false;
        //Ddl_Area.Attributes.Remove("disabled");
        Txt_CompanyAddress.Enabled = true;
        Txt_Remark.Enabled = true;

        Button_Tab1Save.Enabled = true;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Remove("opacity");
        Btn_Next.CssClass = "btn btn-info largeButtonStyle next-step";
        Btn_Next.Style.Remove("opacity");
    }

    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        if (HiddenField_Submit1.Value == "1")
        {
            string CGSTFileName;
            string CCINFileName;

            if (fileName1 == null)
            {
                CGSTFileName = "";
            }
            else
            {
                CGSTFileName = fileName1;
            }

            if (fileName2 == null)
            {
                CCINFileName = "";
            }
            else
            {
                CCINFileName = fileName2;
            }
            globalVar.setCode(Txt_ComapnyCode.Text == "" ? "0" : Txt_ComapnyCode.Text.ToString());
            statusClass.setTab(2);

            if (statusClass.tab == 2)
            {
                if (statusClass.btnUpdate == 0)
                {
                    con.Open();

                    cmd = new SqlCommand("spCreateOrUpdateCompany1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@company", -1);
                    cmd.Parameters.AddWithValue("@companybool", -1);
                    cmd.Parameters.AddWithValue("@upload", statusClass.Tab2);
                    cmd.Parameters.AddWithValue("@uploadbool", statusClass.Tab2Status);
                    cmd.Parameters.AddWithValue("@companyNo", globalVar.code.ToString());
                    cmd.Parameters.AddWithValue("@companyName", "");
                    cmd.Parameters.AddWithValue("@ownerName", "");
                    cmd.Parameters.AddWithValue("@ownerContactNo", "");
                    cmd.Parameters.AddWithValue("@emailID", "");
                    cmd.Parameters.AddWithValue("@pincode", "");
                    cmd.Parameters.AddWithValue("@area", "");
                    cmd.Parameters.AddWithValue("@city", "");
                    cmd.Parameters.AddWithValue("@taluka", "");
                    cmd.Parameters.AddWithValue("@district", "");
                    cmd.Parameters.AddWithValue("@state", "");
                    cmd.Parameters.AddWithValue("@companyAddress", "");
                    cmd.Parameters.AddWithValue("@remark", "");
                    cmd.Parameters.AddWithValue("@employeeNo", "");
                    cmd.Parameters.AddWithValue("@username", "");
                    cmd.Parameters.AddWithValue("@creationDateTime", "");
                    cmd.Parameters.AddWithValue("@userBranch", "");
                    cmd.Parameters.AddWithValue("@GST_CertificateNo", Txt_CompanyGSTCertificates.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@cin", Txt_CompanyCIN.Text.Trim().ToString().ToUpper());
                    // cmd.Parameters.AddWithValue("@GSTFileName", Company_GST_Label.Text.Trim().ToString().ToUpper());
                    // cmd.Parameters.AddWithValue("@CINFileName", Company_CIN_Label.Text.Trim().ToString().ToUpper());

                    cmd.Parameters.AddWithValue("@GSTFileName", CGSTFileName);
                    cmd.Parameters.AddWithValue("@CINFileName", CCINFileName);

                    cmd.ExecuteNonQuery();

                    string a = "Button_Submit1";
                    string b = "SAVE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

                    statusClass.setTab2Status(0);
                    con.Close();
                   

                }
                else if (statusClass.btnUpdate == 1)
                {
                    statusClass.setTab2Status(1);
                    con.Open();

                    cmd = new SqlCommand("spCreateOrUpdateCompany1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@company", -1);
                    cmd.Parameters.AddWithValue("@companybool", -1);
                    cmd.Parameters.AddWithValue("@upload", statusClass.Tab2);
                    cmd.Parameters.AddWithValue("@uploadbool", statusClass.Tab2Status);
                    cmd.Parameters.AddWithValue("@companyNo", globalVar.code.ToString());
                    cmd.Parameters.AddWithValue("@companyName", "");
                    cmd.Parameters.AddWithValue("@ownerName", "");
                    cmd.Parameters.AddWithValue("@ownerContactNo", "");
                    cmd.Parameters.AddWithValue("@emailID", "");
                    cmd.Parameters.AddWithValue("@pincode", "");
                    cmd.Parameters.AddWithValue("@area", "");
                    cmd.Parameters.AddWithValue("@city", "");
                    cmd.Parameters.AddWithValue("@taluka", "");
                    cmd.Parameters.AddWithValue("@district", "");
                    cmd.Parameters.AddWithValue("@state", "");
                    cmd.Parameters.AddWithValue("@companyAddress", "");
                    cmd.Parameters.AddWithValue("@remark", "");
                    cmd.Parameters.AddWithValue("@employeeNo", "");
                    cmd.Parameters.AddWithValue("@username", "");
                    cmd.Parameters.AddWithValue("@creationDateTime", "");
                    cmd.Parameters.AddWithValue("@userBranch", "");
                    cmd.Parameters.AddWithValue("@GST_CertificateNo", Txt_CompanyGSTCertificates.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@cin", Txt_CompanyCIN.Text.Trim().ToString().ToUpper());
                    //  cmd.Parameters.AddWithValue("@GSTFileName", Company_GST_Label.Text.Trim().ToString().ToUpper());
                    //   cmd.Parameters.AddWithValue("@CINFileName", Company_CIN_Label.Text.Trim().ToString().ToUpper());

                    cmd.Parameters.AddWithValue("@GSTFileName", CGSTFileName);
                    cmd.Parameters.AddWithValue("@CINFileName", CCINFileName);
                    cmd.ExecuteNonQuery();

                    string a = "Button_Submit1";
                    string b = "UPDATE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

                    con.Close();
                   
                    statusClass.setTab2Status(0);
                    statusClass.setBtnSubmit1(0);
                   
                }
            }
            RemoveNonEditableFieldsOfCompany();
            DatafillForCompanyViewDetails();
            displayDataInGridView();
            clearAll();
           
            HiddenField_Submit1.Value = "";
        }
        

    }

    protected void editCompanyDetails_Click(object sender, EventArgs e)
    {
        
        Demo_AREA.Visible = false;
        Area.Visible = true;

        statusClass.setTab1Status(1);
        statusClass.setTab2Status(1);
        fillDeliveryPincode();
        string companyno = (sender as LinkButton).CommandArgument;
        editCompanyNo = companyno;


        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spEditCompany", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@companyNo", companyno);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        con.Close();
        //Ddl_Area.Items.Clear();

        Txt_CompanyName.Enabled = false;
        // hfBranchID.Value = companyno.ToString();
        Txt_ComapnyCode.Text = dtbl.Rows[0]["companyNo"].ToString();
        Txt_CompanyName.Text = dtbl.Rows[0]["companyName"].ToString();
        Txt_OwnerName.Text = dtbl.Rows[0]["ownerName"].ToString();
        Txt_OwnerContactNo.Text = dtbl.Rows[0]["ownerContactNo"].ToString();
        Txt_EmailId.Text = dtbl.Rows[0]["emailID"].ToString();

        //if(DDL_PinCode.Items.FindByValue(dtbl.Rows[0]["pincode"].ToString())!=null)
        //{
        //    DDL_PinCode.Items.FindByValue(dtbl.Rows[0]["pincode"].ToString()).Selected = true;
        //    FillArea();
        //}
        Txt_PinCode.Text = dtbl.Rows[0]["pincode"].ToString();
        foreach (ListItem list in RadioButtonList_PinCode.Items)
        {
            list.Text = list.Text.ToUpper();
            if (list.Text == dtbl.Rows[0]["pincode"].ToString())
            {
                list.Selected = true;
                Txt_PinCode.Text = list.Text;
                break;
            }
        }
        FillArea();
        //if (RadioButtonList_PinCode.Items.FindByValue(dtbl.Rows[0]["pincode"].ToString())!=null)
        //{
        //    Txt_PinCode.Text = dtbl.Rows[0]["pincode"].ToString();

        //    FillArea();
        //}
        Txt_Area.Text = dtbl.Rows[0]["area"].ToString();
        foreach (ListItem list in RadioButtonList_Area.Items)
        {
            list.Text = list.Text.ToUpper();
            if (list.Text == dtbl.Rows[0]["area"].ToString())
            {
                list.Selected = true;
                Txt_Area.Text = list.Text;
                break;
            }
        }
        //Ddl_Area.Items.Insert(0, dtbl.Rows[0]["area"].ToString());
        Txt_City.Text = dtbl.Rows[0]["city"].ToString();
        Txt_Taluka.Text = dtbl.Rows[0]["taluka"].ToString();
        Txt_District.Text = dtbl.Rows[0]["district"].ToString();
        Txt_State.Text = dtbl.Rows[0]["state"].ToString();
        Txt_CompanyAddress.Text = dtbl.Rows[0]["companyAddress"].ToString();
        Txt_Remark.Text = dtbl.Rows[0]["remark"].ToString();
        Txt_CompanyGSTCertificates.Text = dtbl.Rows[0]["GST_CertificateNo"].ToString();
        Txt_CompanyCIN.Text = dtbl.Rows[0]["cin"].ToString();

        //      Company_GST_Label .Text = dtbl.Rows[0]["GSTFileName"].ToString();
        Company_GST_Label.InnerHtml = dtbl.Rows[0]["GSTFileName"].ToString();
        Company_GST_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["GSTFileName"].ToString());
        //      Company_CIN_Label.Text = dtbl.Rows[0]["CINFileName"].ToString();
        Company_CIN_Label.InnerHtml = dtbl.Rows[0]["CINFileName"].ToString();
        Company_CIN_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["CINFileName"].ToString());



        Btn_Reset.Enabled = false;
        Btn_Reset.Style.Add("opacity", "0.3");
        Btn_DocReset.Enabled = false;
        Btn_DocReset.Style.Add("opacity", "0.3");
        Button_Tab1Save.Text = "UPDATE <i class='fa fa-save'></i>";
        UpdateSubmitStatus();
        statusClass.setBtnSubmit(1);
        statusClass.setBtnSubmit1(1);
        RemoveNonEditableFieldsOfCompany();

        Demo_AREA.Visible = false;
        Area.Visible = true;
    }

    protected void Delete_Data1_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        //getting particular row linkbutton
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;

        int companyid = Convert.ToInt32(gridViewCompany.DataKeys[gvrow.RowIndex].Value.ToString());
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Update tblCompanyCreation set setDelete='TRUE' where companyID=" + companyid, con);
            cmd.ExecuteNonQuery();
            DatafillForCompanyViewDetails();
            con.Close();

            string a = "Delete_Data1";
            string b = "DELETE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
        DatafillForCompanyViewDetails();
        displayDataInGridView();
    }

    public void DatafillForCompanyViewDetails()
    {
        SqlCommand cmd_cname = new SqlCommand("Select companyName from tblCompanyCreation where setDelete='FALSE'", con);
        con.Open();
        RadioButtonList_SearchCompanyName.DataSource = cmd_cname.ExecuteReader();
        RadioButtonList_SearchCompanyName.DataTextField = "companyName";
        RadioButtonList_SearchCompanyName.DataBind();
        RadioButtonList_SearchCompanyName.Items.Insert(0, "SELECT");
        foreach (ListItem listofcompany in RadioButtonList_SearchCompanyName.Items)
        {
            listofcompany.Text = listofcompany.Text.ToUpper();
        }
        Txt_SearchCompanyName.Text = "SELECT";
        Txt_SearchCompanyName_Search.Text = "";
        RadioButtonList_SearchCompanyName.SelectedIndex = 0;
        con.Close();

        SqlCommand cmd_state = new SqlCommand("Select distinct state from tblCompanyCreation where setDelete='FALSE'", con);
        con.Open();
        RadioButtonList_SearchState.DataSource = cmd_state.ExecuteReader();
        RadioButtonList_SearchState.DataTextField = "state";
        RadioButtonList_SearchState.DataBind();
        RadioButtonList_SearchState.Items.Insert(0, "SELECT");
        foreach (ListItem listofstate in RadioButtonList_SearchState.Items)
        {
            listofstate.Text = listofstate.Text.ToUpper();
        }
        Txt_SearchState.Text = "SELECT";
        Txt_SearchState_Search.Text = "";
        RadioButtonList_SearchState.SelectedIndex = 0;
        con.Close();

        SqlCommand cmd_city = new SqlCommand("Select distinct city from tblCompanyCreation where setDelete='FALSE'", con);
        con.Open();
        RadioButtonList_SearchCity.DataSource = cmd_city.ExecuteReader();
        RadioButtonList_SearchCity.DataTextField = "city";
        RadioButtonList_SearchCity.DataBind();
        RadioButtonList_SearchCity.Items.Insert(0, "SELECT");
        foreach (ListItem listofcity in RadioButtonList_SearchCity.Items)
        {
            listofcity.Text = listofcity.Text.ToUpper();
        }
        Txt_SearchCity.Text = "SELECT";
        Txt_SearchCity_Search.Text = "";
        RadioButtonList_SearchCity.SelectedIndex = 0;
        con.Close();

        // RadioButtonList_Area.SelectedIndex = 0;

    }

    protected void Txt_SearchCompanyName_Search_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_SearchCompanyName_Search.Value == "1")
        {
            if (Txt_SearchCompanyName_Search.Text != "")
            {
                string search = Txt_SearchCompanyName_Search.Text;
                string searchTxt = "SELECT companyName FROM tblCompanyCreation WHERE companyName LIKE '%" + search + "%' AND setDelete='FALSE'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_SearchCompanyName.DataSource = dt;
                RadioButtonList_SearchCompanyName.DataTextField = "companyName";
                RadioButtonList_SearchCompanyName.DataValueField = "companyName";
                RadioButtonList_SearchCompanyName.DataBind();
                RadioButtonList_SearchCompanyName.Items.Insert(0, "SELECT");
                foreach (ListItem listofcompany in RadioButtonList_SearchCompanyName.Items)
                {
                    listofcompany.Text = listofcompany.Text.ToUpper();
                }
                Txt_SearchCompanyName_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_SearchCompanyName.Items.Count; i++)
                {
                    if (Txt_SearchCompanyName.Text == RadioButtonList_SearchCompanyName.Items[i].Text)
                    {
                        RadioButtonList_SearchCompanyName.Items[i].Selected = true;
						break;
                    }
                }
            }

            else if (Txt_SearchCompanyName_Search.Text == "")
            {

                string searchTxt = "SELECT companyName FROM tblCompanyCreation WHERE setDelete='FALSE'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                RadioButtonList_SearchCompanyName.DataSource = dt;
                RadioButtonList_SearchCompanyName.DataTextField = "companyName";
                RadioButtonList_SearchCompanyName.DataValueField = "companyName";
                RadioButtonList_SearchCompanyName.DataBind();
                RadioButtonList_SearchCompanyName.Items.Insert(0, "SELECT");
                foreach (ListItem listofcompany in RadioButtonList_SearchCompanyName.Items)
                {
                    listofcompany.Text = listofcompany.Text.ToUpper();
                }
                Txt_SearchCompanyName_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_SearchCompanyName.Items.Count; i++)
                {
                    if (Txt_SearchCompanyName.Text == RadioButtonList_SearchCompanyName.Items[i].Text)
                    {
                        RadioButtonList_SearchCompanyName.Items[i].Selected = true;
						break;														  
                    }
                }
            }
            HiddenField_SearchCompanyName_Search.Value = "";
        }

        
    }

    protected void RadioButtonList_SearchCompanyName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (HiddenField_SearchCompanyName.Value == "1")
        {
            for (int i = 0; i < RadioButtonList_SearchCompanyName.Items.Count; i++)
            {
                if (RadioButtonList_SearchCompanyName.Items[i].Selected)
                {
                    Txt_SearchCompanyName.Text = RadioButtonList_SearchCompanyName.Items[i].Text;

                    if (Txt_SearchCompanyName.Text.ToString() == "SELECT")
                    {
                        Txt_SearchCompanyName.Focus();
                    }
                    else
                    {
                        Txt_SearchState.Focus();
                    }

                }

            }
            PopupControlExtender_SearchCompanyName.Commit(RadioButtonList_SearchCompanyName.SelectedValue);
            HiddenField_SearchCompanyName.Value = "";
        }
        
    }

    protected void Txt_SearchState_Search_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_SearchState_Search.Value == "1")
        {
            if (Txt_SearchState_Search.Text != "")
            {
                string search = Txt_SearchState_Search.Text;
                string searchTxt = "SELECT distinct state FROM tblCompanyCreation WHERE state LIKE '%" + search + "%' AND setDelete='FALSE'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_SearchState.DataSource = dt;
                RadioButtonList_SearchState.DataTextField = "state";
                RadioButtonList_SearchState.DataValueField = "state";
                RadioButtonList_SearchState.DataBind();
                RadioButtonList_SearchState.Items.Insert(0, "SELECT");
                foreach (ListItem listofstate in RadioButtonList_SearchState.Items)
                {
                    listofstate.Text = listofstate.Text.ToUpper();
                }
                Txt_SearchState_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_SearchState.Items.Count; i++)
                {
                    if (Txt_SearchState.Text == RadioButtonList_SearchState.Items[i].Text)
                    {
                        RadioButtonList_SearchState.Items[i].Selected = true;
						break;													
                    }
                }
            }

            else if (Txt_SearchState_Search.Text == "")
            {

                string searchTxt = "SELECT distinct state FROM tblCompanyCreation WHERE setDelete='FALSE'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                RadioButtonList_SearchState.DataSource = dt;
                RadioButtonList_SearchState.DataTextField = "state";
                RadioButtonList_SearchState.DataValueField = "state";
                RadioButtonList_SearchState.DataBind();
                RadioButtonList_SearchState.Items.Insert(0, "SELECT");
                foreach (ListItem listofstate in RadioButtonList_SearchState.Items)
                {
                    listofstate.Text = listofstate.Text.ToUpper();
                }
                Txt_SearchState_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_SearchState.Items.Count; i++)
                {
                    if (Txt_SearchState.Text == RadioButtonList_SearchState.Items[i].Text)
                    {
                        RadioButtonList_SearchState.Items[i].Selected = true;
						break;
                    }
                }
            }
            HiddenField_SearchState_Search.Value = "";
        }
        
    }

    protected void RadioButtonList_SearchState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (HiddenField_SearchState.Value == "1")
        {
            for (int i = 0; i < RadioButtonList_SearchState.Items.Count; i++)
            {
                if (RadioButtonList_SearchState.Items[i].Selected)
                {
                    Txt_SearchState.Text = RadioButtonList_SearchState.Items[i].Text;

                    if (Txt_SearchState.Text.ToString() == "SELECT")
                    {
                        Txt_SearchState.Focus();
                    }
                    else
                    {
                        Txt_SearchCity.Focus();
                    }

                }

            }


            PopupControlExtender_SearchState.Commit(RadioButtonList_SearchState.SelectedValue);
            HiddenField_SearchState.Value = "";
        }
       
    }

    protected void Txt_SearchCity_Search_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_SearchCity_Search.Value == "1")
        {
            if (Txt_SearchCity_Search.Text != "")
            {
                string search = Txt_SearchCity_Search.Text;
                string searchTxt = "SELECT distinct city FROM tblCompanyCreation WHERE city LIKE '%" + search + "%' AND setDelete='FALSE'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);

                RadioButtonList_SearchCity.DataSource = dt;
                RadioButtonList_SearchCity.DataTextField = "city";
                RadioButtonList_SearchCity.DataValueField = "city";
                RadioButtonList_SearchCity.DataBind();
                RadioButtonList_SearchCity.Items.Insert(0, "SELECT");
                foreach (ListItem listofcity in RadioButtonList_SearchCity.Items)
                {
                    listofcity.Text = listofcity.Text.ToUpper();
                }
                Txt_SearchCity_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_SearchCity.Items.Count; i++)
                {
                    if (Txt_SearchCity.Text == RadioButtonList_SearchCity.Items[i].Text)
                    {
                        RadioButtonList_SearchCity.Items[i].Selected = true;
						break;
                    }
                }
            }

            else if (Txt_SearchState_Search.Text == "")
            {

                string searchTxt = "SELECT distinct city FROM tblCompanyCreation WHERE setDelete='FALSE'";

                con.Open();
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                RadioButtonList_SearchCity.DataSource = dt;
                RadioButtonList_SearchCity.DataTextField = "city";
                RadioButtonList_SearchCity.DataValueField = "city";
                RadioButtonList_SearchCity.DataBind();
                RadioButtonList_SearchCity.Items.Insert(0, "SELECT");
                foreach (ListItem listofcity in RadioButtonList_SearchCity.Items)
                {
                    listofcity.Text = listofcity.Text.ToUpper();
                }
                Txt_SearchCity_Search.Focus();
                con.Close();

                for (int i = 0; i < RadioButtonList_SearchCity.Items.Count; i++)
                {
                    if (Txt_SearchCity.Text == RadioButtonList_SearchCity.Items[i].Text)
                    {
                        RadioButtonList_SearchCity.Items[i].Selected = true;
						break;												   
                    }
                }
            }
            HiddenField_SearchCity_Search.Value = "";
        }
        
    }

    protected void RadioButtonList_SearchCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (HiddenField_SearchCity.Value == "1")
        {
            for (int i = 0; i < RadioButtonList_SearchCity.Items.Count; i++)
            {
                if (RadioButtonList_SearchCity.Items[i].Selected)
                {
                    Txt_SearchCity.Text = RadioButtonList_SearchCity.Items[i].Text;

                    if (Txt_SearchCity.Text.ToString() == "SELECT")
                    {
                        Txt_SearchCity.Focus();
                    }
                    else
                    {
                        Btn_Search.Focus();
                    }
                }

            }


            PopupControlExtender_SearchCity.Commit(RadioButtonList_SearchCity.SelectedValue);
            HiddenField_SearchCity.Value = "";
        }
        
    }
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Search.Value == "1")
        {
            Search_CompanyDetails_View.Visible = true;

            SearchData();
            HiddenField_Search.Value = "";
        }
        
    }

    public void SearchData()
    {
        String compname = Txt_SearchCompanyName.Text.ToString().Trim();
        String strState = Txt_SearchState.Text.ToString().Trim();
        String strCity = Txt_SearchCity.Text.ToString().Trim();

        if ((Txt_SearchCompanyName.Text.ToString() != "SELECT") || (Txt_SearchState.Text.ToString() != "SELECT") || (Txt_SearchCity.Text.ToString() != "SELECT"))
        {
            string str = "Select * from tblCompanyCreation where (setDelete='FALSE') AND (companyName like '%" + compname + "%' OR state like '%" + strState + "%' OR city like '%" + strCity + "%')";
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            cmd.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds);
            gridViewCompany.DataSource = ds;
            GV_Export.DataSource = ds;

            gridViewCompany.DataBind();
            GV_Export.DataBind();
            con.Close();

        }
        else
        {
            displayDataInGridView();
        }
    }

    protected void Btn_SubmitArea_Click(object sender, EventArgs e)
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("spInsertArea", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@area", Txt_AreaNamePopup.Text.Trim().ToUpper());
        cmd.Parameters.AddWithValue("@pincode", Txt_PinCode.Text.Trim());
        int k = cmd.ExecuteNonQuery();
        if (k != 0)
        {
            lblmsg.Text = "Record Inserted Succesfully into the Database";
            lblmsg.ForeColor = System.Drawing.Color.CornflowerBlue;
        }
        con.Close();
        Txt_AreaNamePopup.Text = "";
        lblmsg.Text = "";

        FillArea();
    }



    protected void gridViewCompany_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewCompany.PageIndex = e.NewPageIndex;
        SearchData();
    }

    protected void gridViewCompany_Sorting(object sender, GridViewSortEventArgs e)
    {
        displayDataInGridView(e.SortExpression);
    }

    #region    Single Selection DropDown




    //protected void Txt_SingleDropDown_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (Txt_SingleDropDown_Search.Text != "")
    //    {
    //        string search = Txt_SingleDropDown_Search.Text;
    //        string searchTxt = "SELECT DISTINCT [Delivery Pincode] " + "FROM tblERPDataFile " + "WHERE [Delivery Pincode] LIKE '" + search + "%' ";

    //        con.Open();
    //        SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //        sqlda.SelectCommand.CommandType = CommandType.Text;
    //        DataTable dt = new DataTable();
    //        sqlda.Fill(dt);

    //        RadioButtonList_SingleDropDown.DataSource = dt;
    //        RadioButtonList_SingleDropDown.DataTextField = "Delivery Pincode";
    //        RadioButtonList_SingleDropDown.DataValueField = "Delivery Pincode";
    //        RadioButtonList_SingleDropDown.DataBind();
    //        Txt_SingleDropDown_Search.Focus();
    //    }

    //    else if (Txt_SingleDropDown_Search.Text == "")
    //    {
    //        //string search = TextBox2.Text;
    //        string searchTxt = "SELECT DISTINCT [Delivery Pincode] " + "FROM tblERPDataFile ";


    //        con.Open();
    //        SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //        sqlda.SelectCommand.CommandType = CommandType.Text;
    //        DataTable dt = new DataTable();
    //        sqlda.Fill(dt);


    //        RadioButtonList_SingleDropDown.DataSource = dt;
    //        RadioButtonList_SingleDropDown.DataTextField = "Delivery Pincode";
    //        RadioButtonList_SingleDropDown.DataValueField = "Delivery Pincode";
    //        RadioButtonList_SingleDropDown.DataBind();
    //        Txt_SingleDropDown_Search.Focus();
    //    }
    //}

    //protected void RadioButtonList_SingleDropDown_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    string name = "";
    //    int c = 0;
    //    for (int i = 0; i < RadioButtonList_SingleDropDown.Items.Count; i++)
    //    {
    //        if (RadioButtonList_SingleDropDown.Items[i].Selected)
    //        {
    //            c++;
    //        }
    //    }

    //    for (int i = 0; i < RadioButtonList_SingleDropDown.Items.Count; i++)
    //    {
    //        if (RadioButtonList_SingleDropDown.Items[i].Selected)
    //        {
    //            name += RadioButtonList_SingleDropDown.Items[i].Text;
    //        }
    //    }
    //    Txt_SingleDropDown.Text = name;
    //}


    //protected void LinkButton_Single_DropDown_Reset_Click(object sender, EventArgs e)
    //{
    //    Txt_SingleDropDown.Text = "";
    //    Txt_SingleDropDown_Search.Text = "";
    //    RadioButtonList_SingleDropDown.ClearSelection();



    //    string searchTxt = "SELECT DISTINCT [Delivery Pincode] " + "FROM tblERPDataFile ";


    //    con.Open();
    //    SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //    sqlda.SelectCommand.CommandType = CommandType.Text;
    //    DataTable dt = new DataTable();
    //    sqlda.Fill(dt);


    //    RadioButtonList_SingleDropDown.DataSource = dt;
    //    RadioButtonList_SingleDropDown.DataTextField = "Delivery Pincode";
    //    RadioButtonList_SingleDropDown.DataValueField = "Delivery Pincode";
    //    RadioButtonList_SingleDropDown.DataBind();
    //    Txt_SingleDropDown_Search.Focus();

    //}



    #endregion



    /* Ajax File Upload Start*/
    protected void Company_GST_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Company_GST_Uploader.SaveAs(fileNameToUpload);
        fileName1 = e.FileName.ToString();
    }

    protected void Company_CIN_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Company_CIN_Uploader.SaveAs(fileNameToUpload);
        fileName2 = e.FileName.ToString();
    }

    /* Ajax File Upload End*/




    /* Export To Excel Start */
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btn_ExporttoExcel_Click(object sender, EventArgs e)
    {
       // if (HiddenField_ExporttoExcel.Value=="1")
        {
          string CurrentDateTime=cmf.CurrentDateTime();
            GV_Export.Visible = true;
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "Company_Creation" + CurrentDateTime + ".xls";
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

           // HiddenField_ExporttoExcel.Value = "";


        }
        
    }
    /* Export To Excel End */
}