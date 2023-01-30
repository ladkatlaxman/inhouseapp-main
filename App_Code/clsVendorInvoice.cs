using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using BLProperties;
using NameSpaceConnection;

/// <summary>
/// Summary description for VendorInvoice
/// </summary>
public class clsVendorInvoice
{
    public clsVendorInvoice()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public IDataReader ViewTrips(string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_ViewVendorTrips", paramList);
        return Reader;
    }
    public DataTable ViewTripList(string vendorId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        paramList.Add(new Parameters("@vendorId", vendorId));
        DataTable dataTable = (new Connection()).Fillsp("ssp_ViewVendorTriplist", paramList);
        return dataTable;
    }
    public IDataReader ViwVendorFixBill(string vendorId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@vendorId", vendorId));
        return (new Connection()).ReadSp("ssp_ViwVendorFixBill", paramList);
    }
    public Vendor getVendorName(string vendorId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@vendorId", vendorId.ToString()));
        IDataReader reader = (new Connection()).ReadSp("ssp_GetVendorName", paramList);
        Vendor vendor = new Vendor();
        while (reader.Read())
        {
            vendor.Id = vendorId;
            vendor.Name = reader["vendorName"].ToString(); 
        }
        return vendor;
    }
    public IDataReader saveVehicleRequestsKMS(string VehicleRequestId, string KMS) 
    { 
        List<Parameters> paramList = new List<Parameters>(); 
        paramList.Add(new Parameters("@VehicleRequestId", VehicleRequestId)); 
        paramList.Add(new Parameters("@KMS", KMS)); 
        return (new Connection()).ReadSp("ssp_CreateVehicleRequestsKMS", paramList); 
    }
    public IDataReader createVehicleFreightKMS(string VendorId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>(); 
        paramList.Add(new Parameters("@VendorId", VendorId)); 
        paramList.Add(new Parameters("@fromDate", fromDate.ToString())); 
        paramList.Add(new Parameters("@toDate", toDate.ToString())); 
        return (new Connection()).ReadSp("ssp_CreateVendorFixedBill", paramList); 
    }
    public IDataReader createVehicleFreightALL(string VendorId, string fromDate, string toDate)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@VendorId", VendorId));
        paramList.Add(new Parameters("@fromDate", fromDate.ToString()));
        paramList.Add(new Parameters("@toDate", toDate.ToString()));
        return (new Connection()).ReadSp("ssp_CreateVendorBillNew", paramList);
    }
    public IDataReader getVehicledetails(string vehicleRequestId)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
        return (new Connection()).ReadSp("ssp_GetVehicleRequestDetails", paramList);
    }
    public IDataReader getWayBillExpenses(string vehicleRequestId)
    {
        List<Parameters> paramList = new List<Parameters>();
        if(!vehicleRequestId.Equals("")) paramList.Add(new Parameters("@vehicleRequestId", vehicleRequestId));
        return (new Connection()).ReadSp("ssp_WayBillFreightExpenses", paramList);
    }

}

public class Vendor
{
    public string Id { get; set; }
    public string Name { get; set; }

}