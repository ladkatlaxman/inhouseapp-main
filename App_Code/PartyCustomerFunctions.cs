using BLProperties;
using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PartyCustomerFunctions
/// </summary>
public class PartyCustomerFunctions
{
    public PartyCustomerFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }
  public string[] getAllCustName(string searchPrefixText, string data)
    {
        int count = 0;
        List<string> custName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["AllCustName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            dtTable = (new Connection()).Fillsp("ssp_GetAllCustomerList", paramList);
            HttpContext.Current.Application["AllCustName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["AllCustName"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "customerName like '%" + searchPrefixText.ToUpper() + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    custName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    custName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) custName.Add(string.Format("{0}ʭ{1}", "", ""));
        return custName.ToArray();
    }
    public string[] GetBillingPartyName(string searchPrefixText, string data)
    {
        int count = 0;
        List<string> billingPartyList = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["BillingParty"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            dtTable = (new Connection()).Fillsp("ssp_GetBillingPartyName", paramList);
            HttpContext.Current.Application["BillingParty"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["BillingParty"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "customerName like '%" + searchPrefixText.ToUpper() + "%'";
            DataRow[] rows = dtTable.Select(expression);
            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    billingPartyList.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    billingPartyList.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) billingPartyList.Add(string.Format("{0}ʭ{1}", "", ""));
        return billingPartyList.ToArray();
    }

    public int SaveCustomerData(CustomerHeader CustHeader, List<CustomerDetails> CustDetail,dataCust dataCustNo)
    {
        CustomerHeader session = new CustomerHeader();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;

            #region HeaderParameter
       if (dataCustNo.custNo != "")
        {            
                List<Parameters> paramList1 = new List<Parameters>();
                paramList1.Add(new Parameters("@custCode", dataCustNo.custNo.ToUpper()));
                DataTable dt = (new Connection()).Fillsp("ssp_CheckCustomerCode", paramList1);
                if (dt.Rows[0]["custNo"].ToString() != "0")
                {                
                        return 0;
                        //error Msg
                }
                else
                {
                    paramList.Add(new Parameters("@event", "Y"));
                    paramList.Add(new Parameters("@custNo", CustHeader.CustNo.ToUpper()));
                    paramList.Add(new Parameters("@customerType", CustHeader.CustType.ToString()));
                    paramList.Add(new Parameters("@customerCategory", CustHeader.CustCategory));
                    paramList.Add(new Parameters("@Name", CustHeader.Name.ToUpper()));
                    paramList.Add(new Parameters("@ContactNo", CustHeader.ContactNo));
                    paramList.Add(new Parameters("@EmailId", CustHeader.EmailId));
                    paramList.Add(new Parameters("@custBillingID", CustHeader.CustBillingID.ToString()));
                    paramList.Add(new Parameters("@modeOfPayment", CustHeader.ModeOfPayment));
                    paramList.Add(new Parameters("@category", CustHeader.Category));
                    paramList.Add(new Parameters("@customercreditlimit", CustHeader.CustCreditLimit.ToString()));
                    paramList.Add(new Parameters("@autoUtility", CustHeader.AutoUtility.ToUpper()));
                    paramList.Add(new Parameters("@branchID", session.Session.BranchID.ToString()));
                    paramList.Add(new Parameters("@userID", session.Session.UserID.ToString()));
                    paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));
                }
        }
       else
        {
            paramList.Add(new Parameters("@event", "N"));
            paramList.Add(new Parameters("@custNo", ""));
            paramList.Add(new Parameters("@customerType", CustHeader.CustType.ToString()));
            paramList.Add(new Parameters("@customerCategory", CustHeader.CustCategory));
            paramList.Add(new Parameters("@Name", CustHeader.Name.ToUpper()));
            paramList.Add(new Parameters("@ContactNo", CustHeader.ContactNo));
            paramList.Add(new Parameters("@EmailId", CustHeader.EmailId));
            paramList.Add(new Parameters("@custBillingID", CustHeader.CustBillingID.ToString()));
            paramList.Add(new Parameters("@modeOfPayment", CustHeader.ModeOfPayment));
            paramList.Add(new Parameters("@category", CustHeader.Category));
            paramList.Add(new Parameters("@customercreditlimit", CustHeader.CustCreditLimit.ToString()));
            paramList.Add(new Parameters("@autoUtility", CustHeader.AutoUtility.ToUpper()));
            paramList.Add(new Parameters("@branchID", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@userID", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));
        }
        #endregion


        reader = (new Connection()).ExecuteSpIS("ssp_CreateOrUpdatePartyCustomer", paramList);
        if (reader.Read())
        {
            CustHeader.CustId = Convert.ToInt32(reader["id"]);
            CFunctions.setID(Convert.ToInt32(reader["id"]));

            foreach (CustomerDetails detail in CustDetail)
            {
                #region DetailParameters
                paramList = new List<Parameters>();
                paramList.Add(new Parameters("@customerID", CustHeader.CustId.ToString()));
                paramList.Add(new Parameters("@branchID", detail.BelongToBranchId.ToString()));
                paramList.Add(new Parameters("@LocID", detail.LocId.ToString()));
                paramList.Add(new Parameters("@areaID", detail.AreaId.ToString()));
                paramList.Add(new Parameters("@billingAddress", detail.BillingAddress.ToString().ToUpper()));

                #endregion

                (new Connection()).ExecuteSp("ssp_CreateCustomerBelongToBranch", paramList);
            }
        }
        return CFunctions.ID;
    }
    public CustomerHeader getCustomerDetails(string CustomerId, string BranchId)
    {
        CustomerHeader custHead = new CustomerHeader(); 
        List<Parameters> paramList = new List<Parameters>(); 
        paramList.Add(new Parameters("@CustomerId", CustomerId)); 
        paramList.Add(new Parameters("@BranchId", BranchId)); 
        IDataReader reader = (new Connection()).ExecuteSpIS("ssp_GetPartyCustomerDetails", paramList);
        while (reader.Read())
        {
            custHead.Name = reader["customerName"].ToString(); 
            custHead.BranchName = reader["BranchName"].ToString();
			custHead.BillingAddress = reader["BillingAddress"].ToString(); 
			custHead.BranchAddress = reader["Address"].ToString();
        }
        return custHead; 
    }
}