using System.Collections.Generic;

/// <summary>
/// Summary description for PickReqProperties
/// </summary>
namespace BLProperties
{

    public class PickReqProperties
    {
        public PickReqProperties()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
    public class ConsingorConsignee
    {
        private sessionDetails sessionDetail;
        public ConsingorConsignee()
        {
            if (sessionDetail == null)
                sessionDetail = new sessionDetails();
        }
        public string value { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public long ContactNo { get; set; }
        public int LocID { get; set; }
        public int AreaID { get; set; }
        public string Address { get; set; }
        public string GSTNo { get; set; }     
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

    }
    public class PickReq
    {
        private Date fromToDate;
        private sessionDetails sessionDetail;
        public PickReq()
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
        public int Id { get; set; }
        public int pickupID { get; set; }
        public string WaybillDate { get; set; }
        public string CustName { get; set; }
        public int WaybillId { get; set; }
        public int WaybillNo { get; set; }
        public string PaymentMode { get; set; }
        public string CustCode { get; set; }
        public string PickupNo { get; set; }
        public string PickType { get; set; }
        public string PickDate { get; set; }
        public string PickTime { get; set; }
        public string CustType { get; set; }
        public int CustID { get; set; }
        public int walkinCustID { get; set; }
        public string CustContactNo { get; set; }
        public string CustTelephone { get; set; }
        public string CustEmailId { get; set; }
        public int CustLocID { get; set; }
        public string CustPINCode { get; set; }
        public string CustArea { get; set; }
        public int CustAreaID { get; set; }
        public string CustAddress { get; set; }
        public int PickLocID { get; set; }
        public string PickPINCode { get; set; }
        public int PickAreaID { get; set; }
        public string PickArea { get; set; }
        public string pickupArea { get; set; }
        public string PickAddress { get; set; }
        public int pickUpBranchId { get; set; }
        public int DelBranchId { get; set; }
        public int ConsigneeID { get; set; }
        public string ConsigneeName { get; set; }
        public string ConsigneeContactNo { get; set; }
        public int DelLocID { get; set; }
        public string DelPINCode { get; set; }
        public int DelAreaID { get; set; }
        public string DelArea { get; set; }
        public string DelCity { get; set; }
        public string ConsigneeGSTNo { get; set; }
        public string DelAddress { get; set; }
        public List<PickReqDetail> PicReqListDetails { get; set; }
        public List<PickReqInvoice> PicReqInvoiceDetails { get; set; }
        
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
        public string IPAddress { get; set; }
        public string Status { get; set; }
        public string Remark { get; set; }      
        public string PickupBranch { get; set; }
        public string DeliveryBranch { get; set; }
        public string ExpectedWeightOfMaterial { get; set; }
        public string employeeNo { get; set; }
        public string UserName { get; set; }
        public string UserBranch { get; set; }
        public string creationDateTime { get; set; }
        public string CFTValue { get; set; }
        public string ReverseWaybillNo { get; set; }

    }

    public class PickReqDetail
    {
        public int SrNo { get; set; }        
        public int Id { get; set; }
        public int MaterialID { get; set; }
        public string MaterialType { get; set; }
        public int PackageID { get; set; }
        public string PackageType { get; set; }
        public string Unit { get; set; }
        public decimal Length { get; set; }
        public decimal Breadth { get; set; }
        public decimal Height { get; set; }
        public decimal CFT { get; set; }
        public decimal ActualWeight { get; set; }
        public int NoOfPackage { get; set; }
        public int NoOfInnerPackage { get; set; }
        public double KgperItem { get; set; }
        public decimal ChargeWeight { get; set; }
        public string InvoiceNo { get; set; }
        public string InvoiceDate { get; set; }
        public decimal InvoiceValue { get; set; }
        public string EWaybillNo { get; set; }
        public string EWaybillDate { get; set; }
        public string EWaybillExpiryDate { get; set; }
    }
    public class PickReqInvoice
    {
        public int WaybillId { get; set; }
        public int RateID { get; set; }
        public string RateType { get; set; }
        public string Value { get; set; }
    }
    public class PickSummary
    {
        public long TotalPackage { get; set; }

        public double TotalWeight { get; set; }
    }
    public class Stationary
    {
        public int WayBillStationaryId { get; set; }
        public int startingNo { get; set; }
        public int endingNo { get; set; }
        public int currentNo { get; set; }
        public string startEndNo { get; set; }
	public string Utilisation { get; set; }
	public string Unused { get; set; }
    }

    public class DEPSDetail
    {
        public int waybillItemID { get; set; }
        public int statusID { get; set; }
        public int itemQty { get; set; }
        public int vehicleRequestID { get; set; }
        public string depsType { get; set; }
        public string remark { get; set; }
    }
    public class Bay
    {
        public int ID { get; set; }
        public int branchID { get; set; }
        public string bayName { get; set; }
        public int maxQty { get; set; }
        public decimal maxWt { get; set; }
        public string maxUOM { get; set; }

    }
    public class BayWaybills
    {
        public int bayMasterID { get; set; }
        public int WaybillItemID { get; set; }
        public int itemQty { get; set; }
       
    }
 
}