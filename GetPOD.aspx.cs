using BLProperties;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.IO; 
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

public partial class GetPOD : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string filename = @"http://45.250.248.130:40/pod/" + Request.QueryString["wb"].ToString(); 
            bool result = false; 
            result = getFile(filename, "jpg"); 
            if (!result) result = getFile(filename, "jpeg"); 
            filename = @"http://45.250.248.130:40/podMobile/" + Request.QueryString["wb"].ToString();
            if (!result) result = getFile(filename, "jpg"); 
            if (!result) result = getFile(filename, "jpeg");
        }
        catch(Exception ex)
        {
            lblPOD.Text = ex.Message;
        }
    }

    private bool getFile(string filename, string extension)
    {
        filename = filename + "." + extension;
        // Check if File Exists 
        //var url = @"http://45.250.248.130:40/pod/3067045.jpeg";
        var request = (HttpWebRequest)WebRequest.Create(filename);
        request.Method = "HEAD";
        try
        {
            byte[] data;
            using (WebClient client = new WebClient())
            {
                data = client.DownloadData(filename);
            }
            File.WriteAllBytes(Server.MapPath("pod") + @"\POD.jpg", data);
            Response.ContentType = "image/jpeg"; 
            Server.Transfer(@"\pod\POD.jpg");
            return true;
        }
        catch (WebException ex)
        {
            /* A WebException will be thrown if the status of the response is not `200 OK` */
            lblPOD.Text = ex.Message;
            return false;
        }
    }
}