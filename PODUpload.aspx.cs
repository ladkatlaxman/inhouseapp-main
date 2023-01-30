using BLFunctions;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PODUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		Response.Redirect(@"http://45.250.248.130:40/POD.aspx");
        //Response.Redirect(@"http://122.170.111.196:4000/POD.aspx");
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                //(new CFunctions()).dropdwnlist(null, null, Ddl_VehicleNo, null, "VehicleNo", "VehicleRequestID", (new PickReqFunctions().getDeliveredVehicleNo(Convert.ToInt32(Session["BranchId"]))));
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            (new CFunctions()).GetJavascriptFunction(this, "txtWayBillNo", "hfWayBillNo", "PODUpload.aspx/getWayBillNo", "GetData", "});});");
            (new CFunctions()).GetJavascript(CFunctions.javascript, this);
        }
   }
    [WebMethod]
    public static string[] getWayBillNo(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getDeliveredWaybillNo(searchPrefixText, data, Convert.ToInt32(HttpContext.Current.Session["branchID"]));
    }
    /*protected void Btn_UploadPOD_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {          
            string ext = Path.GetExtension(FileUpload1.FileName);
            string fileName = txtWayBillNo.Text + ext;
            string fileName1 = txtWayBillNo.Text + "_1" + ext;
            string fileName2 = txtWayBillNo.Text + "_2" + ext;
            string fileName3 = txtWayBillNo.Text + "_3" + ext;
            string fileName4 = txtWayBillNo.Text + "_4" + ext;
            string fileName5 = txtWayBillNo.Text + "_5" + ext;

            var str = "http://dexters.co.in/app/pod/";
            var url = str + fileName;
                    
            HttpWebResponse response = null;
            //var request = (HttpWebRequest)WebRequest.Create(url);
            //request.Method = "HEAD";           
            try
            {               
                //response = (HttpWebResponse)request.GetResponse();
                //HttpStatusCode status = response.StatusCode;  // It returns in YES/NO                      
                                                              // if status return YES   

                if(!System.IO.File.Exists(Server.MapPath(@"pod/" + fileName)))
                {
                    FileUpload1.SaveAs(Server.MapPath(@"pod/" + fileName));
                }
                else if (!System.IO.File.Exists(Server.MapPath(@"pod/" + fileName1)))
                {
                    FileUpload1.SaveAs(Server.MapPath(@"pod/" + fileName1));
                }
                else if (!System.IO.File.Exists(Server.MapPath(@"pod/" + fileName2)))
                {
                    FileUpload1.SaveAs(Server.MapPath(@"pod/" + fileName2));
                }
                else if (!System.IO.File.Exists(Server.MapPath(@"pod/" + fileName3)))
                {
                    FileUpload1.SaveAs(Server.MapPath(@"pod/" + fileName3));
                }
                else if (!System.IO.File.Exists(Server.MapPath(@"pod/" + fileName4)))
                {
                    FileUpload1.SaveAs(Server.MapPath(@"pod/" + fileName4));
                }
                txtWayBillNo.Text = "";
                hfWayBillNo.Value = "";
                FileUpload1.Dispose();
              //  Response.Redirect(Request.Url.AbsoluteUri);
            }
            catch (WebException ex)   // if status return NO
            {
                if(response==null)
                {
                    //FileUpload.SaveAs(Server.MapPath(@"pod/" + fileName1));
                    //Response.Redirect(Request.Url.AbsoluteUri);
                }               
            }
            finally
            {
                // Don't forget to close your response.
                if (response != null)
                {
                    response.Close();
                }
            }                                              
          
            //  string fileName = txtWayBillNo.Text + Path.GetFileName(FileUpload.PostedFile.FileName);
            //  FileUpload.PostedFile.SaveAs(Server.MapPath("~/pod/") + fileName);
                   
        }
        else
        {
          
        }
    }*/


    protected void Upload_Files(object sender, EventArgs e)
    {
        lblFileList.Text = "";
        if (fileUpload.HasFile)     // CHECK IF ANY FILE HAS BEEN SELECTED.
        {
            int iUploadedCnt = 0;
            int iFailedCnt = 0;
            HttpFileCollection hfc = Request.Files;
            //lblFileList.Text = "Select <b>" + hfc.Count + "</b> file(s)<br>";

            if (hfc.Count <= 30)    // 30 FILES RESTRICTION.
            {
                for (int i = 0; i <= hfc.Count - 1; i++)
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {
                        string sFileName = Path.GetFileName(hpf.FileName);
                        string sFileExt = Path.GetExtension(hpf.FileName);
                        if (sFileExt == ".png" || sFileExt == ".jpg" || sFileExt == ".jpeg")
                        {
                            string fileName = Path.GetFileNameWithoutExtension(hpf.FileName);
                            DataTable dt = new DataTable();
                            dt = new VehicleRequestFunction().GetDeliveredWaybillList(fileName);
                            if (dt.Rows.Count > 0)
                            {
                                string waybillId = dt.Rows[0]["waybillID"].ToString();
                               #region
                                    //string url = "http://122.170.111.196:2020/PODSCANNING//";
                                    //if (!File.Exists(url + Path.GetFileName(hpf.FileName)))

                                    string url = "http://122.170.111.196:2020/PODSCANNING//", strResponse = "";

                                    //string url = "http://example.com/help/" + LANG_ID + HELP_CONTEXT;
                                    WebRequest request = WebRequest.Create(url + sFileName);
                                    HttpWebResponse response = null;
                                    try
                                    {
                                        response = (HttpWebResponse)request.GetResponse();
                                        strResponse = response.StatusDescription;
                                    }
                                    catch { };

                                    if (response == null && strResponse != "OK")
                                    {
                                        if (!File.Exists(Server.MapPath("..\\pod\\") + sFileName))
                                        {
                                         DirectoryInfo objDir = new DirectoryInfo(Server.MapPath("..\\pod\\"));

                                    
                                            #region
                                            // CHECK FOR DUPLICATE FILES.
                                            FileInfo[] objFI = objDir.GetFiles(sFileName.Replace(sFileExt, "") + ".*");

                                            if (objFI.Length > 0)
                                            {
                                                // CHECK IF FILE WITH THE SAME NAME EXISTS 
                                                //(IGNORING THE EXTENTIONS).
                                                foreach (FileInfo file in objFI)
                                                {
                                                    string sFileName1 = objFI[0].Name;
                                                    string sFileExt1 = Path.GetExtension(objFI[0].Name); //Path.GetExtension < (objFI[0].Name);
                                                    if (sFileName1.Replace(sFileExt1, "") == sFileName.Replace(sFileExt, ""))
                                                    {
                                                        iFailedCnt += 1;        // NOT ALLOWING DUPLICATE.
                                                        break;
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                // SAVE THE FILE IN A FOLDER.
                                                hpf.SaveAs(Server.MapPath("..\\pod\\") +
                                                    Path.GetFileName(hpf.FileName));
                                                lblFileList.Text += "Uploaded for : " + sFileName + "<br>";

                                                (new BLFunctions.CommFunctions()).SavePODUpload(Convert.ToInt32(waybillId),(new CFunctions()).CurrentDateTime());

                                            iUploadedCnt += 1;
                                            }
                                            #endregion

                                                                       
                                      }
                                     else
                                       {
                                          lblFileList.Text += "<span style=\"color:#FF0000\">" + hpf.FileName + " already exists. </span><br>";
                                       }
                                   }
                                   else
                                   {
                                       lblFileList.Text += "<span style=\"color:#FF0000\">" + hpf.FileName + " already exists. </span><br>";
                                   }
                                    #endregion
                            }
                            else
                            {
                                lblFileList.Text += "<span style=\"color:#FF0000\">" + fileName + " Not Delivered. </span><br>";
                            }
                        }
                        else
                        {
                            lblFileList.Text += "<span style=\"color:#FF0000\">" + "Please Upload png, jpg and jpeg files only</span><br>";
                        }
                    }
                }
                lblUploadStatus.Text = "<b>" + iUploadedCnt + "</b> file(s) Uploaded.";
                //lblFailedStatus.Text = "<b>" + iFailedCnt +
                //    "</b> duplicate file(s) could not be uploaded.";
                //lblFileList.Text = "Select <b>" + (iUploadedCnt + iFailedCnt) + "</b> file(s)<br>";
            }
            else lblUploadStatus.Text = "Max. 30 files allowed.";
        }
        else lblUploadStatus.Text = "No files selected.";
    }
    /*protected void btnShowWaybill_Click(object sender, EventArgs e)
    {
        if (Ddl_VehicleNo.SelectedItem.ToString() != "SELECT")
        {           
            DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_VehicleNo.SelectedValue), 8, Convert.ToInt32(Session["branchId"].ToString()));
            gvDeliveryWaybills.DataSource = dt;
            gvDeliveryWaybills.DataBind();
        }
    }*/
}