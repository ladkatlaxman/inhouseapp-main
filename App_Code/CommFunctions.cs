using BLProperties;
using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.IO; 

/// <summary>
/// Summary description for CommFunctions
/// </summary>
namespace BLFunctions
{

    public class CommFunctions
    {
        public CommFunctions()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        //Get Branch ID
        public sessionDetails getBranchID(string BranchName)
        {
            sessionDetails branchId = new sessionDetails();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchName", BranchName));
            IDataReader Reader = (new Connection()).ReadSp("spBindBranchId", paramList);
            while (Reader.Read())
            {
                branchId.BranchID = Convert.ToInt32(Reader["branchID"]);
            }
            return branchId;
        }

        //Get Pincode 
        public string[] getPincode(string searchPrefixText, string data)
        {
            int count = 0;
            List<string> pincode = new List<string>();
            DataTable dtTable = null;
            if (HttpContext.Current.Application["Pincode"] == null)
            {
                List<Parameters> paramList = new List<Parameters>();
                dtTable = (new Connection()).Fillsp("ssp_GetPincodeList", paramList);
                HttpContext.Current.Application["Pincode"] = dtTable;
            }
            else
            {
                dtTable = HttpContext.Current.Application["Pincode"] as DataTable;
            }
            if (searchPrefixText != "")
            {
                string expression = "CONVERT(LocPincode,System.String) like '%" + searchPrefixText + "%'";
                DataRow[] rows = dtTable.Select(expression);

                if (data == "GetData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        pincode.Add(string.Format("{0}ʭ{1}", dr["LocPincode"].ToString(), dr["locID"].ToString()));
                    }
                }
                else if (data == "ReadData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        pincode.Add(string.Format("{0}ʭ{1}", dr["LocPincode"].ToString(), dr["locID"].ToString()));
                        break;
                    }
                }
            }
            if (count == 0) pincode.Add(string.Format("{0}ʭ{1}", "", ""));
            return pincode.ToArray();
            //int count = 0;
            //List<string> pincode = new List<string>();
            //List<Parameters> paramList = new List<Parameters>();
            //if (data == "GetData")
            //    paramList.Add(new Parameters("@Event", "GetPincode"));
            //else if (data == "ReadData")
            //    paramList.Add(new Parameters("@Event", "ReadPincode"));
            //paramList.Add(new Parameters("@SDC", ""));
            //paramList.Add(new Parameters("@specificSearch", searchPrefixText));
            //IDataReader Reader = (new Connection()).ReadSp("spBindDropdownListORAuto", paramList);
            //while (Reader.Read())
            //{
            //    count++;
            //    pincode.Add(string.Format("{0}-{1}", Reader["LocPincode"], Reader["locID"]));
            //}
            //if (count == 0)
            //    pincode.Add(string.Format("{0}-{1}", "", ""));

            //return pincode.ToArray();
        }
        //Get Pincode 
        public string[] getConsignorPincode(string searchPrefixText, string data, int branchId)
        {
            int count = 0;
            List<string> pincode = new List<string>();
            DataTable dtTable = null;
            if (HttpContext.Current.Application["Pincode"] == null)
            {
                List<Parameters> paramList = new List<Parameters>();
                dtTable = (new Connection()).Fillsp("ssp_GetPincodeList", paramList);
                HttpContext.Current.Application["Pincode"] = dtTable;
            }
            else
            {
                dtTable = HttpContext.Current.Application["Pincode"] as DataTable;
            }
            if (searchPrefixText != "")
            {
                string expression = "CONVERT(LocPincode,System.String) like '%" + searchPrefixText + "%' AND branchId='" + branchId + "'";
                DataRow[] rows = dtTable.Select(expression);

                if (data == "GetData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        pincode.Add(string.Format("{0}ʭ{1}", dr["LocPincode"].ToString(), dr["locID"].ToString()));
                    }
                }
                else if (data == "ReadData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        pincode.Add(string.Format("{0}ʭ{1}", dr["LocPincode"].ToString(), dr["locID"].ToString()));
                        break;
                    }
                }
            }
            if (count == 0) pincode.Add(string.Format("{0}ʭ{1}", "", ""));
            return pincode.ToArray();

        }

        //Get Pincode Details
        public string[] PincodeDetail(int pincode)
        {
            int count = 0;
            List<string> PinDetail = new List<string>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@pincode", pincode.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetPincodeDetails", paramList);
            while (Reader.Read())
            {
                count++;
                PinDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}", Reader["stateName"], Reader["districtName"], Reader["cityName"], Reader["branchName"], Reader["branchId"], Reader["districtID"], Reader["cityID"], Reader["stateID"]));
            }
            return PinDetail.ToArray();
        }



        //Get Pincode Details
        public FullAddress getPincodeDetail(int pincode)
        {
            FullAddress PinDetail = new FullAddress();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "Field_SDC"));
            paramList.Add(new Parameters("@SDC", pincode.ToString()));
            paramList.Add(new Parameters("@specificSearch", ""));
            IDataReader Reader = (new Connection()).ReadSp("spBindDropdownListORAuto", paramList);
            while (Reader.Read())
            {
                PinDetail.State = Reader["Delivery State"].ToString().ToUpper();
                PinDetail.District = Reader["Delivery  District"].ToString().ToUpper();
                PinDetail.City = Reader["Delivery City"].ToString().ToUpper();
            }
            return PinDetail;
        }

        //Get Area in Dropdown
        public List<FullAddress> getArea(int pincode)
        {
            List<FullAddress> area = new List<FullAddress>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@locPincode", pincode.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetPincodeAreaList", paramList);
            while (Reader.Read())
            {
                area.Add(new FullAddress() { AreaID = Convert.ToInt32(Reader["locAreaID"]), Area = Reader["areaName"].ToString().ToUpper() });
            }
            return area;
        }

        //Get Area
        //public string[] getArea(string searchPrefixText, string data, string pincode)
        //{
        //    int count = 0;
        //    List<string> area = new List<string>();
        //    List<Parameters> paramList = new List<Parameters>();
        //    if (data == "GetData")
        //        paramList.Add(new Parameters("@Event", "GetArea"));
        //    else if (data == "ReadData")
        //        paramList.Add(new Parameters("@Event", "ReadArea"));
        //    paramList.Add(new Parameters("@SDC", pincode));
        //    paramList.Add(new Parameters("@specificSearch", searchPrefixText));
        //    IDataReader Reader = (new Connection()).ReadSp("spBindDropdownListORAuto", paramList);
        //    while (Reader.Read())
        //    {
        //        count++;
        //        area.Add(string.Format("{0}-{1}", Reader["areaName"], Reader["locAreaID"]));
        //    }
        //    if (count == 0)
        //        area.Add(string.Format("{0}-{1}", "", ""));

        //    return area.ToArray();
        //}


        public bool AreaCreation(string pincode, string area)
        {
            Connection con = new Connection();
            FullAddress Area = new FullAddress();
            Area.Pincode = Convert.ToInt32(pincode);
            Area.Area = area;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@pincode", Area.Pincode.ToString()));
            paramList.Add(new Parameters("@area", Area.Area));

            int insert = con.ExecuteSp("spInsertArea", paramList);

            return insert == 1;
        }
        //Get Branch in Dropdown
        public List<Branch> GetBranch()
        {
            List<Branch> branchList = new List<Branch>();
            List<Parameters> paramList = new List<Parameters>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetBranchList", paramList);
            while (Reader.Read())
            {
                branchList.Add(new Branch()
                {
                    branchId = Convert.ToInt32(Reader["branchID"]),
                    branchName = Reader["branchName"].ToString(),
                });
            }
            return branchList;
        }

        //Get State in Dropdown
        public List<Location> GetState()
        {
            List<Location> List = new List<Location>();
            List<Parameters> paramList = new List<Parameters>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetStateList", paramList);
            while (Reader.Read())
            {
                List.Add(new Location()
                {
                    State = Reader["stateName"].ToString(),
                    StateId = Convert.ToInt32(Reader["stateId"]),
                   
                });
            }
            return List;
        }

        //Get State in Dropdown
        public List<Location> GetDistrictOnState(int stateid)
        {
            List<Location> List = new List<Location>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@stateId", stateid.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDistrictListOnState", paramList);
            while (Reader.Read())
            {
                List.Add(new Location()
                {
                    District = Reader["DistrictName"].ToString(),
                    DistrictId = Convert.ToInt32(Reader["DistrictId"]),

                });
            }
            return List;
        }

        /*------------------------------------------------------------Location Master------------------------------------------------------------*/
        //Get Location Pincode 
        public List<Location> getLocationPincode(string searchableText)
        {
            Location Pin;
            List<Parameters> paramList = new List<Parameters>();
            if (searchableText == "")
                paramList.Add(new Parameters("@Event", "Pincode_Dropdown"));
            else if (searchableText != "")
                paramList.Add(new Parameters("@Event", "Searchable_Pincode_Dropdown"));
            paramList.Add(new Parameters("@Name", ""));
            paramList.Add(new Parameters("@Search", searchableText));
            List<Location> pincodeList = new List<Location>();
            IDataReader Reader = (new Connection()).ReadSp("spBindDropdownCommonListORAuto", paramList);
            while (Reader.Read())
            {
                Pin = new Location();
                Pin.Pincode = Convert.ToInt32(Reader["locPincode"].ToString());
                Pin.PincodeId = Convert.ToInt32(Reader["locID"].ToString());
                pincodeList.Add(Pin);
            }
            return pincodeList;
        }
        //Get City 
        //public string[] getCity(string searchPrefixText, string data)
        //{
        //    int count = 0;
        //    List<string> city = new List<string>();
        //    DataTable dtTable = null;
        //    if (HttpContext.Current.Application["City"] == null)
        //    {
        //        List<Parameters> paramList = new List<Parameters>();
        //        dtTable = (new Connection()).Fillsp("ssp_GetCityList", paramList);
        //        HttpContext.Current.Application["City"] = dtTable;
        //    }
        //    else
        //    {
        //        dtTable = HttpContext.Current.Application["City"] as DataTable;
        //    }
        //    if (searchPrefixText != "")
        //    {
        //        string expression = "cityName like '%" + searchPrefixText + "%'";
        //        DataRow[] rows = dtTable.Select(expression);

        //        if (data == "GetData")
        //        {
        //            foreach (DataRow dr in rows)
        //            {
        //                count++;
        //                city.Add(string.Format("{0}ʭ{1}", dr["cityName"].ToString(), dr["cityID"].ToString()));
        //            }
        //        }
        //        else if (data == "ReadData")
        //        {
        //            foreach (DataRow dr in rows)
        //            {
        //                count++;
        //                city.Add(string.Format("{0}ʭ{1}", dr["cityName"].ToString(), dr["cityID"].ToString()));
        //                break;
        //            }
        //        }
        //    }
        //    if (count == 0) city.Add(string.Format("{0}ʭ{1}", "", ""));
        //    return city.ToArray();

        //}
        ////Get District 
        //public string[] getDistrict(string searchPrefixText,string data)
        //{
        //    int count = 0;
        //    List<string> district = new List<string>();
        //    DataTable dtTable = null;
        //    if (HttpContext.Current.Application["District"] == null)
        //    {
        //        List<Parameters> paramList = new List<Parameters>();
        //        dtTable = (new Connection()).Fillsp("ssp_GetDistrictList", paramList);
        //        HttpContext.Current.Application["District"] = dtTable;
        //    }
        //    else
        //    {
        //        dtTable = HttpContext.Current.Application["District"] as DataTable;
        //    }
        //    if (searchPrefixText != "")
        //    {
        //        string expression = "DistrictName like '%" + searchPrefixText + "%'";
        //        DataRow[] rows = dtTable.Select(expression);

        //        if (data == "GetData")
        //        {
        //            foreach (DataRow dr in rows)
        //            {
        //                count++;
        //                district.Add(string.Format("{0}ʭ{1}", dr["DistrictName"].ToString(), dr["DistrictId"].ToString()));
        //            }
        //        }
        //        else if (data == "ReadData")
        //        {
        //            foreach (DataRow dr in rows)
        //            {
        //                count++;
        //                district.Add(string.Format("{0}ʭ{1}", dr["DistrictName"].ToString(), dr["DistrictId"].ToString()));
        //                break;
        //            }
        //        }
        //    }
        //    if (count == 0) district.Add(string.Format("{0}ʭ{1}", "", ""));
        //    return district.ToArray();
        //}

        //Get City 
        public List<Location> getCity(string searchableText)
        {
            Location lc;
            List<Parameters> paramList = new List<Parameters>();
            if (searchableText == "")
                paramList.Add(new Parameters("@Event", "City_Dropdown"));
            else if (searchableText != "")
                paramList.Add(new Parameters("@Event", "Searchable_City_Dropdown"));
            paramList.Add(new Parameters("@Name", ""));
            paramList.Add(new Parameters("@Search", searchableText));
            List<Location> List = new List<Location>();
            IDataReader Reader = (new Connection()).ReadSp("spBindDropdownCommonListORAuto", paramList);
            while (Reader.Read())
            {
                lc = new Location();
                lc.City = Reader["cityName"].ToString();
                lc.CityId = Convert.ToInt32(Reader["cityID"].ToString());
                List.Add(lc);
            }
            return List;
        }
        //Get District 
        public List<Location> getDistrict(string searchableText)
        {
            Location ld;
            List<Parameters> paramList = new List<Parameters>();
            if (searchableText == "")
                paramList.Add(new Parameters("@Event", "District_Dropdown"));
            else if (searchableText != "")
                paramList.Add(new Parameters("@Event", "Searchable_District_Dropdown"));
            paramList.Add(new Parameters("@Name", ""));
            paramList.Add(new Parameters("@Search", searchableText));
            List<Location> List = new List<Location>();
            IDataReader Reader = (new Connection()).ReadSp("spBindDropdownCommonListORAuto", paramList);
            while (Reader.Read())
            {
                ld = new Location();
                ld.District = Reader["districtName"].ToString();
                ld.DistrictId = Convert.ToInt32(Reader["districtID"].ToString());
                List.Add(ld);
            }
            return List;
        }

        //Get State 
        public List<Location> getState(string searchableText)
        {
            Location ld;
            List<Parameters> paramList = new List<Parameters>();
            if (searchableText == "")
                paramList.Add(new Parameters("@Event", "State_Dropdown"));
            else if (searchableText != "")
                paramList.Add(new Parameters("@Event", "Searchable_State_Dropdown"));
            paramList.Add(new Parameters("@Name", ""));
            paramList.Add(new Parameters("@Search", searchableText));
            List<Location> List = new List<Location>();
            IDataReader Reader = (new Connection()).ReadSp("spBindDropdownCommonListORAuto", paramList);
            while (Reader.Read())
            {
                ld = new Location();
                ld.State = Reader["stateName"].ToString();
                ld.StateId = Convert.ToInt32(Reader["stateID"].ToString());
                List.Add(ld);
            }
            return List;
        }
        public Branch getBranchAddress(string BranchId)
        {
            Branch br = new Branch(); 
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            IDataReader dt = (new Connection()).ReadSp("ssp_GetBranchCreation", paramList);
            while (dt.Read())
            {
                br.branchAddress = dt["address"].ToString() + "," + dt["areaName"].ToString() + ","
                    + dt["districtName"].ToString() + "," + dt["stateName"].ToString() + "," + dt["locPincode"].ToString();
            }
            return br;
        }
        // Get Pickup Request Details in GridView
        public DataTable ViewLocationMasterPincodeWise(Location loc, string rdbl)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (rdbl != "SELECT")
            {
                paramList.Add(new Parameters("@Event", "Pincode"));
                paramList.Add(new Parameters("@locID", loc.PincodeId.ToString()));
                paramList.Add(new Parameters("@cityID", ""));
                paramList.Add(new Parameters("@districtID", ""));
                paramList.Add(new Parameters("@stateID", ""));
            }
            DataTable dt = (new Connection()).Fillsp("spViewLocationMasterDetails", paramList);
            return dt;
        }
        public DataTable ViewLocationMasterCityWise(Location loc, string rdbl)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (rdbl != "SELECT")
            {
                paramList.Add(new Parameters("@Event", "City"));
                paramList.Add(new Parameters("@locID", ""));
                paramList.Add(new Parameters("@cityID", loc.CityId.ToString()));
                paramList.Add(new Parameters("@districtID", ""));
                paramList.Add(new Parameters("@stateID", ""));
            }
            DataTable dt = (new Connection()).Fillsp("spViewLocationMasterDetails", paramList);
            return dt;
        }
        public DataTable ViewLocationMasterDistrictWise(Location loc, string rdbl)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (rdbl != "SELECT")
            {
                paramList.Add(new Parameters("@Event", "District"));
                paramList.Add(new Parameters("@locID", ""));
                paramList.Add(new Parameters("@cityID", ""));
                paramList.Add(new Parameters("@districtID", loc.DistrictId.ToString()));
                paramList.Add(new Parameters("@stateID", ""));
            }
            DataTable dt = (new Connection()).Fillsp("spViewLocationMasterDetails", paramList);
            return dt;
        }
        public DataTable ViewLocationMasterStateWise(Location loc, string rdbl)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (rdbl != "SELECT")
            {
                paramList.Add(new Parameters("@Event", "State"));
                paramList.Add(new Parameters("@locID", ""));
                paramList.Add(new Parameters("@cityID", ""));
                paramList.Add(new Parameters("@districtID", ""));
                paramList.Add(new Parameters("@stateID", loc.StateId.ToString()));
            }
            DataTable dt = (new Connection()).Fillsp("spViewLocationMasterDetails", paramList);
            return dt;
        }
        public DataTable ViewWayBillsBranchStock(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (branchID > 0) paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportBranchInHandStock", paramList);
            return dt;
        }
	public DataTable ViewWayBillsRouteStock(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewRouteWayBills", paramList);
            return dt;
        }
        public DataTable ViewWayBillsCreated(int BranchId, string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportWayBills", paramList);
            return dt;
        }
        public DataTable WayBillsEntered(string WaybillNo)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WaybillNo", WaybillNo.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_CheckWaybillsEntered", paramList);
            return dt;
        }
	public DataTable ViewWayBillBookingReport(int BranchId, string fromDate, string toDate, String strPayMode = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId > 0) paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            if (strPayMode != "") paramList.Add(new Parameters("@PAYMODE", strPayMode));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportWayBillsBookingReport", paramList);
            return dt;
        }
	public DataTable ViewBookingReport(int BranchId, string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            if(BranchId >0 ) paramList.Add(new Parameters("@branchID", BranchId.ToString())); 
            paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
            paramList.Add(new Parameters("@toDate", toDate.ToString())); 
            DataTable dt = (new Connection()).Fillsp("ssp_ReportBookingReport", paramList); 
            return dt; 
        }
	public DataTable ViewForwardingReport(int BranchId, string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>(); 
            if (BranchId > 0) paramList.Add(new Parameters("@branchID", BranchId.ToString())); 
            paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
            paramList.Add(new Parameters("@toDate", toDate.ToString())); 
            DataTable dt = (new Connection()).Fillsp("ssp_ReportForwardingWayBills", paramList); 
            return dt;
        }
         public DataTable ViewDRSRegister(int BranchId, string fromDate, string toDate, string customerID = null,string PodUpload = null)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (customerID != null) paramList.Add(new Parameters("@customerID", customerID.ToString()));
            if (PodUpload != null) paramList.Add(new Parameters("@PODUpload", PodUpload.ToString()));
            if (BranchId > 0) paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportDeliveries", paramList);
            return dt;
        }
        public DataTable ViewAllPickups(int BranchId, string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            if(BranchId > 0) paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportPickUpRequests", paramList);
            return dt;
        }
        public DataTable ViewAllOpenPickups(int BranchId, string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            paramList.Add(new Parameters("@Status", "OPEN"));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportPickUpRequests", paramList);
            return dt;
        }
        public DataTable ViewWayBillsBranchStatus(int branchID, int StatusId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            paramList.Add(new Parameters("@statusId", StatusId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewBranchWayBills", paramList);
            return dt;
        }
        public DataTable ViewBranchVehicles(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewBranchVehicles", paramList);
            return dt;
        }        
	    public DataTable ViewVehiclesRequests(int branchID, string fromDate, string toDate)	
        {	
            List<Parameters> paramList = new List<Parameters>();	
            if (branchID > 0) paramList.Add(new Parameters("@branchID", branchID.ToString()));	
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));	
            paramList.Add(new Parameters("@toDate", toDate.ToString()));	
            DataTable dt = (new Connection()).Fillsp("ssp_ViewVehicleRequests", paramList);	
            return dt;	
        }
        public DataTable ViewVehiclesInTrip(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (branchID > 0) paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewVehicleInTrip", paramList);
            return dt;
        }

        public DataTable ViewRequestsMaterial(string vehicleRequestId)	
        {	
            List<Parameters> paramList = new List<Parameters>();	
            paramList.Add(new Parameters("@VehicleRequestId", vehicleRequestId.ToString()));	
            DataTable dt = (new Connection()).Fillsp("ssp_ViewVehicleRequestsMaterial", paramList);	
            return dt;	
        }	
        public DataTable ViewBranchStockMaterial(int BranchId)	
        {	
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId > 0) paramList.Add(new Parameters("@BranchId", BranchId.ToString()));	
            DataTable dt = (new Connection()).Fillsp("ssp_GetBranchStock", paramList);	
            return dt;	
        }
        public DataTable ViewBranchTranshipmentStockMaterial(int BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId > 0) paramList.Add(new Parameters("@BranchId", BranchId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetBranchTranshipmentStock", paramList);
            return dt;
        }
        public DataTable ViewBranchDeliveryStockMaterial(int BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId > 0) paramList.Add(new Parameters("@BranchId", BranchId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetBranchDeliveryStock", paramList);
            return dt;
        }
        public DataTable ViewBranchLocations(string BranchId = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewBranchLocations", paramList);
            return dt;
        }
        public DataTable ViewVehicleMovements(string VehicleRequestId = "", string BranchId = "",	
                    string FromDate = "", string ToDate = "")	
        {	
            List<Parameters> paramList = new List<Parameters>();	
            if(VehicleRequestId != "") paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestId));	
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));	
            if (FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate));	
            if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));	
            DataTable dt = (new Connection()).Fillsp("ssp_VehicleRequestStatus", paramList);	
            return dt;	
        }
        public DataTable ViewWayBillMovement(string BranchId = "", string FromDate = "", string ToDate = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            if (FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate));
            if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportWaybillMovement", paramList);
            return dt;
        }
        public DataTable ViewCustomerContracts(string ContractId = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (ContractId != "") paramList.Add(new Parameters("@ContractId", ContractId));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewCustomerContracts", paramList);
            return dt;
        }
        public DataTable ViewCustomerList(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetCustomerList", paramList);
            return dt;
        }
        public DataTable ViewWalkinCustomerList(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetConsignorNameList", paramList);
            return dt;
        }
        public DataTable ViewConsigneeList(int branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetConsigneeNameList", paramList);
            return dt;
        }
        public DataTable ViewBillingParty()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetBillingPartyName", paramList);
            return dt;
        }
        public DataTable ViewMaterialList()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetMaterialNameList", paramList);
            return dt;
        }
        public DataTable ViewPackageList()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetPackageNameList", paramList);
            return dt;
        }
        public DataTable ViewWaybillRateTypeList()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetWaybillRateType", paramList);
            return dt;
        }
        public DataTable ViewVehicleRateTypeList()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetVehicleRateType", paramList);
            return dt;
        }
        public DataTable ViewWayBillSummary(string BranchId, string FromDate = "", string ToDate = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if(BranchId != "") paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", FromDate.ToString()));
            paramList.Add(new Parameters("@toDate", ToDate.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetWayBillBookingSummary", paramList);
            return dt;
        }
        public DataTable GetDeliveryLoadedWayBills(string vehicleRequestId, string BranchId) 
        {
            List<Parameters> paramList = new List<Parameters>();
            if (vehicleRequestId != "") paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@StatusId", "6"));
            paramList.Add(new Parameters("@BranchId", BranchId));

            DataTable dt = (new Connection()).Fillsp("ssp_ReportLoadedQtyOnVehicleList", paramList);
            return dt;
        }
        public DataTable GetManifestdWayBills(string vehicleRequestId)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (vehicleRequestId != "") paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));

            DataTable dt = (new Connection()).Fillsp("ssp_ReportManifest", paramList);
            return dt;
        }
	public DataTable GetPickupLoadedWayBills(string vehicleRequestId, string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (vehicleRequestId != "") paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            paramList.Add(new Parameters("@StatusId", "2"));
            paramList.Add(new Parameters("@BranchId", BranchId));

            DataTable dt = (new Connection()).Fillsp("ssp_ReportLoadedQtyOnVehicleList", paramList);
            return dt;
        }
        public DataTable getStationary(string branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetStationaryBranch", paramList);
            return dt;
        }
        public DataTable getStationaryDates(string branchID, string FromDate = "", string ToDate = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if(branchID != "") paramList.Add(new Parameters("@branchId", branchID.ToString()));
            paramList.Add(new Parameters("@fromDate", FromDate));
            paramList.Add(new Parameters("@toDate", ToDate));

            DataTable dt = (new Connection()).Fillsp("ssp_GetStationaryBranchDates", paramList);
            return dt;
        }
        public DataTable getUserAccessAllReport(string userName)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@userName", userName.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_GetUserAccessAllBranchesReport", paramList);
            return dt;
        }
        public void SetUserBranch(string userId, string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@userId", userId));
            paramList.Add(new Parameters("@branchId", BranchId));
            paramList.Add(new Parameters("@ActivityId", "2"));
            paramList.Add(new Parameters("@creationDateTime", (new CFunctions()).CurrentDateTime()));

            (new Connection()).ExecuteSp("ssp_CreateUserActivity", paramList);
        }
        public int getUserLastLoginBranch(string userId)
        {
            int iBranchId = 0;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@userId", userId));

            IDataReader Reader = (new Connection()).ReadSp("ssp_GetLastBranch", paramList);
            while (Reader.Read())
            {
                iBranchId = Convert.ToInt32(Reader["branchID"]);
            }
            return iBranchId;
        }
        public bool SaveFuel(FuelPrice fuel)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@fuelType", fuel.fuelType.ToString()));
            paramList.Add(new Parameters("@fuelDate", fuel.fuelDate.ToString()));
            paramList.Add(new Parameters("@districtID", fuel.DistrictId.ToString()));
            paramList.Add(new Parameters("@fuelPrice", fuel.fuelPrice.ToString()));
            paramList.Add(new Parameters("@creationDateTime", (new CFunctions()).CurrentDateTime()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateFuelPrice", paramList);
            return reader != null;
        }
        public DataTableCollection ViewWayBillTracking(string WaybillNo)
        {
            DataTableCollection dt; 
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@waybillNo", WaybillNo));
            DataSet ds = (new Connection()).FillDataSetSP("ssp_ReportWaybillStatus", paramList);
            dt = ds.Tables; 
            return dt; 
        }
        public DataTableCollection ViewWayBillTrackingSum(string WaybillNo)
        {
            DataTableCollection dt;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@waybillNo", WaybillNo));
            DataSet ds = (new Connection()).FillDataSetSP("ssp_ReportWaybillStatusSum", paramList);
            dt = ds.Tables;
            return dt;
        }
        public bool SaveArea(FullAddress fa)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@locID", fa.Pincode.ToString()));
            paramList.Add(new Parameters("@areaName", fa.Area.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateArea", paramList);
            return reader != null;
        }

        public bool SaveLocationDefinition(Location loc)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@contractID", loc.contractID.ToString()));
            paramList.Add(new Parameters("@locID", loc.PincodeId.ToString()));
            paramList.Add(new Parameters("@areaID", loc.AreaID.ToString()));
            paramList.Add(new Parameters("@cityID", loc.CityId.ToString()));
            paramList.Add(new Parameters("@districtID", loc.DistrictId.ToString()));
            paramList.Add(new Parameters("@status", loc.status.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateLocationDefinition", paramList);
            return reader != null;
        }
        public IDataReader ViewLocationDefinition()
        {
            IDataReader Reader = null;
            List<Parameters> paramList = new List<Parameters>();
            return Reader = (new Connection()).ReadSp("ssp_ViewLocationDefinition", paramList);         
        }
        //For Waybill List for E-waybill updation
        public IDataReader ViewWaybillListForEwaybill(int branch,string vehicleRequestId=null)
        {
            IDataReader Reader = null;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", branch.ToString()));
            if (vehicleRequestId != null) paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId.ToString()));
            return Reader = (new Connection()).ReadSp("ssp_GetEWayBillList", paramList);
        }
	//Listing of Invoice Values for teh Waybills. 
	public DataTable ViewWayBillInvoices(string CustomerId, string fromDate, string toDate) 
        { 
            List<Parameters> paramList = new List<Parameters>(); 
            paramList.Add(new Parameters("@CustomerId", CustomerId.ToString())); 
            paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
            paramList.Add(new Parameters("@toDate", toDate.ToString())); 
            DataTable dt = (new Connection()).Fillsp("ssp_GetInvoiceValues", paramList); 
            return dt; 
        }
        public IDataReader GetUserPassword(int userID)
        {
            IDataReader Reader = null;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@userID", userID.ToString()));
            return Reader = (new Connection()).ReadSp("ssp_GetUserPassword", paramList);
        }
        public bool SavePassword(int userID, string password)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
            paramList.Add(new Parameters("@userID", userID.ToString()));
            paramList.Add(new Parameters("@password", password.ToString()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreatePassword", paramList);
            return reader != null;
        }

        public IDataReader ReadCSV(string fileName, out List<WayBillDetails> wayBillDetails) 
        { 
            DataTable dtCSVFile = new DataTable(); 
            int intLineNo = 0; 
            using (var reader = new StreamReader(fileName)) 
            { 
                List<string> listValues = new List<string>(); 
                int intColNo = 0;

                while (!reader.EndOfStream) 
                { 
                    var line = reader.ReadLine(); 
                    var values = line.Split(',');
                    if(intColNo != 0) dtCSVFile.Rows.Add(); 
                    
                    intLineNo = 0; 
                    foreach (string strCellValue in values) 
                    {
                        intLineNo++; 
                        if (dtCSVFile.Columns.Count < intLineNo) dtCSVFile.Columns.Add(); 
                        if(intColNo == 0)
                        {
                            if (strCellValue != "")
                                dtCSVFile.Columns[intLineNo - 1].ColumnName = strCellValue; 
                        }
                        else
                        dtCSVFile.Rows[dtCSVFile.Rows.Count - 1][intLineNo - 1] = strCellValue; 
                    }
                    //if (intLineNo == 100) break;  
                    intColNo++; 
                } 
            }

            dtCSVFile.Columns.Add("customerId"); 
            dtCSVFile.Columns.Add("consignorId"); 
            dtCSVFile.Columns.Add("consigneeId"); 
            dtCSVFile.Columns.Add("pickUpLocationId"); 
            dtCSVFile.Columns.Add("pickUpAreaId"); 
            dtCSVFile.Columns.Add("deliveryLocationId"); 
            dtCSVFile.Columns.Add("deliveryAreaId");
            dtCSVFile.Columns.Add("SystemRemarks");
            dtCSVFile.Columns.Add("SystemUpload");

            wayBillDetails = new List<WayBillDetails>();
            string strConsignorId = "", strConsigneeId = "";
            for (int intRow = 0; intRow <= dtCSVFile.Rows.Count - 1; intRow++)
            {
                WayBillDetails wayBillDetail = new WayBillDetails();  //dtCSVFile.Rows[intRow]["Way Bill No"].ToString(), null, null,null, null, null, 
                                                                      //null, null, null, null, null);
                wayBillDetail.wayBillHeader.wayBillNo = dtCSVFile.Rows[intRow]["Way Bill No"].ToString();
                //wayBillDetail.wayBillNo = dtCSVFile.Rows[intRow]["Way Bill No"].ToString();
                dtCSVFile.Rows[intRow]["SystemUpload"] = false.ToString(); 
                
                //Check if Waybill no is available 
                //if (wayBillDetail.wayBillHeader.wayBillNo != null)
                //if(wayBillDetail.wayBillNo != null)
                {
                    
                }
                //Check if Customer Name is available, Get Customer Id 
                if(dtCSVFile.Rows[intRow]["Consigner Name"] != null & dtCSVFile.Rows[intRow]["Consigner Name"].ToString() != "") 
                {
                    System.Diagnostics.Debug.Print(intRow.ToString());
                    System.Diagnostics.Debug.Print(DateTime.Now.ToString());
                    strConsignorId = getCustomerId(dtCSVFile.Rows[intRow]["Consigner Name"].ToString()); 
                    System.Diagnostics.Debug.Print("done");
                    System.Diagnostics.Debug.Print(DateTime.Now.ToString());
                    dtCSVFile.Rows[intRow]["SystemUpload"] = strConsignorId;
                    dtCSVFile.Rows[intRow]["customerId"] = strConsignorId;
                    //Get more details from the customer Id 
                }

                //Get Consignee Name 
                if (dtCSVFile.Rows[intRow]["Consignee Name"] != null)
                {
                    strConsigneeId = getConsigneeId(dtCSVFile.Rows[intRow]["Consigner Name"].ToString());
                    dtCSVFile.Rows[intRow]["consigneeId"] = strConsignorId;
                }
                wayBillDetails.Add(wayBillDetail); 
            }

            return dtCSVFile.CreateDataReader(); 
        }
        public string getConsigneeId(string consigneeName)
        {
            string strConsigneeId = "";

            return strConsigneeId; 
        }
        public string getCustomerId(string customerName)
        {
            string strCustomerId = "";
            try
            {
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@customerName", customerName.ToString()));
                IDataReader Reader = (new Connection()).ReadSp("ssp_GetCustomerIdFromName", paramList);
                while (Reader.Read())
                {
                    strCustomerId = Reader[0].ToString();
                }
            }
            catch  { }
            return strCustomerId; 
        }
        public bool addStationary(int BranchId, int StartNum, int EndingNum, string CreationDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", BranchId.ToString()));
            paramList.Add(new Parameters("@StartNum", StartNum.ToString()));
            paramList.Add(new Parameters("@EndNum", EndingNum.ToString()));
            paramList.Add(new Parameters("@creationDate", CreationDate.ToString()));
            IDataReader reader = (new Connection()).ExecuteSpIS("ssp_CreateWayBillStationary", paramList);

            return reader!=null;
        }

        public IDataReader SavePODUpload(int waybillId, string CreationDate)
        {
            List<Parameters> paramList = new List<Parameters>();         
            paramList.Add(new Parameters("@waybillID", waybillId.ToString()));
            paramList.Add(new Parameters("@uploadDate", CreationDate.ToString()));
            IDataReader reader = (new Connection()).ExecuteSpIS("dbo.ssp_CreatePODUploaded", paramList);

            return reader;
        }
	public DataTable viewVDTReport()
        {
            DataTable dt = (new Connection()).Fillsp("ssp_ViewVDTReport", new List<Parameters>());
            return dt;
        }
       
        public List<StaffDetail> getDepartmentName()
        {
            StaffDetail Name;
            List<Parameters> paramList = new List<Parameters>();
            List<StaffDetail> List = new List<StaffDetail>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetDepartmentList", paramList);
            while (Reader.Read())
            {
                Name = new StaffDetail();
                Name.Name = Reader["departmentName"].ToString();
                Name.Id = Convert.ToInt32(Reader["departmentID"]);
                List.Add(Name);
            }
            return List;
        }

        public List<StaffDetail> getMaterialName()
        {
            StaffDetail Name;
            List<Parameters> paramList = new List<Parameters>();
            List<StaffDetail> List = new List<StaffDetail>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_MMMaterialList", paramList);
            while (Reader.Read())
            {
                Name = new StaffDetail();
                Name.Name = Reader["MaterialName"].ToString();
                Name.Id = Convert.ToInt32(Reader["MaterialId"]);
                List.Add(Name);
            }
            return List;
        }
        public bool SavePurchaseMaterial(PurchaseMaterials detail)
        {
            PickReq session = new PickReq();
            session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
            session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader = null;
           
            paramList.Add(new Parameters("@BranchId", detail.branchId.ToString()));
            paramList.Add(new Parameters("@departmentID", detail.departmentId.ToString()));
            paramList.Add(new Parameters("@Remarks", detail.remark.ToString()));                  
            paramList.Add(new Parameters("@UserId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@CreationDate", session.Session.CreationDateTime));
            reader = (new Connection()).ExecuteSpIS("ssp_MMCreatePurchaseRequestHeader", paramList);
            if (reader.Read())
            {
                detail.Id = Convert.ToInt32(reader["id"]);
                if (detail.MaterialDetail != null)
                {
                    foreach (PurchaseMaterialDetails material in detail.MaterialDetail)
                    {
                        paramList = new List<Parameters>();
                        paramList.Add(new Parameters("@PurchaseRequestId", detail.Id + ""));
                        paramList.Add(new Parameters("@MaterialId", material.materialId + ""));
                        paramList.Add(new Parameters("@Quantity", material.qty + ""));
                        paramList.Add(new Parameters("@UOM", material.unit + ""));
                        paramList.Add(new Parameters("@ExpectedDate", material.expectedDate + ""));
                        (new Connection()).ExecuteSp("ssp_MMCreatePurchaseRequestMaterials", paramList);
                    }
                }
            }
            return reader != null;
        }
        public List<ShowPurchaseMaterialDetails> SearchMaterialPurchaseDetails(string fromdate,string todate,string id,int status)
        {
            List<ShowPurchaseMaterialDetails> searchList = new List<ShowPurchaseMaterialDetails>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@FromDate", fromdate));
            paramList.Add(new Parameters("@ToDate", todate));
            paramList.Add(new Parameters("@BranchId", id));
            paramList.Add(new Parameters("@status", status.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetPurchaseMaterialDetails", paramList);
            while (Reader.Read())
            {
                searchList.Add(new ShowPurchaseMaterialDetails()
                {
                    ID = Convert.ToInt32(Reader["PurchaseRequestMaterialsId"]),
                    branchName = Reader["branchName"].ToString(),
                    materialName = Reader["MaterialName"].ToString(),
                    qty = Convert.ToInt32(Reader["Quantity"]),
                    departmentName = Reader["departmentName"].ToString(),
                    unit = Reader["UOM"].ToString(),
                    remarks = Reader["Remarks"].ToString(),
                    expectedDate = Reader["ExpectedDate"].ToString()
                });
            }
            return searchList;
        }
        public int SaveStatusOfApprovalMaterial(int id,int statusId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@id", id.ToString()));
            paramList.Add(new Parameters("@statusid", statusId.ToString()));           
            int i = (new Connection()).ExecuteSp("ssp_UpdateStatusOfPurchaseMaterial", paramList);
            return i;
        }
        public IDataReader GetWaybillSummary()
        {
            IDataReader Reader = (new Connection()).ReadSp("ssp_WayBillMonthSummary", new List<Parameters>());
            return Reader; 
        }
        public DataTable GetRoutes()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetRouteNameList", paramList);
            return dt;
        }
	public DataTable GetPickUnloadWayBillDetails(string vehicleRequestId, string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@BranchId", BranchId));
            DataTable Reader = (new Connection()).Fillsp("ssp_ViewPickupUnloading", paramList);
            return Reader;
        }
	public DataTable GetTranshipUnloadWayBillDetails(string vehicleRequestId, string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            paramList.Add(new Parameters("@BranchId", BranchId));
            DataTable Reader = (new Connection()).Fillsp("ssp_ViewTranshipmentUnloading", paramList);
            return Reader;
        }
        public string getBranchNo(string BranchName)
        {
            string BranchNo = "";
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchName", BranchName));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetBranchIdFromName", paramList);
            while (Reader.Read())
            {
                BranchNo = Reader["branchNo"].ToString();
            }
            return BranchNo;
        }
        public void setPODUpload(string WayBillNo)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Wayillno", WayBillNo));
            paramList.Add(new Parameters("@PODStatus", "YES"));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreatePODUpdate", paramList);
        }
        public DataTable GetPendingPODCount()
        {
            List<Parameters> paramList = new List<Parameters>();
            DataTable dt = (new Connection()).Fillsp("ssp_GetPendingPODCount", paramList);
            return dt;
        }

        public List<Branch> DeliveryWayBranches(int branchId)
        {
            List<Branch> branches = new List<Branch>();
            Branch branch; 
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", branchId.ToString()));
            IDataReader dr = (new Connection()).ReadSp("ssp_getStockBranches", paramList);
            while (dr.Read())
            {
                branch = new Branch();
                branch.branchId = Convert.ToInt32(dr["branchId"].ToString());
                branch.branchName = dr["branchName"].ToString();
                branches.Add(branch); 
            }
            return branches;
        }

        public DataTable getLHSData(string vehicleRequestId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
            DataTable Reader = (new Connection()).Fillsp("ssp_ReportLHS", paramList);
            return Reader;
        }
        public DataTable ViewManifestList(string BranchId = "", string FromDate = "", string ToDate = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            if (FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate));
            if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportLHSBranch", paramList);
            return dt;
        }
        public DataTable ViewManifestWaybills(string manifestNo,string BranchId = "", string FromDate = "", string ToDate = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            if (manifestNo != "") paramList.Add(new Parameters("@ManifestNo", manifestNo));
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            if (FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate));
            if (ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportManifestWaybills", paramList);
            return dt;
        }
        public IDataReader getEWayBillParameters(int ID)
        {
            IDataReader Reader = null;
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@ID", ID.ToString()));
            return Reader = (new Connection()).ReadSp("ssp_GetEWayBillParameters", paramList);
        }
        public int SaveEWayBillAuthToken(int id, string EwbTokenExp, string EwbAppKey, string EwbAuthToken, string EwbSEK)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@EwbTokenExp", EwbTokenExp));
            paramList.Add(new Parameters("@EwbAppKey", EwbAppKey));
            paramList.Add(new Parameters("@EwbAuthToken", EwbAuthToken));
            paramList.Add(new Parameters("@EwbSEK", EwbSEK));
            paramList.Add(new Parameters("@Id", id.ToString()));
            int i = (new Connection()).ExecuteSp("ssp_UpdateEWayBillParameters", paramList);
            return i;
        }
        public DataTable getPendingPODs(string branchID)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (branchID != "") paramList.Add(new Parameters("@branchId", branchID.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportPendingPOD", paramList);
            return dt;
        }
        public DataTable ViewInvoiceWayBills(string fromDate, string toDate, string CustomerId, string InvoiceId, string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (CustomerId != "") paramList.Add(new Parameters("@CustomerId", CustomerId.ToString()));
            if (InvoiceId != "") paramList.Add(new Parameters("@InvoiceId", InvoiceId.ToString()));
            if (fromDate != "") paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            if (toDate != "") paramList.Add(new Parameters("@toDate", toDate.ToString()));
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId.ToString())); 
            DataTable dt = (new Connection()).Fillsp("ssp_GetWayBillForInvoice", paramList);
            return dt;
        }
        public DataTable CalculateWaybillInvoice(string WayBillId)
        { 
            List<Parameters> paramList = new List<Parameters>(); 
            paramList.Add(new Parameters("@WayBillId", WayBillId.ToString())); 
            DataTable dt = (new Connection()).Fillsp("ssp_CreateWayBillContractInvoice", paramList); 
            return dt; 
        }
 
        public IDataReader SaveWayBillInvoice(string InvoiceNo, string InvoiceMonthYear, string CustomerId, string total, string cgst, string sgst, string igst, string totalInvoice, string branchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@InvoiceNo", InvoiceNo));
            paramList.Add(new Parameters("@InvoiceMonthYear", InvoiceMonthYear));
            paramList.Add(new Parameters("@CustomerId", CustomerId));
            paramList.Add(new Parameters("@TOTAL", total));
            paramList.Add(new Parameters("@CGST", cgst));
            paramList.Add(new Parameters("@SGST", sgst));
            paramList.Add(new Parameters("@IGST", igst));
            paramList.Add(new Parameters("@TOTALINVOICE", totalInvoice));
            paramList.Add(new Parameters("@BranchId", branchId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_CreateCustomerInvoice", paramList);
            return Reader;
        }
        public IDataReader SaveInvoiceNoINWayBill(string WayBillId, string InvoiceId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@WayBillId", WayBillId));
            paramList.Add(new Parameters("@InvoiceId", InvoiceId));
            IDataReader Reader = (new Connection()).ReadSp("ssp_UpdateInvoiceToWayBill", paramList);
            return Reader;
        }
        public IDataReader ViewInvoiceList(string InvoiceId, string FromDate = "", string ToDate = "") 
        {
            List<Parameters> paramList = new List<Parameters>();
            if(InvoiceId != "") paramList.Add(new Parameters("@InvoiceId", InvoiceId));
            if(FromDate != "") paramList.Add(new Parameters("@FromDate", FromDate)); 
            if(ToDate != "") paramList.Add(new Parameters("@ToDate", ToDate)); 
            IDataReader Reader = (new Connection()).ReadSp("ssp_ViewInvoiceList", paramList); 
            return Reader; 
        } 
        public DataTable ViewMobileWayBill(string FromDate = "", string ToDate = "")
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@FromDate", FromDate));
            paramList.Add(new Parameters("@ToDate", ToDate));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewMobileAppWayBill", paramList);
            return dt;
        }
        public DataTable getTranshipWeight(string BranchId, string fromDate, string toDate)
        {
            List<Parameters> paramList = new List<Parameters>();
            if(BranchId != "") paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
            paramList.Add(new Parameters("@toDate", toDate.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportTranshipWeight", paramList);
            return dt;
        }
        public IDataReader ViewInvoiceWayBillsReport(string fromDate, string toDate) 
        { 
            List<Parameters> paramList = new List<Parameters>(); 
            if (fromDate != "") paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
            if (toDate != "") paramList.Add(new Parameters("@toDate", toDate.ToString())); 
            IDataReader dt = (new Connection()).ReadSp("ssp_ReportWayBillsBookingInvoices", paramList); 
            return dt; 
        }
        public IDataReader ViewMIS(string fromDate, string toDate, string customerId, string BranchId) 
        { 
            List<Parameters> paramList = new List<Parameters>(); 
            if (fromDate != "") paramList.Add(new Parameters("@fromDate", fromDate)); 
            if (toDate != "") paramList.Add(new Parameters("@toDate", toDate));
            if (customerId != "") paramList.Add(new Parameters("@CustomerId", customerId)); 
	    if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId)); 
            IDataReader dt = (new Connection()).ReadSp("ssp_ReportMIS", paramList); 
            return dt; 
        } 
        public DataTable ViewMISdt(string fromDate, string toDate, string customerId, string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            if (fromDate != "") paramList.Add(new Parameters("@fromDate", fromDate));
            if (toDate != "") paramList.Add(new Parameters("@toDate", toDate));
            if (customerId != "") paramList.Add(new Parameters("@CustomerId", customerId));
            if (BranchId != "") paramList.Add(new Parameters("@BranchId", BranchId));
            DataTable dt = (new Connection()).Fillsp("ssp_ReportMIS", paramList);
            return dt;
        }
    }
}