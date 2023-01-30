using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using BLFunctions;
using BLProperties;

public partial class EmployeeLogin : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    SqlDataAdapter sqlda;
    string strcmd = string.Empty;
    int checkDuplicate = 0;
    public static int UserID;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            CFunctions.setTabStatus(0);
          
            DatafillForEmployeeName();
            DataFillForSearchEmployee();         
            Search_EmployeeLogin_View.Visible = false;
            con.Open();

            DataTable dt = this.GetData("SELECT AccessMenuId, AccessMenuName FROM tblAccessMenu");
            this.PopulateTreeView(dt, 0, null);

            new CFunctions().dropdwnlist(null, null, Ddl_AccessPage, null, "AccessName", "accessID", (new MasterFormFunctions().GetAccessMenu()));
            new CFunctions().dropdwnlist(null, null, Ddl_AccessBranch, null, "branchName", "branchId", (new CommFunctions().GetBranch()));

        }
           
    }
    private void PopulateTreeView(DataTable dtParent, int parentId, TreeNode treeNode)
    {
        foreach (DataRow row in dtParent.Rows)
        {
            TreeNode child = new TreeNode
            {
                Text = row["AccessMenuName"].ToString(),
                Value = row["AccessMenuId"].ToString()
            };
            if (parentId == 0)
            {
                treeViewAccessPage.Nodes.Add(child);
                DataTable dtChild = this.GetData("SELECT AccessId As AccessMenuId, AccessName As AccessMenuName FROM tblAccess WHERE AccessMenuId = " + child.Value);
                PopulateTreeView(dtChild, int.Parse(child.Value), child);
            }
            else
            {
                treeNode.ChildNodes.Add(child);
            }
        }
    }

    private DataTable GetData(string query)
    {
        DataTable dt = new DataTable();
        string constr = ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    sda.Fill(dt);
                }
            }
            return dt;
        }
    }
    public void DatafillForEmployeeName()
    {
        con.Open();
        sqlda = new SqlDataAdapter("ssp_GetEmployeeList", con);
        sqlda.SelectCommand.Parameters.AddWithValue("@DepartmentName", null);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        sqlda.Fill(dt);
        Ddl_EmployeeName.DataSource = dt;
        Ddl_EmployeeName.DataTextField = "fullName";
        Ddl_EmployeeName.DataValueField = "userID";
        Ddl_EmployeeName.DataBind();
        Ddl_EmployeeName.Items.Insert(0, "SELECT");


        Ddl_UserName.DataSource = dt;
        Ddl_UserName.DataTextField = "fullName";
        Ddl_UserName.DataValueField = "userID";
        Ddl_UserName.DataBind();
        Ddl_UserName.Items.Insert(0, "SELECT");
        con.Close();

        Ddl_EmpBranch.DataSource = dt;
        Ddl_EmpBranch.DataTextField = "fullName";
        Ddl_EmpBranch.DataValueField = "userID";
        Ddl_EmpBranch.DataBind();
        Ddl_EmpBranch.Items.Insert(0, "SELECT");
        con.Close();

    }
    public void DataFillForSearchEmployee()
    {
        con.Open();
        sqlda = new SqlDataAdapter("ssp_GetEmployeeList", con);
        sqlda.SelectCommand.Parameters.AddWithValue("@DepartmentName", null);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt1 = new DataTable();
        sqlda.Fill(dt1);
        Ddl_SearchEmployeeName.DataSource = dt1;
        Ddl_SearchEmployeeName.DataTextField = "fullName";
        Ddl_SearchEmployeeName.DataValueField = "userID";
        Ddl_SearchEmployeeName.DataBind();
        Ddl_SearchEmployeeName.Items.Insert(0, "SELECT");
        con.Close();
    }
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
  
    protected void Btn_LoginDetailsSave_Click(object sender, EventArgs e)
    { 
        if (CFunctions.tabstatus == 0)
        {
            con.Open();
            String str = "Select username from tblEmpLogin";
            cmd = new SqlCommand(str, con);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                if (Txt_EmpUserName.Text.ToString() == reader["username"].ToString())
                {
                    checkDuplicate = 1;
                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('This username already exist')", true);
                    Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('This username already exist');return false;}</script>");
                    Txt_EmpUserName.Text = "";
                    Txt_EmpUserName.Focus();
                    break;
                }
            }
            reader.Close();
            con.Close();
            if (checkDuplicate == 0)
            {
                con.Open();
                cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeLogin", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@check", CFunctions.tabstatus);
                cmd.Parameters.AddWithValue("@userId", Ddl_EmployeeName.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@username", Txt_EmpUserName.Text.Trim().ToString());
                cmd.Parameters.AddWithValue("@password", Txt_EmpPassword.Text.Trim().ToString());

                CFunctions.setTabStatus(0);
                cmd.ExecuteNonQuery();

                // FORMS ACCESS ENTRY
                foreach (TreeNode node in treeViewAccessPage.CheckedNodes)
                {
                    cmd = new SqlCommand("ssp_UserAccess", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", Int32.Parse(Ddl_EmployeeName.SelectedValue.ToString()));
                    cmd.Parameters.AddWithValue("@AccessId", Int32.Parse(node.Value.ToString()));
                    cmd.ExecuteNonQuery();
                }
                con.Close();
                Ddl_EmployeeName.SelectedIndex = 0;
                Txt_EmpUserName.Text = "";
                Txt_EmpPassword.Text = "";
                Txt_EmpConfirmPassword.Text = "";
            }
            else
                checkDuplicate = 0;
        }
        else if (CFunctions.tabstatus == 1)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ssp_CreateOrUpdateEmployeeLogin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@check", CFunctions.tabstatus);
            cmd.Parameters.AddWithValue("@userId", UserID);
            cmd.Parameters.AddWithValue("@username", Txt_EmpUserName.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@password", Txt_EmpPassword.Text.Trim().ToString());
            cmd.ExecuteNonQuery();
            con.Close();
            Btn_LoginDetailsSave.Text = "SAVE <i class='fa fa-save'></i>";

            Ddl_EmployeeName.Enabled = true;
            Ddl_EmployeeName.SelectedIndex = 0;
            Txt_EmpUserName.Text = "";
            Txt_EmpPassword.Text = "";
            Txt_EmpConfirmPassword.Text = "";
           
        }
        CFunctions.setTabStatus(0);
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void editEmployeeLogin_Click(object sender, EventArgs e)
    {
        string userID = (sender as LinkButton).CommandArgument;
        UserID = Convert.ToInt32(userID);
        con.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("ssp_CreateInactiveUser", con);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@userID", UserID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        con.Close();
        DataFillForSearchEmployee();
        Ddl_SearchEmployeeName.SelectedIndex = 0;
        Search_EmployeeLogin_View.Visible = false;       
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
          SearchData();
          Search_EmployeeLogin_View.Visible = true; 
    }
    public void SearchData(string sortExpression = null)
    {
        String userID = Ddl_SearchEmployeeName.SelectedValue.ToString();
       
        if ((Ddl_SearchEmployeeName.SelectedItem.ToString() != "SELECT"))
        {
            con.Open();

            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewEmployeeLogin", con);
            sqlda.SelectCommand.Parameters.AddWithValue("@userID", userID);
            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlda.Fill(dtbl);
            if (sortExpression != null)
            {
                DataView dv = dtbl.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewEmployeeLogin.DataSource = dv;
            }
            else
            {
                gridViewEmployeeLogin.DataSource = dtbl;
            }
            gridViewEmployeeLogin.DataBind();
            con.Close();
        }     
    }

    protected void gridViewEmployeeLogin_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewEmployeeLogin.PageIndex = e.NewPageIndex;
        SearchData();
    }

    protected void gridViewEmployeeLogin_Sorting(object sender, GridViewSortEventArgs e)
    {
        SearchData(e.SortExpression);
    }

    protected void Btn_ViewAccess_Click(object sender, EventArgs e)
    {
       if( Ddl_UserName.SelectedIndex != 0)
        {           
            GV_UserAccessDetails.DataSource = new MasterFormFunctions().ViewUserAccess(Convert.ToInt32(Ddl_UserName.SelectedValue));
            GV_UserAccessDetails.DataBind();
        }
    }

    protected void Btn_AddAccess_Click(object sender, EventArgs e)
    {
        if (Ddl_UserName.SelectedIndex != 0)
        {
            if (Ddl_AccessPage.SelectedIndex != 0)
            {
                UserAccess access = new UserAccess();
                access.userID = Convert.ToInt32(Ddl_UserName.SelectedValue);
                access.accessID = Convert.ToInt32(Ddl_AccessPage.SelectedValue);
                bool alertMsg = (new MasterFormFunctions()).SaveUserAccess(access);
                if (alertMsg)
                    (new CFunctions()).showalert("Button_Tab1Save", "ADD", this);

                Btn_ViewAccess_Click(sender, e);
            }
        }
    }  

    protected void GV_UserAccessDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GV_UserAccessDetails.Rows[rowIndex];
            UserAccess access = new UserAccess();
            access.userID = Convert.ToInt32(row.Cells[1].Text);
            access.accessID = Convert.ToInt32(row.Cells[2].Text);
            bool alertMsg = (new MasterFormFunctions()).RemoveUserAccess(access);
            if (alertMsg)
              (new CFunctions()).showalert("Delete_Data1", "DELETE", this);

            Btn_ViewAccess_Click(sender, e);
        }
    }  
    protected void Btn_ViewBranch_Click(object sender, EventArgs e)
    {
        if (Ddl_EmpBranch.SelectedIndex != 0)
        {
            GV_BranchAccess.DataSource = new MasterFormFunctions().ViewBranchAccess(Convert.ToInt32(Ddl_EmpBranch.SelectedValue));
            GV_BranchAccess.DataBind();
        }
    }

    protected void Btn_AddBranch_Click(object sender, EventArgs e)
    {
        if (Ddl_EmpBranch.SelectedIndex != 0)
        {
            if (Ddl_AccessBranch.SelectedIndex != 0)
            {
                UserAccess access = new UserAccess();
                access.userID = Convert.ToInt32(Ddl_EmpBranch.SelectedValue);
                access.branchID = Convert.ToInt32(Ddl_AccessBranch.SelectedValue);
                bool alertMsg = (new MasterFormFunctions()).SaveBranchAccess(access);
                if (alertMsg)
                    (new CFunctions()).showalert("Button_Tab1Save", "ADD", this);

                Btn_ViewBranch_Click(sender, e);
            }
        }
    }
    protected void GV_BranchAccess_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GV_BranchAccess.Rows[rowIndex];
            UserAccess access = new UserAccess();
            access.userID = Convert.ToInt32(row.Cells[1].Text);
            access.branchID = Convert.ToInt32(row.Cells[2].Text);
            bool alertMsg = (new MasterFormFunctions()).RemoveBranchAccess(access);
            if (alertMsg)
                (new CFunctions()).showalert("Delete_Data1", "DELETE", this);

            Btn_ViewBranch_Click(sender, e);
        }
    }

}