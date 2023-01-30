using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.IO; 

public partial class MobileApp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] filePaths = Directory.GetFiles(Server.MapPath(@"MobileApp"));
        List<ListItem> files = new List<ListItem>();
        foreach (string filePath in filePaths)
        {
            files.Add(new ListItem(Path.GetFileName(filePath), Path.GetFileName(filePath)));
        }
        GridView1.DataSource = files;
        GridView1.DataBind();
    }
    protected void DownloadFile(object sender, EventArgs e)
    {
        string filePath = (sender as LinkButton).CommandArgument;
        Response.ContentType = ContentType;
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePath));
        Response.WriteFile(filePath);
        Response.End();
    }
}