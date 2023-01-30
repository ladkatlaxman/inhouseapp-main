using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    SqlCommand cmd = null;
    SqlDataReader dr = null;
 
    protected void Page_Load(object sender, EventArgs e)
    {
    /*lblError.Text = "Application under Downtime. Please check Later.";
    lblError.ForeColor = System.Drawing.Color.Red;
    lblError.Font.Bold = true; */
        Txt_UserName.Focus();
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
                Server.Transfer("Dashboard.aspx");
                //Response.Redirect("~/Dashboard.aspx");
            }
        }
    }
    protected void loginbtn_ServerClick(object sender, EventArgs e)
    {
        if(Txt_UserName.Value == "")
        {
            lblError.Text = "Please provide your User Name.";
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Font.Bold = true;
            return; 
        }
        if (Txt_Password.Value == "")
        {
            lblError.Text = "Please provide your Password.";
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Font.Bold = true;
            return;
        }

        try
        {
            con.Open();

            cmd = new SqlCommand("ssp_SessionData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", Txt_UserName.Value.Trim());
            cmd.Parameters.AddWithValue("@password", Txt_Password.Value.Trim());

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            int i = cmd.ExecuteNonQuery();
            con.Close();

            if (dt.Rows.Count > 0)
            {
                Session["userID"] = dt.Rows[0]["userID"].ToString();
                Session["username"] = dt.Rows[0]["username"].ToString();
                Session["BranchId"] = dt.Rows[0]["BranchId"].ToString();
                Session["userBranch"] = dt.Rows[0]["belongToBranch"].ToString();
                //Response.Redirect("~/Dashboard.aspx");
                Server.Transfer("Dashboard.aspx");
            }
            else
            {
                lblError.Text = "Wrong username and password";
                lblError.ForeColor = System.Drawing.Color.Red;
                Txt_UserName.Value = "";
                Txt_Password.Value = "";
                Txt_UserName.Focus();
            }
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message;

            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Font.Bold = true; 
        } 
    } 
}