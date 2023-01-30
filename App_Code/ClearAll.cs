using System;
using System.Collections.Generic;
using BLProperties;
using NameSpaceConnection;
using System.Data;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for BranchFunctions
/// </summary>
namespace BLFunctions
{
    public class ClearAll
    {
        public ClearAll()
        {
            HttpContext.Current.Application["CustCode"] = null;
            HttpContext.Current.Application["CustName"] = null;
            HttpContext.Current.Application["Pincode"] = null;
            HttpContext.Current.Application["GetBranchName"] = null;
            HttpContext.Current.Application["ViewFromBranch"] = null;
            HttpContext.Current.Application["ViewTouchingBranch"] = null;
            HttpContext.Current.Application["ViewToBranch"] = null;
            HttpContext.Current.Application["consignorName"] = null;
            HttpContext.Current.Application["consigneeName"] = null;
            HttpContext.Current.Application["ReverseConsignorName"] = null;
            HttpContext.Current.Application["ReverseConsigneeName"] = null;
            HttpContext.Current.Application["MaterialName"] = null;
            HttpContext.Current.Application["PackageName"] = null;
            HttpContext.Current.Application["BillingParty"] = null;
            HttpContext.Current.Application["WayBillNo"] = null;
            HttpContext.Current.Application["District"] = null;
            HttpContext.Current.Application["City"] = null;
            HttpContext.Current.Application["RateType"] = null;
            HttpContext.Current.Application["BranchNameWaybill"] = null;
            HttpContext.Current.Application["VendorName"] = null;
            HttpContext.Current.Application["AllCustName"] = null;
            HttpContext.Current.Application["ReverseWayBillNo"] = null;
        }
    }
}