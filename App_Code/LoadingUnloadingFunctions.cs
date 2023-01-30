using System;
using System.Collections.Generic;
using BLProperties;
using CommonLibrary;
using System.Data;
using System.Web;
using NameSpaceConnection;

/// <summary>
/// Summary description for LoadingUnloading
/// </summary>
namespace BLFunctions
{
    public class LoadingUnloadingFunctions
    {
        public LoadingUnloadingFunctions()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        // Functions For Pickup Unload 

        //Pickup Unloading VehicleList
        public List<pickUpVehicle> GetPickupUnloadingVehicles(int branchId)
        {
            List<pickUpVehicle> vehicleList = new List<pickUpVehicle>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchID", branchId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetPickupUnloadingVehicleList", paramList);
            while (Reader.Read())
            {
                vehicleList.Add(new pickUpVehicle()
                {
                    VehicleRequestID = Convert.ToInt32(Reader["VehicleRequestID"]),
                    vehicleId = Convert.ToInt32(Reader["vehicleID"]),
                    vehicleNo = Reader["vehicleNo"].ToString()
                });
            }
            return vehicleList;
        }


        //Get Vehicle in Dropdown
        public List<pickUpVehicle> GetOpenPickUpVehicles(int branchId, string status)
        {
            List<pickUpVehicle> vehicleList = new List<pickUpVehicle>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", branchId.ToString()));
            paramList.Add(new Parameters("@status", status.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDispatchedVehicleList", paramList);
            while (Reader.Read())
            {
                vehicleList.Add(new pickUpVehicle()
                {
                    VehicleRequestID = Convert.ToInt32(Reader["VehicleRequestID"]),
                    vehicleId = Convert.ToInt32(Reader["vehicleId"]),
                    vehicleNo = Reader["vehicleNo"].ToString()
                });
            }
            return vehicleList;
        }

        //Get Vehicle in Dropdown
        public List<pickUpVehicle> GetOpenTranshipmentVehicles(int branchId)
        {
            List<pickUpVehicle> vehicleList = new List<pickUpVehicle>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", branchId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetTranshipLoadVehicleList", paramList);
            while (Reader.Read())
            {
                vehicleList.Add(new pickUpVehicle()
                {
                    VehicleRequestID = Convert.ToInt32(Reader["VehicleRequestID"]),
                    vehicleId = Convert.ToInt32(Reader["vehicleId"]),
                    vehicleNo = Reader["vehicleNo"].ToString()
                });
            }
            return vehicleList;
        }

       

        //Get Last Branch In Route
        public pickUpVehicle GetLastBranchInRoute(int vehicleRequestId)
        {
            pickUpVehicle vehicleList = new pickUpVehicle();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetLastBranchInRoute", paramList);
            while (Reader.Read())
            {
                vehicleList.VehicleRequestID = Convert.ToInt32(Reader["vehicleRequestId"]);
                vehicleList.branchID = Convert.ToInt32(Reader["toBranchID"]);              
            }
            return vehicleList;
        }
	public List<WayBillDetails> GetDeliveryLoadedWayBills(int VehicleRequestId)	
        {	
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();	
            List<Parameters> paramList = new List<Parameters>();	
            paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestId.ToString()));	
            IDataReader Reader = (new Connection()).ReadSp("ssp_ReportWayBillItemStatus", paramList); 	
            WayBillDetails wbDetail;	
            while (Reader.Read())	
            {	
                wbDetail = new WayBillDetails();	
                wbDetail.waybillID = Reader["waybillID"].ToString();	
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();	
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();	
                wbDetail.wayBillHeader.paymentMode = Reader["paymentMode"].ToString();	
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();	
                wbDetail.materialName = Reader["materialName"].ToString();	
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();	
                wbDetail.itemQty = Reader["itemQty"].ToString();	
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();	
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();	
                wbDetail.wayBillHeader.consigneeName = Reader["consigneeName"].ToString();	
                wbDetail.wayBillHeader.consigneeCity = Reader["DelCity"].ToString();	
                wbDetail.wayBillHeader.consigneeCity = Reader["DelArea"].ToString() == Reader["DelCity"].ToString() ? Reader["DelCity"].ToString(): Reader["DelArea"].ToString() + ", " + Reader["DelCity"].ToString();	
                wbDetail.VehicleNo = Reader["VehicleNo"].ToString();
                wbDetail.VendorName = Reader["vendorName"].ToString();
                wbDetail.VehicleHiringDate = Reader["hiringDate"].ToString();
                waybillDetails.Add(wbDetail);	
            }	
            return waybillDetails;	
        }
        public List<WayBillDetails> GetPickUnloadWayBillDetails(string vehicleRequestId, int StatusId, int branchId)
        {
            return null;
        }


        public List<WayBillDetails> GetPickLoadingWayBillDetails(int branchID)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetPickupLoadingWaybillList", paramList);
            WayBillDetails wbDetail;
            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["RemQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();
                waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        public List<WayBillDetails> GetDeliveryLoadingWayBillDetails(int branchID)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));            
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDeliveryWaybillList", paramList);
            WayBillDetails wbDetail;
            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.wayBillHeader.paymentMode = Reader["paymentMode"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["RemQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();
                wbDetail.wayBillHeader.consigneeArea = Reader["areaName"].ToString();
                waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        public List<WayBillDetails> GetDeliveryLoadingWayBillDetailsNew(string branchID, string DeliveryBranchId) 
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            if(DeliveryBranchId != "") paramList.Add(new Parameters("@DeliveryBranchId", DeliveryBranchId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDeliveryWaybillListNew", paramList);
            WayBillDetails wbDetail;
            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.wayBillHeader.paymentMode = Reader["paymentMode"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["RemQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();
                wbDetail.wayBillHeader.consigneeArea = Reader["areaName"].ToString();
                waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        // Get Pickups List Of Waybills 
        public List<WayBillDetails> GetPickUnloadWayBillDetails(string vehicleRequestId, string BranchId,string waybillNo)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@BranchId", BranchId));
            if(waybillNo!="")
            {
                paramList.Add(new Parameters("@waybillNo", waybillNo));
            }
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleWayBill", paramList);
            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["PickREMQty"].ToString();
                wbDetail.invoiceNo = Reader["InvoiceNo"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                if (wbDetail.remQty != "0") 
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        // Get Transhipment List Of Waybills 
        public List<WayBillDetails> GetTranshipUnloadWayBillDetails(string vehicleRequestId, string BranchId,string waybillNo)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@BranchId", BranchId));
            if(waybillNo!="")
            {
                paramList.Add(new Parameters("@waybillNo", waybillNo));
            }
            //IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleWayBill", paramList);
 	    IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleTransLoadedWayBill", paramList);
            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.BranchName = Reader["BranchName"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.invoiceNo= Reader["invoiceNo"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["TranshipREMQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                if (wbDetail.remQty != "0")
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        public int GetCountOfWaybillItemsForDispatch(int vehicleRequestId, int BranchId)
        {
            int count = 0;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@branchId", BranchId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CountWaybillItemsForDispatch", paramList);
            while (Reader.Read())
            {
                count = Convert.ToInt32(Reader["WaybillCount"]);               
            }
            return count;
        }

        // Get Delivery List Of Waybills 
        public List<WayBillDetails> GetDeliveryUnloadWayBillDetails(string vehicleRequestId,string waybillNo)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            //paramList.Add(new Parameters("@branchId", ""));
            if(waybillNo!="")
            {
                paramList.Add(new Parameters("@waybillNo", waybillNo));
            }
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleWayBill", paramList);
            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["FinalDelREMQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();
                if (wbDetail.remQty != "0") 
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }
        // Get Final Delivery List Of Waybills 
        public List<WayBillDetails> GetFinalDeliveryUnloadWayBillDetails(string vehicleRequestId, string BranchId)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@BranchId", BranchId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleWayBill", paramList);
            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.wayBillHeader.paymentMode = Reader["paymentMode"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["FinalDelREMQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();
                if (wbDetail.remQty != "0")
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        // Get List Of Waybills Not Unload
        public int GetPickNotUnloadWayBillList(string vehicleRequestId)
        {
            int count = 0;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleWayBill", paramList);
            while (Reader.Read())
            {
                if (Reader["3"].ToString() == "0")
                    count++;
            }
            return count;
        }
    
        //Close the Vehicle 
        public int SetVehicleClose(string vehicleRequestId, string UserId, string BranchId, string CreationDateTime,string remark)
        {
            int intResult = -1;
            List<NameSpaceConnection.Parameters> paramList = new List<NameSpaceConnection.Parameters>();
            paramList.Add(new NameSpaceConnection.Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new NameSpaceConnection.Parameters("@UserId", UserId));
            paramList.Add(new NameSpaceConnection.Parameters("@BranchId", BranchId));
            paramList.Add(new NameSpaceConnection.Parameters("@CreationDateTime", CreationDateTime));
            paramList.Add(new NameSpaceConnection.Parameters("@Remark", remark));
            IDataReader Reader = (new NameSpaceConnection.Connection()).ReadSp("ssp_CloseVehicleRequest", paramList);
            while (Reader.Read())
            {
                intResult = Convert.ToInt32(Reader["STATUS"].ToString());
            }
            return intResult;
        }



        // Update unloadStatus
        //public string[] changeUnloadStatus(string id)
        //{
        //    List<string> status = new List<string>();

        //    List<Parameters> paramList = new List<Parameters>();          
        //    paramList.Add(new Parameters("@tblWayBillItemId", id));           
        //    IDataReader Reader = (new Connection()).ReadSp("ssp_ChangeUnloadStatusOfMaterial", paramList);
        //    while (Reader.Read())
        //    {
        //        status.Add(string.Format("{0}", Reader["unloadStatus"]));
        //    }
        //    return status.ToArray();
        //}
        public bool changeUnloadStatus(WaybillItemStatus wb)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WayBillItemId", wb.WayBillItemId.ToString()));
            paramList.Add(new Parameters("@statusId", wb.statusID.ToString()));
            paramList.Add(new Parameters("@itemQty", wb.itemQty.ToString()));
            paramList.Add(new Parameters("@creationDateTime", wb.createdDateTime.ToString()));
            paramList.Add(new Parameters("@branchId", wb.branchID.ToString()));
            paramList.Add(new Parameters("@vehicleRequestId", wb.vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@userId", wb.userID.ToString()));
            paramList.Add(new Parameters("@Reason", wb.Reason.ToString()));
            paramList.Add(new Parameters("@Remark", wb.Remark.ToString()));
            IDataReader reader = null;
            reader = (new Connection()).ReadSp("ssp_CreateWaybillItemStatus", paramList);
            return reader != null;
        }

        public bool ToPayPaymentReceived(int wb)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WayBillItemId", wb.ToString()));           
            IDataReader reader = null;
            reader = (new Connection()).ReadSp("ssp_ToPayPaymentReceived", paramList);
            return reader != null;
        }
        public IDataReader CheckToPayStatus(int waybillItemID)
        {
            IDataReader Reader = null;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WayBillItemId", waybillItemID.ToString()));
            Reader = (new Connection()).ReadSp("ssp_GetToPayReceivedStatus", paramList);
            return Reader;
        }

        //**************************************************************** Transhipment Loading ***********************************************************************
        //Get Vehicle in Dropdown
        public List<pickUpVehicle> GetTranshipmentLoadingVehicles(int branchId)
        {
            List<pickUpVehicle> vehicleList = new List<pickUpVehicle>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", branchId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetTranshipLoadVehicleList", paramList);
            while (Reader.Read())
            {
                vehicleList.Add(new pickUpVehicle()
                {
                    VehicleRequestID = Convert.ToInt32(Reader["vehicleRequestId"].ToString()),
                    vehicleId = Convert.ToInt32(Reader["vehicleId"].ToString()),
                    VehicleRouteId = Convert.ToInt32(Reader["routeId"].ToString()),
                    vehicleNo = Reader["vehicleNo"].ToString()
                });
            }
            return vehicleList;
        }
        // Get List Of Loading Materials 
        //public List<WayBillDetails> GetLoadingWayBillDetails(string vehicleId)
        public List<WayBillDetails> GetLoadingWayBillDetails(string vehicleRequestId, string branchId, string manifestBranchId,string waybillNo)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@branchId", branchId));
            if(waybillNo!="")
            {
                paramList.Add(new Parameters("@waybillNo", waybillNo));
            }
            if (manifestBranchId != "") paramList.Add(new Parameters("@manifestBranchId", manifestBranchId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetManifestWayBillItems", paramList);

            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.invoiceNo = Reader["InvoiceNo"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty= Reader["remQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.branchId = Reader["BranchId"].ToString();
                wbDetail.toBranchId = Reader["toBranchId"].ToString();
                //  wbDetail.toBranchName = Reader["toBranchName"].ToString();
                wbDetail.BranchName = Reader["BranchName"].ToString();
                //    wbDetail.ManifestBranch = Reader["ManifestBranch"].ToString();
                wbDetail.ManifestBranch = Reader["ToBranchName"].ToString();
                wbDetail.toBranchName = Reader["pickUpBranchName"].ToString();
                //Avoid the waybills whose delivery is at the Branch Itself 
                if (wbDetail.toBranchId != branchId)
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        public List<WayBillDetails> GetManifestWayBillDetails(string routeId, string branchId, string manifestBranchId)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@routeId", routeId));
            paramList.Add(new Parameters("@branchId", branchId));
            paramList.Add(new Parameters("@manifestBranchId", manifestBranchId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetManifestWayBillItems", paramList);

            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["waybillID"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.WayBillItemId = Reader["WayBillItemId"].ToString();
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.invoiceNo = Reader["InvoiceNo"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.itemQty = Reader["itemQty"].ToString();
                wbDetail.remQty = Reader["remQty"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.branchId = Reader["BranchId"].ToString();
                wbDetail.toBranchId = Reader["toBranchId"].ToString();
                //  wbDetail.toBranchName = Reader["toBranchName"].ToString();
                wbDetail.BranchName = Reader["BranchName"].ToString();
                //    wbDetail.ManifestBranch = Reader["ManifestBranch"].ToString();
                wbDetail.ManifestBranch = Reader["ToBranchName"].ToString();
                wbDetail.toBranchName = Reader["pickUpBranchName"].ToString();
                //Avoid the waybills whose delivery is at the Branch Itself 
                if (wbDetail.toBranchId != branchId)
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        public List<WayBillDetails> GetManifestSelectedWayBillDetails(int branchId, int routeID)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchId.ToString()));
            paramList.Add(new Parameters("@routeID", routeID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetManifestTranshipmentDetail", paramList);
            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();
                wbDetail.waybillID = Reader["manifestTranshipmentDetailsID"].ToString();
                wbDetail.ManifestBranch = Reader["DeliveryBranchName"].ToString();
                wbDetail.wayBillHeader.wayBillNo = Reader["wayBillNo"].ToString();
                wbDetail.wayBillHeader.pickupDateTime = Reader["WaybillDate"].ToString();
                wbDetail.invoiceNo = Reader["invoiceNo"].ToString();  
                wbDetail.materialName = Reader["materialName"].ToString();
                wbDetail.packNAme = Reader["typeOfPackage"].ToString();
                wbDetail.valueActualWt = Reader["valueActualWt"].ToString();
                wbDetail.itemQty = Reader["qty"].ToString();
                waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }

        //Get Manifest Branch
        public List<WayBillDetails> GetManifestBranch(string vehicleRequestId, string branchId)
        {
            List<WayBillDetails> waybillDetails = new List<WayBillDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@branchId", branchId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetManifestBranch", paramList);

            WayBillDetails wbDetail;

            while (Reader.Read())
            {
                wbDetail = new WayBillDetails();              
                wbDetail.toBranchId = Reader["ToBranchId"].ToString();               
                wbDetail.ManifestBranch = Reader["ToBranchName"].ToString();
               wbDetail.routeName = Reader["routeName"].ToString();
                //Avoid the waybills whose delivery is at the Branch Itself 
                if (wbDetail.toBranchId != branchId)
                    waybillDetails.Add(wbDetail);
            }
            return waybillDetails;
        }
        public bool changeTranshipLoadStatus(WaybillItemStatus wb)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WayBillItemId", wb.WayBillItemId.ToString()));
            paramList.Add(new Parameters("@statusId", wb.statusID.ToString()));
            paramList.Add(new Parameters("@itemQty", wb.itemQty.ToString()));
            paramList.Add(new Parameters("@creationDateTime", wb.createdDateTime.ToString()));
            paramList.Add(new Parameters("@branchId", wb.branchID.ToString()));
            paramList.Add(new Parameters("@vehicleRequestId", wb.vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@userId", wb.userID.ToString()));
	        paramList.Add(new Parameters("@Remark", wb.Remark.ToString()));
            IDataReader reader = null;
         //   reader = (new Connection()).ReadSp("ssp_CreateWaybillItemStatus", paramList);
            reader = (new Connection()).ExecuteSpIS("ssp_CreateWaybillItemStatus", paramList);
            
            return reader != null;
        }

        public bool DeleteManifestTranshipment(string id)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@ID", id));          
            IDataReader reader = null;
            reader = (new Connection()).ReadSp("ssp_DeleteManifestTranshipmentDetails", paramList);
            return reader != null;
        }
        public bool SaveManifestTranshipment(Manifest manifestHeader)
        {
            PickReq session = new PickReq();
            session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
            session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"]);
            session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;

            paramList.Add(new Parameters("@date", manifestHeader.date.ToString()));
            paramList.Add(new Parameters("@routeId", manifestHeader.routeId.ToString()));
            paramList.Add(new Parameters("@remark", manifestHeader.remark.ToString()));
            paramList.Add(new Parameters("@UserId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));

            reader = (new Connection()).ExecuteSpIS("ssp_CreateManifestTranshipment", paramList);
            if (reader.Read())
            {
                manifestHeader.ID = Convert.ToInt32(reader["id"]);
                foreach (ManifestDetails detail in manifestHeader.ManifestDetail)
                {
                    #region DetailParameters

                    paramList = new List<Parameters>();
                    paramList.Add(new Parameters("@manifestTranshipmentID", manifestHeader.ID + ""));
                    paramList.Add(new Parameters("@waybillID", detail.waybillId + ""));
                    paramList.Add(new Parameters("@WayBillItemId", detail.WayBillItemId + ""));
                    paramList.Add(new Parameters("@qty", detail.qty.ToString()));
                   
                    #endregion

                    (new Connection()).ExecuteSp("ssp_CreateManifestTranshipmentDetails", paramList);
                }
            }
            return reader != null;
        }
        #region /*-----------------------------Load Data---------------------------------------*/
        //Load Route Header Data
        public string[] LoadRouteHeaderData(int vehicleRequestId)
        {
            List<string> RouteHeaderDetail = new List<string>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "RouteHeaderDetail"));
            paramList.Add(new Parameters("@vehicleRequesId", vehicleRequestId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetRouteDetails", paramList);
            while (Reader.Read())
            {
                RouteHeaderDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}",
                    Reader["FromBranch"], Reader["fromBranchID"], Reader["ToBranch"], Reader["toBranchID"], Reader["routeName"],
                    Reader["routeTotalDistance"], Reader["mapTotalDistance"]));

            }
            return RouteHeaderDetail.ToArray();
        }
        //Load Route Details Data
        public string[] LoadRouteDetailsData(int vehicleRequestId)
        {
            List<string> RouteDetail = new List<string>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "RouteDetails"));
            paramList.Add(new Parameters("@vehicleRequesId", vehicleRequestId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetRouteDetails", paramList);
            while (Reader.Read())
            {
                RouteDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}",
                    Reader["FromBranch"], Reader["fromBranchID"], Reader["ToBranch"], Reader["toBranchID"], Reader["routeDistance"],
                    Reader["mapDistance"]));

            }
            return RouteDetail.ToArray();
        }
        #endregion

        //Get Last Branch In Route
        public List<PickReq> GetWaybillListForPOD(int vehicleRequestId)
        {
            List<PickReq> waybillList = new List<PickReq>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CheckPOD", paramList);
            while (Reader.Read())
            {
                waybillList.Add(new PickReq()
                {
                    WaybillNo = Convert.ToInt32(Reader["wayBillNo"])
                });
            }
            return waybillList;
        }
    }

}
