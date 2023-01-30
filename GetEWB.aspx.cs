using System;
using System.Data;
using System.Threading.Tasks;
using BLFunctions;
using System.Web;
using System.Web.UI;
//using TaxProEInvoice.API;
using TaxProEWB.API;
using Newtonsoft.Json;
using System.Net;
using System.Collections.Generic;

public partial class GetEWB : System.Web.UI.Page
{
    //eInvoiceSession eInvSession = new eInvoiceSession(true, true);
    public EWBSession EwbSession = new EWBSession();
    DateTime dtTokenExpiry, dtNow;
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Btn_Submit_Click(object sender, EventArgs e)
    {
        Task<string> task = Task.Run<string>(async () => await getEWBDetails(txtEWBNo.Text));
        txtEWMDetails.Text = task.Result; 
    }
    private async Task<string> getEWBDetails(string strEWBNo)
    {
        getTokenDetails();
        long EwbNo = 0;
        long.TryParse(strEWBNo, out EwbNo); //221462336652;
        string result = "";
        TxnRespWithObjAndInfo<RespGetEWBDetail> TxnResp = await EWBAPI.GetEWBDetailAsync(EwbSession, EwbNo);
        var a = JsonConvert.SerializeObject(TxnResp.RespObj);
        if (TxnResp.IsSuccess)
        {
            //result = "[" + JsonConvert.SerializeObject(TxnResp.RespObj) + "]";
            result = JsonConvert.SerializeObject(TxnResp.RespObj);
            //IList<ItemList> validProdcuts = JsonHelper.DeserializeToList<ItemList>(result);
        }
        else
            result = TxnResp.TxnOutcome;
        return result;
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
            if (dtTokenExpiry < dtNow)
            {
                getAuthToken();
            }
        }
    }
    private void getAuthToken()
    {
        ServicePointManager.ServerCertificateValidationCallback += (sender, cert, chain, sslPolicyErrors) => true; 
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        //ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

        //TxnRespWithObjAndInfo<EWBSession> TxnResp = await EWBAPI.GetAuthTokenAsync(EwbSession); 
        TxnRespWithObjAndInfo<EWBSession> TxnResp = Task.Run(() => EWBAPI.GetAuthTokenAsync(EwbSession)).Result; 

        if (TxnResp.IsSuccess) 
        { 
            txtEWMDetails.Text = "Auth Token Response"; 
            (new EWayBill()).SaveEWayBillAuthToken(1, EwbSession.EwbApiLoginDetails.EwbTokenExp.ToString(), 
                    EwbSession.EwbApiLoginDetails.EwbAppKey, EwbSession.EwbApiLoginDetails.EwbAuthToken, EwbSession.EwbApiLoginDetails.EwbSEK); 
        } 
    } 
    public String getAuthTokenOld1() 
    {
        TxnRespWithObjAndInfo<EWBSession> TxnResp = Task.Run(() => EWBAPI.GetAuthTokenAsync(EwbSession)).Result;
        if (TxnResp.IsSuccess)
        {
            txtEWMDetails.Text = "Auth Token Response";
            (new EWayBill()).SaveEWayBillAuthToken(1, EwbSession.EwbApiLoginDetails.EwbTokenExp.ToString(),
                    EwbSession.EwbApiLoginDetails.EwbAppKey, EwbSession.EwbApiLoginDetails.EwbAuthToken, EwbSession.EwbApiLoginDetails.EwbSEK);
        }
        return "";
    }

    private void getAuthTokenOld()
    {
        //SetDetails(); 

        //TxnRespWithObjAndInfo<EWBSession> TxnResp = await EWBAPI.GetAuthTokenAsync(EwbSession);
        TxnRespWithObjAndInfo<EWBSession> TxnResp = Task.Run(() => EWBAPI.GetAuthTokenAsync(EwbSession)).Result;

        if (TxnResp.IsSuccess)
        {
            txtEWMDetails.Text = "Auth Token Response"; 
            (new EWayBill()).SaveEWayBillAuthToken(1, EwbSession.EwbApiLoginDetails.EwbTokenExp.ToString(), 
                    EwbSession.EwbApiLoginDetails.EwbAppKey, EwbSession.EwbApiLoginDetails.EwbAuthToken, EwbSession.EwbApiLoginDetails.EwbSEK); 
        } 
    }

    private void SetDetails()
    {
        EwbSession.EwbApiSetting.GSPName = "TaxPro_Production";
        EwbSession.EwbApiSetting.AspUserId = "1644741920";
        EwbSession.EwbApiSetting.AspPassword = "Dex@@159#";
        EwbSession.EwbApiSetting.EWBClientId = "";
        EwbSession.EwbApiSetting.EWBClientSecret = "";
        EwbSession.EwbApiLoginDetails.EwbUserID = "pavan@1#API";
        EwbSession.EwbApiLoginDetails.EwbPassword = "Dex@@159#";

        //EwbSession.EwbApiSetting.AuthUrl = "https://einvapi.charteredinfo.com/eivital/v1.04";
        //EwbSession.EwbApiSetting.BaseUrl = "https://einvapi.charteredinfo.com/eicore/v1.03";
        EwbSession.EwbApiSetting.AuthUrl = "https://einvapi.charteredinfo.com/eiewb/v1.03";
        //EwbSession.EwbApiSetting.BaseUrl = "https://einvapi.charteredinfo.com/eicore/v1.03";
    }
    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
}