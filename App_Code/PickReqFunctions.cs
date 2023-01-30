using BLProperties;
using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Web;
/// <summary>
/// Summary description for PickReqFunctions
/// </summary>
public class PickReqFunctions
{
    string IPAddress = null;
    public PickReqFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IDataReader GetPrevWayBillNo(int branchID)
    {
        IDataReader Reader = null;
        List<string> currentWaybillList = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        return Reader = (new Connection()).ReadSp("ssp_GetLastWayBill", paramList);
    }
    public IDataReader CurrentWaybillSeries(int branchID)
    {
        //List<string> currentWaybillList = new List<string>();
        //DataTable dtTable = null;
        //if (HttpContext.Current.Application["CurrentWaybillNo"] == null)
        //{
        //    List<Parameters> paramList = new List<Parameters>();
        //    paramList.Add(new Parameters("@branchId", branchID.ToString()));
        //    dtTable = (new Connection()).Fillsp("ssp_GetStationaryBranch", paramList);
        //    HttpContext.Current.Application["CurrentWaybillNo"] = dtTable;
        //}
        //else
        //{
        //    dtTable = HttpContext.Current.Application["CurrentWaybillNo"] as DataTable;
        //}
        //return currentWaybillList.ToArray();

        IDataReader Reader = null;
        List<string> currentWaybillList = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        return Reader = (new Connection()).ReadSp("ssp_GetStationaryBranch", paramList);
        //while (Reader.Read())
        //{
        //    currentWaybillList.Add(new Stationary
        //    {
        //        currentNo = Convert.ToInt32(Reader["currentNo"])
        //    });
        //sum = Convert.ToInt32(reader["currentNo"]) + 1;
        //if (count == 1)
        //    Lbl_CurrentWaybillNo.Text = Lbl_CurrentWaybillNo.Text + sum;

        //else
        //    Lbl_CurrentWaybillNo.Text = Lbl_CurrentWaybillNo.Text + "," + sum;
        //}

    }
    public List<Stationary> getStationary(string branchID)
    {
        Stationary stationary;
        List<Parameters> paramList = new List<Parameters>();
        List<Stationary> NameList = new List<Stationary>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetStationaryBranch", paramList);
        while (Reader.Read())
        {
            stationary = new Stationary();
            stationary.startEndNo = (Reader["startingNo"]) + ("-") + (Reader["endingNo"]);
            stationary.WayBillStationaryId = Convert.ToInt32(Reader["WayBillStationaryId"]);
            stationary.Utilisation = Reader["Utilisation"].ToString(); 
	    stationary.Unused = Reader["Unused"].ToString(); 
            NameList.Add(stationary);
        }
        return NameList;
    }
    public string[] getBranchStaionary(string waybillNo,int branchID)
    {
        List<string> stat = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@wayBillNo", waybillNo.ToString()));
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWayBillStationaryId", paramList);
        while (Reader.Read())
        {
            stat.Add(string.Format("{0}", Reader["Status"]));
        }
        return stat.ToArray();
    }
 public string[] getBranchArea(int branchID)
    {
        List<string> stat = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetBranchAreaByBranchID", paramList);
        while (Reader.Read())
        {
            stat.Add(string.Format("{0}", Reader["locAreaID"]));
        }
        return stat.ToArray();
    }
    public string[] getBranchDeliveryArea(int locID)
    {
        List<string> stat = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@LocId", locID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetBranchAreaByLocID", paramList);
        while (Reader.Read())
        {
            stat.Add(string.Format("{0}", Reader["locAreaID"]));
        }
        return stat.ToArray();
    }
    public string[] GetCurrentWaybillNo(int branchID)
    {
        List<string> stat = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@BranchId", branchID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetCurrentWayBillNo", paramList);
        while (Reader.Read())
        {
            stat.Add(string.Format("{0}", Reader["WaybillNo"]));
        }
        return stat.ToArray();
    }

    public List<Branch> getBranch(string branchID)
    {
        Branch branchName;
        List<Parameters> paramList = new List<Parameters>();
        List<Branch> BranchNameList = new List<Branch>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetUnderControllingBranch", paramList);
        while (Reader.Read())
        {
            branchName = new Branch();
            branchName.branchName = Reader["branchName"].ToString();
            branchName.branchId = Convert.ToInt32(Reader["branchID"]);
            BranchNameList.Add(branchName);
        }
        return BranchNameList;
    }
    public bool SaveStationary(int branchID,int stationaryID)
    {      
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        paramList.Add(new Parameters("@waybillStationaryID", stationaryID.ToString()));      
        reader = (new Connection()).ExecuteSpIS("ssp_AssignStationaryToBranch", paramList);
        return reader != null;
    }

    public bool SaveBay(Bay bay)
    {
        PickReq session = new PickReq();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();   
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@BranchId", bay.branchID.ToString()));
        paramList.Add(new Parameters("@BayName", bay.bayName.ToString()));
        paramList.Add(new Parameters("@MaxQty", bay.maxQty.ToString()));
        paramList.Add(new Parameters("@MaxWt", bay.maxWt.ToString()));
        paramList.Add(new Parameters("@MaxUOM", bay.maxUOM.ToString()));
        paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
        paramList.Add(new Parameters("@creationDate", session.Session.CreationDateTime));       
        reader = (new Connection()).ExecuteSpIS("ssp_CreateBay", paramList);
        return reader != null;
    }
    public List<Bay> getBayName(int branchId)
    {
        Bay BayName;
        List<Parameters> paramList = new List<Parameters>();
        List<Bay> NameList = new List<Bay>();
        paramList.Add(new Parameters("@branchID", branchId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetBayNameList", paramList);
        while (Reader.Read())
        {
            BayName = new Bay();
            BayName.bayName = Reader["BayName"].ToString();
            BayName.ID = Convert.ToInt32(Reader["BayMasterId"]);
            NameList.Add(BayName);
        }
        return NameList;
    }

    public bool SaveBayWaybills(BayWaybills bay)
    {
        PickReq session = new PickReq();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();     
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@BayMasterId", bay.bayMasterID.ToString()));
        paramList.Add(new Parameters("@WayBillItemId", bay.WaybillItemID.ToString()));
        paramList.Add(new Parameters("@Qty", bay.itemQty.ToString()));      
        paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
        paramList.Add(new Parameters("@creationDate", session.Session.CreationDateTime));
        reader = (new Connection()).ExecuteSpIS("ssp_CreateBayWayBill", paramList);
        return reader != null;
    }
    public List<PickReqInvoice> getRateType()
    {
        PickReqInvoice rate;
        List<Parameters> paramList = new List<Parameters>();
        List<PickReqInvoice> RateList = new List<PickReqInvoice>();
        paramList.Add(new Parameters("@type", "WAYBILL"));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetRateType", paramList);
        while (Reader.Read())
        {
            rate = new PickReqInvoice();
            rate.RateType = Reader["RateTypeName"].ToString();
            rate.RateID = Convert.ToInt32(Reader["RateTypeId"]);
            RateList.Add(rate);
        }
        return RateList;

    }

   
    // Get Pickup Request Details in GridView
    //public DataTable ViewData()
    //{
    //    List<Parameters> paramList = new List<Parameters>();
    //    DataTable dt = (new Connection()).Fillsp("spViewPickupRequestDetails", paramList);
    //    return dt;
    //}


    public string[] LoadPickUpHeaderForWayBill(string strPickUpId)
    {
        int count = 0;
        List<string> pickupHeader = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@pickupID", strPickUpId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetPickUp", paramList);
        while (Reader.Read())
        {
            count++;
            pickupHeader.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}ʭ{15}ʭ{16}ʭ{17}ʭ{18}ʭ{19}ʭ{20}ʭ{21}ʭ{22}ʭ{23}ʭ{24}ʭ{25}ʭ{26}ʭ{27}ʭ{28}ʭ{29}ʭ{30}", 
                Reader["pickUpId"], Reader["customerType"], Reader["customerNo"], Reader["customerId"], Reader["customerName"],
                Reader["custContactNo"], Reader["telephoneNo"], Reader["emailID"], Reader["customerLocID"], Reader["CustPINCode"],
                Reader["customerAreaID"], Reader["CustArea"], Reader["customerAddress"], Reader["pickupLocId"], Reader["PickupPINCode"],
                Reader["pickupAreaId"], Reader["PickArea"], Reader["pickupAddress"], Reader["PickUpBranchId"], Reader["PickUpBranchName"],
                Reader["ConsigneeID"], Reader["ConsigneeName"], Reader["consigneeContactNo"], Reader["deliveryLocID"], Reader["deliveryPincode"],
                Reader["deliveryAreaID"], Reader["deliveryArea"], Reader["consigneeAddress"], Reader["DelBranchId"], Reader["DelBranchName"], Reader["pickupType"]));
        }
        return pickupHeader.ToArray(); 
    }
    public PickReq LoadPickUpHeader(string strPickUpId)
    {
        PickReq PR = new PickReq();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@pickupID ", strPickUpId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetPickUp", paramList);
        while (Reader.Read())
        {
            PR.pickupID = Convert.ToInt32(Reader["pickUpId"].ToString());
            PR.CustType= Reader["customerType"].ToString();
            PR.CustCode= Reader["customerNo"].ToString();
            PR.CustID = Convert.ToInt32(Reader["customerId"].ToString());
            PR.CustName = Reader["customerName"].ToString();
            PR.CustContactNo= Reader["custContactNo"].ToString();
            PR.CustTelephone = Reader["telephoneNo"].ToString();
            PR.CustEmailId= Reader["emailID"].ToString();
            PR.CustLocID= Convert.ToInt32(Reader["customerLocID"].ToString());
            PR.CustPINCode= Reader["CustPINCode"].ToString();
            PR.CustAreaID = Convert.ToInt32(Reader["customerAreaID"].ToString());
            PR.CustArea= Reader["CustArea"].ToString();
            PR.CustAddress= Reader["customerAddress"].ToString();
            PR.PickLocID = Convert.ToInt32(Reader["pickupLocId"].ToString());
            PR.PickPINCode = Reader["PickupPINCode"].ToString();
            PR.PickAreaID = Convert.ToInt32(Reader["pickupAreaId"].ToString());
            PR.pickupArea= Reader["PickArea"].ToString();
            PR.PickAddress = Reader["pickupAddress"].ToString();
            PR.pickUpBranchId= Convert.ToInt32(Reader["PickUpBranchId"].ToString());
            PR.PickupBranch = Reader["PickUpBranchName"].ToString();
            PR.ConsigneeID = Convert.ToInt32(Reader["ConsigneeID"].ToString());
            PR.ConsigneeName = Reader["ConsigneeName"].ToString();          
            PR.ConsigneeContactNo = Reader["consigneeContactNo"].ToString();
            PR.DelLocID= Convert.ToInt32(Reader["deliveryLocID"].ToString());
            PR.DelPINCode= Reader["deliveryPincode"].ToString();
            PR.DelAreaID = Convert.ToInt32(Reader["deliveryAreaID"].ToString());
            PR.DelArea = Reader["deliveryArea"].ToString();
            PR.DelAddress = Reader["consigneeAddress"].ToString();
            PR.DeliveryBranch= Reader["DelBranchName"].ToString();
            PR.DelBranchId = Convert.ToInt32(Reader["DelBranchId"].ToString());
        }
        return PR;
    }

    public PickReq LoadWaybillHeader(string waybillID)
    {
        PickReq PR = new PickReq();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", waybillID));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillHeaderData", paramList);
        while (Reader.Read())
        {
            PR.PickType = Reader["pickupType"].ToString();
            PR.CustType = Reader["customerType"].ToString();
            PR.PaymentMode = Reader["paymentMode"].ToString();       
            PR.CustID = Convert.ToInt32(Reader["consigneeID"].ToString());
            PR.CustName = Reader["consigneeName"].ToString();
            PR.CustContactNo = Reader["consigneeContactNo"].ToString();        
            PR.CustLocID = Convert.ToInt32(Reader["consigneeLocationId"].ToString());
            PR.CustPINCode = Reader["DelPincode"].ToString();
            PR.CustAreaID = Convert.ToInt32(Reader["consigneeArea"].ToString());
            PR.CustArea = Reader["DelArea"].ToString();
            PR.CustAddress = Reader["consigneeAddress"].ToString();
            PR.pickUpBranchId = Convert.ToInt32(Reader["DeliveryBranchId"].ToString());
            PR.PickupBranch = Reader["DeliveryBranchName"].ToString();
            PR.ConsigneeID = Convert.ToInt32(Reader["customerID"].ToString());
            PR.ConsigneeName = Reader["CustomerName"].ToString();
            PR.ConsigneeContactNo = Reader["contactNo"].ToString();
            PR.DelLocID = Convert.ToInt32(Reader["pickUpLocationId"].ToString());
            PR.DelPINCode = Reader["PickupPincode"].ToString();
            PR.DelAreaID = Convert.ToInt32(Reader["pickupAreaId"].ToString());
            PR.DelArea = Reader["PickupArea"].ToString();
            PR.DelAddress = Reader["pickupAddress"].ToString();        
            PR.DeliveryBranch = Reader["PickUpBranchName"].ToString();
            PR.DelBranchId = Convert.ToInt32(Reader["pickUPBranchId"].ToString());
            PR.CFTValue = Reader["CFTValue"].ToString();
        }
        return PR;
    }
    public List<PickReqDetail> LoadWaybillMaterialDetails(string waybillID)
    {
        List<PickReqDetail> searchList = new List<PickReqDetail>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", waybillID));       
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillDetailsData", paramList);
        while (Reader.Read())
        {           
            searchList.Add(new PickReqDetail()
            {              
                Id = Convert.ToInt32(Reader["WayBillItemId"]),
                MaterialID = Convert.ToInt32(Reader["materialId"]),
                MaterialType = Reader["materialName"].ToString(),
                PackageID = Convert.ToInt32(Reader["packId"]),
                PackageType = Reader["typeOfPackage"].ToString(),
                Unit = Reader["valueUOM"].ToString(),
                Length = Convert.ToDecimal(Reader["valueL"]),
                Breadth = Convert.ToDecimal(Reader["valueB"]),
                Height = Convert.ToDecimal(Reader["valueH"]),
                CFT = Convert.ToDecimal(Reader["valueCFT"]),
                ChargeWeight = Convert.ToDecimal(Reader["valueChargedWt"]),
                ActualWeight = Convert.ToInt32(Reader["valueActualWt"]),
                NoOfPackage = Convert.ToInt32(Reader["itemQty"]),
                NoOfInnerPackage = Convert.ToInt32(Reader["innerqQty"]),
                InvoiceNo = Reader["invoiceNo"].ToString(),
                InvoiceDate = Reader["invoiceDate"].ToString(),
                InvoiceValue = Convert.ToDecimal(Reader["invoiceAmount"]),
                EWaybillNo = Reader["eWayBillNo"].ToString(),
                EWaybillDate = Reader["eWayBillDate"].ToString(),
                EWaybillExpiryDate = Reader["eWayBillExpiryDate"].ToString(),
            });
        }
        return searchList;
    }

    public DataTable LoadMaterialDetails(string waybillID)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", waybillID));
        DataTable dt = (new Connection()).Fillsp("ssp_GetWaybillDetailsData", paramList);
        return dt;
    }
    public List<PickReq> ViewData(PickReq search)
    {
        List<PickReq> searchList = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@fromDate", search.date.FromDate));
        paramList.Add(new Parameters("@toDate", search.date.ToDate));
        paramList.Add(new Parameters("@branchID", search.Id.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("spViewPickupRequestDetails", paramList);
        while (Reader.Read())
        {
            searchList.Add(new PickReq()
            {
                pickupID = Convert.ToInt32(Reader["pickupID"]),
                PickType = Reader["pickupType"].ToString(),
                PickDate = Reader["pickUPDate"].ToString(),
                CustCode = Reader["customerNo"].ToString(),
                CustName = Reader["CustomerName"].ToString(),
                PickPINCode = Reader["PickUpPinCode"].ToString(),
                pickupArea = Reader["PickUpArea"].ToString(),
                DelPINCode = Reader["DeliveryPincode"].ToString(),
                DelArea = Reader["DeliveryArea"].ToString(),
                PickupBranch = Reader["branchName"].ToString(),
                Status = Reader["pickupStatus"].ToString(),
                Remark = Reader["remark"].ToString(),
                employeeNo = Reader["employeeNo"].ToString(),
                creationDateTime = Reader["creationDateTime"].ToString(),
            });
        }
        return searchList;
    }
    public List<PickReq> GetPickUPList(string fromDate, string toDate, string status, string consignorCode)
    {
        List<PickReq> pickReqList = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        if (fromDate != "") paramList.Add(new Parameters("@fromPickupDate", fromDate));
        if (toDate != "") paramList.Add(new Parameters("@toPickupDate", toDate));
        if (status != "") paramList.Add(new Parameters("@status", status));
        if (consignorCode != "") paramList.Add(new Parameters("@consignorCode", consignorCode));
        //paramList.Add(new Parameters("@consigneeCode", consigneeCode)); 
        IDataReader pickListReader = (new Connection()).ReadSp("ssp_GetPickUPRequestList", paramList);

        PickReq aPickReq;
        while (pickListReader.Read())
        {
            aPickReq = new PickReq();

            aPickReq.PickDate = pickListReader["pickUPDate"].ToString();
            aPickReq.CustName = pickListReader["customerName"].ToString();
            aPickReq.PickPINCode = pickListReader["CustomerPINCode"].ToString();
            aPickReq.pickupArea = pickListReader["areaName"].ToString();
            aPickReq.DelPINCode = pickListReader["locPINCode"].ToString();
            aPickReq.DelArea = pickListReader["DeliveryArea"].ToString();
            aPickReq.Status = pickListReader["PickUPStatus"].ToString();
            aPickReq.creationDateTime = pickListReader["creationDateTime"].ToString();
            aPickReq.PickType = pickListReader["PickUpType"].ToString();
            aPickReq.PickupBranch = pickListReader["BranchName"].ToString();

            pickReqList.Add(aPickReq);
        }
        return pickReqList;
    }

    // For Searching Data in GridView
    //public DataTable SearchData(PickReq search)
    //{
    //    List<Parameters> paramList = new List<Parameters>();

    //    paramList.Add(new Parameters("@fromPickupDate", search.date.FromDate));
    //    paramList.Add(new Parameters("@toPickupDate", search.date.ToDate));
    //    paramList.Add(new Parameters("@status", search.Status));
    //    //paramList.Add(new Parameters("@customerNo", search.CustCode));
    //    //paramList.Add(new Parameters("@customerName", search.CustName));
    //    DataTable dt = (new Connection()).Fillsp("spSearchDataPickupRequest", paramList);
    //    return dt;
    //}
    public List<PickReq> ViewPickupData(PickReq search)
    {
        List<PickReq> searchList = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@fromDate", search.date.FromDate));
        paramList.Add(new Parameters("@toDate", search.date.ToDate));
        paramList.Add(new Parameters("@status", search.Status));
        paramList.Add(new Parameters("@branchID", search.Id.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_ViewPickUPRequestList", paramList);
        while (Reader.Read())
        {
            searchList.Add(new PickReq()
            {
                pickupID = Convert.ToInt32(Reader["pickupRequestID"]),
                PickupNo = Reader["pickupNo"].ToString(),
                PickType = Reader["pickupType"].ToString(),
                PickDate = Reader["pickUPDate"].ToString(),
                CustCode = Reader["customerNo"].ToString(),
                CustName = Reader["CustomerName"].ToString(),
                CustContactNo = Reader["contactNo"].ToString(),
                CustTelephone = Reader["telephoneNo"].ToString(),
                PickPINCode = Reader["PickUpPinCode"].ToString(),
                pickupArea = Reader["PickUpArea"].ToString(),
                PickAddress = Reader["pickupAddress"].ToString(),
                PickupBranch = Reader["PickupBranch"].ToString(),
                DelPINCode = Reader["DeliveryPincode"].ToString(),
                DelArea = Reader["DeliveryArea"].ToString(),
                DeliveryBranch = Reader["DeliveryBranch"].ToString(),
                ExpectedWeightOfMaterial = Reader["expectedWeightOfMaterial"].ToString(),
                Status = Reader["pickupStatus"].ToString(),
                Remark = Reader["remark"].ToString(),
                UserName = Reader["fullName"].ToString(),
                UserBranch = Reader["userBranch"].ToString(),
                creationDateTime = Reader["creationDateTime"].ToString(),
            });
        }
        return searchList;
    }

    public List<PickReq> ViewPickupWaybillData(PickReq search)
    {
        List<PickReq> searchList = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@BranchId", search.Id.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_ViewPickupWaybillData", paramList);
        while (Reader.Read())
        {
            searchList.Add(new PickReq()
            {
                WaybillId = Convert.ToInt32(Reader["waybillID"]),
                WaybillNo = Convert.ToInt32(Reader["wayBillNo"]),
                PickDate = Reader["WaybillDate"].ToString(),
                CustName = Reader["customerName"].ToString(),
                ConsigneeName = Reader["consigneeName"].ToString()
            });
        }
        return searchList;
    }

    // Get Summary
    public PickSummary getSummary(int id)
    {
        PickSummary summaryDetail = new PickSummary();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", id.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_SummaryOfPickupRequestDetail", paramList);
        while (Reader.Read())
        {
            summaryDetail.TotalPackage = Convert.ToInt64(Reader["totalPackage"]);
            summaryDetail.TotalWeight = Convert.ToDouble(Reader["totalWeight"]);
        }
        return summaryDetail;
    }

    // Get Summary
    public PickSummary getWaybillSummary(int BranchId)
    {
        return null; 
        PickSummary summaryDetail = new PickSummary();
        /*List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", BranchId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_SummaryOfWaybillDetail", paramList);
        while (Reader.Read())
        {
            summaryDetail.TotalPackage = Convert.ToInt64(Reader["totalPackage"]);
            summaryDetail.TotalWeight = Convert.ToDouble(Reader["totalWeight"]);
        }*/
        return summaryDetail;
    }

    // Get Free Waybill Summary
    public PickSummary getFreeWaybillSummary(int BranchId)
    {
        PickSummary summaryDetail = new PickSummary();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", BranchId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_SummaryOfFreeWaybillDetail", paramList);
        while (Reader.Read())
        {
            summaryDetail.TotalPackage = Convert.ToInt64(Reader["totalPackage"]);
            summaryDetail.TotalWeight = Convert.ToDouble(Reader["totalWeight"]);
        }
        return summaryDetail;
    }

    // Get Branch Name From Pincode

    //public PickReq getBranchName(int pincode)
    //{
    //    PickReq pr = new PickReq();
    //    List<Parameters> paramList = new List<Parameters>();
    //    paramList.Add(new Parameters("@Event", "PickupBranch"));
    //    paramList.Add(new Parameters("@Name", pincode.ToString()));
    //    paramList.Add(new Parameters("@SearchableData", ""));
    //    IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
    //    while (Reader.Read())
    //    {
    //        pr.PickupBranch = Reader["branchName"].ToString();
    //        pr.Id = Convert.ToInt32(Reader["branchID"]);
    //    }
    //    return pr;
    //}

    public string[] getBranchNameForWaybills(string searchPrefixText, string data)
    {
        int count = 0;
        List<string> name = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["BranchNameWaybill"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            dtTable = (new Connection()).Fillsp("ssp_getBranchNameLocId", paramList);
            HttpContext.Current.Application["BranchNameWaybill"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["BranchNameWaybill"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "branchName like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    name.Add(string.Format("{0}ʭ{1}", dr["branchName"].ToString(), dr["locId"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    name.Add(string.Format("{0}ʭ{1}", dr["branchName"].ToString(), dr["locId"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) name.Add(string.Format("{0}ʭ{1}", "", ""));
        return name.ToArray();
      
    }
    public string[] getPickupBranch(string pincode)
    {
        List<string> pin = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@LocId", pincode));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetBranchForLocation", paramList);
        while (Reader.Read())
        {
            pin.Add(string.Format("{0}ʭ{1}", Reader["branchName"], Reader["branchID"]));
        }
        return pin.ToArray();
    }
    public string[] GetPreviousWayBillNo(int branchID)
    {
        List<string> pin = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetLastWayBill", paramList);
        while (Reader.Read())
        {
            pin.Add(string.Format("{0}ʭ{1}", Reader["wayBillNo"], Reader["waybillID"]));
        }
        return pin.ToArray();
    }


    public string[] getDeliveryBranch(string pincode)
    {
        List<string> pin = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@LocId", pincode));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetBranchForLocation", paramList);
        while (Reader.Read())
        {
            pin.Add(string.Format("{0}ʭ{1}", Reader["branchName"], Reader["branchID"]));
        }
        return pin.ToArray();
    }
    //Get Customer Code
    public string[] getCustomerCode(string searchPrefixText, string data, int branchId)
    {
        int count = 0;
        List<string> custCode = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["CustCode"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchId.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetConsignorCodeList", paramList);
            HttpContext.Current.Application["CustCode"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["CustCode"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "customerNo like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    custCode.Add(string.Format("{0}ʭ{1}", dr["customerNo"].ToString(), dr["customerID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    custCode.Add(string.Format("{0}ʭ{1}", dr["customerNo"].ToString(), dr["customerID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) custCode.Add(string.Format("{0}ʭ{1}", "", ""));
        return custCode.ToArray();
        //int count = 0;
        //List<string> custCode = new List<string>();
        //List<Parameters> paramList = new List<Parameters>();
        //if (data == "GetData")
        //    paramList.Add(new Parameters("@Event", "GetCustomerCode"));
        //else if (data == "ReadData")
        //    paramList.Add(new Parameters("@Event", "ReadCustomerCode"));
        //paramList.Add(new Parameters("@Name", ""));
        //paramList.Add(new Parameters("@SearchableData", searchPrefixText));
        //IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
        //while (Reader.Read())
        //{
        //    count++;
        //    custCode.Add(string.Format("{0}-{1}", Reader["customerNo"], Reader["customerID"]));
        //}
        //if (count == 0)
        //    custCode.Add(string.Format("{0}-{1}", "", ""));

        //return custCode.ToArray();
    }
    //Auto Fill Customer Details
    public string[] getCCustomerDetail(string customerID,int BranchId)
    {
        List<string> custDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@CustomerID", customerID));
        paramList.Add(new Parameters("@branchID", BranchId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetPartyCustomerCreation", paramList);
        while (Reader.Read())
        {
            custDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}", Reader["customerID"], Reader["customerNo"], Reader["customerName"], Reader["customerContactNo"], Reader["EmailId"], Reader["locID"], Reader["locPincode"], Reader["locAreaID"], Reader["areaName"], Reader["billingAddress"], Reader["CFTRate"], Reader["CFTValue"]));
        }
        return custDetail.ToArray();
    }
    //Get Corporate Customer 
    public string[] getCustName(string searchPrefixText, string data, int BranchId)
    {
        int count = 0;
        List<string> custName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["CustName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            //paramList.Add(new Parameters("@branchID", BranchId.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetCustomerList", paramList);
            HttpContext.Current.Application["CustName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["CustName"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "customerName like '%" + searchPrefixText.ToUpper() + "%' AND branchID = " + BranchId.ToString();
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    custName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    custName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["customerID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) custName.Add(string.Format("{0}ʭ{1}", "", ""));
        return custName.ToArray();
    }

    //Get Walkin Customer 
    public string[] getWalkinCustName(string searchPrefixText, string data, int branchID)
    {
        int count = 0;
        List<string> WcustName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["consignorName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            //paramList.Add(new Parameters("@branchID", branchID.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetConsignorNameList", paramList);
            HttpContext.Current.Application["consignorName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["consignorName"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "customerName like '%" + searchPrefixText + "%' AND BranchId = " + branchID.ToString();
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WcustName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["ConsignorId"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WcustName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["ConsignorId"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) WcustName.Add(string.Format("{0}ʭ{1}", "", ""));
        return WcustName.ToArray();
    }
    //Get Searchable Customer Code
    public List<PickReq> getSearchableCustCode()
    {
        List<PickReq> custcode = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Event", "ReadSearchCustomerCode"));
        paramList.Add(new Parameters("@Name", ""));
        paramList.Add(new Parameters("@SearchableData", ""));
        IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
        while (Reader.Read())
        {
            custcode.Add(new PickReq()
            {
                CustCode = Reader["customerNo"].ToString(),
                CustID = Convert.ToInt32(Reader["customerID"]),
            });
        }
        return custcode;
    }
    //Get Searchable Customer Name
    public List<PickReq> getSearchableCustName()
    {
        List<PickReq> custname = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@Event", "ReadSearchCustomerName"));
        paramList.Add(new Parameters("@Name", ""));
        paramList.Add(new Parameters("@SearchableData", ""));
        IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
        while (Reader.Read())
        {
            custname.Add(new PickReq()
            {
                CustName = Reader["customerName"].ToString(),
                CustID = Convert.ToInt32(Reader["customerID"]),
            });
        }
        return custname;
    }
    // Auto Fill Walkin Customer Details
    public string[] getWCustomerDetail(string WcustID)
    {
        List<string> custDetail = new List<string>();

        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ConsignorId", WcustID));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetConsignorDetails", paramList);
        while (Reader.Read())
        {
            custDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}", Reader["contactNo"], Reader["locID"], Reader["locPincode"], Reader["locAreaID"], Reader["areaName"], Reader["pickupAddress"]));
        }
        return custDetail.ToArray();
    }

    // Get Waybill Invoice Detail
    public string[] GetWaybillInvoice(string type)
    {
        List<string> Detail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@type", type));

        IDataReader Reader = (new Connection()).ReadSp("ssp_GetRateType", paramList);
        while (Reader.Read())
        {
            Detail.Add(string.Format("{0}ʭ{1}ʭ{2}", Reader["RateTypeId"], Reader["RateTypeName"], Reader["RateTypeValue"]));
        }
        return Detail.ToArray();
    }
    //Get Consignee 
    public string[] getConsigneeName(string searchPrefixText, string data, int branchId)
    {
        int count = 0;
        List<string> ConsigneeName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["consigneeName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            //paramList.Add(new Parameters("@branchID", branchId.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetConsigneeNameList", paramList);
            HttpContext.Current.Application["consigneeName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["consigneeName"] as DataTable;
            dtTable.Select("BranchId = " + branchId.ToString());
        }
        if (searchPrefixText != "")
        {
            string expression = "customerName like '%" + searchPrefixText + "%' and BranchId = " + branchId.ToString();
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["consigneeId"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["consigneeId"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) ConsigneeName.Add(string.Format("{0}ʭ{1}", "", ""));
        return ConsigneeName.ToArray();
    }
  //Get Reverse Consignee 
      public string[] getReverseConsigneeName(string searchPrefixText, string data, int branchId)
    {
        int count = 0;
        List<string> ConsigneeName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["ReverseConsigneeName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchID", branchId.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetConsigneeNameReverseList", paramList);
            HttpContext.Current.Application["ReverseConsigneeName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["ReverseConsigneeName"] as DataTable;
            dtTable.Select("BranchId = " + branchId.ToString());
        }
        if (searchPrefixText != "")
        {
            string expression = "customerName like '%" + searchPrefixText + "%' and BranchId =  '"+ branchId.ToString() + "' and customerId IS NOT NULL";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["consigneeId"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["consigneeId"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) ConsigneeName.Add(string.Format("{0}ʭ{1}", "", ""));
        return ConsigneeName.ToArray();
    }
    // Auto Fill Consignee Details
    public string[] getConsigneeNameDetail(string Name)
    {
        List<string> consigneeDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ConsigneeId", Name));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetConsigneeDetails", paramList);
        while (Reader.Read())
        {
            consigneeDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}", Reader["contactNo"], Reader["locID"], Reader["locPincode"], Reader["locAreaID"], Reader["areaName"], Reader["deliveryAddress"], Reader["branchName"]));
        }
        return consigneeDetail.ToArray();
    }
 // Auto Fill Reverse Consignee Details
   public string[] getConsigneeNameReverseDetail(string Name)
    {
        List<string> consigneeDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@ConsigneeId", Name));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetConsigneeReverseDetails", paramList);
        while (Reader.Read())
        {
            consigneeDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}", Reader["contactNo"], Reader["locID"], Reader["locPincode"], Reader["locAreaID"], Reader["areaName"], Reader["deliveryAddress"], Reader["branchName"]));
        }
        return consigneeDetail.ToArray();
    }
    //Get Material 
     public string[] getMaterial(string searchPrefixText, string data, string customerId)
    {
        int count = 0;
        List<string> MaterialName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["MaterialName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>(); 
            if(customerId!=null)          
            paramList.Add(new Parameters("@CustomerId", customerId.ToString()));
            //else
            //paramList.Add(new Parameters("@CustomerId", ""));
            dtTable = (new Connection()).Fillsp("ssp_GetMaterialNameList", paramList);
            HttpContext.Current.Application["MaterialName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["MaterialName"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "materialName like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    MaterialName.Add(string.Format("{0}ʭ{1}", dr["materialName"].ToString(), dr["materialID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    MaterialName.Add(string.Format("{0}ʭ{1}", dr["materialName"].ToString(), dr["materialID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) MaterialName.Add(string.Format("{0}ʭ{1}", "", ""));
        return MaterialName.ToArray();
        //int count = 0;
        //List<string> material = new List<string>();
        //List<Parameters> paramList = new List<Parameters>();
        //if (data == "GetData")
        //    paramList.Add(new Parameters("@Event", "GetMaterial"));
        //else if (data == "ReadData")
        //    paramList.Add(new Parameters("@Event", "ReadMaterial"));
        //paramList.Add(new Parameters("@Name", ""));
        //paramList.Add(new Parameters("@SearchableData", searchPrefixText));
        //IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
        //while (Reader.Read())
        //{
        //    count++;
        //    material.Add(string.Format("{0}-{1}", Reader["materialName"], Reader["materialID"]));
        //}
        //if (count == 0)
        //    material.Add(string.Format("{0}-{1}", "", ""));
        //return material.ToArray();
    }
    public string[] getMaterialDetail(string materialId)
    {
        List<string> Detail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@materialId", materialId));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetMaterialDetails", paramList);
        while (Reader.Read())
        {
            Detail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}", Reader["SERIAL"], Reader["L"], Reader["B"], Reader["H"], Reader["UOM"], Reader["CFTValue"]));
        }
        return Detail.ToArray();
    }

    //Get Package 
    public string[] getPackages(string searchPrefixText, string data)
    {
        int count = 0;
        List<string> PackageName = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["PackageName"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            dtTable = (new Connection()).Fillsp("ssp_GetPackageNameList", paramList);
            HttpContext.Current.Application["PackageName"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["PackageName"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "typeOfPackage like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    PackageName.Add(string.Format("{0}ʭ{1}", dr["typeOfPackage"].ToString(), dr["packID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    PackageName.Add(string.Format("{0}ʭ{1}", dr["typeOfPackage"].ToString(), dr["packID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) PackageName.Add(string.Format("{0}ʭ{1}", "", ""));
        return PackageName.ToArray();
        //int count = 0;
        //List<string> packages = new List<string>();
        //List<Parameters> paramList = new List<Parameters>();
        //if (data == "GetData")
        //    paramList.Add(new Parameters("@Event", "GetPackages"));
        //else if (data == "ReadData")
        //    paramList.Add(new Parameters("@Event", "ReadPackages"));
        //paramList.Add(new Parameters("@Name", ""));
        //paramList.Add(new Parameters("@SearchableData", searchPrefixText));
        //IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
        //while (Reader.Read())
        //{
        //    count++;
        //    packages.Add(string.Format("{0}-{1}", Reader["typeOfPackage"], Reader["packID"]));
        //}
        //if (count == 0)
        //    packages.Add(string.Format("{0}-{1}", "", ""));

        //return packages.ToArray();
    }

    // Get Search Customer Code
    public List<PickReq> getCustomerSearchCode(string searchableText)
    {
        PickReq CustomerCode;
        List<Parameters> paramList = new List<Parameters>();
        if (searchableText == "")
            paramList.Add(new Parameters("@Event", "Ddl_SearchCustomerCode"));
        else if (searchableText != "")
            paramList.Add(new Parameters("@Event", "Ddl_Search_SearchCustomerCode"));
        paramList.Add(new Parameters("@Name", ""));
        paramList.Add(new Parameters("@SearchableData", searchableText));
        List<PickReq> CustCodeList = new List<PickReq>();
        IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
        while (Reader.Read())
        {
            CustomerCode = new PickReq();
            CustomerCode.CustCode = Reader["customerNo"].ToString();
            CustCodeList.Add(CustomerCode);
        }
        return CustCodeList;
    }
    ////Get Search Customer Name
    //public List<PickReq> getSearchCustName(string searchableText)
    //{
    //    PickReq CustName;
    //    List<Parameters> paramList = new List<Parameters>();
    //    if (searchableText == "")
    //        paramList.Add(new Parameters("@Event", "Ddl_SearchCustomerName"));
    //    else if (searchableText != "")
    //        paramList.Add(new Parameters("@Event", "Ddl_Search_SearchCustomerName"));
    //    paramList.Add(new Parameters("@Name", ""));
    //    paramList.Add(new Parameters("@SearchableData", searchableText));
    //    List<PickReq> CustNameList = new List<PickReq>();
    //    IDataReader Reader = (new Connection()).ReadSp("spBindDdlPickReq", paramList);
    //    while (Reader.Read())
    //    {
    //        CustName = new PickReq();
    //        CustName.CustName = Reader["customerName"].ToString();
    //        CustNameList.Add(CustName);
    //    }
    //    return CustNameList;
    //}

    // PopUp Consignor Details

    public int getLocIdFromBranch(int branch)
    {
        int locId = 0;      
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;      
        paramList.Add(new Parameters("@branchId", branch.ToString()));
        reader = (new Connection()).ReadSp("ssp_LocIdFromBrancName", paramList);
        if (reader.Read())
        {
            locId = Convert.ToInt32(reader["locId"]);
        }
        return locId;
    }
      public int SaveConsignorConsignee(ConsingorConsignee Details,string branchID=null)
    {
        int id = 0;
        ConsingorConsignee session = new ConsingorConsignee();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"].ToString());
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"].ToString());
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        if (Details.value == "CONSIGNOR")
            paramList.Add(new Parameters("@Value", "CONSIGNOR"));
        else if (Details.value == "CONSIGNEE")
            paramList.Add(new Parameters("@Value", "CONSIGNEE"));
        paramList.Add(new Parameters("@Name", Details.Name.ToUpper()));
        paramList.Add(new Parameters("@contactNo", Details.ContactNo.ToString()));
        paramList.Add(new Parameters("@locID", Details.LocID.ToString()));
        paramList.Add(new Parameters("@locAreaID", Details.AreaID.ToString()));
        paramList.Add(new Parameters("@Address", Details.Address.ToUpper()));       
        paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
        paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));
        if(Details.Id!=0)
        {
            paramList.Add(new Parameters("@BranchId", branchID.ToString()));
            paramList.Add(new Parameters("@customerId", Details.Id.ToString()));
        }
        else { paramList.Add(new Parameters("@BranchId", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@gstNumber", Details.GSTNo.ToUpper()));
        }
        reader = (new Connection()).ExecuteSpIS("ssp_CreateConsignorOrConsignee", paramList);
        if (reader.Read())
        {
            id = Convert.ToInt32(reader["id"]);
        }
	HttpContext.Current.Application["consignorName"] = null;
	HttpContext.Current.Application["consigneeName"] = null;
        return id;
        //int Insert = (new Connection()).ExecuteSp("spCreateConsignorOrConsignee", paramList);
        //return Insert == 1;
    }
    public string GetIPAddress()
    {
        IPHostEntry Host = default(IPHostEntry);
        string Hostname = null;
        Hostname = System.Environment.MachineName;
        Host = Dns.GetHostEntry(Hostname);
        foreach (IPAddress IP in Host.AddressList)
        {
            if (IP.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
            {
                IPAddress = Convert.ToString(IP);
            }
        }
        return IPAddress;
    }
    public bool SavePickupRequest(PickReq pickReqHeader, List<PickReqDetail> pickReqDetail)
    {
        int PickReqId;
        PickReq session = new PickReq();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;

        #region HeaderParameter
        paramList.Add(new Parameters("@customerType", pickReqHeader.CustType));
        paramList.Add(new Parameters("@pickupType", pickReqHeader.PickType));
        paramList.Add(new Parameters("@pickupDate", pickReqHeader.PickDate));
        paramList.Add(new Parameters("@customerID", pickReqHeader.CustID.ToString()));
        paramList.Add(new Parameters("@walkinCustId", pickReqHeader.walkinCustID.ToString()));
        paramList.Add(new Parameters("@contactNo", pickReqHeader.CustContactNo.ToString()));
        paramList.Add(new Parameters("@telephoneNo", pickReqHeader.CustTelephone));
        paramList.Add(new Parameters("@emailID", pickReqHeader.CustEmailId));
        paramList.Add(new Parameters("@customerAddress", pickReqHeader.CustAddress.ToUpper()));
        paramList.Add(new Parameters("@customerLocID", pickReqHeader.CustLocID.ToString()));
        paramList.Add(new Parameters("@customerAreaID", pickReqHeader.CustAreaID.ToString()));
        paramList.Add(new Parameters("@pickupAddress", pickReqHeader.PickAddress.ToUpper()));
        paramList.Add(new Parameters("@pickupLocID", pickReqHeader.PickLocID.ToString()));
        paramList.Add(new Parameters("@pickupAreaID", pickReqHeader.PickAreaID.ToString()));
        paramList.Add(new Parameters("@consigneeID", pickReqHeader.ConsigneeID.ToString()));
        paramList.Add(new Parameters("@consigneeContactNo", pickReqHeader.ConsigneeContactNo.ToString()));
        paramList.Add(new Parameters("@consigneeAddress", pickReqHeader.DelAddress.ToUpper()));
        paramList.Add(new Parameters("@deliveryLocID", pickReqHeader.DelLocID.ToString()));
        paramList.Add(new Parameters("@deliveryAreaID", pickReqHeader.DelAreaID.ToString()));
        paramList.Add(new Parameters("@pickupBranchID", pickReqHeader.PickupBranch));
        paramList.Add(new Parameters("@expectedWeightOfMaterial", pickReqHeader.ExpectedWeightOfMaterial.ToString()));
        paramList.Add(new Parameters("@pickupRequestBy", "CRM/BRANCH"));
        paramList.Add(new Parameters("@IP_Address", ""));
        paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
        paramList.Add(new Parameters("@BranchId", session.Session.BranchID.ToString()));
        paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));
        #endregion

        //(new Connection()).ExecuteSp("spCreateOrUpdatePickupRequest", paramList);
        reader = (new Connection()).ExecuteSpIS("ssp_CreatePickupRequest", paramList);
        if (reader.Read())
        {
            PickReqId = Convert.ToInt32(reader["id"]);
            foreach (PickReqDetail detail in pickReqDetail)
            {
                #region DetailParameters

                paramList = new List<Parameters>();
                paramList.Add(new Parameters("@pickupRequestId", PickReqId+""));
                paramList.Add(new Parameters("@materialID", detail.MaterialType+""));
                paramList.Add(new Parameters("@packID", detail.PackageType + ""));
                paramList.Add(new Parameters("@unit", detail.Unit.ToString()));
                paramList.Add(new Parameters("@length", detail.Length + ""));
                paramList.Add(new Parameters("@breadth", detail.Breadth + ""));
                paramList.Add(new Parameters("@height", detail.Height + ""));
                paramList.Add(new Parameters("@CFT", detail.CFT.ToString()));
                paramList.Add(new Parameters("@actualWeight", detail.ActualWeight + ""));
                paramList.Add(new Parameters("@noOfPackage", detail.NoOfPackage + ""));
                paramList.Add(new Parameters("@kgPerItem", detail.KgperItem + ""));
                paramList.Add(new Parameters("@chargeWeight", detail.ChargeWeight + ""));

                #endregion

                (new Connection()).ExecuteSp("ssp_CreatePickupRequestMaterialDetails", paramList);
            }
        }
        return reader != null;
    }
    public int UpdateConsigneeDetails(PickReq pickReqHeader)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@consigneeId", pickReqHeader.ConsigneeID.ToString()));
        paramList.Add(new Parameters("@contactNo", pickReqHeader.ConsigneeContactNo.ToString()));
        paramList.Add(new Parameters("@locId", pickReqHeader.DelLocID.ToString()));
        paramList.Add(new Parameters("@locAreaId", pickReqHeader.DelAreaID.ToString()));
        paramList.Add(new Parameters("@deliveryAddress", pickReqHeader.DelAddress.ToUpper()));
              
        return (new Connection()).ExecuteSp("ssp_UpdateCosigneeDetails", paramList);
    }
    public int SavePickupRequestWareHouse(PickReq pickReqHeader, List<PickReqDetail> pickReqDetail, List<PickReqInvoice> pickReqInvoice = null)
    {
        PickReq session = new PickReq();
        session.IPAddress = GetIPAddress();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["branchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;

        #region HeaderParameter           
            paramList.Add(new Parameters("@wayBillNo", pickReqHeader.WaybillNo.ToString()));
            paramList.Add(new Parameters("@waybillDate", pickReqHeader.WaybillDate.ToString()));
            paramList.Add(new Parameters("@walkinCustId", pickReqHeader.walkinCustID.ToString()));
            paramList.Add(new Parameters("@customerID", pickReqHeader.CustID.ToString()));
            paramList.Add(new Parameters("@customerType", pickReqHeader.CustType));
            paramList.Add(new Parameters("@contactNo", pickReqHeader.CustContactNo.ToString()));
            paramList.Add(new Parameters("@telephoneNo", pickReqHeader.CustTelephone));
            paramList.Add(new Parameters("@emailID", pickReqHeader.CustEmailId));
            paramList.Add(new Parameters("@customerAddress", pickReqHeader.CustAddress.ToUpper()));
            paramList.Add(new Parameters("@customerLocID", pickReqHeader.CustLocID.ToString()));
            paramList.Add(new Parameters("@customerAreaID", pickReqHeader.CustAreaID.ToString()));
            paramList.Add(new Parameters("@paymentMode", pickReqHeader.PaymentMode.ToUpper()));
            paramList.Add(new Parameters("@pickUPLocId", pickReqHeader.PickLocID.ToString()));
            paramList.Add(new Parameters("@pickupAreaId", pickReqHeader.PickAreaID.ToString()));
            paramList.Add(new Parameters("@pickupType", pickReqHeader.PickType.ToUpper()));
            paramList.Add(new Parameters("@pickupAddress", pickReqHeader.PickAddress.ToUpper()));
            paramList.Add(new Parameters("@consigneeID", pickReqHeader.ConsigneeID.ToString()));
            paramList.Add(new Parameters("@consigneeContactNo", pickReqHeader.ConsigneeContactNo.ToString()));
            paramList.Add(new Parameters("@deliveryLocID", pickReqHeader.DelLocID.ToString()));
            paramList.Add(new Parameters("@deliveryAreaID", pickReqHeader.DelAreaID.ToString()));
            paramList.Add(new Parameters("@consigneeAddress", pickReqHeader.DelAddress.ToUpper()));
            paramList.Add(new Parameters("@pickupBranchID", pickReqHeader.PickupBranch));
            paramList.Add(new Parameters("@IP_Address", session.IPAddress));
            paramList.Add(new Parameters("@distance", "0"));
            paramList.Add(new Parameters("@mapDistance", "0"));
            paramList.Add(new Parameters("@TotalPrice", "0"));
            paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@createdDateTime", session.Session.CreationDateTime));
            if (pickReqHeader.ReverseWaybillNo != null)
            {
                paramList.Add(new Parameters("@RevWayBill", pickReqHeader.ReverseWaybillNo.ToString()));
            }
            reader = (new Connection()).ExecuteSpIS("ssp_CreateWareHouseWayBill", paramList);            
        #endregion

        if (reader.Read())
        {
            CFunctions.setID(Convert.ToInt32(reader["WayBillId"]));
            if (CFunctions.ID != -1)
            { 
                foreach (PickReqDetail detail in pickReqDetail)
                {
                    #region DetailParameters
                    paramList = new List<Parameters>();
                    paramList.Add(new Parameters("@WayBillId", CFunctions.ID.ToString()));
                    paramList.Add(new Parameters("@materialID", detail.MaterialID.ToString()));
                    paramList.Add(new Parameters("@packID", detail.PackageID.ToString()));
                    paramList.Add(new Parameters("@valueL", detail.Length.ToString()));
                    paramList.Add(new Parameters("@valueB", detail.Breadth.ToString()));
                    paramList.Add(new Parameters("@valueC", detail.Height.ToString()));
                    paramList.Add(new Parameters("@valueCFT", detail.CFT.ToString()));
                    paramList.Add(new Parameters("@valueActualWt", detail.ActualWeight.ToString()));
                    paramList.Add(new Parameters("@itemQty", detail.NoOfPackage.ToString()));
                    paramList.Add(new Parameters("@innerqQty", detail.NoOfInnerPackage.ToString()));
                    paramList.Add(new Parameters("@invoiceNo", detail.InvoiceNo.ToString().ToUpper()));
                    paramList.Add(new Parameters("@invoiceDate", detail.InvoiceDate.ToString()));
                    paramList.Add(new Parameters("@invoiceAmount", detail.InvoiceValue.ToString()));
                    paramList.Add(new Parameters("@eWaybillNo", detail.EWaybillNo.ToString().ToUpper()));
                    paramList.Add(new Parameters("@eWaybillDate", detail.EWaybillDate));
                    paramList.Add(new Parameters("@ewayBillExpiryDate", detail.EWaybillExpiryDate));
                    paramList.Add(new Parameters("@valueChargedWt", detail.ChargeWeight.ToString()));
                    paramList.Add(new Parameters("@createdDateTime", session.Session.CreationDateTime));
                    paramList.Add(new Parameters("@branchID", session.Session.BranchID.ToString()));
                    paramList.Add(new Parameters("@vehicleRequestID", DBNull.Value.ToString()));
                    paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
                    paramList.Add(new Parameters("@valueUOM", detail.Unit));
                    #endregion

                    (new Connection()).ExecuteSp("ssp_CreateWaybillItems", paramList);
                }
                if (pickReqHeader.PaymentMode != "FREE")
                {
                    if (pickReqInvoice != null)
                    {
                        foreach (PickReqInvoice invoicedetail in pickReqInvoice)
                        {
                            #region DetailParameters
                            if (invoicedetail.Value != "")
                            {
                                paramList = new List<Parameters>();
                                paramList.Add(new Parameters("@WayBillId", CFunctions.ID.ToString()));
                                paramList.Add(new Parameters("@RateTypeId", invoicedetail.RateID.ToString()));
                                paramList.Add(new Parameters("@Value", invoicedetail.Value.ToString()));
                                (new Connection()).ExecuteSp("ssp_CreateWaybillInvoice", paramList);
                            }
                            #endregion
                        }
                    }
                }                    
            }
        }
        return CFunctions.ID;
    }

   public int SaveFreeBranchToBranchWaybill(PickReq pickReqHeader, List<PickReqDetail> pickReqDetail)
    {
        PickReq session = new PickReq();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["branchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;

        #region HeaderParameter    
       
            paramList.Add(new Parameters("@wayBillNo", pickReqHeader.WaybillNo.ToString()));
            paramList.Add(new Parameters("@waybillDate", pickReqHeader.WaybillDate.ToString()));
            paramList.Add(new Parameters("@paymentMode", pickReqHeader.PaymentMode.ToUpper()));
            paramList.Add(new Parameters("@pickupType", pickReqHeader.PickType.ToUpper()));
            paramList.Add(new Parameters("@pickUPLocId", pickReqHeader.PickLocID.ToString()));
            paramList.Add(new Parameters("@pickupAreaId", pickReqHeader.PickAreaID.ToString()));
            paramList.Add(new Parameters("@deliveryLocID", pickReqHeader.DelLocID.ToString()));
            paramList.Add(new Parameters("@deliveryAreaId", pickReqHeader.DelAreaID.ToString()));
            paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
            paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
            paramList.Add(new Parameters("@createdDateTime", session.Session.CreationDateTime));
         
            reader = (new Connection()).ExecuteSpIS("ssp_CreateFreeWayBill", paramList);

        #endregion

        if (reader.Read())
        {
            CFunctions.setID(Convert.ToInt32(reader["WayBillId"]));
            if (CFunctions.ID != -1)
            {              
                paramList = new List<Parameters>();
                paramList.Add(new Parameters("@WayBillId", CFunctions.ID.ToString()));
                paramList.Add(new Parameters("@WayBillRemark", pickReqHeader.Remark.ToString()));
                paramList.Add(new Parameters("@BranchId", session.Session.BranchID.ToString()));
                (new Connection()).ExecuteSp("ssp_CreateWayBillRemark", paramList);
                
                foreach (PickReqDetail detail in pickReqDetail)
                {
                    #region DetailParameters
                    paramList = new List<Parameters>();
                    paramList.Add(new Parameters("@WayBillId", CFunctions.ID.ToString()));
                    paramList.Add(new Parameters("@materialID", detail.MaterialID.ToString()));
                    paramList.Add(new Parameters("@packID", detail.PackageID.ToString()));
                    paramList.Add(new Parameters("@valueL", detail.Length.ToString()));
                    paramList.Add(new Parameters("@valueB", detail.Breadth.ToString()));
                    paramList.Add(new Parameters("@valueC", detail.Height.ToString()));
                    paramList.Add(new Parameters("@valueCFT", detail.CFT.ToString()));
                    paramList.Add(new Parameters("@valueActualWt", detail.ActualWeight.ToString()));
                    paramList.Add(new Parameters("@itemQty", detail.NoOfPackage.ToString()));
                    paramList.Add(new Parameters("@innerqQty", detail.NoOfInnerPackage.ToString()));
                    paramList.Add(new Parameters("@invoiceNo", detail.InvoiceNo.ToString().ToUpper()));
                    paramList.Add(new Parameters("@invoiceDate", detail.InvoiceDate.ToString()));
                    paramList.Add(new Parameters("@invoiceAmount", detail.InvoiceValue.ToString()));
                    paramList.Add(new Parameters("@eWaybillNo", detail.EWaybillNo.ToString().ToUpper()));
                    paramList.Add(new Parameters("@eWaybillDate", detail.EWaybillDate));
                    paramList.Add(new Parameters("@ewayBillExpiryDate", detail.EWaybillExpiryDate));
                    paramList.Add(new Parameters("@valueChargedWt", detail.ChargeWeight.ToString()));
                    paramList.Add(new Parameters("@createdDateTime", session.Session.CreationDateTime));
                    paramList.Add(new Parameters("@branchID", session.Session.BranchID.ToString()));
                    paramList.Add(new Parameters("@vehicleRequestID", DBNull.Value.ToString()));
                    paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
                    paramList.Add(new Parameters("@valueUOM", detail.Unit));
                    #endregion
                    (new Connection()).ExecuteSp("ssp_CreateWaybillItems", paramList);
                }              
            }
        }
        return CFunctions.ID;
    }
    public int GetConsignorID(string consignorName, string consignorPinId, string consignorAreaId, int branchID)
    {
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        int Id = 0;
        paramList.Add(new Parameters("@consignorName", consignorName.ToString()));
        paramList.Add(new Parameters("@consignorPinId", consignorPinId.ToString()));
        paramList.Add(new Parameters("@consignorAreaId", consignorAreaId.ToString()));
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        reader = (new Connection()).ExecuteSpIS("ssp_GetConsignorReverse", paramList);
        if (reader.Read())
        {
            Id = Convert.ToInt32(reader["ConsignorId"]);            
        }      
        return Id;
    }
    public int GetConsigneeID(string customerId,int branchID)
    {       
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        int Id=0;
        paramList.Add(new Parameters("@customerId", customerId.ToString()));
        paramList.Add(new Parameters("@branchID", branchID.ToString()));       
        reader = (new Connection()).ExecuteSpIS("ssp_GetConsigneeIdReverse", paramList);
        if (reader.Read())
        {
            Id = Convert.ToInt32(reader["ConsigneeId"]);        
        }
        return Id;
    }

    public List<PickReq> SearchWaybillData(PickReq search)
    {
        List<PickReq> searchList = new List<PickReq>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@FromDate", search.date.FromDate));
        paramList.Add(new Parameters("@ToDate", search.date.ToDate));
        paramList.Add(new Parameters("@BranchId", search.Id.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_ViewWaybillData", paramList);
        while (Reader.Read())
        {
            searchList.Add(new PickReq()
            {
                WaybillId = Convert.ToInt32(Reader["waybillID"]),
                WaybillNo = Convert.ToInt32(Reader["wayBillNo"]),
                PickType= Reader["pickupType"].ToString(),
                PickDate = Reader["WaybillDate"].ToString(),
                CustName = Reader["customerName"].ToString(),
                ConsigneeName = Reader["consigneeName"].ToString()
            });
        }
        return searchList;
    }

    public IDataReader SearchFreeWaybillData(PickReq search)
    {
        IDataReader Reader = null;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@FromDate", search.date.FromDate));
        paramList.Add(new Parameters("@ToDate", search.date.ToDate));
        paramList.Add(new Parameters("@BranchId", search.Id.ToString()));
        return Reader = (new Connection()).ReadSp("ssp_ViewFreeWaybillData", paramList);
    }
    #region /*-----------------------------Load Waybill Data---------------------------------------*/
    //Load Route Header Data
    public string[] LoadWaybillHeaderData(int WaybillID)
    {
        List<string> WaybillHeaderDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", WaybillID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillHeaderData", paramList);
        while (Reader.Read())
        {
            WaybillHeaderDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}ʭ{15}ʭ{16}ʭ{17}ʭ{18}ʭ{19}ʭ{20}ʭ{21}ʭ{22}",
                Reader["waybillNo"], Reader["customerType"], Reader["paymentMode"], Reader["customerNo"], Reader["customerName"], Reader["contactNo"], Reader["telephoneNo"],
                Reader["EmailId"], Reader["CustPincode"], Reader["CustArea"], Reader["CustAddress"], Reader["PickupPincode"], Reader["PickupArea"], Reader["pickupAddress"],
                Reader["consigneeName"], Reader["consigneeContactNo"], Reader["DelPincode"], Reader["DelArea"], Reader["consigneeAddress"], Reader["pickUpBranchName"],
                Reader["DeliveryBranchName"], Reader["pickupType"], Reader["waybillDate"]));
        }
        return WaybillHeaderDetail.ToArray();
    }
    //Load Route Details Data
    public string[] LoadWaybillDetailsData(int WaybillID)
    {
        List<string> WaybillDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", WaybillID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillDetailsData", paramList);
        while (Reader.Read())
        {
            WaybillDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}ʭ{15}",
                Reader["materialName"], Reader["typeOfPackage"], Reader["valueUOM"], Reader["valueL"], Reader["valueB"], Reader["valueH"], Reader["valueCFT"],
                Reader["valueActualWt"], Reader["itemQty"], Reader["innerqQty"], Reader["invoiceNo"], Reader["invoiceDate"], Reader["invoiceAmount"],
                Reader["eWayBillNo"], Reader["eWayBillDate"], Reader["eWayBillExpiryDate"]));
        }
        return WaybillDetail.ToArray();
    }
     public string[] LoadWaybillDetailsDataForEdit(string WaybillNo)
    {
        List<string> WaybillDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillNo", WaybillNo.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillDetailsDataForEdit", paramList);
        while (Reader.Read())
        {
            WaybillDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}ʭ{15}ʭ{16}",
                Reader["materialName"], Reader["typeOfPackage"], Reader["valueUOM"], Reader["valueL"], Reader["valueB"], Reader["valueH"], Reader["valueCFT"],
                Reader["valueActualWt"], Reader["valueChargedWt"], Reader["itemQty"], Reader["innerqQty"], Reader["invoiceNo"], Reader["invoiceDate"], Reader["invoiceAmount"],
                Reader["eWayBillNo"], Reader["eWayBillDate"], Reader["eWayBillExpiryDate"]));
        }
        return WaybillDetail.ToArray();
    }
    // Invoice Details
    public string[] LoadWaybillInvoiceDetailsData(int WaybillID)
    {
        List<string> WaybillDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", WaybillID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillInvoiceDetailsData", paramList);
        while (Reader.Read())
        {
            WaybillDetail.Add(string.Format("{0}ʭ{1}",
                Reader["RateTypeName"], Reader["Value"]));
        }
        return WaybillDetail.ToArray();
    }

    //Load DEPS Waybill Details Data
    public string[] DEPSWaybillDetailsData(int WaybillID)
    {
        List<string> WaybillDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillID", WaybillID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetLatestItemQtyWaybillDetailsData", paramList);
        while (Reader.Read())
        {
            WaybillDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}",
                Reader["materialName"], Reader["typeOfPackage"], Reader["valueUOM"], Reader["valueL"], Reader["valueB"], Reader["valueH"], Reader["valueCFT"],
                Reader["valueActualWt"], Reader["itemQty"], Reader["invoiceNo"], Reader["invoiceDate"], Reader["invoiceAmount"],
                Reader["eWayBillNo"], Reader["eWayBillDate"], Reader["eWayBillExpiryDate"]));
        }
        return WaybillDetail.ToArray();
    }

    #endregion

    //public bool SavePickupRequest(PickReq pickupDetail)
    //{

    //    List<Parameters> paramList = new List<Parameters>();
    //    IDataReader reader = null;

    //    #region HeaderParameter
    //    paramList.Add(new Parameters("@bool", CFunctions.tabstatus.ToString()));
    //    paramList.Add(new Parameters("@customerNo", pickupDetail.CustCode.ToString()));
    //    paramList.Add(new Parameters("@customerSearchWord", pickupDetail.CustSeachWord.ToString()));
    //    paramList.Add(new Parameters("@customerType", pickupDetail.CustType));
    //    paramList.Add(new Parameters("@pickupType", pickupDetail.PickType));
    //    paramList.Add(new Parameters("@pickupDate", pickupDetail.PickDate));
    //    paramList.Add(new Parameters("@customerName", pickupDetail.CustName));
    //    paramList.Add(new Parameters("@contactNo", pickupDetail.CustContactNo.ToString()));
    //    paramList.Add(new Parameters("@telephoneNo", pickupDetail.CustTelephone));
    //    paramList.Add(new Parameters("@emailID", pickupDetail.CustEmailId));
    //    paramList.Add(new Parameters("@customerAddress", pickupDetail.CustomerAddress.Address));
    //    paramList.Add(new Parameters("@customerPincode", pickupDetail.CustomerAddress.Pincode.ToString()));
    //    paramList.Add(new Parameters("@customerArea", pickupDetail.CustomerAddress.Area));
    //    paramList.Add(new Parameters("@customerCity", pickupDetail.CustomerAddress.City));
    //    paramList.Add(new Parameters("@customerDistrict", pickupDetail.CustomerAddress.District));
    //    paramList.Add(new Parameters("@customerState", pickupDetail.CustomerAddress.State));
    //    paramList.Add(new Parameters("@pickupAddress", pickupDetail.PickUp.Address));
    //    paramList.Add(new Parameters("@pickupPincode", pickupDetail.PickUp.Pincode.ToString()));
    //    paramList.Add(new Parameters("@pickupArea", pickupDetail.PickUp.Area));
    //    paramList.Add(new Parameters("@pickupCity", pickupDetail.PickUp.City));
    //    paramList.Add(new Parameters("@pickupDistrict", pickupDetail.PickUp.District));
    //    paramList.Add(new Parameters("@pickupState", pickupDetail.PickUp.State));
    //    paramList.Add(new Parameters("@consigneeName", pickupDetail.ConsigneeName));
    //    paramList.Add(new Parameters("@consigneeAddress", pickupDetail.Consignee.Address));
    //    paramList.Add(new Parameters("@deliveryPincode", pickupDetail.Consignee.Pincode.ToString()));
    //    paramList.Add(new Parameters("@deliveryArea", pickupDetail.Consignee.Area));
    //    paramList.Add(new Parameters("@deliveryCity", pickupDetail.Consignee.City));
    //    paramList.Add(new Parameters("@deliveryDistrict", pickupDetail.Consignee.District));
    //    paramList.Add(new Parameters("@deliveryState", pickupDetail.Consignee.State));
    //    paramList.Add(new Parameters("@pickupBranchID", pickupDetail.Id.ToString()));
    //    paramList.Add(new Parameters("@pickupRequestBy", "CRM/BRANCH"));
    //    paramList.Add(new Parameters("@IP_Address", pickupDetail.IPAddress));
    //    paramList.Add(new Parameters("@employeeNo", pickupDetail.Session.EmpoloyeeNo));
    //    paramList.Add(new Parameters("@userBranch", pickupDetail.Session.UserBranch));
    //    paramList.Add(new Parameters("@creationDateTime", pickupDetail.Session.CreationDateTime));
    //    #endregion

    //    //(new Connection()).ExecuteSp("spCreateOrUpdatePickupRequest", paramList);
    //    reader = (new Connection()).ExecuteSpIS("spCreateOrUpdatePickupRequest", paramList);

    //    if (reader.Read())
    //    {
    //        PickId = Convert.ToInt32(reader["id"]);
    //        foreach (PickReqDetail detail in pickupDetail.PicReqListDetails)
    //        {
    //            #region DetailParameters
    //            paramList = new List<Parameters>();
    //            paramList.Add(new Parameters("@pickupID", PickId.ToString()));
    //            paramList.Add(new Parameters("@materialID", detail.MaterialType.ToString()));
    //            paramList.Add(new Parameters("@packID", detail.PackageType.ToString()));
    //            paramList.Add(new Parameters("@unit", detail.Unit.ToString()));
    //            paramList.Add(new Parameters("@length", detail.Length.ToString()));
    //            paramList.Add(new Parameters("@breadth", detail.Breadth.ToString()));
    //            paramList.Add(new Parameters("@height", detail.Height.ToString()));
    //            paramList.Add(new Parameters("@CFT", detail.CFT.ToString()));
    //            paramList.Add(new Parameters("@actualWeight", detail.ActualWeight.ToString()));
    //            paramList.Add(new Parameters("@noOfPackage", detail.NoOfPackage.ToString()));
    //            paramList.Add(new Parameters("@kgPerItem", detail.KgperItem.ToString()));
    //            paramList.Add(new Parameters("@chargeWeight", detail.ChargeWeight.ToString()));
    //            #endregion

    //            (new Connection()).ExecuteSp("spCreatePickupRequestMaterialDetails", paramList);
    //        }
    //    }

    //    return reader != null;
    //}

    public bool SavePopupModalForStatusCancel(PickReq pickupDetail)
    {
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@pickupID", pickupDetail.Id.ToString()));
        paramList.Add(new Parameters("@status", pickupDetail.Status.ToString()));
        paramList.Add(new Parameters("@remark", pickupDetail.Remark.ToString()));
        reader = (new Connection()).ExecuteSpIS("ssp_UpdatePickupRequestStatus", paramList);
        return reader != null;
    }


     public bool SaveDeps(WaybillItemStatus wb, DEPSDetail deps)
    {
        PickReq session = new PickReq();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;

        paramList.Add(new Parameters("@WayBillItemId", wb.WayBillItemId.ToString()));
        paramList.Add(new Parameters("@statusId", wb.statusID.ToString()));
        paramList.Add(new Parameters("@itemQty", deps.itemQty.ToString()));      
        paramList.Add(new Parameters("@creationDateTime", session.Session.CreationDateTime));
        paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
        paramList.Add(new Parameters("@vehicleRequestId", wb.vehicleRequestId.ToString()));
        paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
        paramList.Add(new Parameters("@depsTYPE", deps.depsType.ToString().ToUpper()));
        paramList.Add(new Parameters("@Remark", wb.Remark.ToString().ToUpper()));
        reader = (new Connection()).ExecuteSpIS("ssp_CreateDEPS", paramList);        
        return reader != null;
    }

    public int SaveWaybillCharges(PickReqInvoice detail)
    {     
        List<Parameters> paramList = new List<Parameters>();    
        paramList.Add(new Parameters("@WayBillId", detail.WaybillId.ToString()));
        paramList.Add(new Parameters("@RateTypeId", detail.RateID.ToString()));
        paramList.Add(new Parameters("@Value", detail.Value.ToString()));      
           
        return (new Connection()).ExecuteSp("ssp_CreateWaybillInvoice", paramList);     
    }
    public bool SaveWaybillRemark(int id,string remark,int branchId)
    {
        IDataReader reader = null;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillId", id.ToString()));
        paramList.Add(new Parameters("@WayBillRemark", remark.ToString()));
        paramList.Add(new Parameters("@BranchId", branchId.ToString()));
        reader = (new Connection()).ExecuteSpIS("ssp_CreateWayBillRemark", paramList);
        return reader != null;
    }
    public bool SavePickDelRoute(string routeName, int KMS, int branchId)
    {
        IDataReader reader = null;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@RouteName", routeName.ToString()));
        paramList.Add(new Parameters("@KMS", KMS.ToString()));
        paramList.Add(new Parameters("@BranchId", branchId.ToString()));
        reader = (new Connection()).ExecuteSpIS("ssp_CreateDeliveryRoute", paramList);
        return reader != null;
    }
    public DataTable ViewPickDelRoute(int branchID)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@branchId", branchID.ToString()));
        DataTable dt = (new Connection()).Fillsp("ssp_ViewPickDelRoute", paramList);
        return dt;
    }
  // for Cancelled Waybill
    public bool SaveCancelledWaybill(string WaybillNo, string Remark)
    {
        PickReq session = new PickReq();
        session.Session.CreationDateTime = (new CFunctions()).CurrentDateTime();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["BranchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        IDataReader reader = null;
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WayBillNo", WaybillNo.ToString()));
        paramList.Add(new Parameters("@Remark", Remark.ToString()));
        paramList.Add(new Parameters("@UserId", session.Session.UserID.ToString()));
        paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
        paramList.Add(new Parameters("@CreateionDateTime", session.Session.CreationDateTime.ToString()));
        reader = (new Connection()).ExecuteSpIS("ssp_CreateWayBillStatus", paramList);
        return reader != null;
    }
    //Get WaybillItemID
    public List<PickReqDetail> getWaybillItemID(int waybillID)
    {
        int sno = 0;
        List<PickReqDetail> detail = new List<PickReqDetail>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@waybillID", waybillID.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillItemID", paramList);
        while (Reader.Read())
        {
            detail.Add(new PickReqDetail() { SrNo = sno + 1, Id = Convert.ToInt32(Reader["WayBillItemId"]) });
            sno++;
        }
        return detail;
    }
 //Get WaybillItemID
    public List<PickReqDetail> getWaybillItemIDForEdit(string waybillNo)
    {
        int sno = 0;
        List<PickReqDetail> detail = new List<PickReqDetail>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@waybillNo", waybillNo.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillItemIDForEdit", paramList);
        while (Reader.Read())
        {
            detail.Add(new PickReqDetail() { SrNo = sno + 1, Id = Convert.ToInt32(Reader["WayBillItemId"]) });
            sno++;
        }
        return detail;
    }

   // Fill Material and Package name

    //public PickReqDetail getMaterialPackageName(string id)
    //{
    //    PickReqDetail pr = new PickReqDetail();
    //    List<Parameters> paramList = new List<Parameters>();
    //    paramList.Add(new Parameters("@waybillItemID", id.ToString()));
    //    IDataReader Reader = (new Connection()).ReadSp("ssp_GetMaterialPackageName", paramList);
    //    while (Reader.Read())
    //    {
    //        pr.MaterialType = Reader["materialName"].ToString();
    //        pr.PackageType = Reader["typeOfPackage"].ToString();
    //    }
    //    return pr;
    //}


    public string[] getMaterialPackageName(int id)
    {
        List<string> pr = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@waybillItemID", id.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetMaterialPackageName", paramList);
        while (Reader.Read())
        {
            pr.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}ʭ{15}ʭ{16}ʭ{17}ʭ{18}ʭ{19}ʭ{20}",
               Reader["materialName"], Reader["typeOfPackage"], Reader["vehicleRequestId"], Reader["statusId"],
               Reader["materialId"], Reader["packId"], Reader["valueUOM"], Reader["valueL"],
               Reader["valueB"], Reader["valueH"], Reader["valueCFT"], Reader["itemQty"],
               Reader["valueActualWt"], Reader["valueChargedWt"], Reader["innerqQty"], Reader["invoiceNo"],
               Reader["invoiceDate"], Reader["invoiceAmount"], Reader["eWayBillNo"],
               Reader["eWayBillDate"], Reader["eWayBillExpiryDate"]));
        }
        return pr.ToArray();
    }

    ////Get WaybillItemID
    //public List<PickReqDetail> getWaybillItemID(string waybillID)
    //{
    //        int i = 0;
    //    PickReqDetail detail;
    //    List<Parameters> paramList = new List<Parameters>();
    //    List<PickReqDetail> List = new List<PickReqDetail>();
    //    paramList.Add(new Parameters("@waybillID", waybillID.ToString()));
    //    IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillItemID", paramList);
    //    while (Reader.Read())
    //    {
    //        detail = new PickReqDetail();

    //        detail.SrNo = i+1 ;
    //        detail.Id = Convert.ToInt32(Reader["WayBillItemId"]);
    //        List.Add(detail);
    //    }
    //    return List;
    //}

    //Get Material 
    public string[] getWaybillNo(string searchPrefixText, string data)
    {
        int count = 0;
        List<string> WaybillNo = new List<string>();
        DataTable dtTable = null;
        //if (HttpContext.Current.Application["WayBillNo"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            dtTable = (new Connection()).Fillsp("ssp_GetWaybillNoList", paramList);
            HttpContext.Current.Application["WayBillNo"] = dtTable;
        }
        /*else
        {
            dtTable = HttpContext.Current.Application["WayBillNo"] as DataTable;
        }*/
        if (searchPrefixText != "")
        {
            string expression = "wayBillNo like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WaybillNo.Add(string.Format("{0}ʭ{1}", dr["wayBillNo"].ToString(), dr["waybillID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WaybillNo.Add(string.Format("{0}ʭ{1}", dr["wayBillNo"].ToString(), dr["waybillID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) WaybillNo.Add(string.Format("{0}ʭ{1}", "", ""));
        return WaybillNo.ToArray();     
    }
      public string[] getReverseWaybillNo(string searchPrefixText, string data, int branchId)
    {
        int count = 0;
        List<string> WaybillNo = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["WayBillNo"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", branchId.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetReverseWaybillNoList", paramList);
            HttpContext.Current.Application["WayBillNo"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["WayBillNo"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "waybillNo like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WaybillNo.Add(string.Format("{0}ʭ{1}", dr["waybillNo"].ToString(), dr["waybillID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WaybillNo.Add(string.Format("{0}ʭ{1}", dr["waybillNo"].ToString(), dr["waybillID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) WaybillNo.Add(string.Format("{0}ʭ{1}", "", ""));
        return WaybillNo.ToArray();
    }
    public string[] getDeliveredWaybillNo(string searchPrefixText, string data,int branchId)
    {
        int count = 0;
        List<string> WaybillNo = new List<string>();
        DataTable dtTable = null;
        if (HttpContext.Current.Application["WayBillNo"] == null)
        {
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@branchId", branchId.ToString()));
            dtTable = (new Connection()).Fillsp("ssp_GetDeliveredWaybillNoList", paramList);
            HttpContext.Current.Application["WayBillNo"] = dtTable;
        }
        else
        {
            dtTable = HttpContext.Current.Application["WayBillNo"] as DataTable;
        }
        if (searchPrefixText != "")
        {
            string expression = "wayBillNo like '%" + searchPrefixText + "%'";
            DataRow[] rows = dtTable.Select(expression);

            if (data == "GetData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WaybillNo.Add(string.Format("{0}ʭ{1}", dr["wayBillNo"].ToString(), dr["waybillID"].ToString()));
                }
            }
            else if (data == "ReadData")
            {
                foreach (DataRow dr in rows)
                {
                    count++;
                    WaybillNo.Add(string.Format("{0}ʭ{1}", dr["wayBillNo"].ToString(), dr["waybillID"].ToString()));
                    break;
                }
            }
        }
        if (count == 0) WaybillNo.Add(string.Format("{0}ʭ{1}", "", ""));
        return WaybillNo.ToArray();

    }
    public List<VehicleRequestProperties> getDeliveredVehicleNo(int branchID)
    {
        VehicleRequestProperties vehicle;
        List<Parameters> paramList = new List<Parameters>();
        List<VehicleRequestProperties> NameList = new List<VehicleRequestProperties>();
        paramList.Add(new Parameters("@BranchID", branchID.ToString()));
        paramList.Add(new Parameters("@Status", "4"));
        paramList.Add(new Parameters("@VehicleRequestType", "PD"));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetVehicleList", paramList);
        while (Reader.Read())
        {
            vehicle = new VehicleRequestProperties();
            vehicle.VehicleNo = (Reader["vehicleNo"].ToString());
            vehicle.VehicleRequestID = Convert.ToInt32(Reader["VehicleRequestID"]);
            NameList.Add(vehicle);
        }
        return NameList;
    }
    //Load wAYBILL Header Data
    public string[] LoadWaybillHeaderDataForEdit(string WaybillNo)
    {
        List<string> WaybillHeaderDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillNo", WaybillNo.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillHeaderDataForEdit", paramList);
        while (Reader.Read())
        {
            WaybillHeaderDetail.Add(string.Format("{0}ʭ{1}ʭ{2}ʭ{3}ʭ{4}ʭ{5}ʭ{6}ʭ{7}ʭ{8}ʭ{9}ʭ{10}ʭ{11}ʭ{12}ʭ{13}ʭ{14}ʭ{15}ʭ{16}ʭ{17}ʭ{18}ʭ{19}ʭ{20}ʭ{21}ʭ{22}ʭ{23}ʭ{24}ʭ{25}ʭ{26}ʭ{27}ʭ{28}ʭ{29}",
                Reader["waybillNo"], Reader["customerType"], Reader["paymentMode"], Reader["customerNo"], Reader["customerName"], Reader["contactNo"], Reader["telephoneNo"],
                Reader["EmailId"], Reader["CustPincode"], Reader["CustArea"], Reader["CustAddress"], Reader["PickupPincode"], Reader["PickupArea"], Reader["pickupAddress"],
                Reader["consigneeName"], Reader["consigneeContactNo"], Reader["DelPincode"], Reader["DelArea"], Reader["consigneeAddress"], Reader["pickUpBranchName"],
                Reader["DeliveryBranchName"], Reader["pickupType"], Reader["customerID"], Reader["CustLocId"], Reader["pickUpLocationId"],
                Reader["consigneeID"], Reader["consigneeLocationId"], Reader["pickUPBranchId"], Reader["DeliveryBranchId"], Reader["CFTValue"]));
        }
        return WaybillHeaderDetail.ToArray();
    }
    public string[] GetBranchAndManifest(string WaybillNo, int branchId)
    {
        List<string> WaybillHeaderDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@waybillNo", WaybillNo.ToString()));
        paramList.Add(new Parameters("@branchId", branchId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_CheckWaybillsForManifest", paramList);
        while (Reader.Read())
        {
            WaybillHeaderDetail.Add(string.Format("{0}", Reader["Status"]));
        }
        return WaybillHeaderDetail.ToArray();
    }
    public string[] GetUserForEditManifest(int userId)
    {
        List<string> WaybillHeaderDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@userId", userId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetUserForEditManifest", paramList);
        while (Reader.Read())
        {
            WaybillHeaderDetail.Add(string.Format("{0}", Reader["Status"]));
        }
        return WaybillHeaderDetail.ToArray();
    }
    public string[] CheckWaybillDetails(int waybillId)
    {
        List<string> WaybillHeaderDetail = new List<string>();
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@waybillId", waybillId.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_CheckWaybillDetails", paramList);
        while (Reader.Read())
        {
            WaybillHeaderDetail.Add(string.Format("{0}", Reader["Count"]));
        }
        return WaybillHeaderDetail.ToArray();
    }
    public int UpdatePickupRequestWareHouse(PickReq pickReqHeader)
    {
        PickReq session = new PickReq();
        session.Session.BranchID = Convert.ToInt32(HttpContext.Current.Session["branchId"]);
        session.Session.UserID = Convert.ToInt32(HttpContext.Current.Session["userID"]);
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@wayBillNo", pickReqHeader.WaybillNo.ToString()));
        paramList.Add(new Parameters("@waybillDate", pickReqHeader.WaybillDate.ToString()));
        paramList.Add(new Parameters("@walkinCustId", pickReqHeader.walkinCustID.ToString()));
        paramList.Add(new Parameters("@customerID", pickReqHeader.CustID.ToString()));
        paramList.Add(new Parameters("@customerType", pickReqHeader.CustType));
        paramList.Add(new Parameters("@contactNo", pickReqHeader.CustContactNo.ToString()));
        paramList.Add(new Parameters("@telephoneNo", pickReqHeader.CustTelephone));
        paramList.Add(new Parameters("@emailID", pickReqHeader.CustEmailId));
        paramList.Add(new Parameters("@customerAddress", pickReqHeader.CustAddress.ToUpper()));
        paramList.Add(new Parameters("@customerLocID", pickReqHeader.CustLocID.ToString()));
        paramList.Add(new Parameters("@customerAreaID", pickReqHeader.CustAreaID.ToString()));
        paramList.Add(new Parameters("@paymentMode", pickReqHeader.PaymentMode.ToUpper()));
        paramList.Add(new Parameters("@pickUPLocId", pickReqHeader.PickLocID.ToString()));
        paramList.Add(new Parameters("@pickupAreaId", pickReqHeader.PickAreaID.ToString()));
        paramList.Add(new Parameters("@pickupType", pickReqHeader.PickType.ToUpper()));
        paramList.Add(new Parameters("@pickupAddress", pickReqHeader.PickAddress.ToUpper()));
        paramList.Add(new Parameters("@consigneeID", pickReqHeader.ConsigneeID.ToString()));
        paramList.Add(new Parameters("@consigneeContactNo", pickReqHeader.ConsigneeContactNo.ToString()));
        paramList.Add(new Parameters("@deliveryLocID", pickReqHeader.DelLocID.ToString()));
        paramList.Add(new Parameters("@deliveryAreaID", pickReqHeader.DelAreaID.ToString()));
        paramList.Add(new Parameters("@consigneeAddress", pickReqHeader.DelAddress.ToUpper()));
        paramList.Add(new Parameters("@pickupBranchID", pickReqHeader.PickupBranch));
        paramList.Add(new Parameters("@branchId", session.Session.BranchID.ToString()));
        paramList.Add(new Parameters("@userId", session.Session.UserID.ToString()));
        // return (new Connection()).ExecuteSp("ssp_UpdateWareHouseWayBill", paramList);
        reader = (new Connection()).ExecuteSpIS("ssp_UpdateWareHouseWayBill", paramList);

        if (reader.Read())
        {
            CFunctions.setID(Convert.ToInt32(reader["WayBillId"].ToString()));
        }
        return CFunctions.ID;
    }
    public int UpdatePickupRequestWareHouseMaterial(PickReqDetail detail)
    {        
        List<Parameters> paramList = new List<Parameters>();
        IDataReader reader = null;
        paramList.Add(new Parameters("@WayBillItemId", detail.Id.ToString()));
        paramList.Add(new Parameters("@materialID", detail.MaterialID.ToString()));
        paramList.Add(new Parameters("@packID", detail.PackageID.ToString()));
        paramList.Add(new Parameters("@valueUOM", detail.Unit));
        paramList.Add(new Parameters("@valueL", detail.Length.ToString()));
        paramList.Add(new Parameters("@valueB", detail.Breadth.ToString()));
        paramList.Add(new Parameters("@valueC", detail.Height.ToString()));
        paramList.Add(new Parameters("@valueCFT", detail.CFT.ToString()));
        paramList.Add(new Parameters("@valueActualWt", detail.ActualWeight.ToString()));
        paramList.Add(new Parameters("@itemQty", detail.NoOfPackage.ToString()));
        paramList.Add(new Parameters("@innerqQty", detail.NoOfInnerPackage.ToString()));
        paramList.Add(new Parameters("@invoiceNo", detail.InvoiceNo.ToString().ToUpper()));
        paramList.Add(new Parameters("@invoiceDate", detail.InvoiceDate.ToString()));
        paramList.Add(new Parameters("@invoiceAmount", detail.InvoiceValue.ToString()));
        paramList.Add(new Parameters("@eWaybillNo", detail.EWaybillNo.ToString().ToUpper()));
        paramList.Add(new Parameters("@eWaybillDate", detail.EWaybillDate));
        paramList.Add(new Parameters("@ewayBillExpiryDate", detail.EWaybillExpiryDate));
        paramList.Add(new Parameters("@valueChargedWt", detail.ChargeWeight.ToString()));      
       
        reader = (new Connection()).ExecuteSpIS("ssp_UpdateWaybillItems", paramList);

        if (reader.Read())
        {
            CFunctions.setID(Convert.ToInt32(reader["Id"].ToString()));
        }
        return CFunctions.ID;
    }
}