using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LocationDefinition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    
        FillGrid();
        String savedata = "$(\"[id*=Btn_SetAsODA]\").bind(\"click\", function() {" + "\n" +
                 "var hfSetAsODA = $(\"[id*=hfSetAsODA]\");" + "\n" +
                 "console.log(hfSetAsODA);" +
                 "if(hfSetAsODA.val()==1){" + "\n" +
                 "$(\"[id*=LoadingImage]\").show();" +
                 "var loc = { };" + "\n" +

                // "var ID = $(\".rd input[type = radio]:checked\").attr('id');" +
                "var ID = $(\".rd input[type = radio]:checked\").val();" +
                  "console.log(\"RadioButtonID=\"+ID);" + "\n" +
                 //**********for pincode
                 "if(ID==\"Pincode\"){" + "\n" +
                  "loc.PincodeId = $(\"[id*=hfPincode]\").val();" + "\n" +
                   "loc.status = $(\"[id*=Ddl_Status]\").val();" + "\n" +
                  "}" + "\n" +
                   //**********for district
                   "else if(ID==\"District\"){" + "\n" +
                    "loc.PincodeId = $(\"[id*=hfPincode]\").val();" + "\n" +
                   "loc.DistrictId = $(\"[id*=hfDistrict]\").val();" + "\n" +
                   "loc.status = $(\"[id*=Ddl_Status]\").val();" + "\n" +
                  "}" + "\n" +
                   //**********for city
                   "else if(ID==\"City\"){" + "\n" +
                    "loc.PincodeId = $(\"[id*=hfPincode]\").val();" + "\n" +
                   "loc.CityId = $(\"[id*=hfCity]\").val();" + "\n" +
                   "loc.status = $(\"[id*=Ddl_Status]\").val();" + "\n" +
                  "}" + "\n" +
                   //**********for area
                   "else if(ID==\"Area\"){" + "\n" +
                    "loc.PincodeId = $(\"[id*=hfPincode]\").val();" + "\n" +
                   "loc.AreaID = $(\"[id*=Ddl_Area]\").val();" + "\n" +
                   "loc.status = $(\"[id*=Ddl_Status]\").val();" + "\n" +
                  "}" + "\n" +
                
                 "$.ajax({" + "\n" +
                 "url: \"LocationDefinition.aspx/SaveLocationData\"," + "\n" +
                 "data: '{loc: ' + JSON.stringify(loc) + '}'," + "\n" +
                 "type: \"POST\"," + "\n" +
                 "dataType: \"json\"," + "\n" +
                 "contentType: \"application/json; charset=utf-8\"," + "\n" +
                  "success: function(response) {" + "\n" +
         // "clearData();" + "\n" +
          "$(\"[id*=LoadingImage]\").hide();" + "\n" +
          "alert(\"Data Added Successfully...\");" + "\n" +
           "location.reload(true);" + "\n" +  // for reload page after submition
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
               "});";
                              
        CFunctions.setjavascript(CFunctions.javascript + savedata);
        (new CFunctions()).GetJavascriptFunction(this, "Txt_Pincode", "hfPincode", "~/Party_CustomerCreation.aspx/getPincode", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }
    public void FillGrid()
    {
        IDataReader rd;
        rd = new CommFunctions().ViewLocationDefinition();
        GV_LocationDefinition.DataSource = rd;
        GV_LocationDefinition.DataBind();
    }

    [WebMethod]
    public static bool SaveLocationData(Location loc)
    {
        return (new CommFunctions()).SaveLocationDefinition(loc);
    }
    public void clear()
    {
        Txt_Pincode.Text = "";
        hfPincode.Value = "";
        Txt_District.Text = "";
        hfDistrict.Value = "";
        Txt_City.Text = "";
        hfCity.Value = "";
        Ddl_Area.SelectedIndex = 0;
        Ddl_Status.SelectedIndex = 0;
    }
    protected void Btn_SetAsODA_Click(object sender, EventArgs e)
    {
        if(rdPincode.Checked == true)
        {
            Location loc = new Location();
            loc.PincodeId = Convert.ToInt32(hfPincode.Value);
            loc.status = Ddl_Status.SelectedItem.Text.ToString();
            bool alertmsg = new CommFunctions().SaveLocationDefinition(loc);
            if(alertmsg)
            {
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                clear();
            }             
        }
        else if(rdDistrict.Checked == true)
        {
            Location loc = new Location();
            loc.DistrictId = Convert.ToInt32(hfDistrict.Value);
            loc.status = Ddl_Status.SelectedItem.Text.ToString();
            bool alertmsg = new CommFunctions().SaveLocationDefinition(loc);
            if (alertmsg)
            {
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                clear();
            }
        }
        else if (rdCity.Checked == true)
        {
            Location loc = new Location();
            loc.CityId = Convert.ToInt32(hfCity.Value);
            loc.status = Ddl_Status.SelectedItem.Text.ToString();
            bool alertmsg = new CommFunctions().SaveLocationDefinition(loc);
            if (alertmsg)
            {
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                clear();
            }
        }
        else if (rdArea.Checked == true)
        {
            Location loc = new Location();
            loc.AreaID = Convert.ToInt32(Ddl_Area.SelectedValue);
            loc.status = Ddl_Status.SelectedItem.Text.ToString();
            bool alertmsg = new CommFunctions().SaveLocationDefinition(loc);
            if (alertmsg)
            {
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
                clear();
            }
        }
    }



    
}