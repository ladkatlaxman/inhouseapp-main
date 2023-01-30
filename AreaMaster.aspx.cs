using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AreaMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
            }
            else
            {
                Response.Redirect("Login.aspx");
            }         
        }

        (new CFunctions()).GetJavascriptFunction(this, "Txt_Pincode", "hfPincode", "Party_CustomerCreation.aspx/getPincode", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        FullAddress fd = new FullAddress();    
        fd.Pincode = Convert.ToInt32(hfPincode.Value);
        fd.Area = Txt_Area.Text.ToString().ToUpper();
        bool alertMsg = (new CommFunctions()).SaveArea(fd);
        if (alertMsg)
        {
            (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
            Txt_Pincode.Text = "";
            hfPincode.Value = "";
            Txt_State.Text = "AUTO";
            Txt_District.Text = "AUTO";
            Txt_City.Text = "AUTO";
            Txt_Area.Text = "";         
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
}