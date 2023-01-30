using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PODdownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect(@"http://122.170.111.196:4000/POD.aspx");
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
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
            string[] splitData = fileName.Split(',');
            bool bDone = false;
            for (i = 0; i <= splitData.Length - 1; i++)
            {
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
                string[] splitData = fileName.Split(',');
                bool bDone = false;
                for (i = 0; i <= splitData.Length - 1; i++)
                {
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
                string[] splitData = fileName.Split(',');
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