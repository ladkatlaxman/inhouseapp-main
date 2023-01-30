using System;
//using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
//using System.Linq;
//using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using NameSpaceCommonFunctions;
using CommonLibrary;
using BLProperties;
using BLFunctions;
using System.Web.Services;
using System.Web;

public partial class Contract : System.Web.UI.Page
{
    CommonFunctions cmf = new CommonFunctions();
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    //SqlCommand cmd = null;
    //SqlDataReader dr = null;
    String partyType = "CUSTOMER";
    //decimal sumOfDieselRate = 0;
    //decimal dieselRate = 0;
    //decimal avgState = 0;
    //decimal rate = 0;
    //int s = 0;
    public static string materialID = string.Empty;
    public static string packageID = string.Empty;
    public static string editQuotation = string.Empty;
    public static string contractNoForEdit = string.Empty;
    public static string editBranch = string.Empty;
    string strPreviousRowID = string.Empty;
    int intSubTotalIndex = 1;
    //public static int ContractId;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            globalVar.code = "";
            globalVar.setBtnSubmit(0);
            fillRegions();
            // fillState();
            // FillMaterial();
            //FillPackage();
            GetBranchList();
            //  generateContractCode();
            //GetSearchCustomerList();
            ContractClass.setBtnSubmit(0);
            ContractClass.setTab1(0);
            ContractClass.setTab1Status(0);
            //  displayDataInView();
            Btn_CustomerContractNext.Enabled = false;
            Btn_CustomerContractNext.Style.Add("color", "white");
            Btn_CustomerContractNext.Style.Add("opacity", "0.3");
            Btn_CustomerContractNext.CssClass = "btn btn-info Btn_CustomerContractNext largeButtonStyle";

            cmf.ButtonopacityHideShow(0, "NEXT", Btn_Tab2Next);
            cmf.ButtonopacityHideShow(0, "NEXT", Btn_Tab3Next);

            //Btn_CommercialNext.Enabled = false;
            //Btn_CommercialNext.Style.Add("color", "white");
            //Btn_CommercialNext.Style.Add("opacity", "0.3");
            //Btn_CommercialNext.CssClass = "btn btn-info Btn_CommercialNext largeButtonStyle";

            //Btn_FSCNext.Enabled = false;
            //Btn_FSCNext.Style.Add("color", "white");
            //Btn_FSCNext.Style.Add("opacity", "0.3");
            //Btn_FSCNext.CssClass = "btn btn-info Btn_FSCNext largeButtonStyle";

            //Button_Submit1.Enabled = false;
            //Button_Submit1.Style.Add("color", "white");
            //Button_Submit1.Style.Add("opacity", "0.3");
            //Button_Submit1.CssClass = "btn btn-info Button_Submit1 largeButtonStyle";
            fillGrid();

            (new CFunctions()).dropdwnlist(null, null, Ddl_PopupRateType, null, "RateType", "Id", ((new RateCardFunctions()).getRateCardType()));
            (new CFunctions()).GetJavascriptFunction(this, "Txt_MaterialType", "hfMaterialID", "PickReqCRMBranch.aspx/getMaterial", "GetData", "});");
        }
        string str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
                    "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker();" + "\n" +
                     "$(\"[id$= Txt_signingDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker();" + "\n";

        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascriptFunction(this, "Txt_FromPincode", "hfFromPincode", "Party_CustomerCreation.aspx/getPincode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_ToPincode", "hfToPincode", "Party_CustomerCreation.aspx/getPincode", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_BillingPartyName", "hfBillingPartyName", "Contract.aspx/getBillingParty", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        fillGrid();
    }

    //public void generateContractCode()
    //{
    //    string result = "CNT";
    //    int h = 0;
    //    int m = 0;
    //    int s = 0;

    //    DateTime dt = DateTime.UtcNow.Date;
    //    result += dt.ToString("ddMMyy");
    //    h = DateTime.Now.Hour;
    //    m = DateTime.Now.Minute;
    //    s = DateTime.Now.Second;
    //    if (h < 10)
    //    {
    //        result += "0" + h;
    //    }
    //    else { result += h; }
    //    if (m < 10)
    //    {
    //        result += "0" + m;
    //    }
    //    else { result += m; }
    //    if (s < 10)
    //    {
    //        result += "0" + s;
    //    }
    //    else { result += s; }

    //    Txt_ContractNo.Text = result;
    //    // Txt_ComapnyCode.Text = result + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second;
    //}
    // Get Pincode


    //Get Billing Party Name in Dropdown List
    [WebMethod]
    public static string[] getBillingParty(string searchPrefixText, string data)
    {
        //return (new CustomerContractFunctions()).getBillingParty(searchPrefixText, data);
        return (new CustomerContractFunctions()).getNoContractBillingParty(searchPrefixText, data);
    }
    public void GetBranchList()
    {
        Ddl_BranchName.DataSource = (new CommFunctions()).GetBranch();
        Ddl_BranchName.DataTextField = "branchName";
        Ddl_BranchName.DataValueField = "branchId";
        Ddl_BranchName.DataBind();
        Ddl_BranchName.Items.Insert(0, "SELECT");
    }
    //public void GetSearchCustomerList()
    //{
    //    Ddl_SearchPartyName.DataSource = (new CustomerContractFunctions()).GetSearchContractCustomer();
    //    Ddl_SearchPartyName.DataTextField = "customerName";
    //    Ddl_SearchPartyName.DataValueField = "contractID";
    //    Ddl_SearchPartyName.DataBind();
    //    Ddl_SearchPartyName.Items.Insert(0, "SELECT");
    //}
    protected void Ddl_DeliveryType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (HiddenField_Ddl_DeliveryType.Value == "1")
        {
            if (Ddl_DeliveryType.SelectedItem.ToString() == "GODOWN DELIVERY - GODOWN PICKUP")
            {
                GracePeriod.Visible = true;
                AmountPerDay.Visible = true;
                GracePeriod.Focus();
            }
            else
            {
                GracePeriod.Visible = false;
                AmountPerDay.Visible = false;
                Txt_Remark.Focus();
            }
            HiddenField_Ddl_DeliveryType.Value = "";
        }
    }
    /* View Function For Last Tab */
    public void displayDataInView()
    {
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spViewCustomerContract", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        con.Close();
        gridViewContractCustomer.DataSource = dtbl;
        gridViewContractCustomer.DataBind();
    }
    public void clearBasic()
    {
        Txt_BillingPartyName.Enabled = false;
        Txt_FromDate.Enabled = false;
        Txt_ToDate.Enabled = false;
        Txt_signingDate.Enabled = false;
        Ddl_BranchName.Enabled = false;
        Txt_CFTValue.Enabled = false;
        Txt_FreightRate.Enabled = false;
        Ddl_CategoryOfDays.Enabled = false;
        Txt_CategoryOfDays.Enabled = false;
        Ddl_DeliveryType.Enabled = false;
        Txt_GracePeriod.Enabled = false;
        Txt_DemurrageCharges.Enabled = false;
        Txt_Remark.Enabled = false;
        Txt_Minweight.Enabled = false;
        Txt_MinFreight.Enabled = false;
        Txt_waybillcharges.Enabled = false;
        Ddl_ROVUnit.Enabled = false;
        Txt_Range.Enabled = false;
        Txt_MinimumValue.Enabled = false;
        txtDSCBase.Enabled = false;
        txtDSCChange.Enabled = false;
        chkDSCOnTotal.Enabled = false; 
		ddlDSCOnTotal.Enabled = false;
	}
    public void clearBasicForEdit()
    {
        Txt_BillingPartyName.Text = "";
        hfBillingPartyName.Value = "";
        Txt_FromDate.Text = "";
        Txt_ToDate.Text = "";
        Txt_signingDate.Text = "";
        Ddl_BranchName.SelectedIndex = 0;
        Txt_CFTValue.Text = "";
        Ddl_CategoryOfDays.SelectedIndex = 1;
        Txt_CategoryOfDays.Text = "";
        Ddl_DeliveryType.SelectedIndex = 5;
        Txt_GracePeriod.Text = "";
        Txt_DemurrageCharges.Text = "";
        Txt_Remark.Text = "";
        Txt_BillingPartyName.Enabled = true;
        Txt_FromDate.Enabled = true;
        Txt_ToDate.Enabled = true;
        Txt_signingDate.Enabled = true;
        Ddl_BranchName.Enabled = true;
        Txt_CFTValue.Enabled = true;
        Ddl_CategoryOfDays.Enabled = true;
        Txt_CategoryOfDays.Enabled = true;
        Ddl_DeliveryType.Enabled = true;
        Txt_GracePeriod.Enabled = true;
        Txt_DemurrageCharges.Enabled = true;
        Txt_Remark.Enabled = true;
    }
    public void clearCommercialForEdit()
    {
        Txt_Minweight.Text = "";
        Txt_waybillcharges.Text = "";
        Txt_MinFreight.Text = "";
        Ddl_ROVUnit.SelectedIndex = 0;
        Txt_Range.Text = "";
        Txt_MinimumValue.Text = "";
        txtDSCBase.Text = "";
        txtDSCChange.Text = "";
        chkDSCOnTotal.Checked = false;
    }
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {
        try
        {
            string CurrentDateTime = (new CFunctions().CurrentDateTime());

            con.Open();
            SqlCommand sqlcmd = new SqlCommand("ssp_CreateOrUpdateCustomerContract", con);
            sqlcmd.CommandType = CommandType.StoredProcedure;
            //sqlcmd.Parameters.AddWithValue("@customerID", hfBillingPartyName.Value.ToString());
            if (Txt_ContractId.Text != "") sqlcmd.Parameters.AddWithValue("@contractId", CFunctions.ID);
            sqlcmd.Parameters.AddWithValue("@customerID", hfBillingPartyName.Value);
            sqlcmd.Parameters.AddWithValue("@fromDate", Txt_FromDate.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@toDate", Txt_ToDate.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@signingDate", Txt_signingDate.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@controllingBranchID", Ddl_BranchName.SelectedValue.ToString());
            sqlcmd.Parameters.AddWithValue("@CFTValue", Convert.ToDecimal(Txt_CFTValue.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@Rate", Convert.ToDecimal(Txt_FreightRate.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@creditPeriod", Ddl_CategoryOfDays.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@creditPeriodValue", Convert.ToInt64(Txt_CategoryOfDays.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@deliveryType", Ddl_DeliveryType.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@gracePeriod", Ddl_DeliveryType.Text.ToString() == "GODOWN DELIVERY - GODOWN PICKUP" ? Txt_GracePeriod.Text.ToString() : Convert.ToInt32(0).ToString());
            sqlcmd.Parameters.AddWithValue("@demurrageCharges", Ddl_DeliveryType.Text.ToString() == "GODOWN DELIVERY - GODOWN PICKUP" ? Txt_DemurrageCharges.Text.ToString() : Convert.ToInt32(0).ToString());
            sqlcmd.Parameters.AddWithValue("@remark", Txt_Remark.Text.ToString().ToUpper());
            sqlcmd.Parameters.AddWithValue("@minWeight", Convert.ToDecimal(Txt_Minweight.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@waybillCharges", Convert.ToDecimal(Txt_waybillcharges.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@minimumFreight", Convert.ToDecimal(Txt_MinFreight.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@ODACharges", Convert.ToDecimal(Txt_ODACharges.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@DSCType", Ddl_DSCType.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@DSCCharges", Convert.ToDecimal(Txt_DSCValue.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@ROVUnit", Ddl_ROVUnit.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@value", Txt_Range.Text.ToString());
            sqlcmd.Parameters.AddWithValue("@RateOn", ddlRateOn.SelectedValue.ToString()); //Hardcoded for the Moment
            sqlcmd.Parameters.AddWithValue("@ODAPerKg", txtODAPerKg.Text == "" ? "0" : txtODAPerKg.Text);
            //sqlcmd.Parameters.AddWithValue("@DSCOnTotal", chkDSCOnTotal.Checked ? "Y" : "N");
			sqlcmd.Parameters.AddWithValue("@DSCOnTotal", ddlDSCOnTotal.SelectedValue);
            sqlcmd.Parameters.AddWithValue("@DSCBasePrice", txtDSCBase.Text == "" ? "0" : txtDSCBase.Text);
            sqlcmd.Parameters.AddWithValue("@DSCChange", txtDSCChange.Text == "" ? "0" : txtDSCChange.Text);
            sqlcmd.Parameters.AddWithValue("@rovMinimumValue", Convert.ToInt64(Txt_MinimumValue.Text.ToString()));
            sqlcmd.Parameters.AddWithValue("@branchID", Session["BranchId"].ToString());
            sqlcmd.Parameters.AddWithValue("@userID", Session["userId"].ToString());
            sqlcmd.Parameters.AddWithValue("@fuelbase", ddlFuelBase.SelectedValue.ToString());

            sqlcmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime.ToString());

            // sqlcmd.ExecuteNonQuery();
            IDataReader reader = null;
            reader = (sqlcmd.ExecuteReader());
            if (reader.Read())
            {
                CFunctions.setID(Convert.ToInt32(reader["id"]));
            }
            con.Close();
            clearBasic();
            Button_Tab1Save.Enabled = false;
            Button_Tab1Save.Style.Add("opacity", "0.3");
            Button_Tab1Save.Style.Add("color", "white");
            Button_Tab1Save.CssClass = "btn btn-info Btn_Basic_Save largeButtonStyle";
            Btn_BasicReset.Enabled = false;
            Btn_BasicReset.Style.Add("opacity", "0.3");
            Btn_BasicReset.Style.Add("color", "white");
            Btn_BasicReset.CssClass = "btn btn-info Btn_Reset largeButtonStyle";
            Btn_CustomerContractNext.Enabled = true;
            Btn_CustomerContractNext.Style.Remove("color");
            Btn_CustomerContractNext.Style.Remove("opacity");
            Btn_CustomerContractNext.CssClass = "btn btn-info next-step largeButtonStyle";

            string a = "Button_Tab1Save";
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
        catch (Exception ex)
        {
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + ex.Message + "','" + b + "');", true);
        }
    }
    protected void editCustomerContractDetails_Click(object sender, EventArgs e)
    {

        clearBasicForEdit();
        Txt_BillingPartyName.Enabled = false;
        Txt_FromDate.Enabled = true;
        Txt_ToDate.Enabled = true;
        //Ddl_ContractStatus.Enabled = true;
        Txt_signingDate.Enabled = true;
        //Txt_BelongToBranch.Enabled = true;
        Txt_CFTValue.Enabled = true;
        Ddl_CategoryOfDays.Enabled = true;
        Txt_CategoryOfDays.Enabled = true;
        Ddl_DeliveryType.Enabled = true;
        Txt_GracePeriod.Enabled = true;
        Txt_DemurrageCharges.Enabled = true;
        Txt_Remark.Enabled = true;


        string contractNo = (sender as LinkButton).CommandArgument;
        contractNoForEdit = contractNo;
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewCustomerContract", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@contractId", contractNo);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);

        Txt_ContractId.Text = dtbl.Rows[0]["ContractId"].ToString();
        CFunctions.ID = Convert.ToInt32(Txt_ContractId.Text);
        hfBillingPartyName.Value = dtbl.Rows[0]["CustomerId"].ToString();
        HttpContext.Current.Application["custID"] = dtbl.Rows[0]["CustomerId"].ToString();
        Txt_ContractNo.Text = dtbl.Rows[0]["ContractNo"].ToString();
        Txt_BillingPartyName.Text = dtbl.Rows[0]["billingPartyName"].ToString();
        Txt_FromDate.Text = dtbl.Rows[0]["fromDate"].ToString();
        Txt_ToDate.Text = dtbl.Rows[0]["toDate"].ToString();
        //Ddl_ContractStatus.Text = dtbl.Rows[0]["contractStatus"].ToString();
        Txt_signingDate.Text = dtbl.Rows[0]["signingDate"].ToString();
        Txt_FreightRate.Text = dtbl.Rows[0]["Rate"].ToString();
        Ddl_BranchName.SelectedValue = dtbl.Rows[0]["controllingBranch"].ToString();
        Txt_CFTValue.Text = dtbl.Rows[0]["CFTValue"].ToString();
        Ddl_CategoryOfDays.Text = dtbl.Rows[0]["creditPeriod"].ToString();
        Txt_CategoryOfDays.Text = dtbl.Rows[0]["creditPeriodValue"].ToString();
        //Ddl_DeliveryType.Text = dtbl.Rows[0]["deliveryType"].ToString();
        Txt_GracePeriod.Text = dtbl.Rows[0]["gracePeriod"].ToString();
        Txt_DemurrageCharges.Text = dtbl.Rows[0]["demurrageCharges"].ToString();
        Txt_Remark.Text = dtbl.Rows[0]["remark"].ToString();
        Txt_Minweight.Text = dtbl.Rows[0]["minWeight"].ToString();
        Txt_waybillcharges.Text = dtbl.Rows[0]["waybillCharges"].ToString();
        Txt_Range.Text = dtbl.Rows[0]["value"].ToString();
        Txt_MinFreight.Text = dtbl.Rows[0]["minimumFreight"].ToString();
        Txt_ODACharges.Text = dtbl.Rows[0]["ODACharges"].ToString();
        Ddl_DSCType.SelectedValue = dtbl.Rows[0]["DSCType"].ToString();
        Txt_DSCValue.Text = dtbl.Rows[0]["DSCCharges"].ToString();
        Ddl_ROVUnit.Text = dtbl.Rows[0]["ROVUnit"].ToString() == "" ? "SELECT" : dtbl.Rows[0]["ROVUnit"].ToString();
        Txt_Range.Text = dtbl.Rows[0]["value"].ToString();
        Txt_MinimumValue.Text = dtbl.Rows[0]["rovMinimumValue"].ToString();
        txtDSCBase.Text = dtbl.Rows[0]["DSCBasePrice"].ToString();
        txtDSCChange.Text = dtbl.Rows[0]["DSCChange"].ToString();
        //if (dtbl.Rows[0]["DSCOnTotal"].ToString() == "Y") chkDSCOnTotal.Checked = true;
		if (dtbl.Rows[0]["DSCOnTotal"].ToString() == "Y")
            ddlDSCOnTotal.SelectedValue = "#WAYBILL#";
        else 
            ddlDSCOnTotal.SelectedValue = dtbl.Rows[0]["DSCOnTotal"].ToString(); 
        txtODAPerKg.Text = dtbl.Rows[0]["ODAPerKg"].ToString();

        txtODAPerKg.Text = dtbl.Rows[0]["ODAPerKg"].ToString();
        con.Close();

        fillContractCondition(Txt_ContractId.Text);

        fillGrid(); //Details of Rate Contract

    }



    protected void lnkdeleteCustomerContract_Click(object sender, EventArgs e)
    {

    }

    protected void Button_Tab2Save_Click(object sender, EventArgs e)
    {
        string a = "Button_Tab2Save";
        string b = "SAVE";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

        Response.Redirect(Request.Url.AbsoluteUri);
    }




    /* Popup Creation Image */
    protected void Img_RegionPop_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Region_Master.aspx");
    }

    // Data on onSelectIndexChanged *********************************************************
    #region
    //protected void Ddl_UnitType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_Ddl_UnitType.Value=="1")
    //    {
    //        Ddl_UnitTypeOn.SelectedIndex = 0;
    //        if (Ddl_UnitType.SelectedItem.ToString() == "SELECT")
    //        {
    //            Ddl_UnitTypeOn.SelectedIndex = 0;
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" || Ddl_UnitType.SelectedItem.ToString() == "KG")
    //        {
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //        }
    //        HiddenField_Ddl_UnitType.Value = "";
    //    }       
    //}

    //protected void Ddl_UnitTypeOn_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_Ddl_UnitTypeOn.Value=="1")
    //    {
    //        if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "SELECT")
    //        {
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //        {
    //            NoOfBoxes.Visible = true;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //        {
    //            NoOfBoxesBetween.Visible = true;
    //            NoOfBoxes.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //        {
    //            NoOfBoxes.Visible = true;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }

    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "SELECT")
    //        {
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }

    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //        {
    //            Kg.Visible = true;
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //        {
    //            KMFromTo.Visible = true;
    //            Lbl_KgFrom.Visible = true;
    //            Lbl_KgTo.Visible = true;
    //            SpanKgFromTo.Visible = true;
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //        {
    //            Kg.Visible = true;
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        else
    //        {
    //            NoOfBoxes.Visible = false;
    //            NoOfBoxesBetween.Visible = false;
    //            Kg.Visible = false;
    //            KMFromTo.Visible = false;
    //            Lbl_KgFrom.Visible = false;
    //            Lbl_KgTo.Visible = false;
    //            SpanKgFromTo.Visible = false;
    //        }
    //        HiddenField_Ddl_UnitTypeOn.Value = "";
    //    }
    //}
    //#region popup
    protected void Ddl_PopViewBy_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Ddl_PopViewBy.SelectedItem.ToString() != "SELECT")
        {
            if (Ddl_PopViewBy.SelectedItem.ToString() == "STATE")
            {
                Lbl_PopViewState.Visible = true;
                Ddl_PopView.Visible = true;


                Lbl_PopViewDistrict.Visible = false;
                Lbl_PopViewLocation.Visible = false;
                Lbl_PopViewBranch.Visible = false;
                Lbl_PopViewPincode.Visible = false;
            }
            else if (Ddl_PopViewBy.SelectedItem.ToString() == "DISTRICT")
            {
                Lbl_PopViewDistrict.Visible = true;
                Ddl_PopView.Visible = true;
                Lbl_PopViewState.Visible = false;

                Lbl_PopViewPincode.Visible = false;
                Lbl_PopViewLocation.Visible = false;
                Lbl_PopViewBranch.Visible = false;
            }
            else if (Ddl_PopViewBy.SelectedItem.ToString() == "LOCATION")
            {
                Lbl_PopViewLocation.Visible = true;
                Ddl_PopView.Visible = true;
                Lbl_PopViewDistrict.Visible = false;

                Lbl_PopViewState.Visible = false;
                Lbl_PopViewPincode.Visible = false;
                Lbl_PopViewBranch.Visible = false;

            }
            else if (Ddl_PopViewBy.SelectedItem.ToString() == "BRANCH")
            {
                Lbl_PopViewBranch.Visible = true;
                Ddl_PopView.Visible = true;
                Lbl_PopViewLocation.Visible = false;

                Lbl_PopViewDistrict.Visible = false;
                Lbl_PopViewPincode.Visible = false;
                Lbl_PopViewState.Visible = false;
            }
            else if (Ddl_PopViewBy.SelectedItem.ToString() == "PINCODE")
            {
                Lbl_PopViewPincode.Visible = true;
                Ddl_PopView.Visible = true;
                Lbl_PopViewBranch.Visible = false;

                Lbl_PopViewLocation.Visible = false;

                Lbl_PopViewDistrict.Visible = false;

                Lbl_PopViewState.Visible = false;

            }
        }
        else
        {
            Lbl_PopViewState.Visible = false;
            Lbl_PopViewDistrict.Visible = false;
            Lbl_PopViewLocation.Visible = false;
            Lbl_PopViewBranch.Visible = false;
            Lbl_PopViewPincode.Visible = false;
            Ddl_PopView.Visible = false;
        }
    }
    #endregion

    //private void BindGrid(int rowcount)
    //{
    //    DataTable dt = new DataTable("");
    //    DataRow dr;
    //    dt.Columns.Add(new System.Data.DataColumn("geoScopeID", typeof(int)));
    //    dt.Columns.Add(new System.Data.DataColumn("materialID", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("materialName", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("packageID", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("packageName", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("category", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("scopeType", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("from", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("to", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("unitType", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("unitTypeOn", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("unitValue", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("fromUnitValue", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("toUnitValue", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("unitCharges", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("extraCharges", typeof(String)));

    //    if (ViewState["CurrentData"] != null)
    //    {
    //        for (int i = 0; i < rowcount + 1; i++)
    //        {
    //            dt = (DataTable)ViewState["CurrentData"];
    //            if (dt.Rows.Count > 0)
    //            {
    //                dr = dt.NewRow();
    //                dr[0] = dt.Rows[0][0].ToString();                 
    //            }              
    //        }
    //        dr = dt.NewRow();
    //        #region    
    //        dr[0] = rowcount + 1;
    //        dr[1] = materialID.ToString();
    //        dr[2] = Txt_MaterialName.Text.ToString();
    //        dr[3] = packageID.ToString();
    //        dr[4] = Txt_TypeOFPackage.Text.ToString();
    //        dr[5] = Ddl_GEOScopeCategory.SelectedItem.ToString();
    //        dr[6] = Ddl_ScopeType.SelectedItem.ToString();
    //        dr[7] = Txt_ScopeType1.Text.ToString();
    //        dr[8] = Txt_ScopeType2.Text.ToString();
    //        dr[9] = Ddl_UnitType.SelectedItem.ToString();
    //        dr[10] = Ddl_UnitTypeOn.SelectedItem.ToString();
    //        if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //        {
    //            dr[11] = Txt_NoOfBoxes.Text.ToString();
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //        {
    //            dr[11] = "";
    //            dr[12] = Txt_NoOfBoxesBetween1.Text.ToString();
    //            dr[13] = Txt_NoOfBoxesBetween2.Text.ToString(); 
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //        {
    //            dr[11] = Txt_NoOfBoxes.Text.ToString(); 
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //        {
    //            dr[11] = Txt_Kg.Text.ToString(); 
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //        {
    //            dr[11] = "";
    //            dr[12] = Txt_FromKg.Text.ToString(); 
    //            dr[13] = Txt_ToKg.Text.ToString(); 
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //        {
    //            dr[11] = Txt_Kg.Text.ToString(); 
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        dr[14] = Txt_UnitCharges.Text.ToString(); 
    //        dr[15] = Txt_Extrachargesmin.Text.ToString(); 

    //        dt.Rows.Add(dr);

    //    }
    //    else
    //    {
    //        dr = dt.NewRow();

    //        dr[0] = 1;
    //        dr[1] = materialID.ToString();
    //        dr[2] = Txt_MaterialName.Text.ToString();
    //        dr[3] = packageID.ToString();
    //        dr[4] = Txt_TypeOFPackage.Text.ToString();
    //        dr[5] = Ddl_GEOScopeCategory.SelectedItem.ToString();
    //        dr[6] = Ddl_ScopeType.SelectedItem.ToString();
    //        dr[7] = Txt_ScopeType1.Text.ToString();
    //        dr[8] = Txt_ScopeType2.Text.ToString();
    //        dr[9] = Ddl_UnitType.SelectedItem.ToString();
    //        dr[10] = Ddl_UnitTypeOn.SelectedItem.ToString();
    //        if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //        {
    //            dr[11] = Txt_NoOfBoxes.Text.ToString();
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //        {
    //            dr[11] = "";
    //            dr[12] = Txt_NoOfBoxesBetween1.Text.ToString();
    //            dr[13] = Txt_NoOfBoxesBetween2.Text.ToString();
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //        {
    //            dr[11] = Txt_NoOfBoxes.Text.ToString();
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //        {
    //            dr[11] = Txt_Kg.Text.ToString();
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //        {
    //            dr[11] = "";
    //            dr[12] = Txt_FromKg.Text.ToString();
    //            dr[13] = Txt_ToKg.Text.ToString();
    //        }
    //        else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //        {
    //            dr[11] = Txt_Kg.Text.ToString();
    //            dr[12] = "";
    //            dr[13] = "";
    //        }
    //        dr[14] = Txt_UnitCharges.Text.ToString();
    //        dr[15] = Txt_Extrachargesmin.Text.ToString();

    //        #endregion

    //        dt.Rows.Add(dr);
    //    }
    //    // If ViewState has a data then use the value as the DataSource

    //    if (ViewState["CurrentData"] != null)
    //    {
    //        AddGeoScope_DataTable_GridView.DataSource = (DataTable)ViewState["CurrentData"];
    //        AddGeoScope_DataTable_GridView.DataBind();
    //    }
    //    else
    //    {
    //        // Bind GridView with the initial data assocaited in the DataTable
    //        AddGeoScope_DataTable_GridView.DataSource = dt;
    //        AddGeoScope_DataTable_GridView.DataBind();
    //    }
    //    // Store the DataTable in ViewState to retain the values
    //    ViewState["CurrentData"] = dt;
    //}
    //protected void Btn_addGeoScope_Click(object sender, EventArgs e)
    //{
    //    AddDIV.Visible = true;        
    //    if (ContractClass.btnSubmit == 0)
    //    {
    //        // Check if the ViewState has a data assoiciated within it. If
    //        if (ViewState["CurrentData"] != null)
    //        {
    //            DataTable dt = (DataTable)ViewState["CurrentData"];
    //            int count = dt.Rows.Count;

    //                BindGrid(count);             
    //        }
    //        else
    //        {
    //            BindGrid(1);
    //        }
    //    }
    //    else if (ContractClass.btnSubmit == 1)
    //    {

    //        if (ViewState["CurrentData"] != null)
    //        {
    //            DataTable dt = (DataTable)ViewState["CurrentData"];
    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                if ((dt.Rows[i]["geoScopeID"]).ToString() == editBranch)
    //                {
    //                    dt.Rows[i]["materialName"] = Txt_MaterialName.Text.ToString();
    //                    dt.Rows[i]["packageName"] = Txt_TypeOFPackage.Text.ToString();
    //                    dt.Rows[i]["category"] = Ddl_GEOScopeCategory.SelectedItem.ToString();
    //                    dt.Rows[i]["scopeType"] = Ddl_ScopeType.SelectedItem.ToString();
    //                    dt.Rows[i]["from"] = Txt_ScopeType1.Text.ToString();
    //                    dt.Rows[i]["to"] = Txt_ScopeType2.Text.ToString();
    //                    dt.Rows[i]["unitType"] = Ddl_UnitType.Text.ToString();
    //                    dt.Rows[i]["unitTypeOn"] = Ddl_UnitTypeOn.Text.ToString();
    //                    if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //                    {                         
    //                        dt.Rows[i]["unitValue"]= Txt_NoOfBoxes.Text.ToString();
    //                    }
    //                    else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //                    {
    //                         dt.Rows[i]["fromUnitValue"]= Txt_NoOfBoxesBetween1.Text.ToString();
    //                         dt.Rows[i]["toUnitValue"] = Txt_NoOfBoxesBetween2.Text.ToString(); 
    //                    }
    //                    else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //                    {                         
    //                        dt.Rows[i]["unitValue"]= Txt_NoOfBoxes.Text.ToString();
    //                    }
    //                    else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //                    {                         
    //                        dt.Rows[i]["unitValue"]= Txt_Kg.Text.ToString();
    //                    }
    //                    else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //                    {                         
    //                        dt.Rows[i]["fromUnitValue"]= Txt_FromKg.Text.ToString();
    //                        dt.Rows[i]["toUnitValue"]= Txt_ToKg.Text.ToString();
    //                    }
    //                    else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //                    {                          
    //                        dt.Rows[i]["unitValue"]= Txt_Kg.Text.ToString();
    //                    }                       
    //                    dt.Rows[i]["unitCharges"] = Txt_UnitCharges.Text.ToString();
    //                    dt.Rows[i]["extraCharges"] = Txt_Extrachargesmin.Text.ToString();

    //                    AddGeoScope_DataTable_GridView.DataSource = dt;
    //                    AddGeoScope_DataTable_GridView.DataBind();
    //                    ContractClass.setBtnSubmit(0);                      
    //                    Btn_addGeoScope.Text = "ADD GEO SCOPE";
    //                }
    //            }
    //        }
    //    }

    //    clearAddDataTable();

    //}
    //******************************************************************************Edit Data After Click on Edit Button(Geo Scope)**********************************************************
    #region
    //protected void GeoScopeEdit_Data_Click(object sender, EventArgs e)
    //{
    //    ContractClass.setBtnSubmit(1);      
    //   // Panel_MaterialName.Visible = false;
    //    string edit = (sender as LinkButton).CommandArgument;
    //    editBranch = edit; // This Variable is used For Updation
    //    DataTable dt = (DataTable)ViewState["CurrentData"];
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if ((dt.Rows[i]["geoScopeID"]).ToString() == edit)
    //        {
    //            Txt_MaterialName.Text = dt.Rows[i]["materialName"].ToString();
    //            Txt_TypeOFPackage.Text = dt.Rows[i]["packageName"].ToString();
    //            Ddl_GEOScopeCategory.Text = dt.Rows[i]["category"].ToString();
    //            Ddl_ScopeType.Text = dt.Rows[i]["scopeType"].ToString();
    //            Txt_ScopeType1.Text = dt.Rows[i]["from"].ToString();
    //            Txt_ScopeType2.Text = dt.Rows[i]["to"].ToString();
    //            Ddl_UnitType.Text = dt.Rows[i]["unitType"].ToString();
    //            Ddl_UnitTypeOn.Text = dt.Rows[i]["unitTypeOn"].ToString();
    //            DivScopeType1.Visible = true;
    //            DivScopeType2.Visible = true;
    //            if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //            {                 
    //                NoOfBoxes.Visible = true;                  
    //                Txt_NoOfBoxes.Text= dt.Rows[i]["unitValue"].ToString();
    //                Kg.Visible = false;
    //                NoOfBoxesBetween.Visible = false;
    //                KMFromTo.Visible = false;
    //            }
    //            else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //            {                   
    //                NoOfBoxesBetween.Visible = true;
    //                Txt_NoOfBoxesBetween1.Text = dt.Rows[i]["fromUnitValue"].ToString();
    //                Txt_NoOfBoxesBetween2.Text = dt.Rows[i]["toUnitValue"].ToString();
    //                NoOfBoxes.Visible = false;
    //                Kg.Visible = false;
    //                KMFromTo.Visible = false;
    //            }
    //            else if (Ddl_UnitType.SelectedItem.ToString() == "PER BOX" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //            {
    //                NoOfBoxes.Visible = true;
    //                Txt_NoOfBoxes.Text = dt.Rows[i]["unitValue"].ToString();
    //                Kg.Visible = false;
    //                NoOfBoxesBetween.Visible = false;
    //                KMFromTo.Visible = false;
    //            }
    //            else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "EQUAL TO")
    //            {
    //                Kg.Visible = true;
    //                Txt_Kg.Text = dt.Rows[i]["unitValue"].ToString();
    //                NoOfBoxes.Visible = false;
    //                NoOfBoxesBetween.Visible = false;
    //                KMFromTo.Visible = false;
    //            }
    //            else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "BETWEEN")
    //            {
    //                KMFromTo.Visible = true;
    //                Txt_FromKg.Text = dt.Rows[i]["fromUnitValue"].ToString();
    //                Txt_ToKg.Text = dt.Rows[i]["toUnitValue"].ToString();
    //                NoOfBoxes.Visible = false;
    //                Kg.Visible = false;
    //                NoOfBoxesBetween.Visible = false;
    //            }
    //            else if (Ddl_UnitType.SelectedItem.ToString() == "KG" && Ddl_UnitTypeOn.SelectedItem.ToString() == "ABOVE")
    //            {
    //                Kg.Visible = true;
    //                Txt_Kg.Text = dt.Rows[i]["unitValue"].ToString();
    //                NoOfBoxes.Visible = false;
    //                NoOfBoxesBetween.Visible = false;
    //                KMFromTo.Visible = false;
    //            }

    //            Txt_UnitCharges.Text = dt.Rows[i]["unitCharges"].ToString();
    //            Txt_Extrachargesmin.Text = dt.Rows[i]["extraCharges"].ToString();    
    //        }
    //    }

    //    Btn_addGeoScope.Text = "UPDATE";

    //}
    //protected void GeoScopeDelete_Data1_Click(object sender, EventArgs e)
    //{
    //    String delete = (sender as LinkButton).CommandArgument;
    //    DataTable dt = (DataTable)ViewState["CurrentData"];
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if ((dt.Rows[i]["geoScopeID"]).ToString() == delete)
    //        {
    //            dt.Rows[i].Delete();
    //        }
    //    }

    //    AddGeoScope_DataTable_GridView.DataSource = dt;
    //    AddGeoScope_DataTable_GridView.DataBind();
    //    clearAddDataTable();
    //    cmf.showalert("Delete_Data1", "DELETE", this);
    //    //string a = "Delete_Data1";
    //    //string b = "DELETE";
    //    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

    //}
    //public void clearAddDataTable()
    //{
    //    Txt_MaterialName.Text = "SELECT";
    //    Txt_MaterialName_Search.Text = "";
    //    FillMaterial();
    //    Txt_TypeOFPackage.Text = "SELECT";
    //    Txt_TypeOFPackage_Search.Text = "";
    //    FillPackage();
    //    Ddl_GEOScopeCategory.SelectedIndex = 0;     
    //    Txt_ScopeType1.Text = "SELECT";
    //    Txt_ScopeType1_Search.Text = "";
    //    if (Ddl_ScopeType.SelectedItem.ToString() == "BRANCH TO BRANCH")
    //    {                    
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "spGetControllingBranch", "", "", "", "", "", "", "branchName", "branchName", Txt_ScopeType1);
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spGetControllingBranch", "", "", "", "", "", "", "branchName", "branchName", Txt_ScopeType2);
    //    }

    //    else if (Ddl_ScopeType.SelectedItem.ToString() == "BRANCH TO REGION")
    //    {           
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "spGetControllingBranch", "", "", "", "", "", "", "branchName", "branchName", Txt_ScopeType1);
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType2);
    //    }

    //    else if (Ddl_ScopeType.SelectedItem.ToString() == "REGION TO REGION")
    //    {          
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType1);
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType2);
    //    }

    //    else if (Ddl_ScopeType.SelectedItem.ToString() == "REGION TO BRANCH")
    //    {          
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType1);
    //        cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spGetControllingBranch", "", "", "", "", "", "", "branchName", "branchName", Txt_ScopeType2);
    //    }

    //    Ddl_ScopeType.SelectedIndex = 0;
    //    DivScopeType1.Visible = false;
    //    DivScopeType2.Visible = false;
    //    Ddl_UnitType.SelectedIndex = 0;
    //    Ddl_UnitTypeOn.SelectedIndex = 0;
    //    Txt_NoOfBoxes.Text = "";
    //    Txt_NoOfBoxesBetween1.Text = "";
    //    Txt_NoOfBoxesBetween2.Text = "";
    //    Txt_Kg.Text = "";
    //    Txt_FromKg.Text = "";
    //    Txt_ToKg.Text = "";
    //    Txt_UnitCharges.Text = "";
    //    Txt_Extrachargesmin.Text = "";
    //    NoOfBoxes.Visible = false;
    //    NoOfBoxesBetween.Visible = false;
    //    Kg.Visible = false;
    //    KMFromTo.Visible = false;


    //    Button_Submit1.Enabled = true;
    //    Button_Submit1.Style.Remove("color");
    //    Button_Submit1.Style.Remove("opacity");
    //    Button_Submit1.CssClass = "btn btn-info Button_Submit1 largeButtonStyle";
    //}

    //public void clearAll()
    //{
    //    Txt_State.Enabled = true;
    //    Btn_addquotation.Visible = true;
    //    mainAddDiv.Visible = true;
    //    OnEditAddDiv.Visible = false;
    //    EditQuotationDiv.Visible = false;
    //    Button_Tab3Save.Text = "SAVE <i class='fa fa-save'></i>";

    //    //  Button_Submit1.Text = "SUBMIT<i class='fa fa-save'></i>";
    //}
    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        if (ContractClass.btnSubmit == 0)
        {
            DataTable dt = (DataTable)ViewState["CurrentData"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                con.Open();
                SqlCommand sqlcmd = new SqlCommand("spCreateOrUpdateContractGeoScope", con);
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.Parameters.AddWithValue("@contractNo", ContractClass.code);
                sqlcmd.Parameters.AddWithValue("@materialID", Convert.ToInt32(dt.Rows[i]["materialID"].ToString()));
                sqlcmd.Parameters.AddWithValue("@packID", Convert.ToInt32(dt.Rows[i]["packageID"].ToString()));
                sqlcmd.Parameters.AddWithValue("@category", dt.Rows[i]["category"].ToString());
                sqlcmd.Parameters.AddWithValue("@scopeType", dt.Rows[i]["scopeType"].ToString());
                sqlcmd.Parameters.AddWithValue("@scopeType1", dt.Rows[i]["from"].ToString());
                sqlcmd.Parameters.AddWithValue("@scopeType2", dt.Rows[i]["to"].ToString());
                sqlcmd.Parameters.AddWithValue("@unitType", dt.Rows[i]["unitType"].ToString());
                sqlcmd.Parameters.AddWithValue("@unitTypeOn", dt.Rows[i]["unitTypeOn"].ToString());

                if (dt.Rows[i]["unitType"].ToString() == "PER BOX" && dt.Rows[i]["unitTypeOn"].ToString() == "EQUAL TO")
                {
                    sqlcmd.Parameters.AddWithValue("@unitValue", Convert.ToInt32(dt.Rows[i]["unitValue"].ToString()));
                    sqlcmd.Parameters.AddWithValue("@unitValueFrom", "");
                    sqlcmd.Parameters.AddWithValue("@unitValueTo", "");
                }
                else if (dt.Rows[i]["unitType"].ToString() == "PER BOX" && dt.Rows[i]["unitTypeOn"].ToString() == "BETWEEN")
                {
                    sqlcmd.Parameters.AddWithValue("@unitValue", "");
                    sqlcmd.Parameters.AddWithValue("@unitValueFrom", Convert.ToInt32(dt.Rows[i]["fromUnitValue"].ToString()));
                    sqlcmd.Parameters.AddWithValue("@unitValueTo", Convert.ToInt32(dt.Rows[i]["toUnitValue"].ToString()));
                }
                else if (dt.Rows[i]["unitType"].ToString() == "PER BOX" && dt.Rows[i]["unitTypeOn"].ToString() == "ABOVE")
                {
                    sqlcmd.Parameters.AddWithValue("@unitValue", Convert.ToInt32(dt.Rows[i]["unitValue"].ToString()));
                    sqlcmd.Parameters.AddWithValue("@unitValueFrom", "");
                    sqlcmd.Parameters.AddWithValue("@unitValueTo", "");
                }
                else if (dt.Rows[i]["unitType"].ToString() == "KG" && dt.Rows[i]["unitTypeOn"].ToString() == "EQUAL TO")
                {
                    sqlcmd.Parameters.AddWithValue("@unitValue", Convert.ToInt32(dt.Rows[i]["unitValue"].ToString()));
                    sqlcmd.Parameters.AddWithValue("@unitValueFrom", "");
                    sqlcmd.Parameters.AddWithValue("@unitValueTo", "");
                }
                else if (dt.Rows[i]["unitType"].ToString() == "KG" && dt.Rows[i]["unitTypeOn"].ToString() == "BETWEEN")
                {
                    sqlcmd.Parameters.AddWithValue("@unitValue", "");
                    sqlcmd.Parameters.AddWithValue("@unitValueFrom", Convert.ToInt32(dt.Rows[i]["fromUnitValue"].ToString()));
                    sqlcmd.Parameters.AddWithValue("@unitValueTo", Convert.ToInt32(dt.Rows[i]["toUnitValue"].ToString()));
                }
                else if (dt.Rows[i]["unitType"].ToString() == "KG" && dt.Rows[i]["unitTypeOn"].ToString() == "ABOVE")
                {
                    sqlcmd.Parameters.AddWithValue("@unitValue", Convert.ToInt32(dt.Rows[i]["unitValue"].ToString()));
                    sqlcmd.Parameters.AddWithValue("@unitValueFrom", "");
                    sqlcmd.Parameters.AddWithValue("@unitValueTo", "");
                }

                sqlcmd.Parameters.AddWithValue("@unitCharges", Convert.ToDecimal(dt.Rows[i]["unitCharges"].ToString()));
                sqlcmd.Parameters.AddWithValue("@extraCharges", Convert.ToDecimal(dt.Rows[i]["extraCharges"].ToString()));
                sqlcmd.Parameters.AddWithValue("@scopeTypePriority", i + 1);
                sqlcmd.ExecuteNonQuery();
                con.Close();
            }
            string a = "Button_Submit1";
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
        else if (ContractClass.btnSubmit == 1)
        {

            string a = "Button_Submit1";
            string b = "UPDATE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
        // clearAll();
        displayDataInView();
    }

    #endregion

    //***********************************************For Quotation******************************************************************************
    #region
    //Function For Quotation Data Table Generation
    //private void Quotation(int rowcount)
    //{
    //    DataTable dt = new DataTable();
    //    DataRow dr;
    //    dt.Columns.Add(new System.Data.DataColumn("dataTableID", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("quotationDate", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("quotationNo", typeof(String)));

    //    if (ViewState["QuotationData"] != null)
    //    {
    //        for (int i = 0; i < rowcount + 1; i++)
    //        {
    //            dt = (DataTable)ViewState["QuotationData"];
    //            if (dt.Rows.Count > 0)
    //            {
    //                dr = dt.NewRow();
    //                dr[0] = dt.Rows[0][0].ToString();
    //            }
    //        }
    //        dr = dt.NewRow();
    //        dr[0] = rowcount + 1;
    //        dr[1] = Txt_Quotationdate.Text.ToString();
    //        dr[2] = Txt_QuotationNo.Text.ToString();

    //        dt.Rows.Add(dr);

    //    }
    //    else
    //    {
    //        dr = dt.NewRow();
    //        dr[0] = 1;
    //        dr[1] = Txt_Quotationdate.Text.ToString();
    //        dr[2] = Txt_QuotationNo.Text.ToString();

    //        dt.Rows.Add(dr);
    //    }
    //    // If ViewState has a data then use the value as the DataSource
    //    if (ViewState["QuotationData"] != null)
    //    {
    //        QuotationGridViewDataTable.DataSource = (DataTable)ViewState["QuotationData"];
    //        QuotationGridViewDataTable.DataBind();
    //    }
    //    else
    //    {
    //        // Bind GridView with the initial data assocaited in the DataTable

    //        QuotationGridViewDataTable.DataSource = dt;
    //        QuotationGridViewDataTable.DataBind();

    //    }
    //    // Store the DataTable in ViewState to retain the values
    //    ViewState["QuotationData"] = dt;
    //    con.Close();

    //}
    //protected void Btn_addquotation_Click(object sender, EventArgs e)
    //{
    //    QuotationGridDiv.Visible = true;

    //    // string strBtn = Btn_Add.Text.ToString();
    //    if (globalVar.btnSubmit == 0)
    //    {

    //        // Check if the ViewState has a data assoiciated within it. If
    //        if (ViewState["QuotationData"] != null)
    //        {
    //            DataTable dt = (DataTable)ViewState["QuotationData"];
    //            int count = dt.Rows.Count;
    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                if ((dt.Rows[i]["quotationNo"]).ToString() == Txt_QuotationNo.Text.ToString())
    //                {
    //                    s = 1;

    //                    string a = "Btn_Add";
    //                    string b = "ADD1";
    //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

    //                    break;
    //                }

    //            }
    //            if (s == 0)
    //            {
    //                Quotation(count);
    //            }
    //            else
    //                s = 0;

    //        }
    //        else
    //        {
    //            Quotation(1);
    //        }
    //        Txt_Quotationdate.Text = "";
    //        Txt_QuotationNo.Text = "";

    //    }
    //    else if (globalVar.btnSubmit == 1)
    //    {
    //        if (ViewState["QuotationData"] != null)
    //        {
    //            DataTable dt = (DataTable)ViewState["QuotationData"];
    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                if ((dt.Rows[i]["dataTableID"]).ToString() == editQuotation)
    //                {
    //                    dt.Rows[i]["quotationDate"] = Txt_Quotationdate.Text.ToString();
    //                    dt.Rows[i]["quotationNo"] = Convert.ToInt32(Txt_QuotationNo.Text);
    //                }
    //            }

    //            QuotationGridViewDataTable.DataSource = dt;
    //            QuotationGridViewDataTable.DataBind();
    //        }


    //        Txt_Quotationdate.Text = "";
    //        Txt_QuotationNo.Text = "";
    //        //  Btn_addGeoScope.Text = "ADD GEO SCOPE";
    //        globalVar.setBtnSubmit(0);
    //    }
    //}
    //protected void Edit_Data_Click(object sender, EventArgs e)
    //{
    //    globalVar.setBtnSubmit(1);
    //    string edit = (sender as LinkButton).CommandArgument;
    //    editQuotation = edit;
    //    DataTable dt = (DataTable)ViewState["QuotationData"];
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if ((dt.Rows[i]["dataTableID"]).ToString() == edit)
    //        {
    //            Txt_Quotationdate.Text = dt.Rows[i]["quotationDate"].ToString();
    //            Txt_QuotationNo.Text = dt.Rows[i]["quotationNo"].ToString();
    //        }
    //    }
    //    Btn_addquotation.Text = "UPDATE <i class='fa fa-save'></i>";
    //}
    //protected void Delete_Data1_Click(object sender, EventArgs e)
    //{
    //    String delete = (sender as LinkButton).CommandArgument;
    //    DataTable dt = (DataTable)ViewState["QuotationData"];
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if ((dt.Rows[i]["dataTableID"]).ToString() == delete)
    //        {
    //            dt.Rows[i].Delete();
    //        }
    //    }

    //    QuotationGridViewDataTable.DataSource = dt;
    //    QuotationGridViewDataTable.DataBind();
    //    Txt_Quotationdate.Text = "";
    //    Txt_QuotationNo.Text = "";
    //    // Btn_addGeoScope.Text = "ADD GEO SCOPE";
    //    string a = "Delete_Data1";
    //    string b = "DELETE";
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

    //}
    #endregion
    //*************************************************************For FSC Details************************************************************************
    #region
    //protected void Button_Tab3Save_Click(object sender, EventArgs e)
    //{

    //    if (globalVar.btnSubmit == 0)
    //    {
    //        con.Open();

    //        SqlCommand sqlcmd = new SqlCommand("spCreateOrUpdateContractFSCDetails", con);
    //        sqlcmd.CommandType = CommandType.StoredProcedure;
    //        sqlcmd.Parameters.AddWithValue("@event", "FSC");
    //        sqlcmd.Parameters.AddWithValue("@bool", globalVar.status);
    //        sqlcmd.Parameters.AddWithValue("@contractNo", globalVar.code.ToString());
    //        sqlcmd.Parameters.AddWithValue("@avgDieselRate", Txt_basicDieselRate.Text.ToString());
    //        sqlcmd.Parameters.AddWithValue("@state", "");
    //        sqlcmd.Parameters.AddWithValue("@dieselRate", "");
    //        sqlcmd.ExecuteNonQuery();

    //        string[] state = Txt_State.Text.Split(',');

    //        for (int j = 0; j < state.Length; j++)
    //        {

    //            SqlCommand command = new SqlCommand("SELECT  d.dieselRate FROM tblDieselRate d,tblState s where d.stateID=s.stateID AND s.stateName='" + state[j] + "'", con);
    //            SqlDataReader reader = command.ExecuteReader();
    //            if (reader.Read())
    //            {
    //                rate = Convert.ToDecimal(reader["dieselRate"]);
    //            }
    //            reader.Close();

    //            if (state[j] != "")
    //            {
    //                SqlCommand sqlcmd1 = new SqlCommand("spCreateOrUpdateContractFSCDetails", con);
    //                sqlcmd1.CommandType = CommandType.StoredProcedure;
    //                sqlcmd1.Parameters.AddWithValue("@event", "StateWise");
    //                sqlcmd1.Parameters.AddWithValue("@bool", globalVar.status);
    //                sqlcmd1.Parameters.AddWithValue("@contractNo", globalVar.code.ToString());
    //                sqlcmd1.Parameters.AddWithValue("@avgDieselRate", "");
    //                sqlcmd1.Parameters.AddWithValue("@state", state[j]);
    //                sqlcmd1.Parameters.AddWithValue("@dieselRate", rate);
    //                sqlcmd1.ExecuteNonQuery();
    //            }
    //            else
    //            {
    //                continue;
    //            }
    //        }
    //        con.Close();
    //        DataTable dt = (DataTable)ViewState["QuotationData"];
    //        if (dt != null)
    //        {
    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                con.Open();
    //                sqlcmd = new SqlCommand("spCreateOrUpdateContractQuotation", con);
    //                sqlcmd.CommandType = CommandType.StoredProcedure;
    //                sqlcmd.Parameters.AddWithValue("@bool", globalVar.status);
    //                sqlcmd.Parameters.AddWithValue("@contractNo", globalVar.code.ToString());
    //                sqlcmd.Parameters.AddWithValue("@quotationID", "");
    //                sqlcmd.Parameters.AddWithValue("@quotationDate", dt.Rows[i]["quotationDate"].ToString());
    //                sqlcmd.Parameters.AddWithValue("@quotationNo", dt.Rows[i]["quotationNo"].ToString());
    //                sqlcmd.ExecuteNonQuery();
    //                con.Close();
    //            }
    //        }

    //        globalVar.setStatus(0);

    //        Panel_State.Visible = false;
    //        Button_Tab3Save.Enabled = false;
    //        Button_Tab3Save.Style.Add("opacity", "0.3");
    //        Button_Tab3Save.Style.Add("color", "white");
    //        Button_Tab3Save.CssClass = "btn btn-info Btn_Commercial_Save largeButtonStyle";
    //        Btn_FSCReset.Enabled = false;
    //        Btn_FSCReset.Style.Add("opacity", "0.3");
    //        Btn_FSCReset.Style.Add("color", "white");
    //        Btn_FSCReset.CssClass = "btn btn-info Btn_Reset largeButtonStyle";
    //        Btn_FSCNext.Enabled = true;
    //        Btn_FSCNext.Style.Remove("color");
    //        Btn_FSCNext.Style.Remove("opacity");
    //        Btn_FSCNext.CssClass = "btn btn-info next-step largeButtonStyle";

    //        string a = "Button_Tab3Save";
    //        string b = "SAVE";
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    //        //  displayDataInGridView();

    //    }
    //    else if (globalVar.btnSubmit == 1)
    //    {
    //        con.Open();
    //        globalVar.setStatus(1);
    //        SqlCommand sqlcmd = new SqlCommand("spCreateOrUpdateContractFSCDetails", con);
    //        sqlcmd.CommandType = CommandType.StoredProcedure;
    //        sqlcmd.Parameters.AddWithValue("@event", "FSC");
    //        sqlcmd.Parameters.AddWithValue("@bool", globalVar.status);
    //        sqlcmd.Parameters.AddWithValue("@contractNo", globalVar.code.ToString());
    //        sqlcmd.Parameters.AddWithValue("@avgDieselRate", Txt_basicDieselRate.Text.ToString());
    //        sqlcmd.Parameters.AddWithValue("@state", "");
    //        sqlcmd.Parameters.AddWithValue("@dieselRate", "");
    //        sqlcmd.ExecuteNonQuery();
    //        string[] state = Txt_State.Text.Split(',');
    //        for (int j = 0; j < state.Length; j++)
    //        {

    //            SqlCommand command = new SqlCommand("SELECT  s.stateName,d.dieselRate FROM tblDieselRate d,tblState s where d.stateID=s.stateID AND s.stateName='" + state[j] + "'", con);
    //            SqlDataReader reader = command.ExecuteReader();
    //            if (reader.Read())
    //            {
    //                rate = Convert.ToDecimal(reader["dieselRate"]);
    //            }
    //            reader.Close();

    //            if (state[j] != "")
    //            {

    //                SqlCommand sqlcmd1 = new SqlCommand("spCreateOrUpdateContractFSCDetails", con);
    //                sqlcmd1.CommandType = CommandType.StoredProcedure;
    //                sqlcmd1.Parameters.AddWithValue("@event", "StateWise");
    //                sqlcmd1.Parameters.AddWithValue("@bool", globalVar.status);
    //                sqlcmd1.Parameters.AddWithValue("@contractNo", globalVar.code.ToString());
    //                sqlcmd1.Parameters.AddWithValue("@avgDieselRate", "");
    //                sqlcmd1.Parameters.AddWithValue("@state", state[j]);
    //                sqlcmd1.Parameters.AddWithValue("@dieselRate", rate);
    //                sqlcmd1.ExecuteNonQuery();

    //            }
    //            else
    //            {
    //                continue;
    //            }
    //        }
    //        con.Close();

    //        Button_Tab3Save.Enabled = false;
    //        Button_Tab3Save.Style.Add("opacity", "0.3");
    //        Button_Tab3Save.Style.Add("color", "white");
    //        Button_Tab3Save.CssClass = "btn btn-info Btn_Commercial_Save largeButtonStyle";
    //        Btn_FSCReset.Enabled = false;
    //        Btn_FSCReset.Style.Add("opacity", "0.3");
    //        Btn_FSCReset.Style.Add("color", "white");
    //        Btn_FSCReset.CssClass = "btn btn-info Btn_Reset largeButtonStyle";
    //        Btn_FSCNext.Enabled = true;
    //        Btn_FSCNext.Style.Remove("color");
    //        Btn_FSCNext.Style.Remove("opacity");
    //        Btn_FSCNext.CssClass = "btn btn-info next-step largeButtonStyle";
    //        Txt_State.Enabled = false;
    //        Btn_addquotation.Visible = false;

    //        string a = "Button_Tab3Save";
    //        string b = "UPDATE";
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    //        globalVar.setStatus(0);
    //        globalVar.setBtnSubmit(0);

    //    }
    //}
    #endregion
    //******************************************************Fill Dropdowns**************************************************************************
    #region
    public void fillRegions()
    {
        string searchTxt = "ssp_GetRegionList";
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);
        ddlFromRegion.DataSource = dt;
        ddlFromRegion.DataTextField = "RegionName";
        ddlFromRegion.DataValueField = "RegionId";
        ddlFromRegion.DataBind();
        ddlToRegion.DataSource = dt;
        ddlToRegion.DataTextField = "RegionName";
        ddlToRegion.DataValueField = "RegionId";
        ddlToRegion.DataBind();
        con.Close();
    }
    //public void fillState()
    //{
    //    string searchTxt = "SELECT d.stateID,s.stateName FROM tblDieselRate d,tblState s WHERE d.stateID=s.stateID";
    //    con.Open();
    //    SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //    sqlda.SelectCommand.CommandType = CommandType.Text;
    //    DataTable dt = new DataTable();
    //    sqlda.Fill(dt);
    //    CheckBoxList__State.DataSource = dt;
    //    CheckBoxList__State.DataTextField = "stateName";
    //    CheckBoxList__State.DataValueField = "stateName";
    //    CheckBoxList__State.DataBind();
    //    con.Close();
    //}
    //protected void Txt_State_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_State_Search.Value == "1")
    //    {
    //        select_all_State.Visible = false;
    //        string[] value = Txt_State.Text.Split(',');
    //        if (Txt_State_Search.Text != "")
    //        {
    //            string search = Txt_State_Search.Text;
    //            string searchTxt = "SELECT d.stateID,s.stateName FROM tblDieselRate d,tblState s WHERE d.stateID=s.stateID AND s.stateName LIKE '%" + search + "%'";
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            CheckBoxList__State.DataSource = dt;
    //            CheckBoxList__State.DataTextField = "stateName";
    //            CheckBoxList__State.DataValueField = "stateName";
    //            CheckBoxList__State.DataBind();
    //            //Txt_State_Search.Focus();

    //            for (int i = 0; i < value.Count(); i++)
    //            {
    //                for (int j = 0; j < CheckBoxList__State.Items.Count; j++)
    //                {
    //                    if (value[i] == CheckBoxList__State.Items[j].Text)
    //                    {
    //                        CheckBoxList__State.Items[j].Selected = true;
    //                    }
    //                }
    //            }
    //        }
    //        else if (Txt_State_Search.Text == "")
    //        {
    //            string searchTxt = "SELECT d.stateID,s.stateName FROM tblDieselRate d,tblState s WHERE d.stateID=s.stateID";
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            CheckBoxList__State.DataSource = dt;
    //            CheckBoxList__State.DataTextField = "stateName";
    //            CheckBoxList__State.DataValueField = "stateName";
    //            CheckBoxList__State.DataBind();
    //            //Txt_State_Search.Focus();

    //            for (int i = 0; i < value.Count(); i++)
    //            {
    //                for (int j = 0; j < CheckBoxList__State.Items.Count; j++)
    //                {
    //                    if (value[i] == CheckBoxList__State.Items[j].Text)
    //                    {
    //                        CheckBoxList__State.Items[j].Selected = true;
    //                    }
    //                }
    //            }
    //        }

    //        HiddenField_Txt_State_Search.Value = "";
    //    }
    //}
    //protected void LinkButton_SearchState_Dropdown_Submit_Click(object sender, EventArgs e)
    //{
    //    if (HiddenField_LinkButton_SearchState_Dropdown_Submit.Value == "1")
    //    {
    //        select_all_State.Visible = true;
    //        select_all_State.Checked = false;
    //        Txt_State_Search.Text = "";
    //        sumOfDieselRate = 0;
    //        avgState = 0;
    //        Txt_State.Text = "";
    //        int c = 0;
    //        for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //        {
    //            if (CheckBoxList__State.Items[i].Selected)
    //            {
    //                c++;
    //            }
    //        }
    //        if (Txt_State.Text != "")
    //        {
    //            for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //            {
    //                if (CheckBoxList__State.Items[i].Selected)
    //                {
    //                    Txt_State.Text += CheckBoxList__State.Items[i].Text + ",";
    //                }
    //            }
    //            List<String> value = new List<string>();
    //            value = Txt_State.Text.Split(',').ToList();
    //            for (int i = 0; i < value.Count(); i++)
    //            {
    //                ListItem item = CheckBoxList__State.Items.FindByText(value[i]);
    //                if (value[i] == "")
    //                {
    //                    continue;
    //                }
    //                else if (item == null)
    //                {
    //                    continue;
    //                }
    //                else if (CheckBoxList__State.Items.FindByText(value[i]).Selected == false)
    //                {
    //                    value.RemoveAt(i);
    //                }
    //            }
    //            string searchTxt = "SELECT d.stateID,s.stateName FROM tblDieselRate d,tblState s WHERE d.stateID=s.stateID";
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            CheckBoxList__State.DataSource = dt;
    //            CheckBoxList__State.DataTextField = "stateName";
    //            CheckBoxList__State.DataValueField = "stateName";
    //            CheckBoxList__State.DataBind();
    //            //  bd.CheckboxlistBindDropdownDoubleParameter(CheckBoxList__State, "spBindDropdownListORAuto", "@Event", "State_Dropdown", "@SDC", "", "Delivery State", "Delivery State");
    //            for (int i = 0; i < value.Count(); i++)
    //            {
    //                for (int j = 0; j < CheckBoxList__State.Items.Count; j++)
    //                {
    //                    if (value[i] == CheckBoxList__State.Items[j].Text)
    //                    {
    //                        CheckBoxList__State.Items[j].Selected = true;
    //                    }
    //                }
    //            }
    //            Txt_State.Text = "";
    //            for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //            {
    //                if (CheckBoxList__State.Items[i].Selected)
    //                {
    //                    Txt_State.Text += CheckBoxList__State.Items[i].Value + ",";
    //                }
    //            }

    //        }
    //        else
    //        {

    //            for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //            {
    //                if (CheckBoxList__State.Items[i].Selected)
    //                {
    //                    Txt_State.Text += CheckBoxList__State.Items[i].Text + ",";
    //                }
    //            }
    //            string searchTxt = "SELECT d.stateID,s.stateName FROM tblDieselRate d,tblState s WHERE d.stateID=s.stateID";
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            CheckBoxList__State.DataSource = dt;
    //            CheckBoxList__State.DataTextField = "stateName";
    //            CheckBoxList__State.DataValueField = "stateName";
    //            CheckBoxList__State.DataBind();
    //            //  bd.CheckboxlistBindDropdownDoubleParameter(CheckBoxList__State, "spBindDropdownListORAuto", "@Event", "State_Dropdown", "@SDC", "", "Delivery State", "Delivery State");
    //            List<String> value = new List<string>();
    //            value = Txt_State.Text.Split(',').ToList();
    //            for (int i = 0; i < value.Count(); i++)
    //            {
    //                for (int j = 0; j < CheckBoxList__State.Items.Count; j++)
    //                {
    //                    if (value[i] == CheckBoxList__State.Items[j].Text)
    //                    {
    //                        CheckBoxList__State.Items[j].Selected = true;
    //                    }
    //                }
    //            }


    //        }
    //        if (Txt_State.Text != "")
    //        {
    //            for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //            {
    //                con.Open();
    //                string str = "Select dieselRate from tblDieselRate d,tblState s WHERE d.stateID=s.stateID AND s.stateName LIKE '" + CheckBoxList__State.Items[i].Text.Trim() + "%'";
    //                cmd = new SqlCommand(str, con);
    //                dr = cmd.ExecuteReader();
    //                if (dr.Read())
    //                {
    //                    dieselRate = Convert.ToDecimal(dr["dieselRate"]);
    //                    dr.Close();
    //                }
    //                con.Close();
    //                if (CheckBoxList__State.Items[i].Selected)
    //                {
    //                    sumOfDieselRate = sumOfDieselRate + Convert.ToDecimal(dieselRate);
    //                }
    //            }
    //            avgState = (Convert.ToDecimal(sumOfDieselRate)) / Convert.ToInt32(c);
    //            Txt_basicDieselRate.Text = Math.Round(Convert.ToDecimal(avgState), 2).ToString();
    //        }
    //        else
    //        {
    //            Txt_basicDieselRate.Text = "";
    //        }

    //        int count = CheckBoxList__State.Items.Count;
    //        int c1 = 0;
    //        for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //        {
    //            if (CheckBoxList__State.Items[i].Selected)
    //            {
    //                c1++;
    //            }
    //        }

    //        if (count == c1)
    //        {
    //            select_all_State.Checked = true;
    //        }
    //        else
    //            select_all_State.Checked = false;
    //        Txt_State.ToolTip = Txt_State.Text;

    //        HiddenField_LinkButton_SearchState_Dropdown_Submit.Value = "";
    //    }



    //}
    //// SELECT ALL CHECKBOX
    //protected void select_all_State_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_select_all_State.Value == "1")
    //    {
    //        Txt_State.Text = "";
    //        int c = 0;
    //        List<String> copyStateList = new List<string>();
    //        if (select_all_State.Checked == true)
    //        {
    //            foreach (ListItem item in CheckBoxList__State.Items)
    //            {
    //                item.Selected = true;
    //                c++;
    //                copyStateList.Add(item.Text.ToString());
    //            }
    //            if (copyStateList.Count == 0)
    //            {
    //                Txt_State.Text = "";
    //            }
    //            else
    //            {
    //                //Txt_State.Text = "";
    //                for (int i = 0; i < copyStateList.Count; i++)
    //                {
    //                    if (copyStateList.Count == 1)
    //                    {
    //                        if (Txt_State.Text != "")
    //                        {
    //                            Txt_State.Text += "," + copyStateList[i].ToString();
    //                        }
    //                        else
    //                        {
    //                            Txt_State.Text += copyStateList[i].ToString();
    //                        }
    //                    }
    //                    else if (copyStateList.Count == i + 1)
    //                    {
    //                        Txt_State.Text += copyStateList[i].ToString();
    //                    }
    //                    else
    //                    {
    //                        Txt_State.Text += copyStateList[i].ToString() + ",";
    //                    }
    //                }
    //            }
    //            for (int i = 0; i < CheckBoxList__State.Items.Count; i++)
    //            {
    //                con.Open();
    //                string str = "Select dieselRate from tblDieselRate d,tblState s WHERE d.stateID=s.stateID AND s.stateName LIKE '" + CheckBoxList__State.Items[i].Text.Trim() + "%'";
    //                cmd = new SqlCommand(str, con);
    //                dr = cmd.ExecuteReader();
    //                if (dr.Read())
    //                {
    //                    dieselRate = Convert.ToDecimal(dr["dieselRate"]);
    //                    dr.Close();
    //                }
    //                con.Close();
    //                if (CheckBoxList__State.Items[i].Selected)
    //                {
    //                    sumOfDieselRate = sumOfDieselRate + Convert.ToDecimal(dieselRate);
    //                }
    //            }
    //            avgState = (Convert.ToDecimal(sumOfDieselRate)) / Convert.ToInt32(c);
    //            Txt_basicDieselRate.Text = Math.Round(Convert.ToDecimal(avgState), 2).ToString();
    //        }
    //        else
    //        {
    //            foreach (ListItem item in CheckBoxList__State.Items)
    //            {
    //                item.Selected = false;
    //            }
    //            Txt_State.Text = "";
    //            Txt_basicDieselRate.Text = "";
    //        }
    //        Txt_State.ToolTip = Txt_State.Text;
    //        //   PopupControlExtender_State.Commit(CheckBoxList__State.SelectedValue);        
    //        HiddenField_select_all_State.Value = "";
    //    }
    //}

    #region
    //*************************************************Fill Material List************************************************************
    //public void FillMaterial()
    //{
    //    SqlCommand cmd_bname = new SqlCommand("Select materialID,materialName from tblMaterial", con);
    //    con.Open();
    //    RadioButtonList_MaterialName.DataSource = cmd_bname.ExecuteReader();
    //    RadioButtonList_MaterialName.DataTextField = "materialName";
    //    RadioButtonList_MaterialName.DataValueField = "materialID";
    //    RadioButtonList_MaterialName.DataBind();
    //    RadioButtonList_MaterialName.Items.Insert(0, "SELECT");
    //    foreach (ListItem listofitem in RadioButtonList_MaterialName.Items)
    //    {
    //        listofitem.Text = listofitem.Text.ToUpper();
    //    }
    //    RadioButtonList_MaterialName.SelectedIndex = 0;
    //    con.Close();
    //}
    //protected void Txt_MaterialName_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_Txt_MaterialName_Search.Value=="1")
    //    {
    //        if (Txt_MaterialName_Search.Text != "")
    //        {
    //            string search = Txt_MaterialName_Search.Text;
    //            string searchTxt = "SELECT materialID,materialName FROM tblMaterial WHERE materialName LIKE '%" + search + "%'";

    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);

    //            RadioButtonList_MaterialName.DataSource = dt;
    //            RadioButtonList_MaterialName.DataTextField = "materialName";
    //            RadioButtonList_MaterialName.DataValueField = "materialID";
    //            RadioButtonList_MaterialName.DataBind();
    //            RadioButtonList_MaterialName.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofitem in RadioButtonList_MaterialName.Items)
    //            {
    //                listofitem.Text = listofitem.Text.ToUpper();
    //            }
    //            Txt_MaterialName_Search.Focus();
    //            con.Close();
    //        }

    //        else if (Txt_MaterialName_Search.Text == "")
    //        {

    //            string searchTxt = "SELECT materialID,materialName FROM tblMaterial";

    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            RadioButtonList_MaterialName.DataSource = dt;
    //            RadioButtonList_MaterialName.DataTextField = "materialName";
    //            RadioButtonList_MaterialName.DataValueField = "materialID";
    //            RadioButtonList_MaterialName.DataBind();
    //            RadioButtonList_MaterialName.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofitem in RadioButtonList_MaterialName.Items)
    //            {
    //                listofitem.Text = listofitem.Text.ToUpper();
    //            }
    //            Txt_MaterialName_Search.Focus();
    //            con.Close();
    //        }
    //        HiddenField_Txt_MaterialName_Search.Value = "";
    //    }
    //}
    //protected void RadioButtonList_MaterialName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_RadioButtonList_MaterialName.Value=="1")
    //    {
    //        //cmf.DataList_SelectedIndexChanging(RadioButtonList_MaterialName, Txt_MaterialName);
    //        for (int i = 0; i < RadioButtonList_MaterialName.Items.Count; i++)
    //        {
    //            if (RadioButtonList_MaterialName.Items[i].Selected)
    //            {
    //                Txt_MaterialName.Text = RadioButtonList_MaterialName.Items[i].Text;
    //                materialID = RadioButtonList_MaterialName.Items[i].Value;
    //                if (Txt_MaterialName.Text.ToString() == "SELECT")
    //                {
    //                    Txt_MaterialName.Focus();
    //                }
    //                else
    //                {
    //                    Txt_TypeOFPackage.Focus();
    //                }
    //            }
    //        }                    
    //        PopupControlExtender_MaterialName.Commit(RadioButtonList_MaterialName.SelectedValue);
    //        HiddenField_RadioButtonList_MaterialName.Value = "";
    //    }

    //}
    ////****************************Fill Package Details*******************************************************
    //public void FillPackage()
    //{
    //    SqlCommand cmd_pack = new SqlCommand("Select packID,typeOfPackage from tblPackage", con);
    //    con.Open();
    //    RadioButtonList_TypeOFPackage.DataSource = cmd_pack.ExecuteReader();
    //    RadioButtonList_TypeOFPackage.DataTextField = "typeOfPackage";
    //    RadioButtonList_TypeOFPackage.DataValueField = "packID";
    //    RadioButtonList_TypeOFPackage.DataBind();
    //    RadioButtonList_TypeOFPackage.Items.Insert(0, "SELECT");
    //    foreach (ListItem listofpckage in RadioButtonList_TypeOFPackage.Items)
    //    {
    //        listofpckage.Text = listofpckage.Text.ToUpper();
    //    }
    //    RadioButtonList_TypeOFPackage.SelectedIndex = 0;
    //    con.Close();
    //}
    //protected void Txt_TypeOFPackage_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_Txt_TypeOFPackage_Search.Value=="1")
    //    {
    //        if (Txt_TypeOFPackage_Search.Text != "")
    //        {
    //            string search = Txt_TypeOFPackage_Search.Text;
    //            string searchTxt = "SELECT packID,typeOfPackage FROM tblPackage WHERE typeOfPackage LIKE '%" + search + "%'";

    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);

    //            RadioButtonList_TypeOFPackage.DataSource = dt;
    //            RadioButtonList_TypeOFPackage.DataTextField = "typeOfPackage";
    //            RadioButtonList_TypeOFPackage.DataValueField = "packID";
    //            RadioButtonList_TypeOFPackage.DataBind();
    //            RadioButtonList_TypeOFPackage.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofitem in RadioButtonList_TypeOFPackage.Items)
    //            {
    //                listofitem.Text = listofitem.Text.ToUpper();
    //            }
    //            Txt_TypeOFPackage_Search.Focus();
    //            con.Close();
    //        }

    //        else if (Txt_TypeOFPackage_Search.Text == "")
    //        {

    //            string searchTxt = "SELECT packID,typeOfPackage FROM tblPackage";

    //            con.Open();
    //            SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //            sqlda.SelectCommand.CommandType = CommandType.Text;
    //            DataTable dt = new DataTable();
    //            sqlda.Fill(dt);
    //            RadioButtonList_TypeOFPackage.DataSource = dt;
    //            RadioButtonList_TypeOFPackage.DataTextField = "typeOfPackage";
    //            RadioButtonList_TypeOFPackage.DataValueField = "packID";
    //            RadioButtonList_TypeOFPackage.DataBind();
    //            RadioButtonList_TypeOFPackage.Items.Insert(0, "SELECT");
    //            foreach (ListItem listofitem in RadioButtonList_TypeOFPackage.Items)
    //            {
    //                listofitem.Text = listofitem.Text.ToUpper();
    //            }
    //            Txt_TypeOFPackage_Search.Focus();
    //            con.Close();
    //        }
    //        HiddenField_Txt_TypeOFPackage_Search.Value = "";
    //    }
    //}
    //protected void RadioButtonList_TypeOFPackage_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_RadioButtonList_TypeOFPackage.Value=="1")
    //    {
    //        // cmf.DataList_SelectedIndexChanging(RadioButtonList_TypeOFPackage, Txt_TypeOFPackage);
    //        for (int i = 0; i < RadioButtonList_TypeOFPackage.Items.Count; i++)
    //        {
    //            if (RadioButtonList_TypeOFPackage.Items[i].Selected)
    //            {
    //                Txt_TypeOFPackage.Text = RadioButtonList_TypeOFPackage.Items[i].Text;
    //                packageID = RadioButtonList_TypeOFPackage.Items[i].Value;
    //                if (Txt_TypeOFPackage.Text.ToString() == "SELECT")
    //                {
    //                    Txt_TypeOFPackage.Focus();
    //                }
    //                else
    //                {
    //                    Ddl_GEOScopeCategory.Focus();
    //                }
    //            }
    //        }

    //        PopupControlExtender_TypeOFPackage.Commit(RadioButtonList_TypeOFPackage.SelectedValue);
    //        HiddenField_RadioButtonList_TypeOFPackage.Value = "";
    //    }
    //}
    ////*************************************Fill Dropdowns of Scope Type*********************************************************
    //protected void Txt_ScopeType1_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_Txt_ScopeType1_Search.Value=="1")
    //    {
    //        if (Ddl_ScopeType.SelectedItem.ToString() == "BRANCH TO BRANCH")
    //        {
    //            if (Txt_ScopeType1_Search.Text != "")
    //            {
    //                string search = Txt_ScopeType1_Search.Text;
    //                string searchTxt = "Select branchName from tblBranchCreation where branchName LIKE '%" + search + "%'";

    //                con.Open();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //                sqlda.SelectCommand.CommandType = CommandType.Text;
    //                DataTable dt = new DataTable();
    //                sqlda.Fill(dt);

    //                RadioButtonList_ScopeType1.DataSource = dt;
    //                RadioButtonList_ScopeType1.DataTextField = "branchName";
    //                RadioButtonList_ScopeType1.DataValueField = "branchName";
    //                RadioButtonList_ScopeType1.DataBind();
    //                RadioButtonList_ScopeType1.Items.Insert(0, "SELECT");
    //                Txt_ScopeType1_Search.Focus();
    //                con.Close();
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //            }

    //            else if (Txt_ScopeType1_Search.Text == "")
    //            {
    //                cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "ssp_GetBranchList", "", "", "", "", "", "", "branchName", "branchID", Txt_ScopeType1);
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //            }


    //        }

    //        else if (Ddl_ScopeType.SelectedItem.ToString() == "BRANCH TO REGION")
    //        {
    //            if (Txt_ScopeType1_Search.Text != "")
    //            {
    //                string search = Txt_ScopeType1_Search.Text;
    //                string searchTxt = "Select branchName from tblBranchCreation where branchName LIKE '%" + search + "%'";

    //                con.Open();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //                sqlda.SelectCommand.CommandType = CommandType.Text;
    //                DataTable dt = new DataTable();
    //                sqlda.Fill(dt);

    //                RadioButtonList_ScopeType1.DataSource = dt;
    //                RadioButtonList_ScopeType1.DataTextField = "branchName";
    //                RadioButtonList_ScopeType1.DataValueField = "branchName";
    //                RadioButtonList_ScopeType1.DataBind();
    //                RadioButtonList_ScopeType1.Items.Insert(0, "SELECT");
    //                Txt_ScopeType1_Search.Focus();
    //                con.Close();
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //            }

    //            else if (Txt_ScopeType1_Search.Text == "")
    //            {
    //                cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "ssp_GetBranchList", "", "", "", "", "", "", "branchName", "branchID", Txt_ScopeType1);
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //            }


    //        }

    //        else if (Ddl_ScopeType.SelectedItem.ToString() == "REGION TO REGION")
    //        {

    //            if (Txt_ScopeType1_Search.Text != "")
    //            {
    //                string search = Txt_ScopeType1_Search.Text;
    //                string searchTxt = "Select regionName from tblRegionCreation where setDelete='FALSE' AND regionName LIKE '%" + search + "%'";

    //                con.Open();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //                sqlda.SelectCommand.CommandType = CommandType.Text;
    //                DataTable dt = new DataTable();
    //                sqlda.Fill(dt);

    //                RadioButtonList_ScopeType1.DataSource = dt;
    //                RadioButtonList_ScopeType1.DataTextField = "regionName";
    //                RadioButtonList_ScopeType1.DataValueField = "regionName";
    //                RadioButtonList_ScopeType1.DataBind();
    //                RadioButtonList_ScopeType1.Items.Insert(0, "SELECT");
    //                Txt_ScopeType1_Search.Focus();
    //                con.Close();
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //            }

    //            else if (Txt_ScopeType1_Search.Text == "")
    //            {
    //                cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType1, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType1);
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //            }


    //        }
    //        HiddenField_Txt_ScopeType1_Search.Value = "";
    //    }
    //}
    //protected void RadioButtonList_ScopeType1_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_RadioButtonList_ScopeType1.Value=="1")
    //    {
    //        cmf.DataList_SelectedIndexChanging(RadioButtonList_ScopeType1, Txt_ScopeType1);
    //        if(Txt_ScopeType1.Text.ToString()=="SELECT")
    //        {
    //            Txt_ScopeType1.Focus();
    //        }
    //        else
    //        {
    //            Txt_ScopeType2.Focus();
    //        }
    //        PopupControlExtender_ScopeType1.Commit(RadioButtonList_ScopeType1.SelectedValue);
    //        HiddenField_RadioButtonList_ScopeType1.Value = "";
    //    }
    //}
    //protected void Txt_ScopeType2_Search_TextChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_Txt_ScopeType2_Search.Value=="1")
    //    {
    //        if (Ddl_ScopeType.SelectedItem.ToString() == "BRANCH TO BRANCH")
    //        {
    //            if (Txt_ScopeType2_Search.Text != "")
    //            {
    //                string search = Txt_ScopeType2_Search.Text;
    //                string searchTxt = "Select branchName from tblBranchCreation where setDelete='FALSE' AND setFinalSubmit='TRUE' AND branchName LIKE '%" + search + "%'";

    //                con.Open();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //                sqlda.SelectCommand.CommandType = CommandType.Text;
    //                DataTable dt = new DataTable();
    //                sqlda.Fill(dt);

    //                RadioButtonList_ScopeType2.DataSource = dt;
    //                RadioButtonList_ScopeType2.DataTextField = "branchName";
    //                RadioButtonList_ScopeType2.DataValueField = "branchName";
    //                RadioButtonList_ScopeType2.DataBind();
    //                RadioButtonList_ScopeType2.Items.Insert(0, "SELECT");
    //                Txt_ScopeType2_Search.Focus();
    //                con.Close();
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //            }

    //            else if (Txt_ScopeType2_Search.Text == "")
    //            {
    //                cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spGetControllingBranch", "", "", "", "", "", "", "branchName", "branchName", Txt_ScopeType2);
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //            }

    //        }

    //        else if (Ddl_ScopeType.SelectedItem.ToString() == "BRANCH TO REGION")
    //        {
    //            if (Txt_ScopeType2_Search.Text != "")
    //            {
    //                string search = Txt_ScopeType2_Search.Text;
    //                string searchTxt = "Select regionName from tblRegionCreation where setDelete='FALSE' AND regionName LIKE '%" + search + "%'";

    //                con.Open();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //                sqlda.SelectCommand.CommandType = CommandType.Text;
    //                DataTable dt = new DataTable();
    //                sqlda.Fill(dt);

    //                RadioButtonList_ScopeType2.DataSource = dt;
    //                RadioButtonList_ScopeType2.DataTextField = "regionName";
    //                RadioButtonList_ScopeType2.DataValueField = "regionName";
    //                RadioButtonList_ScopeType2.DataBind();
    //                RadioButtonList_ScopeType2.Items.Insert(0, "SELECT");
    //                Txt_ScopeType2_Search.Focus();
    //                con.Close();
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //            }

    //            else if (Txt_ScopeType2_Search.Text == "")
    //            {
    //                cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType2);
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //            }

    //        }

    //        else if (Ddl_ScopeType.SelectedItem.ToString() == "REGION TO REGION")
    //        {
    //            if (Txt_ScopeType2_Search.Text != "")
    //            {
    //                string search = Txt_ScopeType2_Search.Text;
    //                string searchTxt = "Select regionName from tblRegionCreation where setDelete='FALSE' AND regionName LIKE '%" + search + "%'";

    //                con.Open();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
    //                sqlda.SelectCommand.CommandType = CommandType.Text;
    //                DataTable dt = new DataTable();
    //                sqlda.Fill(dt);

    //                RadioButtonList_ScopeType2.DataSource = dt;
    //                RadioButtonList_ScopeType2.DataTextField = "regionName";
    //                RadioButtonList_ScopeType2.DataValueField = "regionName";
    //                RadioButtonList_ScopeType2.DataBind();
    //                RadioButtonList_ScopeType2.Items.Insert(0, "SELECT");
    //                Txt_ScopeType2_Search.Focus();
    //                con.Close();
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //            }

    //            else if (Txt_ScopeType2_Search.Text == "")
    //            {
    //                cmf.BindDataValueInListTripleParameter("area", RadioButtonList_ScopeType2, null, null, "spFillRegionName", "", "", "", "", "", "", "regionName", "regionName", Txt_ScopeType2);
    //                cmf.SelectListUsingTextbox(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //            }
    //        }
    //        HiddenField_Txt_ScopeType2_Search.Value = "";
    //    }
    //}
    //protected void RadioButtonList_ScopeType2_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(HiddenField_RadioButtonList_ScopeType2.Value=="1")
    //    {
    //        cmf.DataList_SelectedIndexChanging(RadioButtonList_ScopeType2, Txt_ScopeType2);
    //        if(Txt_ScopeType2.Text.ToString()=="SELECT")
    //        {
    //            Txt_ScopeType2.Focus();
    //        }
    //        else
    //        {
    //            Ddl_UnitType.Focus();
    //        }
    //        PopupControlExtender_ScopeType2.Commit(RadioButtonList_ScopeType2.SelectedValue);
    //        HiddenField_RadioButtonList_ScopeType2.Value = "";
    //    }
    //}
    #endregion
    #endregion
    //***********************************************************Reset Button***********************************************************
    #region
    //protected void Btn_FSCReset_Click(object sender, EventArgs e)
    //{
    //    if (HiddenField_Btn_FSCReset.Value == "1")
    //    {
    //        Txt_State.Text = "";
    //        Txt_State_Search.Text = "";
    //        //fillState();
    //        Txt_basicDieselRate.Text = "";
    //        Txt_Quotationdate.Text = "";
    //        Txt_QuotationNo.Text = "";
    //        Btn_addquotation.Text = "ADD QUOTATION <i class='fa fa-plus'></i>";
    //        QuotationGridDiv.Visible = false;
    //        HiddenField_Btn_FSCReset.Value = "";
    //    }
    //}

    protected void Btn_BasicReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_BasicReset.Value == "1")
        {
            Response.Redirect(Request.Url.AbsoluteUri);
            HiddenField_Btn_BasicReset.Value = "";
        }
    }
    //protected void Btn_ResetGeoScope_Click(object sender, EventArgs e)
    //{
    //    if (HiddenField_Btn_ResetGeoScope.Value == "1")
    //    {
    //        clearAddDataTable();
    //        Btn_addGeoScope.Text = "ADD GEO SCOPE";
    //        Button_Submit1.Enabled = false;
    //        Button_Submit1.Style.Add("color", "white");
    //        Button_Submit1.Style.Add("opacity", "0.3");
    //        Button_Submit1.CssClass = "btn btn-info Button_Tab4Save largeButtonStyle";
    //        AddDIV.Visible = false;
    //        HiddenField_Btn_ResetGeoScope.Value = "";

    //    }
    //}
    #endregion
    //****************************************************Edit For Quotation (View Panel) *******************************************************************************
    #region
    // After Click on Edit Button in Viewing Panel
    //protected void EditQuotation_Data_Click(object sender, EventArgs e)
    //{
    //    globalVar.setStatus(1);
    //    globalVar.setBtnSubmit(1);
    //    int quotationID = Convert.ToInt32((sender as LinkButton).CommandArgument);
    //    globalVar.setID(Convert.ToInt32(quotationID));
    //    con.Open();
    //    SqlDataAdapter sqlda = new SqlDataAdapter("spEditContractQuotation", con);
    //    sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sqlda.SelectCommand.Parameters.AddWithValue("@quotationID", quotationID);
    //    //sqlda.SelectCommand.Parameters.AddWithValue("@contractNo", Txt_ContractNo.Text.ToString());
    //    DataTable dtbl = new DataTable();
    //    sqlda.Fill(dtbl);
    //    con.Close();
    //    Txt_Quotationdate.Text = dtbl.Rows[0]["quotationDate"].ToString();
    //    Txt_QuotationNo.Text = dtbl.Rows[0]["quotationNo"].ToString();
    //    Btn_OnEditAddQuotation.Text = "UPDATE <i class='fa fa-save'></i>";

    //}
    //protected void DeleteQuotation_Data1_Click(object sender, EventArgs e)
    //{
    //    LinkButton lnkbtn = sender as LinkButton;
    //    GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;

    //    int quotationID = Convert.ToInt32(GridViewEditQuotation.DataKeys[gvrow.RowIndex].Value.ToString());
    //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString))
    //    {
    //        con.Open();
    //        SqlCommand cmd = new SqlCommand("Delete tblContractQuotationDetail where quotationID=" + quotationID, con);
    //        cmd.ExecuteNonQuery();
    //        con.Close();

    //    }
    //    Txt_Quotationdate.Text = "";
    //    Txt_QuotationNo.Text = "";
    //    Btn_OnEditAddQuotation.Text = "ADD QUOTATION <i class='fa fa-plus'></i>";
    //    ListOfQuotationDetails();
    //}
    //protected void Btn_OnEditAddQuotation_Click(object sender, EventArgs e)
    //{

    //    if (globalVar.btnSubmit == 0)
    //    {
    //        con.Open();
    //        SqlCommand sqlcmd = new SqlCommand("spCreateOrUpdateContractQuotationOnEdit", con);
    //        sqlcmd.CommandType = CommandType.StoredProcedure;
    //        sqlcmd.Parameters.AddWithValue("@bool", globalVar.status);
    //        //  sqlcmd.Parameters.AddWithValue("@contractNo", Txt_ContractNo.Text.ToString());
    //        sqlcmd.Parameters.AddWithValue("@quotationID", "");
    //        sqlcmd.Parameters.AddWithValue("@quotationDate", Txt_Quotationdate.Text.ToString());
    //        sqlcmd.Parameters.AddWithValue("@quotationNo", Txt_QuotationNo.Text.ToString());
    //        sqlcmd.ExecuteNonQuery();
    //        globalVar.setStatus(0);
    //        con.Close();
    //    }
    //    else if (globalVar.btnSubmit == 1)
    //    {
    //        con.Open();
    //        globalVar.setStatus(1);
    //        SqlCommand cmd = new SqlCommand("spCreateOrUpdateContractQuotationOnEdit", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@bool", globalVar.status);
    //        //  cmd.Parameters.AddWithValue("@contractNo", Txt_ContractNo.Text.ToString());
    //        cmd.Parameters.AddWithValue("@quotationID", globalVar.id);
    //        cmd.Parameters.AddWithValue("@quotationDate", Txt_Quotationdate.Text.ToString());
    //        cmd.Parameters.AddWithValue("@quotationNo", Txt_QuotationNo.Text.ToString());
    //        cmd.ExecuteNonQuery();
    //        con.Close();
    //        Btn_OnEditAddQuotation.Text = "ADD QUOTATION <i class='fa fa-plus'></i>";
    //        globalVar.setStatus(0);
    //        globalVar.setBtnSubmit(0);
    //    }
    //    Txt_Quotationdate.Text = "";
    //    Txt_QuotationNo.Text = "";
    //    ListOfQuotationDetails();
    //}
    #endregion
    //****************************************************Edit For Geo Scope (View Panel) *******************************************************************************
    #region
    protected void GeoScopeEdit_OnEdit_Click(object sender, EventArgs e)
    {

    }
    protected void GeoScopeDelete_OnEdit_Click(object sender, EventArgs e)
    {

    }
    protected void Btn_addGeoScope_OnEdit_Click(object sender, EventArgs e)
    {

    }
    #endregion
    //**************************************************** For Rate Card *******************************************************************************
    #region
    protected void gridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //strPreviousRowID = DataBinder.Eval(e.Row.DataItem, "RateTypeID").ToString();
        }
    }

    protected void gridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        return;
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;

        bool IsSubTotalRowNeedToAdd = false;

        if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "RateTypeID") != null))
            if (strPreviousRowID != DataBinder.Eval(e.Row.DataItem, "RateTypeID").ToString())
                IsSubTotalRowNeedToAdd = true;

        if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "RateTypeID") == null))
        {
            IsSubTotalRowNeedToAdd = true;
            intSubTotalIndex = 0;
        }
        if ((strPreviousRowID == string.Empty) && (DataBinder.Eval(e.Row.DataItem, "RateTypeID") != null))
        {
            GridView gridView = (GridView)sender;

            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

            TableCell cell = new TableCell();
            cell.Text = "RateType Name : " + DataBinder.Eval(e.Row.DataItem, "RateTypeName").ToString();
            cell.HorizontalAlign = HorizontalAlign.Center;
            cell.Style.Add("font-weight", "bold");
            cell.ColumnSpan = e.Row.Cells.Count;
            //cell.CssClass = "GroupHeaderStyle";
            row.Cells.Add(cell);

            gridView.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
            intSubTotalIndex++;
        }
        if (IsSubTotalRowNeedToAdd)
        {
            #region Adding Sub Total Row
            GridView grdViewOrders = (GridView)sender;

            // Creating a Row
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

            //Adding Total Cell 
            TableCell cell = new TableCell();

            //Adding the Row at the RowIndex position in the Grid
            grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
            intSubTotalIndex++;
            #endregion

            #region Adding Next Group Header Details
            if (DataBinder.Eval(e.Row.DataItem, "RateTypeID") != null)
            {
                row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

                cell = new TableCell();
                cell.Text = "RateType Name : " + DataBinder.Eval(e.Row.DataItem, "RateTypeName").ToString();
                cell.ColumnSpan = e.Row.Cells.Count;
                cell.HorizontalAlign = HorizontalAlign.Center;
                cell.Style.Add("font-weight", "bold");
                //cell.CssClass = "GroupHeaderStyle";
                row.Cells.Add(cell);

                grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                intSubTotalIndex++;
            }
            #endregion
        }
    }
    public void fillContractCondition(string ContractId)
    {
        con.Open();
        SqlDataAdapter sqlda_FSC = new SqlDataAdapter("ssp_getCustomerContractConditions", con);
        sqlda_FSC.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda_FSC.SelectCommand.Parameters.AddWithValue("@contractId", ContractId);
        DataTable dtbl_FSC = new DataTable();
        sqlda_FSC.Fill(dtbl_FSC);
        AddGeoScope_DataTable_GridView.DataSource = dtbl_FSC;
        AddGeoScope_DataTable_GridView.DataBind();
        AddGeoScope_DataTable_GridView.Visible = true;
        con.Close();
    }
    public void fillGrid()
    {
        //DataTable dt = (new RateCardFunctions()).ViewContractRateCard(Txt_ContractId.Text);
        IDataReader dt = (new RateCardFunctions()).ViewContractRateCard(CFunctions.ID.ToString());
        gridView.DataSource = dt;
        gridView.DataBind();
    }
    public void ClearAll()
    {
        Ddl_PopupRateType.SelectedIndex = 0;
        Txt_PopupFromWeight.Text = "";
        Txt_PopupToWeight.Text = "";
        Txt_PopupFromDistance.Text = "";
        Txt_PopupToDistance.Text = "";
        Txt_RateValue.Text = "";
        cmf.ButtonopacityHideShow(1, "NEXT", Btn_Tab2Next);
    }
    protected void Btn_PopupRateSubmit_Click(object sender, EventArgs e)
    {
        RateCardDetails rcd = new RateCardDetails();
        rcd.RateTypeId = Convert.ToInt32(Ddl_PopupRateType.SelectedValue);
        //rcd.ContractID = CFunctions.ID;
        rcd.ContractID = Convert.ToInt32(Txt_ContractId.Text);
        rcd.WeightFrom = Convert.ToInt32(Txt_PopupFromWeight.Text);
        rcd.WeightTo = Convert.ToInt32(Txt_PopupToWeight.Text);
        rcd.DistanceFrom = Convert.ToInt32(Txt_PopupFromDistance.Text);
        rcd.DistanceTo = Convert.ToInt32(Txt_PopupToDistance.Text);
        rcd.RateValue = Convert.ToDecimal(Txt_RateValue.Text);
        rcd.EntryDate = new CFunctions().CurrentDateTime();
        rcd.ExpiryDate = Convert.ToDateTime("2050-12-31 00:00:00.000");
        bool alertMsg = (new RateCardFunctions()).SaveRateCardDetails(rcd);

        if (alertMsg)
        {
            (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
            ClearAll();
            fillGrid();
        }

    }

    #endregion

    //*************************************************Searching View Panel**************************************************************************
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        Search_Contract_Customer_View.Visible = true;
        SearchData();
    }
    public void SearchData()
    {
        String partyName = Txt_SearchPartyName.Text.ToString() == "" ? null : Txt_SearchPartyName.Text.ToString();
        String strStatus = Ddl_SearchStatus.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchStatus.SelectedItem.ToString();
        if ((partyName != null) || (strStatus != null))
        {
            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewCustomerContract", con);
            sqlda.SelectCommand.Parameters.AddWithValue("@customerName", partyName);
            sqlda.SelectCommand.Parameters.AddWithValue("@status", strStatus);
            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlda.Fill(dtbl);
            con.Close();
            gridViewContractCustomer.DataSource = dtbl;
            gridViewContractCustomer.DataBind();
        }
    }
    //********************************************PickUp Schedule***********************************************************************
    #region
    protected void Btn_PickupSchedule_Click(object sender, EventArgs e)
    {
        if (chkMon.Checked)
        {
            if (Ddl_MonHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_MonMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(1, Convert.ToInt32(Ddl_MonHours.SelectedItem.Text.ToString()), Ddl_MonMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkTue.Checked)
        {
            if (Ddl_TueHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_TueMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(2, Convert.ToInt32(Ddl_TueHours.SelectedItem.Text.ToString()), Ddl_TueMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkWed.Checked)
        {
            if (Ddl_WedHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_WedMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(3, Convert.ToInt32(Ddl_WedHours.SelectedItem.Text.ToString()), Ddl_WedMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkThurs.Checked)
        {
            if (Ddl_ThursHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_ThursMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(4, Convert.ToInt32(Ddl_ThursHours.SelectedItem.Text.ToString()), Ddl_ThursMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkFri.Checked)
        {
            if (Ddl_FriHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_FriMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(5, Convert.ToInt32(Ddl_FriHours.SelectedItem.Text.ToString()), Ddl_FriMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkSat.Checked)
        {
            if (Ddl_SatHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_SatMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(6, Convert.ToInt32(Ddl_SatHours.SelectedItem.Text.ToString()), Ddl_SatMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkSun.Checked)
        {
            if (Ddl_SunHours.SelectedItem.Text != "SELECT")
            {
                if (Ddl_SunMinutes.SelectedItem.Text != "SELECT")
                {
                    PickUpSchedule(7, Convert.ToInt32(Ddl_SunHours.SelectedItem.Text.ToString()), Ddl_SunMinutes.SelectedItem.Text.ToString());
                }
            }
        }
        if (chkMon.Checked || chkTue.Checked || chkWed.Checked || chkThurs.Checked || chkFri.Checked || chkSat.Checked || chkSun.Checked)
        {
            nonEditablePickupSchedule();
            Btn_PickupSchedule.Enabled = false;
            Btn_PickupSchedule.Style.Add("opacity", "0.3");
            Btn_PickupSchedule.Style.Add("color", "white");
            Btn_PickupSchedule.CssClass = "btn btn-info Btn_PickupSchedule largeButtonStyle";
            Btn_PickupReset.Enabled = false;
            Btn_PickupReset.Style.Add("opacity", "0.3");
            Btn_PickupReset.Style.Add("color", "white");
            Btn_PickupReset.CssClass = "btn btn-info Btn_PickupReset largeButtonStyle";
            Btn_Tab3Next.Enabled = true;
            Btn_Tab3Next.Style.Remove("color");
            Btn_Tab3Next.Style.Remove("opacity");
            Btn_Tab3Next.CssClass = "btn btn-info next-step largeButtonStyle";
            string a = "Button_Tab2Save";
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
    }

    public void PickUpSchedule(int i, int hrs, string min)
    {
        PickupSchedule ps = new PickupSchedule();
        ps.contractID = CFunctions.ID;
        ps.pickUPDay = i;
        string time = hrs + ":" + min;
        ps.pickUPTime = time.ToString();
        (new CustomerContractFunctions()).SavePickupSchedule(ps);
    }
    public void nonEditablePickupSchedule()
    {
        chkMon.Enabled = false;
        chkTue.Enabled = false;
        chkWed.Enabled = false;
        chkThurs.Enabled = false;
        chkFri.Enabled = false;
        chkSat.Enabled = false;
        chkSun.Enabled = false;
        Ddl_MonHours.Enabled = false;
        Ddl_TueHours.Enabled = false;
        Ddl_WedHours.Enabled = false;
        Ddl_ThursHours.Enabled = false;
        Ddl_FriHours.Enabled = false;
        Ddl_SatHours.Enabled = false;
        Ddl_SunHours.Enabled = false;

        Ddl_MonMinutes.Enabled = false;
        Ddl_TueMinutes.Enabled = false;
        Ddl_WedMinutes.Enabled = false;
        Ddl_ThursMinutes.Enabled = false;
        Ddl_FriMinutes.Enabled = false;
        Ddl_SatMinutes.Enabled = false;
        Ddl_SunMinutes.Enabled = false;
    }
    public void clearPickupSchedule()
    {
        chkMon.Checked = true;
        chkTue.Checked = true;
        chkWed.Checked = true;
        chkThurs.Checked = true;
        chkFri.Checked = true;
        chkSat.Checked = true;
        chkSun.Checked = false;
        Ddl_MonHours.SelectedIndex = 0;
        Ddl_TueHours.SelectedIndex = 0;
        Ddl_WedHours.SelectedIndex = 0;
        Ddl_ThursHours.SelectedIndex = 0;
        Ddl_FriHours.SelectedIndex = 0;
        Ddl_SatHours.SelectedIndex = 0;
        Ddl_SunHours.SelectedIndex = 0;

        Ddl_MonMinutes.SelectedIndex = 0;
        Ddl_TueMinutes.SelectedIndex = 0;
        Ddl_WedMinutes.SelectedIndex = 0;
        Ddl_ThursMinutes.SelectedIndex = 0;
        Ddl_FriMinutes.SelectedIndex = 0;
        Ddl_SatMinutes.SelectedIndex = 0;
        Ddl_SunMinutes.SelectedIndex = 0;
        chkMon.Enabled = true;
        chkTue.Enabled = true;
        chkWed.Enabled = true;
        chkThurs.Enabled = true;
        chkFri.Enabled = true;
        chkSat.Enabled = true;
        chkSun.Enabled = true; ;
        Ddl_MonHours.Enabled = true;
        Ddl_TueHours.Enabled = true;
        Ddl_WedHours.Enabled = true;
        Ddl_ThursHours.Enabled = true;
        Ddl_FriHours.Enabled = true;
        Ddl_SatHours.Enabled = true;
        Ddl_SunHours.Enabled = true;

        Ddl_MonMinutes.Enabled = true;
        Ddl_TueMinutes.Enabled = true;
        Ddl_WedMinutes.Enabled = true;
        Ddl_ThursMinutes.Enabled = true;
        Ddl_FriMinutes.Enabled = true;
        Ddl_SatMinutes.Enabled = true;
        Ddl_SunMinutes.Enabled = true;
    }
    #endregion


    protected void gridViewContractCustomer_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewContractCustomer.PageIndex = e.NewPageIndex;
        SearchData();
    }

    //****************************************Function For Data Table Generation**********************************************************
    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("fromhfValue", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("fromLocation", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("tohfValue", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("toLocation", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("weight", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("price", typeof(String)));

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
            if (chkFromPincode.Checked)
            {
                dr[0] = hfFromPincode.Value.ToString();
                dr[1] = Txt_FromPincode.Text.ToString();
            }
            if (chkFromDistrict.Checked)
            {
                dr[0] = hfFromDistrict.Value.ToString();
                dr[1] = Txt_FromDistrict.Text.ToString().ToUpper();
            }
            if (chkFromCity.Checked)
            {
                dr[0] = hfFromCity.Value.ToString();
                dr[1] = Txt_FromCity.Text.ToString().ToUpper();
            }
            if (chkFromState.Checked)
            {
                dr[0] = hfFromState.Value.ToString();
                dr[1] = Txt_FromState.Text.ToString().ToUpper();
            }


            if (chkToPincode.Checked)
            {
                dr[2] = hfToPincode.Value.ToString();
                dr[3] = Txt_ToPincode.Text.ToString();
            }
            if (chkToDistrict.Checked)
            {
                dr[2] = hfToDistrict.Value.ToString();
                dr[3] = Txt_ToDistrict.Text.ToString().ToUpper();
            }
            if (chkToCity.Checked)
            {
                dr[2] = hfToCity.Value.ToString();
                dr[3] = Txt_ToCity.Text.ToString().ToUpper();
            }
            if (chkToState.Checked)
            {
                dr[2] = hfToState.Value.ToString();
                dr[3] = Txt_ToState.Text.ToString().ToUpper();
            }

            dr[4] = Txt_Weight.Text.ToString();
            dr[5] = Txt_Price.Text.ToString();
            dt.Rows.Add(dr);
        }
        else
        {
            dr = dt.NewRow();
            if (chkFromPincode.Checked)
            {
                dr[0] = hfFromPincode.Value.ToString();
                dr[1] = Txt_FromPincode.Text.ToString();
            }
            if (chkFromDistrict.Checked)
            {
                dr[0] = hfFromDistrict.Value.ToString();
                dr[1] = Txt_FromDistrict.Text.ToString().ToUpper();
            }
            if (chkFromCity.Checked)
            {
                dr[0] = hfFromCity.Value.ToString();
                dr[1] = Txt_FromCity.Text.ToString().ToUpper();
            }
            if (chkFromState.Checked)
            {
                dr[0] = hfFromState.Value.ToString();
                dr[1] = Txt_FromState.Text.ToString().ToUpper();
            }

            if (chkToPincode.Checked)
            {
                dr[2] = hfToPincode.Value.ToString();
                dr[3] = Txt_ToPincode.Text.ToString();
            }
            if (chkToDistrict.Checked)
            {
                dr[2] = hfToDistrict.Value.ToString();
                dr[3] = Txt_ToDistrict.Text.ToString().ToUpper();
            }
            if (chkToCity.Checked)
            {
                dr[2] = hfToCity.Value.ToString();
                dr[3] = Txt_ToCity.Text.ToString().ToUpper();
            }
            if (chkToState.Checked)
            {
                dr[2] = hfToState.Value.ToString();
                dr[3] = Txt_ToState.Text.ToString().ToUpper();
            }

            dr[4] = Txt_Weight.Text.ToString();
            dr[5] = Txt_Price.Text.ToString();
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        /*if (ViewState["CurrentData"] != null)
        {
            AddGeoScope_DataTable_GridView.DataSource = (DataTable)ViewState["CurrentData"];
            AddGeoScope_DataTable_GridView.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable
            AddGeoScope_DataTable_GridView.DataSource = dt;
            AddGeoScope_DataTable_GridView.DataBind();
        }*/
        // Store the DataTable in ViewState to retain the values
        ViewState["CurrentData"] = dt;
    }

    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        if (chkFromPincode.Checked || chkFromDistrict.Checked || chkFromCity.Checked || chkFromState.Checked || chkfromRegion.Checked || chkToDepot.Checked)
        {
            if (chkToPincode.Checked || chkToDistrict.Checked || chkToCity.Checked || chkToState.Checked || chkToRegion.Checked || chkToDepot.Checked)
            {
                if (CFunctions.ID > 0)
                {
                    AddDIV.Visible = true;
                    if (ViewState["CurrentData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["CurrentData"];
                        int count = dt.Rows.Count;
                        //BindGrid(count);
                    }
                    else
                    {
                        //BindGrid(1);
                    }
                    insertContractCondition();
                    cmf.ButtonopacityHideShow(0, "RESET", Btn_ResetGeoScope);
                    clearAddGeoScope();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Please Select To Checkbox')", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Please Select From Checkbox')", true);
        }
    }
    public void clearAddGeoScope()
    {
        Txt_FromPincode.Text = "";
        hfFromPincode.Value = "";
        chkFromPincode.Checked = false;
        Txt_ToPincode.Text = "";
        hfToPincode.Value = "";
        chkToPincode.Checked = false;

        Txt_FromDistrict.Text = "";
        hfFromDistrict.Value = "";
        chkFromDistrict.Checked = false;
        Txt_ToDistrict.Text = "";
        hfToDistrict.Value = "";
        chkToDistrict.Checked = false;

        Txt_FromCity.Text = "";
        hfFromCity.Value = "";
        chkFromCity.Checked = false;
        Txt_ToCity.Text = "";
        hfToCity.Value = "";
        chkToCity.Checked = false;

        Txt_FromState.Text = "";
        hfFromState.Value = "";
        chkFromState.Checked = false;
        Txt_ToState.Text = "";
        hfToState.Value = "";
        chkToState.Checked = false;

        Txt_Weight.Text = "";
        Txt_Price.Text = "";
    }

    public void insertContractCondition()
    {
        con.Open();
        SqlCommand sqlcmd = new SqlCommand("ssp_CreateContractCondition", con);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        //sqlcmd.Parameters.AddWithValue("@ContractId", CFunctions.ID);
        sqlcmd.Parameters.AddWithValue("@ContractId", Txt_ContractId.Text);

        if (chkFromPincode.Checked) 
            sqlcmd.Parameters.AddWithValue("@fromLocId", hfFromPincode.Value.ToString());
        else    
            sqlcmd.Parameters.AddWithValue("@fromLocId", null);
        if (chkFromDistrict.Checked)
            sqlcmd.Parameters.AddWithValue("@fromDistrictId", hfFromDistrict.Value.ToString());
        else
            sqlcmd.Parameters.AddWithValue("@fromDistrictId", null);
        if (chkFromCity.Checked)
            sqlcmd.Parameters.AddWithValue("@fromCityId", hfFromCity.Value.ToString());
        else 
            sqlcmd.Parameters.AddWithValue("@fromCityId", null);
        if (chkFromState.Checked)
            sqlcmd.Parameters.AddWithValue("@fromStateId", hfFromState.Value.ToString());
        else 
            sqlcmd.Parameters.AddWithValue("@fromStateId", null);
        if (chkToPincode.Checked)
            sqlcmd.Parameters.AddWithValue("@toLocId", hfToPincode.Value.ToString());
        else 
            sqlcmd.Parameters.AddWithValue("@toLocId", null);
        if (chkToDistrict.Checked)
            sqlcmd.Parameters.AddWithValue("@toDistrictId", hfToDistrict.Value.ToString());
        else 
            sqlcmd.Parameters.AddWithValue("@toDistrictId", null);

        if (chkToCity.Checked)
            sqlcmd.Parameters.AddWithValue("@toCityId", hfToCity.Value.ToString());
        else 
            sqlcmd.Parameters.AddWithValue("@toCityId", null);

        if (chkToState.Checked)
            sqlcmd.Parameters.AddWithValue("@toStateId", hfToState.Value.ToString());
        else 
            sqlcmd.Parameters.AddWithValue("@toStateId", null);

        if (chkfromRegion.Checked)
            sqlcmd.Parameters.AddWithValue("@fromRegionId", ddlFromRegion.SelectedValue.ToString());
        else
            sqlcmd.Parameters.AddWithValue("@fromRegionId", null);

        if (chkToRegion.Checked)
            sqlcmd.Parameters.AddWithValue("@toRegionId", ddlToRegion.SelectedValue.ToString());
        else
            sqlcmd.Parameters.AddWithValue("@toRegionId", null);

        if (Txt_Weight.Text.ToString().Trim() != "")
        {
            sqlcmd.Parameters.AddWithValue("@Weight", Txt_Weight.Text.ToString());
        }
        if (txtFromWeight.Text.ToString().Trim() != "")
        {
            sqlcmd.Parameters.AddWithValue("@FromWeight", txtFromWeight.Text.ToString());
        }
        if (txtToWeight.Text.ToString().Trim() != "")
        {
            sqlcmd.Parameters.AddWithValue("@ToWeight", txtToWeight.Text.ToString());
        }
        if (hfMaterialID.Value.ToString().Trim() != "")
        {
            sqlcmd.Parameters.AddWithValue("@materialId", hfMaterialID.Value.ToString());
        }
        if(chkToDepot.Checked)
        {
            sqlcmd.Parameters.AddWithValue("@depot", "1"); 
        }

        sqlcmd.Parameters.AddWithValue("@RateValue", Txt_Price.Text.ToString());
        sqlcmd.ExecuteNonQuery();
        con.Close();
	    fillContractCondition(Txt_ContractId.Text);
    }

    protected void Btn_ResetGeoScope_Click(object sender, EventArgs e)
    {
        clearAddGeoScope();
        AddDIV.Visible = false;
    }

    protected void Btn_PickupReset_Click(object sender, EventArgs e)
    {
        clearPickupSchedule();
    }
    protected void deleteContractCondition_Click(object sender, EventArgs e)
    {
        string contractConditionId = (sender as LinkButton).CommandArgument; 
        (new RateCardFunctions()).deleteContractCondition(contractConditionId);
        fillContractCondition(Txt_ContractId.Text);
    }
} 