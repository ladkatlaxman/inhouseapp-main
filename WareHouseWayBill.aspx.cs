using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WareHouseWayBill : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if (HiddenField_Btn_Search.Value == "1")
        {
            //SearchingDataInGridview();
            HiddenField_Btn_Search.Value = "";
        }
    }

    protected void gridViewPickupRequestDetail_Sorting(object sender, GridViewSortEventArgs e)
    {
        //FillGrid(e.SortExpression);
    }
    protected void gridViewPickupRequestDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_ViewWaybillDetail.PageIndex = e.NewPageIndex;
        //FillGrid();
    }
}