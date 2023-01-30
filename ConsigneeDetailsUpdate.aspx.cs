using BLProperties;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ConsigneeDetailsUpdate : System.Web.UI.Page
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

            string updateData = "$(function () {" + "\n" +
                 "$(\"[id*=Button_Submit]\").bind(\"click\", function() {" + "\n" +
                  "var hfSubmit = $(\"[id*=hfSubmit]\");" + "\n" +
                 "console.log(hfSubmit.val());" +
                 "if(hfSubmit.val()==1){" + "\n" +
                    "$(\"[id*=LoadingImage]\").show();" + "\n" +
                    "var details = { };" + "\n" +

                "details.ConsigneeID=$(\"[id$=hfConsigneeID]\").val();" + "\n" +
                "details.ConsigneeContactNo = $(\"[id*=Txt_ConsigneeContNo]\").val();" + "\n" +
                "details.DelLocID = $(\"[id*=hfDelPinID]\").val();" + "\n" +
                "details.DelAreaID = $(\"[id*=Ddl_DelArea]\").val();" + "\n" +
                "details.DelAddress = $(\"[id*=Txt_DelAdd]\").val();" + "\n" +

                    "$.ajax({" + "\n" +
                    "url: \"ConsigneeDetailsUpdate.aspx/SaveConsignee\"," + "\n" +
                    "data: '{PickReqHeader: ' + JSON.stringify(details) +'}'," + "\n" +
                    "type: \"POST\"," + "\n" +
                    "dataType: \"json\"," + "\n" +
                    "contentType: \"application/json; charset=utf-8\"," + "\n" +
                    "success: function(response) {" + "\n" +
                    "var data=response.d;" + "\n" +
                    "console.log(\"data:\"+ data);" + "\n" +
                    "if(data == -1)" +
                    "{" +
                        "alert(\"Data could not Add...\");" + "\n" +
                        "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                    "}" +
                    "else{" +
                            "$(\"[id*=LoadingImage]\").hide();" + "\n" +

                            "newFunction(\"Button_Tab1Save\",\"UPDATE\")" + "\n" +

                           // "alert(\"Data Added Successfully...\");" + "\n" +
                           // For clear Query String value from url
                           " var uri = window.location.toString();" +
                           "if (uri.indexOf(\"?\") > 0)" +
                           "{" +
                            "var clean_uri = uri.substring(0, uri.indexOf(\"?\"));" +
                            "window.history.replaceState({ }, document.title, clean_uri);" +
                           " }" +
                           "location.reload(true);" + "\n" +  // for reload page after submition
                         "}" +
                     "}," + "\n" +
                      "error: function(response) {" + "\n" +
                            "alert(response.responseText);" + "\n" +
                             "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                      "}," + "\n" +
                      "failure: function(response) {" + "\n" +
                      "$(\"[id*=LoadingImage]\").hide();" + "\n" +
                      "alert(response.responseText);" + "\n" +
                     "}" + "\n" +
                  "});" + "\n" +
                  "}" + "\n" +
                  "return false;" + "\n" +
                  "});" + "\n" +

                "}),";

            CFunctions.setjavascript(CFunctions.javascript + updateData);
            (new CFunctions()).GetJavascriptFunction(this, "Txt_DelPin", "hfDelPinID", "PickReqCRMBranch.aspx/getPincode", "GetData", "});");
            (new CFunctions()).GetJavascriptFunction(this, "Txt_ConsigneeName", "hfConsigneeID", "PickReqCRMBranch.aspx/getConsigneeName", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
    }
    [WebMethod]
    public static int SaveConsignee(PickReq PickReqHeader)
    {
        return (new PickReqFunctions()).UpdateConsigneeDetails(PickReqHeader);
    }
   
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
}