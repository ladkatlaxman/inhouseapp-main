using System;

/// <summary>
/// Summary description for RateCardProperties
/// </summary>
namespace BLProperties
{
    public class RateCardProperties
    {
        public RateCardProperties()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
    public class RateCardType
    {
        public int Id { get; set; }
        public string RateType { get; set; }
    }
    public class RateCardDetails
    {
        public int Id { get; set; }
        public int RateTypeId { get; set; }
        public int ContractID { get; set; }
        public int DistanceFrom { get; set; }
        public int DistanceTo { get; set; }
        public int WeightFrom { get; set; }
        public int WeightTo { get; set; }
        public decimal RateValue { get; set; }
        public string EntryDate { get; set; }
        public DateTime ExpiryDate { get; set; }
    }
}
  