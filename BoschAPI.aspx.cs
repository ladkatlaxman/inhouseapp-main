//using BLProperties;
using iTextSharp.tool.xml.html;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using System.Windows.Media.Media3D;
using ZXing.Aztec.Internal;

public partial class BoschAPI : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Web.UI.HtmlControls.HtmlGenericControl menu = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("NavBar");
        menu.Visible = false;

        if (!IsPostBack)
        {
            ddlBosch.DataValueField = "CustomerId";
            ddlBosch.DataTextField = "CustomerName";
            ddlBosch.DataSource = (new clsBoschCustomerFunctions()).getCustomerListTable();
            ddlBosch.DataBind();

            dtFrom.Text = DateTime.Now.AddDays(-30).ToString(@"01/MM/yyyy");
            dtTill.Text = DateTime.Now.ToString(@"dd/MM/yyyy");

            btnGetWayBills_Click(sender, e);
        }
    }
    protected void btnGetWayBills_Click(object sender, EventArgs e)
    {
        gvFirstGrid.DataSource = (new clsBoschCustomerFunctions()).getWayBillListTable(dtFrom.Text, dtTill.Text);
        gvFirstGrid.DataBind();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int iCount = 0;
        lblError.Text = ""; lblStatement.Text = "";
        foreach (GridViewRow dataGridViewRow in gvFirstGrid.Rows)
        {
            if (!dataGridViewRow.Cells[0].Text.Trim().Equals(""))
            {
                //lblError.Text += dataGridViewRow.Cells[0].Text + ":" + dataGridViewRow.Cells[1].Text + ",";
                //if (dataGridViewRow.Cells["colWayBillId"].Value.ToString() == "294553")
                {
                    if (dataGridViewRow.Cells[1].Text == "Shipment Delivered" && iCount > 0 && iCount < 0)
                    //if (dataGridViewRow.Cells[1].Text == "Shipment In Transit" && iCount < 50)
                    {
                        iCount++;
                        UpdateServer(dataGridViewRow.Cells[0].Text, dataGridViewRow.Cells[1].Text,
                            dataGridViewRow.Cells[2].Text, dataGridViewRow.Cells[3].Text,
                            dataGridViewRow.Cells[4].Text, dataGridViewRow.Cells[5].Text,
                            dataGridViewRow.Cells[6].Text, dataGridViewRow.Cells[7].Text);
                        //UpdateServer(dataGridViewRow.Cells[0].Text, "Shipment Delivered");
                        //UpdateServer(dataGridViewRow.Cells[0].Text, dataGridViewRow.Cells[1].Text); 
                        //UpdateServer(dataGridViewRow.Cells["colWayBillId"].Value.ToString(), dataGridViewRow.Cells["colStatus"].Value.ToString());
                        //UpdateServer(dataGridViewRow.Cells["colWayBillNo"].Value.ToString(), dataGridViewRow.Cells["colStatus"].Value.ToString());
                    }
                }
            }
            //break;
        }

    }

    private void UpdateServer(string sWayBillNo, string Status, string branchName, string wayBillDate, string delDate,
                string weight, string noOfPackages, string edd)
    {
        ServicePointManager.Expect100Continue = true;
        //ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
        var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://trackingapi.bosch-travis.com/api/lr/tracking");
        httpWebRequest.Headers.Add("Authorization", "Bearer " + Session["boschtoken"].ToString());
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Method = "POST";
        wayBillDate = wayBillDate.Substring(wayBillDate.Length - 4, 4) + @"-" + wayBillDate.Substring(3, 2) + "-" +
                      wayBillDate.Substring(0, 2) + " 12:00:00";
        delDate = delDate.Substring(delDate.Length - 4, 4) + @"-" + delDate.Substring(3, 2) + "-" + delDate.Substring(0, 2) + " 12:00:00";
        //sWayBillNo = "293964";
        edd = edd.Substring(edd.Length - 4, 4) + @"-" + edd.Substring(3, 2) + "-" +
                        edd.Substring(0, 2) + " 12:00:00";
        String ActualDelDate = @"""actualDeliveredDate"":""" + delDate + @"""";
        //if(Status == "Shipment Delivered") ActualDelDate += delDate;
        edd = delDate;
        //lblError.Text += ":::" + ActualDelDate + ":::" + Status + ":::"; 
        var body = @"{
                    ""lrTrackingDetails"": {
                    ""lspId"": ""0097220216"",
                    ""lrNumber"": """ + sWayBillNo + @""",
                    ""lrStatus"": """ + Status + @""",
                    ""latitude"": ""00.00"",
                    ""longitude"": ""00.00"",
                    ""location"": """ + branchName + @""",
                    ""pickUpDate"": """ + wayBillDate + @""",
                    ""lrDate"": """ + wayBillDate + @""",
                    ""actualDeliveredDate"":""" + delDate + @""",
                    ""edd"": """ + edd + @""",
                   ""receiverName"": ""'null'"",
                    ""deliveredToPerson"": ""'null'"",
                    ""actualWeight"": """ + weight + @""",
                    ""numberOfPackages"": """ + noOfPackages + @""",
                    ""length"": 1.0,
                    ""breadth"": 1.0,
                    ""height"": 1.0,
                    ""truckType"": ""LTL"",
                    ""truckTonnage"": ""1 T"",
                    ""vehicleNo"": """",
                    ""deliveryNotes"": ""null""
                    }
                }";
        //lblError.Text += body ;
        using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
        {
            string json = body;
            streamWriter.Write(json);
        }
        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            string result = streamReader.ReadToEnd();
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Text += result;
        }
        lblStatement.Text += body.ToString() + "<br />";
    }
    private void Login()
    {
        var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://trackingapi.bosch-travis.com/api/auth/login");
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Method = "POST";
        var body = @"{
                      ""userDetails"": {
                        ""emailId"": ""ithead@dexters.co.in"",
                        ""password"": ""Dex@@159##""
                      }
                    }";
        using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
        {
            string json = body;
            streamWriter.Write(json);
        }
        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            string result = streamReader.ReadToEnd();
            lblError.ForeColor = System.Drawing.Color.Red;
            lblError.Text += result;
            dynamic jsonResponse = JsonConvert.DeserializeObject(result);
            dynamic jsonObject = jsonResponse.token;
            string token = Convert.ToString(jsonObject);
            lblError.Text += token;
            Session["boschtoken"] = token;
        }
    }

    private bool CheckFile(string wayBillNo)
    {
        string filename = @"http://45.250.248.130:40/pod/" + wayBillNo;
        bool result = false;
        result = getFile(filename, wayBillNo, "jpg");
        if (!result) result = getFile(filename, wayBillNo, "jpeg");
        filename = @"http://45.250.248.130:40/podMobile/" + wayBillNo;
        if (!result) result = getFile(filename, wayBillNo, "jpg");
        if (!result) result = getFile(filename, wayBillNo, "jpeg");
        return result; 
    }

    private bool getFile(string filename, string wayBillNo, string extension)
    {
        filename = filename + "." + extension;
        var request = (HttpWebRequest)WebRequest.Create(filename);
        request.Method = "HEAD";
        try
        {
            byte[] data;
            using (WebClient client = new WebClient())
            {
                data = client.DownloadData(filename);
            }
            File.WriteAllBytes(Server.MapPath("pod") + @"\" + wayBillNo + ".jpg", data);
            return true;
        }
        catch (WebException ex)
        {
            /* A WebException will be thrown if the status of the response is not `200 OK` */
            //lblPOD.Text = ex.Message;
            return false;
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Login();
    }
    protected void btnUploadEPod_Click(object sender, EventArgs e)
    {
        int iCount = 0;
        lblError.Text = ""; lblStatement.Text = "";
        foreach (GridViewRow dataGridViewRow in gvFirstGrid.Rows)
        {
            if (!dataGridViewRow.Cells[0].Text.Trim().Equals(""))
            {
                iCount++;
                //lblError.Text += dataGridViewRow.Cells[0].Text + ":" + dataGridViewRow.Cells[1].Text + ",";
                //if (dataGridViewRow.Cells[1].Text == "Shipment In Transit" && iCount < 50)
                if (dataGridViewRow.Cells[1].Text == "Shipment Delivered" && iCount >= 0)
                {
                    //Get the File in the Server 
                    if (CheckFile(dataGridViewRow.Cells[0].Text) == true)
                    {
                        //Thread.Sleep(1000); 
                        uploadEPOD(dataGridViewRow.Cells[0].Text);
                        if (iCount > 10) break;
                    }
                }
            }
        }
    }
    private void uploadEPOD(string WayBillNo)
    {
        byte[] imageArray = System.IO.File.ReadAllBytes(Server.MapPath("pod") + @"\" + WayBillNo + ".jpg");
        string base64ImageRepresentation = Convert.ToBase64String(imageArray);
        //File.WriteAllText(@Server.MapPath("pod") + @"\POD.txt", base64ImageRepresentation + Environment.NewLine);

        ServicePointManager.Expect100Continue = true;
        var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://trackingapi.bosch-travis.com/api/lr/epod");
        httpWebRequest.Headers.Add("Authorization", "Bearer " + Session["boschtoken"].ToString());
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Method = "POST";

        var body = @"{ 
                    ""lrNumber"": """ + WayBillNo + @""", 
                    ""lspId"": ""0097220216"", 
                    ""epod"": """ + base64ImageRepresentation + @""" 
                    }";

        using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
        {
            string json = body; // 
            streamWriter.Write(json);
        }
        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            string result = streamReader.ReadToEnd();
            lblError.ForeColor = System.Drawing.Color.Red;
             lblError.Text += result;
        }
        return;
    }
}