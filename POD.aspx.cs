using BLFunctions;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using Ionic.Zip;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class POD : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl menu = (System.Web.UI.HtmlControls.HtmlGenericControl)Master.FindControl("NavBar");
            menu.Visible = false;
        }
    }
 
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

                                /*string url = "http://122.170.111.196:2020/PODSCANNING//", strResponse = "";

                                //string url = "http://example.com/help/" + LANG_ID + HELP_CONTEXT;
                                WebRequest request = WebRequest.Create(url + sFileName);
                                HttpWebResponse response = null;
                                try
                                {
                                    response = (HttpWebResponse)request.GetResponse();
                                    strResponse = response.StatusDescription;
                                }
                                catch { };*/

                                if (1==1) //(response == null && strResponse != "OK")
                                {
                                    if (!File.Exists(@"D:\PODInhouse\pod\" + sFileName) & !File.Exists(@"D:\PODNewOne\PODSCANNING\" + sFileName))
                                    {
                                        DirectoryInfo objDir = new DirectoryInfo(@"D:\PODInhouse\pod\");
                                        
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
                                            // hpf.SaveAs(Server.MapPath("..\\pod\\") +
                                            //hpf.SaveAs(Server.MapPath("http://122.170.111.196:2020/PODSCANNING//") +
                                            //     Path.GetFileName(hpf.FileName));
                                            hpf.SaveAs(@"D:\PODInhouse\pod\" + Path.GetFileName(hpf.FileName));
                                            lblFileList.Text += "Uploaded for : " + sFileName + "<br>";

                                            if (File.Exists(@"D:\PODInhouse\pod\" + Path.GetFileName(hpf.FileName)))  
                                                (new BLFunctions.CommFunctions()).SavePODUpload(Convert.ToInt32(waybillId), (new CFunctions()).CurrentDateTime());

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

    protected void Btn_DownloadPOD_Click(object sender, EventArgs e)
    {
        if (txtWayBillNo.Text.ToString() != "")
        {
            PODListD.Visible = true;
            NoPODList.Visible = false;
            int i = 0;
            List<ListItem> files = new List<ListItem>();
            string fileName = txtWayBillNo.Text;
             //string[] splitData = fileName.Split(',');
            string[] splitData = fileName.Split(new[] { ',', ' ', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
            bool bDone = false;
            for (i = 0; i <= splitData.Length - 1; i++)
            {

                //string url = "http://122.170.111.196:2020/PODSCANNING//", strResponse = "";             
               // WebRequest request = WebRequest.Create(url + splitData[i].Trim() + ".jpg");
               // HttpWebResponse response = null;
               // try
               // {
                //    response = (HttpWebResponse)request.GetResponse();
               //     strResponse = response.StatusDescription;
               // }
              //  catch { };

              // if (response != null && strResponse == "OK")
              //  {
              //      string filePath = splitData[i].Trim() + ".jpg";
              //      files.Add(new ListItem(Path.GetFileName(filePath), filePath));
              //      bDone = true;
              //  }

                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".png")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".png"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (splitData[i] + "_1").Trim() + ".png")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + (splitData[i] + "_1").Trim() + ".png"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (splitData[i] + "_2").Trim() + ".png")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + (splitData[i] + "_2").Trim() + ".png"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }

                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpg")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpg"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpg")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpg"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpg")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpg"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }

                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpeg")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpeg"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpeg")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpeg"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));                   
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpeg")))
                {
                    string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpeg"));
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));                   
                    bDone = true;
                }
                if (bDone == false)
                {
                    string filePath = (splitData[i].Trim() + " :" + "NO POD Uploaded");
                    //string filePath = ("NO POD Uploaded");
                    files.Add(new ListItem(filePath, ""));                  
                    //bDone = true;
                    continue;
                }
                bDone = false;
            }
            gvPODList.DataSource = files;
            gvPODList.DataBind();
        }
    }

    protected void Btn_ZipFile_Click(object sender, EventArgs e)
    {
        if (txtWayBillNo.Text.ToString() != "")
        {
            using (ZipFile zip = new ZipFile())
            {
                zip.AlternateEncodingUsage = ZipOption.AsNecessary;
                zip.AddDirectoryByName("Files");
                int i = 0;
                string fileName = txtWayBillNo.Text;
                string[] splitData = fileName.Split(new[] { ',', ' ', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                bool bDone = false;
                for (i = 0; i <= splitData.Length - 1; i++)
                {

                    //string url = "http://122.170.111.196:2020/PODSCANNING//", strResponse = "";
                    //WebRequest request = WebRequest.Create(url + splitData[i].Trim() + ".jpg");
                    //HttpWebResponse response = null;
                    //try
                    //{
                    //    response = (HttpWebResponse)request.GetResponse();
                    //    strResponse = response.StatusDescription;
                    //}
                    //catch { };

                    //if (response != null && strResponse == "OK")
                    //{
                    //   // string filePath = (splitData[i].Trim() + ".jpg");
                    //    string filePath = Path.GetFileName("122.170.111.196:2020/PODSCANNING//" + splitData[i].Trim() + ".png");
                    //    zip.AddFile("122.170.111.196:2020/PODSCANNING//" + filePath,"Files");
                    //    bDone = true;
                    //}

                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".png")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".png"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (splitData[i] + "_1").Trim() + ".png")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + (splitData[i] + "_1").Trim() + ".png"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (splitData[i] + "_2").Trim() + ".png")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + (splitData[i] + "_2").Trim() + ".png"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }

                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpg"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpg"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpg"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }

                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpeg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpeg"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpeg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpeg"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpeg")))
                    {
                        string filePath = Path.GetFileName(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpeg"));
                        zip.AddFile(Server.MapPath(@"..//pod//") + filePath, "Files");
                        bDone = true;
                    }
                    if (bDone == false)
                    {
                        continue;
                    }
                    bDone = false;
                }
                Response.Clear();
                Response.BufferOutput = false;
                string zipName = String.Format("Zip_{0}.zip", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"));
                Response.ContentType = "application/zip";
                Response.AddHeader("content-disposition", "attachment; filename=" + zipName);
                zip.Save(Response.OutputStream);
                Response.End();

            } //using zip          
        }
    }

    protected void Btn_NotUploadedPOD_Click(object sender, EventArgs e)
    {
        if (txtWayBillNo.Text.ToString() != "")
        {
            PODListD.Visible = false;
            NoPODList.Visible = true;
            List<ListItem> List_files = new List<ListItem>();
            int i = 0;
            string fileName = txtWayBillNo.Text;
            string[] splitData = fileName.Split(new[] { ',', ' ', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
            bool bDone = false;
            for (i = 0; i <= splitData.Length - 1; i++)
            {
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".png")))
                {
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (splitData[i] + "_1").Trim() + ".png")))
                {
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + (splitData[i] + "_2").Trim() + ".png")))
                {
                    bDone = true;
                }

                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpg")))
                {
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpg")))
                {
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpg")))
                {
                    bDone = true;
                }

                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + ".jpeg")))
                {
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_1" + ".jpeg")))
                {
                    bDone = true;
                }
                if (System.IO.File.Exists(Server.MapPath(@"..//pod//" + splitData[i].Trim() + "_2" + ".jpeg")))
                {
                    bDone = true;
                }
                if (bDone == false)
                {
                    string filePath = (splitData[i].Trim());
                    List_files.Add(new ListItem(filePath, ""));
                    continue;
                }
                bDone = false;
            }
            GvPODNotUploadedList.DataSource = List_files;
            GvPODNotUploadedList.DataBind();
        }
    }
}