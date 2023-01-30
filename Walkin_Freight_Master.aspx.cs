using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLProperties;
public partial class OPERATIONS_Walkin_Freight : System.Web.UI.Page
{
    string strPreviousRowID = string.Empty;
    int intSubTotalIndex = 1;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillGrid();
            (new CFunctions()).dropdwnlist(null, null, Ddl_PopupRateType, null, "RateType", "Id", ((new RateCardFunctions()).getRateCardType()));
        }
    }
    public void fillGrid()
        {
        DataTable dt = (new RateCardFunctions()).ViewData();
        gridView.DataSource = dt;
        gridView.DataBind();
    }
    public void ClearAll()
    {      
        Ddl_PopupRateType.SelectedIndex = 0;
        Txt_PopupFromWeight.Text = "";
        Txt_PopupToWeight.Text = "";
        Txt_PopupFromDistance.Text = "";
        Txt_PopupToDistance.Text = "";
        Txt_RateValue.Text = "";
    }
    protected void gridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                strPreviousRowID = DataBinder.Eval(e.Row.DataItem, "RateTypeID").ToString();
            }
            catch { }
        }
    }

    protected void gridView_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;

        bool IsSubTotalRowNeedToAdd = false;

        if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "RateTypeID") != null))
            if (strPreviousRowID != DataBinder.Eval(e.Row.DataItem, "RateTypeID").ToString())
                IsSubTotalRowNeedToAdd = true;

        if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "RateTypeID") == null))
        {
            IsSubTotalRowNeedToAdd = true;
            intSubTotalIndex = 0;
        }
        if ((strPreviousRowID == string.Empty) && (DataBinder.Eval(e.Row.DataItem, "RateTypeID") != null))
        {
            GridView grdView = (GridView)sender;

            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

            TableCell cell = new TableCell();
            cell.Text = "RateType Name : " + DataBinder.Eval(e.Row.DataItem, "RateTypeName").ToString();
            cell.HorizontalAlign = HorizontalAlign.Center;
            cell.Style.Add("font-weight", "bold");
            cell.ColumnSpan = e.Row.Cells.Count;
            //cell.CssClass = "GroupHeaderStyle";
            row.Cells.Add(cell);

            grdView.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
            intSubTotalIndex++;
        }
        if (IsSubTotalRowNeedToAdd)
        {
            #region Adding Sub Total Row
            GridView grdViewOrders = (GridView)sender;
             
            // Creating a Row
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

            //Adding Total Cell 
            TableCell cell = new TableCell();

            //Adding the Row at the RowIndex position in the Grid
            grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
            intSubTotalIndex++;
            #endregion

            #region Adding Next Group Header Details
            if (DataBinder.Eval(e.Row.DataItem, "RateTypeID") != null)
            {
                row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);

                cell = new TableCell();
                cell.Text = "RateType Name : " + DataBinder.Eval(e.Row.DataItem, "RateTypeName").ToString();
                cell.ColumnSpan = e.Row.Cells.Count;
                cell.HorizontalAlign = HorizontalAlign.Center;
                cell.Style.Add("font-weight", "bold");
                //cell.CssClass = "GroupHeaderStyle";
                row.Cells.Add(cell);

                grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                intSubTotalIndex++;
            }
            #endregion
        }
    }

    protected void Btn_PopupRateSubmit_Click(object sender, EventArgs e)
    {

        RateCardDetails rcd = new RateCardDetails();
        rcd.RateTypeId = Convert.ToInt32(Ddl_PopupRateType.SelectedValue);
        rcd.ContractID = 0;
        rcd.WeightFrom = Convert.ToInt32(Txt_PopupFromWeight.Text);
        rcd.WeightTo = Convert.ToInt32(Txt_PopupToWeight.Text);
        rcd.DistanceFrom = Convert.ToInt32(Txt_PopupFromDistance.Text);
        rcd.DistanceTo = Convert.ToInt32(Txt_PopupToDistance.Text);
        rcd.RateValue = Convert.ToDecimal(Txt_RateValue.Text);
        rcd.EntryDate = new CFunctions().CurrentDateTime();
        rcd.ExpiryDate = Convert.ToDateTime("2050-12-31 00:00:00.000");      
        bool alertMsg = (new RateCardFunctions()).SaveRateCardDetails(rcd);

        if (alertMsg)
        {
            (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
            ClearAll();
            fillGrid();
        }
        
    }
}