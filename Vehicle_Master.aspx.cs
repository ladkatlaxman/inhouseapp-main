using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;
using NameSpaceConnection;
using BLFunctions;
using System.Linq;

public partial class OPERATIONS_VehicleMaster : System.Web.UI.Page
{

    //static int count;
    public static string usePickup, useDelivery, useRoute;
    string VehicleNo;
    int count;
    /*     - PkFieldId Store DatakeyValue of Gridview,
          - VehicleNo store vehicle number come to database
          - count vehicle alpha*/


    //Create Object of Connecton and BindDropdownlist Class
    Connection con = new Connection();
    CFunctions cmf = new CFunctions();

    static String fileName1;
    static String fileName2;
    static String fileName3;
    static String fileName4;



    #region    /*------------------------------------------------------------------Page Load--------------------------------------------------------*/
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoClear();

        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                //focus 
                Txt_NewVehicleNoAlpha1.Focus();
                //hide button
                cmf.ButtonopacityHideShow(0, "NEXT", Btn_VehicleNext);
                //set variable
                CFunctions.setTab(1);
                CFunctions.setTabStatus(0);

                cmf.dropdwnlist(null, null, Ddl_TransporterName, null, "Name", "ID", (new MasterFormFunctions().getVendor(Convert.ToInt32(Session["BranchId"]))));
                cmf.dropdwnlist(null, null, Ddl_VehicleType, null, "Name", "ID", (new MasterFormFunctions().getVehicleType()));

                //Calling DropBindDropdownDoubleParameter using object of BindDropdownlist
                //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_TransporterName, "ssp_GetVendorList", "", "", "", "", "", "", "vendorName", "vendorID", null);
                //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_VehicleType, "ssp_GetVehicleTypeList", "@Event", "ddl_VehicleType", "@VehicleType", "", "", "", "VehicleType", "vehicleTypeID", null);
                //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchVehicleNo, "ssp_GetVehicleNoList", "", "", "", "", "", "", "vehicleNo", "vehicleNo", null);
                //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchTransporterName, "ssp_GetVendorList", "", "", "", "", "", "", "vendorName", "vendorID", null);

                if (Session["VehicleNoAlpha1"] != null)
                {
                    Txt_NewVehicleNoAlpha1.Text = Session["VehicleNoAlpha1"].ToString();
                    Session["VehicleNoAlpha1"] = null;
                }
                if (Session["VehicleNoDigit1"] != null)
                {
                    Txt_NewVehicleNoDigit1.Text = Session["VehicleNoDigit1"].ToString();
                    Session["VehicleNoDigit1"] = null;
                }
                if (Session["VehicleNoAlpha2"] != null)
                {
                    Txt_NewVehicleNoAlpha2.Text = Session["VehicleNoAlpha2"].ToString();
                    Session["VehicleNoAlpha2"] = null;
                }
                if (Session["VehicleNoDigit2"] != null)
                {
                    Txt_NewVehicleNoDigit2.Text = Session["VehicleNoDigit2"].ToString();
                    Session["VehicleNoDigit2"] = null;
                }
                if (Session["VehicleCategory"] != null)
                {
                    foreach (ListItem item in Ddl_VehicleCategory.Items)
                    {
                        if (item.Text == Session["VehicleCategory"].ToString())
                        {
                            item.Selected = true;
                            Session["VehicleCategory"] = null;
                            break;
                        }
                    }
                }
                else
                {
                    //Ddl_VehicleCategory.SelectedIndex = 1;
                }
                if (Session["VehicleHiringType"] != null)
                {
                    int VehicleHiringTypeSelectedCount = 0;
                    string VehicleHiringType = Session["VehicleHiringType"].ToString();
                    string[] VehicleHiringTypeList = VehicleHiringType.Split(',');
                    foreach (string VehicleHire in VehicleHiringTypeList)
                    {
                        foreach (ListItem item in CheckBoxList_VehicleHiringType.Items)
                        {
                            if (item.Text == VehicleHire)
                            {
                                item.Selected = true;
                                VehicleHiringTypeSelectedCount++;
                                break;
                            }
                        }
                    }
                    if (VehicleHiringTypeSelectedCount == CheckBoxList_VehicleHiringType.Items.Count)
                        select_all_VehicleHiringType.Checked = true;
                    Session["VehicleHiringType"] = null;
                }
                else
                {
                    Txt_VehicleHiringType.Text = "";
                    foreach (ListItem item in CheckBoxList_VehicleHiringType.Items)
                    {
                        item.Selected = false;
                    }
                }
                if (Session["VehicleType"] != null)
                {
                    foreach (ListItem t in Ddl_VehicleType.Items)
                    {
                        if (t.Text == Session["VehicleType"].ToString())
                        {
                            t.Selected = true;
                            Session["VehicleType"] = null;
                            break;
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }

    #endregion


    #region /*------------------------------------------------------------All Function Defination------------------------------------------------------------------------*/


    /*----------------Auto Complete Code false--------------------*/

    public void AutoClear()
    {
        Txt_NewVehicleNoAlpha1.Attributes.Add("autocomplete", "off");
        Txt_NewVehicleNoDigit1.Attributes.Add("autocomplete", "off");
        Txt_NewVehicleNoAlpha2.Attributes.Add("autocomplete", "off");
        Txt_NewVehicleNoDigit2.Attributes.Add("autocomplete", "off");
        Txt_Permit_No.Attributes.Add("autocomplete", "off");
        Txt_PermitDateValidFrom.Attributes.Add("autocomplete", "off");
        Txt_PermitDateValidUpto.Attributes.Add("autocomplete", "off");
        Txt_InsNo.Attributes.Add("autocomplete", "off");
        Txt_InsDateValidFrom.Attributes.Add("autocomplete", "off");
        Txt_InsDateValidUpto.Attributes.Add("autocomplete", "off");
        Txt_PUCNo.Attributes.Add("autocomplete", "off");
        Txt_PUCDateValidFrom.Attributes.Add("autocomplete", "off");
        Txt_PUCDateValidUpto.Attributes.Add("autocomplete", "off");
        Txt_FitnessCertificateNo.Attributes.Add("autocomplete", "off");
        Txt_FitnessChkDateValidFrom.Attributes.Add("autocomplete", "off");
        Txt_FitnessChkDateValidUpto.Attributes.Add("autocomplete", "off");
    }
    /*----------------Fill Data in Gridview code with Sorting--------------------*/

    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private void FillGrid(string sortExpression = null)
    {
        if (con.State == ConnectionState.Closed)
        {
            con.open();
        }

        //string VehicleNo = Ddl_SearchVehicleNo.SelectedItem.Text.ToString() == "SELECT" ? null : Ddl_SearchVehicleNo.SelectedItem.Text.ToString();
        //string TransporterName = Ddl_SearchTransporterName.SelectedItem.Text.ToString() == "SELECT" ? null : Ddl_SearchTransporterName.SelectedItem.Text.ToString();

        
      
        string Category = Ddl_SearchCategory.SelectedItem.Text.ToString() == "SELECT" ? null : Ddl_SearchCategory.SelectedItem.Text.ToString();

        if (Category != null)
        {
            con.cmd = new SqlCommand("ssp_ViewVehicle", con.con);
            con.cmd.CommandType = CommandType.StoredProcedure;
            con.cmd.Parameters.AddWithValue("@Category", Category);
            con.cmd.Parameters.AddWithValue("@BranchId", Session["BranchId"].ToString());
            con.DA = new SqlDataAdapter(con.cmd);
            con.Dt = new DataTable();
            con.DA.Fill(con.Dt);
            if (sortExpression != null)
            {
                DataView dv = con.Dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                if (this.SortDirection == "ASC")
                {
                    dv.Sort = sortExpression + " " + this.SortDirection;
                }
                dv.Sort = sortExpression + " " + this.SortDirection;
                GV_VehicleMaster.DataSource = dv;
               // GV_Export.DataSource = dv;
            }
            else
            {
                GV_VehicleMaster.DataSource = con.Dt;
                //GV_Export.DataSource = con.Dt;
            }
            GV_VehicleMaster.DataBind();
          //  GV_Export.DataBind();
        }
        else
        {
            con.Dt = new DataTable();
            GV_VehicleMaster.DataSource = con.Dt;
            GV_VehicleMaster.DataBind();
        }
    }

    /*----------------Load Data Into Text Code--------------------*/

    //Load Data
    public void LoadFinalDataIntoText()
    {
        if (con.State == ConnectionState.Closed)
        {
            con.open();
        }
        con.cmd = new SqlCommand("ssp_GetVehicleCreation", con.con);
        con.cmd.CommandType = CommandType.StoredProcedure;
        con.cmd.Parameters.AddWithValue("@VehicleID", CFunctions.ID);
        con.DA = new SqlDataAdapter(con.cmd);
        con.Dt = new DataTable();
        con.DA.Fill(con.Dt);
        GV_VehicleMaster.DataSource = con.Dt;
        if (con.Dt.Rows.Count > 0)
        {
            VehicleNo = con.Dt.Rows[0]["vehicleNo"].ToString();
            foreach (char v in VehicleNo)
            {
                count++;
                if (count < 3)
                {
                    if (System.Text.RegularExpressions.Regex.IsMatch(v.ToString(), "^[a-zA-Z]"))
                    {
                        Txt_NewVehicleNoAlpha1.Text += v.ToString();
                    }
                    else
                    {
                        Txt_NewVehicleNoDigit1.Text += v.ToString();
                    }
                }
                else if (count < 5)
                {
                    if (System.Text.RegularExpressions.Regex.IsMatch(v.ToString(), "^[0-9]"))
                    {
                        Txt_NewVehicleNoDigit1.Text += v.ToString();
                    }
                    else
                    {
                        Txt_NewVehicleNoAlpha2.Text += v.ToString();
                    }
                }
                else if (count <= 10)
                {
                    if (System.Text.RegularExpressions.Regex.IsMatch(v.ToString(), "^[a-zA-Z]"))
                    {
                        Txt_NewVehicleNoAlpha2.Text += v.ToString();
                    }
                    else
                    {
                        Txt_NewVehicleNoDigit2.Text += v.ToString();
                    }
                }
            }
            Ddl_VehicleCategory.Text = con.Dt.Rows[0]["vehicleCategory"].ToString();
            Ddl_TransporterName.SelectedItem.Text = con.Dt.Rows[0]["vendorName"].ToString();
            Ddl_TransporterName.SelectedValue = con.Dt.Rows[0]["VendorID"].ToString();
            int c = 0;
            foreach (ListItem item in CheckBoxList_VehicleHiringType.Items)
            {
                if (item.Text == "ROUTE" && con.Dt.Rows[0]["useForRoute"].ToString() == "TRUE")
                {
                    c++;
                    item.Selected = true;
                    Txt_VehicleHiringType.Text = item.Text + ",";
                }
                else if (item.Text == "PICKUP" && con.Dt.Rows[0]["useForPickup"].ToString() == "TRUE")
                {
                    c++;
                    item.Selected = true;
                    Txt_VehicleHiringType.Text += item.Text + ",";
                }
                else if (item.Text == "DELIVERY" && con.Dt.Rows[0]["useForDelivery"].ToString() == "TRUE")
                {
                    c++;
                    item.Selected = true;
                    Txt_VehicleHiringType.Text += item.Text + ",";
                }
            }
            if (c == CheckBoxList_VehicleHiringType.Items.Count)
                select_all_VehicleHiringType.Checked = true;
            Ddl_VehicleType.SelectedItem.Text = con.Dt.Rows[0]["vehicleType"].ToString();
            Ddl_VehicleType.SelectedValue = con.Dt.Rows[0]["vehicleTypeID"].ToString();

            Txt_Permit_No.Text = con.Dt.Rows[0]["permitNo"].ToString();
            Txt_PermitDateValidFrom.Text = con.Dt.Rows[0]["permitValidFromDate"].ToString();
            Txt_PermitDateValidUpto.Text = con.Dt.Rows[0]["permitValidToDate"].ToString();
            Txt_InsNo.Text = con.Dt.Rows[0]["insuranceNo"].ToString();
            Txt_InsDateValidFrom.Text = con.Dt.Rows[0]["insuranceValidFromDate"].ToString();
            Txt_InsDateValidUpto.Text = con.Dt.Rows[0]["insuranceValidToDate"].ToString();
            Txt_PUCNo.Text = con.Dt.Rows[0]["pucNo"].ToString();
            Txt_PUCDateValidFrom.Text = con.Dt.Rows[0]["pucValidFromDate"].ToString();
            Txt_PUCDateValidUpto.Text = con.Dt.Rows[0]["pucValidToDate"].ToString();
            Txt_FitnessCertificateNo.Text = con.Dt.Rows[0]["fitnessCertificateNo"].ToString();
            Txt_FitnessChkDateValidFrom.Text = con.Dt.Rows[0]["fitnessCertificateValidFromDate"].ToString();
            Txt_FitnessChkDateValidUpto.Text = con.Dt.Rows[0]["fitnessCertificateValidToDate"].ToString();

            Vehicle_NationalPermitNo_Label.InnerHtml = con.Dt.Rows[0]["permitFileName"].ToString();
            Vehicle_NationalPermitNo_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["permitFileName"].ToString());

            Vehicle_InsuranceNo_Label.InnerHtml = con.Dt.Rows[0]["insuranceFileName"].ToString();
            Vehicle_InsuranceNo_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["insuranceFileName"].ToString());

            Vehicle_PUC_No_Label.InnerHtml = con.Dt.Rows[0]["pucFileName"].ToString();
            Vehicle_PUC_No_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["pucFileName"].ToString());

            Vehicle_FitneesCertificateNo_Label.InnerHtml = con.Dt.Rows[0]["fitnessCertificateFileName"].ToString();
            Vehicle_FitneesCertificateNo_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["fitnessCertificateFileName"].ToString());
        }
    }

    /*----------------ClearText OR Disable Code--------------------*/

    //Vehicle tab1 Vehicle Data Clear
    protected void ClearTextVehicleDetails()
    {
        Txt_NewVehicleNoAlpha1.Text = "";
        Txt_NewVehicleNoDigit1.Text = "";
        Txt_NewVehicleNoAlpha2.Text = "";
        Txt_NewVehicleNoDigit2.Text = "";
        Ddl_TransporterName.SelectedIndex = 0;
        Ddl_VehicleCategory.SelectedIndex = 1;
        Txt_VehicleHiringType.Text = "";
        foreach (ListItem item in CheckBoxList_VehicleHiringType.Items)
        {
            item.Selected = false;
        }
        select_all_VehicleHiringType.Checked = false;
        Ddl_VehicleType.SelectedIndex = 0;
        ViewData.Visible = false;
    }
    //Vehicle tab1 Disable
    protected void DisableVehicleDetails()
    {
        Txt_NewVehicleNoAlpha1.Enabled = false;
        Txt_NewVehicleNoDigit1.Enabled = false;
        Txt_NewVehicleNoAlpha2.Enabled = false;
        Txt_NewVehicleNoDigit2.Enabled = false;
        Ddl_TransporterName.Enabled = false;
        Ddl_VehicleCategory.Attributes.Add("disabled", "disabled");
        Txt_VehicleHiringType.Attributes.Add("disabled", "disabled");
        Ddl_VehicleType.Enabled = false;
        Btn_AddNewTransporter.Visible = false;
    }

    //Vehicle tab2 Supporting Data Clear
    protected void ClearTextVSupportingDetails()
    {
        Txt_Permit_No.Text = "";
        Txt_PermitDateValidFrom.Text = "";
        Txt_PermitDateValidUpto.Text = "";
        Vehicle_NationalPermitNo_Label.InnerHtml = "";

        Txt_InsNo.Text = "";
        Txt_InsDateValidFrom.Text = "";
        Txt_InsDateValidUpto.Text = "";
        Vehicle_InsuranceNo_Label.InnerHtml = "";

        Txt_PUCNo.Text = "";
        Txt_PUCDateValidFrom.Text = "";
        Txt_PUCDateValidUpto.Text = "";
        Vehicle_PUC_No_Label.InnerHtml = "";

        Txt_FitnessCertificateNo.Text = "";
        Txt_FitnessChkDateValidFrom.Text = "";
        Txt_FitnessChkDateValidUpto.Text = "";
        Vehicle_FitneesCertificateNo_Label.InnerHtml = "";
        ViewData.Visible = false;
    }

    //  Active All Feilds
    protected void ActiveAllDetails()
    {
        Txt_NewVehicleNoAlpha1.Enabled = true;
        Txt_NewVehicleNoDigit1.Enabled = true;
        Txt_NewVehicleNoAlpha2.Enabled = true;
        Txt_NewVehicleNoDigit2.Enabled = true;
        TransporterName.Visible = true;
        Ddl_TransporterName.Enabled = true;
        Ddl_VehicleCategory.Attributes.Remove("disabled");
        Txt_VehicleHiringType.Attributes.Remove("disabled");
        Ddl_VehicleType.Enabled = true;
        Btn_AddNewTransporter.Visible = true;
    }
    #endregion


    #region    /***********************************************************Start Tab1 Code**************************************************************************************/

    #region    //Padleft(Prefix) By Default 0 
    protected void Txt_NewVehicleNoDigit1_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_NewVehicleNoDigit1.Value == "1")
        {
            if (Txt_NewVehicleNoDigit1.Text.Length <= 2)
            {
                if (Txt_NewVehicleNoDigit1.Text != "" && Txt_NewVehicleNoDigit1.Text != "0" && Txt_NewVehicleNoDigit1.Text != "00")
                {
                    Txt_NewVehicleNoDigit1.Text = "0".Substring(0, 2 - Txt_NewVehicleNoDigit1.Text.Length) + Txt_NewVehicleNoDigit1.Text;
                    Txt_NewVehicleNoAlpha2.Focus();
                }
                else
                {
                    Txt_NewVehicleNoDigit1.Text = "";
                    Txt_NewVehicleNoDigit1.Focus();
                }
            }
            else
            {
                Txt_NewVehicleNoAlpha2.Focus();
            }
            HiddenField_Txt_NewVehicleNoDigit1.Value = "";
        }
    }

    //Padleft(Prefix) By Default 0  AND Check VehicleNo is Exist or not
    protected void Txt_NewVehicleNoDigit2_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_NewVehicleNoDigit2.Value == "1")
        {
            if (Txt_NewVehicleNoDigit2.Text.Length <= 4)
            {
                if (Txt_NewVehicleNoDigit2.Text != "" && Txt_NewVehicleNoDigit2.Text != "0" && Txt_NewVehicleNoDigit2.Text != "00" && Txt_NewVehicleNoDigit2.Text != "000" && Txt_NewVehicleNoDigit2.Text != "0000")
                {
                    Txt_NewVehicleNoDigit2.Text = "000".Substring(0, 4 - Txt_NewVehicleNoDigit2.Text.Length) + Txt_NewVehicleNoDigit2.Text;
                    Ddl_TransporterName.Focus();

                    VehicleNo = Txt_NewVehicleNoAlpha1.Text.ToUpper() + Txt_NewVehicleNoDigit1.Text + Txt_NewVehicleNoAlpha2.Text.ToUpper() + Txt_NewVehicleNoDigit2.Text;
                    if (con.State == ConnectionState.Closed)
                    {
                        con.open();
                    }
                    string query = "select vehicleNo,status from tblVehicleCreation";
                    con.cmd = new SqlCommand(query, con.con);
                    SqlDataReader readVehicleNo = con.cmd.ExecuteReader();
                    //con.DR = con.cmd.ExecuteReader();
                    while (readVehicleNo.Read())
                    {
                        if (readVehicleNo["vehicleNo"].ToString() == VehicleNo)
                        {
                            if (readVehicleNo["status"].ToString() == "INACTIVE" || readVehicleNo["status"].ToString() == "NULL")
                                Ddl_TransporterName.Focus();
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('This VehicleNo Already Exists!');", true);
                                Txt_NewVehicleNoAlpha1.Text = "";
                                Txt_NewVehicleNoDigit1.Text = "";
                                Txt_NewVehicleNoAlpha2.Text = "";
                                Txt_NewVehicleNoDigit2.Text = "";
                                Txt_NewVehicleNoAlpha1.Focus();
                                break;
                            }
                        }
                        else
                            Ddl_TransporterName.Focus();
                    }
                }
                else
                {
                    Txt_NewVehicleNoDigit2.Text = "";
                    Txt_NewVehicleNoDigit2.Focus();
                }
            }
            HiddenField_Txt_NewVehicleNoDigit2.Value = "";
        }
    }
    #endregion


    #region    /*-----------------------------------------Transportername Dropdownlist Code-------------------------------------------------------------*/

    //protected void RadioButtonList_Transportername_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_Transportername.Value == "1")
    //    {
    //        for (int i = 0; i < RadioButtonList_Transportername.Items.Count; i++)
    //        {
    //            if (RadioButtonList_Transportername.Items[i].Selected)
    //            {
    //                Txt_Transportername.Text = RadioButtonList_Transportername.Items[i].Text;
    //                if (Txt_Transportername.Text == "SELECT")
    //                {
    //                    Txt_Transportername.Focus();
    //                    Btn_AddNewTransporter.Visible = true;
    //                }
    //                else
    //                {
    //                    Btn_AddNewTransporter.Visible = false;
    //                    //     cmf.BindDataValueInListTripleParameter("", RadioButtonList_Vehicle_Owner, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_DropdownTransportarOwner", "@Name", Txt_Transportername.Text.ToString(), "@check", "", "vendorOwnerName", "vendorOwnerName", Txt_Vehicle_Owner);
    //                    Ddl_VehicleCategory.Focus();
    //                }
    //            }
    //        }

    //        PopupControlExtender_Transportername.Commit(RadioButtonList_Transportername.SelectedValue);

    //        HiddenField_RadioButtonList_Transportername.Value = "";
    //    }


    //}


    //protected void Txt_Transportername_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_Transportername_Search.Value == "1")
    //    {
    //        if (Txt_Transportername_Search.Text != "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_Transportername_Search, RadioButtonList_Transportername, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_DropdownTransportarName", "@Name", Txt_Transportername_Search.Text.ToString(), "@check", "", "companyName", "companyName", Txt_Transportername);
    //        }

    //        else if (Txt_Transportername_Search.Text == "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_Transportername_Search, RadioButtonList_Transportername, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_DropdownTransportarName", "@Name", "", "@check", "", "companyName", "companyName", Txt_Transportername);
    //        }

    //        HiddenField_Txt_Transportername_Search.Value = "";
    //    }
    //}

    //Add New Transportar
    protected void Btn_AddNewTransporter_Click(object sender, ImageClickEventArgs e)
    {
        CFunctions.setform(1);
        if (Txt_NewVehicleNoAlpha1.Text.ToString() != "")
        {
            Session["VehicleNoAlpha1"] = Txt_NewVehicleNoAlpha1.Text.ToString().ToUpper();
        }
        else
        {
            Session["VehicleNoAlpha1"] = null;
        }
        if (Txt_NewVehicleNoDigit1.Text.ToString() != "")
        {
            Session["VehicleNoDigit1"] = Txt_NewVehicleNoDigit1.Text.ToString();
        }
        else
        {
            Session["VehicleNoDigit1"] = null;
        }
        if (Txt_NewVehicleNoAlpha2.Text.ToString() != "")
        {
            Session["VehicleNoAlpha2"] = Txt_NewVehicleNoAlpha2.Text.ToString().ToUpper();
        }
        else
        {
            Session["VehicleNoAlpha2"] = null;
        }
        if (Txt_NewVehicleNoDigit2.Text.ToString() != "")
        {
            Session["VehicleNoDigit2"] = Txt_NewVehicleNoDigit2.Text.ToString();
        }
        else
        {
            Session["VehicleNoDigit2"] = null;
        }
        if (Ddl_VehicleCategory.SelectedItem.ToString() != "")
        {
            Session["VehicleCategory"] = Ddl_VehicleCategory.SelectedItem.ToString().ToUpper();
        }
        else
        {
            Session["VehicleCategory"] = null;
        }
        if (Txt_VehicleHiringType.Text.ToString() != "")
        {
            Session["VehicleHiringType"] = Txt_VehicleHiringType.Text.ToString().ToUpper();
        }
        else
        {
            Session["VehicleHiringType"] = null;
        }
        if (Ddl_VehicleType.Text.ToString() != "")
        {
            Session["VehicleType"] = Ddl_VehicleType.Text.ToString().ToUpper();
        }
        else
        {
            Session["VehicleType"] = null;
        }
        Session["URI"] = HttpContext.Current.Request.Url.AbsoluteUri;

        Response.Redirect("Party_VendorCreation.aspx");
    }
    #endregion

    protected void Ddl_VehicleCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Ddl_VehicleCategory.SelectedItem.Text == "OWNED")
            TransporterName.Visible = false;
        else
            TransporterName.Visible = true;
        Ddl_VehicleCategory.Focus();
    }

    #region    /*-----------------------------------------VehicleUsedFor Dropdownlist Code-------------------------------------------------------------*/

    protected void LiunkButton_VehicleHiringType()
    {
        int Listcount = 0, selected = 0;
        Txt_VehicleHiringType.Text = "";
        Listcount = CheckBoxList_VehicleHiringType.Items.Count;
        for (int i = 0; i < CheckBoxList_VehicleHiringType.Items.Count; i++)
        {
            if (CheckBoxList_VehicleHiringType.Items[i].Selected)
            {
                Txt_VehicleHiringType.Text += CheckBoxList_VehicleHiringType.Items[i].Text + ",";
                selected++;
            }
        }
        if (Listcount == selected)
            select_all_VehicleHiringType.Checked = true;
        else
            select_all_VehicleHiringType.Checked = false;
    }
    protected void LinkButton_VehicleHiringType_Submit_Click(object sender, EventArgs e)
    {
        if (HiddenField_LinkButton_VehicleHiringType_Submit.Value == "1")
        {
            LiunkButton_VehicleHiringType();
            HiddenField_LinkButton_VehicleHiringType_Submit.Value = "";
            Ddl_VehicleType.Focus();
        }
    }
    protected void Select_All_VehicleHiringType()
    {
        if (select_all_VehicleHiringType.Checked == true)
        {
            Txt_VehicleHiringType.Text = "";
            for (int i = 0; i < CheckBoxList_VehicleHiringType.Items.Count; i++)
            {
                CheckBoxList_VehicleHiringType.Items[i].Selected = true;
                Txt_VehicleHiringType.Text += CheckBoxList_VehicleHiringType.Items[i].Text + ",";
            }
        }
        else if (select_all_VehicleHiringType.Checked == false)
        {
            for (int i = 0; i < CheckBoxList_VehicleHiringType.Items.Count; i++)
            {
                CheckBoxList_VehicleHiringType.Items[i].Selected = false;
            }
            Txt_VehicleHiringType.Text = "";
        }
    }
    protected void select_all_VehicleHiringType_CheckedChanged(object sender, EventArgs e)
    {
        if (HiddenField_select_all_VehicleHiringType.Value == "1")
        {
            Select_All_VehicleHiringType();
            Ddl_VehicleType.Focus();
            HiddenField_select_all_VehicleHiringType.Value = "";
        }
    }
    #endregion

    //#region    /*-----------------------------------------VehicleType Dropdownlist Code-------------------------------------------------------------*/
    //protected void RadioButtonList_VehicleType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_VehicleType.Value == "1")
    //    {
    //        cmf.DataList_SelectedIndexChanging(RadioButtonList_VehicleType, Txt_VehicleType);
    //        if (Txt_VehicleType.Text == "SELECT")
    //        {
    //            Txt_VehicleType.Focus();
    //        }
    //        else
    //        {
    //            Ddl_VehicleStatus.Focus();
    //        }

    //        //for (int i = 0; i < RadioButtonList_VehicleType.Items.Count; i++)
    //        //{
    //        //    if (RadioButtonList_VehicleType.Items[i].Selected)
    //        //    {
    //        //        Txt_VehicleType.Text = RadioButtonList_VehicleType.Items[i].Text;

    //        //        if (Txt_VehicleType.Text == "SELECT")
    //        //        {
    //        //            Txt_VehicleType.Focus();
    //        //        }
    //        //        else
    //        //        {
    //        //            Ddl_VehicleStatus.Focus();
    //        //        }

    //        //    }
    //        //}

    //        PopupControlExtender_VehicleType.Commit(RadioButtonList_VehicleType.SelectedValue);

    //        HiddenField_RadioButtonList_VehicleType.Value = "";
    //    }


    //}
    //protected void Txt_VehicleType_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_VehicleType_Search.Value == "1")
    //    {
    //        if (Txt_VehicleType_Search.Text != "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_VehicleType_Search, RadioButtonList_VehicleType, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_DropdownVehicleType", "@Name", Txt_VehicleType_Search.Text.ToString(), "@check", "", "VehicleType", "VehicleType", Txt_VehicleType);
    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_VehicleType, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_DropdownVehicleType", "@Name", Txt_VehicleType_Search.Text.ToString(), "@check", "", "VehicleType", "VehicleType");
    //            //Txt_VehicleType_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_VehicleType.Items.Count; i++)
    //            //{
    //            //    if (Txt_VehicleType.Text == RadioButtonList_VehicleType.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_VehicleType.Items[i].Selected = true;
    //            //    }

    //            //}

    //        }
    //        else if (Txt_VehicleType_Search.Text == "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_VehicleType_Search, RadioButtonList_VehicleType, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_DropdownVehicleType", "@Name", "", "@check", "", "VehicleType", "VehicleType", Txt_VehicleType);

    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_VehicleType, "spBindDropdownListVehicleMaster", "@Event", "View_DropdownVehicleType", "@Name", "", "@check", "", "VehicleType", "VehicleType");
    //            //Txt_VehicleType_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_VehicleType.Items.Count; i++)
    //            //{
    //            //    if (Txt_VehicleType.Text == RadioButtonList_VehicleType.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_VehicleType.Items[i].Selected = true;
    //            //    }

    //            //}

    //        }

    //        HiddenField_Txt_VehicleType_Search.Value = "";
    //    }


    //}
    //#endregion

    #region   //Tab1 Save Code
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {
        VehicleNo = Txt_NewVehicleNoAlpha1.Text + Txt_NewVehicleNoDigit1.Text + Txt_NewVehicleNoAlpha2.Text + Txt_NewVehicleNoDigit2.Text;

        foreach (ListItem item in CheckBoxList_VehicleHiringType.Items)
        {
            if (item.Text == "ROUTE")
                useRoute = (item.Text == "ROUTE" && item.Selected == true) ? "TRUE" : "FALSE";
            if (item.Text == "PICKUP")
                usePickup = (item.Text == "PICKUP" && item.Selected == true) ? "TRUE" : "FALSE";
            if (item.Text == "DELIVERY")
                useDelivery = (item.Text == "DELIVERY" && item.Selected == true) ? "TRUE" : "FALSE";
        }
        if (con.State == ConnectionState.Closed)
            con.open();
        //Submit Code
        if (CFunctions.tab == 1)
        {
            if (CFunctions.tabstatus == 0)
            {
                string CurrentDateTime = cmf.CurrentDateTime();

                IDataReader reader = null;
                if (con.con.State == ConnectionState.Closed)
                {
                    con.open();
                }
                con.cmd = new SqlCommand("ssp_CreateOrUpdateVehicleMaster", con.con);
                con.cmd.CommandType = CommandType.StoredProcedure;
                con.cmd.Parameters.AddWithValue("@VehicleTab", CFunctions.tab);
                con.cmd.Parameters.AddWithValue("@Vehiclecheck", CFunctions.tabstatus);
                con.cmd.Parameters.AddWithValue("@VehicleID", "");
                con.cmd.Parameters.AddWithValue("@vehicleNo", VehicleNo.ToString().ToUpper());
                if (Ddl_VehicleCategory.SelectedItem.Text == "OWNED")
                    con.cmd.Parameters.AddWithValue("@VendorID", DBNull.Value);
                else
                    con.cmd.Parameters.AddWithValue("@VendorID", Ddl_TransporterName.SelectedValue.ToString());
                con.cmd.Parameters.AddWithValue("@vehicleCategory", Ddl_VehicleCategory.SelectedItem.ToString().ToUpper());
                con.cmd.Parameters.AddWithValue("@vehicleTypeID", Ddl_VehicleType.SelectedValue.ToString());
                con.cmd.Parameters.AddWithValue("@useForPickup", usePickup);
                con.cmd.Parameters.AddWithValue("@useForDelivery", useDelivery);
                con.cmd.Parameters.AddWithValue("@useForRoute", useRoute);
                con.cmd.Parameters.AddWithValue("@permitNo", "");
                con.cmd.Parameters.AddWithValue("@permitValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@permitValidToDate", "");
                con.cmd.Parameters.AddWithValue("@insuranceNo", "");
                con.cmd.Parameters.AddWithValue("@insuranceValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@insuranceValidToDate", "");
                con.cmd.Parameters.AddWithValue("@pucNo", "");
                con.cmd.Parameters.AddWithValue("@pucValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@pucValidToDate", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateNo", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateValidToDate", "");
                con.cmd.Parameters.AddWithValue("@permitFileName", "");
                con.cmd.Parameters.AddWithValue("@insuranceFileName", "");
                con.cmd.Parameters.AddWithValue("@pucFileName", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateFileName", "");
                con.cmd.Parameters.AddWithValue("@branchID", Session["BranchId"].ToString());
                con.cmd.Parameters.AddWithValue("@userID", Session["userID"].ToString());
                con.cmd.Parameters.AddWithValue("@CreationDateTime", CurrentDateTime);
                reader = con.cmd.ExecuteReader();
                if (reader.Read())
                { CFunctions.setID(Convert.ToInt32(reader["id"])); }
                cmf.ButtonopacityHideShow(0, "SAVE", Button_Tab1Save);
                cmf.showalert("Button_Tab1Save", "SAVE", this);
            }
            else if (CFunctions.tabstatus == 1)
            {
                con.cmd = new SqlCommand("ssp_CreateOrUpdateVehicleMaster", con.con);
                con.cmd.CommandType = CommandType.StoredProcedure;
                con.cmd.Parameters.AddWithValue("@VehicleTab", CFunctions.tab);
                con.cmd.Parameters.AddWithValue("@Vehiclecheck", CFunctions.tabstatus);
                con.cmd.Parameters.AddWithValue("@VehicleID", CFunctions.ID);
                con.cmd.Parameters.AddWithValue("@vehicleNo", VehicleNo.ToString().ToUpper());
                if (Ddl_VehicleCategory.SelectedItem.Text == "OWNED")
                    con.cmd.Parameters.AddWithValue("@VendorID", DBNull.Value);
                else
                    con.cmd.Parameters.AddWithValue("@VendorID", Ddl_TransporterName.SelectedValue.ToString());
                con.cmd.Parameters.AddWithValue("@vehicleCategory", Ddl_VehicleCategory.SelectedItem.ToString().ToUpper());
                con.cmd.Parameters.AddWithValue("@vehicleTypeID", Ddl_VehicleType.SelectedValue.ToString());
                con.cmd.Parameters.AddWithValue("@useForPickup", usePickup);
                con.cmd.Parameters.AddWithValue("@useForDelivery", useDelivery);
                con.cmd.Parameters.AddWithValue("@useForRoute", useRoute);
                con.cmd.Parameters.AddWithValue("@permitNo", "");
                con.cmd.Parameters.AddWithValue("@permitValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@permitValidToDate", "");
                con.cmd.Parameters.AddWithValue("@insuranceNo", "");
                con.cmd.Parameters.AddWithValue("@insuranceValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@insuranceValidToDate", "");
                con.cmd.Parameters.AddWithValue("@pucNo", "");
                con.cmd.Parameters.AddWithValue("@pucValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@pucValidToDate", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateNo", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateValidFromDate", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateValidToDate", "");
                con.cmd.Parameters.AddWithValue("@permitFileName", "");
                con.cmd.Parameters.AddWithValue("@insuranceFileName", "");
                con.cmd.Parameters.AddWithValue("@pucFileName", "");
                con.cmd.Parameters.AddWithValue("@fitnessCertificateFileName", "");
                con.cmd.Parameters.AddWithValue("@branchID", "");
                con.cmd.Parameters.AddWithValue("@userID", "");
                con.cmd.Parameters.AddWithValue("@CreationDateTime", "");
                con.cmd.ExecuteNonQuery();
                cmf.ButtonopacityHideShow(0, "UPDATE", Button_Tab1Save);
                cmf.showalert("Button_Tab1Save", "UPDATE", this);
            }
        }
        cmf.ButtonopacityHideShow(0, "RESET", Btn_VehicleReset);
        cmf.ButtonopacityHideShow(1, "NEXT", Btn_VehicleNext);
        DisableVehicleDetails();
        //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchVehicleNo, "ssp_GetVehicleNoList", "", "", "", "", "", "", "vehicleNo", "vehicleNo", null);
        //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchTransporterName, "ssp_GetVendorList", "", "", "", "", "", "", "vendorName", "vendorID", null);
    }

    #endregion


    //Tab1 Reset Code
    protected void Btn_VehicleReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_VehicleReset.Value == "1")
        {
            ClearTextVehicleDetails();

            HiddenField_Btn_VehicleReset.Value = "";
        }

    }

    /***********************************************************End Tab1 Code**************************************************************************************/
    #endregion

    #region    /***********************************************************Start Tab3 Code**************************************************************************************/

    #region     /*Date And Time*/

    protected void Txt_PermitDateValidUpto_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_PermitDateValidUpto.Value == "1")
        {
            int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

            String FromDate = Txt_PermitDateValidFrom.Text.Trim();
            string[] splitDate = FromDate.Split('-');
            String ToDate = Txt_PermitDateValidUpto.Text.Trim();
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
                        Txt_InsNo.Focus();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                        Txt_PermitDateValidUpto.Text = "";
                        Txt_PermitDateValidUpto.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                    Txt_PermitDateValidUpto.Text = "";
                    Txt_PermitDateValidUpto.Focus();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                Txt_PermitDateValidUpto.Text = "";
                Txt_PermitDateValidUpto.Focus();
            }

            HiddenField_Txt_PermitDateValidUpto.Value = "";
        }


    }

    protected void Txt_InsDateValidUpto_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_InsDateValidUpto.Value == "1")
        {
            int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

            String FromDate = Txt_InsDateValidFrom.Text.Trim();
            string[] splitDate = FromDate.Split('-');
            String ToDate = Txt_InsDateValidUpto.Text.Trim();
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
                        Txt_PUCNo.Focus();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                        Txt_InsDateValidUpto.Text = "";
                        Txt_InsDateValidUpto.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                    Txt_InsDateValidUpto.Text = "";
                    Txt_InsDateValidUpto.Focus();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                Txt_InsDateValidUpto.Text = "";
                Txt_InsDateValidUpto.Focus();
            }


            HiddenField_Txt_InsDateValidUpto.Value = "";
        }


    }

    protected void Txt_PUCDateValidUpto_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_PUCDateValidUpto.Value == "1")
        {
            int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

            String FromDate = Txt_PUCDateValidFrom.Text.Trim();
            string[] splitDate = FromDate.Split('-');
            String ToDate = Txt_PUCDateValidUpto.Text.Trim();
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
                        Txt_FitnessCertificateNo.Focus();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                        Txt_PUCDateValidUpto.Text = "";
                        Txt_PUCDateValidUpto.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                    Txt_PUCDateValidUpto.Text = "";
                    Txt_PUCDateValidUpto.Focus();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                Txt_PUCDateValidUpto.Text = "";
                Txt_PUCDateValidUpto.Focus();
            }


            HiddenField_Txt_PUCDateValidUpto.Value = "";
        }


    }

    protected void Txt_FitnessChkDateValidUpto_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_FitnessChkDateValidUpto.Value == "1")
        {
            int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

            String FromDate = Txt_FitnessChkDateValidFrom.Text.Trim();
            string[] splitDate = FromDate.Split('-');
            String ToDate = Txt_FitnessChkDateValidUpto.Text.Trim();
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
                        Txt_FitnessChkDateValidUpto.Focus();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                        Txt_FitnessChkDateValidUpto.Text = "";
                        Txt_FitnessChkDateValidUpto.Focus();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                    Txt_FitnessChkDateValidUpto.Text = "";
                    Txt_FitnessChkDateValidUpto.Focus();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
                Txt_FitnessChkDateValidUpto.Text = "";
                Txt_FitnessChkDateValidUpto.Focus();
            }

            HiddenField_Txt_FitnessChkDateValidUpto.Value = "";
        }


    }

    #endregion

    #region    /*File Upload Section Start*/

    /* Ajax File Upload Start*/

    protected void Vehicle_NationalPermitNo_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vehicle_NationalPermitNo_Uploader.SaveAs(fileNameToUpload);
        fileName1 = e.FileName.ToString();
    }

    protected void Vehicle_InsuranceNo_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vehicle_InsuranceNo_Uploader.SaveAs(fileNameToUpload);
        fileName2 = e.FileName.ToString();
    }

    protected void Vehicle_PUC_No_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vehicle_PUC_No_Uploader.SaveAs(fileNameToUpload);
        fileName3 = e.FileName.ToString();
    }

    protected void Vehicle_FitneesCertificateNo_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vehicle_FitneesCertificateNo_Uploader.SaveAs(fileNameToUpload);
        fileName4 = e.FileName.ToString();
    }

    /* Ajax File Upload End*/

    #endregion   /*File Upload Section End*/


    #region    //Save Document Save
    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        string permitFileNameCheck;
        string insuranceFileNameCheck;
        string pucFileNameCheck;
        string fitnessCertificateFileNameCheck;

        if (fileName1 == null)
        {
            permitFileNameCheck = "";
        }
        else
        {
            permitFileNameCheck = fileName1;
        }
        if (fileName2 == null)
        {
            insuranceFileNameCheck = "";
        }
        else
        {
            insuranceFileNameCheck = fileName2;
        }
        if (fileName3 == null)
        {
            pucFileNameCheck = "";
        }
        else
        {
            pucFileNameCheck = fileName3;
        }
        if (fileName4 == null)
        {
            fitnessCertificateFileNameCheck = "";
        }
        else
        {
            fitnessCertificateFileNameCheck = fileName4;
        }
        if (con.con.State == ConnectionState.Closed)
        {
            con.open();
        }
        //Submit Code
        CFunctions.setTab(2);
        if (CFunctions.tab == 2)
        {

            con.cmd = new SqlCommand("ssp_CreateOrUpdateVehicleMaster", con.con);
            con.cmd.CommandType = CommandType.StoredProcedure;
            con.cmd.Parameters.AddWithValue("@VehicleTab", CFunctions.tab);
            con.cmd.Parameters.AddWithValue("@Vehiclecheck", CFunctions.tabstatus);
            con.cmd.Parameters.AddWithValue("@VehicleID", CFunctions.ID);
            con.cmd.Parameters.AddWithValue("@permitNo", Txt_Permit_No.Text.ToString().ToUpper());
            con.cmd.Parameters.AddWithValue("@permitValidFromDate", Txt_PermitDateValidFrom.Text);
            con.cmd.Parameters.AddWithValue("@permitValidToDate", Txt_PermitDateValidUpto.Text);
            con.cmd.Parameters.AddWithValue("@insuranceNo", Txt_InsNo.Text.ToString().ToUpper());
            con.cmd.Parameters.AddWithValue("@insuranceValidFromDate", Txt_InsDateValidFrom.Text);
            con.cmd.Parameters.AddWithValue("@insuranceValidToDate", Txt_InsDateValidUpto.Text);
            con.cmd.Parameters.AddWithValue("@pucNo", Txt_PUCNo.Text.ToString().ToUpper());
            con.cmd.Parameters.AddWithValue("@pucValidFromDate", Txt_PUCDateValidFrom.Text);
            con.cmd.Parameters.AddWithValue("@pucValidToDate", Txt_PUCDateValidUpto.Text);
            con.cmd.Parameters.AddWithValue("@fitnessCertificateNo", Txt_FitnessCertificateNo.Text.ToString().ToUpper());
            con.cmd.Parameters.AddWithValue("@fitnessCertificateValidFromDate", Txt_FitnessChkDateValidFrom.Text);
            con.cmd.Parameters.AddWithValue("@fitnessCertificateValidToDate", Txt_FitnessChkDateValidUpto.Text);
            con.cmd.Parameters.AddWithValue("@permitFileName", permitFileNameCheck);
            con.cmd.Parameters.AddWithValue("@insuranceFileName", insuranceFileNameCheck);
            con.cmd.Parameters.AddWithValue("@pucFileName", pucFileNameCheck);
            con.cmd.Parameters.AddWithValue("@fitnessCertificateFileName", fitnessCertificateFileNameCheck);
            con.cmd.Parameters.AddWithValue("@vehicleNo", "");
            con.cmd.Parameters.AddWithValue("@VendorID", "");
            con.cmd.Parameters.AddWithValue("@vehicleCategory", "");
            con.cmd.Parameters.AddWithValue("@vehicleTypeID", "");
            con.cmd.Parameters.AddWithValue("@useForPickup", "");
            con.cmd.Parameters.AddWithValue("@useForDelivery", "");
            con.cmd.Parameters.AddWithValue("@useForRoute", "");

            con.cmd.Parameters.AddWithValue("@branchID", "");
            con.cmd.Parameters.AddWithValue("@userID", "");
            con.cmd.Parameters.AddWithValue("@CreationDateTime", "");
            con.cmd.ExecuteNonQuery();

            if (CFunctions.tabstatus == 0)
            {
                cmf.showalert("Button_Submit1", "SAVE", this);
            }
            else if (CFunctions.tabstatus == 1)
            {
                cmf.showalert("Button_Submit1", "UPDATE", this);
            }
            CFunctions.setTab(1);
            CFunctions.setTabStatus(0);

            ClearTextVehicleDetails();
            ClearTextVSupportingDetails();
            ActiveAllDetails();

            Txt_NewVehicleNoAlpha1.Enabled = true;
            Txt_NewVehicleNoDigit1.Enabled = true;
            Txt_NewVehicleNoAlpha2.Enabled = true;
            Txt_NewVehicleNoDigit2.Enabled = true;

            cmf.ButtonopacityHideShow(1, "SAVE", Button_Tab1Save);
            cmf.ButtonopacityHideShow(1, "RESET", Btn_VehicleReset);
            cmf.ButtonopacityHideShow(1, "RESET", Btn_SupportingReset);
            cmf.ButtonopacityHideShow(0, "NEXT", Btn_VehicleNext);
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

    #endregion

    //Supporting Detail Reset 
    protected void Btn_SupportingReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_SupportingReset.Value == "1")
        {
            ClearTextVSupportingDetails();

            HiddenField_Btn_SupportingReset.Value = "";
        }
    }

    /***********************************************************End Tab3 Code**************************************************************************************/
    #endregion

    #region    /***********************************************************Start Tab4 Code**************************************************************************************/

    //#region    /*-----------------------------------------Seachable Vehicle No Dropdownlist Code-------------------------------------------------------------*/
    //protected void RadioButtonList_SearchVehicleNo_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_SearchVehicleNo.Value == "1")
    //    {
    //        cmf.DataList_SelectedIndexChanging(RadioButtonList_SearchVehicleNo, TXt_SearchVehicleNo);
    //        if (TXt_SearchVehicleNo.Text.ToString() == "SELECT")
    //        {
    //            TXt_SearchVehicleNo.Focus();
    //        }
    //        else
    //        {
    //            Txt_SearchTransporterName.Focus();
    //        }
    //        //for (int i = 0; i < RadioButtonList_SearchVehicleNo.Items.Count; i++)
    //        //{
    //        //    if (RadioButtonList_SearchVehicleNo.Items[i].Selected)
    //        //    {
    //        //        TXt_SearchVehicleNo.Text = RadioButtonList_SearchVehicleNo.Items[i].Text;

    //        //        if (TXt_SearchVehicleNo.Text.ToString() == "SELECT")
    //        //        {
    //        //            TXt_SearchVehicleNo.Focus();
    //        //        }
    //        //        else
    //        //        {
    //        //            Txt_SearchTransporterName.Focus();
    //        //        }
    //        //    }
    //        //}

    //        PopupControlExtender_SearchVehicleNo.Commit(RadioButtonList_SearchVehicleNo.SelectedValue);

    //        HiddenField_RadioButtonList_SearchVehicleNo.Value = "";
    //    }


    //}
    //protected void Txt_SearchVehicleNo_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_SearchVehicleNo_Search.Value == "1")
    //    {
    //        if (Txt_SearchVehicleNo_Search.Text != "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_SearchVehicleNo_Search, RadioButtonList_SearchVehicleNo, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_SearchableVehicleNo", "@Name", Txt_SearchVehicleNo_Search.Text.ToString(), "@check", "", "vehicleNo", "vehicleNo", TXt_SearchVehicleNo);
    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_SearchVehicleNo, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_SearchableVehicleNo", "@Name", Txt_SearchVehicleNo_Search.Text.ToString(), "@check", "", "vehicleNo", "vehicleNo");
    //            //Txt_SearchVehicleNo_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_SearchVehicleNo.Items.Count; i++)
    //            //{
    //            //    if (TXt_SearchVehicleNo.Text == RadioButtonList_SearchVehicleNo.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_SearchVehicleNo.Items[i].Selected = true;
    //            //    }

    //            //}

    //        }
    //        else if (Txt_SearchVehicleNo_Search.Text == "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_SearchVehicleNo_Search, RadioButtonList_SearchVehicleNo, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_SearchableVehicleNo", "@Name", "", "@check", "", "vehicleNo", "vehicleNo", TXt_SearchVehicleNo);

    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_SearchVehicleNo, "spBindDropdownListVehicleMaster", "@Event", "View_SearchableVehicleNo", "@Name", "", "@check", "", "vehicleNo", "vehicleNo");
    //            //Txt_SearchVehicleNo_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_SearchVehicleNo.Items.Count; i++)
    //            //{
    //            //    if (TXt_SearchVehicleNo.Text == RadioButtonList_SearchVehicleNo.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_SearchVehicleNo.Items[i].Selected = true;
    //            //    }

    //            //}

    //        }

    //        HiddenField_Txt_SearchVehicleNo_Search.Value = "";
    //    }


    //}
    //#endregion


    //#region    /*-----------------------------------------Seachable Transporter Name Dropdownlist Code-------------------------------------------------------------*/
    //protected void RadioButtonList_SearchTransporterName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_SearchTransporterName.Value == "1")
    //    {
    //        cmf.DataList_SelectedIndexChanging(RadioButtonList_SearchTransporterName, Txt_SearchTransporterName);
    //        if (Txt_SearchTransporterName.Text.ToString() == "SELECT")
    //        {
    //            Txt_SearchTransporterName.Focus();
    //        }
    //        else
    //        {
    //            Ddl_SearchCategory.Focus();
    //        }
    //        //for (int i = 0; i < RadioButtonList_SearchTransporterName.Items.Count; i++)
    //        //{
    //        //    if (RadioButtonList_SearchTransporterName.Items[i].Selected)
    //        //    {
    //        //        Txt_SearchTransporterName.Text = RadioButtonList_SearchTransporterName.Items[i].Text;

    //        //        if (Txt_SearchTransporterName.Text.ToString() == "SELECT")
    //        //        {
    //        //            Txt_SearchTransporterName.Focus();
    //        //        }
    //        //        else
    //        //        {
    //        //            Ddl_SearchCategory.Focus();
    //        //        }

    //        //    }
    //        //}
    //        PopupControlExtender_SearchTransporterName.Commit(RadioButtonList_SearchTransporterName.SelectedValue);

    //        HiddenField_RadioButtonList_SearchTransporterName.Value = "";
    //    }


    //}
    //protected void Txt_SearchTransporterName_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_SearchTransporterName_Search.Value == "1")
    //    {
    //        if (Txt_SearchTransporterName_Search.Text != "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_SearchTransporterName_Search, RadioButtonList_SearchTransporterName, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_SearchableTransportarName", "@Name", Txt_SearchTransporterName_Search.Text.ToString(), "@check", "", "transporterName", "transporterName", Txt_SearchTransporterName);
    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_SearchTransporterName, "spBindDropdownListVehicleMaster", "@Event", "View_Searchable_SearchableTransportarName", "@Name", Txt_SearchTransporterName_Search.Text.ToString(), "@check", "", "transporterName", "transporterName");
    //            //Txt_SearchTransporterName_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_SearchTransporterName.Items.Count; i++)
    //            //{
    //            //    if (Txt_SearchTransporterName.Text == RadioButtonList_SearchTransporterName.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_SearchTransporterName.Items[i].Selected = true;


    //            //    }

    //            //}

    //        }
    //        else if (Txt_SearchTransporterName_Search.Text == "")
    //        {
    //            cmf.Datalist_Searchable("", Txt_SearchTransporterName_Search, RadioButtonList_SearchTransporterName, null, null, "spBindDropdownListVehicleMaster", "@Event", "View_SearchableTransportarName", "@Name", "", "@check", "", "transporterName", "transporterName", Txt_SearchTransporterName);

    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_SearchTransporterName, "spBindDropdownListVehicleMaster", "@Event", "View_SearchableTransportarName", "@Name", "", "@check", "", "transporterName", "transporterName");
    //            //Txt_SearchTransporterName_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_SearchTransporterName.Items.Count; i++)
    //            //{
    //            //    if (Txt_SearchTransporterName.Text == RadioButtonList_SearchTransporterName.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_SearchTransporterName.Items[i].Selected = true;
    //            //    }

    //            //}

    //        }

    //        HiddenField_Txt_SearchTransporterName_Search.Value = "";
    //    }


    //}

    //#endregion

    #region    //Search Data
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Search.Value == "1")
        {
            FillGrid();
            ViewData.Visible = true;
            HiddenField_Btn_Search.Value = "";
        }
    }

    //Searchable View Function
    //private void SearchableView()
    //{
    //    /*if (con.con.State == ConnectionState.Closed)
    //    {
    //        con.open();
    //    }*/
    //    String SVehicleNo = TXt_SearchVehicleNo.Text.ToString().Trim();
    //    String STransportarName = Txt_SearchTransporterName.Text.ToString().Trim();
    //    String SVehicleCategory = Ddl_SearchCategory.SelectedValue.ToString().Trim();
    //    cmf.SearchData(GV_VehicleMaster, GV_Export, "spSearchDataVehicleMaster", "@vehicleNo", SVehicleNo, "@transportarName", STransportarName, "@vehicleCategory", SVehicleCategory, "", "", "", "", "", "");


    //    /* con.cmd = new SqlCommand("spSearchDataVehicleMaster", con.con);
    //     con.cmd.CommandType = CommandType.StoredProcedure;
    //     con.cmd.Parameters.AddWithValue("@vehicleNo", SVehicleNo);
    //     con.cmd.Parameters.AddWithValue("@transportarName", STransportarName);
    //     con.cmd.Parameters.AddWithValue("@vehicleCategory", SVehicleCategory);
    //     con.DA = new SqlDataAdapter(con.cmd);
    //     con.Dt = new DataTable();
    //     con.DA.Fill(con.Dt);
    //     GV_VehicleMaster.DataSource = con.Dt;
    //     GV_VehicleMaster.DataBind();
    //     GV_Export.DataSource = con.Dt;
    //     GV_Export.DataBind();
    //     con.close();*/
    //}
    #endregion

    //Edit Data
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Edit_Data_Click(object sender, EventArgs e)
    {
        //ClearTextVehicleDetails();

        CFunctions.setTab(1);
        CFunctions.setTabStatus(1);
        Btn_VehicleReset.Enabled = false;
        CFunctions.setID(Convert.ToInt32((sender as LinkButton).CommandArgument));
        LoadFinalDataIntoText();
        ActiveAllDetails();

        Txt_NewVehicleNoAlpha1.Enabled = false;
        Txt_NewVehicleNoDigit1.Enabled = false;
        Txt_NewVehicleNoAlpha2.Enabled = false;
        Txt_NewVehicleNoDigit2.Enabled = false;

        cmf.ButtonopacityHideShow(1, "UPDATE", Button_Tab1Save);
        cmf.ButtonopacityHideShow(1, "NEXT", Btn_VehicleNext);
        cmf.ButtonopacityHideShow(0, "RESET", Btn_VehicleReset);
        cmf.ButtonopacityHideShow(0, "RESET", Btn_SupportingReset);
    }

    #region    Grid View / Expot To Excel
    protected void GV_VehicleMaster_Sorting(object sender, GridViewSortEventArgs e)
    {
        FillGrid(e.SortExpression);
    }

    protected void GV_VehicleMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_VehicleMaster.PageIndex = e.NewPageIndex;
        FillGrid();
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
        string FileName = "Vehicle_Creation" + CurrentDateTime + ".xls";
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
    #endregion

    #endregion
}



