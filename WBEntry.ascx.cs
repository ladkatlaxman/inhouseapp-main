using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class WBEntry : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SetInitialRowItem();
        GetPrevWayBillNo();
        //CurrentWaybillNo();
        SetInitialRowItemForInvoice();
    }

    public void GetPrevWayBillNo()
    {
        IDataReader reader = (new PickReqFunctions().GetPrevWayBillNo(Convert.ToInt32(Session["branchID"].ToString())));
        while (reader.Read())
        {
            hfWaybillID.Value = reader["waybillID"].ToString();
            btnView.Text = reader["wayBillNo"].ToString();
            lnkPrevWayBill.NavigateUrl = "WayBillPrint.aspx?WayBillNo=" + Convert.ToString(reader["waybillNo"]);
            lblCurrentWBNo.Text = reader["wayBillNo"].ToString();
            Txt_WaybillNo.Text = (Convert.ToInt32(reader["wayBillNo"]) + 1).ToString();
        }
    }
    public void CurrentWaybillNo()
    {
        IDataReader reader = (new PickReqFunctions().CurrentWaybillSeries(Convert.ToInt32(Session["branchID"].ToString())));
        while (reader.Read())
        {
            lblCurrentWBNo.Text = reader["currentNo"].ToString(); 
        }
    }

    //Add First Row Or Clear Row in Dynamically For Add Waybill CFT Code
    private void SetInitialRowItem()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.AddRange(new DataColumn[19] { new DataColumn("MaterialID", typeof(Int32)), new DataColumn("MaterialType", typeof(String)),
                                                new DataColumn("PackageID", typeof(Int32)), new DataColumn("PackageType", typeof(String)),
                                                new DataColumn("Unit", typeof(String)), new DataColumn("Length", typeof(Double)),
                                                new DataColumn("Breadth", typeof(Double)), new DataColumn("Height", typeof(Double)),
                                                new DataColumn("CFT", typeof(Int32)), new DataColumn("ActWeight", typeof(Double)),new DataColumn("ChargeWeight", typeof(Double)),
                                                new DataColumn("NoOfPackage", typeof(Int32)), new DataColumn("NoOfInnerPackage", typeof(Int32)),
                                                new DataColumn("InvoiceNo", typeof(String)), new DataColumn("InvoiceDate", typeof(String)),
                                                new DataColumn("InvoiceValue", typeof(Double)),new DataColumn("EWaybillNo", typeof(String)),
                                                new DataColumn("EWaybillDate", typeof(String)),new DataColumn("EWaybillExpiryDate", typeof(String))
                                                });
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        GV_WaybillDetail.DataSource = dt;
        GV_WaybillDetail.DataBind();
    }
    //Add First Row Or Clear Row in Dynamically For Add Waybill CFT Code
    private void SetInitialRowItemForInvoice()
    {
        DataTable dt = new DataTable();
        DataRow dr = null;
        dt.Columns.AddRange(new DataColumn[3] { new DataColumn("RateID", typeof(Int32)), new DataColumn("RateType", typeof(String)),
                                                new DataColumn("Charges", typeof(Double))}); //, new DataColumn("Remark", typeof(String))
        //ViewState["CurrentTable"] = dt;
        dr = dt.NewRow();
        dt.Rows.Add(dr);
        GV_Invoice.DataSource = dt;
        GV_Invoice.DataBind();
    }
}