using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for JsonHelper
/// </summary>
namespace BLFunctions
{
    public class JsonHelper
    {
        public JsonHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static List<string> InvalidJsonElements;
        public static IList<T> DeserializeToList<T>(string jsonString)
        {
            InvalidJsonElements = null;

            /*var array = JArray.Parse(jsonString);
            IList<T> objectsList = new List<T>();

            foreach (var item in array)
            {
                try
                {
                    // CorrectElements  
                    objectsList.Add(item.ToObject<T>());
                }
                catch (Exception ex)
                {
                    InvalidJsonElements = InvalidJsonElements ?? new List<string>();
                    InvalidJsonElements.Add(item.ToString());
                }
            }*/
            //jsonString = jsonString; 
            JObject fromJsonObject = JObject.Parse(jsonString);
            IList<JToken> results = fromJsonObject[""]["itemList"].Children().ToList();

            IList<ItemList> deserResults = new List<ItemList>();

            IList<T> objectsList = new List<T>();
            foreach (JToken result in results)
            {
                ItemList ItemList = result.ToObject<ItemList>();
                deserResults.Add(ItemList);
            }

            return objectsList;
        }
    }



    /*public class ItemList
    {
        public string itemNo { get; set; }
        public string productId { get; set; }
        public string productName { get; set; }
        public string productDesc { get; set; }
        public string hsnCode { get; set; }
        public string quantity { get; set; }
        public string qtyUnit { get; set; }
        public string cgstRate { get; set; }
        public string sgstRate { get; set; }
        public string igstRate{ get; set; }
        public string cessRate { get; set; }
        public string cessNonAdvol { get; set; }
        public string taxableAmount { get; set; }
    }*/

    // Root myDeserializedClass = JsonConvert.DeserializeObject<List<Root>>(myJsonResponse);
    public class ItemList
    {
        public string itemNo { get; set; }
        public string productId { get; set; }
        public string productName { get; set; }
        public string productDesc { get; set; }
        public string hsnCode { get; set; }
        public string quantity { get; set; }
        public string qtyUnit { get; set; }
        public string cgstRate { get; set; }
        public string sgstRate { get; set; }
        public string igstRate { get; set; }
        public string cessRate { get; set; }
        public string cessNonAdvol { get; set; }
        public string taxableAmount { get; set; }
    }

    public class Result
    {
        public string ewbNo { get; set; }
        public string ewayBillDate { get; set; }
        public string genMode { get; set; }
        public string userGstin { get; set; }
        public string supplyType { get; set; }
        public string subSupplyType { get; set; }
        public string docType { get; set; }
        public string docNo { get; set; }
        public string docDate { get; set; }
        public string fromGstin { get; set; }
        public string fromTrdName { get; set; }
        public string fromAddr1 { get; set; }
        public string fromAddr2 { get; set; }
        public string fromPlace { get; set; }
        public string fromPincode { get; set; }
        public string fromStateCode { get; set; }
        public string toGstin { get; set; }
        public string toTrdName { get; set; }
        public string toAddr1 { get; set; }
        public string toAddr2 { get; set; }
        public string toPlace { get; set; }
        public string toPincode { get; set; }
        public string toStateCode { get; set; }
        public string totalValue { get; set; }
        public string totInvValue { get; set; }
        public string cgstValue { get; set; }
        public string sgstValue { get; set; }
        public string igstValue { get; set; }
        public string cessValue { get; set; }
        public string transporterId { get; set; }
        public string transporterName { get; set; }
        public string status { get; set; }
        public string actualDist { get; set; }
        public string noValidDays { get; set; }
        public string vehicleType { get; set; }
        public string validUpto { get; set; }
        public string extendedTimes { get; set; }
        public string rejectStatus { get; set; }
        public string actFromStateCode { get; set; }
        public string actToStateCode { get; set; }
        public string transactionType { get; set; }
        public string otherValue { get; set; }
        public string cessNonAdvolValue { get; set; }
        public List<ItemList> itemList { get; set; }
        public List<VehiclListDetail> VehiclListDetails { get; set; }
    }

    public class Root
    {
        public Result Result { get; set; }
        public string Id { get; set; }
        public string Exception { get; set; }
        public string Status { get; set; }
        public string IsCanceled { get; set; }
        public string IsCompleted { get; set; }
        public string CreationOptions { get; set; }
        public string AsyncState { get; set; }
        public string IsFaulted { get; set; }
    }

    public class VehiclListDetail
    {
        public string updMode { get; set; }
        public string vehicleNo { get; set; }
        public string fromPlace { get; set; }
        public string fromState { get; set; }
        public string tripshtNo { get; set; }
        public string userGSTINTransin { get; set; }
        public string enteredDate { get; set; }
        public string transMode { get; set; }
        public string transDocNo { get; set; }
        public string transDocDate { get; set; }
    }


}