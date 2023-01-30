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
    public class WBEntryClass
    {
        int RouteId; string finalvalue;
        public WBEntryClass()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string[] getBranchStationary(string waybillNo, int branchID)
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
        public List<FullAddress> getArea(int pincode)
        {
            List<FullAddress> area = new List<FullAddress>();
            List<Parameters> paramList = new List<Parameters>();
            paramList.Add(new Parameters("@locPincode", pincode.ToString()));
            IDataReader Reader = (new Connection()).ReadSp("ssp_GetPincodeAreaList", paramList);
            while (Reader.Read())
            {
                area.Add(new FullAddress() { AreaID = Convert.ToInt32(Reader["locAreaID"]), Area = Reader["areaName"].ToString().ToUpper() });
            }
            return area;
        }
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
        }
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
                        ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString() + "|" + dr["areaName"].ToString() + "|" + dr["cityName"].ToString(), dr["consigneeId"].ToString()));
                    }
                }
                else if (data == "ReadData")
                {
                    foreach (DataRow dr in rows)
                    {
                        count++;
                        //ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString(), dr["consigneeId"].ToString()));
                        ConsigneeName.Add(string.Format("{0}ʭ{1}", dr["customerName"].ToString() + "|" + dr["areaName"].ToString() + "|" + dr["cityName"].ToString(), dr["consigneeId"].ToString()));
                        break;
                    }
                }
            }
            if (count == 0) ConsigneeName.Add(string.Format("{0}ʭ{1}", "", ""));
            return ConsigneeName.ToArray();
        }

    }
}
