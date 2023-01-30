using BLProperties;
using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;

/// <summary>
/// Summary description for CustomerContractFunctions
/// </summary>
namespace BLFunctions
{
    public class CustomerContractFunctions
    {
        public CustomerContractFunctions()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public void SavePickupSchedule(PickupSchedule ps)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@contractID", ps.contractID.ToString()));
            paramList.Add(new Parameters("@pickUPDay", ps.pickUPDay.ToString()));
            paramList.Add(new Parameters("@pickUPTime", ps.pickUPTime.ToString()));
            (new Connection()).ReadSp("ssp_CreateContractPickUPDay", paramList);        
        }
        //Get Branch in Dropdown
        public List<CustomerContractProperties> GetSearchContractCustomer()
        {
            List<CustomerContractProperties> customerList = new List<CustomerContractProperties>();
            List<Parameters> paramList = new List<Parameters>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetContractCustomerList", paramList);
            while (Reader.Read())
            {
                customerList.Add(new CustomerContractProperties()
                {
                    contractID = Convert.ToInt32(Reader["contractID"]),
                    customerName = Reader["customerName"].ToString(),
                });
            }
            return customerList;
        }
        // Get Billing party name
        public string[] getBillingParty(string searchPrefixText, string data)
        {
            int count = 0;
            List<string> billingPartyList = new List<string>();
            DataTable dtTable = null;
            if (HttpContext.Current.Application["BillingParty"] == null)
            {
                List<Parameters> paramList = new List<Parameters>();
                dtTable = (new Connection()).Fillsp("ssp_GetBillingPartyContractName", paramList);
                HttpContext.Current.Application["BillingParty"] = dtTable;
            }
            else
            {
                dtTable = HttpContext.Current.Application["BillingParty"] as DataTable;
            }
            if (searchPrefixText != "")
            {
                string expression = "customerName like '%" + searchPrefixText + "%'";
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
        // Get Vendor Name
        public string[] getVendorName(string searchPrefixText, string data)
        {
            int count = 0;
            List<string> List = new List<string>();
            DataTable dtTable = null;
            if (HttpContext.Current.Application["VendorName"] == null)
            {
                List<Parameters> paramList = new List<Parameters>();
				//paramList.Add(new Parameters("@branchID", HttpContext.Current.Session["BranchId"].ToString()));
                dtTable = (new Connection()).Fillsp("ssp_GetVendorList", paramList);
                HttpContext.Current.Application["VendorName"] = dtTable;
            }
            else
            {
                dtTable = HttpContext.Current.Application["VendorName"] as DataTable;
            }
            if (searchPrefixText != "")
            {
                string expression = "vendorName like '%" + searchPrefixText + "%'";
                DataRow[] rows = dtTable.Select(expression);

                if (data == "GetData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        List.Add(string.Format("{0}ʭ{1}", dr["vendorName"].ToString(), dr["vendorID"].ToString()));
                    }
                }
                else if (data == "ReadData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        List.Add(string.Format("{0}ʭ{1}", dr["vendorName"].ToString(), dr["vendorID"].ToString()));
                        break;
                    }
                }
            }
            if (count == 0) List.Add(string.Format("{0}ʭ{1}", "", ""));
            return List.ToArray();
        }
        //Get Pincode Details
        public string[] getVendorDetail(int vendorId)
        {
            int count = 0;
            List<string> Detail = new List<string>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vendorId", vendorId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVendorDetails", paramList);
            while (Reader.Read())
            {
                count++;
                Detail.Add(string.Format("{0}ʭ{1}ʭ{2}", Reader["vendorType"], Reader["vendorContactNo"], Reader["branchName"]));
            }
            return Detail.ToArray();
        }

        public VendorContract VendorDetails(string vendorId)
        {
            VendorContract vendor = new VendorContract();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vendorId", vendorId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVendorDetails", paramList);
            while (Reader.Read())
            {
		vendor.contractID = Convert.ToInt16(Reader["ContractId"].ToString());
                vendor.vendorType = Reader["vendorType"].ToString().ToUpper();
                vendor.contactNo = Reader["vendorContactNo"].ToString().ToUpper();
                vendor.branchName = Reader["branchName"].ToString().ToUpper();
            }
            return vendor;
        }
        public int SaveVendorContract(VendorContract detail)
        {
            PickReq session = new PickReq();
            session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
            session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"]);
            session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@vendorID", detail.vendorID.ToString()));
            paramList.Add(new Parameters("@fromDate", detail.fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", detail.toDate.ToString()));
            paramList.Add(new Parameters("@signingDate", detail.signingDate.ToString()));
            paramList.Add(new Parameters("@baseDieselRate", detail.baseDieselRate.ToString()));
            paramList.Add(new Parameters("@minimumFreight", detail.minimumFreight.ToString()));
            /*if(detail.onPickup.ToString()!="")
            {
                paramList.Add(new Parameters("@onPickup", detail.onPickup.ToString()));
                paramList.Add(new Parameters("@pickupValue", detail.pickupValue.ToString()));
            }*/
            paramList.Add(new Parameters("@branchID", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@userID", session.Session.UserID.ToString()));          
            paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateVendorContractCreation", paramList);
            if (reader.Read())
            {
                detail.contractID = Convert.ToInt32(reader["id"]);
                return detail.contractID; 
                /*if(detail.geoScopeDetail!=null)
                {
                    foreach (VendorContractGeoScope geoScope in detail.geoScopeDetail)
                    {
                        paramList = new List<Parameters>();
                        paramList.Add(new Parameters("@contractID", detail.contractID + ""));
                        paramList.Add(new Parameters("@routeID", geoScope.routeID + ""));
                        paramList.Add(new Parameters("@Value", geoScope.routeValue + ""));
                        (new Connection()).ExecuteSp("ssp_CreateVendorContractGeoScope", paramList);
                    }
                }*/             
            }
            //return reader != null;
	    return 0; 
        }
        public List<VendorContract> SearchVendorContractData(VendorContract search)
        {
            List<VendorContract> searchList = new List<VendorContract>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vendorType", search.vendorType));
            paramList.Add(new Parameters("@VendorName", search.vendorName));
            paramList.Add(new Parameters("@status", search.contractStatus));
	    if(search.contractID > 0) paramList.Add(new Parameters("@contractId", search.contractID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_ViewVendorContract", paramList);
            while (Reader.Read())
            {
                searchList.Add(new VendorContract()
                {
                    contractID = Convert.ToInt32(Reader["contractID"].ToString()),
                    contractNo = Reader["contractNo"].ToString(),
                    vendorName = Reader["vendorName"].ToString(),
                    vendorType = Reader["vendorType"].ToString(),
                    fromDate = Reader["fromDate"].ToString(),
                    toDate = Reader["toDate"].ToString(),
                    contractStatus = Reader["contractStatus"].ToString(),
                    signingDate = Reader["signingDate"].ToString(),
                    branchName = Reader["branchName"].ToString(),
                    baseDieselRate = Convert.ToDecimal(Reader["baseDieselRate"]),
                    minimumFreight = Convert.ToDecimal(Reader["minimumFreight"]),
                    onPickup = Reader["onPickup"].ToString(),
                    pickupValue = Reader["pickupValue"].ToString(),
                    Username = Reader["userName"].ToString(),
                    creationDateTime = Reader["creationDateTime"].ToString()
                });
            }
            return searchList;
        }
	
        public string[] getNoContractBillingParty(string searchPrefixText, string data)	
        {	
            List<string> billingPartyList = new List<string>(); 	
            DataTable dtTable = null; 	
            List<Parameters> paramList = new List<Parameters>(); 	
            dtTable = (new Connection()).Fillsp("ssp_GetNoContractCustomer", paramList); 	
            string expression = "customerName like '%" + searchPrefixText + "%'"; 	
            DataRow[] rows = dtTable.Select(expression); 	
            foreach (DataRow dr in rows) 	
            { 	
                billingPartyList.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString())); 	
            } 	
            return billingPartyList.ToArray(); 	
        } 	
	public bool CreateVehicleContractCondition(VendorContractCondition vendorContractCondition)	
        {	
            try	
            {	
                List<Parameters> paramList = new List<Parameters>();	
                paramList.Add(new Parameters("@ContractId", vendorContractCondition.ContractId.ToString()));	
                paramList.Add(new Parameters("@ConditionCode", vendorContractCondition.ConditionCode));	
                if(vendorContractCondition.RouteID > 0) paramList.Add(new Parameters("@RouteId", vendorContractCondition.RouteID.ToString()));	
                paramList.Add(new Parameters("@Value", vendorContractCondition.value.ToString()));	
                paramList.Add(new Parameters("@fromValue", vendorContractCondition.fromValue.ToString()));	
                paramList.Add(new Parameters("@toValue", vendorContractCondition.toValue.ToString()));	
                paramList.Add(new Parameters("@Minimum", vendorContractCondition.Minimum.ToString()));
                (new Connection()).ReadSp("ssp_CreateVendorContractCondition", paramList);	
                return true;	
            }	
            catch	
            {	
                return false;	
            }	
        }	
        public IDataReader drContractConditions(int ContractId)	
        {	
            List<Parameters> paramList = new List<Parameters>();	
            paramList.Add(new Parameters("@ContractId", ContractId.ToString()));	
            IDataReader dr = (new Connection()).ReadSp("ssp_GetVehicleContractConditions", paramList);	
            return dr; 	
        }
    }
}
