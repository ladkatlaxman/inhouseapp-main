using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using System.Data;
using System.Web.Services;

public partial class TranshipLHS : System.Web.UI.Page
{
    string VehicleNo; int count;
    public static int DriverId, PickUpPersonId, VehicleId,s;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BranchId"].ToString() == "49" || Session["BranchId"].ToString() == "37") Response.Redirect("VehicleRequest.aspx?q=RT");

        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                (new CFunctions()).dropdwnlist(null, null, Ddl_VehicleRoute, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteName(Session["userBranch"].ToString())));
                (new CFunctions()).dropdwnlist(null, null, Ddl_DriverName, null, "Name", "Id", ((new VehicleRequestFunction()).getDriverName()));

                AddDefaultFirstRecord();
                FillGrid();
            }
            else
                Response.Redirect("Login.aspx");
        }
        if (Txt_HiringDate.Text == "")
        {
            string str = "$(\"[id$= Txt_HiringDate]\").datepicker({ dateFormat: 'dd/mm/yy' ,minDate: 0}).datepicker(\"setDate\", new Date());";
            CFunctions.setjavascript(CFunctions.javascript + str);
            (new CFunctions()).GetJavascriptFunction(this, "Txt_AccountCode", "hfAccountName", "~/PickDelLHS.aspx/getRateType", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
        else
        {
            string str = "$(\"[id$= Txt_HiringDate]\").datepicker({ dateFormat: 'dd/mm/yy' ,minDate: 0}).datepicker(\"setDate\", $(\"[id$= Txt_HiringDate]\").val());";
            CFunctions.setjavascript(CFunctions.javascript + str);
            (new CFunctions()).GetJavascriptFunction(this, "Txt_AccountCode", "hfAccountName", "~/PickDelLHS.aspx/getRateType", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
      
       
    }
    #region     /*----------------------------------------------------All Functions------------------------------------------------------------*/
   
    /*----------------Auto Generate mPin--------------------*/
    public int GenerateRandomNo()
    {
        int _min = 1000;
        int _max = 9999;
        Random _rdm = new Random();
        return _rdm.Next(_min, _max);
    }

    /*----------------Auto Complete Code false--------------------*/
    public void AutoClear()
    {
        Txt_NewVehicleNoAlpha1.Attributes.Add("autocomplete", "off");
        Txt_NewVehicleNoDigit1.Attributes.Add("autocomplete", "off");
        Txt_NewVehicleNoAlpha2.Attributes.Add("autocomplete", "off");
        Txt_NewVehicleNoDigit2.Attributes.Add("autocomplete", "off");
        Txt_NoOfLabour.Attributes.Add("autocomplete", "off");
    }
    /*----------------Clear All Data Code--------------------*/
    public void ClearTextField()
    {
        if (ViewState["AccountData"] != null)
        {
            DataTable dt1 = (DataTable)ViewState["AccountData"];
            dt1.Clear();
            ViewState["AccountData"] = null;
            Txt_AccountCode.Text = "";
            Txt_Charges.Text = "";
            Txt_Remark.Text = "";
            AccountDetails.Visible = false;
        }
        Txt_NewVehicleNoAlpha1.Enabled = true;
        Txt_NewVehicleNoDigit1.Enabled = true;
        Txt_NewVehicleNoAlpha2.Enabled = true;
        Txt_NewVehicleNoDigit2.Enabled = true;
        Txt_NoOfLabour.Enabled = true;
        Ddl_StaffType.Enabled = true;
        Txt_NewVehicleNoAlpha1.Text = "";
        Txt_NewVehicleNoDigit1.Text = "";
        Txt_NewVehicleNoAlpha2.Text = "";
        Txt_NewVehicleNoDigit2.Text = "";
        Txt_VendorName.Text = "AUTO";
        Txt_VehicleCategory.Text = "AUTO";
        Txt_VehicleType.Text = "AUTO";
        Txt_NoOfLabour.Text = "";     
        Ddl_VehicleRoute.Items.Clear();
        Ddl_VehicleRoute.Items.Insert(0, "SELECT");
        Ddl_RouteSchedule.Items.Clear();
        Ddl_RouteSchedule.Items.Insert(0, "SELECT");
        Ddl_StaffType.SelectedIndex = 0;
        Txt_ReasonForVehicle.Text = "";
        ClearStaffDetail();
        DataTable dt = (DataTable)ViewState["Detail"];
        dt.Clear();
        ViewState["Detail"] = null;
        AddDefaultFirstRecord();
        staffDetail.Visible = true;
        //Pickup_NoDataFound.Visible = false;
        AlreadyAdd.Visible = false;
        //PickUpTab.Visible = false;
        //PickUpErrorMassage.Visible = false;
        // PickUpSubmit.Visible = false;
        DeliveryTab.Visible = false;
        DeliveryErrorMassage.Visible = false;
    }
    /*----------------Clear All Data Code--------------------*/
    public void ClearStaffDetail()
    {
        Ddl_StaffType.SelectedIndex = 1;
        if (Ddl_DriverName.Visible == true)
            Ddl_DriverName.SelectedIndex = 0;
        //(new CFunctions()).SelectDropdownList(Txt_Search_DriverName, Txt_DriverName, RadioButtonList_DriverName);
        Txt_ContactNo.Text = "AUTO";
        if (ddl_PickPersonName.Visible == true)
            ddl_PickPersonName.SelectedIndex = 0;
        //(new CFunctions()).SelectDropdownList(Txt_Search_PickPersonName, Txt_PickPersonName, RadioButtonList_PickPersonName);
        ddl_PickPersonName.Visible = false;
        Ddl_DriverName.Visible = true;
    }
    /*----------------Dynamic Generate Gridview---------------*/
    private void AddDefaultFirstRecord()
    {
        //creating dataTable   
        DataTable dt = new DataTable();
        DataRow dr;
        dt.TableName = "Detail";
        dt.Columns.Add(new DataColumn("StaffType", typeof(String)));
        dt.Columns.Add(new DataColumn("DriverID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("PickUpPersonID", typeof(Int32)));
        dt.Columns.Add(new DataColumn("StaffName", typeof(String)));
        dt.Columns.Add(new DataColumn("StaffContactNo", typeof(Int64)));
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        //saving databale into viewstate   
        ViewState["Detail"] = dt;
        //bind Gridview  
        GV_StaffDetail.DataSource = dt;
        GV_StaffDetail.DataBind();
        StaffDetails.Visible = false;
    }
    private void AddNewRecordRowToGrid()
    {
        StaffDetail staff = new StaffDetail();
        staff.Type = Ddl_StaffType.SelectedItem.Text.ToString();
        if (staff.Type == "DRIVER")
        {
            staff.Id = DriverId;
            staff.Name = Ddl_DriverName.SelectedItem.Text.ToString();
        }
        else if (staff.Type == "PICKUP PERSON")
        {
            staff.Id = PickUpPersonId;
            staff.Name = ddl_PickPersonName.SelectedItem.Text.ToString();
        }
        staff.ContactNo = Convert.ToInt64(Txt_ContactNo.Text);
        AddDataInViewState(staff);
    }
    private void AddDataInViewState(StaffDetail staff)
    {
        // check view state is not null  
        if (ViewState["Detail"] != null)
        {
            //get datatable from view state   
            DataTable dtCurrentTable = (DataTable)ViewState["Detail"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {
                    //add each row into data table  
                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["StaffType"] = staff.Type;
                    if (staff.Type == "DRIVER")
                    {
                        drCurrentRow["DriverID"] = staff.Id;
                        drCurrentRow["StaffName"] = staff.Name;
                        drCurrentRow["StaffContactNo"] = staff.ContactNo;
                    }
                    else if (staff.Type == "PICKUP PERSON")
                    {
                        drCurrentRow["PickUpPersonID"] = staff.Id;
                        drCurrentRow["StaffName"] = staff.Name;
                        drCurrentRow["StaffContactNo"] = staff.ContactNo;
                    }
                }
                //Remove initial blank row  
                if (dtCurrentTable.Rows[0][0].ToString() == "")
                {
                    dtCurrentTable.Rows[0].Delete();
                    dtCurrentTable.AcceptChanges();
                }
                //add created Rows into dataTable  
                dtCurrentTable.Rows.Add(drCurrentRow);
                //Save Data table into view state after creating each row  
                ViewState["Detail"] = dtCurrentTable;
                //Bind Gridview with latest Row  
                GV_StaffDetail.DataSource = dtCurrentTable;
                GV_StaffDetail.DataBind();
                StaffDetails.Visible = true;
            }
        }
    }
    /*----------------PickUp Detail View---------------*/
    private void RouteWaybillFillGrid(string BranchId)
    {
        List<PickReq> PickReq = (new VehicleRequestFunction()).ViewAllRouteBranchWiseData(BranchId);
        GV_RouteWaybillDetail.DataSource = PickReq;
        GV_RouteWaybillDetail.DataBind();
    }

    //private void PickUpAlreadyAddedLHSFillGrid(int pickDelId)
    //{
    //    DataTable dt = (new PickDelLHSFunctions()).ViewAlreadyAddedPickDelLHSData(Convert.ToInt32(Session["BranchId"]), pickDelId);
    //    GV_AlreadyAdd.DataSource = dt;
    //    GV_AlreadyAdd.DataBind();
    //}

    /*----------------Fill Data in Gridview with sorting--------------------*/
    private void FillGrid()
    {
        List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewData(Convert.ToInt32(Session["BranchId"]), "RT");
        GV_TranshipView.DataSource = ViewList;
        GV_TranshipView.DataBind();
    }

    /*----------------Load Data in TextFields with View--------------------*/
    protected void LoadDataInTextField(int VehicleRequestID)
    {
        VehicleRequestProperties VehicleRequestDetail = (new VehicleRequestFunction().LoadData(VehicleRequestID));
        foreach (char v in VehicleRequestDetail.VehicleNo)
        {
            count++; if (count < 3)
            {
                if (System.Text.RegularExpressions.Regex.IsMatch(v.ToString(), "^[a-zA-Z]"))
                { Txt_NewVehicleNoAlpha1.Text += v.ToString(); }
                else
                { Txt_NewVehicleNoDigit1.Text += v.ToString(); }
            }
            else if (count < 5)
            {
                if (System.Text.RegularExpressions.Regex.IsMatch(v.ToString(), "^[0-9]"))
                { Txt_NewVehicleNoDigit1.Text += v.ToString(); }
                else
                { Txt_NewVehicleNoAlpha2.Text += v.ToString(); }
            }
            else if (count <= 10)
            {
                if (System.Text.RegularExpressions.Regex.IsMatch(v.ToString(), "^[a-zA-Z]"))
                { Txt_NewVehicleNoAlpha2.Text += v.ToString(); }
                else
                { Txt_NewVehicleNoDigit2.Text += v.ToString(); }
            }
        }
        Txt_VendorName.Text = VehicleRequestDetail.VendorName;
        Txt_VehicleCategory.Text = VehicleRequestDetail.VehicleCategory;
        Txt_VehicleType.Text = VehicleRequestDetail.VehicleType;
        Txt_NoOfLabour.Text = VehicleRequestDetail.NoOfLabour.ToString();
       // txtSealNo.Text = VehicleRequestDetail.sealNo;
        foreach (ListItem item in Ddl_VehicleRoute.Items)
        {
            if (item.Value == VehicleRequestDetail.routeId.ToString())
            {
                item.Selected = true;
                break;
            }
        }
        new CFunctions().dropdwnlist(null, null, Ddl_RouteSchedule, null, "scheduleName", "scheduleId", (new VehicleRequestFunction().getRouteSchedule(VehicleRequestDetail.routeId)));
        foreach (ListItem item in Ddl_RouteSchedule.Items)
        {
            if (item.Value == VehicleRequestDetail.routeScheduleMasterId.ToString())
            {
                item.Selected = true;
                break;
            }
        }
        //foreach (var detail in VehicleRequestDetail.staff)
        //{
        //    StaffDetail staff = new StaffDetail();
        //    staff.Type = detail.Type;
        //    if (staff.Type == "DRIVER")
        //    {
        //        staff.Id = detail.Id;
        //        staff.Name = detail.Name;
        //        staff.ContactNo = detail.ContactNo;
        //        AddDataInViewState(staff);
        //    }
        //    else if (staff.Type == "PICKUP PERSON")
        //    {
        //        staff.Id = detail.Id;
        //        staff.Name = detail.Name;
        //        staff.ContactNo = detail.ContactNo;
        //        AddDataInViewState(staff);
        //    }
        //}
        //Txt_NewVehicleNoAlpha1.Enabled = false;
        //Txt_NewVehicleNoDigit1.Enabled = false;
        //Txt_NewVehicleNoAlpha2.Enabled = false;
        //Txt_NewVehicleNoDigit2.Enabled = false;
        //Txt_NoOfLabour.Enabled = false;
        //Ddl_StaffType.Enabled = false;
    }
    #endregion

    #region     /*----------------------------------------------------Tab 1(Pickup/Delivery Vehicle, Labour And Staff Detail)------------------------------------------------------------*/

    /*--------------------VehicleNo Validation Code----------------------*/
  
    protected void Txt_NewVehicleNoDigit2_TextChanged(object sender, EventArgs e)
    {
        int vehicleExist = 0;
        if (Txt_NewVehicleNoDigit2.Text.Length <= 4)
        {
            if (Txt_NewVehicleNoDigit2.Text != "" && Txt_NewVehicleNoDigit2.Text != "0" && Txt_NewVehicleNoDigit2.Text != "00" && Txt_NewVehicleNoDigit2.Text != "000" && Txt_NewVehicleNoDigit2.Text != "0000")
            {
                VehicleRequestProperties vehicleNumber = new VehicleRequestProperties();
                Txt_NewVehicleNoDigit2.Text = "000".Substring(0, 4 - Txt_NewVehicleNoDigit2.Text.Length) + Txt_NewVehicleNoDigit2.Text;
                vehicleNumber.VehicleNo = Txt_NewVehicleNoAlpha1.Text.ToUpper() + Txt_NewVehicleNoDigit1.Text + Txt_NewVehicleNoAlpha2.Text.ToUpper() + Txt_NewVehicleNoDigit2.Text;
                List<VehicleRequestProperties> VehicleDetail = (new VehicleRequestFunction()).getVehicleDetail(vehicleNumber.VehicleNo);
                foreach (VehicleRequestProperties Detail in VehicleDetail)
                {
                    if (Detail.VehicleID != 0)
                    {
                        vehicleExist = 1;

                        VehicleRequestProperties VehicleStatus = (new VehicleRequestFunction()).CheckVehicleNoStatus(Detail.VehicleID);
                        string currentBranch = VehicleStatus.CurrentBranch;
                        if (VehicleStatus.Status == "CREATED")
                        {
                            (new CFunctions()).showalert1("VehicleNo", "CREATED", currentBranch, this);
                            break;
                        }
                        else if (VehicleStatus.Status == "APPROVED")
                        {
                            (new CFunctions()).showalert1("VehicleNo", "APPROVED", currentBranch, this);
                            break;
                        }
                        else if (VehicleStatus.Status == "DISPATCHED")
                        {
                            (new CFunctions()).showalert1("VehicleNo", "DISPATCHED", currentBranch, this);
                            break;
                        }
                        else if (VehicleStatus.Status == "PARKED")
                        {
                            (new CFunctions()).showalert1("VehicleNo", "PARKED", currentBranch, this);
                            break;
                        }
                        else if (VehicleStatus.Status == "CANCELLED" || VehicleStatus.Status == "REJECTED" || VehicleStatus.Status == "CLOSED" || VehicleStatus.Status == null)
                        {
                            VehicleId = Detail.VehicleID;
                            Txt_VendorName.Text = Detail.VendorName.ToString();
                            Txt_VehicleCategory.Text = Detail.VehicleCategory.ToString();
                            Txt_VehicleType.Text = Detail.VehicleType.ToString();
                            Txt_NoOfLabour.Focus();
                        }
                    }
                }

                if (vehicleExist == 0)
                {
                    Txt_NewVehicleNoAlpha1.Text = "";
                    Txt_NewVehicleNoDigit1.Text = "";
                    Txt_NewVehicleNoAlpha2.Text = "";
                    Txt_NewVehicleNoDigit2.Text = "";
                    (new CFunctions()).showalert("VehicleNo", "NOT EXISTS", this);
                    Txt_NewVehicleNoAlpha1.Focus();
                }
            }
        }
        else
        {
            Txt_NewVehicleNoDigit2.Text = "";
            Txt_NewVehicleNoDigit2.Focus();
        }







        //if (Txt_NewVehicleNoDigit2.Text.Length <= 4)
        //{
        //    if (Txt_NewVehicleNoDigit2.Text != "" && Txt_NewVehicleNoDigit2.Text != "0" && Txt_NewVehicleNoDigit2.Text != "00" && Txt_NewVehicleNoDigit2.Text != "000" && Txt_NewVehicleNoDigit2.Text != "0000")
        //    {
        //        VehicleRequestProperties vehicleNumber = new VehicleRequestProperties();
        //        Txt_NewVehicleNoDigit2.Text = "000".Substring(0, 4 - Txt_NewVehicleNoDigit2.Text.Length) + Txt_NewVehicleNoDigit2.Text;
        //        vehicleNumber.VehicleNo = Txt_NewVehicleNoAlpha1.Text.ToUpper() + Txt_NewVehicleNoDigit1.Text + Txt_NewVehicleNoAlpha2.Text.ToUpper() + Txt_NewVehicleNoDigit2.Text;

        //        List<VehicleRequestProperties> VehicleDetail = (new VehicleRequestFunction()).getVehicleDetail(vehicleNumber.VehicleNo);
        //        foreach (VehicleRequestProperties Detail in VehicleDetail)
        //        {
        //            if (Detail.VehicleID != 0)
        //            {
        //                VehicleRequestProperties VehicleStatus = (new VehicleRequestFunction()).CheckVehicleNoStatus(Detail.VehicleID);

        //                if (VehicleStatus.Status == "CREATED")
        //                    (new CFunctions()).showalert("VehicleNo", "CREATED", this);
        //                else if (VehicleStatus.Status == "APPROVED")
        //                    (new CFunctions()).showalert("VehicleNo", "APPROVED", this);
        //                else if (VehicleStatus.Status == "DISPATCHED")
        //                    (new CFunctions()).showalert("VehicleNo", "DISPATCHED", this);
        //                else if (VehicleStatus.Status == "PARKED")
        //                    (new CFunctions()).showalert("VehicleNo", "PARKED", this);
        //                else if (VehicleStatus.Status == "CANCELLED" || VehicleStatus.Status == "REJECTED" || VehicleStatus.Status == "CLOSED" || VehicleStatus.Status == null)
        //                {
        //                    VehicleId = Detail.VehicleID;
        //                    Txt_VendorName.Text = Detail.VendorName.ToString();
        //                    Txt_VehicleCategory.Text = Detail.VehicleCategory.ToString();
        //                    Txt_VehicleType.Text = Detail.VehicleType.ToString();
        //                    Txt_NoOfLabour.Focus();
        //                }
        //            }
        //            else
        //            {
        //                (new CFunctions()).showalert("Txt_NewVehicleNoDigit2", "NOT EXISTS", this);
        //            }
        //        }
        //    }
        //    else
        //    {
        //        Txt_NewVehicleNoDigit2.Text = "";
        //        Txt_NewVehicleNoDigit2.Focus();
        //    }
        // }
    }

    protected void Ddl_VehicleRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        new CFunctions().dropdwnlist(null, null, Ddl_RouteSchedule, null, "scheduleName", "scheduleId", (new VehicleRequestFunction().getRouteSchedule(Convert.ToInt32(Ddl_VehicleRoute.SelectedValue))));
        //new CFunctions().dropdwnlist(null, null, Ddl_LocationOnRoute, null, "Branch", "BranchId", (new RouteMasterFunctions().BranchWithWaybillCount(Ddl_VehicleRoute.SelectedValue)));
    }

    // For Account Details
    //****************************************Function For Data Table Generation**********************************************************
    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("AccountID", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("AccountName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Charges", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Remark", typeof(String)));

        if (ViewState["AccountData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["AccountData"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = hfAccountName.Value.ToString();
            dr[1] = Txt_AccountCode.Text.ToString().ToUpper();
            dr[2] = Txt_Charges.Text.ToString();
            dr[3] = Txt_Remark.Text.ToString().ToUpper();
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = hfAccountName.Value.ToString();
            dr[1] = Txt_AccountCode.Text.ToString().ToUpper();
            dr[2] = Txt_Charges.Text.ToString();
            dr[3] = Txt_Remark.Text.ToString().ToUpper();
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["AccountData"] != null)
        {
            GV_Account.DataSource = (DataTable)ViewState["AccountData"];
            GV_Account.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_Account.DataSource = dt;
            GV_Account.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["AccountData"] = dt;
    }
    protected void Btn_AddAccount_Click(object sender, EventArgs e)
    {

        if (ViewState["AccountData"] != null)
        {
            DataTable dt = (DataTable)ViewState["AccountData"];
            int count = dt.Rows.Count;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if ((dt.Rows[i]["AccountName"]).ToString() == Txt_AccountCode.Text.ToString())
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

        Txt_AccountCode.Text = "";
        hfAccountName.Value = "";
        Txt_Charges.Text = "";
        Txt_Remark.Text = "";
    }


    /*---------------------Staff Type DropdownList Code(Hide/show Driver/Pickup_Person Details)------------------------------------------*/
    protected void Ddl_StaffType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Ddl_StaffType.SelectedItem.Text == "DRIVER")
        {
            (new CFunctions()).dropdwnlist(null, null, Ddl_DriverName, null, "Name", "Id", ((new VehicleRequestFunction()).getDriverName()));
            Ddl_DriverName.Enabled = true;
            Ddl_DriverName.Visible = true;
            ddl_PickPersonName.Visible = false;
            Ddl_DriverName.SelectedIndex = 0;
            Txt_ContactNo.Text = "AUTO";
            new CFunctions().ButtonopacityHideShow(1, "ADD", Button_Add);
        }
        else if (Ddl_StaffType.SelectedItem.Text == "PICKUP PERSON")
        {
            (new CFunctions()).dropdwnlist(null, null, ddl_PickPersonName, null, "Name", "Id", ((new VehicleRequestFunction()).getPickUpPerson()));

            ddl_PickPersonName.Visible = true;
            Ddl_DriverName.Visible = false;
            ddl_PickPersonName.SelectedIndex = 0;
            Txt_ContactNo.Text = "AUTO";
            new CFunctions().ButtonopacityHideShow(1, "ADD", Button_Add);
        }
        else
        {
            Ddl_DriverName.Enabled = false;
            Txt_ContactNo.Text = "AUTO";
            ddl_PickPersonName.Visible = false;
            new CFunctions().ButtonopacityHideShow(0, "ADD", Button_Add);
        }
    }

    /*---------------------Driver Dropdownlist Code with Searching-----------------------------------------------*/
    protected void Ddl_DriverName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Ddl_DriverName.SelectedIndex != 0)
        {
            DriverId = Convert.ToInt32(Ddl_DriverName.SelectedValue);
            StaffDetail DriverDetail = (new VehicleRequestFunction()).getDriverDetail(DriverId);
            Txt_ContactNo.Text = DriverDetail.ContactNo.ToString();
        }
        else
            Txt_ContactNo.Text = "AUTO";
    }

    //Searchable TextBox Code
    //protected void Txt_Search_DriverName_TextChanged(object sender, EventArgs e)
    //{
    //    (new CFunctions()).dropdwnlist(null, RadioButtonList_DriverName, null, Txt_DriverName, "DriverName", "Id", ((new VehicleRequestFunction()).getDriverName()));
    //}
    //RadioButton SelectedIndex Code 
    //protected void RadioButtonList_DriverName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    (new CFunctions()).DataList_SelectedIndexChanging(RadioButtonList_DriverName, Txt_DriverName);
    //    if (RadioButtonList_DriverName.SelectedIndex != 0)
    //    {
    //        DriverId = Convert.ToInt32(RadioButtonList_DriverName.SelectedValue);
    //        StaffDetail DriverDetail = (new VehicleRequestFunction()).getDriverDetail(DriverId);
    //        Txt_DriverContactNo.Text = DriverDetail.ContactNo.ToString();
    //    }
    //    else
    //        Txt_DriverContactNo.Text = "AUTO";
    //}
    /*---------------------- PickUp Person Dropdownlist Code With Searching-------------------------------------------------------*/
    protected void ddl_PickPersonName_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_PickPersonName.SelectedIndex != 0)
        {
            PickUpPersonId = Convert.ToInt32(ddl_PickPersonName.SelectedValue);
            StaffDetail PickUpPersonDetail = (new VehicleRequestFunction()).getPickUpPersonDetail(PickUpPersonId);
            Txt_ContactNo.Text = PickUpPersonDetail.ContactNo.ToString();
        }
        else
            Txt_ContactNo.Text = "AUTO";
    }
    //Searchable TextBox Code
    //protected void Txt_Search_PickPersonName_TextChanged(object sender, EventArgs e)
    //{
    //    (new CFunctions()).dropdwnlist(null, RadioButtonList_PickPersonName, null, Txt_PickPersonName, "PickPersonName", "Id", ((new VehicleRequestFunction()).getPickUpPerson()));
    //}
    //RadioButton SelectedIndex Code
    //protected void RadioButtonList_PickPersonName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    (new CFunctions()).DataList_SelectedIndexChanging(RadioButtonList_PickPersonName, Txt_PickPersonName);
    //    if (RadioButtonList_PickPersonName.SelectedIndex != 0)
    //    {
    //        PickUpPersonId = Convert.ToInt32(RadioButtonList_PickPersonName.SelectedValue);
    //        StaffDetail PickUpPersonDetail = (new VehicleRequestFunction()).getPickUpPersonDetail(PickUpPersonId);
    //        Txt_PickPersonContactNo.Text = PickUpPersonDetail.ContactNo.ToString();
    //    }
    //    else
    //        Txt_PickPersonContactNo.Text = "AUTO";
    //}
    /*---------------------------Add Staff Type Details In Datatable And Show in Gridview------------------------------------------*/
    protected void Button_Add_Click(object sender, EventArgs e)
    {
        AddNewRecordRowToGrid();
        ClearStaffDetail();
    }
    #endregion

    /*---------------------------Waybill Details Select All Code--------------------------------------------------------*/
    protected void SelectAllData(CheckBox selectAll)
    {
        foreach (GridViewRow item in GV_RouteWaybillDetail.Rows)
        {
            var checkbox = item.FindControl("CheckBox1") as CheckBox;
            if (selectAll.Checked == true)
                checkbox.Checked = true;
            else if (selectAll.Checked == false)
                checkbox.Checked = false;
        }
    }
    protected void SellectAll_CheckedChanged(object sender, EventArgs e)
    {
        SelectAllData(GV_RouteWaybillDetail.HeaderRow.FindControl("CheckSelectAll") as CheckBox);
    }

    protected void Ddl_LocationOnRoute_SelectedIndexChanged(object sender, EventArgs e)
    {
        //  RouteWaybillFillGrid(Ddl_LocationOnRoute.SelectedValue);
        foreach (GridViewRow item in GV_RouteWaybillDetail.Rows)
        {
            CheckBox SelectAll = GV_RouteWaybillDetail.HeaderRow.FindControl("CheckSelectAll") as CheckBox;
            SelectAll.Checked = true;
            SelectAllData(SelectAll);
            break;
        }
    }
    /*----------------------------Final All PickUp Details Submit Data And Store In DataBase-------------------------------------------------*/
    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        // int checkcount = 0;
        if (CFunctions.tabstatus == 0)
        {
            //foreach (GridViewRow Row in GV_RouteWaybillDetail.Rows)
            //{
            //    var checkbox = Row.FindControl("CheckBox1") as CheckBox;
            //    if (checkbox.Checked == true)
            //    {
            //checkcount++;

            VehicleRequestProperties VehicleRequestLHS = new VehicleRequestProperties();
            VehicleRequestLHS.VehicleID = VehicleId;
            VehicleRequestLHS.vehicleReqType = "RT";
            VehicleRequestLHS.NoOfLabour = Convert.ToInt32(Txt_NoOfLabour.Text);
            VehicleRequestLHS.hiringDate = Txt_HiringDate.Text.ToString();
            VehicleRequestLHS.Mpin = GenerateRandomNo();     
            VehicleRequestLHS.routeId = Convert.ToInt32(Ddl_VehicleRoute.SelectedValue);
            VehicleRequestLHS.routeScheduleMasterId = Convert.ToInt32(Ddl_RouteSchedule.SelectedValue);
            VehicleRequestLHS.deliveryRouteId = 0;
            VehicleRequestLHS.Remark = Txt_ReasonForVehicle.Text.ToString().ToUpper();
            VehicleRequestLHS.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
            VehicleRequestLHS.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
            VehicleRequestLHS.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
            // For Account Details
            if(ViewState["AccountData"] != null)
            {
                List<AccountDetail> lstAcctDetails = new List<AccountDetail>();
                foreach (GridViewRow drRow in GV_Account.Rows)
                {
                    AccountDetail acctDetail = new AccountDetail();
                    acctDetail.AccountId = Convert.ToInt32(drRow.Cells[1].Text);
                    acctDetail.AccountValue = Convert.ToDecimal(drRow.Cells[3].Text);
                    acctDetail.Remark = drRow.Cells[4].Text.ToString();
                    lstAcctDetails.Add(acctDetail);
                }
                VehicleRequestLHS.acct = lstAcctDetails;
            }
           
            // For Staff Details
            List<StaffDetail> lstStaffDetails = new List<StaffDetail>();
            foreach (GridViewRow drRow in GV_StaffDetail.Rows)
            {
                StaffDetail staffDetail = new StaffDetail();
                staffDetail.Type = drRow.Cells[1].Text.ToString();
                if (staffDetail.Type == "DRIVER")
                    staffDetail.Id = Convert.ToInt32(drRow.Cells[2].Text);
                else if (staffDetail.Type == "PICKUP PERSON")
                    staffDetail.Id = Convert.ToInt32(drRow.Cells[3].Text);
                lstStaffDetails.Add(staffDetail);
            }
            //for Delivery
            VehicleRequestLHS.staff = lstStaffDetails;
            List<PickReq> ListWaybill = new List<PickReq>();
            foreach (GridViewRow drRow in GV_RouteWaybillDetail.Rows)
            {
                var checkbox1 = drRow.FindControl("CheckBox1") as CheckBox;
                if (checkbox1.Checked == true)
                {
                    PickReq WaybillDetail = new PickReq();
                    WaybillDetail.WaybillId = Convert.ToInt32(drRow.Cells[2].Text);
                    ListWaybill.Add(WaybillDetail);
                }
            }
            VehicleRequestLHS.listwaybill = ListWaybill;
            int reader = (new VehicleRequestFunction()).SaveVehicleRequestLHS(VehicleRequestLHS);
            if (reader != 0)
            {
                VehicleRequestProperties VehicleRequestStatus = new VehicleRequestProperties();
                VehicleRequestStatus.VehicleRequestID = reader;
                if (Txt_VehicleCategory.Text == "OWNED" || Txt_VehicleCategory.Text == "FIXED")
                {
                    VehicleRequestStatus.StatusID = 2;
                    VehicleRequestStatus.Remark= Txt_ReasonForVehicle.Text.ToString().ToUpper();
                    VehicleRequestStatus.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
                    VehicleRequestStatus.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
                    VehicleRequestStatus.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
                    (new VehicleRequestFunction()).SaveVehicleRequestLHSStatus(VehicleRequestStatus);
                }
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                FillGrid();
                ClearTextField();
            }
            //  break;
            //    }
            //}
            //if (checkcount == 0)
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select checkbox')", true);
        }
        //else if (CFunctions.tabstatus == 1)
        //{
        //    foreach (GridViewRow Row in GV_RouteWaybillDetail.Rows)
        //    {
        //        var checkbox = Row.FindControl("CheckBox1") as CheckBox;
        //        if (checkbox.Checked == true)
        //        {
        //            checkcount++;
        //            PickDelLHSProperties pickdel = new PickDelLHSProperties();
        //            List<PickReq> ListPickReq = new List<PickReq>();
        //            foreach (GridViewRow drRow in GV_RouteWaybillDetail.Rows)
        //            {
        //                var checkbox1 = drRow.FindControl("CheckBox1") as CheckBox;
        //                if (checkbox1.Checked == true)
        //                {
        //                    PickReq pickDetail = new PickReq();
        //                    pickDetail.Id = Convert.ToInt32(drRow.Cells[2].Text);
        //                    ListPickReq.Add(pickDetail);
        //                }
        //            }
        //            pickdel.PickReq = ListPickReq;
        //            (new PickDelLHSFunctions()).SavePickUpReq(pickdel, CFunctions.tab);
        //            (new CFunctions()).showalert("Button_Tab1Save", "UPDATE", this);
        //            //FillGrid();
        //            //ClearTextField();
        //            break;
        //        }
        //    }
        //    if (checkcount == 0)
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select checkbox')", true);
        //}
    }

    //protected void ViewData_Edit_Click(object sender, EventArgs e)
    //{
    //    CFunctions.setTabStatus(1);
    //    VehicleRequestProperties VehicleRequest = new VehicleRequestProperties();
    //    VehicleRequest.VehicleRequestID = Convert.ToInt32(Convert.ToString((sender as LinkButton).CommandArgument));
    //    CFunctions.setTab(VehicleRequest.VehicleRequestID);
    //    LoadDataInTextField(VehicleRequest.VehicleRequestID);
    //    staffDetail.Visible = false;
    //    //PickUpFillGrid();
    //    // PickUpTab.Visible = true;
    //    // PickUpAlreadyAddedLHSFillGrid(pickdel.Id);
    //    AlreadyAdd.Visible = true;
    //    // PickUpSubmit.Visible = true;
    //}

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    
}