using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SendStationaryEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string strBranch = "", strQuantity = "", strMessage = "";
            strBranch = Request["Branch"].ToString(); 
            strQuantity = Request["Qty"].ToString(); 

            strMessage = "Request for Branch : " + strBranch + "\n\r" + "\x0A" + 
                         "Required Qty : " + strQuantity;
            (new SendMail()).MailExecute(strMessage, "it@dexters.co.in, ithead@dexters.co.in", null, "New Waybill Stationary Request"); 
        }
        catch { }
    }
}