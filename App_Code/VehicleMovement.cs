using System;
using System.Data; 
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using BLProperties;
using BLFunctions; 

/// <summary>
/// Summary description for VehicleMovement
/// </summary>
public class VehicleMovement
{
    public VehicleMovement()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public geoPosition getBranchLatitudeLongitude(string branchId)
    {
        geoPosition geoBranch = new geoPosition();
        geoPosition ngeo = new geoPosition(); 
        string branchAddress = ((new CommFunctions()).getBranchAddress(branchId)).branchAddress;
        ngeo = geoCodeAddress(branchAddress); 
        return ngeo; 
    }

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
                //accountNumber = 1113,
                accountNumber = 3337,
                vehicleNumber = vehicleNo
                //vehicleNumber = "MH42K7948"
                //accountNumber = 3337,
                //vehicleNumber = "MH42K7948"
            });
            streamWriter.Write(json);
        }
        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            string result = streamReader.ReadToEnd();
            var serializer = new JavaScriptSerializer();
            dynamic result1 = serializer.DeserializeObject(result);
            //var r = int.Parse(result1["result"]["latitude"]);
            //return "Latitude :- " + result1["result"]["latitude"] + " Longitude :- " + result1["result"]["longitude"];
            ngeo.latitude = Convert.ToString(result1["result"]["latitude"]);
            ngeo.longitude = Convert.ToString(result1["result"]["longitude"]);
            return ngeo; 
        }
    }


    public string geoCodeDistance(geoPosition ngeo1, geoPosition ngeo2)
    {
        //https://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway,+Mountain + View,+CA & key = YOUR_API_KEY
        //string sURL = "https://maps.googleapis.com/maps/api/geocode/xml?origins=" + ngeo1.latitude + "," + ngeo1.longitude + "|" + ngeo2.latitude + "," + ngeo2.longitude + "&sensor=false&key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E";
        string sURL = "https://maps.googleapis.com/maps/api/distancematrix/xml?units=imperial&origins=" + ngeo1.latitude + "," + ngeo1.longitude + "&destinations=" + ngeo2.latitude + "," + ngeo2.longitude + "&key=AIzaSyCf3AeB-YHUsLg12VhfIt8yFK5FLmP0yFE";

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
            distance = DS.Tables["distance"].Rows[0]["value"].ToString();;
        }
        decimal intDistance; 
        if(decimal.TryParse(distance, out intDistance))
        {
            //Convert Meters to Kilometers and Round it to 2 decimal places.
            distance = Math.Round(intDistance / 1000, 2).ToString();
        }
        return distance;
    }


    public geoPosition geoCodeAddress(string Address)
    {
        //https://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway,+Mountain + View,+CA & key = YOUR_API_KEY
        string sURL = "https://maps.googleapis.com/maps/api/geocode/xml?address=" + Address + "&sensor=false&key=AIzaSyCf3AeB-YHUsLg12VhfIt8yFK5FLmP0yFE"; 
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
        //DS.ReadXml(dataStream);
        //DS.ReadXml(tx);

        geoPosition GP = new geoPosition();

        string status = cCommon.GetStringValue(DS.Tables["GeocodeResponse"].Rows[0]["status"]);
        if (status == "OK")
        {
            GP.latitude = DS.Tables["location"].Rows[0]["lat"].ToString();
            //cCommon.GetNumericValue(DS.Tables["location"].Rows[0]["lat"]);
            GP.longitude = DS.Tables["location"].Rows[0]["lng"].ToString();
            //cCommon.GetNumericValue(DS.Tables["location"].Rows[0]["lng"]);
            /*if (DS.Tables["result"] != null)
            {
                GP.Address = cCommon.GetStringValue(DS.Tables["result"].Rows[0]["formatted_address"]);
            }*/
        }
        return GP;
    }
    public string GetStringVehicleLatitudeLongitude(string vehicleNo)
    {
        var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://backend.tracko.co.in/locate/geofence");
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Method = "POST";
        geoPosition ngeo = new geoPosition();
        using (var streamWriter = new

        StreamWriter(httpWebRequest.GetRequestStream()))
        {
            string json = new JavaScriptSerializer().Serialize(new
            {
                //accountNumber = 1113,
                accountNumber = 3337,
                vehicleNumber = vehicleNo, 
        		date = "2021-06-09T16:30:00.000Z"
                //vehicleNumber = "MH42K7948"
                //accountNumber = 3337,
                //vehicleNumber = "MH42K7948"
            });
            streamWriter.Write(json);
        }
        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            string result = streamReader.ReadToEnd();
            return result; 
            //return ngeo;
        }
    }
}

public class geoPosition
{
    public string latitude { get; set; }
    public string longitude { get; set; }
    public string address { get; set; }
    public string dateTime { get; set; } 
    public string sdata { get; set; }
}
