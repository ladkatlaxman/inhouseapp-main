using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ParkVehicle : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnGetResult_Click(object sender, EventArgs e)
    {
        txtResult.Text = (new VehicleMovement()).GetStringVehicleLatitudeLongitude(txtVehicleNo.Text); 
    }
}