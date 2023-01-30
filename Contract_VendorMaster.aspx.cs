using BLFunctions;
using BLProperties;
using CommonLibrary;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contract_VendorMaster : System.Web.UI.Page
{
    //CommonFunctions cmf = new CommonFunctions();
    public static int s;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["username"] != null)
            {
               // cmf.ButtonopacityHideShow(0, "NEXT", Btn_ContractVendorNext);
                (new CFunctions()).dropdwnlist(null, null, Ddl_Route, null, "routeName", "routeID", (new RouteMasterFunctions().getRouteNameForContract())); 
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        string str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker(\"setDate\", new Date());" + "\n" +
                    "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker();" + "\n" +
                    "$(\"[id$= Txt_signingDate]\").datepicker({ dateFormat: 'dd/mm/yy', minDate:0}).datepicker();" + "\n" ;

        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascriptFunction(this, "Txt_VendorName", "hfVendorName", "Contract_VendorMaster.aspx/getVendorName", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }
    [WebMethod]
    public static string[] getVendorName(string searchPrefixText, string data)
    {
        return (new CustomerContractFunctions()).getVendorName(searchPrefixText, data);
    }
    [WebMethod]
    public static string[] getVendorDetail(int vendorId)
    {
        return (new CustomerContractFunctions()).getVendorDetail(vendorId);
    }    
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    protected void Btn_ResetGeoScope_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    //protected void Btn_Basic_Save_Click(object sender, EventArgs e)
    //{  
    //    Txt_VendorName.Enabled = false;
    //    Txt_FromDate.Enabled = false;
    //    Txt_ToDate.Enabled = false;
    //    Txt_signingDate.Enabled = false;
    //    Txt_CurrentDieselRate.Enabled = false;
    //    Txt_MinFreight.Enabled = false;
    //    cmf.ButtonopacityHideShow(1, "NEXT", Btn_ContractVendorNext);
    //    cmf.ButtonopacityHideShow(0, "SAVE", Btn_Basic_Save);
    //    cmf.ButtonopacityHideShow(0, "RESET", Btn_Reset);
    //}
    //****************************************Function For Data Table Generation**********************************************************
    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("routeID", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("RouteName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Value", typeof(String)));

        if (ViewState["RouteData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["RouteData"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = Ddl_Route.SelectedValue.ToString();
            dr[1] = Ddl_Route.SelectedItem.Text.ToString();
            dr[2] = Txt_RouteValue.Text.ToString();
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = Ddl_Route.SelectedValue.ToString();
            dr[1] = Ddl_Route.SelectedItem.Text.ToString();
            dr[2] = Txt_RouteValue.Text.ToString();
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["RouteData"] != null)
        {
            GV_RouteDetails.DataSource = (DataTable)ViewState["RouteData"];
            GV_RouteDetails.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_RouteDetails.DataSource = dt;
            GV_RouteDetails.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["RouteData"] = dt;
    }
 
    protected void Btn_Add_Click(object sender, EventArgs e)
    {
        GVDiv.Visible = true;
        /*if (ViewState["RouteData"] != null)
        {
            DataTable dt = (DataTable)ViewState["RouteData"];
            int count = dt.Rows.Count;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if ((dt.Rows[i]["RouteName"]).ToString() == Ddl_Route.SelectedItem.Text.ToString())
                {
                    s = 1;
                    //  Page.RegisterStartupScript("Key", "<script type='text/javascript'>window.onload = function(){alert('This is Already Selected');return false;}</script>");
                    string a = "Btn_Add";
                    string b = "ADD1";
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
                    break;
                }
            }
            if (s == 0)
            {
                //BindGrid(count);
            }
            else
                s = 0;
        }
        else
        {
            //BindGrid(1);
        }
        Ddl_Route.SelectedIndex = 0;
        Txt_RouteValue.Text = "";*/
        //if(hfVendorName.Value!="")
        if(lblContractId.Text != "")
        {
            // Check conditions for Values
            if(Ddl_Condition.SelectedValue == "")
            {

            }
            VendorContractCondition vendorContractCondition = new VendorContractCondition();
            vendorContractCondition.ContractId = Convert.ToInt32(lblContractId.Text.ToString());
            vendorContractCondition.ConditionCode = Ddl_Condition.SelectedValue.ToString();
            vendorContractCondition.value = Convert.ToDouble(Txt_RouteValue.Text == "" ? "0" : Txt_RouteValue.Text);
            if(Ddl_Route.SelectedValue.ToString() != "SELECT") vendorContractCondition.RouteID = Convert.ToInt32(Ddl_Route.SelectedValue.ToString() != "SELECT" ? Ddl_Route.SelectedValue.ToString() : "0");
            vendorContractCondition.fromValue = Convert.ToInt32(txtFromKMS.Text != ""? txtFromKMS.Text : "0") ;
            vendorContractCondition.toValue = Convert.ToInt32(txtToKMS.Text != "" ? txtToKMS.Text : "0");
            vendorContractCondition.Minimum = Convert.ToDouble(txtMinimum.Text != "" ? txtMinimum.Text : "0"); 
            if(!(new CustomerContractFunctions()).CreateVehicleContractCondition(vendorContractCondition))
            {
                //The Contract Could not be Saved. Put up an Error Script 
            }

            /*VendorContract vc = new CustomerContractFunctions().VendorDetails(lblVendorId.Text);
            Txt_BelongToBranch.Text = vc.branchName;
            Txt_VendorType.Text = vc.vendorType;
            Txt_PartyContact.Text = vc.contactNo;
            lblContractId.Text = vc.contractID.ToString();
            fillContract(vc); */

            VendorContract vc1 = new VendorContract();
            vc1.contractID = Convert.ToInt32(lblContractId.Text);
            fillContract(vc1);
        }
    }

    public void clearPage()
    {
        //Txt_VendorName.Enabled = true;
        //Txt_FromDate.Enabled = true;
        //Txt_ToDate.Enabled = true;
        //Txt_signingDate.Enabled = true;
        //Txt_CurrentDieselRate.Enabled = true;
        //Txt_MinFreight.Enabled = true;
        Txt_VendorName.Text = "";
        hfVendorName.Value = "";
        Txt_ToDate.Text = "";
        Txt_signingDate.Text = "";
        Txt_VendorType.Text = "AUTO";
        Txt_PartyContact.Text = "AUTO";
        Txt_BelongToBranch.Text = "AUTO";
        Txt_CurrentDieselRate.Text = "";
        Txt_MinFreight.Text = "";
        //Ddl_Pickup.SelectedIndex = 0;
        //Txt_PickupValue.Text = "";
        if(ViewState["RouteData"] != null)
        {
            DataTable dt = (DataTable)ViewState["RouteData"];
            dt.Clear();
            ViewState["RouteData"] = null;
          //  ViewState.Remove("RouteData");
            GVDiv.Visible = false;
        }      
       
        //cmf.ButtonopacityHideShow(0, "NEXT", Btn_ContractVendorNext);
        //cmf.ButtonopacityHideShow(1, "SAVE", Btn_Basic_Save);
        //cmf.ButtonopacityHideShow(1, "RESET", Btn_Reset);
    }
    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        VendorContract vendorContract = new VendorContract();
        //vendorContract.vendorID = Convert.ToInt32(hfVendorName.Value);
	if (lblVendorId.Text == "" && hfVendorName.Value != "") lblVendorId.Text = hfVendorName.Value; 
        vendorContract.vendorID = Convert.ToInt32(lblVendorId.Text); 
        vendorContract.fromDate = Txt_FromDate.Text.ToString();
        vendorContract.toDate = Txt_ToDate.Text.ToString();
        vendorContract.signingDate = Txt_signingDate.Text.ToString();
        vendorContract.baseDieselRate = Convert.ToDecimal(Txt_CurrentDieselRate.Text);
        vendorContract.minimumFreight = Convert.ToDecimal(Txt_MinFreight.Text);
        //vendorContract.onPickup = Ddl_Pickup.SelectedItem.ToString() == "SELECT" ? "" : Ddl_Pickup.SelectedItem.Text.ToString();
        //vendorContract.pickupValue = Txt_PickupValue.Text.ToString() == "" ? "" : Txt_PickupValue.Text.ToString();

        if (ViewState["RouteData"] != null)
        {
            List<VendorContractGeoScope> List = new List<VendorContractGeoScope>();
            foreach (GridViewRow drRow in GV_RouteDetails.Rows)
            {
                VendorContractGeoScope geoDetail = new VendorContractGeoScope();
                geoDetail.routeID = Convert.ToInt32(drRow.Cells[1].Text);
                geoDetail.routeValue = Convert.ToDecimal(drRow.Cells[3].Text);
                List.Add(geoDetail);
            }
            vendorContract.geoScopeDetail = List;
        }

        //bool reader = (new CustomerContractFunctions()).SaveVendorContract(vendorContract);
        int reader = (new CustomerContractFunctions()).SaveVendorContract(vendorContract);

        if (reader > 0)
        {
            (new CFunctions()).showalert("Button_Submit1", "SAVE", this);
            //clearPage();
            VendorContract vc = new VendorContract();
            vc.contractID = reader;
            fillContract(vc);
        }
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        SearchData();
    }
    public void SearchData()
    {
        String vendorType = Ddl_SearchVendorTypes.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchVendorTypes.SelectedItem.ToString();
        String partyName = Txt_SearchPartyName.Text.ToString() == "" ? null : Txt_SearchPartyName.Text.ToString();
        String strStatus = Ddl_SearchStatus.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchStatus.SelectedItem.ToString();
        if ((vendorType != null) || (partyName != null) || (strStatus != null))
        {
            VendorContract vc = new VendorContract();
            vc.vendorType = vendorType;
            vc.vendorName = partyName;
            vc.contractStatus = strStatus;

            gridViewVendorContract.DataSource = (new CustomerContractFunctions()).SearchVendorContractData(vc);
            gridViewVendorContract.DataBind();
        }
        else
            (new CFunctions()).showalert("Btn_Search", "SEARCH", this);
    }

    protected void lnkEditVendorContract_Click(object sender, EventArgs e)
    {
        VendorContract vc = new VendorContract(); 
        vc.contractID = Convert.ToInt16((sender as LinkButton).CommandArgument);
        
        fillContract(vc); 
    }

    private void fillContract(VendorContract vc)
    {
        List<VendorContract> VC = new List<VendorContract>();
        VC = (new CustomerContractFunctions()).SearchVendorContractData(vc);

        foreach (VendorContract vendorContract in VC)
        {
            lblContractId.Text = vendorContract.contractID.ToString(); 
            lblVendorId.Text = vendorContract.vendorID.ToString();
            Txt_VendorName.Text = vendorContract.vendorName;
            Txt_VendorType.Text = vendorContract.vendorType;
            Txt_PartyContact.Text = vendorContract.contactNo;
            Txt_BelongToBranch.Text = vendorContract.branchName;
            Txt_FromDate.Text = vendorContract.fromDate;
            Txt_ToDate.Text = vendorContract.toDate;
            Txt_signingDate.Text = vendorContract.signingDate;
            Txt_CurrentDieselRate.Text = vendorContract.baseDieselRate.ToString();
            Txt_MinFreight.Text = vendorContract.minimumFreight.ToString();

            //Get ContractConditions Details 
            GV_RouteDetails.DataSource = (new CustomerContractFunctions()).drContractConditions(Convert.ToInt32(lblContractId.Text));
            GV_RouteDetails.DataBind(); 

            break;
        }
        Ddl_Condition.SelectedIndex = 0;
    }

    protected void btnGetContractDetails_Click(object sender, EventArgs e)
    {
        VendorContract vc = new VendorContract();
        List<VendorContract> VC;// = new List<VendorContract>();

        vc.contractID = Convert.ToInt16((sender as LinkButton).CommandArgument);
        VC = (new CustomerContractFunctions()).SearchVendorContractData(vc);
        foreach (VendorContract vendorContract in VC)
        {
            lblContractId.Text = vendorContract.contractID.ToString(); 
            lblVendorId.Text = vendorContract.vendorID.ToString();
            Txt_VendorName.Text = vendorContract.vendorName;
            Txt_VendorType.Text = vendorContract.vendorType;
            Txt_PartyContact.Text = vendorContract.contactNo;
            Txt_BelongToBranch.Text = vendorContract.branchName;
            Txt_FromDate.Text = vendorContract.fromDate;
            Txt_ToDate.Text = vendorContract.toDate;
            Txt_signingDate.Text = vendorContract.signingDate;
            Txt_CurrentDieselRate.Text = vendorContract.baseDieselRate.ToString();
            Txt_MinFreight.Text = vendorContract.minimumFreight.ToString();
            break;
        }
        Ddl_Condition.SelectedIndex = 0;
    }
}

