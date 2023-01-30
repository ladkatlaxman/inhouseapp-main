using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CancelledWaybill : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {

            }
            else
                Response.Redirect("Login.aspx");          
        }
    }
    private void clearFileUpload()
    {
        FileUpload.Dispose();
    }
    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        bool alert = new PickReqFunctions().SaveCancelledWaybill(Txt_WaybillNo.Text.ToString(), Txt_Remark.Text.ToString().ToUpper());
        if (FileUpload.HasFile)
        {
            string ext = Path.GetExtension(FileUpload.FileName);
            string fileName = Txt_WaybillNo.Text.ToString() + ext;
            FileUpload.SaveAs(Server.MapPath(@"pod/" + fileName));
        }
        if (alert)
        {
            Txt_WaybillNo.Text = "";
            clearFileUpload();
            Txt_Remark.Text = "";
            string a = "Button_Submit1";
            string b = "SAVE";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
        }
    }
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
  
}