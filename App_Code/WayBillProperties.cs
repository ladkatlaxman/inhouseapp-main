

using System.Collections.Generic;
///Classes for Waybill Header, Waybill Details, and a composite class 
/// Class for Waybill Header details 
public class WayBillHeader
{
    public WayBillHeader ()    {    }
    public string waybillID { get; set; }
    public string wayBillNo { get; set; }
    public string pickupID { get; set; }
    public string pickupDateTime { get; set; }
    public string customerID { get; set; }
    public string customerName { get; set; }
    public string paymentMode { get; set; }
    public string pickupAreaId { get; set; }
    public string pickUpLocationId { get; set; }
    public string consigneeID { get; set; }
    public string consigneeName { get; set; }
    public string consigneeArea { get; set; }
    public string consigneeLocationId { get; set; }
    public string consigneeCity { get; set; }
    public string consigneeAddress { get; set; }
    public string eWaybillNo { get; set; }
    public string eWaybillDate { get; set; }
    public string ewayBillExpiryDate { get; set; }
    public string distance { get; set; }
    public string mapDistance { get; set; }
    public string TotalPrice { get; set; }
    public string createdBy { get; set; }
    public string createdDateTime { get; set; }
    public string InvoiceApproveId { get; set; }
    public string InvoiceApprovedDate { get; set; }
}

public class WayBillDetails
{
    public WayBillDetails()
    {
        wbHead = new WayBillHeader();     
    } 
    private WayBillHeader wbHead; 
    public WayBillHeader wayBillHeader {
        get { return wbHead;  }
        set { wbHead = value; }
    }
    public string WayBillItemId { get; set; }
    public string transhipLHSId { get; set; }
    public string waybillID { get; set; }
    public string materialId { get; set; }
    public string materialName { get; set; }
    public string packId { get; set; }
    public string packNAme { get; set; }
    public string branchId { get; set; }
    public string toBranchId { get; set; }
    public string BranchName { get; set; }
    public string toBranchName { get; set; }
    public string ManifestBranch { get; set; }
    public string valueL { get; set; }
    public string valueB { get; set; }
    public string valueC { get; set; }
    public string valueCFT { get; set; }
    public string valueChargedWt { get; set; }
    public string valueActualWt { get; set; }
    public string itemQty { get; set; }
    public string remQty { get; set; }
    public string innerqQty { get; set; }
    public string invoiceNo { get; set; }
    public string invoiceDate { get; set; }
    public string invoiceAmount { get; set; }
    public string routeName { get; set; }
    public string VehicleNo { get; set; }
    public string VehicleHiringDate { get; set; }
    public string VendorName { get; set; }
}

public class WaybillItemStatus
{
     public int WayBillItemId { get; set; }
     public int statusID { get; set; }
     public int itemQty { get; set; }
     public string createdDateTime { get; set; }
     public int branchID { get; set; }
     public int vehicleRequestId { get; set; }  
     public string Reason { get; set; }
     public int userID { get; set; }
     public string Remark { get; set; }
}

public class Manifest
{
    public int ID { get; set; }
    public int WayBillId { get; set; }
    public int WayBillItemId { get; set; }
    public string date { get; set; }
    public int routeId { get; set; }
    public string remark { get; set; }
    public List<ManifestDetails> ManifestDetail { get; set; }
}
public class ManifestDetails
{
    public int manifestID { get; set; }
    public int waybillId { get; set; }
    public int WayBillItemId { get; set; }
    public int qty { get; set; }
   
}




