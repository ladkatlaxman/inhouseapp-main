using BLFunctions;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WaybillTracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Web.UI.HtmlControls.HtmlGenericControl menu = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("NavBar");
        menu.Visible = false;
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        //  string strWaybillNo = "2086941,2086943,2045632";
       
        string strWaybillNo = txtWayBillNo.Text.ToString();
        string[] strArr = strWaybillNo.Split(',');
       
        for (int i = 0; i <= strArr.Length - 1; i++)
        {           
            string waybillNo = null;
            if (i <= 12)
            {
                DataTableCollection dtMultiple;
                dtMultiple = (new CommFunctions()).ViewWayBillTracking(strArr[i].Trim());
                DataTable dt = new DataTable();
                dt= (new CommFunctions()).WayBillsEntered(strArr[i].Trim());
                if(dt.Rows.Count>0)
                    {
                        Control myControl = LoadControl("WaybillTrackingControl1.ascx");
                        myControl.ID = "WaybillTrackingControl" + i.ToString();
                        myControl.Visible = true;
                        this.MultipleTrackingDetails.Controls.Add(myControl);

                        ((GridView)myControl.FindControl("GV_Booking")).DataSource = dtMultiple[0];
                          waybillNo= dtMultiple[0].Rows[0]["waybillNo"].ToString();
                        ((GridView)myControl.FindControl("GV_Booking")).DataBind();

                        ((GridView)myControl.FindControl("GV_Transhipment")).DataSource = dtMultiple[1];
                        ((GridView)myControl.FindControl("GV_Transhipment")).DataBind();

                    List<ListItem> files = new List<ListItem>();
                    bool bDone = false;
                    var str = "http://122.170.111.196:2020/PODSCANNING//";
                    var url0 = str + waybillNo + ".png";
                    var url1 = str + waybillNo + ".jpg";
                    var url2 = str + waybillNo + ".pdf";
                    var url3 = str + waybillNo + ".jpeg";

                    HttpWebResponse response = null;
                    var request0 = (HttpWebRequest)WebRequest.Create(url0);
                    var request1 = (HttpWebRequest)WebRequest.Create(url1);
                    var request2 = (HttpWebRequest)WebRequest.Create(url2);
                    var request3 = (HttpWebRequest)WebRequest.Create(url3);

                    request0.Method = "HEAD";
                    request1.Method = "HEAD";
                    request2.Method = "HEAD";
                    request3.Method = "HEAD";

                    try
                    {
                        response = (HttpWebResponse)request0.GetResponse();
                        HttpStatusCode status0 = response.StatusCode;
                        bDone = true;
                        string filePath = waybillNo + ".png";
                        files.Add(new ListItem((filePath), filePath));
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request1.GetResponse();
                        HttpStatusCode status1 = response.StatusCode;
                        bDone = true;
                        string filePath = waybillNo + ".jpg";
                        files.Add(new ListItem((filePath), filePath));
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request2.GetResponse();
                        HttpStatusCode status2 = response.StatusCode;
                        bDone = true;
                        string filePath = waybillNo + ".pdf";
                        files.Add(new ListItem((filePath), filePath));
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request3.GetResponse();
                        HttpStatusCode status3 = response.StatusCode;
                        bDone = true;
                        string filePath = waybillNo + ".jpeg";
                        files.Add(new ListItem((filePath), filePath));
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }


                    if (System.IO.File.Exists(Server.MapPath(@".//pod//" + waybillNo + ".png")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + ".png"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (waybillNo + "_1").Trim() + ".png")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + (waybillNo + "_1").Trim() + ".png"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (waybillNo + "_2").Trim() + ".png")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + (waybillNo + "_2").Trim() + ".png"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }

                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + waybillNo + ".jpg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + ".jpg"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + waybillNo + "_1" + ".jpg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + "_1" + ".jpg"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + waybillNo + "_2" + ".jpg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + "_2" + ".jpg"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }

                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + waybillNo + ".jpeg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + ".jpeg"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + waybillNo + "_1" + ".jpeg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + "_1" + ".jpeg"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + waybillNo + "_2" + ".jpeg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + waybillNo + "_2" + ".jpeg"));
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                        bDone = true;
                    }
                    if (bDone == false)
                    {                     
                        string filePath = ("NO POD Uploaded");
                        files.Add(new ListItem(filePath, ""));
                        bDone = true;
                    }

                    ((GridView)myControl.FindControl("gvPODList")).DataSource = files;
                    ((GridView)myControl.FindControl("gvPODList")).DataBind();


                }

                //if (i == 0)
                //{
                //    Tracking1.Visible = true;                           
                //    ((Label)Tracking1.FindControl("HeaderName")).Text = strArr[0] + "  " + "TRACKING DETAILS";
                //    ((GridView)Tracking1.FindControl("GV_Booking")).DataSource = dtMultiple[0];
                //    ((GridView)Tracking1.FindControl("GV_Booking")).DataBind();

                //    ((GridView)Tracking1.FindControl("GV_Transhipment")).DataSource = dtMultiple[1];
                //    ((GridView)Tracking1.FindControl("GV_Transhipment")).DataBind();
                //}
                //if (i == 1)
                //{
                //    Tracking2.Visible = true;
                //    ((Label)Tracking2.FindControl("HeaderName")).Text = strArr[1] + "  " + "TRACKING DETAILS";
                //    ((GridView)Tracking2.FindControl("GV_Booking")).DataSource = dtMultiple[0];
                //    ((GridView)Tracking2.FindControl("GV_Booking")).DataBind();

                //    ((GridView)Tracking2.FindControl("GV_Transhipment")).DataSource = dtMultiple[1];
                //    ((GridView)Tracking2.FindControl("GV_Transhipment")).DataBind();
                //}
                //if (i == 2)
                //{
                //    Tracking3.Visible = true;
                //    ((Label)Tracking3.FindControl("HeaderName")).Text = strArr[2] + "  " + "TRACKING DETAILS";
                //    ((GridView)Tracking3.FindControl("GV_Booking")).DataSource = dtMultiple[0];
                //    ((GridView)Tracking3.FindControl("GV_Booking")).DataBind();

                //    ((GridView)Tracking3.FindControl("GV_Transhipment")).DataSource = dtMultiple[1];
                //    ((GridView)Tracking3.FindControl("GV_Transhipment")).DataBind();
                //}
                //if (i == 3)
                //{
                //    Tracking4.Visible = true;
                //    ((Label)Tracking4.FindControl("HeaderName")).Text = strArr[3] + "  " + "TRACKING DETAILS";
                //    ((GridView)Tracking4.FindControl("GV_Booking")).DataSource = dtMultiple[0];
                //    ((GridView)Tracking4.FindControl("GV_Booking")).DataBind();

                //    ((GridView)Tracking4.FindControl("GV_Transhipment")).DataSource = dtMultiple[1];
                //    ((GridView)Tracking4.FindControl("GV_Transhipment")).DataBind();
                //}
                //if (i == 4)
                //{
                //    Tracking5.Visible = true;
                //    ((Label)Tracking5.FindControl("HeaderName")).Text = strArr[4] + "  " + "TRACKING DETAILS";
                //    ((GridView)Tracking5.FindControl("GV_Booking")).DataSource = dtMultiple[0];
                //    ((GridView)Tracking5.FindControl("GV_Booking")).DataBind();

                //    ((GridView)Tracking5.FindControl("GV_Transhipment")).DataSource = dtMultiple[1];
                //    ((GridView)Tracking5.FindControl("GV_Transhipment")).DataBind();
                //}
            }

        }
    }
}