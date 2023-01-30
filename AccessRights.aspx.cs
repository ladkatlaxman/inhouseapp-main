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
using CommonLibrary;


public partial class AccessRights : System.Web.UI.Page
{   
    SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    int s = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            fillGridView();
            fillGridView1();
            fillGridViewForm();
            DataFillForAssignClass();
            DataFillForModifyClass();
            ListAccessClass.Visible = false;
        }
        Ddl_Username.Enabled = true;
        txtAccessClassName.Enabled = true;

    }
    //Code For Add/Edit Access Class
    protected void Btn_Save_Click(object sender, EventArgs e)
    {
        if (txtAccessClassName.Text == "")
        {
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Enter Access Class Name')", true);
            Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('Enter Access Class Name');return false;}</script>");
        }
        else if (Ddl_Status.SelectedValue.ToString() == "SELECT")
        {
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Select Status')", true);
            Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('Select Status');return false;}</script>");
        }
        else
        {
            if (globalVar.status == 0)
            {
                if (sqlcon.State == ConnectionState.Closed)
                    sqlcon.Open();
                String str = "Select access_class_name from AccessClass";
                SqlCommand cmd = new SqlCommand(str, sqlcon);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    if (txtAccessClassName.Text.ToString() == reader["access_class_name"].ToString())
                    {
                        s = 1;
                        //Response.Write("<script type='text/javascript'>alert('Name already exist'); </Script>");
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Name already exist')", true);
                        txtAccessClassName.Text = "";
                        txtAccessClassName.Focus();
                        break;
                    }
                }
                reader.Close();
                if (s == 0)
                {
                    SqlCommand cmd1 = new SqlCommand("AccessClassCreateOrUpdate", sqlcon);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@access_class_ID", (hfAccessID.Value == "" ? 0 : Convert.ToInt32(hfAccessID.Value)));
                    cmd1.Parameters.AddWithValue("@access_class_name", txtAccessClassName.Text.Trim());
                    cmd1.Parameters.AddWithValue("@status", Ddl_Status.Text.Trim());
                    cmd1.ExecuteNonQuery();
                    sqlcon.Close();
                    String AccessID = hfAccessID.Value;
                    clear();
                    if (AccessID == "")
                        lblSuccessMessage.Text = "Saved Successfully";
                    else
                        lblSuccessMessage.Text = "Updated Successfully";

                    fillGridView();
                    DataFillForAssignClass();
                }
                else
                    s = 0;
            }
            else
            {
                sqlcon.Open();
                SqlCommand cmd = new SqlCommand("AccessClassCreateOrUpdate", sqlcon);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@access_class_ID", (hfAccessID.Value == "" ? 0 : Convert.ToInt32(hfAccessID.Value)));
                cmd.Parameters.AddWithValue("@access_class_name", txtAccessClassName.Text.Trim());
                cmd.Parameters.AddWithValue("@status", Ddl_Status.Text.Trim());
                cmd.ExecuteNonQuery();
                sqlcon.Close();
                String AccessID = hfAccessID.Value;
                clear();
                if (AccessID == "")
                    lblSuccessMessage.Text = "Saved Successfully";
                else
                    lblSuccessMessage.Text = "Updated Successfully";



                //status = 0;
                globalVar.setStatus(0);
                fillGridView();
                DataFillForAssignClass();
            }
        }


    }
    protected void Btn_Reset_AccessClass_Click(object sender, EventArgs e)
    {
        clear();
    }
    public void clear()
    {
        txtAccessClassName.Text = "";
        Ddl_Status.Text = "";
        Btn_Save.Text = "Save";
        lblSuccessMessage.Text = lblErrorMessage.Text = "";

    }
    void fillGridView()
    {
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("AccessClassViewAll", sqlcon);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        sqlcon.Close();
        GridView1.DataSource = dtbl;
        GridView1.DataBind();
    }
    protected void lnk_onClick(object Sender, EventArgs e)
    {
        int access_class_ID = Convert.ToInt32((Sender as LinkButton).CommandArgument);
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("AccessClassViewByID", sqlcon);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@access_class_ID", access_class_ID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        sqlcon.Close();

        hfAccessID.Value = access_class_ID.ToString();
        txtAccessClassName.Text = dtbl.Rows[0]["access_class_name"].ToString();
        Ddl_Status.Text = dtbl.Rows[0]["status"].ToString();
        txtAccessClassName.Enabled = false;
        Btn_Reset_AccessClass.Visible = false;
        Btn_Save.Text = "Update";
        globalVar.setStatus(1);

        //status += 1;


    }
    //Code For Assign Class
    protected void DataFillForAssignClass()
    {
        SqlCommand cmd = new SqlCommand("Select access_class_ID, access_class_name from AccessClass", sqlcon);
        sqlcon.Open();
        Ddl_AccessClass.DataSource = cmd.ExecuteReader();
        Ddl_AccessClass.DataBind();
        Ddl_AccessClass.Items.Insert(0, "select");
        sqlcon.Close();

        SqlCommand cmd1 = new SqlCommand("Select userID,username from tblEmpLogin", sqlcon);
        sqlcon.Open();
        Ddl_Username.DataSource = cmd1.ExecuteReader();
        Ddl_Username.DataBind();
        Ddl_Username.Items.Insert(0, "select");
        sqlcon.Close();
    }
    protected void btn_AssignClass_Click(object sender, EventArgs e)
    {
        if (Ddl_Username.SelectedValue.ToString() == "select")
        {
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Select User Name')", true);
            Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('Enter Access Class Name');return false;}</script>");
        }
        else if (Ddl_AccessClass.SelectedValue.ToString() == "select")
        {
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('Select Access Class Name')", true);
            Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('Enter Access Class Name');return false;}</script>");
        }
        else
        {
            if (globalVar.status == 0)
            {
               
                sqlcon.Open();
                String str = "Select * from AssignClass where userID=(Select userID from tblEmpLogin where username='" + Ddl_Username.SelectedItem.ToString() + "')";
                SqlCommand cmd2 = new SqlCommand(str, sqlcon);
                SqlDataReader reader1 = cmd2.ExecuteReader();
                while (reader1.Read())
                {

                    s = 1;
                    //Response.Write("<script type='text/javascript'>alert('User already Assigned. You Can Edit Class By Using Edit Section..'); </Script>");
                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Error", "alert('User already Assigned. You Can Edit Class By Using Edit Section..')", true);
                    Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('User already Assigned. You Can Edit Class By Using Edit Section..');return false;}</script>");
                    Ddl_Username.SelectedValue = "select";
                    Ddl_Username.Focus();
                    break;

                }
                reader1.Close();
                if (s == 0)
                {
                    if (sqlcon.State == ConnectionState.Closed)
                        sqlcon.Open();
                    SqlCommand cmd = new SqlCommand("AssignClassCreateOrUpdate", sqlcon);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", (hfAssignID.Value == "" ? 0 : Convert.ToInt32(hfAssignID.Value)));
                    cmd.Parameters.AddWithValue("@userID", Ddl_Username.Text.Trim());
                    cmd.Parameters.AddWithValue("@access_class_ID", Ddl_AccessClass.Text.Trim());
                    cmd.ExecuteNonQuery();
                    sqlcon.Close();
                    String AssignID = hfAssignID.Value;
                    clear();
                    if (AssignID == "")
                        lblSuccessMessage1.Text = "Saved Successfully";
                    else
                        lblSuccessMessage1.Text = "Updated Successfully";

                    fillGridView1();
                    DataFillForAssignClass();

                }
                else

                    s = 0;
            }
            else
            {

                sqlcon.Open();
                SqlCommand cmd = new SqlCommand("AssignClassCreateOrUpdate", sqlcon);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", (hfAssignID.Value == "" ? 0 : Convert.ToInt32(hfAssignID.Value)));
                cmd.Parameters.AddWithValue("@userID", Ddl_Username.Text.Trim());
                cmd.Parameters.AddWithValue("@access_class_ID", Ddl_AccessClass.Text.Trim());
                cmd.ExecuteNonQuery();
                sqlcon.Close();
                String AssignID = hfAssignID.Value;
                clear();
                if (AssignID == "")
                    lblSuccessMessage1.Text = "Saved Successfully";
                else
                    lblSuccessMessage1.Text = "Updated Successfully";

                globalVar.setStatus(0);
                fillGridView1();
                DataFillForAssignClass();
            }
        }

    }

    void fillGridView1()
    {
        SqlDataAdapter sqlda = new SqlDataAdapter("AssignclassViewAll", sqlcon);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        Grv_AssignClass.DataSource = dtbl;
        Grv_AssignClass.DataBind();
        sqlcon.Close();
    }
    protected void lnk1_onClick(object Sender, EventArgs e)
    {


        int ID = Convert.ToInt32((Sender as LinkButton).CommandArgument);
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("AssignClassViewByID", sqlcon);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sqlda.SelectCommand.Parameters.AddWithValue("@ID", ID);
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        sqlcon.Close();
        hfAssignID.Value = ID.ToString();
        Ddl_Username.Text = dtbl.Rows[0]["userID"].ToString();
        Ddl_AccessClass.Text = dtbl.Rows[0]["access_class_ID"].ToString();
        btn_AssignClass.Text = "Update";
        Ddl_Username.Enabled = false;

        //Ddl_Username.Focus();
        globalVar.setStatus(1);


    }
    //Code For Modify Access Class
    protected void DataFillForModifyClass()
    {
        SqlCommand cmd2 = new SqlCommand("Select access_class_ID, access_class_name from AccessClass", sqlcon);
        sqlcon.Open();
        Ddl_AccessName.DataSource = cmd2.ExecuteReader();
        Ddl_AccessName.DataBind();
        Ddl_AccessName.Items.Insert(0, "select");
        sqlcon.Close();
    }
    void fillGridViewForm()
    {
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlDataAdapter sqlda = new SqlDataAdapter("spFormTableView", sqlcon);
        sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dtbl = new DataTable();
        sqlda.Fill(dtbl);
        Grid_ModifyAccessClass.DataSource = dtbl;
        Grid_ModifyAccessClass.DataBind();
        sqlcon.Close();
    }

    protected void Btn_ChangeAccess_Click(object sender, EventArgs e)
    {
        fillGridViewForm();
       
        sqlcon.Open();
        int classid = 0;
        String str = "select access_class_name,status from AccessClass where access_class_ID=" + Ddl_AccessName.SelectedValue.ToString();
        SqlCommand com = new SqlCommand(str, sqlcon);
        SqlDataReader reader = com.ExecuteReader();
        if (reader.Read())
        {
            lblClassName.Text = reader["access_class_name"].ToString().ToUpper();
            lblStatus.Text = reader["status"].ToString().ToUpper();
            reader.Close();
        }


        classid = Convert.ToInt32(Ddl_AccessName.SelectedValue.ToString());
        string query = "select FormTable_ID from FormAssignTable where  access_class_ID=" + classid;
        com = new SqlCommand(query, sqlcon);
        reader = com.ExecuteReader();
        while (reader.Read())

        {
            foreach (GridViewRow row in Grid_ModifyAccessClass.Rows)
            {
                if (Convert.ToInt32(row.Cells[0].Text) == Convert.ToInt32(reader["FormTable_ID"].ToString()))
                {
                    CheckBox status = (row.Cells[3].FindControl("CheckBox1") as CheckBox);
                    status.Checked = true;
                }
            }
        }
        reader.Close();
        ListAccessClass.Visible = true;
    }


    protected void Btn_UpdateTableList1_Click(object sender, EventArgs e)
    {
        
        sqlcon.Open();
        SqlCommand com;
        SqlDataReader reader;
        int i = 0;

        int[] formTableIdsInDatabase = new int[100];
        int[] formTableIdsInGridview = new int[100];
        int formTableIdsInDatabaseCount = 0;
        int formTableIdsInGridviewCount = 0;
        String query1 = String.Empty;

        int classid = Convert.ToInt32(Ddl_AccessName.SelectedValue.ToString());

        query1 = "select access_class_ID,FormTable_ID from FormAssignTable where access_class_ID=" + classid;
        com = new SqlCommand(query1, sqlcon);
        reader = com.ExecuteReader();
        while (reader.Read())
        {
            formTableIdsInDatabase[i] = Convert.ToInt32(reader["FormTable_ID"].ToString());
            i++;
            formTableIdsInDatabaseCount++;

        }
        sqlcon.Close();

        sqlcon.Open();
        int j = 0, k;

        foreach (GridViewRow row in Grid_ModifyAccessClass.Rows)
        {
            CheckBox status = (row.Cells[3].FindControl("CheckBox1") as CheckBox);
            int id = Convert.ToInt32(row.Cells[0].Text);
            if (status.Checked)
            {
                formTableIdsInGridview[j] = id;
                formTableIdsInGridviewCount++;
                j++;
            }

        }

        String queryTemp = String.Empty;

        //insertion in new table
        for (k = 0; k < formTableIdsInGridview.Length; k++)
        {
            if (!(formTableIdsInDatabase.Contains(formTableIdsInGridview[k])))
            {
                queryTemp = "insert into FormAssignTable(access_class_ID,FormTable_ID) values(" + classid + "," + formTableIdsInGridview[k] + ")";
                com = new SqlCommand(queryTemp, sqlcon);
                com.ExecuteNonQuery();

            }
            // LblUpdate.Text = "Updated Successfully";
            Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('Updated Successfully');return false;}</script>");
        }

        //for deleting records from table

        for (k = 0; k < formTableIdsInDatabaseCount; k++)
        {
            if (!(formTableIdsInGridview.Contains(formTableIdsInDatabase[k])))
            {
                queryTemp = "delete from FormAssignTable where access_class_ID=" + classid + " and FormTable_ID=" + formTableIdsInDatabase[k];
                com = new SqlCommand(queryTemp, sqlcon);
                com.ExecuteNonQuery();
            }
        }




    }
}