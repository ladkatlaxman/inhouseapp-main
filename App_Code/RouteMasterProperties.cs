using System.Collections.Generic;

/// <summary>
/// Summary description for RouteMasterProperties
/// </summary>
namespace BLProperties
{
    public class RouteMasterProperties
    {
        private sessionDetails session;

        public RouteMasterProperties()
        {
            //
            // TODO: Add constructor logic here
            //
            if (session == null) session = new sessionDetails();

        }
        public int RouteId { get; set; }
        public int HFromBranchId { get; set; }
        public string HFromBranch { get; set; }
        public int HToBranchId { get; set; }
        public string HToBranch { get; set; }
        public string RouteName { get; set; }
        public long TotalDistance { get; set; }
        public long TotalMapDistance { get; set; }
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
        public List<RouteDetails> RouteDetail { get; set; }
    }

    public class allRoutes
    {
        public List<RouteDetails> routes { get; set; }
    }

    public class RouteDetails
    {
        public int RouteId { get; set; }
        public int FromBranchId { get; set; }
        public string FromBranch { get; set; }
        public int ToBranchId { get; set; }
        public string ToBranch { get; set; }
        public long Distance { get; set; }
        public long MapDistance { get; set; }
    }
    public class DdlBranch
    {
        public int BranchId { get; set; }
        public string Branch { get; set; }
    }
    public class RouteScheduleGrid
    {
        private sessionDetails session;
        public RouteScheduleGrid()
        {
            //
            // TODO: Add constructor logic here
            //
            if (session == null) session = new sessionDetails();
        }
        public int scheduleId { get; set; }
        public string scheduleName { get; set; }
        public int routeId { get; set; }
        public string routeName { get; set; }
        public int routeDetailID { get; set; }
        public string route { get; set; }
        public string routeDay { get; set; }
        public string leaveTime { get; set; }
        public string reachTime { get; set; }
        public string remark { get; set; }
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
        public List<RouteScheduleGrid> routeScheduleDetails { get; set; }
    }
}