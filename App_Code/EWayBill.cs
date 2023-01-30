using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using BLProperties;
using NameSpaceConnection;
using System.Data;
using System.Text;
using System.Web;
using BLProperties;
using NameSpaceConnection;
using TaxProEWB.API;
using Newtonsoft.Json;

/// <summary>
/// Summary description for BranchFunctions
/// </summary>
namespace BLFunctions
{
    public class EWayBill
    {
        public EWBSession EwbSession = new EWBSession();
        DateTime dtTokenExpiry, dtNow;
        public EWayBill()
        {
        }
        public IDataReader getDetails() 
        {
            List<Parameters> paramList = new List<Parameters>();
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetEWayBillParameters", paramList);
            return Reader;
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
        public async Task<string> getEWBDetails(string strEWBNo)
        {
            getTokenDetails();
            long EwbNo = long.Parse(strEWBNo.ToString());
            string result = "";
            TxnRespWithObjAndInfo<RespGetEWBDetail> TxnResp = await EWBAPI.GetEWBDetailAsync(EwbSession, EwbNo);
            var a = JsonConvert.SerializeObject(TxnResp.RespObj);
            if (TxnResp.IsSuccess)
                result = JsonConvert.SerializeObject(TxnResp.RespObj);
            else
            {
                result = TxnResp.TxnOutcome;
                List<Parameters> paramList = new List<Parameters>();
                paramList.Add(new Parameters("@errMessage", result));
                (new Connection()).ExecuteSp("ssp_CreateError", paramList);
            }
            return result;
        }

        public int SaveError(string error)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@errMessafe", error));
            int i = (new Connection()).ExecuteSp("ssp_CreateError", paramList);
            return i;
        }


        private void getTokenDetails()
        {
            IDataReader dr = (new EWayBill()).getDetails();
            dtNow = DateTime.Now;

            EwbSession = new EWBSession();
            while (dr.Read())
            {
                EwbSession.EwbApiSetting.GSPName = dr["GSPName"].ToString();
                EwbSession.EwbApiSetting.AspUserId = dr["AspUserId"].ToString();
                EwbSession.EwbApiSetting.AspPassword = dr["AspPassword"].ToString();
                EwbSession.EwbApiSetting.EWBClientId = "";
                EwbSession.EwbApiSetting.EWBClientSecret = "";
                EwbSession.EwbApiSetting.EWBGSPUserID = "";
                EwbSession.EwbApiSetting.BaseUrl = dr["BaseUrl"].ToString();

                EwbSession.EwbApiLoginDetails.EwbGstin = dr["EwbGstin"].ToString();
                EwbSession.EwbApiLoginDetails.EwbUserID = dr["EwbUserID"].ToString();
                EwbSession.EwbApiLoginDetails.EwbPassword = dr["EwbPassword"].ToString();
                EwbSession.EwbApiLoginDetails.EwbTokenExp = Convert.ToDateTime(dr["EwbTokenExp"].ToString());

                EwbSession.EwbApiLoginDetails.EwbAppKey = dr["EwbAppKey"].ToString();
                EwbSession.EwbApiLoginDetails.EwbAuthToken = dr["EwbAuthToken"].ToString();
                EwbSession.EwbApiLoginDetails.EwbSEK = dr["EwbSEK"].ToString();
                dtTokenExpiry = Convert.ToDateTime(dr["EwbTokenExp"].ToString());
                /*if (dtTokenExpiry < dtNow)
                {
                    getAuthToken();
                }*/
            }
        }

    }
}