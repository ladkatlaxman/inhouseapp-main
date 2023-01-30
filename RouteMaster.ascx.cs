using System;
using System.Data;
using System.Web.UI;
public partial class RouteMaster : UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TxtBranch1.Attributes.Add("disabled", "disabled");
        Txt_MapDistance.Attributes.Add("disabled", "disabled");
        txtTotalDistance.Attributes.Add("disabled", "disabled");
        txtTotalMapDistance.Attributes.Add("disabled", "disabled");
        DataTable dt = new DataTable();
        dt.Columns.Add(new DataColumn("fromBranchId", typeof(Int32)));
        dt.Columns.Add(new DataColumn("fromBranch", typeof(String)));
        dt.Columns.Add(new DataColumn("toBranchId", typeof(Int32)));
        dt.Columns.Add(new DataColumn("toBranch", typeof(String)));
        dt.Columns.Add(new DataColumn("distance", typeof(Decimal)));
        dt.Columns.Add(new DataColumn("mapDistance", typeof(Decimal)));
        dt.Rows.Add();
        GV_RouteDetail.DataSource = dt;
        GV_RouteDetail.DataBind();
    }
}