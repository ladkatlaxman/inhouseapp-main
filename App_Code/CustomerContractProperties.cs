/// <summary>
/// Summary description for CustomerContractProperties
/// </summary>
using System.Collections.Generic;
namespace BLProperties
{
    public class CustomerContractProperties
    {
        public CustomerContractProperties()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int contractID { get; set; }
        public string customerName { get; set; }
    }
    public class PickupSchedule
    {
        public int contractID { get; set; }
        public int pickUPDay { get; set; }
        public string pickUPTime { get; set; }
    }
    public class VendorContract
    {
        public int contractID { get; set; }
        public string contractNo { get; set; }
        public string vendorName { get; set; }
        public string vendorType { get; set; }
        public string contractStatus { get; set; }
        public string branchName { get; set; }
        public string contactNo { get; set; }
        public int vendorID { get; set; }
        public string fromDate { get; set; }
        public string toDate { get; set; }
        public string signingDate { get; set; }
        public decimal baseDieselRate { get; set; }
        public decimal minimumFreight { get; set; }
        public string onPickup { get; set; }
        public string pickupValue { get; set; }
        public string Username { get; set; }
        public string creationDateTime { get; set; }

        public List<VendorContractGeoScope> geoScopeDetail { get; set; }

    }
    public class VendorContractGeoScope
    {
        public int routeID { get; set; }
        public decimal routeValue { get; set; }
    }
    public class VendorContractCondition
    {
        public int VendorContractConditionId { get; set; }
        public int ContractId { get; set; }
        public string ConditionCode { get; set; }
        public double value { get; set; }
        public int RouteID { get; set; }
        public int fromValue { get; set; }
        public int toValue { get; set; }
        public double Minimum { get; set; } 
    }
}
