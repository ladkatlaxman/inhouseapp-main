using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions; 

public partial class VendorInvoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        btnCalculate.Enabled = false; 
        try
        {
            String strVendorid = Context.Items["VendorId"].ToString();
            String strVendorTrips = Context.Items["VehicleRequestIds"].ToString();
            txtFromDate.Text = Context.Items["FromDate"].ToString();
            txtToDate.Text = Context.Items["ToDate"].ToString();
            hdVendorTrips.Value = Context.Items["VehicleRequestIds"].ToString(); 
            IDataReader drVendor = (new VehicleRequestFunction()).GetVendorDetails(strVendorid);

            txtInvoiceNo.Text = "<New>"; 
            txtInvoiceDate.Text = DateTime.Now.ToString("dd/MM/yyyy"); 
            //txtVendorName.Text += " : " + Context.Items["VehicleRequestIds"].ToString();
            while(drVendor.Read())
            {
                hVendorId.Value = drVendor["VendorId"].ToString();
                txtVendorName.Text = drVendor["VendorName"].ToString();
            }

            IDataReader dr = (new VehicleRequestFunction()).CreateVendorInvoice(strVendorTrips); 
            while (dr.Read())
            { 
                txtNoOfDays.Text = dr["NoOfDays"].ToString(); 
                txtNetAmount.Text = dr["NetValue"].ToString(); 
                txtNETWeight.Text = dr["NetWeight"].ToString(); 
                txtNoOfPieces.Text = dr["NoOfPCS"].ToString();
            } 
            btnCalculate.Enabled = true;

            gvFirstGrid.DataSource = (new VehicleRequestFunction()).ViewVehicleVendorRequests("", "", strVendorTrips, "", "", "", "");
            gvFirstGrid.DataBind();
        }
        catch { }; 
    }
    private string getInvoiceHTML()
    {
        //Get the String of HTML Text 
        string strHTML = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("/Vendorbill.html"));
        int iSrNo = 0;
        //Update the Contents of HTML Content 
        strHTML = strHTML.Replace(@"@VendorName", txtVendorName.Text);
        strHTML = strHTML.Replace(@"@VendorAddress", "").Replace("@FromDate", txtFromDate.Text).Replace("@ToDate", txtToDate.Text).Replace("@TotalWeight", txtNETWeight.Text).Replace("@TotalAmount", txtNetAmount.Text);
        StringBuilder strRows = new StringBuilder();
        foreach (GridViewRow gvRow in gvFirstGrid.Rows)
        {
            strRows.Append(@"<tr>");
            strRows.Append(@"<td>" + ++iSrNo + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[1].Text + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[2].Text + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[3].Text + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[4].Text + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[5].Text.Replace("PickUp/Delivery", "NA")  + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[6].Text + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[7].Text + "</td>");
            strRows.Append(@"<td>" + gvFirstGrid.Rows[gvRow.RowIndex].Cells[8].Text + "</td>");
            strRows.Append(@"<td>" + "" + "</td>");
            //strRows.Append(@"<td>" + ((TextBox)(gvFirstGrid.Rows[gvRow.RowIndex].FindControl("txtKMS"))).Text + "</td>"); 
            strRows.Append(@"<td>" + ((TextBox)(gvFirstGrid.Rows[gvRow.RowIndex].FindControl("txtAmount"))).Text + "</td>");
            strRows.Append(@"</tr>");
        }
        strHTML = strHTML.Replace("@trBillDetails", strRows.ToString());
        return strHTML; 
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        string strHTML = getInvoiceHTML(); 
        Response.AppendHeader("content-disposition", "attachment;filename=ExportedHtml.xls");
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        this.EnableViewState = false;
        Response.Write(strHTML);
        Response.End();
    }

    protected void lnkWayBills_Click(object sender, EventArgs e)
    {
        String strVendorTrips = hdVendorTrips.Value.ToString(); //Context.Items["VehicleRequestIds"].ToString();
        gvWayBills.DataSource = (new VehicleRequestFunction()).ViewVehicleVendorWayBills(strVendorTrips);
        gvWayBills.DataBind(); 
        Response.ContentType = "application/x-msexcel";
        Response.AddHeader("Content-Disposition", "attachment;filename=VendorWayBills.xls");
        Response.ContentEncoding = Encoding.UTF8;
        StringWriter tw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        gvWayBills.GridLines = GridLines.Both;
        gvWayBills.HeaderStyle.Font.Bold = true;
        gvWayBills.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

}