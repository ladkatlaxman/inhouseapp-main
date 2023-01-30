using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PartyCustomerProperties
/// </summary>
namespace BLProperties
{
    public class PartyCustomerProperties
    {
        public PartyCustomerProperties()
        {
            //
            // TODO: Add constructor logic here
            //
        }
      
    }
    public class CustomerHeader
    {
        private Date fromToDate;
        private sessionDetails sessionDetail;
        public CustomerHeader()
        {
            if (fromToDate == null) fromToDate = new Date();
            if (sessionDetail == null) sessionDetail = new sessionDetails();
        }
        public Date date
        {
            get
            {
                return fromToDate;
            }
            set
            {
                fromToDate = value;
            }
        }
        public sessionDetails Session
        {
            get
            {
                return sessionDetail;
            }
            set
            {
                sessionDetail = value;
            }
        }
        public int CustId { get; set; }
        public string CustCategory { get; set; }
        public string CustNo { get; set; }
        public string CustType { get; set; }
        public string Name { get; set; }
        public string ContactNo { get; set; }
        public string EmailId { get; set; }
        public int CustBillingID { get; set; }
        public string ModeOfPayment { get; set; }
        public string Category { get; set; }
        public int CustCreditLimit { get; set; }
        public string AutoUtility { get; set; }
        public string BranchName { get; set; } 
		public string BranchAddress { get; set; }
		public string BillingAddress { get; set; }
    }
    public class CustomerDetails
    {
        public int BelongToBranchId { get; set; }
        public int LocId { get; set; }
        public int AreaId { get; set; }
        public string BillingAddress { get; set; }
    }

    public class dataCust
    {
        public string custNo { get; set; }
    }
}
