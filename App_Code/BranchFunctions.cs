using System;
using System.Collections.Generic;
using BLProperties;
using NameSpaceConnection;
using System.Data;
using System.Text;
/// <summary>
/// Summary description for BranchFunctions
/// </summary>
namespace BLFunctions
{
    public class BranchFunctions
    {
        public BranchFunctions()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<DdlBranch> getBranches(int EmployeeId)
        {
            //List<Parameters> paramList = new List<Parameters>();
            List<DdlBranch> rtList = new List<DdlBranch>();
            List<Parameters> prm = new List<Parameters>();
            prm.Add(new Parameters("employeeId", EmployeeId.ToString())); 

            IDataReader dr = (new Connection()).ReadSp("ssp_GetEmplBelongToBranch", prm);
            DdlBranch rtName;

            while(dr.Read())
            {
                rtName = new DdlBranch();
                rtName.BranchId = Convert.ToInt32(dr["branchId"].ToString());
                rtName.Branch = dr["branchName"].ToString();
                rtList.Add(rtName); 
            }

            return rtList;
        }
        public string getNotifications(int BranchId)
        {
            StringBuilder strNotification = new StringBuilder();
            List<Parameters> prm = new List<Parameters>();
            prm.Add(new Parameters("BranchId", BranchId.ToString()));

            IDataReader dr = (new Connection()).ReadSp("ssp_Notifications", prm);

            while (dr.Read())
            {
                strNotification.Append(dr["tblNote"].ToString());
                //strNotification.Append("<BR>");
            }
            return strNotification.ToString();
        }
	public DataTable ViewBranchRelatedVehicles(int BranchId)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@BranchId", BranchId.ToString()));
            DataTable dt = (new Connection()).Fillsp("ssp_ViewBranchRelatedVehicle", paramList);
            return dt;
        }
        public string GetBranchNameFromId(string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>(); 
            paramList.Add(new Parameters("@BranchId", BranchId.ToString())); 
            DataTable dt = (new Connection()).Fillsp("ssp_GetBranchNameFromId", paramList);
            IDataReader dr = (new Connection()).ReadSp("ssp_GetBranchNameFromId", paramList);
            while(dr.Read())
            {
                return dr["BranchName"].ToString(); 
            }
            return "";
        }
    }
}