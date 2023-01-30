using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
public partial class ResetApplicationVariable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
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
        ClearCacheItems(); 
    }
    public void ClearCacheItems()
    {
        List<string> keys = new List<string>();
        IDictionaryEnumerator enumerator = Cache.GetEnumerator();

        while (enumerator.MoveNext())
            keys.Add(enumerator.Key.ToString());

        for (int i = 0; i < keys.Count; i++)
            Cache.Remove(keys[i]);
    }
}