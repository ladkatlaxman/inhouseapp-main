using System.Collections.Generic;
/// <summary>
/// Summary description for CommonProperties
/// </summary>
namespace BLProperties
{

    public class CommProperties
    {
        public CommProperties()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }

    public class Date
    {
        public string FromDate { get; set; }

        public string ToDate { get; set; }
    }
    public class sessionDetails
    {
        public int BranchID { get; set; }
        public string UserBranch { get; set; }
        public string EmpoloyeeNo { get; set; }
        public int UserID { get; set; }
        public string UserName { get; set; }
        public string CreationDateTime { get; set; }
      
    }
    public class FullAddress
    {
        public int Pincode { get; set; }
        public string State { get; set; }
        public string District { get; set; }
        public string Taluka { get; set; }
        public string City { get; set; }
        public string Area { get; set; }
        public int AreaID { get; set; }
        public string Address { get; set; }
    }
    public class Location
    {
        public int PincodeId { get; set; }
        public int Pincode { get; set; }
        public int StateId { get; set; }
        public string State { get; set; }
        public int DistrictId { get; set; }
        public string District { get; set; }
        public int CityId { get; set; }
        public string City { get; set; }
        public string Area { get; set; }
        public int AreaID { get; set; }
        public string status { get; set; }
        public int contractID { get; set; }
    }
    public class Branch
    {
        public int branchId { get; set; }
        public string branchName { get; set; }
        public string branchAddress { get; set; }
    }
    public class FuelPrice
    {
        public string fuelType { get; set; }
        public string fuelDate { get; set; }
        public decimal fuelPrice { get; set; }
        public int DistrictId { get; set; }
    }
    public class CRMTool
    {
        public int categoryId { get; set; }
        public string categoryName { get; set; }
        public int assignId { get; set; }
        public string assignName { get; set; }
        public int statusId { get; set; }
        public string statusName { get; set; }

    }
    public class PurchaseMaterials
    {
        public int Id { get; set; }
        public int branchId { get; set; }
        public int departmentId { get; set; }
        public string remark { get; set; }
        public List<PurchaseMaterialDetails> MaterialDetail { get; set; }
    }
    public class PurchaseMaterialDetails
    {
        public int materialId { get; set; }
        public int qty { get; set; }
        public string unit { get; set; }
        public string expectedDate { get; set; }
    }
    public class ShowPurchaseMaterialDetails
    {
        public int ID { get; set; }
        public string branchName { get; set; }
        public string departmentName { get; set; }
        public string materialName { get; set; }
        public int qty { get; set; }
        public string unit { get; set; }
        public string remarks { get; set; }
        public string expectedDate { get; set; }
    }

}