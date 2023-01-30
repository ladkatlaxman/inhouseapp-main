using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;

public partial class VDTReport : System.Web.UI.Page 
{ 
    protected void Page_Load(object sender, EventArgs e) 
    { 
        DataTable dt = (new CommFunctions()).viewVDTReport(); 
        gvFirstGrid.DataSource = dt; 
        gvFirstGrid.DataBind(); 
    } 
} 