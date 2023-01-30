using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using CommonLibrary;
using System.Web.Services;
using BLFunctions;
using BLProperties;
using NameSpaceConnection;

public partial class OPERATIONS_party_master_CustomerCreation : System.Web.UI.Page
{
    int val;
    String PkFieldId, result = "";
    /*- PkFieldId Store DatakeyValue of Gridview,
      - result store Code Alpha Value*/

    /*Create Object of Connecton and BindDropdownlist Class*/
    NameSpaceConnection.Connection con = new NameSpaceConnection.Connection();
    //SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    CommonFunctions cmf = new CommonFunctions();
    CFunctions cmf1 = new CFunctions();
    InsertUpdateProcedureWithParameters InsertUpdate = new InsertUpdateProcedureWithParameters();
    // PartyCustomerAndVendorMasterClass pm = new PartyCustomerAndVendorMasterClass();

    static String fileName1;
    static String fileName2;
    static String fileName3;
    static String fileName4;
    static String fileName5;
    static String fileName6;
    int s = 0;

    #region  /*---------------------------------------------------------------------------Page Load------------------------------------------------------------------------------*/
    protected void Page_Load(object sender, EventArgs e)
    {
        // ScriptManager.RegisterStartupScript(this, this.GetType(), "Onload", ".FirstNoSpaceAndZero;", true);
        //AutoClear();
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                /*Auto Focus*/
                Txt_CustomerName.Focus();
                /*Enable false button*/
                cmf.ButtonopacityHideShow(0, "NEXT", Btn_CustomerNext);
                cmf.ButtonopacityHideShow(0, "NEXT", Btn_OtherNext);
                /*Set Variable*/

                CFunctions.setTabStatus(0);

                /*Call FillGridFinalVendor And GetMaxId Function*/
                //FillGrid();

                /*Calling DropBindDropdownDoubleParameter using object of BindDropdownlist*/
                // (new CFunctions()).GetJavascriptFunction(this, "Txt_PickupPincode", "hfPickupPincode", "~/Party_CustomerCreation.aspx/getPincode", "GetData", "});});");
                //  (new CFunctions()).GetJavascript(CFunctions.javascript, this);

                //  GetBranchList();
                cmf.BindDataValueInListTripleParameter("", null, CheckBoxList_SalesPerson, null, "ssp_GetEmployeeList", "@DepartmentName", "SALES", "", "", "", "", "fullName", "userID", Txt_SalesPerson);
                //cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchCustName, "ssp_GetCustomerList", "", "", "", "", "", "", "customerName", "customerID", null);
                cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchSalesPersonName, "ssp_GetEmployeeList", "@DepartmentName", "SALES", "", "", "", "", "fullName", "userID", null);
                //  cmf.BindDataValueInListTripleParameter("", null, null, Ddl_BillingParty, "ssp_GetBillingPartyName", "@customerType", Ddl_TypeofParty.SelectedItem.Text.ToString(), "", "", "", "", "customerName", "customerID", null);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }


            //((IAttributeAccessor)FindControlRecursive(this.Page, Txt_Pickup_Pincode)).SetAttribute("onblur", "onPopupLostFocus();");
                    (new CFunctions()).GetJavascriptFunction(this, "Txt_Pincode", "hfPincode", "Party_CustomerCreation.aspx/getPincode", "GetData", "});");

        }
        /*DataTable dt = DummyData();
        Gv_BelongToBranch.DataSource = dt;
        Gv_BelongToBranch.DataBind();*/

        string str = "$(\"[id$=billingparty]\").hide();";
        //str = ""; 

        string strDataTable = "$(function() {" + "\n" +
                         "var Index=0;" + "\n" +
          "$(\"[id*=Btn_AddCustomerBranch]\").click(function() {" + "\n" +
        #region
        "var hfAddCustomerBranch = $(\"[id*=hfAddCustomerBranch]\");" + "\n" +
          "if(hfAddCustomerBranch.val() != 0){" +
          "console.log(hfAddCustomerBranch.val());" +
          "var gridView = $(\"[id*=Gv_BelongToBranch]\");" + "\n" +
          "var row = gridView.find(\"tr\").eq(1);" + "\n" +
          "var rowData= row.find(\"td\").eq(1).find(\"input\").eq(0).val()" + "\n" +
            "console.log(\"Row Data:\")" + "\n" +
          "console.log(rowData)" + "\n" +
          "if ($.trim(row.find(\"td\").eq(1).html()) == \"&nbsp;\" || rowData==\"\") {" + "\n" +
          "row.remove();" + "\n" +
          "Index=0;" +
          "}" + "\n" +
          "row = row.clone(true);" + "\n" +
          "Index=Index+1;" + "\n" +
          "console.log(Index+\"Table\");" +
          "$(\"[id*=AutoIncrementNo]\").val(Index);" + "\n" +
          "var txtAutoIncrementNo = $(\"[id*=AutoIncrementNo]\");" + "\n" +
          "SetValue(row, 0, \"Index\", txtAutoIncrementNo);" + "\n" +
          "var locID = $(\"[id*=hfPincode]\");" + "\n" +
          "SetValue(row, 1, \"locID\", locID);" + "\n" +
          "var Pincode = $(\"[id*=Txt_Pincode]\");" + "\n" +
          "SetValue(row, 2, \"Pincode\", Pincode);" + "\n" +
          "var State = $(\"[id*=Txt_State]\");" + "\n" +
          "SetValue(row, 3, \"State\", State);" + "\n" +
          "var District = $(\"[id*=Txt_District]\");" + "\n" +
          "SetValue(row, 4, \"District\", District);" + "\n" +
          "var city = $(\"[id*=Txt_City]\");" + "\n" +
          "SetValue(row, 5, \"city\", city);" + "\n" +
          "var Area = $(\"[id*=Ddl_Area]\");" + "\n" +
          "SetDDlValue(row, 6, \"Area\", Area);" + "\n" +
          "var AreaID = $(\"[id*=hfArea]\");" + "\n" +
          "SetValue(row, 7, \"AreaID\", AreaID);" + "\n" +
          "var Address = $(\"[id*=Txt_BillingAddress]\");" + "\n" +
          "SetValue(row, 8, \"Address\", Address);" + "\n" +
          "var BelongToBranch = $(\"[id*=Txt_BelongToBranch]\");" + "\n" +
          "SetValue(row, 9, \"BelongToBranch\", BelongToBranch);" + "\n" +
          "var BelongToBranchID = $(\"[id*=hfbranchID]\");" + "\n" +
          "SetValue(row, 10, \"BelongToBranchID\", BelongToBranchID);" + "\n" +
          "gridView.append(row);" + "\n" +
          "Pincode.val(\"\");" + "\n" +
          "locID.val(\"\");" + "\n" +
          "State.val(\"AUTO\");" + "\n" +
          "District.val(\"AUTO\");" + "\n" +
          "city.val(\"AUTO\");" + "\n" +
          "Area.empty();" + "\n" +
          "Area.append('<option selected=\"selected\" value=\"0\">SELECT</option>');" + "\n" +
          "AreaID.val(\"\");" + "\n" +
          "Address.val(\"\");" + "\n" +
          "BelongToBranch.val(\"AUTO\");" + "\n" +
          "BelongToBranchID.val(\"\");" + "\n" +
          "}" + "\n" +
          "return false;" + "\n" +
          "});" + "\n" +
          "function SetValue(row, index, name, textbox)" + "\n" +
          "{" + "\n" +
          "row.find(\"td\").eq(index).html(textbox.val());" + "\n" +
          "var input = $(\"<input type = 'hidden' />\");" + "\n" +
          "input.prop(\"name\", name);" + "\n" +
          "input.val(textbox.val());" + "\n" +
          "row.find(\"td\").eq(index).append(input);" + "\n" +
          "}" + "\n" +

           "function SetDDlValue(row, index, name, ddl)" + "\n" +
          "{" + "\n" +
          "row.find(\"td\").eq(index).html(ddl.children(\":selected\").text());" + "\n" +
          "var input = $(\"<input type = 'hidden' />\");" + "\n" +
          "input.prop(\"name\", name);" + "\n" +
          "input.val(ddl.children(\":selected\").text());" + "\n" +
          "row.find(\"td\").eq(index).append(input);" + "\n" +
          "}" + "\n" +
        #endregion
         "}),";

        //strDataTable = ""; 

        String saveCustData = "$(function () {" + "\n" +
                "$(\"[id*=Button_Tab1Save]\").bind(\"click\", function() {" + "\n" +
                 "var hfButtonTab1Save = $(\"[id*=hfButtonTab1Save]\");" + "\n" +
                 "console.log(hfButtonTab1Save.val());" +
        #region
                            "if(hfButtonTab1Save.val()==1){" + "\n" +
                "$(\"[id*=LoadingImage]\").show();" + "\n" +
                "var CustHeader = { }; var dataC = { };" + "\n" +
                  "var CustDetail=[];var Count;" + "\n" +
                  "var dataCustNo = $(\"[id*=Txt_CustCode]\");" + "\n" +
                   " dataC.custNo = dataCustNo.val();" +
                   "if(dataC.custNo!=\"\"){" + "\n" +
                    "CustHeader.CustNo=$(\"[id$=Txt_CustCode]\").val();" + "\n" +
                    "}" + "\n" +

                "CustHeader.CustType=$(\"[id$=Ddl_TypeofParty]\").val();" + "\n" +
                "CustHeader.CustCategory = $(\"[id*=Ddl_Categoryofcustomer]\").val();" + "\n" +
                "CustHeader.Name = $(\"[id*=Txt_CustomerName]\").val();" + "\n" +
                "CustHeader.ContactNo = $(\"[id*=Txt_ContactNo]\").val();" + "\n" +
                "CustHeader.EmailId = $(\"[id*=Txt_CustEmailId]\").val();" + "\n" +
                "if(CustHeader.CustCategory==\"CUSTOMER\"){" + "\n" +
                "CustHeader.CustBillingID=$(\"[id$=hfBillingParty]\").val();" + "\n" +
                "}" + "\n" +
                "else{" + "\n" +
                 "CustHeader.CustBillingID=0;}" + "\n" +
                "CustHeader.ModeOfPayment = $(\"[id*=Ddl_ModeOfPayment]\").val();" + "\n" +
                "CustHeader.Category = $(\"[id*=Ddl_CustCategory]\").val();" + "\n" +
                "CustHeader.CustCreditLimit = $(\"[id*=Txt_CreditLimit]\").val();" + "\n" +

                "if($(\"[id*=CheckBox_AutoUtility1]\").prop('checked', true)){" + "\n" +
                "CustHeader.AutoUtility=$(\"[id$=CheckBox_AutoUtility1]\").val();" + "\n" +
                "}" + "\n" +

                "if($(\"[id*=CheckBox_AutoUtility2]\").prop('checked', true)){" + "\n" +
                "CustHeader.AutoUtility=(CustHeader.AutoUtility=\"\") ? $(\"[id$=CheckBox_AutoUtility2]\").val() : CustHeader.AutoUtility + \",\" + $(\"[id$=CheckBox_AutoUtility2]\").val();" + "\n" +
                "}" + "\n" +

                "if($(\"[id*=CheckBox_AutoUtility3]\").prop('checked', true)){" + "\n" +
                "CustHeader.AutoUtility=(CustHeader.AutoUtility=\"\") ? $(\"[id$=CheckBox_AutoUtility3]\").val() : CustHeader.AutoUtility + \",\" + $(\"[id$=CheckBox_AutoUtility3]\").val();" + "\n" +
                "}" + "\n" +


                 "var gridView = $(\"[id*=Gv_BelongToBranch]\");" + "\n" +
                 "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                 "var rowData= row.find(\"td\").eq(1).find(\"input\").eq(0).val()" + "\n" +
                 "console.log($.trim(row.find(\"td\").eq(1).html()));" +
                 "console.log(rowData);" +
                 "if($.trim(row.find(\"td\").eq(1).html()) != \"&nbsp;\" && rowData!=\"\"){" +
                                    "console.log(rowData);" +
                "$(\"[id*=Gv_BelongToBranch] tr\").each(function() {" + "\n" +
                "Count=($(this).length)-1;" + "\n" +
                "if (!this.rowIndex) return;" + "\n" +
                "var SubDetail={};" + "\n" +
                "SubDetail.LocId= $(this).find(\"td\").eq(1).find(\"input\").eq(0).val();" + "\n" +
                "SubDetail.AreaId = $(this).find(\"td\").eq(7).find(\"input\").eq(0).val();" + "\n" +
                "SubDetail.BillingAddress =  $(this).find(\"td\").eq(8).find(\"input\").eq(0).val();" + "\n" +
                "SubDetail.BelongToBranchId = $(this).find(\"td\").eq(10).find(\"input\").eq(0).val();" + "\n" +

                "CustDetail.push(SubDetail);" + "\n" + "\n" +
        "});" + "\n" +
        "}" +
        "//console.log(CustHeader);" +
        "//console.log(CustDetail);" +
        "if(){  \n" +
        "$.ajax({" + "\n" +
        "url: \"Party_CustomerCreation.aspx/SaveCustomerData\"," + "\n" +
        "data: '{CustHeader: ' + JSON.stringify(CustHeader) + ', CustDetail:' + JSON.stringify(CustDetail) + ', dataCustNo:' + JSON.stringify(dataC) +'}'," + "\n" +
        "type: \"POST\"," + "\n" +
        "dataType: \"json\"," + "\n" +
        "contentType: \"application/json; charset=utf-8\"," + "\n" +
        "success: function(response) {" + "\n" +
          "var data=response.d;" + "\n" +
          "if(data==0){" + "\n" +
          "$(\"[id*=LoadingImage]\").hide();" + "\n" +
          "alert(\"Customer No is already exist...\");" + "\n" +
            "}" + "\n" +
              "else{" + "\n" +

        // "console.log(\"data:\"+ data);" + "\n" +      
        "$(\"[id*=hfGetCustID]\").val(data);" + "\n" +
        //   "console.log($(\"[id*=hfGetCustID]\").val());" +
        "clearData();" + "\n" +
        "$(\"[id*=LoadingImage]\").hide();" + "\n" +
        // alert msg
                "newFunction(\"Button_Tab1Save\",\"SAVE\")" + "\n" +

          // "alert(\"Data Added Successfully...\");" + "\n" +

          "}" + "\n" +

        "}," + "\n" +
         "error: function(response) {" + "\n" +
               "alert(response.responseText);" + "\n" +
                "$(\"[id*=LoadingImage]\").hide();" + "\n" +
         "}," + "\n" +
         "failure: function(response) {" + "\n" +
         "$(\"[id*=LoadingImage]\").hide();" + "\n" +
         "alert(response.responseText);" + "\n" +
         "}" + "\n" +
      "});" + "\n" +
      "}" + "\n" +
      "return false;" + "\n" +
      "});" + "\n" +
      "function clearData() {" + "\n" +
       "console.log(\"clear\");" + "\n" +
       "$(\"[id*=Ddl_TypeofParty]\").val(\"CORPORATE\");" + "\n" +
       "$(\"[id*=Ddl_Categoryofcustomer]\").val(\"CUSTOMER\");" + "\n" +
       "$(\"[id*=Txt_CustomerName]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_CustCode]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_ContactNo]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_CustEmailId]\").val(\"\");" + "\n" +
       "$(\"[id*=Txt_BillingParty]\").val(\"\");" + "\n" +
       "$(\"[id$=billingparty]\").hide();" +
       "$(\"[id*=hfBillingParty]\").val(\"\");" + "\n" +
       "$(\"[id*=Ddl_ModeOfPayment]\").val(\"CREDIT\");" + "\n" +
       "$(\"[id*=Ddl_CustCategory]\").val(\"FIRM/COMPANY\");" + "\n" +
       "$(\"[id*=Txt_CreditLimit]\").val(\"\");" + "\n" +
       "$(\"[id*=CheckBox_AutoUtility1]\").prop('checked', false);" + "\n" +
       "$(\"[id*=CheckBox_AutoUtility2]\").prop('checked', false);" + "\n" +
       "$(\"[id*=CheckBox_AutoUtility3]\").prop('checked', false);" + "\n" +
       "AddGridviewRow();" +
       "$(\"[id*=hfButtonTab1Save]\").val(0);" + "\n" +
       "$(\"[id*=Txt_CustomerName]\").focus();" +
      "};" +
       // function for Add Blank DataTable Row after Submit
       "function AddGridviewRow()" +
              "{" +
                  "var hfButtonTab1Save = $(\"[id*=hfButtonTab1Save]\");" + "\n" +
                  "console.log(\"add\"+hfButtonTab1Save);" +
                  "if(hfButtonTab1Save.val() !=0){" +
                  "var gridView = $(\"[id*=Gv_BelongToBranch]\");" + "\n" +
                  "var row = gridView.find(\"tr\").eq(1);" + "\n" +
                  "$(\"[id*=Gv_BelongToBranch]\").find(\"tr:not(:nth-child(1)):not(:nth-child(2))\").remove();" +
                  "Index=1;" + "\n" +
                  "$(\"[id*=AutoIncrementNo]\").val(Index);" + "\n" +
                  "var txtAutoIncrementNo = $(\"[id*=AutoIncrementNo]\");" + "\n" +
                  "SetValue(row, 0, \"Index\", txtAutoIncrementNo);" + "\n" +
                  "var locID = $(\"[id*=hfPincode]\");" + "\n" +
                  "locID.val(\"\");" + "\n" +
                  "SetValue(row, 1, \"locID\", locID);" + "\n" +
                  "var Pincode = $(\"[id*=Txt_Pincode]\");" + "\n" +
                  "SetValue(row, 2, \"Pincode\", Pincode);" + "\n" +
                  "var State = $(\"[id*=Txt_State]\");" + "\n" +
                  "SetValue(row, 3, \"State\", Pincode);" + "\n" +
                  "var District = $(\"[id*=Txt_District]\");" + "\n" +
                  "SetValue(row, 4, \"District\", Pincode);" + "\n" +
                  "var city = $(\"[id*=Txt_City]\");" + "\n" +
                  "SetValue(row, 5, \"city\", Pincode);" + "\n" +
                  "var Area = $(\"[id*=Ddl_Area]\");" + "\n" +
                  "SetDDlValue(row, 6, \"Area\", Pincode);" + "\n" +
                   "var AreaID = $(\"[id*=hfArea]\");" + "\n" +
                  "AreaID.val(\"\");" + "\n" +
                  "SetValue(row, 7, \"AreaID\", AreaID);" + "\n" +
                  "var Address = $(\"[id*=Txt_BillingAddress]\");" + "\n" +
                  "SetValue(row, 8, \"Address\", Address);" + "\n" +
                  "var BelongToBranch = $(\"[id*=Txt_BelongToBranch]\");" + "\n" +
                  "SetValue(row, 9, \"BelongToBranch\", Pincode);" + "\n" +
                  "var BelongToBranchID = $(\"[id*=hfbranchID]\");" + "\n" +
                  "BelongToBranchID.val(\"\");" + "\n" +
                  "SetValue(row, 10, \"BelongToBranchID\", BelongToBranchID);" + "\n" +
                  "gridView.append(row);" + "\n" +
                  "};" +
              "};" +
           "function SetValue(row, index, name, textbox)" + "\n" +
           "{" + "\n" +
           "row.find(\"td\").eq(index).html(textbox.val());" + "\n" +
           "var input = $(\"<input type = 'hidden' />\");" + "\n" +
           "input.prop(\"name\", name);" + "\n" +
           "input.val(textbox.val());" + "\n" +
           "row.find(\"td\").eq(index).append(input);" + "\n" +
           "};" + "\n" +

            "function SetDDlValue(row, index, name, ddl)" + "\n" +
           "{" + "\n" +
           "row.find(\"td\").eq(index).html(ddl.children(\":selected\").text());" + "\n" +
           "var input = $(\"<input type = 'hidden' />\");" + "\n" +
           "input.prop(\"name\", name);" + "\n" +
           "input.val(ddl.children(\":selected\").text());" + "\n" +
           "row.find(\"td\").eq(index).append(input);" + "\n" +
           "}" + "\n" +

        #endregion
                 "}),";

        //saveCustData = ""; 
        //CFunctions.setjavascript(CFunctions.javascript + str + strDataTable + saveCustData );
        CFunctions.setjavascript(CFunctions.javascript);

        (new CFunctions()).GetJavascriptFunction(this, "Txt_BillingParty", "hfBillingParty", "Party_CustomerCreation.aspx/getBillingParty", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }
    #endregion

    #region /*---------------------------------------------------------------------All Function Defination------------------------------------------------------------------------------*/
    // Get Pincode
    [WebMethod]
    public static string[] getPincode(string searchPrefixText, string data = null)
    {
        return (new CommFunctions()).getPincode(searchPrefixText, data);
    }

    [WebMethod]
    public static string[] PincodeDetail(int pincode)
    {
        return (new CommFunctions()).PincodeDetail(pincode);
    }
    //Get Area in Dropdown List
    [WebMethod]
    public static List<FullAddress> getArea(int pincode)
    {
        return (new CommFunctions()).getArea(pincode);
    }
    //Get Billing Party Name in Dropdown List
    [WebMethod]
    public static string[] getBillingParty(string searchPrefixText, string data = null)
    {
        return (new PartyCustomerFunctions()).GetBillingPartyName(searchPrefixText, data);
    }



    // On Submit Tab 1
    [WebMethod]
    public static int SaveCustomerData(CustomerHeader CustHeader, List<CustomerDetails> CustDetail, dataCust dataCustNo)
    {
        return (new PartyCustomerFunctions()).SaveCustomerData(CustHeader, CustDetail, dataCustNo);
    }

    //public void GetBranchList()
    //{
    //    Ddl_BranchName.DataSource = (new CommFunctions()).GetBranch();
    //    Ddl_BranchName.DataTextField = "branchName";
    //    Ddl_BranchName.DataValueField = "branchId";
    //    Ddl_BranchName.DataBind();
    //    Ddl_BranchName.Items.Insert(0, "SELECT");
    //}
    /*----------------Auto Complete Code false--------------------*/
    //Dummy Entry
    public DataTable DummyData()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("locID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("Pincode", typeof(String)));
        dt.Columns.Add(new DataColumn("State", typeof(String)));
        dt.Columns.Add(new DataColumn("District", typeof(String)));
        dt.Columns.Add(new DataColumn("city", typeof(String)));
        dt.Columns.Add(new DataColumn("Area", typeof(String)));
        dt.Columns.Add(new DataColumn("AreaID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("Address", typeof(String)));
        dt.Columns.Add(new DataColumn("BelongToBranchID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("BelongToBranch", typeof(String)));
        dt.Columns.Add(new DataColumn("custBelongToBranchID", typeof(String)));
        dt.Rows.Add();
        return dt;
    }


    public void AutoClear()
    {
        Txt_CustomerName.Attributes.Add("autocomplete", "off");
        Txt_ContactNo.Attributes.Add("autocomplete", "off");
        Txt_CustEmailId.Attributes.Add("autocomplete", "off");
        Txt_BillingAddress.Attributes.Add("autocomplete", "off");
	txtGSTNo.Attributes.Add("autocomplete", "off");
        Txt_OtherPersonName.Attributes.Add("autocomplete", "off");
        Txt_OtherContactNo.Attributes.Add("autocomplete", "off");
        Txt_OtherPersonEmailId.Attributes.Add("autocomplete", "off");
        Txt_AdharcardNo.Attributes.Add("autocomplete", "off");
        Txt_PanCardNo.Attributes.Add("autocomplete", "off");
        Txt_CustomerGSTCertificates.Attributes.Add("autocomplete", "off");
        Txt_CustomerCIN.Attributes.Add("autocomplete", "off");
        Txt_OtherPanCardNo.Attributes.Add("autocomplete", "off");
        Txt_OtherAdharcardNo.Attributes.Add("autocomplete", "off");
    }



    /*----------------Fill Data in Gridview Code with sorting--------------------*/
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private void FillGrid(string sortExpression = null)
    {
        /*if (con1.State == ConnectionState.Closed)
        {
            con1.Open();
        }*/
        con.cmd = new SqlCommand("spViewPartyCustomerMaster");
        con.cmd.CommandType = CommandType.StoredProcedure;
        con.cmd.Parameters.AddWithValue("@Event", "View_FinalCustomer");
        con.cmd.Parameters.AddWithValue("@CustomerCode", "");
        con.DA = new SqlDataAdapter(con.cmd);
        con.Dt = new DataTable();
        con.DA.Fill(con.Dt);
        if (sortExpression != null)
        {
            DataView dv = con.Dt.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            GV_CustomerView.DataSource = dv;
            // GV_Export.DataSource = dv;                                      /*Export GV*/
        }
        else
        {
            GV_CustomerView.DataSource = con.Dt;
            //  GV_Export.DataSource = con.Dt;                                  /*Export GV*/
        }
        GV_CustomerView.DataBind();
        // GV_Export.DataBind();                                               /*Export GV*/

    }

    /*----------------ClearText OR Disable Code--------------------*/
    //tab1 Clear
    public void ClearCustomerData()
    {
        Ddl_TypeofParty.SelectedIndex = 1;
        //Ddl_Categoryofcustomer.SelectedIndex = 2;
        Txt_CustomerName.Text = "";
        Txt_ContactNo.Text = "";
        Txt_CustEmailId.Text = "";
        Txt_Pincode.Text = "";
        Txt_State.Text = "AUTO";
        Txt_District.Text = "AUTO";
        Txt_City.Text = "AUTO";
        Txt_BillingParty.Text = "";
        Txt_BillingAddress.Text = "";
	txtGSTNo.Text = ""; 
        Ddl_ModeOfPayment.SelectedIndex = 0;
        // Ddl_BranchName.SelectedIndex = 0;
        //Ddl_CustCategory.SelectedIndex = 2;
        Txt_CreditLimit.Text = "";
        CheckBox_AutoUtility1.Checked = false;
        CheckBox_AutoUtility2.Checked = false;
        CheckBox_AutoUtility3.Checked = false;
        ViewData.Visible = false;
    }
    //tab1 Disable
    public void DisableCustomerData()
    {
        Ddl_TypeofParty.Attributes.Add("disabled", "disabled");
        Ddl_Categoryofcustomer.Attributes.Add("disabled", "disabled");
        Txt_CustomerName.Enabled = false;
        Txt_CustCode.Enabled = false;
        Txt_ContactNo.Enabled = false;
        Txt_CustEmailId.Enabled = false;
        Txt_BillingParty.Enabled = false;
        //Txt_BillingAddress.Enabled = false;
        Ddl_ModeOfPayment.Attributes.Add("disabled", "disabled");
        Ddl_CustCategory.Attributes.Add("disabled", "disabled");
        Txt_CreditLimit.Enabled = false;
        CheckBox_AutoUtility1.Enabled = false;
        CheckBox_AutoUtility2.Enabled = false;
        CheckBox_AutoUtility3.Enabled = false;
    }
    //tab2 clear
    public void ClearLogisticsData()
    {
        Txt_SalesPerson.Text = "";
        Ddl_PersonDesignation.SelectedIndex = 0;
        Txt_OtherPersonName.Text = "";
        Txt_OtherContactNo.Text = "";
        Txt_OtherPersonEmailId.Text = "";
        GridviewOtherDiv.Visible = false;
        Txt_SalesPerson.Enabled = true;
        Panel_SalesPerson.Visible = true;
        for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
        {
            CheckBoxList_SalesPerson.Items[i].Selected = false;
        }
    }
    //tab32 Disable
    public void DisableLogisticsData()
    {
        Txt_SalesPerson.Enabled = false;
        Panel_SalesPerson.Visible = false;
        Ddl_PersonDesignation.Enabled = false;
        Txt_OtherPersonName.Enabled = false;
        Txt_OtherContactNo.Enabled = false;
        Txt_OtherPersonEmailId.Enabled = false;
    }
    //tab1 Clear
    public void ClearDocumentData()
    {
        Txt_PanCardNo.Text = "";
        Cust_PanCard_Label.InnerHtml = "";
        Txt_AdharcardNo.Text = "";
        Cust_AadhaarCard_Label.InnerHtml = "";
        Txt_CustomerGSTCertificates.Text = "";
        Cust_GST_Label.InnerHtml = "";
        Txt_CustomerCIN.Text = "";
        Cust_CIN_Label.InnerHtml = "";
        Txt_OtherPanCardNo.Text = "";
        Logistic_PanCard_Label.InnerHtml = "";
        Txt_OtherAdharcardNo.Text = "";
        Logistic_AadhaarCard_Label.InnerHtml = "";
        ViewData.Visible = false;
        Ddl_UploadDesignation.SelectedIndex = 0;
    }
    //Active All Fields
    public void ActiveAllTextFields()
    {
        Ddl_TypeofParty.Attributes.Remove("disabled");
        Ddl_Categoryofcustomer.Attributes.Remove("disabled");
        Ddl_ModeOfPayment.Attributes.Remove("disabled");
        Txt_CustomerName.Enabled = true;
        Txt_CustCode.Enabled = true;
        Txt_ContactNo.Enabled = true;
        Txt_CustEmailId.Enabled = true;
        Txt_BillingParty.Enabled = true;
        Txt_BillingAddress.Enabled = true;
	txtGSTNo.Enabled = true; 
        Ddl_CustCategory.Attributes.Remove("disabled");
        Txt_CreditLimit.Enabled = true;
        CheckBox_AutoUtility1.Enabled = true;
        CheckBox_AutoUtility2.Enabled = true;
        CheckBox_AutoUtility3.Enabled = true;
        Txt_OtherPersonName.Enabled = true;
        Txt_OtherContactNo.Enabled = true;
        Txt_OtherPersonEmailId.Enabled = true;
    }

    /*----------------Load Data Into Text Code--------------------*/


    #endregion

    #region      /*----------------------------------------------------------------------Tab1 Start Code / Customer--------------------------------------------------------------------*/
    //Hide show customer category
    protected void Ddl_TypeofParty_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (Ddl_TypeofParty.SelectedItem.ToString() != "SELECT")
        {
            Ddl_Categoryofcustomer.Focus();
        }
        else
        {
            Ddl_TypeofParty.Focus();
        }

    }
    // billing party hide show 
    //and text change customer name to billing party name  
    //and customer credit code to billing party code
    //protected void Ddl_Categoryofcustomer_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Ddl_Categoryofcustomer.Value == "1")
    //    {
    //        if (Ddl_Categoryofcustomer.SelectedItem.ToString() == "BILLING PARTY")
    //        {              
    //            billingparty.Visible = false;
    //            Txt_CustomerName.Focus();

    //        }
    //        else if (Ddl_Categoryofcustomer.SelectedItem.ToString() == "CUSTOMER")
    //        {                
    //            billingparty.Visible = true;
    //            Txt_CustomerName.Focus();
    //        }
    //        else
    //        {
    //            Ddl_Categoryofcustomer.Focus();
    //        }

    //        HiddenField_Ddl_Categoryofcustomer.Value = "";
    //    }


    //}



    //****************************************Function For Data Table Generation of Customer**********************************************************
    #region
    //private void AddBelongToBranchCustomer(int rowcount)
    //{
    //    DataTable dt = new DataTable();
    //    DataRow dr;
    //    dt.Columns.Add(new System.Data.DataColumn("Pincode", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("locID", typeof(int)));
    //    dt.Columns.Add(new System.Data.DataColumn("State", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("District", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("city", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("Area", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("AreaID", typeof(int)));
    //    dt.Columns.Add(new System.Data.DataColumn("BelongToBranch", typeof(String)));
    //    dt.Columns.Add(new System.Data.DataColumn("BelongToBranchID", typeof(int)));

    //    if (ViewState["VW_BelongToBranch"] != null)
    //    {
    //        for (int i = 0; i < rowcount + 1; i++)
    //        {
    //            dt = (DataTable)ViewState["VW_BelongToBranch"];
    //            if (dt.Rows.Count > 0)
    //            {
    //                dr = dt.NewRow();
    //                dr[0] = dt.Rows[0][0].ToString();
    //            }
    //        }
    //        dr = dt.NewRow();
    //        dr[0] = Txt_Pincode.Text.ToString();
    //        dr[1] = hfPincode.Value.ToString();
    //        dr[2] = Txt_State.Text.ToString();
    //        dr[3] = Txt_District.Text.ToString();
    //        dr[4] = Txt_City.Text.ToString();
    //        dr[5] = Ddl_Area.SelectedItem.Text.ToString();
    //        dr[6] = hfArea.Value.ToString();
    //        dr[7] = Txt_BelongToBranch.Text.ToString();
    //        dr[8] = hfbranchID.Value.ToString();
    //        dt.Rows.Add(dr);

    //    }
    //    else
    //    {
    //        dr = dt.NewRow();
    //        dr[0] = Txt_Pincode.Text.ToString();
    //        dr[1] = hfPincode.Value.ToString();
    //        dr[2] = Txt_State.Text.ToString();
    //        dr[3] = Txt_District.Text.ToString();
    //        dr[4] = Txt_City.Text.ToString();
    //        dr[5] = Ddl_Area.SelectedItem.Text.ToString();
    //        dr[6] = hfArea.Value.ToString();
    //        dr[7] = Txt_BelongToBranch.Text.ToString();
    //        dr[8] = hfbranchID.Value.ToString();
    //        dt.Rows.Add(dr);
    //    }
    //    // If ViewState has a data then use the value as the DataSource
    //    if (ViewState["VW_BelongToBranch"] != null)
    //    {
    //        Gv_BelongToBranch.DataSource = (DataTable)ViewState["VW_BelongToBranch"];
    //        Gv_BelongToBranch.DataBind();
    //    }
    //    else
    //    {
    //        // Bind GridView with the initial data assocaited in the DataTable

    //        Gv_BelongToBranch.DataSource = dt;
    //        Gv_BelongToBranch.DataBind();

    //    }
    //    // Store the DataTable in ViewState to retain the values
    //    ViewState["VW_BelongToBranch"] = dt;
    //    //con.con.Close();

    //}


    //protected void Btn_AddCustomerBranch_Click(object sender, EventArgs e)
    //{
    //    if (ViewState["VW_BelongToBranch"] != null)
    //    {
    //        DataTable dt = (DataTable)ViewState["VW_BelongToBranch"];
    //        int count = dt.Rows.Count;
    //        for (int i = 0; i < dt.Rows.Count; i++)
    //        {
    //            if ((dt.Rows[i]["BelongToBranch"]).ToString() == Txt_BelongToBranch.Text.ToString())
    //            {
    //                s = 1;
    //                //  Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('This is Already Selected');return false;}</script>");

    //                string a = "Btn_AddCustomerBranch";
    //                string b = "ADD1";
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);


    //                break;
    //            }

    //        }
    //        if (s == 0)
    //        {
    //            AddBelongToBranchCustomer(count);
    //        }
    //        else
    //            s = 0;

    //    }
    //    else
    //    {
    //        AddBelongToBranchCustomer(1);
    //    }
    //    Txt_Pincode.Text = "";
    //    hfPincode.Value = "";
    //    Txt_State.Text = "AUTO";
    //    Txt_District.Text = "AUTO";
    //    Txt_City.Text = "AUTO";
    //    Ddl_Area.SelectedIndex = 0;
    //    hfArea.Value = "";
    //    Txt_BelongToBranch.Text = "AUTO";
    //    hfbranchID.Value = "";
    //    Txt_Pincode.Focus();
    //}

    //protected void btn_Delete_Click(object sender, EventArgs e)
    //{
    //    String delete = (sender as LinkButton).CommandArgument;
    //    DataTable dt = (DataTable)ViewState["VW_BelongToBranch"];
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if ((dt.Rows[i]["BelongToBranch"]).ToString() == delete)
    //        {
    //            dt.Rows[i].Delete();
    //        }
    //    }

    //    Gv_BelongToBranch.DataSource = dt;
    //    Gv_BelongToBranch.DataBind();
    //    Txt_Pincode.Text = "";
    //    hfPincode.Value = "";
    //    Txt_State.Text = "AUTO";
    //    Txt_District.Text = "AUTO";
    //    Txt_City.Text = "AUTO";
    //    Ddl_Area.SelectedIndex = 0;
    //    hfArea.Value = "";
    //    Txt_BelongToBranch.Text = "AUTO";
    //    hfbranchID.Value = "";
    //    string a = "btn_Delete";
    //    string b = "DELETE";
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    //}

    #endregion


    /*Add New Area*/


    #region  /*Save Customer Data In Table*/
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {

        string CurrentDateTime = cmf1.CurrentDateTime();
        string AutoUtility = "";
        if (CheckBox_AutoUtility1.Checked) { AutoUtility = CheckBox_AutoUtility1.Text; }
        if (CheckBox_AutoUtility2.Checked) { AutoUtility = (AutoUtility == "") ? CheckBox_AutoUtility2.Text : AutoUtility + "," + CheckBox_AutoUtility2.Text; }
        if (CheckBox_AutoUtility3.Checked) { AutoUtility = (AutoUtility == "") ? CheckBox_AutoUtility3.Text : AutoUtility + "," + CheckBox_AutoUtility3.Text; }
        if (con.con.State == ConnectionState.Closed)
        {
            con.open();
        }
        //Submit Code
        if (CFunctions.tabstatus == 0)
        {
            // con.con.Open();
            SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdatePartyCustomer", con.con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@Customercheck", CFunctions.tabstatus);
            cmd.Parameters.AddWithValue("@customerID", "");
            cmd.Parameters.AddWithValue("@custno", Txt_CustCode.Text);
            cmd.Parameters.AddWithValue("@customerType", Ddl_TypeofParty.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@customerCategory", Ddl_Categoryofcustomer.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@Name", Txt_CustomerName.Text.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@ContactNo", Txt_ContactNo.Text);
            cmd.Parameters.AddWithValue("@EmailId", Txt_CustEmailId.Text.ToString());
            //cmd.Parameters.AddWithValue("@LocID", hfPincode.Value.ToString());
            //cmd.Parameters.AddWithValue("@areaID", hfArea.Value.ToString());
            if (Ddl_Categoryofcustomer.SelectedItem.ToString() == "CUSTOMER")
                cmd.Parameters.AddWithValue("@custBillingID", hfBillingParty.Value.ToString());
            else
                cmd.Parameters.AddWithValue("@custBillingID", 0);
            //cmd.Parameters.AddWithValue("@billingAddress", Txt_BillingAddress.Text.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@modeOfPayment", Ddl_ModeOfPayment.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@category", Ddl_CustCategory.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@customercreditlimit", Txt_CreditLimit.Text.ToString());
            cmd.Parameters.AddWithValue("@autoUtility", AutoUtility);
            cmd.Parameters.AddWithValue("@branchID", Session["BranchId"].ToString());
            cmd.Parameters.AddWithValue("@userID", Session["userID"].ToString());
            cmd.Parameters.AddWithValue("@creationDateTime", CurrentDateTime);

            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                CFunctions.setID(Convert.ToInt32(rd["Id"]));
                Lbl_CustomerId.Text = rd["Id"].ToString();
            }

            con.con.Close();
            cmf.ButtonopacityHideShow(0, "SAVE", Button_Tab1Save);
            cmf.ButtonopacityHideShow(0, "RESET", Btn_CustomerReset);
            cmf.ButtonopacityHideShow(1, "NEXT", Btn_CustomerNext);
            cmf.showalert("Button_Tab1Save", "SAVE", this);
        }
        else if (CFunctions.tabstatus == 1)
        {
            CFunctions.setTabStatus(1);

            SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdatePartyCustomer", con.con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Customercheck", CFunctions.tabstatus);
            cmd.Parameters.AddWithValue("@customerID", CFunctions.ID);
            cmd.Parameters.AddWithValue("@customerType", Ddl_TypeofParty.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@customerCategory", Ddl_Categoryofcustomer.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@Name", Txt_CustomerName.Text.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@ContactNo", Txt_ContactNo.Text.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@EmailId", Txt_CustEmailId.Text.ToString());
            cmd.Parameters.AddWithValue("@LocID", hfPincode.Value.ToString());
            cmd.Parameters.AddWithValue("@areaID", hfArea.Value.ToString());
            if (Ddl_Categoryofcustomer.SelectedItem.ToString() == "CUSTOMER")
                cmd.Parameters.AddWithValue("@custBillingID", hfBillingParty.Value.ToString());
            else
                cmd.Parameters.AddWithValue("@custBillingID", 0);
            //cmd.Parameters.AddWithValue("@billingAddress", Txt_BillingAddress.Text.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@modeOfPayment", Ddl_ModeOfPayment.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@category", Ddl_CustCategory.SelectedItem.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@customercreditlimit", Txt_CreditLimit.Text.ToString().ToUpper());
            cmd.Parameters.AddWithValue("@autoUtility", AutoUtility);
            cmd.Parameters.AddWithValue("@branchID", "");
            cmd.Parameters.AddWithValue("@userID", "");
            cmd.Parameters.AddWithValue("@creationDateTime", "");
            cmd.ExecuteNonQuery();

            cmf.ButtonopacityHideShow(0, "UPDATE", Button_Tab1Save);
            cmf.showalert("Button_Tab1Save", "UPDATE", this);
        }
        DisableCustomerData();
        //   cmf.BindDataValueInListTripleParameter("", RadioButtonList_SearchCustomerName, null, null, "spBindDropdownListPartyCustomerMaster", "@Event", "Search_Customer_Name", "@Name", "", "@SearchableData", "", "customerName", "customerName", Txt_SearchCustomerName);
        //   cmf.BindDataValueInListTripleParameter("", RadioButtonList_SearchBranchName, null, null, "spBindDropdownListPartyCustomerMaster", "@Event", "Search_BranchName", "@Name", "", "@SearchableData", "", "branchName", "branchName", Txt_SearchBranchName);
        Btn_CustomerNext.Focus();
        CFunctions.setTabStatus(0);

        List<NameSpaceConnection.Parameters> paramList = new List<NameSpaceConnection.Parameters>();
        paramList.Add(new NameSpaceConnection.Parameters("@branchID", Session["branchID"].ToString()));
        DataTable dtTable = (new NameSpaceConnection.Connection()).Fillsp("ssp_GetConsignorCodeList", paramList);
        HttpContext.Current.Application["CustCode"] = dtTable;

        List<NameSpaceConnection.Parameters> paramList1 = new List<NameSpaceConnection.Parameters>();
        paramList1.Add(new NameSpaceConnection.Parameters("@branchID", Session["branchID"].ToString()));
        DataTable dtTable1 = (new NameSpaceConnection.Connection()).Fillsp("ssp_GetCustomerList", paramList1);
        HttpContext.Current.Application["CustName"] = dtTable1;
    }
    #endregion
    //Reset Customer
    protected void Btn_CustomerReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_CustomerReset.Value == "1")
        {
            ClearCustomerData();
            HiddenField_CustomerReset.Value = "";
        }
    }
    /*----------------------------------------------------------------------Tab1 END Code--------------------------------------------------------------------*/
    #endregion

    #region      /*----------------------------------------------------------------------Tab2 Start Code / Other Person--------------------------------------------------------------------*/
    //Submit Sales Person Name in multiple checkboxes dropdown
    protected void LinkButton_Search_SalesPerson_Click(object sender, EventArgs e)
    {
        if (HiddenField_LinkButton_Search_SalesPerson.Value == "1")
        {
            Txt_Search_SalesPerson.Text = "";
            Txt_SalesPerson.Text = "";
            int c = 0;
            for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
            {
                if (CheckBoxList_SalesPerson.Items[i].Selected)
                {
                    c++;
                }
            }
            if (Txt_SalesPerson.Text != "")
            {
                for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
                {
                    if (CheckBoxList_SalesPerson.Items[i].Selected)
                    {
                        Txt_SalesPerson.Text += CheckBoxList_SalesPerson.Items[i].Text + ",";
                    }
                }
                List<String> value = new List<string>();
                value = Txt_SalesPerson.Text.Split(',').ToList();
                for (int i = 0; i < value.Count(); i++)
                {
                    ListItem item = CheckBoxList_SalesPerson.Items.FindByText(value[i]);
                    if (value[i] == "")
                    {
                        continue;
                    }
                    else if (item == null)
                    {
                        continue;
                    }
                    else if (CheckBoxList_SalesPerson.Items.FindByText(value[i]).Selected == false)
                    {
                        value.RemoveAt(i);
                    }
                }

                cmf.BindDataValueInListTripleParameter("", null, CheckBoxList_SalesPerson, null, "ssp_GetEmployeeList", "@DepartmentName", "SALES", "", "", "", "", "fullName", "userID", Txt_SalesPerson);
                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_SalesPerson.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_SalesPerson.Items[j].Text)
                        {
                            CheckBoxList_SalesPerson.Items[j].Selected = true;
                        }
                    }
                }
                Txt_SalesPerson.Text = "";
                for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
                {
                    if (CheckBoxList_SalesPerson.Items[i].Selected)
                    {
                        Txt_SalesPerson.Text += CheckBoxList_SalesPerson.Items[i].Value + ",";
                    }
                }

            }
            else
            {
                for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
                {
                    if (CheckBoxList_SalesPerson.Items[i].Selected)
                    {
                        Txt_SalesPerson.Text += CheckBoxList_SalesPerson.Items[i].Text + ",";
                    }
                }

                cmf.BindDataValueInListTripleParameter("", null, CheckBoxList_SalesPerson, null, "ssp_GetEmployeeList", "@DepartmentName", "SALES", "", "", "", "", "fullName", "userID", Txt_SalesPerson);
                List<String> value = new List<string>();
                value = Txt_SalesPerson.Text.Split(',').ToList();
                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_SalesPerson.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_SalesPerson.Items[j].Text)
                        {
                            CheckBoxList_SalesPerson.Items[j].Selected = true;
                        }
                    }
                }
            }

            Txt_SalesPerson.ToolTip = Txt_SalesPerson.Text;

            HiddenField_LinkButton_Search_SalesPerson.Value = "";
        }

    }
    //Search Sales Person Name in multiple checkboxes dropdown
    protected void Txt_Search_SalesPerson_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_Search_SalesPerson.Value == "1")
        {
            string[] value = Txt_SalesPerson.Text.Split(',');
            if (Txt_Search_SalesPerson.Text != "")
            {
                string search = Txt_Search_SalesPerson.Text;
                if (con.con.State == ConnectionState.Closed)
                {
                    con.open();
                }
                string searchTxt = "SELECT tblEmpLogin.userID, (FirstName +' '+ MiddleName +' '+ LastName) as fullName FROM tblEmpLogin LEFT JOIN tblDepartment ON tblEmpLogin.department = tblDepartment.departmentID WHERE departmentName='SALES' AND status='ACTIVE' AND FirstName LIKE '%" + search + "%' order by FirstName ASC";
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con.con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                CheckBoxList_SalesPerson.DataSource = dt;
                CheckBoxList_SalesPerson.DataTextField = "fullName";
                CheckBoxList_SalesPerson.DataValueField = "userID";
                CheckBoxList_SalesPerson.DataBind();
                con.con.Close();
                //Txt_State_Search.Focus();

                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_SalesPerson.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_SalesPerson.Items[j].Text)
                        {
                            CheckBoxList_SalesPerson.Items[j].Selected = true;
                        }
                    }
                }
            }
            else if (Txt_Search_SalesPerson.Text == "")
            {
                cmf.BindDataValueInListTripleParameter("", null, CheckBoxList_SalesPerson, null, "ssp_GetEmployeeList", "@DepartmentName", "SALES", "", "", "", "", "fullName", "userID", Txt_SalesPerson);

                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_SalesPerson.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_SalesPerson.Items[j].Text)
                        {
                            CheckBoxList_SalesPerson.Items[j].Selected = true;
                        }
                    }
                }
            }

            HiddenField_Txt_Search_SalesPerson.Value = "";
        }
    }



    //****************************************Function For Data Table Generation**********************************************************
    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("CustomerId", typeof(int)));
        dt.Columns.Add(new System.Data.DataColumn("Designation", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Name", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("ContactNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("EmailID", typeof(String)));

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
            dr[0] = CFunctions.ID;
            dr[1] = Ddl_PersonDesignation.SelectedItem.Text.ToString();
            dr[2] = Txt_OtherPersonName.Text.ToString().ToUpper();
            dr[3] = Txt_OtherContactNo.Text.ToString();
            dr[4] = Txt_OtherPersonEmailId.Text.ToString();
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = CFunctions.ID;
            dr[1] = Ddl_PersonDesignation.SelectedItem.Text.ToString();
            dr[2] = Txt_OtherPersonName.Text.ToString().ToUpper();
            dr[3] = Txt_OtherContactNo.Text.ToString();
            dr[4] = Txt_OtherPersonEmailId.Text.ToString();
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["CurrentData"] != null)
        {
            DataTableGridView.DataSource = (DataTable)ViewState["CurrentData"];
            DataTableGridView.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            DataTableGridView.DataSource = dt;
            DataTableGridView.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["CurrentData"] = dt;
        //con.con.Close();

    }

    protected void Btn_OtherPersonAdd_Click(object sender, EventArgs e)
    {

        //if (CFunctions.tabstatus == 0)
        //{
        // Check if the ViewState has a data assoiciated within it. If
        if (ViewState["CurrentData"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentData"];
            int count = dt.Rows.Count;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (((dt.Rows[i]["Name"]).ToString() == Txt_OtherPersonName.Text.ToString()) && ((dt.Rows[i]["ContactNo"]).ToString() == Txt_OtherContactNo.Text.ToString()))
                {
                    s = 1;
                    //  Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('This is Already Selected');return false;}</script>");

                    string a = "Btn_Add";
                    string b = "ADD1";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);


                    break;
                }

            }
            if (s == 0)
            {
                BindGrid(count);
            }
            else
                s = 0;

        }
        else
        {
            BindGrid(1);
        }
        Ddl_PersonDesignation.SelectedIndex = 0;
        Txt_OtherPersonName.Text = "";
        Txt_OtherContactNo.Text = "";
        Txt_OtherPersonEmailId.Text = "";
        Ddl_PersonDesignation.Focus();

    }

    protected void Delete_Data1_Click(object sender, EventArgs e)
    {
        String delete = (sender as LinkButton).CommandArgument;
        DataTable dt = (DataTable)ViewState["CurrentData"];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if ((dt.Rows[i]["Name"]).ToString() == delete)
            {
                dt.Rows[i].Delete();
            }
        }

        DataTableGridView.DataSource = dt;
        DataTableGridView.DataBind();
        Ddl_PersonDesignation.SelectedIndex = 0;
        Txt_OtherPersonName.Text = "";
        Txt_OtherContactNo.Text = "";
        Txt_OtherPersonEmailId.Text = "";
        string a = "Delete_Data1";
        string b = "DELETE";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

    }

    //Button Save And Update
    protected void Button_Tab2Save_Click(object sender, EventArgs e)
    {

        if (CFunctions.tabstatus == 0)
        {
            if (con.con.State == ConnectionState.Closed)
            {
                con.open();
            }
            // Sales Person Details Insert
            if (Txt_SalesPerson.Text != "")
            {
                for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
                {
                    if (CheckBoxList_SalesPerson.Items[i].Selected)
                    {
                        int empID = Convert.ToInt32(CheckBoxList_SalesPerson.Items[i].Value.ToString());
                        SqlCommand cmd1 = new SqlCommand("ssp_CreateOrUpdateCustomerSalesPerson", con.con);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.AddWithValue("@Event", "Insert");
                        cmd1.Parameters.AddWithValue("@customerID", hfGetCustID.Value);
                        cmd1.Parameters.AddWithValue("@userID", empID);
                        cmd1.ExecuteNonQuery();
                    }
                }



                // Other Person Details Insert              

                DataTable dt = (DataTable)ViewState["CurrentData"];
                if (ViewState["CurrentData"] != null)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdatePartyCustomerOtherPerson", con.con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Customercheck", CFunctions.tabstatus);
                        cmd.Parameters.AddWithValue("@OtherPersonID", "");
                        cmd.Parameters.AddWithValue("@customerID", hfGetCustID.Value);
                        cmd.Parameters.AddWithValue("@Name", dt.Rows[i]["Name"].ToString());
                        cmd.Parameters.AddWithValue("@ContactNo", dt.Rows[i]["ContactNo"].ToString());
                        cmd.Parameters.AddWithValue("@EmailId", dt.Rows[i]["EmailID"].ToString());
                        cmd.Parameters.AddWithValue("@Designation", dt.Rows[i]["Designation"].ToString());
                        cmd.ExecuteNonQuery();
                    }
                }

                con.con.Close();

                DisableLogisticsData();
                cmf.ButtonopacityHideShow(0, "SAVE", Button_Tab2Save);
                cmf.ButtonopacityHideShow(0, "RESET", Btn_OtherReset);
                cmf.ButtonopacityHideShow(1, "NEXT", Btn_OtherNext);
                cmf.showalert("Button_Tab2Save", "SAVE", this);
            }

        }
        else if (CFunctions.tabstatus == 1)
        {
            CFunctions.setTabStatus(1);

            con.con.Open();
            SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateCustomerSalesPerson", con.con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Event", "Delete");
            cmd.Parameters.AddWithValue("@customerID", CFunctions.ID);
            cmd.Parameters.AddWithValue("@userID", "");
            cmd.ExecuteNonQuery();
            con.con.Close();


            for (int i = 0; i < CheckBoxList_SalesPerson.Items.Count; i++)
            {
                if (CheckBoxList_SalesPerson.Items[i].Selected)
                {
                    int empID = Convert.ToInt32(CheckBoxList_SalesPerson.Items[i].Value.ToString());
                    con.con.Open();
                    SqlCommand cmd1 = new SqlCommand("ssp_CreateOrUpdateCustomerSalesPerson", con.con);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@Event", "Insert");
                    cmd1.Parameters.AddWithValue("@customerID", CFunctions.ID);
                    cmd1.Parameters.AddWithValue("@userID", empID);
                    cmd1.ExecuteNonQuery();
                    con.con.Close();
                }
            }


            DisableLogisticsData();
            cmf.ButtonopacityHideShow(0, "UPDATE", Button_Tab2Save);
            cmf.showalert("Button_Tab2Save", "UPDATE", this);
        }
        CFunctions.setTabStatus(0);

    }
    //Reset Data
    protected void Btn_OtherReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_OtherReset.Value == "1")
        {
            ClearLogisticsData();

            HiddenField_OtherReset.Value = "";
        }

    }
    /*----------------------------------------------------------------------Tab3 END Code--------------------------------------------------------------------*/
    #endregion  

    #region        /*----------------------------------------------------------------------Tab3 Start Code / Upload Document--------------------------------------------------------------------*/
    #region   /*=================================File Upload Section Start================================*/

    /* Ajax File Upload Start*/
    /*  Customer Documents */
    protected void Cust_PanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Cust_PanCard_Uploader.SaveAs(fileNameToUpload);
        fileName1 = e.FileName.ToString();
    }

    protected void Cust_AadhaarCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Cust_AadhaarCard_Uploader.SaveAs(fileNameToUpload);
        fileName2 = e.FileName.ToString();
    }

    protected void Cust_GST_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Cust_GST_Uploader.SaveAs(fileNameToUpload);
        fileName3 = e.FileName.ToString();
    }

    protected void Cust_CIN_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Cust_CIN_Uploader.SaveAs(fileNameToUpload);
        fileName4 = e.FileName.ToString();
    }

    /*  Logistic Person     */
    protected void Logistic_PanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Logistic_PanCard_Uploader.SaveAs(fileNameToUpload);
        fileName5 = e.FileName.ToString();
    }

    protected void Logistic_AadhaarCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {
        string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
        Logistic_AadhaarCard_Uploader.SaveAs(fileNameToUpload);
        fileName6 = e.FileName.ToString();
    }



    /* Ajax File Upload End*/

    /*=============================File Upload Section End==================================================*/
    #endregion
    //check final submit
    protected void Button_Submit1_Click(object sender, EventArgs e)
    {

        string FileUploadCheck;
        string CPancardFileNameCheck;
        string CAadharCardFileNameCheck;
        string CGSTCertificateFileNameCheck;
        string CCINFileNameCheck;
        string OPancardFileNameCheck;
        string OAadharCardFileNameCheck;
        #region
        if (fileName1 == null)
        {
            FileUploadCheck = "";
            CPancardFileNameCheck = "";
        }
        else
        {
            FileUploadCheck = fileName1;
            CPancardFileNameCheck = fileName1;
        }

        if (fileName2 == null)
        {
            CAadharCardFileNameCheck = "";
        }
        else
        {
            CAadharCardFileNameCheck = fileName2;
        }
        if (fileName3 == null)
        {
            CGSTCertificateFileNameCheck = "";
        }
        else
        {
            CGSTCertificateFileNameCheck = fileName3;
        }
        if (fileName4 == null)
        {
            CCINFileNameCheck = "";
        }
        else
        {
            CCINFileNameCheck = fileName4;
        }
        if (fileName5 == null)
        {
            OPancardFileNameCheck = "";
        }
        else
        {
            OPancardFileNameCheck = fileName5;
        }
        if (fileName6 == null)
        {
            OAadharCardFileNameCheck = "";
        }
        else
        {
            OAadharCardFileNameCheck = fileName6;
        }
        #endregion
        if (con.con.State == ConnectionState.Closed)
        {
            con.open();
        }
        //  CFunctions.setTabStatus(1);
        SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdatePartyCustomerUpload", con.con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@customerID", hfGetCustID.Value);
        cmd.Parameters.AddWithValue("@Designation", Ddl_UploadDesignation.SelectedItem.ToString().ToUpper());
        cmd.Parameters.AddWithValue("@CustPanCardNo", Txt_PanCardNo.Text.ToString().ToUpper());
        cmd.Parameters.AddWithValue("@CustAadharCardNo", Txt_AdharcardNo.Text.ToString());
        cmd.Parameters.AddWithValue("@CustGSTCertificateNo", Txt_CustomerGSTCertificates.Text.ToString().ToUpper());
        cmd.Parameters.AddWithValue("@CustCIN", Txt_CustomerCIN.Text.ToString());
        cmd.Parameters.AddWithValue("@CustPancardFileName", CPancardFileNameCheck);
        cmd.Parameters.AddWithValue("@CustAadharCardFileName", CAadharCardFileNameCheck);
        cmd.Parameters.AddWithValue("@CustGSTCertificateFileName", CGSTCertificateFileNameCheck);
        cmd.Parameters.AddWithValue("@CustCINFileName", CCINFileNameCheck);
        cmd.Parameters.AddWithValue("@OtherPanCardNo", Txt_OtherPanCardNo.Text.ToString().ToUpper());
        cmd.Parameters.AddWithValue("@OtherAadharCardNo", Txt_OtherAdharcardNo.Text.ToString());
        cmd.Parameters.AddWithValue("@OtherPancardFileName", OPancardFileNameCheck);
        cmd.Parameters.AddWithValue("@OtherAadharCardFileName", OAadharCardFileNameCheck);
        cmd.ExecuteNonQuery();

        if (CFunctions.tabstatus == 0)
        {
            billingparty.Visible = false;
            cmf.showalert("Button_Submit1", "SAVE", this);
        }
        else if (CFunctions.tabstatus == 1)
        {
            Ddl_TypeofParty.Attributes.Remove("disabled");
            Ddl_Categoryofcustomer.Attributes.Remove("disabled");
            Txt_CustomerName.Enabled = true;
            cmf.showalert("Button_Submit1", "UPDATE", this);
        }
        //ClearCustomerData();
        //ClearLogisticsData();
        //ClearDocumentData();
        //ActiveAllTextFields();
        //cmf.ButtonopacityHideShow(0, "NEXT", Btn_CustomerNext);
        //cmf.ButtonopacityHideShow(1, "SAVE", Button_Tab1Save);

        //cmf.ButtonopacityHideShow(1, "SAVE", Button_Tab2Save);
        //cmf.ButtonopacityHideShow(1, "RESET", Btn_CustomerReset);
        //cmf.ButtonopacityHideShow(1, "RESET", Btn_OtherReset);
        //CFunctions.setTabStatus(0);

        Response.Redirect(Request.Url.AbsoluteUri);
        //  Ddl_ModeOfPayment.Enabled = false;
    }
    protected void Btn_DocumenReset_Click(object sender, EventArgs e)
    {
        if (HiddenField_DocumenReset.Value == "1")
        {
            ClearDocumentData();

            HiddenField_DocumenReset.Value = "";
        }
    }
    /*----------------------------------------------------------------------Tab6 END Code--------------------------------------------------------------------*/
    #endregion

    #region   /*------------------------------------------------------------Tab4 Start Code / Search / View / Export to Excel-----------------------------------------------------------*/

    #region    //Search Data
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        ViewData.Visible = true;
        SearchableView();
    }
    //Searchable View
    private void SearchableView()
    {
        String CustomerName = Txt_SearchCustName.Text.ToString() == "" ? null : Txt_SearchCustName.Text.ToString();
        String CustomerStatus = Ddl_SearchableStatus.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchableStatus.SelectedItem.ToString();
        String CustomerSalesPerson = Ddl_SearchSalesPersonName.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchSalesPersonName.SelectedValue.ToString();
        //if ((CustomerName != null) || (CustomerStatus != null) || (CustomerSalesPerson != null))
        {
            if (con.con.State == ConnectionState.Closed)
            {
                con.open();
            }
            con.cmd = new SqlCommand("ssp_ViewPartyCustomer", con.con);
            con.cmd.CommandType = CommandType.StoredProcedure;
            con.cmd.Parameters.AddWithValue("@status", CustomerStatus);
            con.cmd.Parameters.AddWithValue("@customerName", CustomerName);
            con.cmd.Parameters.AddWithValue("@salesPersonID", CustomerSalesPerson);
            con.DA = new SqlDataAdapter(con.cmd);
            con.Dt = new DataTable();
            con.DA.Fill(con.Dt);
            GV_CustomerView.DataSource = con.Dt;
            GV_CustomerView.DataBind();
            con.close();
        }
    }
    #endregion
    #region   //Edit Final Record
    protected void Edit_CustomerData_Click(object sender, EventArgs e)
    {
        CFunctions.setTabStatus(1);
        PkFieldId = Convert.ToString((sender as LinkButton).CommandArgument);
        ClearCustomerData();
        ClearLogisticsData();
        ClearDocumentData();
        ActiveAllTextFields();
        LoadFinalDataIntoText();
        //cmf.ButtonopacityHideShow(1, "NEXT", Btn_CustomerNext);
        //cmf.ButtonopacityHideShow(1, "UPDATE", Button_Tab1Save);
        //cmf.ButtonopacityHideShow(1, "UPDATE", Button_Tab2Save);
        //cmf.ButtonopacityHideShow(0, "RESET", Btn_CustomerReset);
        //cmf.ButtonopacityHideShow(0, "RESET", Btn_OtherReset);
        //cmf.ButtonopacityHideShow(0, "RESET", Btn_DocumenReset);
        Ddl_TypeofParty.Attributes.Add("disabled", "disabled");
        Ddl_Categoryofcustomer.Attributes.Add("disabled", "disabled");
        Ddl_ModeOfPayment.Attributes.Add("disabled", "disabled");
        Txt_CustomerName.Enabled = false;
    }
    private void Btn_GV_Demo_Load(object sender, EventArgs e)
    {
        throw new NotImplementedException();
    }
    #endregion

    #region  /* Grid View / Export To Excel Start */
    //Shorting Data in gridview 
    protected void GV_CustomerView_Sorting(object sender, GridViewSortEventArgs e)
    {
        //FillGrid(e.SortExpression);
    }
    //show data with Paging
    protected void GV_CustomerView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_CustomerView.PageIndex = e.NewPageIndex;
        SearchableView();
        /*if (Txt_SearchCustName.Text.ToString() == "" && Ddl_SearchableStatus.SelectedItem.Text == "SELECT" && Ddl_SearchSalesPersonName.SelectedItem.ToString() == "SELECT")
        {
            FillGrid();
        }
        else
        {
            SearchableView();
        }*/
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btn_ExporttoExcel_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = cmf.CurrentDateTime();
        GV_Export.Visible = true;                       /*Export GV*/
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Customer_Creation" + CurrentDateTime + ".xls";
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
    /*----------------------------------------------------------------------Tab7 End Code--------------------------------------------------------------------*/
    #endregion
    //Load Data
    public void LoadFinalDataIntoText()
    {
        /*if (con1.State == ConnectionState.Closed)
        {
        }*/
        if (con.con.State == ConnectionState.Closed)
        {
            con.open();
        }
        //con.cmd = new SqlCommand("spViewPartyCustomerMaster");
        //con.cmd = new SqlCommand("ssp_GetPartyCustomerDetails");
        //con.cmd.CommandType = CommandType.StoredProcedure;
        SqlCommand cmd = new SqlCommand("ssp_GetPartyCustomerDetails", con.con);
        cmd.CommandType = CommandType.StoredProcedure;
        //con.cmd.Parameters.AddWithValue("@Event", "Load_FinalData");
        //con.cmd.Parameters.AddWithValue("@CustomerCode", PkFieldId);
        //con.cmd.Parameters.AddWithValue("@CustomerID", PkFieldId);
        cmd.Parameters.AddWithValue("@CustomerID", PkFieldId);
        SqlDataAdapter DA = new SqlDataAdapter(cmd);
        DataTable DT = new DataTable();
        DA.Fill(DT);
        //con.DA = new SqlDataAdapter(con.cmd);
        //con.Dt = new DataTable();
        //con.DA.Fill(con.Dt);
        //GV_CustomerView.DataSource = con.Dt;
        //GV_CustomerView.DataSource = DT;
        //if (con.Dt.Rows.Count > 0)
        if (DT.Rows.Count > 0)
        {
            Lbl_CustomerId.Text = DT.Rows[0]["CustomerId"].ToString();
            Ddl_TypeofParty.Text = DT.Rows[0]["customerType"].ToString();
            Ddl_Categoryofcustomer.Text = DT.Rows[0]["customerCategory"].ToString();
            Txt_CustomerName.Text = DT.Rows[0]["customerName"].ToString();
            Txt_CustCode.Text = DT.Rows[0]["customerNo"].ToString();
            Txt_ContactNo.Text = DT.Rows[0]["customerContactNo"].ToString();
            Txt_CustEmailId.Text = DT.Rows[0]["EmailId"].ToString();
            //Txt_Pincode.Text = DT.Rows[0]["customerPickupPincode"].ToString();
            //Txt_State.Text = DT.Rows[0]["state"].ToString();
            //Txt_District.Text = DT.Rows[0]["district"].ToString();
            //Txt_City.Text = DT.Rows[0]["city"].ToString();
            /*if (Ddl_Categoryofcustomer.Text == "BILLING PARTY")
            {
                billingparty.Visible = false;
            }*/
            //else
            {
                //Ddl_BillingParty.SelectedItem.Text = DT.Rows[0]["customerName"].ToString();
                //Ddl_BillingParty.SelectedValue = DT.Rows[0]["custBillingID"].ToString();
            }
            //Txt_BillingAddress.Text = DT.Rows[0]["billingAddress"].ToString();
            Ddl_ModeOfPayment.Text = DT.Rows[0]["modeOfPayment"].ToString();
            statusClass1.setcode(DT.Rows[0]["modeOfPayment"].ToString());
            //Ddl_BranchName.Text = DT.Rows[0]["branchName"].ToString();
            Ddl_CustCategory.Text = DT.Rows[0]["category"].ToString();
            Txt_CreditLimit.Text = DT.Rows[0]["customerCreditLimit"].ToString();
            string autoutility = DT.Rows[0]["autoUtility"].ToString();
            string[] values = autoutility.Split(',');
            for (int i = 0; i < values.Length; i++)
            {
                if (values[i].ToString() == "MAILING")
                {
                    CheckBox_AutoUtility1.Checked = true;
                }
                else if (values[i].ToString() == "SMS")
                {
                    CheckBox_AutoUtility2.Checked = true;
                }
                else if (values[i].ToString() == "PDF_MAILING")
                {
                    CheckBox_AutoUtility3.Checked = true;
                }
            }

            //Txt_OtherPersonName.Text = DT.Rows[0]["logisticPersonName"].ToString();
            //Txt_OtherContactNo.Text = DT.Rows[0]["logisticPersonContactNo"].ToString();
            //Txt_OtherPersonEmailId.Text = DT.Rows[0]["logisticPersonEmailID"].ToString();

            Txt_PanCardNo.Text = DT.Rows[0]["panCardNo"].ToString();
            Cust_PanCard_Label.InnerHtml = DT.Rows[0]["customerPancardFileName"].ToString();
            //Cust_PanCard_Label.Attributes.Add("href", "~/FileUpload/" + DT.Rows[0]["customerPancardFileName"].ToString());

            Txt_AdharcardNo.Text = DT.Rows[0]["aadharCardNo"].ToString();
            Cust_AadhaarCard_Label.InnerHtml = DT.Rows[0]["customerAadharCardFileName"].ToString();
            //Cust_AadhaarCard_Label.Attributes.Add("href", "~/FileUpload/" + DT.Rows[0]["customerAadharCardFileName"].ToString());

            Txt_CustomerGSTCertificates.Text = DT.Rows[0]["GSTCertificateNo"].ToString();
            Cust_GST_Label.InnerHtml = DT.Rows[0]["GSTCertificateFileName"].ToString();
            //Cust_GST_Label.Attributes.Add("href", "~/FileUpload/" + DT.Rows[0]["GSTCertificateFileName"].ToString());

            Txt_CustomerCIN.Text = DT.Rows[0]["CIN"].ToString();
            Cust_CIN_Label.InnerHtml = DT.Rows[0]["CINFileName"].ToString();

            SqlCommand sqlcmdBranches = new SqlCommand("ssp_CustomerBelongToBranch", con.con);
            sqlcmdBranches.Parameters.AddWithValue("@CustomerID", PkFieldId);

            sqlcmdBranches.CommandType = CommandType.StoredProcedure;
            SqlDataReader rd = sqlcmdBranches.ExecuteReader();
            Gv_BelongToBranch.DataSource = rd;
            Gv_BelongToBranch.DataBind();

            //Cust_CIN_Label.Attributes.Add("href", "~/FileUpload/" + DT.Rows[0]["CINFileName"].ToString());

            //Txt_OtherPanCardNo.Text = DT.Rows[0]["logisticPersonPancardNo"].ToString();
            //Logistic_PanCard_Label.InnerHtml = DT.Rows[0]["logisticPersonPancardFileName"].ToString();
            //Logistic_PanCard_Label.Attributes.Add("href", "~/FileUpload/" + DT.Rows[0]["logisticPersonPancardFileName"].ToString());

            //Txt_OtherAdharcardNo.Text = DT.Rows[0]["logisticPersonAadharcardNo"].ToString();
            //Logistic_AadhaarCard_Label.InnerHtml = DT.Rows[0]["logisticPersonAadharcardFileName"].ToString();
            //Logistic_AadhaarCard_Label.Attributes.Add("href", "~/FileUpload/" + DT.Rows[0]["logisticPersonAadharcardFileName"].ToString());
        }
    }

    protected void Btn_AddCustomerBranch_Click(object sender, EventArgs e)
    {
        /*CustId = Convert.ToInt32(reader["id"]);*/
        //CFunctions.setID(Convert.ToInt32(reader["id"]));

        //foreach (CustomerDetails detail in CustDetail)
        {
            #region DetailParameters
            List<NameSpaceConnection.Parameters> paramList = new List<NameSpaceConnection.Parameters>();
            paramList.Add(new NameSpaceConnection.Parameters("@customerID", Lbl_CustomerId.Text));
            paramList.Add(new NameSpaceConnection.Parameters("@branchID", hfbranchID.Value));
            paramList.Add(new NameSpaceConnection.Parameters("@LocID", hfPincode.Value));
            paramList.Add(new NameSpaceConnection.Parameters("@areaID", hfArea.Value));
            paramList.Add(new NameSpaceConnection.Parameters("@billingAddress", Txt_BillingAddress.Text));
            paramList.Add(new NameSpaceConnection.Parameters("@GSTNumber", txtGSTNo.Text));

            #endregion
            (new NameSpaceConnection.Connection()).ExecuteSp("ssp_CreateCustomerBelongToBranch", paramList);
            PkFieldId = Lbl_CustomerId.Text;
            LoadFinalDataIntoText(); 
        }
    }
}