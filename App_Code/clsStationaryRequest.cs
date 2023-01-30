using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.IO; 
using System.Web;
using NameSpaceConnection;

/// <summary>
/// Summary description for clsStationaryRequest
/// </summary>
namespace BLFunctions
{
    public class clsStationaryRequest
    {
        public clsStationaryRequest()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string AddStationaryRequest(string BranchId, string itemQty, string UserId, string BranchName)
        {
            string sResult = "";
            List<Parameters> paramList = new List<Parameters>(); 
            paramList.Add(new Parameters("@BranchId", BranchId)); 
            paramList.Add(new Parameters("@itemQty", itemQty)); 
            paramList.Add(new Parameters("@UserId", UserId)); 
            IDataReader reader = (new Connection()).ExecuteSpIS("ssp_CreateWayBillStationaryRequest", paramList); 
            while (reader.Read()) 
            { 
                sResult = reader["RESULT"].ToString(); 
            }
            //Send An Email to the respective Persons 
            /*string strSubject = "New Waybill Stationary Request";
            string strBody = "Request for Branch :" + BranchName + "<br>" + 
                             "Required Qty :" + itemQty;*/
            //(new SendMail()).MailExecute(strBody, "it@dexters.co.in, ithead@dexters.co.in", null, strSubject); 
            //Call Email send Request https://bsite.net/coldwater/SendStationaryEmail.aspx?Branch=Wagholi&Qty=500
            callurl("https://bsite.net/coldwater/SendStationaryEmail.aspx?Branch=" + BranchName + "&Qty=" + itemQty);

            return sResult; 
        }

        public void callurl(string url)
        {
            WebRequest request = HttpWebRequest.Create(url);
            WebResponse response = request.GetResponse();
            StreamReader reader = new StreamReader(response.GetResponseStream());
            string urlText = reader.ReadToEnd(); // it takes the response from your url. now you can use as your need  
            //Response.Write(urlText.ToString());
        }

        public IDataReader CurrentStationary(string BranchId)
        {
            List<Parameters> paramList = new List<Parameters>(); 
            if(BranchId != "" && BranchId != "11") paramList.Add(new Parameters("@BranchId", BranchId)); 
            IDataReader reader = (new Connection()).ExecuteSpIS("ssp_ViewWayBillStationaryRequests", paramList); 
            return reader; 
        }
        public void SetStationaryRequestStatus(string WaybillStationaryRequestID, string status, string UserId) 
        { 
            List<Parameters> paramList = new List<Parameters>(); 
            paramList.Add(new Parameters("@WaybillStationaryRequestID", WaybillStationaryRequestID)); 
            paramList.Add(new Parameters("@Status", status)); 
            paramList.Add(new Parameters("@UserId", UserId)); 
            IDataReader reader = (new Connection()).ExecuteSpIS("ssp_UpdateWayBillStationaryRequests", paramList); 
        } 
    }
}