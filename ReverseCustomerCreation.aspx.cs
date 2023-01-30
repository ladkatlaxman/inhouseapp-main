using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReverseCustomerCreation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                HttpContext.Current.Application["CustName"] = null;
                (new CFunctions()).dropdwnlist(null, null, Ddl_BranchName, null, "branchName", "branchId", (new CommFunctions().GetBranch()));
            }
            else
            { Response.Redirect("Login.aspx"); }


            string strSave = "$(function () {" + "\n" +
           "$(\"[id*=Button_Submit]\").bind(\"click\", function() {" + "\n" +
             "var hfSubmit = $(\"[id*=hfSubmit]\");" + "\n" +
              "console.log(hfSubmit.val());" +
               "if(hfSubmit.val()==1){" + "\n" +

               "$(\"[id*=LoadingImage]\").show();" + "\n" +
               "var Details = { };" + "\n" +
               "var Branch = { };" + "\n" +
            #region
               "Details.value = \"CONSIGNEE\";" + "\n" +
               "Details.Id = $(\"[id$=hfCustID]\").val();" + "\n" +
               "Details.Name = $(\"[id*=Txt_CCustName]\").val();" + "\n" +
               "Details.ContactNo = $(\"[id*=Txt_CustMobileNo]\").val();" + "\n" +
               "Details.LocID = $(\"[id*=hfCustPinID]\").val();" + "\n" +
               "Details.AreaID = $(\"[id$=Ddl_CustArea]\").val();" + "\n" +
               "Details.Address = $(\"[id*=Txt_CustAdd]\").val();" + "\n" +
               "Branch.branchId = $(\"[id*=Ddl_BranchName]\").val();" + "\n" +
               "console.log(Branch.branchId);" +
            #endregion
                    "$.ajax({" + "\n" +
                   "url: \"ReverseCustomerCreation.aspx/SaveConsignee\"," + "\n" +
                   "data: '{Details: ' + JSON.stringify(Details) + ', BranchID: ' + Branch.branchId + '}'," + "\n" +
                   "type: \"POST\"," + "\n" +
                   "dataType: \"json\"," + "\n" +
                   "contentType: \"application/json; charset=utf-8\"," + "\n" +
            #region
                   "success: function(data) {" + "\n" +       
                      "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                        // alert msg
                        "newFunction(\"Button_Submit1\",\"SAVE\")" + "\n" +
                       // For clear Query String value from url
                       " var uri = window.location.toString();" +
                       "if (uri.indexOf(\"?\") > 0)" +
                       "{" +
                        "var clean_uri = uri.substring(0, uri.indexOf(\"?\"));" +
                        "window.history.replaceState({ }, document.title, clean_uri);" +
                       " }" +
                       "location.reload(true);" + "\n" +  // for reload page after submition
                     "}," + "\n" + //  // end of success
                     "error: function(response) {" + "\n" +
                           "alert(response.responseText);" + "\n" +
                            "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                     "}," + "\n" + // end of error
                     "failure: function(response) {" + "\n" +
                     "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                     "alert(response.responseText);" + "\n" +
                    "}" + "\n" +  // end of failure
            #endregion
                    "});" + "\n" +  // end of ajax
                 "}" + "\n" + // end  if(hfWaybillUpdate.val()==1)
                 "return false;" + "\n" +
                 "});" + "\n" + // end button click
            "}),"; // end function

            CFunctions.setjavascript(CFunctions.javascript + strSave);
            (new CFunctions()).GetJavascriptFunction(this, "Txt_CCustName", "hfCustID", "ReverseCustomerCreation.aspx/getCustName", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }      
    }
    //Get Corporate Customer Names
    [WebMethod]
    public static string[] getCustName(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getCustName(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }
    // Auto Fill details on Customer Code
    [WebMethod]
    public static string[] getCCustomerDetail(string customerID)
    {
        return (new PickReqFunctions()).getCCustomerDetail(customerID, Convert.ToInt32(HttpContext.Current.Session["BranchId"]));
    }

    [WebMethod]
    public static int SaveConsignee(ConsingorConsignee Details, string BranchID)
    {
        return (new PickReqFunctions()).SaveConsignorConsignee(Details, BranchID);
    }
    //protected void Button_Submit_Click(object sender, EventArgs e)
    //{
    //    ConsingorConsignee detail = new ConsingorConsignee();
    //    detail.value = "CONSIGNEE";
    //    detail.Id = Convert.ToInt32(hfCustID.Value);
    //    detail.Name = Txt_CCustName.Text.ToString().ToUpper();
    //    detail.ContactNo = Convert.ToInt64(Txt_CustMobileNo.Text);
    //    detail.LocID = Convert.ToInt32(hfCustPinID.Value);
    //    detail.AreaID = Convert.ToInt32(Ddl_CustArea.SelectedValue);
    //    detail.Address = Txt_CustAdd.Text.ToString().ToUpper();
    //    int alert = new PickReqFunctions().SaveConsignorConsignee(detail, Ddl_BranchName.SelectedValue.ToString());
    //    if(alert!=0)
    //    {
    //        Txt_CCustName.Text = "";
    //        hfCustID.Value = "";
    //        Txt_CustPin.Text = "";
    //        hfCustPinID.Value = "";
    //        Ddl_CustArea.SelectedIndex = 0;
    //        Txt_CustMobileNo.Text = "";
    //        Txt_CustAdd.Text = "";
    //        string a = "Button_Submit1";
    //        string b = "SAVE";
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    //    }
    //}

}