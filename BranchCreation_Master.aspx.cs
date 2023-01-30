using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using BLFunctions;
using NameSpaceConnection;
public partial class OPERATIONS_BranchCreation : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    CFunctions cmf = new CFunctions();
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    string strcmd = string.Empty;
    static String fileName1;
    static String fileName2;
    string result;
    public static string editBranchNo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                Txt_BranchName.Focus();

                //(IAttributeAccessor)FindControlRecursive(this.Page, $Txt_PinCode)).SetAttribute("onblur", "onPopupLostFocus();");
                GetBranchList();
                CFunctions.setTab(1);
                CFunctions.setTabStatus(0);
                Btn_Next.Enabled = false;
                Btn_Next.Style.Add("color", "white");
                Btn_Next.Style.Add("opacity", "0.3");
                Search_BranchDetails_View.Visible = false;
                //  displayDataInGridView();
                cmf.dropdwnlist(null, null, Ddl_SearchBranch, null, "branchName", "branchID", (new CommFunctions().GetBranch()));
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        string str = "if ($(\"[id$=Ddl_BContractType]\").children(\"option:selected\").val() != 'PURCHASE'){" +
                    "$(\"[id$=purchasedate]\").hide();" +
                    "$(\"[id$=validfrom]\").show();" +
                    "$(\"[id$=validto]\").show();}" +
                    "else {$(\"[id$=purchasedate]\").show();" +
                    "$(\"[id$=validfrom]\").hide();" +
                    "$(\"[id$=validto]\").hide();};";
        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascriptFunction(this, "Txt_Pincode", "hfPincode", "~/Party_CustomerCreation.aspx/getPincode", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);

    }

    public void GetBranchList()
    {
        Ddl_ControllingBranchName.DataSource = (new CommFunctions()).GetBranch();
        Ddl_ControllingBranchName.DataTextField = "branchName";
        Ddl_ControllingBranchName.DataValueField = "branchId";
        Ddl_ControllingBranchName.DataBind();
        Ddl_ControllingBranchName.Items.Insert(0, "SELECT");
    }
    protected void Ddl_ContractType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (HiddenField_Ddl_BContractType.Value == "1")
        {
            if (Ddl_BContractType.SelectedItem.Text == "SELECT")
            {
                Ddl_BContractType.Focus();
                purchasedate.Visible = false;
                validfrom.Visible = false;
                validto.Visible = false;

            }
            else if (Ddl_BContractType.SelectedItem.Text == "LEASE")
            {
                Txt_BValidFrom.Focus();
                validfrom.Visible = true;
                validto.Visible = true;
                purchasedate.Visible = false;
            }
            else
            {
                Txt_BPurchaseDate.Focus();
                validfrom.Visible = false;
                validto.Visible = false;
                purchasedate.Visible = true;
            }

            HiddenField_Ddl_BContractType.Value = "";
        }
    }

    protected void Branch_Reset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Branch_Reset.Value == "1")
        {
            Response.Redirect(Request.Url.AbsoluteUri);

            HiddenField_Branch_Reset.Value = "";
        }
    }
    public void clearAll()
    {
        Ddl_Type.SelectedIndex = 2;
        Txt_BranchName.Text = "";
        Txt_BranchName.Enabled = true;
        Txt_Pincode.Text = "";
        hfPincode.Value = "";
        Txt_State.Text = "AUTO";
        Txt_District.Text = "AUTO";
        Txt_City.Text = "AUTO";
        Ddl_Area.SelectedIndex = 0;
        hfArea.Value = "";
        Txt_BAddress.Text = "";
        Txt_BLandmark.Text = "";
        Ddl_BContractType.SelectedIndex = 2;
        Txt_BPurchaseDate.Text = "";
        Txt_BValidFrom.Text = "";
        Txt_BValidTo.Text = "";
        Txt_BContractNo.Text = "";
        Txt_BOwnerName.Text = "";
        Txt_BOwnerContactNo.Text = "";
        Txt_BOwnerEmailId.Text = "";
        Ddl_ControllingBranchName.SelectedIndex = 0;
        Txt_BuildUp.Text = "";
        Txt_Carpet.Text = "";
        Ddl_UnderESIC.SelectedIndex = 0;
        Ddl_CoveredLabourLaw.SelectedIndex = 0;
        Ddl_Cataegory.SelectedIndex = 0;
        Txt_BranchPanCardNo.Text = "";
        BranchPanCard_Label.InnerHtml = "";
        Txt_BranchLineAdharcardNo.Text = "";
        BranchLineAdharCard_Label.InnerHtml = "";

        Button_Tab1Save.Text = "SAVE <i class='fa fa-save'></i>";

        Btn_Next.Enabled = false;
        Btn_Next.Style.Add("color", "white");
        Btn_Next.Style.Add("opacity", "0.3");

        Branch_Reset.Enabled = true;
        Branch_Reset.CssClass = "btn btn-info largeButtonStyle";
        Branch_Reset.Style.Add("color", "white");
        Branch_Reset.Style.Remove("opacity");

        Btn_DocReset.Enabled = true;
        Btn_DocReset.CssClass = "btn btn-info largeButtonStyle";
        Btn_DocReset.Style.Add("color", "white");
        Btn_DocReset.Style.Remove("opacity");

        Search_BranchDetails_View.Visible = false;
        Txt_BranchName.Focus();

        // Response.Redirect(Request.Url.AbsoluteUri);
    }
    protected void Btn_DocReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_DocReset.Value == "1")
        {
            Txt_BranchPanCardNo.Text = "";
            BranchPanCard_Label.InnerHtml = "";

            Txt_BranchLineAdharcardNo.Text = "";
            BranchLineAdharCard_Label.InnerHtml = "";

            HiddenField_Btn_DocReset.Value = "";
        }
    }
    protected void Ddl_Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (HiddenField_Ddl_Type.Value == "1")
        {
            if (Ddl_Type.SelectedItem.ToString() == "CONTROLLING BRANCH" || Ddl_Type.SelectedItem.ToString() == "HEAD OFFICE")
            {
                ControllingBranch.Visible = false;
            }
            else
            {
                ControllingBranch.Visible = true;
            }

            HiddenField_Ddl_Type.Value = "";
        }
    }
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    void displayDataInGridView(string sortExpression = null)
    {
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewBranchCreation", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        if (sortExpression != null)
        {
            DataView dv = dtbl.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            gridViewBranch.DataSource = dv;
            GV_Export.DataSource = dv;
        }
        else
        {
            gridViewBranch.DataSource = dtbl;
            GV_Export.DataSource = dtbl;
        }

        gridViewBranch.DataBind();
        GV_Export.DataBind();
        con.Close();
    }
    public void NonEditableFieldsOfBranch()
    {
        Txt_BranchName.Enabled = false;
        Ddl_Type.Attributes.Add("disabled", "disabled");
        if (Ddl_Type.SelectedItem.ToString() == "CONTROLLING BRANCH" || Ddl_Type.SelectedItem.ToString() == "HEAD OFFICE")
        {
            ControllingBranch.Visible = false;
        }
        else
        {
            Ddl_ControllingBranchName.Enabled = false;
        }
        Txt_Pincode.Enabled = false;
        Ddl_Area.Enabled = false;
        Txt_BAddress.Enabled = false;
        Txt_BLandmark.Enabled = false;
        Ddl_BContractType.Attributes.Add("disabled", "disabled");
        if (Ddl_Type.SelectedItem.ToString() == "LEASE")
        {
            Txt_BValidFrom.Enabled = false;
            Txt_BValidTo.Enabled = false;
        }
        else
        {
            Txt_BPurchaseDate.Enabled = false;
        }

        Txt_BContractNo.Enabled = false;
        Txt_BOwnerName.Enabled = false;
        Txt_BOwnerContactNo.Enabled = false;
        Txt_BOwnerEmailId.Enabled = false;

        Txt_BuildUp.Enabled = false;
        Txt_Carpet.Enabled = false;
        Ddl_UnderESIC.Attributes.Add("disabled", "disabled");

        Ddl_CoveredLabourLaw.Attributes.Add("disabled", "disabled");
        Ddl_Cataegory.Attributes.Add("disabled", "disabled");

        Button_Tab1Save.Enabled = false;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Add("opacity", "0.3");
        Branch_Reset.Enabled = false;
        Branch_Reset.Style.Add("color", "white");
        Branch_Reset.Style.Add("opacity", "0.3");
        Btn_Next.CssClass = "btn btn-info largeButtonStyle next-step";
        Btn_Next.Style.Remove("opacity");
    }



    /*From Date less than To Date*/

    protected void Txt_BValidTo_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_BValidTo.Value == "1")
        {
            int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

            String FromDate = Txt_BValidFrom.Text.Trim();
            string[] splitDate = FromDate.Split('-');
            String ToDate = Txt_BValidTo.Text.Trim();
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
                        Txt_BContractNo.Focus();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                        Txt_BValidTo.Text = "";
                        Txt_BValidTo.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                    Txt_BValidTo.Text = "";
                    Txt_BValidTo.Focus();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                Txt_BValidTo.Text = "";
                Txt_BValidTo.Focus();
            }
            HiddenField_Txt_BValidTo.Value = "";
        }
    }

    protected void Txt_Carpet_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_Carpet.Value == "1")
        {
            if (Convert.ToInt32(Txt_Carpet.Text) < Convert.ToInt32(Txt_BuildUp.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter The Carpet Area Value Greater Than Build Up Value');", true);
                Txt_Carpet.Text = "";
                Txt_Carpet.Focus();
            }
            else
            {
                Ddl_UnderESIC.Focus();
            }

            HiddenField_Txt_Carpet.Value = "";
        }
    }


    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {

        string CurrentDateTime = cmf.CurrentDateTime();

        if (CFunctions.tab == 1)
        {
            if (CFunctions.tabstatus == 0)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateBranch", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@branchTab", CFunctions.tab);
                cmd.Parameters.AddWithValue("@branchcheck", CFunctions.tabstatus);
                cmd.Parameters.AddWithValue("@branchId", "");
                cmd.Parameters.AddWithValue("@branchType", Ddl_Type.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@branchName", Txt_BranchName.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@locId", hfPincode.Value);
                cmd.Parameters.AddWithValue("@areaID", hfArea.Value.ToString());
                cmd.Parameters.AddWithValue("@address", Txt_BAddress.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@landMark", Txt_BLandmark.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@contractType", Ddl_BContractType.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@purchaseDate", Txt_BPurchaseDate.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@validFromDate", Txt_BValidFrom.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@validToDate", Txt_BValidTo.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@propertyContractNo", Txt_BContractNo.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@propertyOwnerName", Txt_BOwnerName.Text.Trim().ToString().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@propertyOwnerContactNo", Txt_BOwnerContactNo.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@propertyOwnerEmailID", Txt_BOwnerEmailId.Text.Trim().ToString());
                if (Ddl_Type.SelectedItem.ToString() == "CONTROLLING BRANCH" || Ddl_Type.SelectedItem.ToString() == "HEAD OFFICE")
                {
                    cmd.Parameters.AddWithValue("@controllingBranchID", 0);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@controllingBranchID", Ddl_ControllingBranchName.SelectedValue.ToString());
                }

                cmd.Parameters.AddWithValue("@buildUP", Txt_BuildUp.Text.Trim());
                cmd.Parameters.AddWithValue("@carpet", Txt_Carpet.Text.Trim());
                cmd.Parameters.AddWithValue("@areaCoveredUnderESIC", Ddl_UnderESIC.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@areaCoveredUnderLabourLaw", Ddl_CoveredLabourLaw.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@areaCategory", Ddl_Cataegory.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@userId", Session["userId"].ToString());
                cmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime);
                cmd.Parameters.AddWithValue("@panCardNo", "");
                cmd.Parameters.AddWithValue("@aadharCardNo", "");
                cmd.Parameters.AddWithValue("@panCardFileName", "");
                cmd.Parameters.AddWithValue("@aadharCardFileName", "");
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read())
                {
                    CFunctions.setID(Convert.ToInt32(rd["Id"]));
                }
                con.Close();

                string a = "Button_Tab1Save";
                string b = "SAVE";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

                Btn_Next.Focus();

            }
            else if (CFunctions.tabstatus == 1)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateBranch", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@branchTab", CFunctions.tab);
                cmd.Parameters.AddWithValue("@branchcheck", CFunctions.tabstatus);
                cmd.Parameters.AddWithValue("@branchId", CFunctions.ID);
                cmd.Parameters.AddWithValue("@branchType", Ddl_Type.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@branchName", Txt_BranchName.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@locId", hfPincode.Value);
                cmd.Parameters.AddWithValue("@areaID", hfArea.Value.ToString());
                cmd.Parameters.AddWithValue("@address", Txt_BAddress.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@landMark", Txt_BLandmark.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@contractType", Ddl_BContractType.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@purchaseDate", Txt_BPurchaseDate.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@validFromDate", Txt_BValidFrom.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@validToDate", Txt_BValidTo.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@propertyContractNo", Txt_BContractNo.Text.Trim().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@propertyOwnerName", Txt_BOwnerName.Text.Trim().ToString().ToString().ToUpper());
                cmd.Parameters.AddWithValue("@propertyOwnerContactNo", Txt_BOwnerContactNo.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@propertyOwnerEmailID", Txt_BOwnerEmailId.Text.Trim().ToString());

                if (Ddl_Type.SelectedItem.ToString() == "CONTROLLING BRANCH" || Ddl_Type.SelectedItem.ToString() == "HEAD OFFICE")
                {
                    cmd.Parameters.AddWithValue("@controllingBranchID", 0);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@controllingBranchID", Ddl_ControllingBranchName.SelectedValue.ToString());
                }

                cmd.Parameters.AddWithValue("@buildUP", Txt_BuildUp.Text.Trim());
                cmd.Parameters.AddWithValue("@carpet", Txt_Carpet.Text.Trim());
                cmd.Parameters.AddWithValue("@areaCoveredUnderESIC", Ddl_UnderESIC.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@areaCoveredUnderLabourLaw", Ddl_CoveredLabourLaw.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@areaCategory", Ddl_Cataegory.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@userId", "");
                cmd.Parameters.AddWithValue("@creationDateTime", "");
                cmd.Parameters.AddWithValue("@panCardNo", "");
                cmd.Parameters.AddWithValue("@aadharCardNo", "");
                cmd.Parameters.AddWithValue("@panCardFileName", "");
                cmd.Parameters.AddWithValue("@aadharCardFileName", "");
                cmd.ExecuteNonQuery();
                con.Close();
                string a = "Button_Tab1Save";
                string b = "UPDATE";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

            }

            NonEditableFieldsOfBranch();
            displayDataInGridView();
        }


    }
    public void RemoveNonEditableFieldsOfBranch()
    {
        Txt_BranchName.Enabled = false;
        Ddl_Type.Attributes.Remove("disabled");
        Txt_Pincode.Enabled = true;
        Ddl_Area.Enabled = true;
        // Ddl_BPinCode.Attributes.Remove("disabled");
        // Ddl_BranchArea.Attributes.Remove("disabled");
        Txt_BAddress.Enabled = true;
        Txt_BLandmark.Enabled = true;
        Ddl_BContractType.Attributes.Remove("disabled");
        Txt_BPurchaseDate.Enabled = true;
        Txt_BValidFrom.Enabled = true;
        Txt_BValidTo.Enabled = true;
        Txt_BContractNo.Enabled = true;
        Txt_BOwnerName.Enabled = true;
        Txt_BOwnerContactNo.Enabled = true;
        Txt_BOwnerEmailId.Enabled = true;
        Ddl_ControllingBranchName.Enabled = true;
        // Ddl_BControllingBranchs.Attributes.Remove("disabled");
        Txt_BuildUp.Enabled = true;
        Txt_Carpet.Enabled = true;
        Ddl_UnderESIC.Attributes.Remove("disabled");

        Ddl_CoveredLabourLaw.Attributes.Remove("disabled");
        Ddl_Cataegory.Attributes.Remove("disabled");

        Button_Tab1Save.Enabled = true;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Remove("opacity");

    }

    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        //if (HiddenField_Submit1.Value=="1")
        //{
        string panCardFileName;
        string aadharCardFileName;

        if (fileName1 == null)
        {
            panCardFileName = "";
        }
        else
        {
            panCardFileName = fileName1;
        }

        if (fileName2 == null)
        {
            aadharCardFileName = "";
        }
        else
        {
            aadharCardFileName = fileName2;
        }

        CFunctions.setTab(2);

        if (CFunctions.tab == 2)
        {
            con.Open();
            cmd = new SqlCommand("ssp_CreateOrUpdateBranch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@branchTab", CFunctions.tab);
            cmd.Parameters.AddWithValue("@branchcheck", CFunctions.tabstatus);
            cmd.Parameters.AddWithValue("@branchId", CFunctions.ID);
            cmd.Parameters.AddWithValue("@branchType", "");
            cmd.Parameters.AddWithValue("@branchName", "");
            cmd.Parameters.AddWithValue("@locId", "");
            cmd.Parameters.AddWithValue("@areaID", "");
            cmd.Parameters.AddWithValue("@address", "");
            cmd.Parameters.AddWithValue("@landMark", "");
            cmd.Parameters.AddWithValue("@contractType", "");
            cmd.Parameters.AddWithValue("@purchaseDate", "");
            cmd.Parameters.AddWithValue("@validFromDate", "");
            cmd.Parameters.AddWithValue("@validToDate", "");
            cmd.Parameters.AddWithValue("@propertyContractNo", "");
            cmd.Parameters.AddWithValue("@propertyOwnerName", "");
            cmd.Parameters.AddWithValue("@propertyOwnerContactNo", "");
            cmd.Parameters.AddWithValue("@propertyOwnerEmailID", "");
            cmd.Parameters.AddWithValue("@controllingBranchID", "");
            cmd.Parameters.AddWithValue("@buildUP", "");
            cmd.Parameters.AddWithValue("@carpet", "");
            cmd.Parameters.AddWithValue("@areaCoveredUnderESIC", "");
            cmd.Parameters.AddWithValue("@areaCoveredUnderLabourLaw", "");
            cmd.Parameters.AddWithValue("@areaCategory", "");
            cmd.Parameters.AddWithValue("@userId", "");
            cmd.Parameters.AddWithValue("@creationDateTime", "");
            cmd.Parameters.AddWithValue("@panCardNo", Txt_BranchPanCardNo.Text.Trim().ToString().ToUpper());
            cmd.Parameters.AddWithValue("@aadharCardNo", Txt_BranchLineAdharcardNo.Text.Trim().ToUpper());
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
                CFunctions.setTabStatus(0);
            }
            CFunctions.setTab(1);

        }
        RemoveNonEditableFieldsOfBranch();

        displayDataInGridView();
        clearAll();

        List<Parameters> paramList = new List<Parameters>();
        DataTable dtTable = (new Connection()).Fillsp("sp_GetBranchList", paramList);
        HttpContext.Current.Application["GetBranchName"] = dtTable;

        //    HiddenField_Submit1.Value = "";
        //}


    }


    protected void editBranchDetails_Click(object sender, EventArgs e)
    {
        CFunctions.setTabStatus(1);
        CFunctions.setID(Convert.ToInt32((sender as LinkButton).CommandArgument));
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchCreation", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@branchId", CFunctions.ID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        con.Close();
        Ddl_Type.Text = dtbl.Rows[0]["branchType"].ToString();
        Txt_BranchName.Text = dtbl.Rows[0]["branchName"].ToString();
        Txt_Pincode.Text = dtbl.Rows[0]["locPincode"].ToString();
        hfPincode.Value = dtbl.Rows[0]["locId"].ToString();
        Ddl_Area.SelectedItem.Text = dtbl.Rows[0]["areaName"].ToString();
        hfArea.Value = dtbl.Rows[0]["locAreaID"].ToString();
        Txt_City.Text = dtbl.Rows[0]["cityName"].ToString();
        Txt_District.Text = dtbl.Rows[0]["districtName"].ToString();
        Txt_State.Text = dtbl.Rows[0]["stateName"].ToString();
        Txt_BAddress.Text = dtbl.Rows[0]["address"].ToString();
        Txt_BLandmark.Text = dtbl.Rows[0]["landMark"].ToString();
        Ddl_BContractType.Text = dtbl.Rows[0]["contractType"].ToString();
        Txt_BPurchaseDate.Text = dtbl.Rows[0]["purchaseDate"].ToString();
        Txt_BValidFrom.Text = dtbl.Rows[0]["validFromDate"].ToString();
        Txt_BValidTo.Text = dtbl.Rows[0]["validToDate"].ToString();
        Txt_BContractNo.Text = dtbl.Rows[0]["propertyContractNo"].ToString();
        Txt_BOwnerName.Text = dtbl.Rows[0]["propertyOwnerName"].ToString();
        Txt_BOwnerContactNo.Text = dtbl.Rows[0]["propertyOwnerContactNo"].ToString();
        Txt_BOwnerEmailId.Text = dtbl.Rows[0]["propertyOwnerEmailID"].ToString();
        Txt_BranchPanCardNo.Text = dtbl.Rows[0]["panCardNo"].ToString();
        Txt_BranchLineAdharcardNo.Text = dtbl.Rows[0]["aadharCardNo"].ToString();
        Ddl_ControllingBranchName.SelectedItem.Text = dtbl.Rows[0]["ControllingBranch"].ToString();
        Ddl_ControllingBranchName.SelectedValue = dtbl.Rows[0]["controllingBranchID"].ToString();
        Txt_BuildUp.Text = dtbl.Rows[0]["buildUP"].ToString();
        Txt_Carpet.Text = dtbl.Rows[0]["carpet"].ToString();
        Ddl_UnderESIC.Text = dtbl.Rows[0]["areaCoveredUnderESIC"].ToString();
        Ddl_CoveredLabourLaw.Text = dtbl.Rows[0]["areaCoveredUnderLabourLaw"].ToString();
        Ddl_Cataegory.Text = dtbl.Rows[0]["areaCategory"].ToString();
        BranchPanCard_Label.InnerHtml = dtbl.Rows[0]["panCardFileName"].ToString();
        BranchPanCard_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["panCardFileName"].ToString());
        BranchLineAdharCard_Label.InnerHtml = dtbl.Rows[0]["aadharCardFileName"].ToString();
        BranchLineAdharCard_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["aadharCardFileName"].ToString());
        Branch_Reset.Enabled = false;
        Branch_Reset.Style.Add("opacity", "0.3");
        Btn_DocReset.Enabled = false;
        Btn_DocReset.Style.Add("opacity", "0.3");
        Button_Tab1Save.Text = "UPDATE <i class='fa fa-save'></i>";
        RemoveNonEditableFieldsOfBranch();
    }




    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Search.Value == "1")
        {
            Search_BranchDetails_View.Visible = true;
            Search_DataGridView();

            HiddenField_Btn_Search.Value = "";
        }



    }
    public void Search_DataGridView(string sortExpression = null)
    {
        String bname = Ddl_SearchBranch.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchBranch.SelectedValue.ToString();
        String strStatus = Ddl_SearchBranchStatus.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchBranchStatus.SelectedItem.ToString();

        if ((bname != null) || (strStatus != null))
        {

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewBranchCreation", con);
            sqlda.SelectCommand.Parameters.AddWithValue("@branchId", bname);
            sqlda.SelectCommand.Parameters.AddWithValue("@status", strStatus);
            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlda.Fill(dtbl);
            if (sortExpression != null)
            {
                DataView dv = dtbl.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewBranch.DataSource = dv;
                GV_Export.DataSource = dv;
            }
            else
            {
                gridViewBranch.DataSource = dtbl;
                GV_Export.DataSource = dtbl;
            }

            gridViewBranch.DataBind();
            GV_Export.DataBind();
            con.Close();

        }

    }


    protected void Btn_PopAreaSubmit_Click(object sender, EventArgs e)
    {

        //con.Open();
        //SqlCommand cmd = new SqlCommand("spInsertArea", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@area", Txt_popArea.Text.Trim().ToUpper());
        //cmd.Parameters.AddWithValue("@pincode", Txt_Pincode.Text);
        //int k = cmd.ExecuteNonQuery();
        //if (k != 0)
        //{
        //    lblmsg.Text = "Record Inserted Succesfully into the Database";
        //    lblmsg.ForeColor = System.Drawing.Color.CornflowerBlue;
        //}
        //con.Close();
        //Btn_PopAreaSubmit.Text = "";
        //lblmsg.Text = "";

    }


    protected void gridViewBranch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewBranch.PageIndex = e.NewPageIndex;
        Search_DataGridView();
    }

    protected void gridViewBranch_Sorting(object sender, GridViewSortEventArgs e)
    {
        displayDataInGridView(e.SortExpression);
    }


    /* Ajax File Upload Start*/

    protected void BranchPanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        String file = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        BranchPanCard_Uploader.SaveAs(file);
        fileName1 = e.FileName.ToString();
        // FTPUpload(sender, e);

    }

    //protected void FTPUpload(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    //{
    //    //FTP Server URL.
    //    string ftp = "ftp://dexpro.co.in/httpdocs/InHouseDemo/";

    //    //FTP Folder name. Leave blank if you want to upload to root folder.
    //    string ftpFolder = "FileUpload/";

    //    byte[] fileBytes = null;

    //    //Read the FileName and convert it to Byte array.
    //    fileName1 = Path.GetFileName(e.FileName);
    //    using (StreamReader fileStream = new StreamReader(e.GetStreamContents()))
    //    {
    //        fileBytes = Encoding.UTF8.GetBytes(fileStream.ReadToEnd());
    //        fileStream.Close();
    //    }

    //    try
    //    {
    //        //Create FTP Request.
    //        FtpWebRequest request = (FtpWebRequest)WebRequest.Create(ftp + ftpFolder + fileName1);
    //        request.Method = WebRequestMethods.Ftp.UploadFile;

    //        //Enter FTP Server credentials.
    //        request.Credentials = new NetworkCredential("dexprefj", "Dexters@123");
    //        request.ContentLength = fileBytes.Length;
    //        request.UsePassive = true;
    //        request.UseBinary = true;
    //        request.ServicePoint.ConnectionLimit = fileBytes.Length;
    //        request.EnableSsl = false;

    //        using (Stream requestStream = request.GetRequestStream())
    //        {
    //            requestStream.Write(fileBytes, 0, fileBytes.Length);
    //            requestStream.Close();
    //        }

    //        FtpWebResponse response = (FtpWebResponse)request.GetResponse();

    //     //   lblMessage.Text += fileName1 + " uploaded.<br />";
    //        response.Close();
    //    }
    //    catch (WebException ex)
    //    {
    //        throw new Exception((ex.Response as FtpWebResponse).StatusDescription);
    //    }
    //}

    protected void BranchLineAdharCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        String file = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        BranchLineAdharCard_Uploader.SaveAs(file);
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
        string CurrentDateTime = cmf.CurrentDateTime();

        GV_Export.Visible = true;
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Branch_Creation" + CurrentDateTime + ".xls";
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