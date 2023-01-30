using System;
using System.Collections.Generic;
using System.Web;
using BLProperties;
using NameSpaceConnection;
using System.Data;
using System.Net;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for RouteMasterFunctions
/// </summary>
namespace BLFunctionss
{
public class RouteMasterFunctions
{
    int RouteId; string finalvalue;
    public RouteMasterFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    // Get RouteMaster in GridView
    public DataTable ViewData()
    {
        List<Parameters> paramList = new List<Parameters>();
        DataTable dt = (new Connection()).Fillsp("spViewRouteMaster", paramList);
        return dt;
    }

    //public IDataReader LoadData(int RouteId)
    //{
    //    List<Parameters> paramList = new List<Parameters>();
    //    paramList.Add(new Parameters("@Event", "ViewRouteDetail"));
    //    paramList.Add(new Parameters("@Parameter", RouteId.ToString()));
    //    IDataReader reader = (new Connection()).ReadSp("spBindRouteMaster", paramList);
    //    return reader;
    //}
    public DataTable AddRouteScheduleDetail(int RouteId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Event", "ViewAddRouteSchedule"));
        paramList.Add(new Parameters("@Parameter", ""));
        DataTable dt = (new Connection()).Fillsp("spBindRouteMaster", paramList);
        return dt;
    }


    public List<RouteScheduleGrid> ShowRouteScheduleList(int RouteId)
    {
        List<RouteScheduleGrid> RouteList = new List<RouteScheduleGrid>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Event", "ViewAddRouteSchedule"));
        paramList.Add(new Parameters("@Parameter", RouteId.ToString()));
        IDataReader RouteListReader = (new Connection()).ReadSp("spBindRouteMaster", paramList);
        RouteScheduleGrid Routes;
        while (RouteListReader.Read())
        {
            Routes = new RouteScheduleGrid();
            Routes.routeDetailID = Convert.ToInt32(RouteListReader["routeDetailId"]);
            Routes.route = RouteListReader["route"].ToString();
            RouteList.Add(Routes);
        }
        return RouteList;
    }

    // Search RouteMaster in GridView
    public DataTable SearchData(string ddl, int branchId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if (ddl == "FROM BRANCH")
            paramList.Add(new Parameters("@Event", "FromBranch"));
        else if (ddl == "TOUCHING BRANCH")
            paramList.Add(new Parameters("@Event", "TouchingBranch"));
        else if (ddl == "TO BRANCH")
            paramList.Add(new Parameters("@Event", "ToBranch"));
        paramList.Add(new Parameters("@BranchId", branchId.ToString()));
        DataTable dt = (new Connection()).Fillsp("spSearchRouteMaster", paramList);
        return dt;
    }

    public string[] GetBranch(string searchPrefixText)
    {
        int count = 0;
        List<string> branch = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["GetBranchName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            dtTable = (new Connection()).Fillsp("ssp_GetBranchList", paramList);
            HttpContext.Current.Application["GetBranchName"] = dtTable;
        }
        else
            dtTable = HttpContext.Current.Application["GetBranchName"] as DataTable;
        if (searchPrefixText != "")
        {
            string expression = "branchName like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            foreach (DataRow dr in rows)
            {
                count++;
                branch.Add(string.Format("{0}-{1}", dr["branchName"].ToString(), dr["branchID"].ToString()));
            }
            if (count == 0) branch.Add(string.Format("{0}-{1}", "", ""));
        }
        return branch.ToArray();
    }
    public string[] ViewRouteFromBranch(string searchPrefixText, string ddl)
    {
        int count = 0;
        List<string> branch = new List<string>();
        DataTable dtTable = null;
        if (ddl == "FROM BRANCH")
        {
            if (HttpContext.Current.Application["ViewFromBranch"] == null)
            {
                dtTable = null;
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@Event", ddl));
                dtTable = (new Connection()).Fillsp("ssp_ViewRouteBranchs", paramList);
                HttpContext.Current.Application["ViewFromBranch"] = dtTable;
            }
            else
                dtTable = HttpContext.Current.Application["ViewFromBranch"] as DataTable;
        }
        else if (ddl == "TOUCHING BRANCH")
        {
            dtTable = null;
            if (HttpContext.Current.Application["ViewTouchingBranch"] == null)
            {
                dtTable = null;
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@Event", ddl));
                dtTable = (new Connection()).Fillsp("ssp_ViewRouteBranchs", paramList);
                HttpContext.Current.Application["ViewTouchingBranch"] = dtTable;
            }
            else
                dtTable = HttpContext.Current.Application["ViewTouchingBranch"] as DataTable;
        }
        else if (ddl == "TO BRANCH")
        {
            if (HttpContext.Current.Application["ViewToBranch"] == null)
            {
                dtTable = null;
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@Event", ddl));
                dtTable = (new Connection()).Fillsp("ssp_ViewRouteBranchs", paramList);
                HttpContext.Current.Application["ViewToBranch"] = dtTable;
            }
            else
                dtTable = HttpContext.Current.Application["ViewToBranch"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "branchName like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            foreach (DataRow dr in rows)
            {
                count++;
                branch.Add(string.Format("{0}-{1}", dr["branchName"].ToString(), dr["branchID"].ToString()));
            }
            if (count == 0) branch.Add(string.Format("{0}-{1}", "", ""));
        }
        return branch.ToArray();
    }

    //public string[] GetBranch(string searchPrefixText, string data, string ddl)
    //{
    //    DdlBranch BranchDetail;
    //    int count = 0;
    //    List<string> branch = new List<string>();
    //    List<Parameters> paramList = new List<Parameters>();
    //    if (data == "GetData" && ddl == "")
    //        paramList.Add(new Parameters("@Event", "GetBranch"));
    //    else if (data == "ReadData" && ddl == "")
    //        paramList.Add(new Parameters("@Event", "ReadBranch"));
    //    else if (data == "GetData" && ddl == "FROM BRANCH")
    //        paramList.Add(new Parameters("@Event", "GetSFromBranch"));
    //    else if (data == "ReadData" && ddl == "FROM BRANCH")
    //        paramList.Add(new Parameters("@Event", "ReadSFromBranch"));
    //    else if (data == "GetData" && ddl == "TOUCHING BRANCH")
    //        paramList.Add(new Parameters("@Event", "GetSTouchingBranch"));
    //    else if (data == "ReadData" && ddl == "TOUCHING BRANCH")
    //        paramList.Add(new Parameters("@Event", "ReadSTouchingBranch"));
    //    else if (data == "GetData" && ddl == "TO BRANCH")
    //        paramList.Add(new Parameters("@Event", "GetSToBranch"));
    //    else if (data == "ReadData" && ddl == "TO BRANCH")
    //        paramList.Add(new Parameters("@Event", "ReadSToBranch"));
    //    paramList.Add(new Parameters("@Parameter", searchPrefixText));
    //    IDataReader Reader = (new Connection()).ReadSp("spBindRouteMaster", paramList);
    //    while (Reader.Read())
    //    {
    //        count++;
    //        BranchDetail = new DdlBranch();
    //        BranchDetail.Branch = Reader["branchName"].ToString();
    //        BranchDetail.BranchId = Convert.ToInt32(Reader["branchID"].ToString());
    //        branch.Add(string.Format("{0}-{1}", BranchDetail.Branch, BranchDetail.BranchId));
    //    }
    //    if (count == 0)
    //        branch.Add(string.Format("{0}-{1}", "", ""));
    //    return branch.ToArray();
    //}
    public string GetMapDistance(string FromBranch, string ToBranch)
    {
        if (FromBranch != "" && ToBranch != "")
        {
            string url = @"https://maps.googleapis.com/maps/api/distancematrix/xml?units=metric&origins=" + FromBranch + "&destinations=" + ToBranch + "&key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E";
            WebRequest request = WebRequest.Create(url);
            using (WebResponse response = (HttpWebResponse)request.GetResponse())
            {
                using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    DataSet dsResult = new DataSet();
                    dsResult.ReadXml(reader);
                    long value = Convert.ToInt64(dsResult.Tables["distance"].Rows[0]["value"].ToString());
                    finalvalue = Convert.ToString(value / 1000);
                }
            }
        }
        return finalvalue;
    }
    public bool SaveRouteData(RouteMasterProperties RouteMasterDetail, List<RouteDetails> RouteDetail)
    {
        string routname = "";
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@RouteName", RouteMasterDetail.RouteName));
        IDataReader Reader = (new Connection()).ReadSp("ssp_CheckRouteNameAvailability", paramList);
        while (Reader.Read())
        {
            routname = Reader["routeName"].ToString();
        }
        IDataReader reader = null;
        if (routname == "")
        {
            int RouteId;
            RouteMasterProperties Session = new RouteMasterProperties();
            Session.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
            Session.sessionDetail.UserID = Convert.ToInt32(HttpContext.Current.Session["employeeID"]);
            paramList = new List<Parameters>();
            #region HeaderParameter
            paramList.Add(new Parameters("@Event", "InsertRouteMaster"));
            paramList.Add(new Parameters("@RouteId", ""));
            paramList.Add(new Parameters("@routeName", RouteMasterDetail.RouteName.ToUpper()));
            paramList.Add(new Parameters("@fromBranchID", RouteMasterDetail.HFromBranchId.ToString()));
            paramList.Add(new Parameters("@toBranchID", RouteMasterDetail.HToBranchId.ToString()));
            paramList.Add(new Parameters("@routeDistance", RouteMasterDetail.TotalDistance.ToString()));
            paramList.Add(new Parameters("@mapDistance", RouteMasterDetail.TotalMapDistance.ToString()));
            paramList.Add(new Parameters("@createDateTime", Session.sessionDetail.CreationDateTime));
            paramList.Add(new Parameters("@userID", Session.sessionDetail.UserID.ToString()));
            #endregion
            reader = (new Connection()).ExecuteSpIS("ssp_CreateRouteMaster", paramList);
            if (reader.Read())
            {
                RouteId = Convert.ToInt32(reader["id"]);
                foreach (RouteDetails detail in RouteDetail)
                {
                    #region DetailParameters
                    paramList = new List<Parameters>();
                    paramList.Add(new Parameters("@Event", "InsertRouteMasterDetail"));
                    paramList.Add(new Parameters("@RouteId", RouteId.ToString()));
                    paramList.Add(new Parameters("@routeName", ""));
                    paramList.Add(new Parameters("@fromBranchID", detail.FromBranchId.ToString()));
                    paramList.Add(new Parameters("@toBranchID", detail.ToBranchId.ToString()));
                    paramList.Add(new Parameters("@routeDistance", detail.Distance.ToString()));
                    paramList.Add(new Parameters("@mapDistance", detail.MapDistance.ToString()));
                    paramList.Add(new Parameters("@createDateTime", Session.sessionDetail.CreationDateTime));
                    paramList.Add(new Parameters("@userID", Session.sessionDetail.UserID.ToString()));
                    #endregion
                    (new Connection()).ExecuteSp("ssp_CreateRouteMaster", paramList);
                }
            }
            DataTable dtTable = null;
            paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "FROM BRANCH"));
            dtTable = (new Connection()).Fillsp("ssp_ViewRouteBranchs", paramList);
            HttpContext.Current.Application["ViewFromBranch"] = dtTable;

            dtTable = null;
            paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "TOUCHING BRANCH"));
            dtTable = (new Connection()).Fillsp("ssp_ViewRouteBranchs", paramList);
            HttpContext.Current.Application["ViewTouchingBranch"] = dtTable;

            dtTable = null;
            paramList = new List<Parameters>();
            paramList.Add(new Parameters("@Event", "TO BRANCH"));
            dtTable = (new Connection()).Fillsp("ssp_ViewRouteBranchs", paramList);
            HttpContext.Current.Application["ViewToBranch"] = dtTable;
        }
        return reader != null;
    }

    //Get RouteName
    public List<RouteMasterProperties> getRouteName()
    {
        RouteMasterProperties RouteName;
        List<Parameters> paramList = new List<Parameters>();
        List<RouteMasterProperties> RouteNameList = new List<RouteMasterProperties>();
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetRouteMasterRouteName", paramList);
        while (Reader.Read())
        {
            RouteName = new RouteMasterProperties();
            RouteName.RouteName = Reader["routeName"].ToString();
            RouteName.RouteId = Convert.ToInt32(Reader["routeID"]);
            RouteNameList.Add(RouteName);
        }
        return RouteNameList;
    }

    //Save RouteSchedule
    public bool SaveRouteSchedule(RouteScheduleGrid RouteScheduleDetail)
    {
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        #region HeaderParameter
        paramList.Add(new Parameters("@Event", "CreateSchedules"));
        paramList.Add(new Parameters("@routeScheduleMasterId", ""));
        paramList.Add(new Parameters("@routeId", RouteScheduleDetail.routeDetailID.ToString()));
        paramList.Add(new Parameters("@scheduleName", RouteScheduleDetail.scheduleName.ToUpper()));
        paramList.Add(new Parameters("@routeDetailId", ""));
        paramList.Add(new Parameters("@routeScheduleRemark", RouteScheduleDetail.remark.ToUpper()));
        paramList.Add(new Parameters("@routeDay", ""));
        paramList.Add(new Parameters("@leaveTime", ""));
        paramList.Add(new Parameters("@reachTime", ""));
        paramList.Add(new Parameters("@userID", RouteScheduleDetail.sessionDetail.UserID.ToString()));
        paramList.Add(new Parameters("@branchID", RouteScheduleDetail.sessionDetail.BranchID.ToString()));
        paramList.Add(new Parameters("@creationDateTime", RouteScheduleDetail.sessionDetail.CreationDateTime.ToString()));
        #endregion
        reader = (new Connection()).ExecuteSpIS("spCreateOrUpdateRouteSchedule", paramList);
        if (reader.Read())
        {
            int routeScheduleMasterId = Convert.ToInt32(reader["id"]);
            //Schedules Details
            foreach (RouteScheduleGrid detail in RouteScheduleDetail.routeScheduleDetails)
            {
                #region DetailParameters
                paramList = new List<Parameters>();
                paramList.Add(new Parameters("@Event", "CreateScheduleDetails"));
                paramList.Add(new Parameters("@routeScheduleMasterId", routeScheduleMasterId.ToString()));
                paramList.Add(new Parameters("@routeId", ""));
                paramList.Add(new Parameters("@scheduleName", ""));
                paramList.Add(new Parameters("@routeDetailId", detail.routeDetailID.ToString()));
                paramList.Add(new Parameters("@routeScheduleRemark", ""));
                paramList.Add(new Parameters("@routeDay", detail.routeDay.ToString()));
                paramList.Add(new Parameters("@leaveTime", detail.leaveTime.ToString()));
                paramList.Add(new Parameters("@reachTime", detail.reachTime.ToString()));
                paramList.Add(new Parameters("@userID", ""));
                paramList.Add(new Parameters("@branchID", ""));
                paramList.Add(new Parameters("@creationDateTime", ""));
                #endregion
                (new Connection()).ExecuteSp("spCreateOrUpdateRouteSchedule", paramList);
            }
        }
        return reader != null;
    }
    public List<RouteScheduleGrid> ViewRouteName()
    {
        RouteScheduleGrid Routes;
        List<RouteScheduleGrid> RouteList = new List<RouteScheduleGrid>();
        List<Parameters> paramList = new List<Parameters>();
        IDataReader RouteListReader = (new Connection()).ReadSp("ssp_ViewRouteScheduleMasterRouteName", paramList);
        while (RouteListReader.Read())
        {
            Routes = new RouteScheduleGrid();
            Routes.routeId = Convert.ToInt32(RouteListReader["routeId"]);
            Routes.routeName = RouteListReader["routeName"].ToString();
            RouteList.Add(Routes);
        }
        return RouteList;
    }
    //View Data
    public List<RouteScheduleGrid> SearchRouteScheduleList(string RouteName)
    {
        List<RouteScheduleGrid> RouteList = new List<RouteScheduleGrid>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@routeName", RouteName));
        IDataReader RouteListReader = (new Connection()).ReadSp("ssp_SearchRouteMasterSchedule", paramList);
        RouteScheduleGrid Routes;
        while (RouteListReader.Read())
        {
            Routes = new RouteScheduleGrid();
            Routes.routeId = Convert.ToInt32(RouteListReader["routeId"]);
            Routes.routeName = RouteListReader["routeName"].ToString();
            Routes.scheduleName = RouteListReader["scheduleName"].ToString();
            Routes.routeDetailID = Convert.ToInt32(RouteListReader["routeDetailId"]);
            Routes.route = RouteListReader["route"].ToString();
            Routes.routeDay = RouteListReader["routeDay"].ToString();
            Routes.leaveTime = RouteListReader["leaveTime"].ToString();
            Routes.reachTime = RouteListReader["reachTime"].ToString();
            RouteList.Add(Routes);
        }
        return RouteList;
    }

    #region /*-----------------------------Load Data---------------------------------------*/
    //Load Route Header Data
    public string[] LoadRouteHeaderData(int RouteID)
    {
        List<string> RouteHeaderDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Event", "RouteHeaderDetail"));
        paramList.Add(new Parameters("@RouteId", RouteID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetRouteDetailsById", paramList);
        while (Reader.Read())
        {
            RouteHeaderDetail.Add(string.Format("{0}_{1}_{2}_{3}_{4}_{5}_{6}",
                Reader["FromBranch"], Reader["fromBranchID"], Reader["ToBranch"], Reader["toBranchID"], Reader["routeName"],
                Reader["routeTotalDistance"], Reader["mapTotalDistance"]));

        }
        return RouteHeaderDetail.ToArray();
    }
    //Load Route Details Data
    public string[] LoadRouteDetailsData(int RouteID)
    {
        List<string> RouteDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Event", "RouteDetails"));
        paramList.Add(new Parameters("@RouteId", RouteID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetRouteDetailsById", paramList);
        while (Reader.Read())
        {
            RouteDetail.Add(string.Format("{0}_{1}_{2}_{3}_{4}_{5}",
                Reader["FromBranch"], Reader["fromBranchID"], Reader["ToBranch"], Reader["toBranchID"], Reader["routeDistance"],
                Reader["mapDistance"]));

        }
        return RouteDetail.ToArray();
    }
    #endregion


    //Transhipment LHS Used
    public List<DdlBranch> BranchWithWaybillCount(string RouteId)
    {
        DdlBranch RouteBranches;
        List<DdlBranch> RouteBeanchList = new List<DdlBranch>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@routeId", RouteId));
        IDataReader RouteListReader = (new Connection()).ReadSp("ssp_ViewRouteWayBills", paramList);
        while (RouteListReader.Read())
        {
            RouteBranches = new DdlBranch();
            RouteBranches.BranchId = Convert.ToInt32(RouteListReader["branchId"]);
            RouteBranches.Branch = RouteListReader["Branch"].ToString();
            RouteBeanchList.Add(RouteBranches);
        }
        return RouteBeanchList;
    }
}
}

/*------------------Old Submit Button Code----------------------*/
//List<Parameters> paramList = new List<Parameters>();
//IDataReader reader = null;
//#region HeaderParameter
//paramList.Add(new Parameters("@Event", "InsertRouteMaster"));
//            paramList.Add(new Parameters("@RouteId", ""));
//            paramList.Add(new Parameters("@routeName", RouteMasterDetail.RouteName));
//            paramList.Add(new Parameters("@fromBranchID", RouteMasterDetail.HFromBrnachId.ToString()));
//            paramList.Add(new Parameters("@toBranchID", RouteMasterDetail.HToBrnachId.ToString()));
//            paramList.Add(new Parameters("@routeDistance", RouteMasterDetail.TotalDistance.ToString()));
//            paramList.Add(new Parameters("@mapDistance", RouteMasterDetail.TotalMapDistance.ToString()));
//            paramList.Add(new Parameters("@createDateTime", RouteMasterDetail.sessionDetail.CreationDateTime));
//            paramList.Add(new Parameters("@userID", RouteMasterDetail.sessionDetail.UserID.ToString()));
//            #endregion
//            reader = (new Connection()).ExecuteSpIS("spCreateRouteMaster", paramList);
//            if (reader.Read())
//            {
//                RouteId = Convert.ToInt32(reader["id"]);
//                foreach (RouteDetails detail in RouteMasterDetail.RouteDetail)
//                {
//                    #region DetailParameters
//                    paramList = new List<Parameters>();
//                    paramList.Add(new Parameters("@Event", "InsertRouteMasterDetail"));
//                    paramList.Add(new Parameters("@RouteId", RouteId.ToString()));
//                    paramList.Add(new Parameters("@routeName", ""));
//                    paramList.Add(new Parameters("@fromBranchID", detail.FromBrnachId.ToString()));
//                    paramList.Add(new Parameters("@toBranchID", detail.ToBrnachId.ToString()));
//                    paramList.Add(new Parameters("@routeDistance", detail.Distance.ToString()));
//                    paramList.Add(new Parameters("@mapDistance", detail.MapDistance.ToString()));
//                    paramList.Add(new Parameters("@createDateTime", RouteMasterDetail.sessionDetail.CreationDateTime));
//                    paramList.Add(new Parameters("@userID", RouteMasterDetail.sessionDetail.UserID.ToString()));
//                    #endregion
//                    (new Connection()).ExecuteSp("spCreateRouteMaster", paramList);
//                }
//            }
//            return reader != null;