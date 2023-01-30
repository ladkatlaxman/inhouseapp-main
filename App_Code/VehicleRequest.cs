using System;
using System.Collections.Generic;
using BLProperties;
using System.Data;
using System.Web;
using System.Web.Services;
using NameSpaceConnection;
/// <summary>
/// Summary description for VehicleRequest 
/// </summary>


namespace BLFunctions
{
    public class VehicleRequest
    {
        public VehicleRequest()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public string[] getVehicles(string searchPrefixText) 
        {
            //int count = 0; 
            List<string> VehicleNo = new List<string>(); 
            DataTable dtTable = null; 
            if (searchPrefixText != "") 
            {
                string expression = "VehicleNo like '%" + searchPrefixText + "%'"; 
                List<Parameters> paramList = new List<Parameters>(); 
                dtTable = (new Connection()).Fillsp("ssp_GetVehicleNoList", paramList); 

                if (dtTable.Rows.Count == 0) 
                { 
                    VehicleNo.Add(string.Format("{0}ʭ{1}", "", "")); 
                }

                DataRow[] rows = dtTable.Select(expression);
                foreach (DataRow dr in rows) 
                { 
                    //count++; 
                    VehicleNo.Add(string.Format("{0}ʭ{1}", dr["VehicleNo"].ToString(), dr["VehicleId"].ToString())); 
                } 
            } 
            //if (count == 0) VehicleNo.Add(string.Format("{0}ʭ{1}", "", "")); 
            return VehicleNo.ToArray(); 
        }

        public string[] getVehicleDetail(string VehicleId)
        {
            List<string> VehicleDetails = new List<string>();

            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VehicleId", VehicleId));
            IDataReader dr = (new Connection()).ReadSp("ssp_GetVehicleDetailsbyId", paramList);
            while (dr.Read())
            {
                VehicleDetails.Add(string.Format("{0}ʭ{1}ʭ{2}", dr["vehicleCategory"].ToString(), dr["VehicleType"].ToString(), dr["vendorName"].ToString()));
            }
            return VehicleDetails.ToArray(); 
        }

        public string[] getRouteSchedules(string RouteId)
        {
            List<string> RouteList = new List<string>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@RouteId", RouteId.ToString()));
            IDataReader RouteListReader = (new Connection()).ReadSp("ssp_GetRouteSchedleMasterRouteSchedules", paramList);
            //RouteList.Add(string.Format("{0}ʭ{1}", "", "SELECT"));
            while (RouteListReader.Read())
            {
                RouteList.Add(string.Format("{0}ʭ{1}", RouteListReader["routeScheduleMasterId"].ToString(), RouteListReader["scheduleName"].ToString())); 
            }
            return RouteList.ToArray();
        }

        public string[] getVehicleLimits(string VehicleId)
        {
            List<string> RouteList = new List<string>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@VehicleId", VehicleId));
            IDataReader RouteListReader = (new Connection()).ReadSp("ssp_ViewVehicleLimit", paramList);
            while (RouteListReader.Read())
            {
                RouteList.Add(string.Format("{0}ʭ{1}", RouteListReader["Branch"].ToString(), RouteListReader["Route"].ToString()));
            }
            return RouteList.ToArray();
        }

        public string SaveVehicleLimit(string VehicleId, string BranchId, string routeId)
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader reader;
            paramList.Add(new Parameters("@VehicleId", VehicleId));
            if (BranchId != "SELECT") paramList.Add(new Parameters("@BranchId", BranchId));
            if (routeId != "SELECT") paramList.Add(new Parameters("@routeId", routeId));
            //paramList.Add(new Parameters("@UserId", userID));
            //paramList.Add(new Parameters("@creationDateTime", (new CFunctions()).CurrentDateTime()));
            reader = (new Connection()).ExecuteSpIS("ssp_CreateVehicleLimit", paramList);
            string result = "";
            if (reader.Read())
            {
                result = reader["STATUS"].ToString() + "::" + reader["STATUS"].ToString();
            }
            return result;
        }
        public IDataReader SaveVehicleRequest(string VehicleId, string RequestType, string hiringDate, string BranchId, 
                    string routeId, string routeMasterScheduleId, string DeliveryRouteId, string userID, string creationDateTime)
        {
            List<Parameters> paramList = new List<Parameters>(); 
            IDataReader reader; 
            paramList.Add(new Parameters("@VehicleId", VehicleId)); 
            paramList.Add(new Parameters("@RequestType", RequestType)); 
            paramList.Add(new Parameters("@hiringDate", hiringDate)); 
            paramList.Add(new Parameters("@BranchId", BranchId)); 
            paramList.Add(new Parameters("@userId", userID)); 
            if (routeId.ToUpper() != "SELECT") paramList.Add(new Parameters("@routeId", routeId)); 
            if (routeMasterScheduleId.ToUpper() != "SELECT") paramList.Add(new Parameters("@routeMasterScheduleId", routeMasterScheduleId)); 
            if (DeliveryRouteId.ToUpper() != "SELECT") paramList.Add(new Parameters("@DeliveryRouteId", DeliveryRouteId)); 
            paramList.Add(new Parameters("@creationDateTime", creationDateTime)); 
            reader = (new Connection()).ExecuteSpIS("ssp_CreateVehicleRequestNew", paramList); 
            return reader; 
        }
    }
}