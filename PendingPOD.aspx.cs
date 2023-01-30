using System;
using System.IO;
using System.Data;
/*using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;*/
using BLFunctions; 

public partial class PendingPOD : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRefreshList_Click(object sender, EventArgs e)
    {
        //lblFileName.Text = Server.MapPath(@"..//pod"); 
        string fileName; 
        string[] files = Directory.GetFiles(Server.MapPath(@"..//pod//"), "*.*", SearchOption.TopDirectoryOnly);
        /*gvPODList.AutoGenerateColumns = true; 
        gvPODList.DataSource = files;
        gvPODList.DataBind();*/
        foreach(string file in files)
        {
            //Get the File Name 
            fileName = Path.GetFileNameWithoutExtension(file); 
            lblFileName.Text += ", " + fileName;
            (new CommFunctions()).setPODUpload(fileName);
        }
    }

    protected void btnPendingPODListBranchWise_Click(object sender, EventArgs e)
    {
        DataTable dt = (new CommFunctions()).GetPendingPODCount() ;
        gvPODList.AutoGenerateColumns = true;
        gvPODList.DataSource = dt;
        gvPODList.DataBind();
    }
}