using System;
using System.Collections.Generic;
using System.Data; 
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 
public partial class Dash : System.Web.UI.Page
{
    public StringBuilder strJSData = new StringBuilder();
    string strRequest = "Sales";
    string sDailyBookings = "5";
    protected void Page_Load(object sender, EventArgs e)
    {
        //System.Web.UI.HtmlControls.HtmlGenericControl menu = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("NavBar");
        //menu.Visible = false;

        lblType.Text = " ( Sales ) "; 

        try
        {
            if (Request["Type"].ToString() == "P")
            {
                lblType.Text = " ( Pending Items ) ";
                strRequest = "Pending";
                cmbType.SelectedValue = "WayBills";
                lnkPendingDeliveries.NavigateUrl = "DashDetails.aspx?T=PD&B=" + cmbBranchList.SelectedValue.ToString();
                lnkPendingTranshipments.NavigateUrl = "DashDetails.aspx?T=PT&B=" + cmbBranchList.SelectedValue.ToString();
            }
            if (Request["Type"].ToString() == "O")
            {
                lblType.Text = " ( Operations ) ";
                strRequest = "Operations";
            }
        }
        catch { }

        if(!IsPostBack)
        {
            //Populate the List of Branches 
            (new CFunctions()).dropdwnlist(null, null, cmbBranchList, null, "branchName", "branchId", (new CommFunctions().GetBranch()));
            //cmbType.SelectedIndex = 0; 
        }
        Btn_Search_Click(sender, e); 
    }

    private string getJSData(string strContainerName, string strHeaderText, string sYAxisText, IDataReader dr, string Labels, string strLabelField, string DataField)
    {
        StringBuilder strJSText = new StringBuilder();
        string strbarLabels = "", strLabelData = ""; 
        string[] strLabel = null, strField = null, strLabelsData = null;
        if (DataField != "")
        {
            strLabel = Labels.Split(';'); 
            strField = DataField.Split(';');
            strLabelsData = new string[strField.Length]; 
        }

        if (dr!= null)
        {
            while (dr.Read())
            {
                if (strLabelField != "")
                {
                    strbarLabels += "'" + dr[strLabelField].ToString() + "', ";
                }
                if(DataField != "")
                {
                    for(int i = 0; i < strField.Length - 1; i++)
                    {
                        strLabelsData[i] += dr[strField[i]].ToString() + ", "; 
                    }
                }
            }
            for (int i = 0; i < strLabelsData.Length - 1; i++)
            {
                //strLabelData += "name: 'Field', data:[" + strLabelsData[i] + "]"; 
                strLabelData += "{ name: '" + strLabel[i] + "', data:[" + strLabelsData[i] + "]," + 
                              "  dataLabels: {" +
                              "  enabled: true," +
                              //"  rotation: -90," +
                              //"  color: '#FFFFFF'," +
                              "  align: 'right'," +
                              "  y: 2, " +
                              "  style: " +
                              "     {" +
                              "      fontSize: '10px'," +
                              "      fontFamily: 'arial '," +
                              "      textShadow: false," +
                              "      fontWeight: 'normal' " +
                              "  } " +
                              "  } " +
                    "},"; 
            }
        }
        strJSText.Append("Highcharts.chart('" + strContainerName + "', {  "); 
        strJSText.Append(@"chart:
            {
            type: 'column'
            },
            title:
            {
            text: '" + strHeaderText + @"'
            },
            subtitle:
            {
            text: ''
            },
            xAxis:
            {
            categories:[" + 
                    /*'Jan',                    'Feb',                    'Mar',                    'Apr',                    'May', */ 
                    strbarLabels + 
                @"],
                crosshair: true
            },
            yAxis:
            {
            min: 0,
                title:
                {
                text: '" + sYAxisText + @"'
                }
            },
            tooltip:
            {
            headerFormat: '<span style=""font-size:10px"">{point.key}</span><table>',
                pointFormat: '<tr><td style=""color:{series.color};padding:0"">{series.name}: </td>' +
                    '<td style=""padding:0""><b>{point.y:.0f} </b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            credits: {
                enabled: false
            },
            plotOptions:
            {
            column:
                {
                    pointPadding: 0.4,
                    borderWidth: 0,
                    pointWidth : 25
                }
            },
            series:
            [" + 
                strLabelData + @"
            ],
        });
        ");
        return strJSText.ToString(); 
    }
    
    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        string stringBranchId = "", strBookingDataLabel = "", strBookingDataField = ""; 
        string strTranshipmentDataLabels = "", strTranshipmentDataFields = "";
        string strTDataLabels = "", strTDataFields = ""; 
        if(cmbType.SelectedValue == "WayBills")
        {
            strBookingDataLabel = "No of WayBills;"; 
            strBookingDataField = "WayBills;";
            strTranshipmentDataLabels = "Received; OFD; Delivered;";
            strTranshipmentDataFields = "WayBills;OFD WayBills;Delivered WayBills;";
            strTDataLabels = "Received WayBills;Loaded WayBills;";
            strTDataFields = "WayBills;Loaded WayBills;";
        }
        if (cmbType.SelectedValue == "Qty")
        {
            strBookingDataLabel = "No of Items;";
            strBookingDataField = "Qty;";
            strTranshipmentDataLabels = "Received; OFD; Delivered;";
            strTranshipmentDataFields = "Qty;OFD Qty;Delivered Qty;";
            strTDataLabels = "Received Qty;Loaded Qty;";
            strTDataFields = "Qty;Loaded Qty;";
        }
        if (cmbType.SelectedValue == "ActualWeight")
        {
            strBookingDataLabel = "Actual Weight;";
            strBookingDataField = "Actual Weight;";
            strTranshipmentDataLabels = "Received; OFD; Delivered;";
            strTranshipmentDataFields = "Received Actual Weight;OFD Actual Weight;Delivered Actual Weight;";
            strTDataLabels = "Received Wt;Loaded Wt;";
            strTDataFields = "Actual Weight;Loaded Actual Weight;";
        }
        if (cmbType.SelectedValue == "ChargedWeight")
        {
            strBookingDataLabel = "Charged Weight;";
            strBookingDataField = "Charged Wt;";
            strTranshipmentDataLabels = "Received Charged Wt; OFD Charged Wt; Delivered Charged Wt;";
            strTranshipmentDataFields = "Received Charged Wt;OFD Charged Wt;Delivered Charged Wt;";
            strTDataLabels = "Received Charged Wt;Loaded Charged Wt";
            strTDataFields = "Charged Wt;Loaded Charged Wt;";
        }
        if (cmbType.SelectedValue == "Freight")
        {
            strBookingDataLabel = "Freight;";
            strBookingDataField = "Freight;";
            strTranshipmentDataLabels = "Received Actual Wt; OFD Actual Wt; Delivered Actual Wt;";
            strTranshipmentDataFields = "Received Charged Wt;OFD Charged Wt;Delivered Charged Wt;";
        }
        if (cmbBranchList.SelectedIndex != 0) stringBranchId = cmbBranchList.SelectedValue.ToString();

        if (strRequest == "Sales")
        {
            dailybookingcontainerrow.Visible = true; 
            IDataReader dailybookingdataReader = (new DashBoard()).DashBoardDailyBookings(stringBranchId);
            strJSData.Append(getJSData(dailybookingcontainer.ClientID, "Daily Bookings", "Values", dailybookingdataReader, strBookingDataLabel, "Way Bill Date", strBookingDataField));

            monthlybookingtilldatecontainerrow.Visible = true;
            IDataReader monthlybookingtilldatedataReader = (new DashBoard()).DashBoardMonthlyTillDateBookings(stringBranchId, DateTime.Now.Day.ToString());
            strJSData.Append(getJSData(monthlybookingtilldatecontainer.ClientID, "Monthly Bookings till the date of " + DateTime.Now.Day.ToString(), "Values", monthlybookingtilldatedataReader, strBookingDataLabel, "Month", strBookingDataField));

            monthlybookingcontainerrow.Visible = true; 
            IDataReader monthlybookingdataReader = (new DashBoard()).DashBoardMonthlyBookings(stringBranchId);
            strJSData.Append(getJSData(monthlybookingcontainer.ClientID, "Monthly Bookings", "Values", monthlybookingdataReader, strBookingDataLabel, "Month", strBookingDataField));

            monthlydeliverycontainerrow.Visible = true;
            IDataReader monthlydeliverydataReader = (new DashBoard()).DashBoardMonthlydeliveries(stringBranchId);
            strJSData.Append(getJSData(monthlydeliverycontainer.ClientID, "Monthly Deliveries", "Values", monthlydeliverydataReader, strBookingDataLabel, "Month", strBookingDataField));
        }
        if (strRequest == "Operations") 
        {
            deliveryreportcontainerrow.Visible = true;
            IDataReader deliveryreportdataReader = (new DashBoard()).DashBoardDeliveries(stringBranchId);
            strJSData.Append(getJSData(deliveryreportcontainer.ClientID, "Delivery Operations", "Values", deliveryreportdataReader, strTranshipmentDataLabels, "Way Bill Date", strTranshipmentDataFields));

            transhipmentreportrow.Visible = true;
            IDataReader transhipmentReader = (new DashBoard()).DashBoardTranshipments(stringBranchId);
            strJSData.Append(getJSData(transhimentoperation.ClientID, "Transhipments", "Values", transhipmentReader, strTDataLabels, "Way Bill Date", strTDataFields));

            podcontainerrow.Visible = true;
            IDataReader deliverypoddataReader = (new DashBoard()).DashBoardPOD(stringBranchId);
            strJSData.Append(getJSData(podcontainer.ClientID, "Deliveries", "No Of Dockets", deliverypoddataReader, "Deliveries Done;POD Uploaded;", "Way Bill Date", "Deliveries Done;POD Uploaded;")); 
        }
        if (strRequest == "Pending")
        {
            pendingdeliveryreportcontainerrow.Visible = true;
            IDataReader pendingdeliveryDataReader = (new DashBoard()).DashBoardPendingDeliveries(stringBranchId, "");
            strJSData.Append(getJSData(pendingdeliveryreportcontainer.ClientID, "Pending Deliveries", "No Of Dockets", pendingdeliveryDataReader, "Received Date;", "Way Bill Date", "WayBills;"));

            pendingtranshipmentscontainerrow.Visible = true;
            IDataReader pendingTranshipmentsDataReader = (new DashBoard()).DashBoardPendingTranshipments(stringBranchId, "");
            strJSData.Append(getJSData(pendingtranshipmentscontainer.ClientID, "Pending Transhipments", "No Of Dockets", pendingTranshipmentsDataReader, "Received Date;", "Way Bill Date", "WayBills;"));
        }
    }
}