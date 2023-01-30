using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MasterFormProperties
/// </summary>
/// 
namespace BLProperties
{
    public class MasterFormProperties
    {
        public MasterFormProperties()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int ID { get; set; }
        public String Name { get; set; }
    }
    public class GoodsReceiptNote
    {
        public int ID { get; set; }
        public string grnNo { get; set; }
        public string MaterialName { get; set; }
        public string PoNo { get; set; }
        public int Qty { get; set; }
        public string UOM { get; set; }
    }
    public class PutUpMaterials
    {
        public int grnId { get; set; }
        public int putUpQty { get; set; }
        public int BayMasterId { get; set; }
    } 
    public class PickUpMaterials
    {
        public int putUpMaterialId { get; set; }
        public int pickUpQty { get; set; }
    }
    public class UserAccess
    {
        public int userID { get; set; }
        public int accessID { get; set; }
        public int branchID { get; set; }
        public string AccessName { get; set; }
        public string BranchName { get; set; }
        public string AccessMenuName { get; set; }      
    }

}
