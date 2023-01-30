using System;
using System.Collections.Generic;
using BLProperties;
//using CommonLibrary;
using System.Data;
using System.Web;
using NameSpaceConnection;
/// <summary>
/// Summary description for VehicleRequestFunction
/// </summary>


namespace BLFunctions
{
    public class VehicleRequestFunction
    {
        public static int VehicleRequestID;
        public VehicleRequestFunction()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        //Get Vehicle Details
        public List<VehicleRequestProperties> getVehicleDetail(string VehicleNo)
        {
            List<VehicleRequestProperties> VehicleDetaillist = new List<VehicleRequestProperties>();

            VehicleRequestProperties VehicleDetail;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VehicleNo", VehicleNo));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleDetailsUsingVehicleNo", paramList);
            while (Reader.Read())
            {
                VehicleDetail = new VehicleRequestProperties();
                VehicleDetail.VehicleID = Convert.ToInt32(Reader["vehicleID"]);
                VehicleDetail.VendorName = Reader["vendorName"].ToString().ToUpper();
                VehicleDetail.VehicleCategory = Reader["vehicleCategory"].ToString().ToUpper();
                VehicleDetail.VehicleType = Reader["vehicleType"].ToString().ToUpper();
                VehicleDetail.VehicleHiringType.Route = Reader["useForRoute"].ToString() == "TRUE" ? "ROUTE" : "";
                VehicleDetail.VehicleHiringType.PickUp = Reader["useForPickup"].ToString() == "TRUE" ? "PICKUP" : "";
                VehicleDetail.VehicleHiringType.Delivery = Reader["useForDelivery"].ToString() == "TRUE" ? "DELIVERY" : "";
                VehicleDetaillist.Add(VehicleDetail);
            }
            return VehicleDetaillist;
        }

        //Check VehicleNo Status
        public VehicleRequestProperties CheckVehicleNoStatus(int VehicleID)
        {
            VehicleRequestProperties VehicleNoStatus = new VehicleRequestProperties();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("VehicleId", VehicleID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_checkVehicleStatus", paramList);
            while (Reader.Read())
            {
                VehicleNoStatus.Status = Reader["Status"].ToString().ToUpper();
                VehicleNoStatus.CurrentBranch = Reader["CurrentBranch"].ToString().ToUpper();
            }
            return VehicleNoStatus;
        }


        //Get DriverName 
        public List<StaffDetail> getDriverName()
        {
            StaffDetail DriverName;
            List<Parameters> paramList = new List<Parameters>();
            List<StaffDetail> DriverList = new List<StaffDetail>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDriverList", paramList);
            while (Reader.Read())
            {
                DriverName = new StaffDetail();
                DriverName.Name = Reader["driverName"].ToString();
                DriverName.Id = Convert.ToInt32(Reader["driverID"]);
                DriverList.Add(DriverName);
            }
            return DriverList;
        }
        //Get Driver Details
        public StaffDetail getDriverDetail(int driverID)
        {
            StaffDetail DriverDetail = new StaffDetail();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@DriverID", driverID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDriverCreation", paramList);
            while (Reader.Read())
            {
                DriverDetail.ContactNo = Convert.ToInt64(Reader["driverContactNo"]);
            }
            return DriverDetail;
        }

        //Get PickUp Person
        public List<StaffDetail> getPickUpPerson()
        {
            StaffDetail PickUpPerson;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@DepartmentName", null));
            List<StaffDetail> PickUpPersonList = new List<StaffDetail>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetEmployeeList", paramList);
            while (Reader.Read())
            {
                PickUpPerson = new StaffDetail();
                PickUpPerson.Name = Reader["fullName"].ToString();
                PickUpPerson.Id = Convert.ToInt32(Reader["userID"]);
                PickUpPersonList.Add(PickUpPerson);
            }
            return PickUpPersonList;
        }

        //Get PickUpPerson Details
        public StaffDetail getPickUpPersonDetail(int PickUpPersonID)
        {
            StaffDetail PickUpPersonDetail = new StaffDetail();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@employeeId", PickUpPersonID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetEmployeeCreation", paramList);
            while (Reader.Read())
            {
                PickUpPersonDetail.ContactNo = Convert.ToInt64(Reader["contactNo"]);
            }
            return PickUpPersonDetail;
        }
        //Get RouteSchedule Data
        public List<RouteScheduleGrid> getRouteSchedule(int Routeid)
        {
            RouteScheduleGrid RouteSchedule;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@routeId", Routeid.ToString()));
            List<RouteScheduleGrid> RouteScheduleList = new List<RouteScheduleGrid>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetRouteSchedleName", paramList);
            while (Reader.Read())
            {
                RouteSchedule = new RouteScheduleGrid();
                RouteSchedule.scheduleId = Convert.ToInt32(Reader["routeScheduleMasterId"]);
                RouteSchedule.scheduleName = Reader["scheduleName"].ToString();
                RouteScheduleList.Add(RouteSchedule);
            }
            return RouteScheduleList;
        }

        //PickDetail Request View
        public List<PickReq> ViewAllPickUpData(int BranchId)
        {
            List<PickReq> pickReqList = new List<PickReq>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@pickUpBranchId", BranchId.ToString()));
            paramList.Add(new Parameters("@pickUpStatus", "OPEN"));
            IDataReader pickListReader = (new Connection()).ReadSp("ssp_ViewPickUPRequestList", paramList);
            PickReq PickReq;
            while (pickListReader.Read())
            {
                PickReq = new PickReq();
                PickReq.pickupID = Convert.ToInt32(pickListReader["pickupRequestID"]);
                PickReq.PickType = pickListReader["PickUpType"].ToString();
                PickReq.CustName = pickListReader["customerName"].ToString();
                PickReq.CustContactNo = pickListReader["contactNo"].ToString();
                PickReq.CustTelephone = pickListReader["telephoneNo"].ToString();
                PickReq.PickPINCode = pickListReader["locPincode"].ToString();
                PickReq.pickupArea = pickListReader["areaName"].ToString();
                PickReq.PickAddress = pickListReader["pickupAddress"].ToString();
                pickReqList.Add(PickReq);
            }

            return pickReqList;
        }

        //PickDetail Request View
        public List<PickReq> ViewAllWaybillData(int BranchId)
        {
            List<PickReq> DeliveryList = new List<PickReq>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchID", BranchId.ToString()));
            IDataReader DeliveryReader = (new Connection()).ReadSp("ssp_GetDeliveryWaybillList", paramList);
            PickReq PickReq;
            while (DeliveryReader.Read())
            {
                PickReq = new PickReq();
                PickReq.WaybillId = Convert.ToInt32(DeliveryReader["waybillID"]);
                PickReq.WaybillNo = Convert.ToInt32(DeliveryReader["wayBillNo"]);
                PickReq.CustName = DeliveryReader["customerName"].ToString();
                PickReq.CustContactNo = DeliveryReader["customerContactNo"].ToString();
                PickReq.ConsigneeName = DeliveryReader["consigneeName"].ToString();
                PickReq.ConsigneeContactNo = DeliveryReader["consigneeContactNo"].ToString();
                PickReq.DelPINCode = DeliveryReader["locPincode"].ToString();
                PickReq.DelArea = DeliveryReader["areaName"].ToString();
                PickReq.DelAddress = DeliveryReader["consigneeAddress"].ToString();
                PickReq.PaymentMode = DeliveryReader["paymentMode"].ToString();
                DeliveryList.Add(PickReq);
            }

            return DeliveryList;
        }

        //RouteWaybill BranchWise Detail View
        public List<PickReq> ViewAllRouteBranchWiseData(string BranchId)
        {
            List<PickReq> RouteWaybillList = new List<PickReq>();

            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", BranchId));
            IDataReader RouteWaybillReader = (new Connection()).ReadSp("ssp_ViewRouteWayBillsDetail", paramList);
            PickReq BranchWiseWaybill;
            while (RouteWaybillReader.Read())
            {
                BranchWiseWaybill = new PickReq();
                BranchWiseWaybill.WaybillId = Convert.ToInt32(RouteWaybillReader["waybillID"]);
                BranchWiseWaybill.WaybillNo = Convert.ToInt32(RouteWaybillReader["wayBillNo"]);

                //PickReq.pickupID = Convert.ToInt32(pickListReader["pickupID"]);
                //PickReq.PickType = pickListReader["PickUpType"].ToString();
                //PickReq.PickDate = pickListReader["pickUPDate"].ToString();
                //PickReq.CustCode = pickListReader["customerNo"].ToString();
                //PickReq.Id = Convert.ToInt32(pickListReader["customerID"]);
                //PickReq.CustName = pickListReader["customerName"].ToString();
                //PickReq.CustContactNo = Convert.ToInt32(pickListReader["contactNo"]);
                //PickReq.CustTelephone = pickListReader["telephoneNo"].ToString();
                //PickReq.PickLocID = Convert.ToInt32(pickListReader["pickupLocID"]);
                //PickReq.PickPINCode = pickListReader["pickupPincode"].ToString();
                //PickReq.PickAreaID = Convert.ToInt32(pickListReader["pickupAreaID"]);
                //PickReq.pickupArea = pickListReader["pickupArea"].ToString();
                //PickReq.PickAddress = pickListReader["pickupAddress"].ToString();
                RouteWaybillList.Add(BranchWiseWaybill);
            }
            return RouteWaybillList;
        }
        //PickDetail Request Not Added PickUp View
        //public List<PickReq> ViewAlreadyAddedPickDelLHSData(int BrnachId, int pickdelId)
        //{
        //    List<PickReq> pickReqList = new List<PickReq>();
        //    List<Parameters> paramList = new List<Parameters>();
        //    paramList.Add(new Parameters("@Event", "ViewAlreadyAddPickup"));
        //    paramList.Add(new Parameters("@BranchId", BrnachId.ToString()));
        //    paramList.Add(new Parameters("@PickupId", pickdelId.ToString()));
        //    IDataReader pickListReader = (new Connection()).ReadSp("spViewPickLHSDetail", paramList);
        //    PickReq PickReq;
        //    while (pickListReader.Read())
        //    {
        //        PickReq = new PickReq();
        //        PickReq.pickupID = Convert.ToInt32(pickListReader["pickupID"]);
        //        PickReq.PickType = pickListReader["PickUpType"].ToString();
        //        PickReq.CustName = pickListReader["customerName"].ToString();
        //        PickReq.CustContactNo = Convert.ToInt32(pickListReader["contactNo"]);
        //        PickReq.CustTelephone = pickListReader["telephoneNo"].ToString();
        //        PickReq.PickPINCode = pickListReader["pickupPincode"].ToString();
        //        PickReq.pickupArea = pickListReader["pickupArea"].ToString();
        //        PickReq.PickAddress = pickListReader["pickupAddress"].ToString();
        //        pickReqList.Add(PickReq);
        //    }
        //    return pickReqList;
        //}


        //Save PickDelLHS Data
        public int SaveVehicleRequestLHS(VehicleRequestProperties VehicleRequestLHS)
        {
            List<Parameters> paramList = new List<Parameters>();
            //IDataReader reader = null;
            DataTable reader;

            #region HeaderParameter
            paramList.Add(new Parameters("@vehicleRequestType", VehicleRequestLHS.vehicleReqType));
            paramList.Add(new Parameters("@vehicleId", VehicleRequestLHS.VehicleID.ToString()));
            paramList.Add(new Parameters("@noOfLabour", VehicleRequestLHS.NoOfLabour.ToString()));
            paramList.Add(new Parameters("@hiringDate", VehicleRequestLHS.hiringDate.ToString()));
            paramList.Add(new Parameters("@mPin", VehicleRequestLHS.Mpin.ToString()));
            paramList.Add(new Parameters("@userID", VehicleRequestLHS.sessionDetail.UserID.ToString()));
            paramList.Add(new Parameters("@branchID", VehicleRequestLHS.sessionDetail.BranchID.ToString()));        
            paramList.Add(new Parameters("@routeId", VehicleRequestLHS.routeId.ToString()));
            paramList.Add(new Parameters("@routeScheduleMasterId", VehicleRequestLHS.routeScheduleMasterId.ToString()));
            paramList.Add(new Parameters("@deliveryRouteId", VehicleRequestLHS.deliveryRouteId.ToString()));
            paramList.Add(new Parameters("@remark", VehicleRequestLHS.Remark.ToString()));
            paramList.Add(new Parameters("@creationDateTime", VehicleRequestLHS.sessionDetail.CreationDateTime.ToString()));
            #endregion
            reader = (new Connection()).Fillsp("ssp_CreateVehicleLHS", paramList);

            //if (reader.Read())
            if (reader.Rows.Count > 0)
            {
                //PickReqId = Convert.ToInt32(reader.Columns["Id"].ToString());
                VehicleRequestID = Convert.ToInt32(reader.Rows[0][0].ToString());

                //Account Details
                if(VehicleRequestLHS.acct != null)
                {
                    foreach (AccountDetail Account in VehicleRequestLHS.acct)
                    {
                        #region DetailParameters
                        paramList = new List<Parameters>();
                        paramList.Add(new Parameters("@vehicleRequestId", VehicleRequestID.ToString()));
                        paramList.Add(new Parameters("@RateTypeId", Account.AccountId.ToString()));
                        paramList.Add(new Parameters("@AccountValue", Account.AccountValue.ToString()));
                        paramList.Add(new Parameters("@Remark", Account.Remark.ToString()));
                        #endregion
                        (new Connection()).ExecuteSp("ssp_CreateVehicleAccount", paramList);
                    }
                }
               
                //Staff Details
                foreach (StaffDetail Staff in VehicleRequestLHS.staff)
                {
                    #region DetailParameters
                    paramList = new List<Parameters>();
                    paramList.Add(new Parameters("@vehicleRequestId", VehicleRequestID.ToString()));
                    paramList.Add(new Parameters("@staffType", Staff.Type));
                    paramList.Add(new Parameters("@staffID", Staff.Id.ToString()));
                    #endregion
                    (new Connection()).ExecuteSp("ssp_CreateVehicleStaff", paramList);
                }

                if (VehicleRequestLHS.vehicleReqType == "PD")
                {
                    SaveVehicleRequestPickup(VehicleRequestLHS, VehicleRequestID);
                    SaveTranshipDeliveryWaybill(VehicleRequestLHS, VehicleRequestID);
                }
                else if (VehicleRequestLHS.vehicleReqType == "RT")
                    SaveTranshipDeliveryWaybill(VehicleRequestLHS, VehicleRequestID);
            }
            return VehicleRequestID;
        }
        public void SaveVehicleRequestPickup(VehicleRequestProperties VehicleRequestLHS, int VehicleRequestID)
        {
            //Save PicReq Details
            foreach (PickReq detail in VehicleRequestLHS.listPickReq)
            {
                #region DetailParameters
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@VehicleRequestID", VehicleRequestID.ToString()));
                paramList.Add(new Parameters("@pickupID", detail.Id.ToString()));
                #endregion
                (new Connection()).ExecuteSp("ssp_CreateVehiclePickUps", paramList);
            }
        }

        public void SaveTranshipDeliveryWaybill(VehicleRequestProperties VehicleRequestLHS, int VehicleRequestID)
        {
            //Save TranshipLHS Details
            foreach (PickReq detail in VehicleRequestLHS.listwaybill)
            {
                #region DetailParameters
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@VehicleRequestID", VehicleRequestID.ToString()));
                paramList.Add(new Parameters("@waybillId", detail.WaybillId.ToString()));
                #endregion
                (new Connection()).ExecuteSp("ssp_CreateVehicleWayBill", paramList);
            }
        }
        //Save PickDelLHS Status
        public bool SaveVehicleRequestLHSStatus(VehicleRequestProperties VehicleRequestStatus)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            int id;
            paramList.Add(new Parameters("@VehicleRequestID", VehicleRequestStatus.VehicleRequestID.ToString()));
            paramList.Add(new Parameters("@statusId", VehicleRequestStatus.StatusID.ToString()));
            paramList.Add(new Parameters("@KM", VehicleRequestStatus.KMS.ToString()));
            paramList.Add(new Parameters("@remark", VehicleRequestStatus.Remark.ToString()));
            paramList.Add(new Parameters("@userID", VehicleRequestStatus.sessionDetail.UserID.ToString()));
            paramList.Add(new Parameters("@creationDateTime", VehicleRequestStatus.sessionDetail.CreationDateTime.ToString()));
            paramList.Add(new Parameters("@BranchId", VehicleRequestStatus.sessionDetail.BranchID.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateVehicleStatus", paramList);
            if (reader.Read())
            {
                id = Convert.ToInt32(reader["id"]);
                if(VehicleRequestStatus.sealNo!=null)
                {
                    paramList = new List<Parameters>();
                    paramList.Add(new Parameters("@sealNo", VehicleRequestStatus.sealNo.ToString()));
                    paramList.Add(new Parameters("@vehicleRequestStatusId", id.ToString()));
                    (new Connection()).ExecuteSp("ssp_UpdateSealNo", paramList);
                }
            }
            return reader != null;
        }



        // Get Vehicle Request Details in GridView
        public List<VehicleRequestProperties> ViewData(int brnachId, string routeType)
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", brnachId.ToString()));
            paramList.Add(new Parameters("@routeType", routeType.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_ViewVehicleRequestData", paramList);
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                vehicleData.hiringDate = reader["hiringDate"].ToString();
                vehicleData.sessionDetail.UserBranch = reader["branchName"].ToString();
                vehicleData.VehicleID = Convert.ToInt32(reader["vehicleID"]);
                vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                if (routeType == "PD")
                    vehicleData.totalAttachPickup = Convert.ToInt32(reader["AttachCountPickup"]);
                vehicleData.totalAttachWaybill = Convert.ToInt32(reader["AttachCountWaybill"]);
                if (routeType == "RT")
                {

                    vehicleData.sealNo = reader["sealNo"].ToString();
                    vehicleData.routeName = reader["routeName"].ToString();
                    vehicleData.CurrentBranch = reader["CurrentBranch"].ToString();
                }
                vehicleData.Mpin = Convert.ToInt32(reader["mPin"]);
                vehicleData.Status = reader["status"].ToString();
                vehicleData.sessionDetail.CreationDateTime = reader["creationDateTime"].ToString();

                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        }


        // Get Vehicle Request Approve/Reject Details in GridView
        public List<VehicleRequestProperties> ViewVehicleCreatedData(int brnachId)
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", brnachId.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_ViewVehicleReqCreatedData", paramList);
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                vehicleData.hiringDate = reader["hiringDate"].ToString();
                vehicleData.Remark = reader["remark"].ToString();
                vehicleData.sessionDetail.UserBranch = reader["branchName"].ToString();
                vehicleData.VehicleID = Convert.ToInt32(reader["vehicleID"]);
                vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                vehicleData.totalAttachPickup = Convert.ToInt32(reader["AttachCountPickup"]);
                vehicleData.totalAttachWaybill = Convert.ToInt32(reader["AttachCountWaybill"]);
                vehicleData.Status = reader["status"].ToString();
                vehicleData.sessionDetail.CreationDateTime = reader["creationDateTime"].ToString();
		vehicleData.sessionDetail.UserName = reader["UserName"].ToString();

                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        }

        // Get Vehicle Account Details in GridView
        public List<AccountDetail> ViewAccountDetailOnVehicle(int vehicleRequestID)
        {
            List<AccountDetail> AccounttList = new List<AccountDetail>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestID", vehicleRequestID.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_GetVehicleAccountList", paramList);
            while (reader.Read())
            {
                AccountDetail vehicleData = new AccountDetail();
                vehicleData.AccountName = reader["AccountMasterName"].ToString();
                vehicleData.AccountValue = Convert.ToDecimal(reader["AccountValue"]);
                vehicleData.Remark = reader["Remark"].ToString();
                AccounttList.Add(vehicleData);
            }
            return AccounttList;
        }
        public List<VehicleRequestProperties> ViewTranshipVehicleCreatedData(int brnachId)
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", brnachId.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_ViewTranshipVehicleReqCreatedData", paramList);
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                vehicleData.hiringDate = reader["hiringDate"].ToString();
                vehicleData.Remark = reader["remark"].ToString();
                vehicleData.sessionDetail.UserBranch = reader["branchName"].ToString();
                vehicleData.VehicleID = Convert.ToInt32(reader["vehicleID"]);
                vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                vehicleData.totalAttachPickup = Convert.ToInt32(reader["AttachCountPickup"]);
                vehicleData.totalAttachWaybill = Convert.ToInt32(reader["AttachCountWaybill"]);
                vehicleData.Status = reader["status"].ToString();
                vehicleData.sessionDetail.CreationDateTime = reader["creationDateTime"].ToString();
                vehicleData.sessionDetail.UserName = reader["UserName"].ToString(); 

                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        }
        public List<VehicleRequestProperties> ViewTranshipVehicleList(int branchId, string vehicleRequestType = "")
        {
            List<VehicleRequestProperties> lstVehicleList = (new VehicleRequestFunction()).ViewVehicleList(branchId, 2, vehicleRequestType);
            lstVehicleList.AddRange((new VehicleRequestFunction()).ViewVehicleList(branchId, 4, vehicleRequestType));
            return lstVehicleList; 
        }
        public List<VehicleRequestProperties> ViewVehicleList(int branchId, int Status = 0, string vehicleRequestType = "")
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchID", branchId.ToString()));
            paramList.Add(new Parameters("@Status", Status.ToString()));
            paramList.Add(new Parameters("@vehicleRequestType", vehicleRequestType.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_GetVehicleList", paramList);
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                vehicleData.routeName = reader["routeName"].ToString();
                vehicleData.toBranchId = reader["toBranchId"].ToString();
                vehicleData.creationDateTime = reader["creationDateTime"].ToString();  
                if (reader["vehicleRequestType"].ToString() == "PD")
                    vehicleData.vehicleReqType = "PICKUP/DELIVERY";
                else if (reader["vehicleRequestType"].ToString() == "RT")
                    vehicleData.vehicleReqType = "TRANSHIPMENT";

                //Get the vehicle distance by Google Point 
		//if (1==2) //Commented, as it was taking too much time. 
		{
                try
                {
                    geoPosition ngeo1 = (new VehicleMovement()).GetVehicleLatitudeLongitude(vehicleData.VehicleNo);
                    geoPosition ngeo2 = (new VehicleMovement()).getBranchLatitudeLongitude(branchId.ToString());
                    string strDistance = (new VehicleMovement()).geoCodeDistance(ngeo1, ngeo2);
                    vehicleData.distance = strDistance;// ngeo.latitude + ";" + ngeo.longitude; 
                }
                catch(Exception ex)
                {
                }
		}

                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        } 

        // Get Pickup Vehicle Park Details in GridView
        public List<VehicleRequestProperties> ViewVehicleParkData(int branchId)
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            //if(Convert.ToInt32(Session["userID"]) != 5) paramList.Add(new Parameters("@BranchId", branchId.ToString()));
	    paramList.Add(new Parameters("@BranchId", branchId.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_GetParkVehicleListNew", paramList);
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                vehicleData.routeName = reader["routeName"].ToString();
                vehicleData.creationDateTime = reader["creationDateTime"].ToString();  

                if (reader["vehicleRequestType"].ToString() == "PD")
                    vehicleData.vehicleReqType = "PICKUP/DELIVERY";
                else if (reader["vehicleRequestType"].ToString() == "RT")
                    vehicleData.vehicleReqType = "TRANSHIPMENT";
                vehicleData.routeName = reader["routeName"].ToString();

                //Get the vehicle distance by Google Point 
                try
                {
                    geoPosition ngeo1 = (new VehicleMovement()).GetVehicleLatitudeLongitude(vehicleData.VehicleNo);
                    geoPosition ngeo2 = (new VehicleMovement()).getBranchLatitudeLongitude(branchId.ToString());
                    string strDistance = (new VehicleMovement()).geoCodeDistance(ngeo1, ngeo2);
                    vehicleData.distance = strDistance;// ngeo.latitude + ";" + ngeo.longitude; 
                }
                catch
                { }
                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        }
              
        // Get Vehicle Dispatch Details in GridView
        public List<VehicleRequestProperties> ViewVehicleDispatchData(int branchId)
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", branchId.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_GetDispatchVehicleList", paramList);
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                CheckVehicleDispatchData(Convert.ToInt32(reader["VehicleRequestID"]));
                if (CFunctions.ID != Convert.ToInt32(reader["VehicleRequestID"]))
                {
                    vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                    vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                    if (reader["vehicleRequestType"].ToString() == "PD")
                        vehicleData.vehicleReqType = "PICKUP/DELIVERY";
                    else if (reader["vehicleRequestType"].ToString() == "RT")
                        vehicleData.vehicleReqType = "TRANSHIPMENT";
                    vehicleData.routeName = reader["routeName"].ToString(); 
                    ViewVehicleRequestList.Add(vehicleData);
                }
            }
            return ViewVehicleRequestList;
        }
         public List<VehicleRequestProperties> getVehicleListForEwaybill(int branchId)
        {           
            List<Parameters> paramList = new List<Parameters>();
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            paramList.Add(new Parameters("@branchID", branchId.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_EWaybillVehicleNo", paramList);
            while (Reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(Reader["VehicleRequestID"]);
                vehicleData.VehicleNo = Reader["vehicleNo"].ToString();
                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        }
        // Check Vehicle Pickup/Delivery Dispatch OR not
        public int CheckVehicleDispatchData(int VehicleRequestID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VehicleRequestID", VehicleRequestID.ToString()));
            IDataReader reader = (new Connection()).ReadSp("ssp_CheckDispatchVehicleList", paramList);
            while (reader.Read())
            {
                CFunctions.setID(Convert.ToInt32(reader["VehicleRequestID"]));
            }
            return CFunctions.ID;
        }

        //Get Waybill Rate Type List 
        public string[] getWaybillRateType(string searchPrefixText, string data)
        {
            int count = 0;
            List<string> RateType = new List<string>();
            DataTable dtTable = null;
            if (HttpContext.Current.Application["RateType"] == null)
            {
                List<Parameters> paramList = new List<Parameters>();
                dtTable = (new Connection()).Fillsp("ssp_GetWaybillRateType", paramList);
                HttpContext.Current.Application["RateType"] = dtTable;
            }
            else
            {
                dtTable = HttpContext.Current.Application["RateType"] as DataTable;
            }
            if (searchPrefixText != "")
            {
                string expression = "RateTypeName like '%" + searchPrefixText + "%'";
                DataRow[] rows = dtTable.Select(expression);

                if (data == "GetData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        RateType.Add(string.Format("{0}ʭ{1}", dr["RateTypeName"].ToString(), dr["RateTypeId"].ToString()));
                    }
                }
                else if (data == "ReadData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        RateType.Add(string.Format("{0}ʭ{1}", dr["RateTypeName"].ToString(), dr["RateTypeId"].ToString()));
                        break;
                    }
                }
            }
            if (count == 0) RateType.Add(string.Format("{0}ʭ{1}", "", ""));
            return RateType.ToArray();

        }

        //Get Vehicle Rate Type List 
        public string[] getVehicleRateType(string searchPrefixText, string data)
        {
            int count = 0;
            List<string> RateType = new List<string>();
            DataTable dtTable = null;
            if (HttpContext.Current.Application["RateType"] == null)
            {
                List<Parameters> paramList = new List<Parameters>();
                dtTable = (new Connection()).Fillsp("ssp_GetVehicleRateType", paramList);
                HttpContext.Current.Application["RateType"] = dtTable;
            }
            else
            {
                dtTable = HttpContext.Current.Application["RateType"] as DataTable;
            }
            if (searchPrefixText != "")
            {
                string expression = "RateTypeName like '%" + searchPrefixText + "%'";
                DataRow[] rows = dtTable.Select(expression);

                if (data == "GetData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        RateType.Add(string.Format("{0}ʭ{1}", dr["RateTypeName"].ToString(), dr["RateTypeId"].ToString()));
                    }
                }
                else if (data == "ReadData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        RateType.Add(string.Format("{0}ʭ{1}", dr["RateTypeName"].ToString(), dr["RateTypeId"].ToString()));
                        break;
                    }
                }
            }
            if (count == 0) RateType.Add(string.Format("{0}ʭ{1}", "", ""));
            return RateType.ToArray();

        }

        // Get Waybill Items Details for LoadedQty in GridView
          public DataTable GetLoadedItemList(int vehicleRequestId, int statusId, string branchID=null)
        {
            List<Parameters> paramList = new List<Parameters>();        
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@statusId", statusId.ToString()));
            if(branchID!=null) paramList.Add(new Parameters("@branchId", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_getWaybillLoadedQtyOnVehicleList", paramList);
            return dt;
        }
        public DataTable GetDeliveredWaybillList(string waybillNo)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@waybillNo", waybillNo.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_DeliveredWaybills", paramList);
            return dt;
        }
        // Get Waybill Items Details for ReceivedQty in GridView
        public DataTable GetReceivedItemList(int vehicleRequestId, int statusId, int branchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@statusId", statusId.ToString()));
            if(branchId != 0) paramList.Add(new Parameters("@branchId", branchId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_getWaybillReceivedQtyOnVehicleList", paramList);
            return dt;
        }
	public IDataReader ViewVehicleVendorRequests(string fromDate, string toDate, string VendorTrips, string VendorId, string BranchId, string vehicleno, string routeid) 
        {
            List<Parameters> paramList = new List<Parameters>(); 
            if (fromDate != "") paramList.Add(new Parameters("@fromDate", fromDate)); 
            if (toDate != "") paramList.Add(new Parameters("@toDate", toDate)); 
            if (VendorTrips != "") paramList.Add(new Parameters("@VendorTrips", VendorTrips)); 
            if (VendorId != "") paramList.Add(new Parameters("@VendorId", VendorId)); 
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId)); 
            if (vehicleno != "") paramList.Add(new Parameters("@vehicleno", vehicleno)); 
            if (routeid != "0") paramList.Add(new Parameters("@RouteId", routeid)); 
            IDataReader Reader = (new Connection()).ReadSp("ssp_ViewVehicleVendorList", paramList); 
            return Reader;
        }
	public IDataReader ViewVehicleVendorWayBills(string VendorTrips)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (VendorTrips != "") paramList.Add(new Parameters("@VendorTrips", VendorTrips));
            IDataReader Reader = (new Connection()).ReadSp("dbo.ssp_GetVendorInvoiceWayBills", paramList);
            return Reader;
        }
        public IDataReader CreateVendorInvoice(string VendorTrips)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VendorTrips", VendorTrips));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreateVendorBill", paramList);
            return Reader;
        }


        #region /*-----------------------------Load Data---------------------------------------*/
        //Load PickDelLHS Data
        public VehicleRequestProperties LoadData(int VehicleRequestID)
        {
            VehicleRequestProperties vehicleRequestDetail = new VehicleRequestProperties();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "GetVehicleRequestLHS"));
            paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleRequestDetail", paramList);
            while (Reader.Read())
            {
                vehicleRequestDetail.VehicleNo = Reader["vehicleNo"].ToString();
                List<VehicleRequestProperties> VehicleDetail = (new VehicleRequestFunction()).getVehicleDetail(vehicleRequestDetail.VehicleNo);
                foreach (VehicleRequestProperties Detail in VehicleDetail)
                {
                    vehicleRequestDetail.VendorName = Detail.VendorName;
                    vehicleRequestDetail.VehicleCategory = Detail.VehicleCategory;
                    vehicleRequestDetail.VehicleType = Detail.VehicleType;
                    break;
                }

                vehicleRequestDetail.NoOfLabour = Convert.ToInt32(Reader["noOfLabour"]);
                vehicleRequestDetail.sealNo = Reader["sealNo"].ToString();
                vehicleRequestDetail.routeId = Convert.ToInt32(Reader["routeId"]);
                vehicleRequestDetail.routeScheduleMasterId = Convert.ToInt32(Reader["routeScheduleMasterId"]);
                List<StaffDetail> StaffList = new List<StaffDetail>();
                IDataReader StaffReader = (new VehicleRequestFunction()).LoadDataStaff(VehicleRequestID);
                while (StaffReader.Read())
                {
                    StaffDetail staff = new StaffDetail();
                    staff.Type = StaffReader["staffType"].ToString();
                    if (staff.Type == "DRIVER")
                    {
                        staff.Id = Convert.ToInt32(StaffReader["staffID"].ToString());
                        StaffDetail DriverDetail = (new VehicleRequestFunction()).getDriverDetail(staff.Id);
                        staff.Name = DriverDetail.Name;
                        staff.ContactNo = DriverDetail.ContactNo;
                    }
                    else if (staff.Type == "PICKUP PERSON")
                    {
                        staff.Id = Convert.ToInt32(StaffReader["staffID"].ToString());
                        StaffDetail PickUpPersonDetail = (new VehicleRequestFunction()).getPickUpPersonDetail(staff.Id);
                        staff.Name = PickUpPersonDetail.Name;
                        staff.ContactNo = PickUpPersonDetail.ContactNo;
                    }
                    StaffList.Add(staff);
                }
                vehicleRequestDetail.staff = StaffList;
            }
            return vehicleRequestDetail;
        }
        //Load PickDelLHS Staff Data
        public IDataReader LoadDataStaff(int VehicleRequestID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "GetVehicleRequestLHSStaffDetail"));
            paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestID.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleRequestDetail", paramList);
            return Reader;
        }
		public IDataReader GetVendorDetails(string VendorId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VendorId", VendorId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetVendorCreation", paramList);
            return Reader;
        }

        #endregion
        public List<VehicleRequestProperties>  VehiclesRunning()
        {
            List<VehicleRequestProperties> ViewVehicleRequestList = new List<VehicleRequestProperties>();
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = (new Connection()).ReadSp("ssp_ViewVehicleRequestDataInRun", paramList); 
            while (reader.Read())
            {
                VehicleRequestProperties vehicleData = new VehicleRequestProperties();
                vehicleData.VehicleRequestID = Convert.ToInt32(reader["VehicleRequestID"]);
                vehicleData.BranchName = reader["branchName"].ToString();
                vehicleData.hiringDate = reader["hiringDate"].ToString();
                vehicleData.sessionDetail.UserBranch = reader["branchName"].ToString();
                vehicleData.VehicleID = Convert.ToInt32(reader["vehicleID"]);
                vehicleData.VehicleNo = reader["vehicleNo"].ToString();
                vehicleData.sealNo = reader["sealNo"].ToString();
                vehicleData.routeName = reader["routeName"].ToString();
                vehicleData.CurrentBranch = reader["CurrentBranch"].ToString();
                vehicleData.Mpin = Convert.ToInt32(reader["mPin"]);
                vehicleData.Status = reader["status"].ToString();
                vehicleData.latitude = reader["latitude"].ToString();
                vehicleData.longitude = reader["longitude"].ToString();
                vehicleData.sessionDetail.CreationDateTime = reader["creationDateTime"].ToString();
		vehicleData.vehicleReqType = reader["vehicleRequestType"].ToString(); 
                vehicleData.routeId = Convert.ToInt32(reader["routeId"].ToString());

                ViewVehicleRequestList.Add(vehicleData);
            }
            return ViewVehicleRequestList;
        }

        public DataTable ViewVehicleMovementsNew(string VehicleRequestId = "", string BranchId = "", 
                                                string FromDate = "", string ToDate = "", 
                                                string vehicleRequestType= "", string vehicleType = "", string vehicleno = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (VehicleRequestId != "") paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestId));
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            if (FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate));
            if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));
            if(vehicleRequestType != "") paramList.Add(new Parameters("@vehicleRequestType", vehicleRequestType));
            if(vehicleType != "") paramList.Add(new Parameters("@vehicleType", vehicleType));
            paramList.Add(new Parameters("@vehicleno ", vehicleno));
            DataTable dt = (new Connection()).Fillsp("ssp_VehicleRequestStatusNew", paramList);
            return dt;
        }
        public void saveVehicleRequestTripDetails(string VehicleRequestid, string startDate, string startTime, string endDate, string endTime, string startKM, string endKM)
        { 
            List<Parameters> paramList = new List<Parameters>(); 
            paramList.Add(new Parameters("@VehicleRequestid", VehicleRequestid)); 
            paramList.Add(new Parameters("@TripStartDate", startDate)); 
            paramList.Add(new Parameters("@TripStartTime", startTime)); 
            paramList.Add(new Parameters("@TripEndDate", endDate)); 
            paramList.Add(new Parameters("@TripEndTime", endTime)); 
            paramList.Add(new Parameters("@StartKM", startKM)); 
            paramList.Add(new Parameters("@EndKM", endKM)); 
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreateVehicleRequestReading", paramList); 
        }
        public void saveVehicleRequestExpense(string VehicleRequestid, string VehicleExpenseTypeId, string @VehicleExpenseName, string qty, string rate, string Expense)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VehicleRequestid", VehicleRequestid));
            paramList.Add(new Parameters("@VehicleExpenseTypeId", VehicleExpenseTypeId));
            paramList.Add(new Parameters("@qty", qty));
            paramList.Add(new Parameters("@rate", rate));
            paramList.Add(new Parameters("@VehicleExpenseName", VehicleExpenseName));
            paramList.Add(new Parameters("@Expense", Expense));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreateVehicleExpense", paramList);
        }
        public DataTable ViewVehicleRequestExpense(string VehicleRequestId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestId));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewVehicleRequestExpense", paramList);
            return dt;
        }
    }
}