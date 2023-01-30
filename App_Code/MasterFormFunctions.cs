using BLProperties;
using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Web;

/// <summary>
/// Summary description for MasterFormFunctions
/// </summary>
/// 
namespace BLFunctions
{
    public class MasterFormFunctions
    {
        public MasterFormFunctions()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<MasterFormProperties> getVendor(int branchId)
        {
            List<MasterFormProperties> VendorList = new List<MasterFormProperties>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", branchId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVendorList", paramList);
            while (Reader.Read())
            {
                VendorList.Add(new MasterFormProperties() { ID = Convert.ToInt32(Reader["vendorID"]), Name = Reader["vendorName"].ToString().ToUpper() });
            }
            return VendorList;
        }

        public List<MasterFormProperties> getVehicleType()
        {
            List<MasterFormProperties> VehicleTypeList = new List<MasterFormProperties>();
            List<Parameters> paramList = new List<Parameters>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleTypeList", paramList);
            while (Reader.Read())
            {
                VehicleTypeList.Add(new MasterFormProperties() { ID = Convert.ToInt32(Reader["vehicleTypeID"]), Name = Reader["VehicleType"].ToString().ToUpper()});
            }
            return VehicleTypeList;
        }
        public bool SaveGoodsReceiptNote(GoodsReceiptNote grn)
        {
            PickReq session = new PickReq();
            session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
            session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["branchId"]);
            session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@grnNo", grn.grnNo.ToString()));
            paramList.Add(new Parameters("@MaterialName", grn.MaterialName.ToString()));
            paramList.Add(new Parameters("@PoNo", grn.PoNo.ToString()));
            paramList.Add(new Parameters("@Qty", grn.Qty.ToString()));
            paramList.Add(new Parameters("@UOM", grn.UOM.ToString()));
            paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@creationDate", session.Session.CreationDateTime));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateGoodsReceiptNote", paramList);
            return reader != null;
        }
        public DataTable GetGoodsReceiptNoteDetails(int BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", BranchId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetGoodsReceiptNoteDetails", paramList);
            return dt;
        }
        public bool SavePutUpMaterials(PutUpMaterials matr)
        {
            PickReq session = new PickReq();
            session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
            session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@grnId", matr.grnId.ToString()));
            paramList.Add(new Parameters("@putUpQty", matr.putUpQty.ToString()));
            paramList.Add(new Parameters("@BayMasterId", matr.BayMasterId.ToString()));
            paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@creationDate", session.Session.CreationDateTime));
            reader = (new Connection()).ExecuteSpIS("ssp_CreatePutUpMaterial", paramList);
            return reader != null;
        }
        public DataTable GetPutUpMaterialDetails(int BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", BranchId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetPutUpMaterialDetails", paramList);
            return dt;
        }
        public bool SavePickUpMaterials(PickUpMaterials matr)
        {
            PickReq session = new PickReq();
            session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
            session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@putUpMaterialId", matr.putUpMaterialId.ToString()));
            paramList.Add(new Parameters("@pickUpQty", matr.pickUpQty.ToString()));            
            paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@creationDate", session.Session.CreationDateTime));
            reader = (new Connection()).ExecuteSpIS("ssp_CreatePickUpMaterial", paramList);
            return reader != null;
        }
        public List<UserAccess> GetAccessMenu()
        {
            UserAccess ua;
            List<Parameters> paramList = new List<Parameters>();
            List<UserAccess> List = new List<UserAccess>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetAccessPage", paramList);
            while (Reader.Read())
            {
                ua = new UserAccess();
                ua.accessID = Convert.ToInt32(Reader["AccessId"]);
                ua.AccessName = Reader["AccessPage"].ToString();             
                List.Add(ua);
            }
            return List;
        }
        public List<UserAccess> ViewUserAccess(int userId)
        {
            UserAccess ua;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@UserId", userId.ToString()));
            List<UserAccess> List = new List<UserAccess>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetUserAccess", paramList);
            while (Reader.Read())
            {
                ua = new UserAccess();
                ua.userID = Convert.ToInt32(Reader["UserId"]);
                ua.accessID = Convert.ToInt32(Reader["AccessId"]);
                ua.AccessName = Reader["AccessName"].ToString();
                ua.AccessMenuName = Reader["AccessMenuName"].ToString();
                List.Add(ua);
            }
            return List;
        }
       public List<UserAccess> ViewBranchAccess(int userId)
        {
            UserAccess ua;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "View"));
            paramList.Add(new Parameters("@userID", userId.ToString()));
            List<UserAccess> List = new List<UserAccess>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreateOrUpdateEmployeeBelongToBranch", paramList);
            while (Reader.Read())
            {
                ua = new UserAccess();
                ua.userID = Convert.ToInt32(Reader["UserID"]);
                ua.branchID = Convert.ToInt32(Reader["branchID"]);
                ua.BranchName = Reader["branchName"].ToString();       
                List.Add(ua);
            }
            return List;
        }
        public bool SaveUserAccess(UserAccess ua)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@UserId", ua.userID.ToString()));
            paramList.Add(new Parameters("@AccessId", ua.accessID.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateUserAccess", paramList);
            return reader != null;
        }
        public bool RemoveUserAccess(UserAccess ua)
        {           
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@UserId", ua.userID.ToString()));
            paramList.Add(new Parameters("@AccessId", ua.accessID.ToString()));           
            reader = (new Connection()).ExecuteSpIS("ssp_RemoveUserAccess", paramList);
            return reader != null;
        }
        public bool SaveBranchAccess(UserAccess ua)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@Event", "Insert"));
            paramList.Add(new Parameters("@UserId", ua.userID.ToString()));
            paramList.Add(new Parameters("@branchID", ua.branchID.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateOrUpdateEmployeeBelongToBranch", paramList);
            return reader != null;
        }
        public bool RemoveBranchAccess(UserAccess ua)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@Event", "Delete"));
            paramList.Add(new Parameters("@UserId", ua.userID.ToString()));
            paramList.Add(new Parameters("@branchID", ua.branchID.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateOrUpdateEmployeeBelongToBranch", paramList);
            return reader != null;
        }
	public PickReq getWaybillHeaderDetails(string WaybillId)
        {
            PickReq wbHeader = new PickReq();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WaybillID", WaybillId.ToString()));
            IDataReader reader = (new Connection()).ExecuteSpIS("ssp_GetWaybillHeaderData", paramList);
            while (reader.Read())
            {
                wbHeader.WaybillNo = Convert.ToInt32(reader["waybillNo"]);
                wbHeader.WaybillDate = reader["waybillDate"].ToString();
                wbHeader.CustName = reader["CustomerName"].ToString();
                wbHeader.CustContactNo = reader["contactNo"].ToString();
                wbHeader.PickAddress = reader["pickupAddress"].ToString();
                wbHeader.pickupArea = reader["PickupArea"].ToString();
                wbHeader.PickPINCode = reader["PickupPincode"].ToString();
                wbHeader.ConsigneeName = reader["consigneeName"].ToString();
                wbHeader.ConsigneeContactNo = reader["consigneeContactNo"].ToString();
                wbHeader.DelAddress = reader["consigneeAddress"].ToString();
                wbHeader.DelArea = reader["DelArea"].ToString();
                wbHeader.DelPINCode = reader["DelPincode"].ToString();
                wbHeader.DelCity = reader["DelCity"].ToString();
                wbHeader.PickupBranch = reader["pickUpBranchName"].ToString();
                wbHeader.DeliveryBranch = reader["DeliveryBranchName"].ToString();

            }
            return wbHeader;
        }
        public List<PickReqDetail> getWaybillDetails(string WaybillId)
        {
            List<PickReqDetail> pqd = new List<PickReqDetail>(); 
            PickReqDetail wbDetails;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WaybillID", WaybillId));
            IDataReader reader = (new Connection()).ExecuteSpIS("ssp_GetWaybillDetailsData", paramList);
            while (reader.Read())
            {
                wbDetails = new PickReqDetail();
                wbDetails.MaterialType = reader["materialName"].ToString();
                wbDetails.PackageType = reader["typeOfPackage"].ToString();
                wbDetails.ActualWeight = Convert.ToDecimal(reader["valueActualWt"]);
                wbDetails.ChargeWeight = Convert.ToDecimal(reader["valueChargedWt"]);
                wbDetails.NoOfPackage = Convert.ToInt32(reader["itemQty"]);
                wbDetails.InvoiceNo = reader["invoiceNo"].ToString();
                wbDetails.InvoiceDate = reader["invoiceDate"].ToString();
                wbDetails.InvoiceValue = Convert.ToDecimal(reader["invoiceAmount"]);
                pqd.Add(wbDetails);
            }
            return pqd;
        }
    }
}

