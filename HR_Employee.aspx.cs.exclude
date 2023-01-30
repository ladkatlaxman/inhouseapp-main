using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Global;
//using CheckTabAndButtonStatus;
using System.Configuration;
using System.IO;
using CommonLibrary;
using BLFunctions;

public partial class OPERATIONS_Employee : System.Web.UI.Page
{
    CommonFunctions cmf = new CommonFunctions();
    CFunctions cmf1 = new CFunctions();
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    SqlDataAdapter sqlda;
    string strcmd = string.Empty;
    public static string editEmployeeNo = string.Empty;
    public static int EmpID, BranchID, DepartmentId, DesignationId, StateID;
    static String fileName1;
    static String fileName2;
    static String fileName3;
    static String fileName4;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillEmployeeBelongToBranch();
           // globalVar.code = "";         
            CFunctions.setTab(1);
            CFunctions.setTabStatus(0);
            //Btn_Next.Enabled = false;
            //Btn_Next.Text = "NEXT <i class='fa fa-arrow-circle-right'></i>";
            //Btn_Next.CssClass = "btn btn-info largeButtonStyle";
            //Btn_Next.Style.Add("opacity", ".3");


            cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchEmployeeName, "ssp_GetEmployeeList", "@DepartmentName", null, "", "", "", "", "fullName", "userID", null);
            cmf.BindDataValueInListTripleParameter("", null, null, Ddl_SearchDepartment, "ssp_GetDepartmentList", "", "", "", "", "", "", "departmentName", "departmentID", null);          
            cmf.BindDataValueInListTripleParameter("", null, null, Ddl_Department, "ssp_GetDepartmentList", "", "", "", "", "", "", "departmentName", "departmentID", null);
            cmf.BindDataValueInListTripleParameter("", null, null, Ddl_Designation, "ssp_GetDesignationList", "", "", "", "", "", "", "designationName", "designationID", null);
           // cmf.BindDataValueInListTripleParameter("", null, null, Ddl_State, "ssp_GetStateList", "", "", "", "", "", "", "stateName", "stateID", null);
          //  displayDataInGridView();        
            Ddl_EmployeeType.Focus(); 
        }
    }
  
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private void displayDataInGridView(string sortExpression = null)
    {
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewEmployeeCreation", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        if (sortExpression != null)
        {
            DataView dv = dtbl.AsDataView();
            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
            dv.Sort = sortExpression + " " + this.SortDirection;
            gridViewEmployeeCreation.DataSource = dv;
            GV_Export.DataSource = dv;
        }
        else
        {
            gridViewEmployeeCreation.DataSource = dtbl;
            GV_Export.DataSource = dtbl;
        }


        gridViewEmployeeCreation.DataBind();
        GV_Export.DataBind();
        con.Close();
    }
    public void clear()
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    public void clearAll()
    {
       // globalVar.code = "";
        //  generateEmployeeCode();
      
        Ddl_EmployeeType.SelectedIndex = 0;
        // Txt_EmployeeNo.Enabled = true;
        Txt_DateofJoining.Text = "";
        //  Txt_BelongToBranch.Text = "SELECT";
        //  RadioButtonList_BelongToBranch.SelectedIndex = 0;
        //  Txt_BelongToBranch_Search.Text = "";
        //DatafillForBelongToBranch();
        Txt_FirstName.Text = "";
        Txt_MiddleName.Text = "";
        Txt_LastName.Text = "";
        RadioBtn_Male.Checked = false;
        RadioBtn_Female.Checked = false;
        Txt_Birthdate.Text = "";
        Txt_EmployeeContactNo.Text = "";
        Txt_EmailId.Text = "";
        Txt_PermanantAddress.Text = "";
        Txt_CurrentAddress.Text = "";
        Check_Address.Checked = false;
        //Ddl_BloodGroup.SelectedIndex = 0;
        //Radio_Yes.Checked = false;
        //Radio_No.Checked = false;
        //Radio_Yes2.Checked = false;
        //Radio_No2.Checked = false;
        //Txt_Describe.Text = "";
        //Txt_PrevousCompanyName.Text = "";
        //Txt_Durationfrom.Text = "";
        //Txt_DurationTo.Text = "";
        //Txt_PrevDesgination.Text = "";     
        Ddl_Department.Enabled = true;
        Ddl_Department.SelectedIndex = 0;
        Ddl_Designation.SelectedIndex = 0;
        //Txt_MonthlyGrossSalary.Text = "";
        //Txt_AnnualGrossSalary.Text = "";
        //Txt_NameofBank.Text = "";
        //Txt_Branch.Text = "";
        //Txt_BankAddress.Text = "";      
        //Ddl_State.SelectedIndex = 0;
        //Txt_BankAccountNumber.Text = "";
        //Txt_IFSCcode.Text = "";
        //Txt_PFNumber.Text = "";
        //Txt_DateofRegistration.Text = "";
        //Txt_UAN.Text = "";

        //Txt_AadharNo.Text = "";
        //Emp_AadhaarCard_Label.InnerHtml = "";
        //Txt_PancardNo.Text = "";
        //Emp_PanCard_Label.InnerHtml = "";
        //Emp_Resume_Label.InnerHtml = "";
        //Emp_Photo_Label.InnerHtml = "";
        Ddl_SearchEmployeeName.SelectedIndex = 0;             
        Ddl_SearchDepartment.SelectedIndex = 0;
    
        Button_Tab1Save.Text = "SUBMIT <i class='fa fa-save'></i>";

        //Btn_Next.Enabled = false;
        //Btn_Next.Text = "NEXT <i class='fa fa-arrow-circle-right'></i>";
        //Btn_Next.CssClass = "btn btn-info largeButtonStyle";
        //Btn_Next.Style.Add("opacity", ".3");

        Emp_Reset.Enabled = true;
        Emp_Reset.CssClass = "btn btn-info largeButtonStyle";
        Emp_Reset.Style.Add("color", "white");
        Emp_Reset.Style.Remove("opacity");

        //Upload_Reset.Enabled = true;
        //Upload_Reset.CssClass = "btn btn-info largeButtonStyle";
        //Upload_Reset.Style.Add("color", "white");
        //Upload_Reset.Style.Remove("opacity");

        Search_EmployeeDetails_View.Visible = false;
        Ddl_EmployeeType.Focus();
        // Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void Emp_Reset_Click(object sender, EventArgs e)
    {
        if (HiddenField_Emp_Reset.Value == "1")
        {
            Response.Redirect(Request.Url.AbsoluteUri);

            HiddenField_Emp_Reset.Value = "";
        }

    }

    //protected void Upload_Reset_Click(object sender, EventArgs e)
    //{
    //    if (HiddenField_Upload_Reset.Value == "1")
    //    {
    //        Txt_AadharNo.Text = "";
    //        Emp_AadhaarCard_Label.InnerHtml = "";
    //        Txt_PancardNo.Text = "";
    //        Emp_PanCard_Label.InnerHtml = "";
    //        Emp_Resume_Label.InnerHtml = "";
    //        Emp_Photo_Label.InnerHtml = "";

    //        HiddenField_Upload_Reset.Value = "";
    //    }
    //}  
    public void NonEditableFieldsOfEmployee()
    {
        Ddl_EmployeeType.Enabled = false;
        Txt_DateofJoining.Enabled = false;
        // Panel_BelongToBranch.Visible = false;
        // Txt_BelongToBranch.Style.Remove("background-color");

        Txt_FirstName.Enabled = false;
        Txt_MiddleName.Enabled = false;
        Txt_LastName.Enabled = false;
        RadioBtn_Male.Enabled = false;
        RadioBtn_Female.Enabled = false;
        Txt_Birthdate.Enabled = false;
        Txt_EmployeeContactNo.Enabled = false;
        Txt_EmailId.Enabled = false;
        Txt_PermanantAddress.Enabled = false;
        Txt_CurrentAddress.Enabled = false;
        Check_Address.Enabled = false;
        //Ddl_BloodGroup.Attributes.Add("disabled", "disabled");
        //Radio_Yes.Enabled = false;
        //Radio_No.Enabled = false;
        //Radio_Yes2.Enabled = false;
        //Radio_No2.Enabled = false;
        //Txt_Describe.Enabled = false;
        //Txt_PrevousCompanyName.Enabled = false;
        //Txt_Durationfrom.Enabled = false;
        //Txt_DurationTo.Enabled = false;
        //Txt_PrevDesgination.Enabled = false;
        //Ddl_Department.Enabled = false;
        //Txt_MonthlyGrossSalary.Enabled = false;
        //Txt_AnnualGrossSalary.Enabled = false;
        //Txt_NameofBank.Enabled = false;
        //Txt_Branch.Enabled = false;
        //Txt_BankAddress.Enabled = false;
        //Ddl_Designation.Enabled = false;
        //Ddl_State.Enabled = false;
        //Txt_BankAccountNumber.Enabled = false;
        //Txt_IFSCcode.Enabled = false;
        //Txt_PFNumber.Enabled = false;
        //Txt_DateofRegistration.Enabled = false;
        //Txt_UAN.Enabled = false;

        Button_Tab1Save.Enabled = false;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Add("opacity", "0.3");
        Emp_Reset.Enabled = false;
        Emp_Reset.Style.Add("color", "white");
        Emp_Reset.Style.Add("opacity", "0.3");
        //Btn_Next.CssClass = "btn btn-info largeButtonStyle next-step";
        //Btn_Next.Style.Remove("opacity");
    }
    protected void Button_Tab1Save_Click(object sender, EventArgs e)
    {
        if (HiddenField_Tab1Save.Value == "1")
        {
            // globalVar.setCode(Txt_EmployeeNo.Text == "" ? "0" : Txt_EmployeeNo.Text.ToString());
            CFunctions.setTab(1);

            if (CFunctions.tab == 1)
            {
                if (CFunctions.tabstatus == 0)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeCreation", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@empTab", CFunctions.tab);
                    cmd.Parameters.AddWithValue("@empcheck", CFunctions.tabstatus);
                    cmd.Parameters.AddWithValue("@userId", "");
                    cmd.Parameters.AddWithValue("@employeeType", Ddl_EmployeeType.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@joiningDate", Txt_DateofJoining.Text.Trim().ToString());               
                    cmd.Parameters.AddWithValue("@FirstName", Txt_FirstName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@MiddleName", Txt_MiddleName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@LastName", Txt_LastName.Text.Trim().ToString().ToUpper());
                  
                    string gender = string.Empty;
                    if (RadioBtn_Male.Checked)
                    {
                        gender = "MALE";
                    }
                    else if (RadioBtn_Female.Checked)
                    {
                        gender = "FEMALE";
                    }
                    cmd.Parameters.AddWithValue("@gender", gender);
                    cmd.Parameters.AddWithValue("@birthDate", Txt_Birthdate.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@contactNo", Txt_EmployeeContactNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@emailID", Txt_EmailId.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@permanentAddress", Txt_PermanantAddress.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@currentAddress", Txt_CurrentAddress.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bloodGroup", Ddl_BloodGroup.Text.Trim().ToString());
                    //string physical_disability = string.Empty;
                    //if (Radio_Yes.Checked)
                    //{
                    //    physical_disability = "YES";
                    //}
                    //else if (Radio_No.Checked)
                    //{
                    //    physical_disability = "NO";
                    //}
                    //cmd.Parameters.AddWithValue("@physicalDisabilty", physical_disability);

                    //string major_illness = string.Empty;
                    //if (Radio_Yes2.Checked)
                    //{
                    //    major_illness = "YES";
                    //}
                    //else if (Radio_No2.Checked)
                    //{
                    //    major_illness = "NO";
                    //}
                    //cmd.Parameters.AddWithValue("@majorIllness", major_illness);

                    //if (Radio_Yes2.Checked)
                    //{
                    //    cmd.Parameters.AddWithValue("@description", Txt_Describe.Text.Trim().ToString().ToUpper());
                    //}
                    //else
                    //{
                    //    cmd.Parameters.AddWithValue("@description", "");
                    //}

                    //cmd.Parameters.AddWithValue("@previousCompanyName", Txt_PrevousCompanyName.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@duationFrom", Txt_Durationfrom.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@durationTo", Txt_DurationTo.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@previousDesignation", Txt_PrevDesgination.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@department", Ddl_Department.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@designation", Ddl_Designation.SelectedValue.ToString());
                    //cmd.Parameters.AddWithValue("@monthlyGrossSalary", Txt_MonthlyGrossSalary.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@annualGrossSalary", Txt_AnnualGrossSalary.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@PFNumber", Txt_PFNumber.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@PFRegistrationDate", Txt_DateofRegistration.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@UAN", Txt_UAN.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@bankName", Txt_NameofBank.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bankBranchName", Txt_Branch.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bankAddress", Txt_BankAddress.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bankState", StateID);
                    //cmd.Parameters.AddWithValue("@bankAccountNo", Txt_BankAccountNumber.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@bankIFSC", Txt_IFSCcode.Text.Trim().ToString());

                    cmd.Parameters.AddWithValue("@creationDateTime", cmf1.CurrentDateTime());                
                                       
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        CFunctions.setID(Convert.ToInt32(reader["id"].ToString()));
                    }
                    con.Close();

                    for (int i = 0; i < CheckBoxList_EmpBelongToBranch.Items.Count; i++)
                    {
                        if (CheckBoxList_EmpBelongToBranch.Items[i].Selected)
                        {
                            int branchID = Convert.ToInt32(CheckBoxList_EmpBelongToBranch.Items[i].Value.ToString());
                            con.Open();
                            cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeBelongToBranch", con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Event","Insert");
                            cmd.Parameters.AddWithValue("@userID", CFunctions.ID);
                            cmd.Parameters.AddWithValue("@branchID", branchID);
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }

                    
                
               

                   // NonEditableFieldsOfEmployee();


                    string a = "Button_Tab1Save";
                    string b = "SAVE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);

                }
                else if (CFunctions.tabstatus == 1)
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeCreation", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@empTab", CFunctions.tab);
                    cmd.Parameters.AddWithValue("@empcheck", CFunctions.tabstatus);                
                    cmd.Parameters.AddWithValue("@userId", CFunctions.ID);
                    cmd.Parameters.AddWithValue("@employeeType", Ddl_EmployeeType.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@joiningDate", Txt_DateofJoining.Text.Trim().ToString());            
                    cmd.Parameters.AddWithValue("@FirstName", Txt_FirstName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@MiddleName", Txt_MiddleName.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@LastName", Txt_LastName.Text.Trim().ToString().ToUpper());

                    string gender = string.Empty;
                    if (RadioBtn_Male.Checked)
                    {
                        gender = "MALE";
                    }
                    else if (RadioBtn_Female.Checked)
                    {
                        gender = "FEMALE";
                    }
                    cmd.Parameters.AddWithValue("@gender", gender);
                    cmd.Parameters.AddWithValue("@birthDate", Txt_Birthdate.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@contactNo", Txt_EmployeeContactNo.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@emailID", Txt_EmailId.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@permanentAddress", Txt_PermanantAddress.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@currentAddress", Txt_CurrentAddress.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bloodGroup", Ddl_BloodGroup.Text.Trim().ToString());
                    //string physical_disability = string.Empty;
                    //if (Radio_Yes.Checked)
                    //{
                    //    physical_disability = "YES";
                    //}
                    //else if (Radio_No.Checked)
                    //{
                    //    physical_disability = "NO";
                    //}
                    //cmd.Parameters.AddWithValue("@physicalDisabilty", physical_disability);

                    //string major_illness = string.Empty;
                    //if (Radio_Yes2.Checked)
                    //{
                    //    major_illness = "YES";
                    //}
                    //else if (Radio_No2.Checked)
                    //{
                    //    major_illness = "NO";
                    //}
                    //cmd.Parameters.AddWithValue("@majorIllness", major_illness);

                    //if (Radio_Yes2.Checked)
                    //{
                    //    cmd.Parameters.AddWithValue("@description", Txt_Describe.Text.Trim().ToString().ToUpper());
                    //}
                    //else
                    //{
                    //    cmd.Parameters.AddWithValue("@description", "");
                    //}

                    //cmd.Parameters.AddWithValue("@previousCompanyName", Txt_PrevousCompanyName.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@duationFrom", Txt_Durationfrom.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@durationTo", Txt_DurationTo.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@previousDesignation", Txt_PrevDesgination.Text.Trim().ToString().ToUpper());
                    cmd.Parameters.AddWithValue("@department", Ddl_Department.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@designation", Ddl_Designation.SelectedValue.ToString());

                    //cmd.Parameters.AddWithValue("@PFNumber", Txt_PFNumber.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@PFRegistrationDate", Txt_DateofRegistration.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@UAN", Txt_UAN.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@bankName", Txt_NameofBank.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bankBranchName", Txt_Branch.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bankAddress", Txt_BankAddress.Text.Trim().ToString().ToUpper());
                    //cmd.Parameters.AddWithValue("@bankState", StateID);
                    //cmd.Parameters.AddWithValue("@bankAccountNo", Txt_BankAccountNumber.Text.Trim().ToString());
                    //cmd.Parameters.AddWithValue("@bankIFSC", Txt_IFSCcode.Text.Trim().ToString());
                    cmd.Parameters.AddWithValue("@creationDateTime", "");
                   

                    cmd.ExecuteNonQuery();
                    con.Close();


                    con.Open();
                    cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeBelongToBranch", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Event", "Delete");
                    cmd.Parameters.AddWithValue("@userID", CFunctions.ID);
                    cmd.Parameters.AddWithValue("@branchID", "");
                    cmd.ExecuteNonQuery();
                    con.Close();

                    for (int i = 0; i < CheckBoxList_EmpBelongToBranch.Items.Count; i++)
                    {
                        if (CheckBoxList_EmpBelongToBranch.Items[i].Selected)
                        {
                            int branchID = Convert.ToInt32(CheckBoxList_EmpBelongToBranch.Items[i].Value.ToString());
                            con.Open();
                            cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeBelongToBranch", con);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Event", "Insert");
                            cmd.Parameters.AddWithValue("@userID", CFunctions.ID);
                            cmd.Parameters.AddWithValue("@branchID", branchID);
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }

                    //NonEditableFieldsOfEmployee();
                    Button_Tab1Save.Text = "UPDATE <i class='fa fa-save'></i>";

                  
                    string a = "Button_Tab1Save";
                    string b = "UPDATE";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
                }
                CFunctions.setTabStatus(0);
            }
            clearAll();


            //Btn_Next.Focus();

            HiddenField_Tab1Save.Value = "";
        }

    }

    public void RemoveNonEditableFieldsOfEmployee()
    {
        Ddl_EmployeeType.Enabled = true;
        Txt_DateofJoining.Enabled = true;
        Txt_FirstName.Enabled = true;
        Txt_MiddleName.Enabled = true;
        Txt_LastName.Enabled = true;
        RadioBtn_Male.Enabled = true;
        RadioBtn_Female.Enabled = true;
        Txt_Birthdate.Enabled = true;
        Txt_EmployeeContactNo.Enabled = true;
        Txt_EmailId.Enabled = true;
        Txt_PermanantAddress.Enabled = true;
        Txt_CurrentAddress.Enabled = true;
        Check_Address.Enabled = true;
        //Ddl_BloodGroup.Attributes.Remove("disabled");
        //Radio_Yes.Enabled = true;
        //Radio_No.Enabled = true;
        //Radio_Yes2.Enabled = true;
        //Radio_No2.Enabled = true;
        //Txt_Describe.Enabled = true;
        //Txt_PrevousCompanyName.Enabled = true;
        //Txt_Durationfrom.Enabled = true;
        //Txt_DurationTo.Enabled = true;
        //Txt_PrevDesgination.Enabled = true;
        Ddl_Department.Enabled = true;
      
        //Txt_NameofBank.Enabled = true;
        //Txt_Branch.Enabled = true;
        //Txt_BankAddress.Enabled = true;
        Ddl_Designation.Enabled = true;
        //Ddl_State.Enabled = true;
        //Txt_BankAccountNumber.Enabled = true;
        //Txt_IFSCcode.Enabled = true;
        //Txt_PFNumber.Enabled = true;
        //Txt_DateofRegistration.Enabled = true;
        //Txt_UAN.Enabled = true;

        Button_Tab1Save.Enabled = true;
        Button_Tab1Save.CssClass = "btn btn-info largeButtonStyle";
        Button_Tab1Save.Style.Add("color", "white");
        Button_Tab1Save.Style.Remove("opacity");

    }

    //protected void Button_Submit1_Click(object sender, EventArgs e)
    //{
    //    //if (HiddenField_Submit1.Value=="1")
    //    //{

    //    string EmpPanCardFileName;
    //    string EmpAadhaarCardFileName;
    //    string EmpResumeFileName;
    //    string EmpPhotoFileName;

    //    if (fileName1 == null)
    //    {
    //        EmpPanCardFileName = "";
    //    }
    //    else
    //    {
    //        EmpPanCardFileName = fileName1;
    //    }

    //    if (fileName2 == null)
    //    {
    //        EmpAadhaarCardFileName = "";
    //    }
    //    else
    //    {
    //        EmpAadhaarCardFileName = fileName2;
    //    }
    //    if (fileName3 == null)
    //    {
    //        EmpResumeFileName = "";
    //    }
    //    else
    //    {
    //        EmpResumeFileName = fileName3;
    //    }
    //    if (fileName4 == null)
    //    {
    //        EmpPhotoFileName = "";
    //    }
    //    else
    //    {
    //        EmpPhotoFileName = fileName4;
    //    }


    //    // globalVar.setCode(Txt_EmployeeNo.Text == "" ? "0" : Txt_EmployeeNo.Text.ToString());
    //    CFunctions.setTab(2);

    //    if (CFunctions.tab == 2)
    //    {
    //        con.Open();

    //        cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeCreation", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@empTab", CFunctions.tab);
    //        cmd.Parameters.AddWithValue("@empcheck", CFunctions.tabstatus);
    //        cmd.Parameters.AddWithValue("@employeeId", CFunctions.ID);
    //        cmd.Parameters.AddWithValue("@employeeType", "");
    //        cmd.Parameters.AddWithValue("@joiningDate", "");
    //        cmd.Parameters.AddWithValue("@belongToBranchID", "");
    //        cmd.Parameters.AddWithValue("@fullName", "");
    //        cmd.Parameters.AddWithValue("@gender", "");
    //        cmd.Parameters.AddWithValue("@birthDate", "");
    //        cmd.Parameters.AddWithValue("@contactNo", "");
    //        cmd.Parameters.AddWithValue("@emailID", "");
    //        cmd.Parameters.AddWithValue("@permanentAddress", "");
    //        cmd.Parameters.AddWithValue("@currentAddress", "");
    //        cmd.Parameters.AddWithValue("@department", "");
    //        cmd.Parameters.AddWithValue("@designation", "");
    //        cmd.Parameters.AddWithValue("@creationDateTime", "");
    //        cmd.Parameters.AddWithValue("@aadharCardNo", Txt_AadharNo.Text.Trim().ToString());
    //        cmd.Parameters.AddWithValue("@panCardNo", Txt_PancardNo.Text.Trim().ToString());
    //        cmd.Parameters.AddWithValue("@resumeFileName", EmpResumeFileName);
    //        cmd.Parameters.AddWithValue("@photoFileName", EmpPhotoFileName);
    //        cmd.Parameters.AddWithValue("@aadharFileName", EmpAadhaarCardFileName);
    //        cmd.Parameters.AddWithValue("@panCardFileName", EmpPanCardFileName);          
    //        cmd.ExecuteNonQuery();
    //        con.Close();       
    //        if (CFunctions.tabstatus == 0)
    //        {              
    //            string a = "Button_Submit1";
    //            string b = "SAVE";
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    //        }
    //        else if (CFunctions.tabstatus == 1)
    //        {
    //            string a = "Button_Submit1";
    //            string b = "UPDATE";
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    //        }
    //        CFunctions.setTab(1);
           
    //    }
       
    //    RemoveNonEditableFieldsOfEmployee();
    //    clearAll();
    //    displayDataInGridView();

    //    //    HiddenField_Submit1.Value = "";
    //    //}

    //}
    //************************************************Set setFinalSubmit False(At the time of Editing)******************************************************
  
    protected void editEmployeeCreationDetails_Click(object sender, EventArgs e)
    {
        CFunctions.setTabStatus(1);

        CFunctions.setID(Convert.ToInt32((sender as LinkButton).CommandArgument));
        con.Open();
        sqlda = new SqlDataAdapter("ssp_GetEmployeeCreation", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@employeeId", CFunctions.ID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);


        //fill manifest attachment waybills in dropdown
        sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);
        CheckBoxList_EmpBelongToBranch.DataSource = dt;
        CheckBoxList_EmpBelongToBranch.DataTextField = "branchName";
        CheckBoxList_EmpBelongToBranch.DataValueField = "branchID";
        CheckBoxList_EmpBelongToBranch.DataBind();

        // this is only for checked items in dropdown list
        sqlda = new SqlDataAdapter("ssp_CreateOrUpdateEmployeeBelongToBranch", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@Event", "View");
        sqlda.SelectCommand.Parameters.AddWithValue("@userID", CFunctions.ID);
        sqlda.SelectCommand.Parameters.AddWithValue("@branchID", "");
        DataTable dtbl1 = new DataTable();
        sqlda.Fill(dtbl1);

        for (int i = 0; i < dtbl1.Rows.Count; i++)
        {
            if (CheckBoxList_EmpBelongToBranch.Items.FindByValue(dtbl1.Rows[i]["branchID"].ToString()).ToString() != null)
            {              
                CheckBoxList_EmpBelongToBranch.Items.FindByValue(dtbl1.Rows[i]["branchID"].ToString()).Selected = true;
                Txt_EmpBelongToBranch.Text += dtbl1.Rows[i]["branchName"].ToString() + ",";
            }
        }
       




     
        con.Close();
        //Txt_EmployeeNo.Text = dtbl.Rows[0]["employeeNo"].ToString();
        //if (Ddl_EmployeeType.Items.FindByValue(dtbl.Rows[0]["employeeType"].ToString()) != null)
        //{
        //    Ddl_EmployeeType.Items.FindByValue(dtbl.Rows[0]["employeeType"].ToString()).Selected = true;
        //}
        Ddl_EmployeeType.Text = dtbl.Rows[0]["employeeType"].ToString();
        //if (Ddl_EmployeeType.Text == "FRESHER")
        //{
        //    PreviousExperience.Visible = false;
        //}
        //else
        //{
        //    PreviousExperience.Visible = true;
        //}


        Txt_DateofJoining.Text = dtbl.Rows[0]["joiningDate"].ToString();
        string str = dtbl.Rows[0]["fullName"].ToString();
        string[] fullname = str.Split(' ');
        Txt_FirstName.Text = fullname[0];
        Txt_MiddleName.Text = fullname[1];
        Txt_LastName.Text = fullname[2];

        Txt_EmailId.Text = dtbl.Rows[0]["emailID"].ToString();

        if (RadioBtn_Male.Checked = dtbl.Rows[0]["gender"].ToString() == "MALE")
        {
            RadioBtn_Male.Checked = true;
            RadioBtn_Female.Checked = false;
        }
        else
        {
            RadioBtn_Female.Checked = true;
            RadioBtn_Male.Checked = false;
        }

        Txt_Birthdate.Text = dtbl.Rows[0]["birthDate"].ToString();
        Txt_EmployeeContactNo.Text = dtbl.Rows[0]["contactNo"].ToString();
        Txt_EmailId.Text = dtbl.Rows[0]["emailID"].ToString();
        Txt_PermanantAddress.Text = dtbl.Rows[0]["permanentAddress"].ToString();
        Txt_CurrentAddress.Text = dtbl.Rows[0]["currentAddress"].ToString();
      
        //Ddl_BloodGroup.Text = dtbl.Rows[0]["bloodGroup"].ToString();


        //if (Radio_Yes.Checked = dtbl.Rows[0]["physicalDisabilty"].ToString() == "YES")
        //{
        //    Radio_Yes.Checked = true;
        //    Radio_No.Checked = false;
        //}
        //else
        //{
        //    Radio_No.Checked = true;
        //    Radio_Yes.Checked = false;
        //}
        //if (Radio_Yes2.Checked = dtbl.Rows[0]["majorIllness"].ToString() == "YES")
        //{
        //    Radio_Yes2.Checked = true;
        //    Radio_No2.Checked = false;
        //}
        //else
        //{
        //    Radio_No2.Checked = true;
        //    Radio_Yes2.Checked = false;
        //}
        //Txt_Describe.Text = dtbl.Rows[0]["description"].ToString();
        //Txt_PrevousCompanyName.Text = dtbl.Rows[0]["previousCompanyName"].ToString();
        //Txt_Durationfrom.Text = dtbl.Rows[0]["duationFrom"].ToString();
        //Txt_DurationTo.Text = dtbl.Rows[0]["durationTo"].ToString();
        //Txt_PrevDesgination.Text = dtbl.Rows[0]["previousDesignation"].ToString();       
        Ddl_Department.SelectedItem.Text = dtbl.Rows[0]["departmentName"].ToString();
        Ddl_Department.SelectedValue = dtbl.Rows[0]["department"].ToString();
        Ddl_Designation.SelectedItem.Text = dtbl.Rows[0]["designationName"].ToString();
        Ddl_Designation.SelectedValue = dtbl.Rows[0]["designation"].ToString();
        //Txt_NameofBank.Text = dtbl.Rows[0]["bankName"].ToString();
        //Txt_Branch.Text = dtbl.Rows[0]["bankBranchName"].ToString();
        //Txt_BankAddress.Text = dtbl.Rows[0]["bankAddress"].ToString();
        //Ddl_State.SelectedItem.Text = dtbl.Rows[0]["stateName"].ToString();
        //Txt_BankAccountNumber.Text = dtbl.Rows[0]["bankAccountNo"].ToString();
        //Txt_IFSCcode.Text = dtbl.Rows[0]["bankIFSC"].ToString();
        //Txt_PFNumber.Text = dtbl.Rows[0]["PFNumber"].ToString();
        //Txt_DateofRegistration.Text = dtbl.Rows[0]["PFRegistrationDate"].ToString();
        //Txt_UAN.Text = dtbl.Rows[0]["UAN"].ToString();
        //Txt_AadharNo.Text = dtbl.Rows[0]["aadharCardNo"].ToString();

        //Emp_AadhaarCard_Label.InnerHtml = dtbl.Rows[0]["aadharFileName"].ToString();
        //Emp_AadhaarCard_Label.InnerHtml = dtbl.Rows[0]["aadharFileName"].ToString();
        //Emp_AadhaarCard_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["aadharFileName"].ToString());

        //Txt_PancardNo.Text = dtbl.Rows[0]["panCardNo"].ToString();

        // Emp_PanCard_Label.InnerHtml = dtbl.Rows[0]["panCardFileName"].ToString();
        //Emp_PanCard_Label.InnerHtml = dtbl.Rows[0]["panCardFileName"].ToString();
        //Emp_PanCard_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["panCardFileName"].ToString());

        // Emp_Resume_Label.InnerHtml = dtbl.Rows[0]["resumeFileName"].ToString();
        //Emp_Resume_Label.InnerHtml = dtbl.Rows[0]["resumeFileName"].ToString();
        //Emp_Resume_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["resumeFileName"].ToString());

        // Emp_Photo_Label.InnerHtml = dtbl.Rows[0]["photoFileName"].ToString();
        //Emp_Photo_Label.InnerHtml = dtbl.Rows[0]["photoFileName"].ToString();
        //Emp_Photo_Label.Attributes.Add("href", "~/FileUpload/" + dtbl.Rows[0]["photoFileName"].ToString());

        Emp_Reset.Enabled = false;
        Emp_Reset.Style.Add("opacity", "0.3");
        //Upload_Reset.Enabled = false;
        //Upload_Reset.Style.Add("opacity", "0.3");
        Button_Tab1Save.Text = "UPDATE <i class='fa fa-save'></i>";

        //Btn_Next.Enabled = true;
        //Btn_Next.Style.Add("color", "white");
        //Btn_Next.Style.Remove("opacity");


        RemoveNonEditableFieldsOfEmployee();
    }



    //protected void Ddl_EmployeeType_SelectedIndexChanged(object sender, EventArgs e)
    //{
        //if (HiddenField_Ddl_EmployeeType.Value == "1")
        //{

        //    if (Ddl_EmployeeType.SelectedItem.ToString() == "EXPERIENCED")
        //    {
        //        PreviousExperience.Visible = true;
        //        Txt_DateofJoining.Focus();
        //    }
        //    else
        //    {
        //        PreviousExperience.Visible = false;
        //        Txt_DateofJoining.Focus();
        //    }

        //    HiddenField_Ddl_EmployeeType.Value = "";
        //}
    //}
    protected void Check_Address_CheckedChanged(object sender, EventArgs e)
    {
        if (HiddenField_Check_Address.Value == "1")
        {
            if (Check_Address.Checked == true)
            {
                Txt_CurrentAddress.Text = Txt_PermanantAddress.Text;
                Ddl_Department.Focus();
            }
            else
            {
                Txt_CurrentAddress.Text = "";
                Txt_CurrentAddress.Focus();
            }

            HiddenField_Check_Address.Value = "";
        }
    }
    #region
    //protected void Radio_No2_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Radio_No2.Value == "1")
    //    {
    //        if (Ddl_EmployeeType.Text == "FRESHER")
    //        {
    //            if (Radio_No2.Checked == true)
    //            {
    //                MajorIllnessDescribe.Visible = false;
    //                //   Txt_PrevousCompanyName.Focus();
    //                Ddl_Department.Focus();
    //            }
    //            else
    //            {
    //                MajorIllnessDescribe.Visible = true;
    //                Txt_Describe.Focus();
    //            }
    //        }
    //        else
    //        {
    //            if (Radio_No2.Checked == true)
    //            {
    //                MajorIllnessDescribe.Visible = false;
    //                Txt_PrevousCompanyName.Focus();
    //                //Txt_JoiningDepartment.Focus();
    //            }
    //            else
    //            {
    //                MajorIllnessDescribe.Visible = true;
    //                Txt_Describe.Focus();
    //            }
    //        }

    //        HiddenField_Radio_No2.Value = "";
    //    }


    //}

    //protected void Radio_Yes2_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Radio_Yes2.Value == "1")
    //    {
    //        if (Ddl_EmployeeType.Text == "FRESHER")
    //        {
    //            if (Radio_Yes2.Checked == true)
    //            {
    //                MajorIllnessDescribe.Visible = true;
    //                Txt_Describe.Focus();
    //            }
    //            else
    //            {
    //                MajorIllnessDescribe.Visible = false;
    //                //   Txt_PrevousCompanyName.Focus();
    //                Ddl_Department.Focus();
    //            }
    //        }
    //        else
    //        {
    //            if (Radio_Yes2.Checked == true)
    //            {
    //                MajorIllnessDescribe.Visible = true;
    //                Txt_Describe.Focus();
    //            }
    //            else
    //            {
    //                MajorIllnessDescribe.Visible = false;
    //                Txt_PrevousCompanyName.Focus();
    //                // Txt_JoiningDepartment.Focus();
    //            }
    //        }

    //        HiddenField_Radio_Yes2.Value = "";
    //    }

    //}
    #endregion
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Search.Value == "1")
        {
            Search_EmployeeDetails_View.Visible = true;
            SearchData();


            HiddenField_Btn_Search.Value = "";
        }

    }
    public void SearchData(string sortExpression = null)
    {
        String empName = Ddl_SearchEmployeeName.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchEmployeeName.SelectedValue.ToString(); 
        String empType = Ddl_SearchEmployeeType.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchEmployeeType.SelectedItem.ToString();
        String empdepartment = Ddl_SearchDepartment.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchDepartment.SelectedValue.ToString();

        if ((empName != null) || (empType != null) || (empdepartment != null))
        {

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewEmployeeCreation", con);
            sqlda.SelectCommand.Parameters.AddWithValue("@userID", empName);
            sqlda.SelectCommand.Parameters.AddWithValue("@empType", empType);
            sqlda.SelectCommand.Parameters.AddWithValue("@department", empdepartment);
            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlda.Fill(dtbl);
            if (sortExpression != null)
            {
                DataView dv = dtbl.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewEmployeeCreation.DataSource = dv;
              //  GV_Export.DataSource = dv;
            }
            else
            {
                gridViewEmployeeCreation.DataSource = dtbl;
              //  GV_Export.DataSource = dtbl;
            }


            gridViewEmployeeCreation.DataBind();
          //  GV_Export.DataBind();
            con.Close();
        }
       
    }

    protected void gridViewEmployeeCreation_Sorting(object sender, GridViewSortEventArgs e)
    {
        displayDataInGridView(e.SortExpression);
    }
    protected void gridViewEmployeeCreation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewEmployeeCreation.PageIndex = e.NewPageIndex;
        SearchData();

    }
    //protected void Emp_PanCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    //{
    //    string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
    //    Emp_PanCard_Uploader.SaveAs(fileNameToUpload);
    //    fileName1 = e.FileName.ToString();
    //}

    //protected void Emp_AadhaarCard_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    //{
    //    string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
    //    Emp_AadhaarCard_Uploader.SaveAs(fileNameToUpload);
    //    fileName2 = e.FileName.ToString();
    //}

    //protected void Emp_Resume_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    //{
    //    string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
    //    Emp_Resume_Uploader.SaveAs(fileNameToUpload);
    //    fileName3 = e.FileName.ToString();
    //}

    //protected void Emp_Photo_Uploader_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    //{
    //    string fileNameToUpload = Server.MapPath("~/FileUpload/") + e.FileName.ToString();
    //    Emp_Photo_Uploader.SaveAs(fileNameToUpload);
    //    fileName4 = e.FileName.ToString();
    //}

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
        string FileName = "Employee_Details" + CurrentDateTime + ".xls";
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
    #region
    //protected void Txt_DurationTo_TextChanged(object sender, EventArgs e)
    //{
    //    if (HiddenField_Txt_DurationTo.Value == "1")
    //    {
    //        int Fyear, Fmonth, Fday, Tyear, Tmonth, Tday;

    //        String FromDate = Txt_Durationfrom.Text.Trim();
    //        string[] splitDate = FromDate.Split('-');
    //        String ToDate = Txt_DurationTo.Text.Trim();
    //        string[] splitDate1 = ToDate.Split('-');
    //        Fyear = Int32.Parse(splitDate[0]);
    //        Fmonth = Int32.Parse(splitDate[1]);
    //        Fday = Int32.Parse(splitDate[2]);
    //        Tyear = Int32.Parse(splitDate1[0]);
    //        Tmonth = Int32.Parse(splitDate1[1]);
    //        Tday = Int32.Parse(splitDate1[2]);

    //        if (Fyear <= Tyear)
    //        {
    //            if ((Fmonth <= Tmonth && Fyear <= Tyear) || (Fmonth >= Tmonth || Fmonth <= Tmonth) && Fyear < Tyear)
    //            {
    //                if ((Fday < Tday && Fmonth <= Tmonth && Fyear <= Tyear) || ((Fday >= Tday || Fday <= Tday) && Fmonth < Tmonth && Fyear <= Tyear) || ((Fday >= Tday || Fday <= Tday) && (Fmonth <= Tmonth || Fmonth >= Tmonth) && Fyear < Tyear))
    //                {
    //                    Txt_PrevDesgination.Focus();
    //                }
    //                else
    //                {
    //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
    //                    Txt_DurationTo.Text = "";
    //                    Txt_DurationTo.Focus();
    //                }
    //            }
    //            else
    //            {
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
    //                Txt_DurationTo.Text = "";
    //                Txt_DurationTo.Focus();
    //            }
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter To Date Greater Than From Date');", true);
    //            Txt_DurationTo.Text = "";
    //            Txt_DurationTo.Focus();
    //        }
    //    }

    //    HiddenField_Txt_DurationTo.Value = "";
    //}
    #endregion
    public void fillEmployeeBelongToBranch()
    {
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);
        CheckBoxList_EmpBelongToBranch.DataSource = dt;
        CheckBoxList_EmpBelongToBranch.DataTextField = "branchName";
        CheckBoxList_EmpBelongToBranch.DataValueField = "branchID";
        CheckBoxList_EmpBelongToBranch.DataBind();
        con.Close();
    }
    protected void LinkButton_Search_EmpBelongToBranch_Click(object sender, EventArgs e)
    {
        if (HiddenField_LinkButton_Search_EmpBelongToBranch.Value == "1")
        {
            Txt_Search_EmpBelongToBranch.Text = "";
            Txt_EmpBelongToBranch.Text = "";
            int c = 0;
            for (int i = 0; i < CheckBoxList_EmpBelongToBranch.Items.Count; i++)
            {
                if (CheckBoxList_EmpBelongToBranch.Items[i].Selected)
                {
                    c++;
                }
            }
            if (Txt_EmpBelongToBranch.Text != "")
            {
                for (int i = 0; i < CheckBoxList_EmpBelongToBranch.Items.Count; i++)
                {
                    if (CheckBoxList_EmpBelongToBranch.Items[i].Selected)
                    {
                        Txt_EmpBelongToBranch.Text += CheckBoxList_EmpBelongToBranch.Items[i].Text + ",";
                    }
                }
                List<String> value = new List<string>();
                value = Txt_EmpBelongToBranch.Text.Split(',').ToList();
                for (int i = 0; i < value.Count(); i++)
                {
                    ListItem item = CheckBoxList_EmpBelongToBranch.Items.FindByText(value[i]);
                    if (value[i] == "")
                    {
                        continue;
                    }
                    else if (item == null)
                    {
                        continue;
                    }
                    else if (CheckBoxList_EmpBelongToBranch.Items.FindByText(value[i]).Selected == false)
                    {
                        value.RemoveAt(i);
                    }
                }

                SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
                sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                CheckBoxList_EmpBelongToBranch.DataSource = dt;
                CheckBoxList_EmpBelongToBranch.DataTextField = "branchName";
                CheckBoxList_EmpBelongToBranch.DataValueField = "branchID";
                CheckBoxList_EmpBelongToBranch.DataBind();
                //  bd.CheckboxlistBindDropdownDoubleParameter(CheckBoxList__State, "spBindDropdownListORAuto", "@Event", "State_Dropdown", "@SDC", "", "Delivery State", "Delivery State");
                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_EmpBelongToBranch.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_EmpBelongToBranch.Items[j].Text)
                        {
                            CheckBoxList_EmpBelongToBranch.Items[j].Selected = true;
                        }
                    }
                }
                Txt_EmpBelongToBranch.Text = "";
                for (int i = 0; i < CheckBoxList_EmpBelongToBranch.Items.Count; i++)
                {
                    if (CheckBoxList_EmpBelongToBranch.Items[i].Selected)
                    {
                        Txt_EmpBelongToBranch.Text += CheckBoxList_EmpBelongToBranch.Items[i].Value + ",";
                    }
                }

            }
            else
            {
                for (int i = 0; i < CheckBoxList_EmpBelongToBranch.Items.Count; i++)
                {
                    if (CheckBoxList_EmpBelongToBranch.Items[i].Selected)
                    {
                        Txt_EmpBelongToBranch.Text += CheckBoxList_EmpBelongToBranch.Items[i].Text + ",";
                    }
                }

                SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
                sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                CheckBoxList_EmpBelongToBranch.DataSource = dt;
                CheckBoxList_EmpBelongToBranch.DataTextField = "branchName";
                CheckBoxList_EmpBelongToBranch.DataValueField = "branchID";
                CheckBoxList_EmpBelongToBranch.DataBind();
                //  bd.CheckboxlistBindDropdownDoubleParameter(CheckBoxList__State, "spBindDropdownListORAuto", "@Event", "State_Dropdown", "@SDC", "", "Delivery State", "Delivery State");
                List<String> value = new List<string>();
                value = Txt_EmpBelongToBranch.Text.Split(',').ToList();
                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_EmpBelongToBranch.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_EmpBelongToBranch.Items[j].Text)
                        {
                            CheckBoxList_EmpBelongToBranch.Items[j].Selected = true;
                        }
                    }
                }
            }

            Txt_EmpBelongToBranch.ToolTip = Txt_EmpBelongToBranch.Text;

            HiddenField_LinkButton_Search_EmpBelongToBranch.Value = "";
        }

    }

    protected void Txt_Search_EmpBelongToBranch_TextChanged(object sender, EventArgs e)
    {
        if (HiddenField_Txt_Search_EmpBelongToBranch.Value == "1")
        {
            string[] value = Txt_EmpBelongToBranch.Text.Split(',');
            if (Txt_Search_EmpBelongToBranch.Text != "")
            {
                string search = Txt_Search_EmpBelongToBranch.Text;
                string searchTxt = "Select branchID,branchName from tblBranchCreation where status='ACTIVE' AND branchName LIKE '%" + search + "%' order by branchName ASC";
                SqlDataAdapter sqlda = new SqlDataAdapter(searchTxt, con);
                sqlda.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                CheckBoxList_EmpBelongToBranch.DataSource = dt;
                CheckBoxList_EmpBelongToBranch.DataTextField = "branchName";
                CheckBoxList_EmpBelongToBranch.DataValueField = "branchID";

                CheckBoxList_EmpBelongToBranch.DataBind();
                //Txt_State_Search.Focus();

                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_EmpBelongToBranch.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_EmpBelongToBranch.Items[j].Text)
                        {
                            CheckBoxList_EmpBelongToBranch.Items[j].Selected = true;
                        }
                    }
                }
            }
            else if (Txt_Search_EmpBelongToBranch.Text == "")
            {
                SqlDataAdapter sqlda = new SqlDataAdapter("ssp_GetBranchList", con);
                sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                sqlda.Fill(dt);
                CheckBoxList_EmpBelongToBranch.DataSource = dt;
                CheckBoxList_EmpBelongToBranch.DataTextField = "branchName";
                CheckBoxList_EmpBelongToBranch.DataValueField = "branchID";
                CheckBoxList_EmpBelongToBranch.DataBind();
                //Txt_State_Search.Focus();

                for (int i = 0; i < value.Count(); i++)
                {
                    for (int j = 0; j < CheckBoxList_EmpBelongToBranch.Items.Count; j++)
                    {
                        if (value[i] == CheckBoxList_EmpBelongToBranch.Items[j].Text)
                        {
                            CheckBoxList_EmpBelongToBranch.Items[j].Selected = true;
                        }
                    }
                }
            }

            HiddenField_Txt_Search_EmpBelongToBranch.Value = "";
        }
    }
}