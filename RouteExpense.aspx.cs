using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
public partial class RouteExpense : System.Web.UI.Page
{
    string strVehicleRequest = "";
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = ""; 
        lblErrorMessage.Text = "";
        if (Request["V"] != null)
        {
            strVehicleRequest = Request["V"].ToString();
        }
        else
            Response.Redirect("VehicleExpenses.aspx");

        fromfinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");
        tofinalDate = DateTime.Now.ToString("dd") + @"/" + DateTime.Now.ToString("MM") + @"/" + DateTime.Now.ToString("yyyy");

        if (!IsPostBack)
        {
            getVehicleRequestDetails();
        }
        else
        {
        }
        str = "$(\"[id$=txtStartDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
                "$(\"[id$=txtStartTime]\").timepicker();" + "\n" +
                "$(\"[id$=txtEndDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');" + "\n" +
                "$(\"[id$=txtEndTime]\").timepicker({ dateFormat: 'hh:mm'}).timepicker();});";
        CFunctions.setjavascript(CFunctions.javascript + str);
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        string startKM = "", endKM = "";

        if (txtMeterStart.Text == "" || txtMeterEnd.Text == "")
        {
            lblErrorMessage.Text = "Please provide Starting and Ending Kilometers";
            return; 
        }
        startKM = txtMeterStart.Text;
        endKM = txtMeterEnd.Text;

        saveVehicleRequestDetails(strVehicleRequest, txtStartDate.Text, txtStartTime.Text, txtEndDate.Text, txtEndTime.Text, startKM, endKM);
        getVehicleRequestDetails(); 
    }


    private void getVehicleRequestDetails() 
    {
        DataTable dtVehicleRequest = (new VehicleRequestFunction()).ViewVehicleMovementsNew(strVehicleRequest);
        if (dtVehicleRequest.Rows.Count > 0)
        {
            txtHiringDate.Text = dtVehicleRequest.Rows[0]["HiringDate"].ToString();
            txtVehicleNo.Text = dtVehicleRequest.Rows[0]["VehicleNo"].ToString();
            txtVehicleType.Text = dtVehicleRequest.Rows[0]["Type"].ToString();
            txtRoute.Text = dtVehicleRequest.Rows[0]["RouteName"].ToString();
            txtVendor.Text = dtVehicleRequest.Rows[0]["VendorName"].ToString();
            txtStartDate.Text = dtVehicleRequest.Rows[0]["TripStartDate"].ToString();
            fromfinalDate = txtStartDate.Text; 
            txtStartTime.Text = dtVehicleRequest.Rows[0]["TripStartTime"].ToString();
            txtEndDate.Text = dtVehicleRequest.Rows[0]["TripEndDate"].ToString();
            tofinalDate = txtEndDate.Text; 
            txtEndTime.Text = dtVehicleRequest.Rows[0]["TripEndTime"].ToString();
            txtMeterStart.Text = dtVehicleRequest.Rows[0]["StartKM"].ToString();
            txtMeterEnd.Text = dtVehicleRequest.Rows[0]["EndKM"].ToString();
            txtKMS.Text = dtVehicleRequest.Rows[0]["distance"].ToString();
            txtTime.Text = dtVehicleRequest.Rows[0]["Duration"].ToString();
            if(txtMeterStart.Text == "" && txtMeterEnd.Text == "")
            {
                txtMeterStart.Text = "0";
                txtMeterEnd.Text = dtVehicleRequest.Rows[0]["mapDistance"].ToString(); 
            }
            /*try
            {
                DateTime dateStart = DateTime.ParseExact(txtStartDate.Text + " " + txtStartTime.Text, "dd/MM/yyyy hh:mm tt", CultureInfo.InvariantCulture);
                DateTime dateEnd = DateTime.ParseExact(txtEndDate.Text + " " + txtEndTime.Text, "dd/MM/yyyy hh:mm tt", CultureInfo.InvariantCulture);
                txtTime.Text = Convert.ToString((dateEnd - dateStart).TotalHours); 
            }
            catch { }*/
            try
            {
                txtKMS.Text = Convert.ToString(Convert.ToDecimal(txtMeterEnd.Text) - Convert.ToDecimal(txtMeterStart.Text)); 
            }
            catch { }
            txtDriverName.Text = "";
        }
        DataTable dtVehicleExpenses = (new VehicleRequestFunction()).ViewVehicleRequestExpense(strVehicleRequest); 
        gvExpenseList.DataSource = dtVehicleExpenses; 
        gvExpenseList.DataBind(); 
    }

    private void saveVehicleRequestDetails(string strVehicleRequest, string startDate, string startTime, string endDate, string endTime, string startKM, string endKM)
    {
        (new VehicleRequestFunction()).saveVehicleRequestTripDetails(strVehicleRequest, startDate, startTime, endDate, endTime, startKM, endKM); 
    }

    protected void lnkExpense_Click(object sender, EventArgs e)
    {
        if(txtExpenseValue.Text == "")
        {
            lblErrorMessage.Text = "Please provide the Expense Value."; 
            return; 
        }
        (new VehicleRequestFunction()).saveVehicleRequestExpense(strVehicleRequest,  ddlExpenseType.SelectedValue.ToString(), ddlExpenseType.SelectedItem.Text, txtQty.Text, txtRate.Text, txtExpenseValue.Text);
        txtExpenseValue.Text = "";
        getVehicleRequestDetails();
    }
}