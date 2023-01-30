using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
using BLProperties; 

public partial class VehiclePosition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).VehiclesRunning();
            foreach (VehicleRequestProperties vf in ViewList)
            {
                geoPosition gp = GetVehicleLatitudeLongitude(vf.VehicleNo);
                vf.Remark = gp.latitude + ", " + gp.longitude;
                try
                {
                    if (vf.latitude.ToString() != "" & vf.longitude.ToString() != "" & gp.latitude.ToString() != "" & gp.longitude.ToString() != "")
                    {
                        //Get the Google Distance of the Vehicle from the Warehouse. 
                        vf.distance = geoCodeDistance(vf.latitude, vf.longitude, gp.latitude, gp.longitude);
                    }
                }
                catch { }
            }
            /*foreach (VehicleRequestProperties vf in ViewList)
	    {
	        if (vf.distance == null || vf.distance == "") ViewList.Remove(vf);
            }*/
            //ViewList = ViewList.FindAll(p => p.distance.Trim() != ""); 
            gvVehicleList.DataSource = ViewList.Where(p => p.distance != null); 
            gvVehicleList.DataBind();
        }
    }

    protected void btnGetVehicleDetails_Click(object sender, EventArgs e)
    {
        geoPosition geo = GetVehicleLatitudeLongitude(txtVehicleNo.Text);
        lblLatitude.Text = geo.latitude;
        lblLongitude.Text = geo.longitude;
        lblAddress.Text = geo.address;
        lblDateTime.Text = geo.dateTime; 
        //lblResponse.Text = GetVehicleLatitudeLongitude(txtVehicleNo.Text); 
    }

    //public string GetVehicleLatitudeLongitude(string vehicleNo)
    public geoPosition GetVehicleLatitudeLongitude(string vehicleNo)
    {
        var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://backend.tracko.co.in/locate/vehicle");
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Method = "POST";
        geoPosition ngeo = new geoPosition();
        using (var streamWriter = new

        StreamWriter(httpWebRequest.GetRequestStream()))
        {
            string json = new JavaScriptSerializer().Serialize(new
            {
                accountNumber = 3337,
                vehicleNumber = vehicleNo
            });
            streamWriter.Write(json);
        }
        try
        {
            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            //return httpResponse.ToString(); 
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                string result = streamReader.ReadToEnd();
                var serializer = new JavaScriptSerializer();
                dynamic result1 = serializer.DeserializeObject(result);
                ngeo.latitude = Convert.ToString(result1["result"]["latitude"]);
                ngeo.longitude = Convert.ToString(result1["result"]["longitude"]);
                ngeo.address = Convert.ToString(result1["result"]["address"]);
                ngeo.dateTime = Convert.ToString(result1["result"]["dateTime"]);
                return ngeo;
                //return result; 
            }
        }
        catch { 
            
        }
        return ngeo; 
    }
    public string geoCodeDistance(string lat1, string long1, string lat2, string long2)
    {
        //https://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway,+Mountain + View,+CA & key = YOUR_API_KEY
        //string sURL = "https://maps.googleapis.com/maps/api/geocode/xml?origins=" + ngeo1.latitude + "," + ngeo1.longitude + "|" + ngeo2.latitude + "," + ngeo2.longitude + "&sensor=false&key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E";
        //string sURL = "https://maps.googleapis.com/maps/api/distancematrix/xml?units=imperial&origins=" + ngeo1.latitude + "," + ngeo1.longitude + "&destinations=" + ngeo2.latitude + "," + ngeo2.longitude + "&key=AIzaSyCf3AeB-YHUsLg12VhfIt8yFK5FLmP0yFE";
        string sURL = "https://maps.googleapis.com/maps/api/distancematrix/xml?units=imperial&origins=" + lat1 + "," + long1 + "&destinations=" + lat2 + "," + long2 + "&key=AIzaSyCf3AeB-YHUsLg12VhfIt8yFK5FLmP0yFE";

        WebRequest request = WebRequest.Create(sURL);
        request.Timeout = 10000;
        // Set the Method property of the request to POST.
        request.Method = "POST";
        // Create POST data and convert it to a byte array.
        string postData = "";
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);
        // Set the ContentType property of the WebRequest.
        request.ContentType = "application/x-www-form-urlencoded";
        // Set the ContentLength property of the WebRequest.
        request.ContentLength = byteArray.Length;
        // Get the request stream.
        Stream dataStream = request.GetRequestStream();

        // Write the data to the request stream.
        dataStream.Write(byteArray, 0, byteArray.Length);
        // Close the Stream object.
        dataStream.Close();
        // Get the response.
        WebResponse response = request.GetResponse();
        // Display the status.
        //Console.WriteLine(((HttpWebResponse)response).StatusDescription);
        // Get the stream containing content returned by the server.
        dataStream = response.GetResponseStream();
        // Open the stream using a StreamReader for easy access.
        StreamReader reader = new StreamReader(dataStream);
        // Read the content.
        string responseFromServer = reader.ReadToEnd();

        StringReader tx = new StringReader(responseFromServer);

        DataSet DS = new DataSet();
        DS.ReadXml(tx);

        string distance = "";
        string status = cCommon.GetStringValue(DS.Tables["DistanceMatrixResponse"].Rows[0]["status"]);
        if (status == "OK")
        {
            distance = DS.Tables["distance"].Rows[0]["value"].ToString(); ;
            //return tx.ToString();  
        }
        decimal intDistance;
        if (decimal.TryParse(distance, out intDistance))
        {
            //Convert Meters to Kilometers and Round it to 2 decimal places.
            distance = Math.Round(intDistance / 1000, 2).ToString();
        }
        return distance;
    }


}