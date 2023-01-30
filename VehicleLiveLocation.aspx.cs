using System;
//using System.Collections.Generic;
using System.IO;
//using System.Linq;
using System.Net;
//using System.Web;
using System.Web.Script.Serialization;
//using System.Web.UI;
//using System.Web.UI.WebControls;

public partial class VehicleLiveLocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        geoPosition ngeo = (new VehicleMovement()).GetVehicleLatitudeLongitude("MH42K7948");
        lblLocation.Text = "Latitude :- " + ngeo.latitude + " Longitude :- " + ngeo.longitude;
        
        iFrame.Src = "https://www.google.com/maps/embed/v1/place?q=" + ngeo.latitude + "," + ngeo.longitude + "&amp;key=AIzaSyDxuviIj3j9kfdOu1nPZkJq8DpEu-Kge4E";
    }
}