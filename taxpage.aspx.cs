using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class taxpage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
        Uri u = new Uri(@"https://einvapi.charteredinfo.com/");
        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(u);
        HttpWebResponse res = (HttpWebResponse)req.GetResponse();
        System.IO.Stream st = res.GetResponseStream();
        System.IO.StreamReader sr = new System.IO.StreamReader(st);
        string body = sr.ReadToEnd();
        lblResponse.Text = body;
    }
}