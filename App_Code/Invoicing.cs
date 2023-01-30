using System;
using System.Data; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
    using NameSpaceConnection;
/// <summary>
/// Summary description for Invoicing
/// </summary>
namespace BLFunctions
{
    public class Invoicing
    {
        public Invoicing()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public IDataReader ViewInvoiceList(string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_ViewCreditCustomerWayBillList", paramList);
            return Reader;
        }
        public IDataReader getAllLocations(string branchId, string pinCode = null)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (branchId != "0")    paramList.Add(new Parameters("@branchId", branchId));
            if (pinCode != "") 	    paramList.Add(new Parameters("@PinCode", pinCode)); 
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetLocations", paramList);
            return Reader;
        }
        public void setLocationDefinition(string LocId, string definition)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@LocID", LocId));
            paramList.Add(new Parameters("@Status", definition));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreateLocationDefinition", paramList);
        }
        public void setCustomerODA(string customerId, string ODALocId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@customerId", customerId));
            paramList.Add(new Parameters("@ODALocId", ODALocId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_SetODALocation", paramList);
        }
        public void removeCustomerODA(string customerId, string ODALocId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@customerId", customerId));
            paramList.Add(new Parameters("@ODALocId", ODALocId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_RemoveODALocation", paramList);
        }
    }
}