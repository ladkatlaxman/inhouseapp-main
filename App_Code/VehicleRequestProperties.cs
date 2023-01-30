using System;
using System.Collections.Generic;

/// <summary>
/// Summary description for VehicleRequestProperties
/// </summary>
namespace BLProperties
{
    public class VehicleRequestProperties
    {
        private VehicleHiringType VehHirType;
        private sessionDetails session;
        public VehicleRequestProperties()
        {
            if (VehHirType == null) VehHirType = new VehicleHiringType();
            if (session == null) session = new sessionDetails();
            //
            // TODO: Add constructor logic here
            //
        }
        public int VehicleRequestID { get; set; }
        public string vehicleReqType { get; set; }
        public int VehicleID { get; set; }
        public string VehicleNo { get; set; }
       // public string VehicleHiringType { get; set; }

        public VehicleHiringType VehicleHiringType
        {
            get
            {
                return VehHirType;
            }
            set
            {
                VehHirType = value;
            }
        }
        public string VendorName { get; set; }
        public string VehicleCategory { get; set; }
        public string VehicleType { get; set; }
        public int NoOfLabour { get; set; }
        public string hiringDate { get; set; }
        public int Mpin { get; set; }
        public string sealNo { get; set; }
        public int routeId { get; set; }
        public string routeName { get; set; }
        public int routeScheduleMasterId { get; set; }
        public int deliveryRouteId { get; set; }
        public int StatusID { get; set; }
        public string Status { get; set; }
        public decimal KMS { get; set; }
        public string Remark { get; set; }
        public string CurrentBranch { get; set; }
        public string creationDateTime { get; set; }
        public sessionDetails sessionDetail
        {
            get
            {
                return session;
            }
            set
            {
                session = value;
            }
        }
        public int totalAttachPickup { get; set; }
        public string toBranchId { get; set; }
        public int totalAttachWaybill { get; set; }
        public string distance { get; set; }
        public string ReasonForRequest { get; set; }
        public string BranchName { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }

        public List<StaffDetail> staff { get; set; }
        public List<AccountDetail> acct { get; set; }
        public List<PickReq> listPickReq { get; set; }
        public List<PickReq> listwaybill { get; set; }
    }
    public class StaffDetail
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Name { get; set; }
        public long ContactNo { get; set; }
    }
    public class AccountDetail
    {
        public int AccountId { get; set; }
        public string AccountName { get; set; }
        public decimal AccountValue { get; set; }
        public string Remark { get; set; }
    }
    public class VehicleHiringType
    {
        public string Route { get; set; }
        public string PickUp { get; set; }
        public string Delivery { get; set; }
    }
    public class Vehicle
    {
        public int vehicleId { get; set; }
        public String vehicleNo { get; set; }
    }

    public class pickUpVehicle : Vehicle
    {
        public int VehicleRequestID { get; set; }
        public int VehicleRouteId { get; set; }
        public int branchID { get; set; }
    }
}
