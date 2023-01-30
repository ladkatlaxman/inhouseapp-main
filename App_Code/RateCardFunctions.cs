using System;
using System.Collections.Generic;
using BLProperties;
using NameSpaceConnection;
using System.Data;

/// <summary>
/// Summary description for RateCardFunctions
/// </summary>
public class RateCardFunctions
{
    public RateCardFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    // Get Branch Name From Pincode

    public List<RateCardType> getRateCardType()
    {
        RateCardType rc;
        List<Parameters> paramList = new List<Parameters>();
        List<RateCardType> List = new List<RateCardType>();
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetRateType", paramList);
        while (Reader.Read())
        {
            rc = new RateCardType();
            rc.RateType = Reader["RateTypeName"].ToString();
            rc.Id = Convert.ToInt32(Reader["RateTypeId"]);
            List.Add(rc);
        }
        return List;
    }

    // Get Rate Card Details in GridView
    public DataTable ViewData()
    {
        List<Parameters> paramList = new List<Parameters>();
        DataTable dt = (new Connection()).Fillsp("ssp_GetRateCard", paramList);
        return dt;
    }
    /*public DataTable ViewContractRateCard()
    {
        List<Parameters> paramList = new List<Parameters>();
        DataTable dt = (new Connection()).Fillsp("ssp_GetContractCustomerRateCard", paramList);
        return dt;
    }

    // Get Rate Card Details in GridView
    public DataTable ViewContractRateCard(string contractID)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ContractID", contractID.ToString()));
        DataTable dt = (new Connection()).Fillsp("ssp_GetContractCustomerRateCard", paramList);
        return dt;
    }*/
    public IDataReader ViewContractRateCard(string contractId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ContractID", contractId));
        //DataTable dt = (new Connection()).Fillsp("ssp_GetContractCustomerRateCard", paramList);
        IDataReader reader = (new Connection()).ExecuteSpIS("ssp_GetContractCustomerRateCard", paramList);
        return reader;
    }
    public bool SaveRateCardDetails(RateCardDetails rate)
    {
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@RateTypeId", rate.RateTypeId.ToString()));
        paramList.Add(new Parameters("@contractID", rate.ContractID.ToString()));
        paramList.Add(new Parameters("@DistanceFrom", rate.DistanceFrom.ToString()));
        paramList.Add(new Parameters("@DistanceTo", rate.DistanceTo.ToString()));
        paramList.Add(new Parameters("@WeightFrom", rate.WeightFrom.ToString()));
        paramList.Add(new Parameters("@WeightTo", rate.WeightTo.ToString()));
        paramList.Add(new Parameters("@RateValue", rate.RateValue.ToString()));
        paramList.Add(new Parameters("@EntryDate", rate.EntryDate.ToString()));
        paramList.Add(new Parameters("@ExpiryDate", rate.ExpiryDate.ToString()));
        reader = (new Connection()).ExecuteSpIS("ssp_InsertWayBillRate", paramList);
        return reader != null;
    }
    public bool deleteContractCondition(string contractConditionId)
    {
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@ContractConditionId", contractConditionId));
        reader = (new Connection()).ExecuteSpIS("ssp_DeleteContractCondition", paramList);
        return reader != null;
    }
}
