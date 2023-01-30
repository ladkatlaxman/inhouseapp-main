using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using NameSpaceConnection; 

public partial class ReverseCustomer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            ddlCustomer.DataTextField = "customerName"; 
            ddlCustomer.DataValueField = "customerId";
            ddlCustomer.DataSource = getCustName(Session["BranchId"].ToString());
            ddlCustomer.DataBind();
            getCustomerDetail(ddlCustomer.SelectedValue, Session["BranchId"].ToString());
            (new CFunctions()).dropdwnlist(null, null, Ddl_BranchName, null, "branchName", "branchId", (new CommFunctions().GetBranch()));
            ddlCustomer_SelectedIndexChanged(sender, e);
        }
    }

    public DataTable getCustName(string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>(); 
        paramList.Add(new Parameters("@branchID", BranchId));
        DataTable dtTable = (new Connection()).Fillsp("ssp_GetCustomerList", paramList); 
        return dtTable; 
    }
    public DataTable getCustomerBranches(string customerId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@CustomerId", customerId)); 
        DataTable dtTable = (new Connection()).Fillsp("ssp_GetCustomerReverseBranches", paramList);
        return dtTable;
    }
    public void getCustomerDetail(string customerID, string BranchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@CustomerID", customerID));
        paramList.Add(new Parameters("@branchID", BranchId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetPartyCustomerCreation", paramList);
        while (Reader.Read())
        {
            /*custDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}", Reader["customerID"], Reader["customerNo"], 
                Reader["customerName"], Reader["customerContactNo"], Reader["EmailId"], Reader["locID"], Reader["locPincode"], 
                Reader["locAreaID"], Reader["areaName"], Reader["billingAddress"], Reader["CFTRate"], Reader["CFTValue"]));*/ 
            Txt_CustMobileNo.Text = Reader["customerContactNo"].ToString();
            hfCustPinID.Value = Reader["locID"].ToString(); 
            Txt_CustPin.Text = Reader["locPincode"].ToString(); 
            Txt_CustAdd.Text = Reader["billingAddress"].ToString();
            txtArea.Text = Reader["areaName"].ToString();
            hfAreaId.Value = Reader["locAreaID"].ToString(); 
        }
    }

    protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvBranch.DataSource = getCustomerBranches(ddlCustomer.SelectedValue);
        gvBranch.DataBind(); 
    }
    public static int SaveConsignee(ConsingorConsignee Details, string BranchID)
    {
        return (new PickReqFunctions()).SaveConsignorConsignee(Details, BranchID);
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        ConsingorConsignee Details = new ConsingorConsignee(); 
        Details.value = "CONSIGNEE";
        Details.Id = Convert.ToInt32(ddlCustomer.SelectedValue.ToString()); 
        Details.Name = ddlCustomer.SelectedItem.Text + " - " + Session["BranchName"];
        Details.ContactNo = Convert.ToInt64(Txt_CustMobileNo.Text); 
        Details.LocID = Convert.ToInt32(hfCustPinID.Value.ToString()); 
        Details.AreaID = Convert.ToInt32(hfAreaId.Value.ToString()); 
        Details.Address = Txt_CustAdd.Text; 
        SaveConsignee(Details, Ddl_BranchName.SelectedValue.ToString()); 
        ddlCustomer_SelectedIndexChanged(sender, e);
    }
}