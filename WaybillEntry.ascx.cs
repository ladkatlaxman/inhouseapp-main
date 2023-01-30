using System;
using System.Data;
public partial class WaybillEntry : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SetInitialRowItem();
       // GetPrevWayBillNo(); 
       // CurrentWaybillNo();
        SetInitialRowItemForInvoice();
    }
    public void GetPrevWayBillNo()
    {
        IDataReader reader = (new PickReqFunctions().GetPrevWayBillNo(Convert.ToInt32(Session["branchID"].ToString())));
        while (reader.Read())
        {
            hfWaybillID.Value = Convert.ToString(reader["waybillID"]);
            btnView.Text = Convert.ToString(reader["wayBillNo"]);
        }
    }
    public void CurrentWaybillNo()
    {
        int count = 0;
        int sum = 0;
        IDataReader reader = (new PickReqFunctions().CurrentWaybillSeries(Convert.ToInt32(Session["branchID"].ToString())));
        while (reader.Read())
        {
            count++;
            sum = Convert.ToInt32(reader["currentNo"]);
            if (count == 1)
            {
                Label1.Text = "";
                Label1.Text = Label1.Text + sum;
            }
            else
                Label1.Text = Label1.Text + "," + sum;
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
        //ViewState["CurrentTable"] = dt;
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