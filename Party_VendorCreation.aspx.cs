using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
//using CheckTabAndButtonStatus1;
using System.IO;
//using NameSpaceConnection;
//using NameSpaceCommonFunctions;
//using NameSpacePartyMaster;
using CommonLibrary;
using System.Web.Services;
using BLFunctions;
using BLProperties;
//using CheckTabAndButtonStatus1;
//using insertupdate;
//using ClassLibraryFunction;
public partial class OPERATIONS_party_master_VendorCreation : System.Web.UI.Page
{
    String result = "";
    /*
      - result store Code Alpha Value*/

    /*Create Object of Connecton and BindDropdownlist Class*/
    Connection con = new Connection();
    SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    CommonFunctions cmf = new CommonFunctions();/*temp base*/
    InsertUpdateProcedureWithParameters InsertUpdate = new InsertUpdateProcedureWithParameters();
    CFunctions cmf1 = new CFunctions();
    //PartyCustomerAndVendorMasterClass pm = new PartyCustomerAndVendorMasterClass();
    //  BindDropdownlist bd = new BindDropdownlist();
    static String fileName1;
    static String fileName2;
    static String fileName3;
    static String fileName4;
    static String fileName5;
    static String fileName6;
    static String fileName7;
    static String fileName8;
    static String fileName9;
    static String fileName10;

    #region   /*---------------------------------------------------------------------------Page Load---------------------------------------------------------------------------------*/
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoClear();

        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {   /*Auto Focus*/
                Txt_VendorName.Focus();
                /*Enable false button*/
                cmf.ButtonopacityHideShow(0, "NEXT", Btn_VendorNext);

                /*Set Variable*/
                CFunctions.setTab(1);
                CFunctions.setTabStatus(0);

                /*Calling DropBindDropdownDoubleParameter using object of BindDropdownlist*/
                GetBranchList();
            
               
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        (new CFunctions()).GetJavascriptFunction(this, "Txt_Pincode", "hfPincode", "Party_CustomerCreation.aspx/getPincode", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    #endregion

    #region /*------------------------------------------------------------------------All Function Defination---------------------------------------------------------------------------*/
    public void GetBranchList()
    {
        Ddl_BranchName.DataSource = (new CommFunctions()).GetBranch();
        Ddl_BranchName.DataTextField = "branchName";
        Ddl_BranchName.DataValueField = "branchId";
        Ddl_BranchName.DataBind();
        Ddl_BranchName.Items.Insert(0, "SELECT");
    }
    /*----------------Auto Complete Code false--------------------*/

    public void AutoClear()
    {
        Txt_VendorName.Attributes.Add("autocomplete", "off");
        Txt_VendorContactNo.Attributes.Add("autocomplete", "off");
        Txt_VendorBillingAddress.Attributes.Add("autocomplete", "off");
        Txt_OwnerPersonName.Attributes.Add("autocomplete", "off");
        Txt_OwnerPersonContactNo.Attributes.Add("autocomplete", "off");
        Txt_OwnerPersonEmailId.Attributes.Add("autocomplete", "off");
        Txt_VendorPanCardNo.Attributes.Add("autocomplete", "off");
        Txt_VendorAadhaarCardNo.Attributes.Add("autocomplete", "off");
        Txt_VendorGSTCertificates.Attributes.Add("autocomplete", "off");
        Txt_VendorCIN.Attributes.Add("autocomplete", "off");
        Txt_OwnerPersonPanCardNo.Attributes.Add("autocomplete", "off");
        Txt_OwnerAdharcardNo.Attributes.Add("autocomplete", "off");
    }

    /*----------------Fill Data in Gridview Code--------------------*/
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    private void FillGrid(string sortExpression = null)
    {
        String VendorName = Txt_SearchVendorName.Text.ToString() == "" ? null : Txt_SearchVendorName.Text.ToString();
        String vendorType = Ddl_SearchVendorTypes.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchVendorTypes.SelectedItem.ToString();
        if ((VendorName != null) || (vendorType != null))
        {
            if (con1.State == ConnectionState.Closed)
            {
                con1.Open();
            }
            con.cmd = new SqlCommand("ssp_ViewVendor", con1);
            con.cmd.CommandType = CommandType.StoredProcedure;
            con.cmd.Parameters.AddWithValue("@VendorType", vendorType);
            con.cmd.Parameters.AddWithValue("@VendorName", VendorName);
            con.DA = new SqlDataAdapter(con.cmd);
            con.Dt = new DataTable();
            con.DA.Fill(con.Dt);
            if (sortExpression != null)
            {
                DataView dv = con.Dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                GV_PartyVendorMaster.DataSource = dv;
                // GV_Export.DataSource = dv;
            }
            else

            {
                GV_PartyVendorMaster.DataSource = con.Dt;
                //  GV_Export.DataSource = con.Dt;
            }
            GV_PartyVendorMaster.DataBind();
            //  GV_Export.DataBind();
        }

    }
    /*----------------ClearText OR Disable Code--------------------*/
    //Vendor Tab1 Clear Data
    protected void ClearTextVendorCreationDetails()
    {
        Ddl_VendorType.SelectedIndex = 1;
        Txt_VendorName.Text = "";
        Txt_VendorContactNo.Text = "";
        Txt_Pincode.Text = "";
        Txt_State.Text = "AUTO";
        Txt_District.Text = "AUTO";
        Txt_City.Text = "AUTO";
        Txt_VendorBillingAddress.Text = "";

        Ddl_BranchName.SelectedIndex = 0;
        Ddl_VendorCategory.SelectedIndex = 0;

        Txt_OwnerPersonName.Text = "";
        Txt_OwnerPersonContactNo.Text = "";
        Txt_OwnerPersonEmailId.Text = "";
        ViewData.Visible = false;
    }
    //Vendor Tab1 Disable Data
    protected void DisableVendorCreationDetails()
    {
        Ddl_VendorType.Attributes.Add("disabled", "disabled");
        Txt_VendorName.Enabled = false;
        Txt_VendorContactNo.Enabled = false;
        Txt_Pincode.Enabled = false;
        Ddl_Area.Enabled = false;
        Txt_VendorBillingAddress.Enabled = false;
        Ddl_BranchName.Enabled = false;
        Ddl_VendorCategory.Attributes.Add("disabled", "disabled");
        Txt_OwnerPersonName.Enabled = false;
        Txt_OwnerPersonContactNo.Enabled = false;
        Txt_OwnerPersonEmailId.Enabled = false;
    }


    //Vendor tab2 Upload Clear data
    protected void ClearTextUploadDocumentDetails()
    {
        // Upload File Tab1 to Tab4
        //Tab1 Doc Upload
        Txt_VendorPanCardNo.Text = "";
        Vendor_PanCard_Label.InnerHtml = "";
        Txt_VendorAadhaarCardNo.Text = "";
        Vendor_AadhaarCard_Label.InnerHtml = "";
        Txt_VendorGSTCertificates.Text = "";
        Vendor_GST_Label.InnerHtml = "";
        Txt_VendorCIN.Text = "";
        Vendor_CIN_Label.InnerHtml = "";
        Txt_OwnerPersonPanCardNo.Text = "";
        Owner_PanCard_Label.InnerHtml = "";
        Txt_OwnerAdharcardNo.Text = "";
        Owner_AadhaarCard_Label.InnerHtml = "";

        ViewData.Visible = false;
    }
    //Active All TextField
    protected void ActiveAllTextFields()
    {
        //Tab1
        Ddl_VendorType.Attributes.Remove("disabled");
        Txt_VendorName.Enabled = true;
        Txt_VendorContactNo.Enabled = true;
        Txt_Pincode.Enabled = true;
        Ddl_BranchName.Enabled = true;
        Txt_VendorBillingAddress.Enabled = true;
        Ddl_Area.Enabled = true;
        Ddl_VendorCategory.Attributes.Remove("disabled");
        Txt_OwnerPersonName.Enabled = true;
        Txt_OwnerPersonContactNo.Enabled = true;
        Txt_OwnerPersonEmailId.Enabled = true;
    }
    /*----------------Load Data Into Text Code--------------------*/
    public void LoadFinalDataIntoText()
    {
        if (con1.State == ConnectionState.Closed)
        {
            con1.Open();
        }
        con.cmd = new SqlCommand("ssp_GetVendorCreation", con1);
        con.cmd.CommandType = CommandType.StoredProcedure;
        con.cmd.Parameters.AddWithValue("@VendorID", CFunctions.ID);
        con.DA = new SqlDataAdapter(con.cmd);
        con.Dt = new DataTable();
        con.DA.Fill(con.Dt);
        GV_PartyVendorMaster.DataSource = con.Dt;
        if (con.Dt.Rows.Count > 0)
        {
            Ddl_VendorType.Text = con.Dt.Rows[0]["vendorType"].ToString();
            Txt_VendorName.Text = con.Dt.Rows[0]["vendorName"].ToString();
            Txt_VendorContactNo.Text = con.Dt.Rows[0]["vendorContactNo"].ToString();
            Txt_Pincode.Text = con.Dt.Rows[0]["locPincode"].ToString();
            Txt_State.Text = con.Dt.Rows[0]["stateName"].ToString();
            Txt_District.Text = con.Dt.Rows[0]["districtName"].ToString();
            Txt_City.Text = con.Dt.Rows[0]["cityName"].ToString();
            Ddl_Area.Text = con.Dt.Rows[0]["areaName"].ToString();

            Txt_VendorBillingAddress.Text = con.Dt.Rows[0]["billingAddress"].ToString();
            Ddl_BranchName.SelectedItem.Text = con.Dt.Rows[0]["BelongToBranchID"].ToString();

            Ddl_VendorCategory.Text = con.Dt.Rows[0]["category"].ToString();
            Txt_OwnerPersonName.Text = con.Dt.Rows[0]["OwnerName"].ToString();

            Txt_OwnerPersonContactNo.Text = con.Dt.Rows[0]["OwnerContactNo"].ToString();
            Txt_OwnerPersonEmailId.Text = con.Dt.Rows[0]["OwnerEmailID"].ToString();

            Txt_VendorPanCardNo.Text = con.Dt.Rows[0]["vendorPancardNo"].ToString();
            Txt_VendorAadhaarCardNo.Text = con.Dt.Rows[0]["vendorAadharCardNo"].ToString();
            Txt_VendorGSTCertificates.Text = con.Dt.Rows[0]["GSTCertificateNo"].ToString();
            Txt_VendorCIN.Text = con.Dt.Rows[0]["CIN"].ToString();

            Vendor_PanCard_Label.InnerHtml = con.Dt.Rows[0]["PancardNoFileName"].ToString();
            Vendor_PanCard_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["PancardNoFileName"].ToString());

            Vendor_AadhaarCard_Label.InnerHtml = con.Dt.Rows[0]["AadharCardNoFileName"].ToString();
            Vendor_AadhaarCard_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["AadharCardNoFileName"].ToString());

            Vendor_GST_Label.InnerHtml = con.Dt.Rows[0]["GSTFileName"].ToString();
            Vendor_GST_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["GSTFileName"].ToString());

            Vendor_CIN_Label.InnerHtml = con.Dt.Rows[0]["CINFileName"].ToString();
            Vendor_CIN_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["CINFileName"].ToString());

            Txt_OwnerPersonPanCardNo.Text = con.Dt.Rows[0]["OwnerPancardNo"].ToString();
            Txt_OwnerAdharcardNo.Text = con.Dt.Rows[0]["OwnerAadharCardNo"].ToString();

            Owner_PanCard_Label.InnerHtml = con.Dt.Rows[0]["OwnerPancardFileName"].ToString();
            Owner_PanCard_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["OwnerPancardFileName"].ToString());

            Owner_AadhaarCard_Label.InnerHtml = con.Dt.Rows[0]["OwnerAadharCardFileName"].ToString();
            Owner_AadhaarCard_Label.Attributes.Add("href", "~/FileUpload/" + con.Dt.Rows[0]["OwnerAadharCardFileName"].ToString());
        }
    }
    #endregion

    #region    /*----------------------------------------------------------------------Tab1 Start Code / Vendor Creation--------------------------------------------------------------------*/


    #region    /*Auto Field State,District,City,Area Where Pincode is Selected*/

    // Get Pincode
    [WebMethod]
    public static string[] getPincode(string searchPrefixText, string data=null)
    {
        return (new CommFunctions()).getPincode(searchPrefixText,data);
    }

    [WebMethod]
    public static string[] PincodeDetail(int pincode)
    {
        return (new CommFunctions()).PincodeDetail(pincode);
    }

    [WebMethod]
    public static List<FullAddress> getArea(int pincode)
    {
        return (new CommFunctions()).getArea(pincode);
    }

    //protected void RadioButtonList_VendorPinCode_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_RadioButtonList_VendorPinCode.Value=="1")
    //    {
    //        cmf.DataList_SelectedIndexChanging(RadioButtonList_VendorPinCode, Txt_VendorPinCode);
    //        if (Txt_VendorPinCode.Text.ToString() != "SELECT")
    //        {
    //            cmf.bindFourValueUsingoneCode(RadioButtonList_VendorPinCode, "ssp_GetPincodeDetails", "@pincode", Txt_VendorPinCode.Text.ToString(), "", "", "", "", Txt_VendorState, "stateName", Txt_VendorDistrict, "districtName", Txt_VendorCity, "cityName", null, "");
    //            cmf.BindDataValueInListTripleParameter("area", RadioButtonList_VendorArea, null, null, "ssp_GetPincodeAreaList", "", "", "@locPincode", Txt_VendorPinCode.Text.ToString(), "", "", "areaName", "locAreaID", Txt_VendorArea);
    //            RadioButtonList_VendorArea.SelectedIndex = 0;
    //            Txt_VendorArea.Text = "SELECT";
    //            Img_AddArea.Visible = true;
    //            Demo_AREA.Visible = false;
    //            AREA.Visible = true;
    //            Txt_VendorTaluka.Focus();
    //        }
    //        else
    //        {
    //            Txt_VendorPinCode.Focus();
    //            Txt_VendorState.Text = "AUTO";
    //            Txt_VendorDistrict.Text = "AUTO";
    //            Txt_VendorCity.Text = "AUTO";
    //            Txt_VendorArea.Text = "SELECT";
    //            RadioButtonList_VendorArea.SelectedIndex = 0;
    //            Img_AddArea.Visible = false;
    //            Demo_AREA.Visible = true;
    //            AREA.Visible = false;
    //        }
    //        //for (int i = 0; i < RadioButtonList_VendorPinCode.Items.Count; i++)
    //        //{
    //        //    if (RadioButtonList_VendorPinCode.Items[i].Selected)
    //        //    {
    //        //        Txt_VendorPinCode.Text = RadioButtonList_VendorPinCode.Items[i].Text;

    //        //        if (con.con.State == ConnectionState.Closed)
    //        //        {
    //        //            con.open();
    //        //        }
    //        //        if (Txt_VendorPinCode.Text.ToString() != "SELECT")
    //        //        {
    //        //            con.cmd = new SqlCommand("spBindDropdownListORAuto", con.con);
    //        //            con.cmd.CommandType = CommandType.StoredProcedure;
    //        //            con.cmd.Parameters.AddWithValue("@Event", "Field_SDC");
    //        //            con.cmd.Parameters.AddWithValue("@SDC", Txt_VendorPinCode.Text.ToString());
    //        //            con.cmd.Parameters.AddWithValue("@specificSearch", "");
    //        //            con.DA = new SqlDataAdapter(con.cmd);
    //        //            con.Dt = new DataTable();
    //        //            con.DA.Fill(con.Dt);
    //        //            RadioButtonList_VendorPinCode.DataSource = con.Dt;
    //        //            if (con.Dt.Rows.Count > 0)
    //        //            {
    //        //                Txt_VendorState.Text = con.Dt.Rows[0]["Delivery State"].ToString();
    //        //                Txt_VendorDistrict.Text = con.Dt.Rows[0]["Delivery  District"].ToString();
    //        //                Txt_VendorCity.Text = con.Dt.Rows[0]["Delivery City"].ToString();
    //        //            }
    //        //            bd.BindRadioButtonListTripleParameter(RadioButtonList_VendorArea, "spBindDropdownListORAuto", "@Event", "Area_Dropdown", "@SDC", Txt_VendorPinCode.Text.ToString(), "@specificSearch", "", "Delivery Area", "Delivery Area");
    //        //            RadioButtonList_VendorArea.SelectedIndex = 0;
    //        //            foreach (ListItem t in RadioButtonList_VendorArea.Items)
    //        //            {
    //        //                t.Text = t.Text.ToUpper();
    //        //            }
    //        //            Img_AddArea.Visible = true;
    //        //            Demo_AREA.Visible = false;
    //        //            AREA.Visible = true;
    //        //            Txt_VendorTaluka.Focus();
    //        //        }
    //        //        else
    //        //        {
    //        //            Txt_VendorPinCode.Focus();
    //        //            Txt_VendorState.Text = "AUTO";
    //        //            Txt_VendorDistrict.Text = "AUTO";
    //        //            Txt_VendorCity.Text = "AUTO";
    //        //            Txt_VendorArea.Text = "SELECT";
    //        //            RadioButtonList_VendorArea.SelectedIndex = 0;
    //        //            Img_AddArea.Visible = false;
    //        //            Demo_AREA.Visible = true;
    //        //            AREA.Visible = false;
    //        //        }
    //        //    }
    //        //}
    //        PopupControlExtender_VendorPinCode.Commit(RadioButtonList_VendorPinCode.SelectedValue);

    //        HiddenField_RadioButtonList_VendorPinCode.Value = "";
    //    }

    //}
    //protected void Txt_VendorPinCode_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_VendorPinCode_Search.Value=="1")
    //    {
    //        if (Txt_VendorPinCode_Search.Text != "")
    //        {
    //            cmf.Datalist_Searchable("",Txt_VendorPinCode_Search, RadioButtonList_VendorPinCode, null, null, "spBindDropdownListORAuto", "@Event", "Searchable_Pincode_Dropdown", "@specificSearch", Txt_VendorPinCode_Search.Text.ToString(), "@SDC", "", "Delivery Pincode", "Delivery Pincode", Txt_VendorPinCode);

    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_VendorPinCode, "spBindDropdownListORAuto", "@Event", "Searchable_Pincode_Dropdown", "@SDC", Txt_VendorPinCode_Search.Text, "@specificSearch", "", "Delivery Pincode", "Delivery Pincode");
    //            //Txt_VendorPinCode_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_VendorPinCode.Items.Count; i++)
    //            //{
    //            //    if (Txt_VendorPinCode.Text == RadioButtonList_VendorPinCode.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_VendorPinCode.Items[i].Selected = true;
    //            //    }

    //            //}
    //        }
    //        else if (Txt_VendorPinCode_Search.Text == "")
    //        {
    //            cmf.Datalist_Searchable("",Txt_VendorPinCode_Search, RadioButtonList_VendorPinCode, null, null, "spBindDropdownListORAuto", "@Event", "Pincode_Dropdown", "@specificSearch", "", "@SDC", "", "Delivery Pincode", "Delivery Pincode", Txt_VendorPinCode);

    //            //bd.BindRadioButtonListTripleParameter(RadioButtonList_VendorPinCode, "spBindDropdownListORAuto", "@Event", "Pincode_Dropdown", "@SDC", "", "@specificSearch", "", "Delivery Pincode", "Delivery Pincode");
    //            //Txt_VendorPinCode_Search.Focus();

    //            //for (int i = 0; i < RadioButtonList_VendorPinCode.Items.Count; i++)
    //            //{
    //            //    if (Txt_VendorPinCode.Text == RadioButtonList_VendorPinCode.Items[i].Text)
    //            //    {
    //            //        RadioButtonList_VendorPinCode.Items[i].Selected = true;
    //            //    }

    //            //}

    //        }

    //        HiddenField_Txt_VendorPinCode_Search.Value = "";
    //    }

    //}
    #endregion

    ///*Add New Area*/
    protected void Btn_PopupAreaSubmit_Click(object sender, EventArgs e)
    {
        if (con1.State == ConnectionState.Closed)
        {
            con1.Open();
        }
        con.cmd = new SqlCommand("spInsertArea", con1);
        con.cmd.CommandType = CommandType.StoredProcedure;
        con.cmd.Parameters.AddWithValue("@pincode", Txt_Pincode.Text.ToString());
        con.cmd.Parameters.AddWithValue("@area", Txt_popArea.Text.ToString().ToUpper());
        con.cmd.ExecuteNonQuery();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Insert Area Successfully!');", true);
    }
    //#endregion


    #region    /*Save Vendor Data In Table*/
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = cmf1.CurrentDateTime();

        if (CFunctions.tab == 1)
        {
            if (CFunctions.tabstatus == 0)
            {
                IDataReader reader = InsertUpdate.InsertUpdateParameters60("ssp_CreateOrUpdatePartyVendor", "@VendorTab", CFunctions.tab, "@Vendorcheck", CFunctions.tabstatus, "@vendorId", "", "@VendorType", Ddl_VendorType.SelectedItem.ToString().ToUpper(), "@vendorName", Txt_VendorName.Text.ToString().ToUpper(), "@vendorContactNo", Txt_VendorContactNo.Text.ToString().ToUpper(), "@locationID", hfPincode.Value.ToString(),
                  "@areaID", hfArea.Value.ToString(), "@billingAddress", Txt_VendorBillingAddress.Text.ToString().ToUpper(), "@belongToBranchID", Ddl_BranchName.SelectedValue.ToString(), "@category", Ddl_VendorCategory.SelectedItem.ToString().ToUpper(), "@VPancardNo", "", "@VAadharCardNo", "", "@VGSTCertificateNo", "", "@VCIN", "",
                  "@VPancardNoFileName", "", "@VAadharCardNoFileName", "", "@VGSTFileName", "", "@VCINFileName", "", "@OwnerName", Txt_OwnerPersonName.Text.ToString().ToUpper(), "@OwnerContactNo", Txt_OwnerPersonContactNo.Text.ToString(), "@OwnerEmailID", Txt_OwnerPersonEmailId.Text.ToString(),
                  "@OwnerPancardNo", "", "@OwnerAadharCardNo", "", "@OwnerPancardNoFileName", "", "@OwnerAadharCardNoFileName", "", "@BranchID", Session["BranchId"].ToString(), "@userID", Session["userID"].ToString(), "@creationDateTime", CurrentDateTime,
                   "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                if (reader.Read())
                {
                    CFunctions.setID(Convert.ToInt32(reader["id"]));
                }
                cmf.ButtonopacityHideShow(0, "SAVE", Button_Tab1Save);
                cmf.ButtonopacityHideShow(0, "RESET", Btn_ResetVendorCreation);
                cmf.ButtonopacityHideShow(1, "NEXT", Btn_VendorNext);

                cmf.showalert("Button_Tab1Save", "SAVE", this);
				HttpContext.Current.Application["VendorName"] = null;
            }
            else if (CFunctions.tabstatus == 1)
            {
                InsertUpdate.InsertUpdateParameters60("ssp_CreateOrUpdatePartyVendor", "@VendorTab", CFunctions.tab, "@Vendorcheck", CFunctions.tabstatus, "@vendorId", CFunctions.ID, "@VendorType", Ddl_VendorType.SelectedItem.ToString().ToUpper(), "@vendorName", Txt_VendorName.Text.ToString().ToUpper(), "@vendorContactNo", Txt_VendorContactNo.Text.ToString().ToUpper(), "@locationID", hfPincode.Value.ToString(),
               "@areaID", hfArea.Value.ToString(), "@billingAddress", Txt_VendorBillingAddress.Text.ToString().ToUpper(), "@belongToBranchID", Ddl_BranchName.SelectedValue.ToString(), "@category", Ddl_VendorCategory.SelectedItem.ToString().ToUpper(), "@VPancardNo", "", "@VAadharCardNo", "", "@VGSTCertificateNo", "", "@VCIN", "",
               "@VPancardNoFileName", "", "@VAadharCardNoFileName", "", "@VGSTFileName", "", "@VCINFileName", "", "@OwnerName", Txt_OwnerPersonName.Text.ToString().ToUpper(), "@OwnerContactNo", Txt_OwnerPersonContactNo.Text.ToString(), "@OwnerEmailID", Txt_OwnerPersonEmailId.Text.ToString(),
               "@OwnerPancardNo", "", "@OwnerAadharCardNo", "", "@OwnerPancardNoFileName", "", "@OwnerAadharCardNoFileName", "", "@BranchID", "", "@userID", "", "@creationDateTime", "",
                "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

                cmf.ButtonopacityHideShow(0, "UPDATE", Button_Tab1Save);
                cmf.showalert("Button_Tab1Save", "UPDATE", this);
				HttpContext.Current.Application["VendorName"] = null;
            }
        }
		HttpContext.Current.Application["VendorName"] = null;
        DisableVendorCreationDetails();
        //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchVendorName, "ssp_GetVendorList", "", "", "", "", "", "", "vendorName", "vendorID", null);
        // cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchBranch, "ssp_GetBranchList", "", "", "", "", "", "", "branchName", "branchID", null);
    }
    #endregion
    /*Reset Button Code*/
    protected void Btn_ResetVendorCreation_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_ResetVendorCreation.Value == "1")
        {
            ClearTextVendorCreationDetails();
            Ddl_VendorType.Focus();

            HiddenField_Btn_ResetVendorCreation.Value = "";
        }
    }
    protected void Btn_VendorNext_Click(object sender, EventArgs e)
    {
        Txt_OwnerPersonName.Focus();
    }

    /*----------------------------------------------------------------------Tab1 End Code--------------------------------------------------------------------*/
    #endregion


    #region    /*---------------------------------------------------------------Tab2 Start Code / UploadDocument / SaveButton-------------------------------------------------------------*/


    #region    /*File Upload Section Start*/
    /* Ajax File Upload Start*/

    /*  Vendor  */
    protected void Vendor_PanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vendor_PanCard_Uploader.SaveAs(fileNameToUpload);
        fileName1 = e.FileName.ToString();
    }

    protected void Vendor_AadhaarCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vendor_AadhaarCard_Uploader.SaveAs(fileNameToUpload);
        fileName2 = e.FileName.ToString();
    }

    protected void Vendor_GST_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vendor_GST_Uploader.SaveAs(fileNameToUpload);
        fileName3 = e.FileName.ToString();
    }

    protected void Vendor_CIN_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Vendor_CIN_Uploader.SaveAs(fileNameToUpload);
        fileName4 = e.FileName.ToString();
    }
    /*  Owner */
    protected void Owner_PanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Owner_PanCard_Uploader.SaveAs(fileNameToUpload);
        fileName5 = e.FileName.ToString();
    }
    protected void Owner_AadhaarCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Owner_AadhaarCard_Uploader.SaveAs(fileNameToUpload);
        fileName6 = e.FileName.ToString();
    }
    /* Ajax File Upload Start*/

    /*File Upload Section End*/
    #endregion

    #region   //Save All Document
    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        if (HiddenField_Button_Submit1.Value == "1")
        {
            string VPancardNoFileNameCheck;
            string VAadharCardNoFileNameCheck;
            string VGSTFileNameCheck;
            string VCINFileNameCheck;
            string VoPancardNoFileNameCheck;
            string VoAadharCardNoFileNameCheck;

            if (fileName1 == null)
            {
                VPancardNoFileNameCheck = "";
            }
            else
            {
                VPancardNoFileNameCheck = fileName1;
            }

            if (fileName2 == null)
            {
                VAadharCardNoFileNameCheck = "";
            }
            else
            {
                VAadharCardNoFileNameCheck = fileName2;
            }
            if (fileName3 == null)
            {
                VGSTFileNameCheck = "";
            }
            else
            {
                VGSTFileNameCheck = fileName3;
            }
            if (fileName4 == null)
            {
                VCINFileNameCheck = "";
            }
            else
            {
                VCINFileNameCheck = fileName4;
            }
            if (fileName5 == null)
            {
                VoPancardNoFileNameCheck = "";
            }
            else
            {
                VoPancardNoFileNameCheck = fileName5;
            }
            if (fileName6 == null)
            {
                VoAadharCardNoFileNameCheck = "";
            }
            else
            {
                VoAadharCardNoFileNameCheck = fileName6;
            }

            if (con.con.State == ConnectionState.Closed)
            {
                con.open();
            }
            CFunctions.setTab(2);
            if (CFunctions.tab == 2)
            {

                InsertUpdate.InsertUpdateParameters60("ssp_CreateOrUpdatePartyVendor", "@VendorTab", CFunctions.tab, "@Vendorcheck", CFunctions.tabstatus, "@vendorId", CFunctions.ID, "@VendorType", "", "@vendorName", "", "@vendorContactNo", "", "@locationID", "",
               "@areaID", "", "@billingAddress", "", "@belongToBranchID", "", "@category", "", "@VPancardNo", Txt_VendorPanCardNo.Text.ToString().ToUpper(), "@VAadharCardNo", Txt_VendorAadhaarCardNo.Text.ToString().ToUpper(), "@VGSTCertificateNo", Txt_VendorGSTCertificates.Text.ToString().ToUpper(), "@VCIN", Txt_VendorCIN.Text.ToString().ToUpper(),
               "@VPancardNoFileName", VPancardNoFileNameCheck, "@VAadharCardNoFileName", VAadharCardNoFileNameCheck, "@VGSTFileName", VGSTFileNameCheck, "@VCINFileName", VCINFileNameCheck, "@OwnerName", "", "@OwnerContactNo", "", "@OwnerEmailID", "",
               "@OwnerPancardNo", Txt_OwnerPersonPanCardNo.Text.ToString().ToUpper(), "@OwnerAadharCardNo", Txt_OwnerAdharcardNo.Text.ToString().ToUpper(), "@OwnerPancardNoFileName", VoPancardNoFileNameCheck, "@OwnerAadharCardNoFileName", VoAadharCardNoFileNameCheck, "@BranchID", "", "@userID", "", "@creationDateTime", "",
                "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                if (CFunctions.tabstatus == 0)
                {
                    cmf.showalert("Button_Submit1", "SAVE", this);
                }
                else if (CFunctions.tabstatus == 1)
                {
                    cmf.showalert("Button_Submit1", "UPDATE", this);

                }

                Ddl_VendorType.Attributes.Remove("disabled");
                Txt_VendorName.Enabled = true;
                CFunctions.setTabStatus(0);
                CFunctions.setTab(1);
                ClearTextVendorCreationDetails();
                ClearTextUploadDocumentDetails();
                ActiveAllTextFields();

                cmf.ButtonopacityHideShow(0, "NEXT", Btn_VendorNext);
                cmf.ButtonopacityHideShow(1, "SAVE", Button_Tab1Save);
                cmf.ButtonopacityHideShow(1, "RESET", Btn_ResetVendorCreation);
				HttpContext.Current.Application["VendorName"] = null;
            }
        }
        if (statusClass1.form == 1)
        {
            statusClass1.setform(0);
            if (Session["URI"] != null)
            {
                Response.Redirect(Session["URI"].ToString());
            }
        }
        HiddenField_Button_Submit1.Value = "";
    }
    protected void Btn_DocumentReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_DocumentReset.Value == "1")
        {
            ClearTextUploadDocumentDetails();

            HiddenField_Btn_DocumentReset.Value = "";
        }
    }
    #endregion

    /*----------------------------------------------------------------------Tab2 End Code--------------------------------------------------------------------*/
    #endregion

    #region    /*------------------------------------------------------------Tab3 Start Code / Search / View / Export to Excel-----------------------------------------------------------------*/


    #region    //Search Data
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
       
            FillGrid();
      
        ViewData.Visible = true;
    }
    #endregion

    #region    //  tab6 Edit Final Data 
    protected void Edit_Data_Click(object sender, EventArgs e)
    {
        CFunctions.setTab(1);
        CFunctions.setTabStatus(1);

        Btn_ResetVendorCreation.Enabled = false;
        CFunctions.setID(Convert.ToInt32((sender as LinkButton).CommandArgument));
        ActiveAllTextFields();
        LoadFinalDataIntoText();

        cmf.ButtonopacityHideShow(1, "NEXT", Btn_VendorNext);
        cmf.ButtonopacityHideShow(1, "UPDATE", Button_Tab1Save);
        cmf.ButtonopacityHideShow(0, "RESET", Btn_ResetVendorCreation);
        Ddl_VendorType.Attributes.Add("disabled", "disabled");
        Txt_VendorName.Enabled = false;

    }
    #endregion


    #region    // Grid View / Export to Excel
    protected void GV_PartyVendorMaster_Sorting(object sender, GridViewSortEventArgs e)
    {
        FillGrid(e.SortExpression);

    }
    protected void GV_PartyVendorMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_PartyVendorMaster.PageIndex = e.NewPageIndex;
        if (Ddl_SearchVendorTypes.SelectedItem.Text == "SELECT" && Txt_SearchVendorName.Text.ToString() == "")
        {
        }
        else
        {
            FillGrid();
        }
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
        string FileName = "Vendor_Creation" + CurrentDateTime + ".xls";
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

    /*----------------------------------------------------------------------Tab6 End Code--------------------------------------------------------------------*/

    #endregion



}