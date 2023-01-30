using System;
using System.Data;
using BLFunctions;
using System.Web.UI;

public partial class ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
              
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }

    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        IDataReader reader = (new CommFunctions().GetUserPassword(Convert.ToInt32(Session["userID"].ToString())));
        while (reader.Read())
        {
            string password = reader["password"].ToString();
            if(Txt_EmpCurrentPassword.Text.ToString()==password)
            {
                int userid = Convert.ToInt32(Session["userID"].ToString());
                string pass = Txt_EmpChangePassword.Text.ToString();
                bool alert = (new CommFunctions().SavePassword(userid,pass));
                if(alert)
                {
                    (new CFunctions()).showalert("Button_Submit1", "PASSWORD", this);
                    Txt_EmpCurrentPassword.Text = "";
                    Txt_EmpChangePassword.Text = "";
                    Txt_EmpConfirmPassword.Text = "";
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Enter Correct Password.')", true);
            }
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
}