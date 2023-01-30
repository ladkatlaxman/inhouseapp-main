using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.IdentityModel.Protocols.WSTrust;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for project
/// </summary>
public class project
{
    public project()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public IDataReader ViewProjects(String StatusId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@StatusId", StatusId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_ViewProject", paramList); 
        return Reader;
    }
    public IDataReader ViewProjectOnId(String ProjectId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ProjectId", ProjectId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_ViewProject", paramList);
        return Reader;
    }
    public DataTable ViewProjectStatusMaster()
    {
        List<Parameters> paramList = new List<Parameters>();
        return (new Connection()).Fillsp("ssp_GetProjectStatus", paramList);
    }

    public DataTable ViewProjectStatus(string ProjectId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ProjectId", ProjectId));
        return (new Connection()).Fillsp("ssp_ViewProjectUpdate", paramList);
    }

    public void UpdateProjectStatus(string ProjectId, string statusId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ProjectId", ProjectId));
        paramList.Add(new Parameters("@Status", statusId));
        (new Connection()).ReadSp("ssp_UpdateProjectStatus", paramList);
    }


    public IDataReader CreateProject(string ProjectDescription, string ProjectStatusId, string CreationDate, 
            string StartDate, string EndDate, string SelfProjectId, string UserId) 
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ProjectDescription", ProjectDescription));
        paramList.Add(new Parameters("@ProjectStatusId", ProjectStatusId));
        paramList.Add(new Parameters("@CreationDate", CreationDate));
        paramList.Add(new Parameters("@StartDate", StartDate));
        paramList.Add(new Parameters("@EndDate", EndDate));
        if(SelfProjectId != null) paramList.Add(new Parameters("@SelfProjectId", SelfProjectId)); 
        paramList.Add(new Parameters("@UserId", UserId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_CreateProject", paramList);
        return Reader;
    }

    public IDataReader CreateProjectUpdate(string Comments, string ProjectId, string StartDate, string EndDate, string creationdate, string ProjectStatusId, string UserId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Comments", Comments));
        paramList.Add(new Parameters("@ProjectId", ProjectId));
        paramList.Add(new Parameters("@StartDate", StartDate));
        paramList.Add(new Parameters("@EndDate", EndDate));
        paramList.Add(new Parameters("@CreationDate", creationdate));
        paramList.Add(new Parameters("@ProjectStatusId ", ProjectStatusId));
        paramList.Add(new Parameters("@UserId", UserId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_CreateProjectUpdate", paramList); 
        return Reader; 
    }

}