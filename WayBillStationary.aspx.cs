using BLFunctions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class WayBillStationary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                gvFirstGrid.DataSource = (new PickReqFunctions()).getStationary(HttpContext.Current.Session["BranchId"].ToString());
                gvFirstGrid.DataBind();
            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        try
        {
            string fromWaybillNo = Txt_FromNumber.Text;
            string toWaybillNo = Txt_ToNumber.Text;
            string nextNumber = (Convert.ToInt32(fromWaybillNo) + 49).ToString();
            if (Txt_FromNumber.Text == "")
            {
                Lbl_Note.Text = "Please provide Starting No.";
                return;
            }
            if (Txt_ToNumber.Text == "")
            {
                Lbl_Note.Text = "Please provide Ending No.";
                return;
            }
            if (Txt_ToNumber.Text != nextNumber)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please provide 50 Range of Waybill Series');", true);
                return;
            }
            bool alert= new CommFunctions().addStationary(Convert.ToInt32(HttpContext.Current.Session["BranchId"].ToString()), Convert.ToInt32(Txt_FromNumber.Text), Convert.ToInt32(Txt_ToNumber.Text), (new CFunctions()).CurrentDateTime());
            if(alert)
            {
                Txt_FromNumber.Text = "";
                Txt_ToNumber.Text = "";               
                string a = "Button_Submit1";
                string b = "SAVE";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
            }           
        } 
        catch (Exception ex) 
        { 
            Lbl_Note.Text = ex.Message; 
        }
        Page_Load(sender, e); 
    }
}