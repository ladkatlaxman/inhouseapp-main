using System;
//using System.Collections.Generic;
using System.Data;
//using System.Linq;
using System.Text; 
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using BLProperties;
using BLFunctions; 
/*using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.xml.simpleparser;*/
//using iTextSharp.text.html;
//using System.Data.SqlClient;
//using System.Configuration;
public partial class CustomerInvoice : System.Web.UI.Page
{
    string fromfinalDate = "", tofinalDate = "", str;
    int iODAColumn = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request["CustomerId"].ToString() != "")
            {
                hfSearchCustName.Value = Request["CustomerId"].ToString();
                hfBranchId.Value = Request["BranchId"].ToString();
                CustomerHeader custHead = (new PartyCustomerFunctions()).getCustomerDetails(hfSearchCustName.Value, hfBranchId.Value);
                Txt_SearchCustName.Text = custHead.Name;
                txtBranchName.Text = custHead.BranchName;
				hfBranchAddress.Value = custHead.BranchAddress; 
				hfCustomerAddress.Value = custHead.BillingAddress; 
                fromfinalDate = Request["FromDate"].ToString();
                tofinalDate = Request["ToDate"].ToString();
                btnGetWayBills_Click(sender, e);
            }
        }
        catch { }

        if (!IsPostBack)
        {
            try
            {
                if (Request["InvoiceId"].ToString() != null)
                {
                    if (Request["InvoiceId"].ToString() == "-1")
                    {
                        fromfinalDate = System.DateTime.Today.AddDays(-1).ToString(@"dd/MM/yyyy").Replace("-", "/");
                        tofinalDate = System.DateTime.Today.AddDays(-1).ToString(@"dd/MM/yyyy").Replace("-", "/");
                        divInvoiceButtons.Visible = false;
                        btnGetWayBills_Click(sender, e);
                    }
                    else if (Request["InvoiceId"].ToString() == "0")
                    {
                        fromfinalDate = System.DateTime.Today.ToString(@"dd/MM/yyyy").Replace("-", "/");
                        tofinalDate = System.DateTime.Today.ToString(@"dd/MM/yyyy").Replace("-", "/");
                        divInvoiceButtons.Visible = false;
                        btnGetWayBills_Click(sender, e);
                    }
                    else
                    {
                        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", new Date());" + "\n" +
                          "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", new Date());";
                        FIllInvoice();
                    }
                    hdInvoiceId.Value = Request["InvoiceId"].ToString(); 
                }
            }
            catch { }
        }
        else
        {
            if (Txt_FromDate.Text.ToString().Trim() == "") fromfinalDate = "new Date()"; else fromfinalDate = Txt_FromDate.Text.ToString();
            if (Txt_ToDate.Text.ToString().Trim() == "") tofinalDate = "new Date()"; else tofinalDate = Txt_ToDate.Text.ToString();
        }
        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + fromfinalDate + "');" + "\n" +
              "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", '" + tofinalDate + "');";

        CFunctions.setjavascript(CFunctions.javascript + str);

        (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchCustName", "hfSearchCustName", "ReportData.aspx/getCustomerName", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "txtBranchName", "hfBranchId", "RouteMaster.aspx/GetBranch", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    protected void btnGetWayBills_Click(object sender, EventArgs e)
    {
        string strStartDate = Txt_FromDate.Text, strEndDate = Txt_ToDate.Text;
        try
        {
            if (Request["InvoiceId"].ToString() != null)
            {
                if (Request["InvoiceId"].ToString() == "-1" || Request["InvoiceId"].ToString() == "0")
                {
                    strStartDate = fromfinalDate;
                    strEndDate = tofinalDate;
                }
            }
        }
        catch { }
        try
        {
            if (Request["CustomerId"].ToString() != "")
            {
                strStartDate = Request["FromDate"].ToString();
                strEndDate = Request["ToDate"].ToString();
            }
        }
        catch { }

        DataTable dt  = (new BLFunctions.CommFunctions()).ViewInvoiceWayBills(strStartDate, strEndDate, hfSearchCustName.Value.ToString(), "", hfBranchId.Value);

        try
        {
            int totalWeight = Convert.ToInt32(dt.Compute("SUM([Charged Weight])", string.Empty));
            lblWeight.Text = totalWeight.ToString();
        }
        catch { }

        try
        {
            int totalValue = Convert.ToInt32(dt.Compute("SUM([Total])", string.Empty));
            lblValue.Text = totalValue.ToString();

            int cgst = (int)(totalValue * 0.06);
            lblCGST.Text = cgst.ToString();

            int sgst = (int)(totalValue * 0.06);
            lblSGST.Text = sgst.ToString();

            /*int igst = (int)(totalValue * 0.12);*/
            lblIGST.Text = "0"; // igst.ToString();

            int totalInvoice = totalValue + cgst + sgst;
            lblTotalInvoice.Text = totalInvoice.ToString();
        }
        catch { }

        dt.Columns.Add("Refresh"); 
        gvFirstGrid.DataSource = dt; 
        gvFirstGrid.DataBind();
    }

    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //try
        {
            //if (iODAColumn == 0) iODAColumn = GetColumnIndexByName(gvFirstGrid, e, "ODA");
            iODAColumn = 11; 
            string strODA;
            //e.Row.Cells[iODAColumn].Wrap = true; 
            e.Row.Cells[0].Visible = false;     //Hide WayBill Id 
            e.Row.Cells[1].Visible = false;     //Hide Customer Id 
            e.Row.Cells[2].Visible = false;     //Hide Delivery Location Id 
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                strODA = e.Row.Cells[iODAColumn].Text;

                Label lblODA = new Label();
                lblODA.Text = strODA;

                if (strODA != "ODA")
                {
                    //LinkButton lnkAddODA = new LinkButton();
                    ImageButton lnkAddODA = new ImageButton();
                    lnkAddODA.ID = "lnkAddODA";
                    //lnkAddODA.Text = "Set";
                    lnkAddODA.CommandName = "addODA"; 
                    lnkAddODA.ImageUrl = "Images/addODA.bmp";
                    lnkAddODA.Click += LnkAddODA_Click;
                    lnkAddODA.OnClientClick = "return confirm('Are you sure you want to set this as ODA')"; 
                    e.Row.Cells[iODAColumn].Controls.Add(lnkAddODA);
                }
                if (strODA == "ODA")
                {
                    //LinkButton lnkRemODA = new LinkButton();
                    ImageButton lnkRemODA = new ImageButton(); 
                    lnkRemODA.ID = "lnkRemODA";
                    //lnkRemODA.Text = "Rem";
                    lnkRemODA.ImageUrl = "Images/remODA.bmp";
                    lnkRemODA.Click += LnkRemODA_Click;
                    lnkRemODA.OnClientClick = "return confirm('Are you sure you want to Remove this as ODA')";
                    e.Row.Cells[iODAColumn].Controls.Add(lnkRemODA);
                }
                e.Row.Cells[iODAColumn].Controls.Add(lblODA);
                ImageButton lnkReCalculate = new ImageButton();
                lnkReCalculate.ID = "lnkReCalculate";
                lnkReCalculate.ImageUrl = "Images/Refresh.png";
                lnkReCalculate.Click += LnkReCalculate_Click; ;
                e.Row.Cells[e.Row.Cells.Count-1].Controls.Add(lnkReCalculate);
                e.Row.Attributes.Add("class", "WordWrap");
                //Style s = new Style();
                //s.CssClass = "WordWrap"; 
                //e.Row.Cells[iODAColumn].ApplyStyle(s);
            }
        }
        //catch { }
    }

    private void LnkReCalculate_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton lb = (ImageButton)sender;
        GridViewRow row = (GridViewRow)lb.NamingContainer;
        (new BLFunctions.CommFunctions()).CalculateWaybillInvoice(row.Cells[0].Text);
        btnGetWayBills_Click(sender, e);
    }

    private void LnkRemODA_Click(object sender, EventArgs e)
    {
        ImageButton lb = (ImageButton)sender;
        GridViewRow row = (GridViewRow)lb.NamingContainer;
        if (row != null)
        {
            int index = row.RowIndex; //gets the row index selected
        }
        (new Invoicing()).removeCustomerODA(hfSearchCustName.Value.ToString(), row.Cells[2].Text);
        LnkReCalculate_Click(sender, null);
    }

    private void LnkAddODA_Click(object sender, EventArgs e)
    {
        ImageButton lb = (ImageButton)sender;
        GridViewRow row = (GridViewRow)lb.NamingContainer;
        if (row != null)
        {
            int index = row.RowIndex; //gets the row index selected
        }
        (new Invoicing()).setCustomerODA(hfSearchCustName.Value.ToString(), row.Cells[2].Text);
        LnkReCalculate_Click(sender, null);
    }

    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        if (HttpContext.Current.Session["userID"].ToString() != "5")
        {
            //return;
        }
        foreach (GridViewRow grv in gvFirstGrid.Rows)
        {
            (new BLFunctions.CommFunctions()).CalculateWaybillInvoice(grv.Cells[0].Text); 
        }
        btnGetWayBills_Click(sender, e); 
    }

    protected void btnSaveInvoiceValues_Click(object sender, EventArgs e)
    {
        if(HttpContext.Current.Session["userID"].ToString() != "5")
        {
            //return; 
        }

        if (txtInvoiceNo.Text.Trim() == "")
        {
            return; 
        }
        if (hdInvoiceId.Value.ToString() != "") return; 

        string sInvoiceNo = "";

        IDataReader dr = (new BLFunctions.CommFunctions()).SaveWayBillInvoice(txtInvoiceNo.Text, "", hfSearchCustName.Value.ToString(), lblValue.Text, 
                            lblCGST.Text, lblSGST.Text, lblIGST.Text, lblTotalInvoice.Text, hfBranchId.Value.ToString()); 
        while(dr.Read())
        {
            sInvoiceNo = dr[0].ToString(); 
        }    
        hdInvoiceId.Value = sInvoiceNo;

        foreach (GridViewRow grv in gvFirstGrid.Rows)
        {
            (new BLFunctions.CommFunctions()).SaveInvoiceNoINWayBill(grv.Cells[0].Text, sInvoiceNo);
        }
        Response.Redirect("CustomerInvoice.aspx?InvoiceId="+sInvoiceNo);
    }
    private void FIllInvoice()
    {
        divCriteria.Visible = false;
        IDataReader dr = (new BLFunctions.CommFunctions()).ViewInvoiceList(Request["InvoiceId"].ToString());
        while (dr.Read())
        {
            Txt_SearchCustName.Text = dr["Customer Name"].ToString();
            txtInvoiceNo.Text = dr["Invoice No"].ToString();
            lblValue.Text = dr["Total"].ToString();
            lblCGST.Text = dr["CGST"].ToString();
            lblSGST.Text = dr["SGST"].ToString();
            lblIGST.Text = dr["IGST"].ToString();
            lblTotalInvoice.Text = dr["Invoice Total"].ToString();
            txtBranchName.Text = dr["Branch"].ToString();
            hfBranchAddress.Value = dr["address"].ToString();
            hfCustomerAddress.Value = dr["billingAddress"].ToString();
            hfCustomerStatecode.Value = dr["CustStatecode"].ToString();
            hfBranchStateCode.Value = dr["BranchStatecode"].ToString();
        }
        gvFirstGrid.DataSource = (new BLFunctions.CommFunctions()).ViewInvoiceWayBills("", "", "", Request["InvoiceId"].ToString(), "");
        gvFirstGrid.DataBind();
    }

    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Customers.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvFirstGrid.HeaderRow.Style.Add("background-color", "#FFFFFF");
        for (int i = 0; i < gvFirstGrid.HeaderRow.Cells.Count; i++)
        {
            gvFirstGrid.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        gvFirstGrid.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btnInvoice_Click(object sender, EventArgs e)
    {
		string strDate = Txt_FromDate.Text;
        DateTime dt = new DateTime(int.Parse(strDate.Substring(6, 4)), int.Parse(strDate.Substring(3, 2)), int.Parse(strDate.Substring(0, 2))); 

        Table tbl = new Table();

        TableRow tr1 = new TableRow();
        TableCell tc1 = new TableCell();
        tc1.ColumnSpan = 15;
        tc1.HorizontalAlign = HorizontalAlign.Center;
        tc1.Text = "TAX INVOICE";
        tr1.Cells.Add(tc1);
        tc1.BorderWidth = 1;
        tbl.Rows.Add(tr1);

        TableRow tr2 = new TableRow();
        TableCell tc2 = new TableCell();
        tc2.ColumnSpan = 15;
        tc2.HorizontalAlign = HorizontalAlign.Center;
        tc2.Text = "DEXTERS LOGISTICS PRIVATE LIMTIED";
        tr2.Cells.Add(tc2);
        tc2.BorderWidth = 1;
        tbl.Rows.Add(tr2);

        TableRow tr3 = new TableRow();
        TableCell tc3 = new TableCell();
        tc3.ColumnSpan = 15;
        tc3.HorizontalAlign = HorizontalAlign.Center;
        tc3.Text = "<strong>Corporate Office</strong>: Unit no 401/402 Kumar Business Centre, Bund Gardan Road, Sangamwadi, Pune - 411001";
        tc3.BorderWidth = 1;
        tr3.Cells.Add(tc3);
        tbl.Rows.Add(tr3);

        TableRow tr4 = new TableRow();
        TableCell tc4 = new TableCell();
        tc4.ColumnSpan = 15;
        tc4.HorizontalAlign = HorizontalAlign.Center;
        tc4.Text = "<strong>Branch Address :</strong> " + hfBranchAddress.Value;
        tc4.BorderWidth = 1;
        tr4.Cells.Add(tc4);
        tbl.Rows.Add(tr4);

        TableRow tr4p5 = new TableRow();
        TableCell tc4p5_1 = new TableCell();
        tc4p5_1.ColumnSpan = 7;
        tc4p5_1.HorizontalAlign = HorizontalAlign.Center;
        tc4p5_1.Text = "<strong>Customer Address</strong>";
        tc4p5_1.BorderWidth = 1;
        tr4p5.Cells.Add(tc4p5_1);

        TableCell tc4p5_2 = new TableCell();
        tc4p5_2.ColumnSpan = 8;
        tc4p5_2.HorizontalAlign = HorizontalAlign.Center;
        tc4p5_2.Text = "<strong>Supplier Details</strong>";
        tc4p5_2.BorderWidth = 1;
        tr4p5.Cells.Add(tc4p5_2);
        tbl.Rows.Add(tr4p5);

        TableRow tr6 = new TableRow();
        //Customer Name
        TableCell tc6A = new TableCell();
        tc6A.ColumnSpan = 10;
        tc6A.HorizontalAlign = HorizontalAlign.Left;
        tc6A.BorderWidth = 1;
        tc6A.Text = Txt_SearchCustName.Text;
        tr6.Cells.Add(tc6A);

        TableCell tc6B = new TableCell();
        tc6B.ColumnSpan = 3;
        tc6B.HorizontalAlign = HorizontalAlign.Left;
        tc6B.Text = "Invoice No";
        tc6B.BorderWidth = 1;
        tr6.Cells.Add(tc6B);

        TableCell tc6C = new TableCell();
        tc6C.ColumnSpan = 2;
        tc6C.HorizontalAlign = HorizontalAlign.Left;
        tc6C.Text = txtInvoiceNo.Text;
        tc6C.BorderWidth = 1;
        tr6.Cells.Add(tc6C);
        tbl.Rows.Add(tr6);

        TableRow tr7 = new TableRow();
        /*TableCell tc7A = new TableCell();
        tc7A.ColumnSpan = 10;
        tc7A.HorizontalAlign = HorizontalAlign.Left;
        tc7A.BorderWidth = 1;
        tc7A.Text = "";
        tr7.Cells.Add(tc7A);*/
        TableCell tc7A = new TableCell();
        tc7A.ColumnSpan = 10;
        tc7A.HorizontalAlign = HorizontalAlign.Left;
        tc7A.RowSpan = 4; 
        tc7A.BorderWidth = 1;
        tc7A.Text = hfCustomerAddress.Value;
        tr7.Cells.Add(tc7A);

        TableCell tc7B = new TableCell();
        tc7B.ColumnSpan = 3;
        tc7B.HorizontalAlign = HorizontalAlign.Left;
        tc7B.Text = "Invoice Date";
        tc7B.BorderWidth = 1;
        tr7.Cells.Add(tc7B);

        TableCell tc7C = new TableCell();
        tc7C.ColumnSpan = 2;
        tc7C.HorizontalAlign = HorizontalAlign.Left;
        tc7C.Text = "";
        tc7C.BorderWidth = 1;
        tr7.Cells.Add(tc7C);
        tbl.Rows.Add(tr7);

        TableRow tr8 = new TableRow();
        /*TableCell tc8A = new TableCell();
        tc8A.ColumnSpan = 10;
        tc8A.HorizontalAlign = HorizontalAlign.Left;
        tc8A.BorderWidth = 1;
        tc8A.Text = "";
        tr8.Cells.Add(tc8A);*/

        TableCell tc8B = new TableCell();
        tc8B.ColumnSpan = 3;
        tc8B.HorizontalAlign = HorizontalAlign.Left;
        tc8B.Text = "Period of Supply";
        tc8B.BorderWidth = 1;
        tr8.Cells.Add(tc8B);

        TableCell tc8C = new TableCell();
        tc8C.ColumnSpan = 2;
        tc8C.HorizontalAlign = HorizontalAlign.Left;
        tc8C.Text = "";
        tc8C.BorderWidth = 1;
        tr8.Cells.Add(tc8C);
        tbl.Rows.Add(tr8);

        TableRow tr9 = new TableRow();
        /*TableCell tc9A = new TableCell();
        tc9A.ColumnSpan = 10;
        tc9A.HorizontalAlign = HorizontalAlign.Left;
        tc9A.BorderWidth = 1;
        tc9A.Text = "";
        tr9.Cells.Add(tc9A);*/

        TableCell tc9B = new TableCell();
        tc9B.ColumnSpan = 3;
        tc9B.HorizontalAlign = HorizontalAlign.Left;
        tc9B.Text = "Due Date";
        tc9B.BorderWidth = 1;
        tr9.Cells.Add(tc9B);

        TableCell tc9C = new TableCell();
        tc9C.ColumnSpan = 2;
        tc9C.HorizontalAlign = HorizontalAlign.Left;
        tc9C.Text = "";
        tc9C.BorderWidth = 1;
        tr9.Cells.Add(tc9C);
        tbl.Rows.Add(tr9);

        TableRow tr10 = new TableRow();
        /*TableCell tc10A = new TableCell();
        tc10A.ColumnSpan = 10;
        tc10A.HorizontalAlign = HorizontalAlign.Left;
        tc10A.BorderWidth = 1;
        tc10A.Text = "";
        tr10.Cells.Add(tc10A);*/

        TableCell tc10B = new TableCell();
        tc10B.ColumnSpan = 3;
        tc10B.HorizontalAlign = HorizontalAlign.Left;
        tc10B.Text = "Place of Supply of Service";
        tc10B.BorderWidth = 1;
        tr10.Cells.Add(tc10B);

        TableCell tc10C = new TableCell();
        tc10C.ColumnSpan = 2;
        tc10C.HorizontalAlign = HorizontalAlign.Left;
        tc10C.Text = txtBranchName.Text;
        tc10C.BorderWidth = 1;
        tr10.Cells.Add(tc10C);
        tbl.Rows.Add(tr10);

        TableRow trStateCode = new TableRow();
        TableCell tcSC1 = new TableCell();
        tcSC1.ColumnSpan = 5;
        tcSC1.HorizontalAlign = HorizontalAlign.Left;
        tcSC1.Text = "State Code as per GST : ";
        tcSC1.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC1);

        TableCell tcSC2 = new TableCell();
        tcSC2.ColumnSpan = 5;
        tcSC2.HorizontalAlign = HorizontalAlign.Center;
        tcSC2.Text = hfCustomerStatecode.Value;
        tcSC2.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC2);

        TableCell tcSC3 = new TableCell();
        tcSC3.ColumnSpan = 3;
        tcSC3.HorizontalAlign = HorizontalAlign.Left;
        tcSC3.Text = "State code as per GST : ";
        tcSC3.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC3);

        TableCell tcSC4 = new TableCell();
        tcSC4.ColumnSpan = 2;
        tcSC4.HorizontalAlign = HorizontalAlign.Center;
        tcSC4.Text = hfBranchStateCode.Value;
        tcSC4.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC4);

        tbl.Rows.Add(trStateCode);

        TableRow tr5 = new TableRow();
        TableCell tc5a = new TableCell();
        tc5a.ColumnSpan = 6;
        tc5a.HorizontalAlign = HorizontalAlign.Center;
        tc5a.Text = "GSTIN / Unique Id :";
        tc5a.BorderWidth = 1;
        tr5.Cells.Add(tc5a);
        
        TableCell tc5b = new TableCell();
        tc5b.ColumnSpan = 4;
        tc5b.HorizontalAlign = HorizontalAlign.Center;
        tc5b.Text = "";
        tc5b.BorderWidth = 1;
        tr5.Cells.Add(tc5b);

        TableCell tc5c = new TableCell();
        tc5c.ColumnSpan = 3;
        tc5c.HorizontalAlign = HorizontalAlign.Center;
        tc5c.Text = "GSTIN :";
        tc5c.BorderWidth = 1;
        tr5.Cells.Add(tc5c);

        TableCell tc5d = new TableCell();
        tc5d.ColumnSpan = 2;
        tc5d.HorizontalAlign = HorizontalAlign.Center;
        tc5d.Text = "24AADCD5211A1ZJ";
        tc5d.BorderWidth = 1;
        tr5.Cells.Add(tc5d);

        tbl.Rows.Add(tr5);

        TableRow tr5A = new TableRow();
        TableCell tc6a = new TableCell();
        tc6a.ColumnSpan = 6;
        tc6a.HorizontalAlign = HorizontalAlign.Center;
        tc6a.Text = "PAN No Buyer :";
        tc6a.BorderWidth = 1;
        tr5A.Cells.Add(tc6a);

        TableCell tc6b = new TableCell();
        tc6b.ColumnSpan = 4;
        tc6b.HorizontalAlign = HorizontalAlign.Center;
        tc6b.Text = "";
        tc6b.BorderWidth = 1;
        tr5A.Cells.Add(tc6b);

        TableCell tc6c = new TableCell();
        tc6c.ColumnSpan = 3;
        tc6c.HorizontalAlign = HorizontalAlign.Center;
        tc6c.Text = "PAN :";
        tc6c.BorderWidth = 1;
        tr5A.Cells.Add(tc6c);

        TableCell tc6d = new TableCell();
        tc6d.ColumnSpan = 2;
        tc6d.HorizontalAlign = HorizontalAlign.Center;
        tc6d.Text = "AADCD5211A";
        tc6d.BorderWidth = 1;
        tr5A.Cells.Add(tc6d);

        tbl.Rows.Add(tr5A);

        TableRow tr5B = new TableRow();
        TableCell tc7a = new TableCell();
        tc7a.ColumnSpan = 6;
        tc7a.HorizontalAlign = HorizontalAlign.Center;
        tc7a.Text = "SAC/HSN Code	";
        tc7a.BorderWidth = 1;
        tr5B.Cells.Add(tc7a);

        TableCell tc7b = new TableCell();
        tc7b.ColumnSpan = 4;
        tc7b.HorizontalAlign = HorizontalAlign.Center;
        tc7b.Text = "996511	";
        tc7b.BorderWidth = 1;
        tr5B.Cells.Add(tc7b);

        TableCell tc7c = new TableCell();
        tc7c.ColumnSpan = 3;
        tc7c.HorizontalAlign = HorizontalAlign.Center;
        tc7c.Text = "CIN :";
        tc7c.BorderWidth = 1;
        tr5B.Cells.Add(tc7c);

        TableCell tc7d = new TableCell();
        tc7d.ColumnSpan = 2;
        tc7d.HorizontalAlign = HorizontalAlign.Center;
        tc7d.Text = "U63010PN2010PTC136886"; 
        tc7d.BorderWidth = 1;
        tr5B.Cells.Add(tc7d);

        tbl.Rows.Add(tr5B);

        TableRow tr11 = new TableRow();
        TableCell tc11A = new TableCell();
        tc11A.ColumnSpan = 10;
        tc11A.HorizontalAlign = HorizontalAlign.Left;
        tc11A.BorderWidth = 1;
        tc11A.Text = "Service Description: Transportation Services (GTA)";
        tr11.Cells.Add(tc11A);

/*        TableCell tc11B = new TableCell();
        tc11B.ColumnSpan = 4;
        tc11B.HorizontalAlign = HorizontalAlign.Left;
        tc11B.Text = "HSN/SAC : 996511";
        tc11B.BorderWidth = 1;
        tr11.Cells.Add(tc11B);*/

        TableCell tc11C = new TableCell();
        tc11C.ColumnSpan = 5;
        tc11C.HorizontalAlign = HorizontalAlign.Left;
        tc11C.Text = "Tax is payable on Reverse Charge : No";
        tc11C.BorderWidth = 1;
        tr11.Cells.Add(tc11C);
        tbl.Rows.Add(tr11);
		
        TableRow tr11T = new TableRow();
        TableCell tc11TA = new TableCell();
        tc11TA.ColumnSpan = 2;
        tc11TA.HorizontalAlign = HorizontalAlign.Left;
        tc11TA.BorderWidth = 1;
        tc11TA.Text = "Sr No.";
        tr11T.Cells.Add(tc11TA);
        TableCell tc11TB = new TableCell();
        tc11TB.ColumnSpan = 11;
        tc11TB.HorizontalAlign = HorizontalAlign.Left;
        tc11TB.BorderWidth = 1;
        tc11TB.Text = "Description of the Goods";
        tr11T.Cells.Add(tc11TB);
        TableCell tc11TC = new TableCell();
        tc11TC.ColumnSpan = 2;
        tc11TC.HorizontalAlign = HorizontalAlign.Center;
        tc11TC.Text = "Total Freight";
        tc11TC.BorderWidth = 1;
        tr11T.Cells.Add(tc11TC);
        tbl.Rows.Add(tr11T);

        TableRow tr11T1 = new TableRow();
        TableCell tc11T1A = new TableCell();
        tc11T1A.ColumnSpan = 2;
        tc11T1A.HorizontalAlign = HorizontalAlign.Left;
        tc11T1A.BorderWidth = 1;
        tc11T1A.Text = "1.";
        tr11T1.Cells.Add(tc11T1A);
        TableCell tc11T1B = new TableCell();
        tc11T1B.ColumnSpan = 11;
        tc11T1B.HorizontalAlign = HorizontalAlign.Left;
        tc11T1B.BorderWidth = 1;

        tc11T1B.Text = "Secondary Freight Charges for the month " + dt.ToString("MMMM") + @"' " + dt.ToString("yyyy") + " (As per Annexture attach)";
        tr11T1.Cells.Add(tc11T1B);
        TableCell tc11T1C = new TableCell();
        tc11T1C.ColumnSpan = 2;
        tc11T1C.HorizontalAlign = HorizontalAlign.Center;
        tc11T1C.Text = lblValue.Text;
        tc11T1C.BorderWidth = 1;
        tr11T1.Cells.Add(tc11T1C);
        tbl.Rows.Add(tr11T1);

        TableRow tr13 = new TableRow();
        TableCell tc13A = new TableCell();
        tc13A.ColumnSpan = 13;
        tc13A.HorizontalAlign = HorizontalAlign.Center;
        tc13A.BorderWidth = 1;
        tc13A.Text = "Totals";
        tr13.Cells.Add(tc13A);

        TableCell tc13B = new TableCell();
        tc13B.ColumnSpan = 2;
        tc13B.HorizontalAlign = HorizontalAlign.Left;
        tc13B.Text = @"<strong>" + lblValue.Text + @"</strong>";
        tc13B.BorderWidth = 1;
        tr13.Cells.Add(tc13B);
        tbl.Rows.Add(tr13);

        TableRow trTa = new TableRow();

        TableCell tcTa = new TableCell();
        tcTa.ColumnSpan = 2;
        tcTa.HorizontalAlign = HorizontalAlign.Left;
        tcTa.Text = "Add";
        tcTa.BorderWidth = 1;
        trTa.Cells.Add(tcTa);

        TableCell tcTb = new TableCell();
        tcTb.ColumnSpan = 11;
        tcTb.HorizontalAlign = HorizontalAlign.Left;
        tcTb.Text = " CGST @ 6%";
        tcTb.BorderWidth = 1;
        trTa.Cells.Add(tcTb);

        TableCell tcTc = new TableCell();
        tcTc.ColumnSpan = 2;
        tcTc.HorizontalAlign = HorizontalAlign.Left;
        tcTc.Text = lblCGST.Text; 
        tcTc.BorderWidth = 1;
        trTa.Cells.Add(tcTc);

        tbl.Rows.Add(trTa);

        TableRow trTb = new TableRow();

        TableCell tcTa1 = new TableCell();
        tcTa1.ColumnSpan = 2;
        tcTa1.HorizontalAlign = HorizontalAlign.Left;
        tcTa1.Text = "Add";
        tcTa1.BorderWidth = 1;
        trTb.Cells.Add(tcTa1);

        TableCell tcTb1 = new TableCell();
        tcTb1.ColumnSpan = 11;
        tcTb1.HorizontalAlign = HorizontalAlign.Left;
        tcTb1.Text = " SGST @ 6%";
        tcTb1.BorderWidth = 1;
        trTb.Cells.Add(tcTb1);

        TableCell tcTc1 = new TableCell();
        tcTc1.ColumnSpan = 2;
        tcTc1.HorizontalAlign = HorizontalAlign.Left;
        tcTc1.Text = lblSGST.Text;
        tcTc1.BorderWidth = 1;
        trTb.Cells.Add(tcTc1);

        tbl.Rows.Add(trTb);

        TableRow trTc = new TableRow();

        TableCell tcTa2 = new TableCell();
        tcTa2.ColumnSpan = 2;
        tcTa2.HorizontalAlign = HorizontalAlign.Left;
        tcTa2.Text = "Add";
        tcTa2.BorderWidth = 1;
        trTc.Cells.Add(tcTa2);

        TableCell tcTb2 = new TableCell();
        tcTb2.ColumnSpan = 11;
        tcTb2.HorizontalAlign = HorizontalAlign.Left;
        tcTb2.Text = " IGST @ 12%";
        tcTb2.BorderWidth = 1;
        trTc.Cells.Add(tcTb2);

        TableCell tcTc2 = new TableCell();
        tcTc2.ColumnSpan = 2;
        tcTc2.HorizontalAlign = HorizontalAlign.Left;
        tcTc2.Text = lblIGST.Text;
        tcTc2.BorderWidth = 1;
        trTc.Cells.Add(tcTc2);

        tbl.Rows.Add(trTc);
        
        TableRow trTotalInvoice = new TableRow();
        TableCell tcTotalInvoiceA = new TableCell();
        tcTotalInvoiceA.ColumnSpan = 13;
        tcTotalInvoiceA.HorizontalAlign = HorizontalAlign.Center;
        tcTotalInvoiceA.BorderWidth = 1;
        tcTotalInvoiceA.Text = "Total Invoice Value ";
        trTotalInvoice.Cells.Add(tcTotalInvoiceA);

        TableCell tcTotalInvoiceB = new TableCell();
        tcTotalInvoiceB.ColumnSpan = 2;
        tcTotalInvoiceB.HorizontalAlign = HorizontalAlign.Left;
        tcTotalInvoiceB.Text = @"<strong>" + lblTotalInvoice.Text + @"</strong>";
        tcTotalInvoiceB.BorderWidth = 1;
        trTotalInvoice.Cells.Add(tcTotalInvoiceB);
        tbl.Rows.Add(trTotalInvoice);

        TableRow tr15 = new TableRow();
        TableCell tc15 = new TableCell();
        tc15.ColumnSpan = 15; 
        tc15.HorizontalAlign = HorizontalAlign.Left;
        tc15.BorderWidth = 1;
        tc15.Text = "Term & Conditions : ";
        tr15.Cells.Add(tc15);
        tbl.Rows.Add(tr15);

        TableRow tr16 = new TableRow();
        TableCell tc16 = new TableCell();
        tc16.ColumnSpan = 15; 
        tc16.HorizontalAlign = HorizontalAlign.Left;
        tc16.BorderWidth = 0;
        tc16.Text = "Udyog Aadhaar Registration Certificate : UDYAM-MH-26-0074541 Dated 05-02-2021"; 
        tr16.Cells.Add(tc16);
        tbl.Rows.Add(tr16);

        TableRow tr17 = new TableRow();
        TableCell tc17 = new TableCell();
        tc17.ColumnSpan = 15;
        tc17.HorizontalAlign = HorizontalAlign.Left;
        tc17.BorderWidth = 0; 
        tc17.Text = "Please pay the payment on or before due date given in this Bill";
        tr17.Cells.Add(tc17);
        tbl.Rows.Add(tr17);

        TableRow tr18 = new TableRow();
        TableCell tc18 = new TableCell();
        tc18.ColumnSpan = 15;
        tc18.HorizontalAlign = HorizontalAlign.Left;
        tc18.BorderWidth = 0;
        tc18.Text = "Please pay by cheque or draft in favour of <strong>DEXTERS LOGISTICS PRIVATE LIMITED</strong>";
        tr18.Cells.Add(tc18);
        tbl.Rows.Add(tr18);

        TableRow tr19 = new TableRow();
        TableCell tc19 = new TableCell();
        tc19.ColumnSpan = 15;
        tc19.HorizontalAlign = HorizontalAlign.Left;
        tc19.BorderWidth = 0;
        tc19.Text = "Request you to please pay on time to avoid discruption in service / late payment fees";
        tr19.Cells.Add(tc19);
        tbl.Rows.Add(tr19);        

        TableRow tr20 = new TableRow();
        TableCell tc20 = new TableCell();
        tc20.ColumnSpan = 15;
        tc20.HorizontalAlign = HorizontalAlign.Left;
        tc20.BorderWidth = 0;
        tc20.Text = "If any complain or discripancy please inform within three days from date receipt of bill.";
        tr20.Cells.Add(tc20);
        tbl.Rows.Add(tr20);

        TableRow tr21 = new TableRow();
        TableCell tc21 = new TableCell();
        tc21.ColumnSpan = 15;
        tc21.HorizontalAlign = HorizontalAlign.Left;
        tc21.BorderWidth = 0;
        tc21.Text = "           All disputes are subject to Pune jurisdiction ";
        tr21.Cells.Add(tc21);
        tbl.Rows.Add(tr21);

        TableRow tr22 = new TableRow();
        TableCell tc22 = new TableCell();
        tc22.ColumnSpan = 15;
        tc22.HorizontalAlign = HorizontalAlign.Right;
        tc22.BorderWidth = 0;
        tc22.Text = "           For <strong>DEXTERS LOGISTICS PRIVATE LIMITED</strong>";
        tr22.Cells.Add(tc22);
        tbl.Rows.Add(tr22);

        TableRow tr23 = new TableRow();
        TableCell tc23 = new TableCell();
        tc23.ColumnSpan = 15;
        tc23.HorizontalAlign = HorizontalAlign.Left;
        tc23.BorderWidth = 0;
        tc23.Text = "";
        tr23.Cells.Add(tc23);
        tbl.Rows.Add(tr23);

        TableRow tr24 = new TableRow();
        TableCell tc24 = new TableCell();
        tc24.ColumnSpan = 15;
        tc24.HorizontalAlign = HorizontalAlign.Right;
        tc24.BorderWidth = 0;
        tc24.Text = "Authorised Signatory";
        tr24.Cells.Add(tc24);
        tbl.Rows.Add(tr24);

        for(int iBlank = 0; iBlank <= 20; iBlank++)
        {
            TableRow trBlank = new TableRow();
            tbl.Rows.Add(trBlank);
        }

        TableRow tr12 = new TableRow();
        TableCell tc12A = new TableCell(), tc12B = new TableCell(), tc12C = new TableCell(), tc12D = new TableCell(), tc12E = new TableCell(), tc12F = new TableCell(), tc12G = new TableCell(), tc12H = new TableCell(), tc12I = new TableCell(), tc12J = new TableCell(), tc12K = new TableCell(), tc12L = new TableCell(), tc12M = new TableCell(), tc12N = new TableCell(), tc12O = new TableCell(), tcDist = new TableCell();
        tc12A.BorderWidth = 1; tc12B.BorderWidth = 1; tc12C.BorderWidth = 1; tc12D.BorderWidth = 1; tc12E.BorderWidth = 1; tc12F.BorderWidth = 1; tc12G.BorderWidth = 1; tc12H.BorderWidth = 1; tc12I.BorderWidth = 1; tc12J.BorderWidth = 1; tc12K.BorderWidth = 1; tc12L.BorderWidth = 1; tc12M.BorderWidth = 1; tc12N.BorderWidth = 1; tc12O.BorderWidth = 1;
        tc12A.Text = "SR.No."; tc12B.Text = "Way Bill No."; tc12C.Text = "Date"; tc12D.Text = "Station"; tc12E.Text = "Weight"; tc12F.Text = "No of PCS"; tc12G.Text = "Rate"; tc12H.Text = "Basic Frt."; tc12I.Text = "Labour"; tc12J.Text = "Other"; tc12K.Text = "fov"; tc12L.Text = "Docket Ch"; tc12M.Text = "ODA"; tc12N.Text = "DSC"; tc12O.Text = "Total Freight"; tcDist.Text = "Distance"; 
        tr12.Cells.Add(tc12A); tr12.Cells.Add(tc12B); tr12.Cells.Add(tc12C); tr12.Cells.Add(tc12D); tr12.Cells.Add(tcDist); tr12.Cells.Add(tc12E); tr12.Cells.Add(tc12F); tr12.Cells.Add(tc12G); tr12.Cells.Add(tc12H); tr12.Cells.Add(tc12I); tr12.Cells.Add(tc12J); tr12.Cells.Add(tc12K); tr12.Cells.Add(tc12L); tr12.Cells.Add(tc12M); tr12.Cells.Add(tc12N); tr12.Cells.Add(tc12O);
        tbl.Rows.Add(tr12);

        foreach (GridViewRow grvRow in gvFirstGrid.Rows)
        {
            TableRow trGrid = new TableRow();
            for (int iCell = 0; iCell <= grvRow.Cells.Count; iCell++)
            {
                //if (iCell == 2 || iCell == 3 || iCell == 4 || iCell == 10 || iCell == 11 || iCell == 14 || iCell == 15 || iCell == 16 || iCell == 17 || iCell == 18 || iCell == 19 || iCell == 20 || iCell == 21 || iCell == 22)
                if (iCell == 3 || iCell == 4 || iCell == 5 || iCell == 9 || iCell == 11 || iCell == 12 || iCell == 15 || iCell == 16 || iCell == 17 || iCell == 18 || iCell == 19 || iCell == 20 || iCell == 21 || iCell == 22 || iCell == 23)
                {
                    TableCell tcGrid = new TableCell();
                    tcGrid.Text = grvRow.Cells[iCell].Text;
                    tcGrid.BorderWidth = 1;
                    trGrid.Cells.Add(tcGrid);
                }
                if(iCell == 8)
                {
                    TableCell tcGrid = new TableCell();
                    if(grvRow.Cells[8].Text == grvRow.Cells[9].Text)
                        tcGrid.Text = grvRow.Cells[8].Text;
                    else
                        tcGrid.Text = grvRow.Cells[8].Text + ", " + grvRow.Cells[9].Text;

                    tcGrid.Text = tcGrid.Text + ", " + grvRow.Cells[5].Text;
                    tcGrid.BorderWidth = 1;
                    trGrid.Cells.Add(tcGrid);
                }
            }
            tbl.Rows.Add(trGrid);
        }

        Response.ContentType = "application/x-msexcel";
        Response.AddHeader("Content-Disposition", "attachment;filename = " + Txt_SearchCustName.Text.Substring(0, 10).Trim() + ".xls");
        Response.ContentEncoding = Encoding.UTF8;
        StringWriter tw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        tbl.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();
        /*Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);
        tbl.RenderControl(htmlTextWriter);
        StringReader stringReader = new StringReader(stringWriter.ToString());
        Document Doc = new Document(PageSize.A4, 10f, 10f, 100f, 10f);
        HTMLWorker htmlparser = new HTMLWorker(Doc);
               
        
        PdfWriter.GetInstance(Doc, Response.OutputStream);
        Doc.Open();
        htmlparser.Parse(stringReader);
        Doc.Close();
        Response.Write(Doc);
        Response.End();*/
    }

	protected void btnInvoiceHeader_Click(object sender, EventArgs e)
    {
        string strDate = Txt_FromDate.Text;
        DateTime dt = new DateTime(int.Parse(strDate.Substring(6, 4)), int.Parse(strDate.Substring(3, 2)), int.Parse(strDate.Substring(0, 2))); 
        Table tbl = new Table();

        TableRow tr1 = new TableRow();
        TableCell tc1 = new TableCell();
        tc1.ColumnSpan = 15;
        tc1.HorizontalAlign = HorizontalAlign.Center;
        tc1.Text = "TAX INVOICE";
        tr1.Cells.Add(tc1);
        tc1.BorderWidth = 1;
        tbl.Rows.Add(tr1);

        TableRow tr2 = new TableRow();
        TableCell tc2 = new TableCell();
        tc2.ColumnSpan = 15;
        tc2.HorizontalAlign = HorizontalAlign.Center;
        tc2.Text = "DEXTERS LOGISTICS PRIVATE LIMTIED";
        tr2.Cells.Add(tc2);
        tc2.BorderWidth = 1;
        tbl.Rows.Add(tr2);

        TableRow tr3 = new TableRow();
        TableCell tc3 = new TableCell();
        tc3.ColumnSpan = 15;
        tc3.HorizontalAlign = HorizontalAlign.Center;
        tc3.Text = "<strong>Corporate Office</strong>: Unit no 401/402 Kumar Business Centre, Bund Gardan Road, Sangamwadi, Pune - 411001";
        tc3.BorderWidth = 1;
        tr3.Cells.Add(tc3);
        tbl.Rows.Add(tr3);

        TableRow tr4 = new TableRow();
        TableCell tc4 = new TableCell();
        tc4.ColumnSpan = 15;
        tc4.HorizontalAlign = HorizontalAlign.Center;
        tc4.Text = "<strong>Branch Address :</strong> " + hfBranchAddress.Value;
        tc4.BorderWidth = 1;
        tr4.Cells.Add(tc4);
        tbl.Rows.Add(tr4);

        TableRow tr4p5 = new TableRow();
        TableCell tc4p5_1 = new TableCell();
        tc4p5_1.ColumnSpan = 7;
        tc4p5_1.HorizontalAlign = HorizontalAlign.Center;
        tc4p5_1.Text = "<strong>Customer Address</strong>";
        tc4p5_1.BorderWidth = 1;
        tr4p5.Cells.Add(tc4p5_1);

        TableCell tc4p5_2 = new TableCell();
        tc4p5_2.ColumnSpan = 8;
        tc4p5_2.HorizontalAlign = HorizontalAlign.Center;
        tc4p5_2.Text = "<strong>Supplier Details</strong>";
        tc4p5_2.BorderWidth = 1;
        tr4p5.Cells.Add(tc4p5_2);
        tbl.Rows.Add(tr4p5);

        TableRow tr6 = new TableRow();
        //Customer Name
        TableCell tc6A = new TableCell();
        tc6A.ColumnSpan = 10;
        tc6A.HorizontalAlign = HorizontalAlign.Left;
        tc6A.BorderWidth = 1;
        tc6A.Text = Txt_SearchCustName.Text;
        tr6.Cells.Add(tc6A);

        TableCell tc6B = new TableCell();
        tc6B.ColumnSpan = 3;
        tc6B.HorizontalAlign = HorizontalAlign.Left;
        tc6B.Text = "Invoice No";
        tc6B.BorderWidth = 1;
        tr6.Cells.Add(tc6B);

        TableCell tc6C = new TableCell();
        tc6C.ColumnSpan = 2;
        tc6C.HorizontalAlign = HorizontalAlign.Left;
        tc6C.Text = txtInvoiceNo.Text;
        tc6C.BorderWidth = 1;
        tr6.Cells.Add(tc6C);
        tbl.Rows.Add(tr6);

        TableRow tr7 = new TableRow();
        TableCell tc7A = new TableCell();
        tc7A.ColumnSpan = 10;
        tc7A.HorizontalAlign = HorizontalAlign.Left;
        tc7A.RowSpan = 4; 
        tc7A.BorderWidth = 1;
        tc7A.Text = hfCustomerAddress.Value;
        tr7.Cells.Add(tc7A);

        TableCell tc7B = new TableCell();
        tc7B.ColumnSpan = 3;
        tc7B.HorizontalAlign = HorizontalAlign.Left;
        tc7B.Text = "Invoice Date";
        tc7B.BorderWidth = 1;
        tr7.Cells.Add(tc7B);

        TableCell tc7C = new TableCell();
        tc7C.ColumnSpan = 2;
        tc7C.HorizontalAlign = HorizontalAlign.Left;
        tc7C.Text = "";
        tc7C.BorderWidth = 1;
        tr7.Cells.Add(tc7C);
        tbl.Rows.Add(tr7);

        TableRow tr8 = new TableRow();

        TableCell tc8B = new TableCell();
        tc8B.ColumnSpan = 3;
        tc8B.HorizontalAlign = HorizontalAlign.Left;
        tc8B.Text = "Period of Supply";
        tc8B.BorderWidth = 1;
        tr8.Cells.Add(tc8B);

        TableCell tc8C = new TableCell();
        tc8C.ColumnSpan = 2;
        tc8C.HorizontalAlign = HorizontalAlign.Left;
        tc8C.Text = "";
        tc8C.BorderWidth = 1;
        tr8.Cells.Add(tc8C);
        tbl.Rows.Add(tr8);

        TableRow tr9 = new TableRow();

        TableCell tc9B = new TableCell();
        tc9B.ColumnSpan = 3;
        tc9B.HorizontalAlign = HorizontalAlign.Left;
        tc9B.Text = "Due Date";
        tc9B.BorderWidth = 1;
        tr9.Cells.Add(tc9B);

        TableCell tc9C = new TableCell();
        tc9C.ColumnSpan = 2;
        tc9C.HorizontalAlign = HorizontalAlign.Left;
        tc9C.Text = "";
        tc9C.BorderWidth = 1;
        tr9.Cells.Add(tc9C);
        tbl.Rows.Add(tr9);

        TableRow tr10 = new TableRow();

        TableCell tc10B = new TableCell();
        tc10B.ColumnSpan = 3;
        tc10B.HorizontalAlign = HorizontalAlign.Left;
        tc10B.Text = "Place of Supply of Service";
        tc10B.BorderWidth = 1;
        tr10.Cells.Add(tc10B);

        TableCell tc10C = new TableCell();
        tc10C.ColumnSpan = 2;
        tc10C.HorizontalAlign = HorizontalAlign.Left;
        tc10C.Text = txtBranchName.Text;
        tc10C.BorderWidth = 1;
        tr10.Cells.Add(tc10C);
        tbl.Rows.Add(tr10);

        TableRow trStateCode = new TableRow();
        TableCell tcSC1 = new TableCell();
        tcSC1.ColumnSpan = 5;
        tcSC1.HorizontalAlign = HorizontalAlign.Left;
        tcSC1.Text = "State Code as per GST : ";
        tcSC1.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC1);

        TableCell tcSC2 = new TableCell();
        tcSC2.ColumnSpan = 5;
        tcSC2.HorizontalAlign = HorizontalAlign.Center;
        tcSC2.Text = hfCustomerStatecode.Value;
        tcSC2.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC2);

        TableCell tcSC3 = new TableCell();
        tcSC3.ColumnSpan = 3;
        tcSC3.HorizontalAlign = HorizontalAlign.Left;
        tcSC3.Text = "State code as per GST : ";
        tcSC3.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC3);

        TableCell tcSC4 = new TableCell();
        tcSC4.ColumnSpan = 2;
        tcSC4.HorizontalAlign = HorizontalAlign.Center;
        tcSC4.Text = hfBranchStateCode.Value;
        tcSC4.BorderWidth = 1;
        trStateCode.Cells.Add(tcSC4);

        tbl.Rows.Add(trStateCode);

        TableRow tr5 = new TableRow();
        TableCell tc5a = new TableCell();
        tc5a.ColumnSpan = 6;
        tc5a.HorizontalAlign = HorizontalAlign.Center;
        tc5a.Text = "GSTIN / Unique Id :";
        tc5a.BorderWidth = 1;
        tr5.Cells.Add(tc5a);
        
        TableCell tc5b = new TableCell();
        tc5b.ColumnSpan = 4;
        tc5b.HorizontalAlign = HorizontalAlign.Center;
        tc5b.Text = "";
        tc5b.BorderWidth = 1;
        tr5.Cells.Add(tc5b);

        TableCell tc5c = new TableCell();
        tc5c.ColumnSpan = 3;
        tc5c.HorizontalAlign = HorizontalAlign.Center;
        tc5c.Text = "GSTIN :";
        tc5c.BorderWidth = 1;
        tr5.Cells.Add(tc5c);

        TableCell tc5d = new TableCell();
        tc5d.ColumnSpan = 2;
        tc5d.HorizontalAlign = HorizontalAlign.Center;
        tc5d.Text = "24AADCD5211A1ZJ";
        tc5d.BorderWidth = 1;
        tr5.Cells.Add(tc5d);

        tbl.Rows.Add(tr5);

        TableRow tr5A = new TableRow();
        TableCell tc6a = new TableCell();
        tc6a.ColumnSpan = 6;
        tc6a.HorizontalAlign = HorizontalAlign.Center;
        tc6a.Text = "PAN No Buyer :";
        tc6a.BorderWidth = 1;
        tr5A.Cells.Add(tc6a);

        TableCell tc6b = new TableCell();
        tc6b.ColumnSpan = 4;
        tc6b.HorizontalAlign = HorizontalAlign.Center;
        tc6b.Text = "";
        tc6b.BorderWidth = 1;
        tr5A.Cells.Add(tc6b);

        TableCell tc6c = new TableCell();
        tc6c.ColumnSpan = 3;
        tc6c.HorizontalAlign = HorizontalAlign.Center;
        tc6c.Text = "PAN :";
        tc6c.BorderWidth = 1;
        tr5A.Cells.Add(tc6c);

        TableCell tc6d = new TableCell();
        tc6d.ColumnSpan = 2;
        tc6d.HorizontalAlign = HorizontalAlign.Center;
        tc6d.Text = "AADCD5211A";
        tc6d.BorderWidth = 1;
        tr5A.Cells.Add(tc6d);

        tbl.Rows.Add(tr5A);

        TableRow tr5B = new TableRow();
        TableCell tc7a = new TableCell();
        tc7a.ColumnSpan = 6;
        tc7a.HorizontalAlign = HorizontalAlign.Center;
        tc7a.Text = "SAC/HSN Code	";
        tc7a.BorderWidth = 1;
        tr5B.Cells.Add(tc7a);

        TableCell tc7b = new TableCell();
        tc7b.ColumnSpan = 4;
        tc7b.HorizontalAlign = HorizontalAlign.Center;
        tc7b.Text = "996511	";
        tc7b.BorderWidth = 1;
        tr5B.Cells.Add(tc7b);

        TableCell tc7c = new TableCell();
        tc7c.ColumnSpan = 3;
        tc7c.HorizontalAlign = HorizontalAlign.Center;
        tc7c.Text = "CIN :";
        tc7c.BorderWidth = 1;
        tr5B.Cells.Add(tc7c);

        TableCell tc7d = new TableCell();
        tc7d.ColumnSpan = 2;
        tc7d.HorizontalAlign = HorizontalAlign.Center;
        tc7d.Text = "U63010PN2010PTC136886"; 
        tc7d.BorderWidth = 1;
        tr5B.Cells.Add(tc7d);

        tbl.Rows.Add(tr5B);

        TableRow tr11 = new TableRow();
        TableCell tc11A = new TableCell();
        tc11A.ColumnSpan = 10;
        tc11A.HorizontalAlign = HorizontalAlign.Left;
        tc11A.BorderWidth = 1;
        tc11A.Text = "Service Description: Transportation Services (GTA)";
        tr11.Cells.Add(tc11A);

        TableCell tc11C = new TableCell();
        tc11C.ColumnSpan = 5;
        tc11C.HorizontalAlign = HorizontalAlign.Left;
        tc11C.Text = "Tax is payable on Reverse Charge : No";
        tc11C.BorderWidth = 1;
        tr11.Cells.Add(tc11C);
        tbl.Rows.Add(tr11);
			
        #region Added 02/Aug/2021 
        TableRow tr11T = new TableRow();
        TableCell tc11TA = new TableCell();
        tc11TA.ColumnSpan = 2;
        tc11TA.HorizontalAlign = HorizontalAlign.Left;
        tc11TA.BorderWidth = 1;
        tc11TA.Text = "Sr No.";
        tr11T.Cells.Add(tc11TA);
        TableCell tc11TB = new TableCell();
        tc11TB.ColumnSpan = 11;
        tc11TB.HorizontalAlign = HorizontalAlign.Left;
        tc11TB.BorderWidth = 1;
        tc11TB.Text = "Description of the Goods";
        tr11T.Cells.Add(tc11TB);
        TableCell tc11TC = new TableCell();
        tc11TC.ColumnSpan = 2;
        tc11TC.HorizontalAlign = HorizontalAlign.Center;
        tc11TC.Text = "Total Freight";
        tc11TC.BorderWidth = 1;
        tr11T.Cells.Add(tc11TC);
        tbl.Rows.Add(tr11T);

        TableRow tr11T1 = new TableRow();
        TableCell tc11T1A = new TableCell();
        tc11T1A.ColumnSpan = 2;
        tc11T1A.HorizontalAlign = HorizontalAlign.Left;
        tc11T1A.BorderWidth = 1;
        tc11T1A.Text = "1.";
        tr11T1.Cells.Add(tc11T1A);
        TableCell tc11T1B = new TableCell();
        tc11T1B.ColumnSpan = 11;
        tc11T1B.HorizontalAlign = HorizontalAlign.Left;
        tc11T1B.BorderWidth = 1;

        tc11T1B.Text = "Secondary Freight Charges for the month " + dt.ToString("MMMM") + @"' " + dt.ToString("yyyy") + " (As per Annexture attach)";
        tr11T1.Cells.Add(tc11T1B);
        TableCell tc11T1C = new TableCell();
        tc11T1C.ColumnSpan = 2;
        tc11T1C.HorizontalAlign = HorizontalAlign.Center;
        tc11T1C.Text = lblValue.Text;
        tc11T1C.BorderWidth = 1;
        tr11T1.Cells.Add(tc11T1C);
        tbl.Rows.Add(tr11T1);
        #endregion 

        TableRow tr13 = new TableRow();
        TableCell tc13A = new TableCell();
        tc13A.ColumnSpan = 13;
        tc13A.HorizontalAlign = HorizontalAlign.Center;
        tc13A.BorderWidth = 1;
        tc13A.Text = "Total";
        tr13.Cells.Add(tc13A);

        TableCell tc13B = new TableCell();
        tc13B.ColumnSpan = 2;
        tc13B.HorizontalAlign = HorizontalAlign.Left;
        tc13B.Text = @"<strong>" + lblValue.Text + @"</strong>";
        tc13B.BorderWidth = 1;
        tr13.Cells.Add(tc13B);
        tbl.Rows.Add(tr13);

        TableRow trTa = new TableRow();

        TableCell tcTa = new TableCell();
        tcTa.ColumnSpan = 2;
        tcTa.HorizontalAlign = HorizontalAlign.Left;
        tcTa.Text = "Add";
        tcTa.BorderWidth = 1;
        trTa.Cells.Add(tcTa);

        TableCell tcTb = new TableCell();
        tcTb.ColumnSpan = 11;
        tcTb.HorizontalAlign = HorizontalAlign.Left;
        tcTb.Text = " CGST @ 6%";
        tcTb.BorderWidth = 1;
        trTa.Cells.Add(tcTb);

        TableCell tcTc = new TableCell();
        tcTc.ColumnSpan = 2;
        tcTc.HorizontalAlign = HorizontalAlign.Left;
        tcTc.Text = lblCGST.Text; 
        tcTc.BorderWidth = 1;
        trTa.Cells.Add(tcTc);

        tbl.Rows.Add(trTa);

        TableRow trTb = new TableRow();

        TableCell tcTa1 = new TableCell();
        tcTa1.ColumnSpan = 2;
        tcTa1.HorizontalAlign = HorizontalAlign.Left;
        tcTa1.Text = "Add";
        tcTa1.BorderWidth = 1;
        trTb.Cells.Add(tcTa1);

        TableCell tcTb1 = new TableCell();
        tcTb1.ColumnSpan = 11;
        tcTb1.HorizontalAlign = HorizontalAlign.Left;
        tcTb1.Text = " SGST @ 6%";
        tcTb1.BorderWidth = 1;
        trTb.Cells.Add(tcTb1);

        TableCell tcTc1 = new TableCell();
        tcTc1.ColumnSpan = 2;
        tcTc1.HorizontalAlign = HorizontalAlign.Left;
        tcTc1.Text = lblSGST.Text;
        tcTc1.BorderWidth = 1;
        trTb.Cells.Add(tcTc1);

        tbl.Rows.Add(trTb);

        TableRow trTc = new TableRow();

        TableCell tcTa2 = new TableCell();
        tcTa2.ColumnSpan = 2;
        tcTa2.HorizontalAlign = HorizontalAlign.Left;
        tcTa2.Text = "Add";
        tcTa2.BorderWidth = 1;
        trTc.Cells.Add(tcTa2);

        TableCell tcTb2 = new TableCell();
        tcTb2.ColumnSpan = 11;
        tcTb2.HorizontalAlign = HorizontalAlign.Left;
        tcTb2.Text = " IGST @ 12%";
        tcTb2.BorderWidth = 1;
        trTc.Cells.Add(tcTb2);

        TableCell tcTc2 = new TableCell();
        tcTc2.ColumnSpan = 2;
        tcTc2.HorizontalAlign = HorizontalAlign.Left;
        tcTc2.Text = lblIGST.Text;
        tcTc2.BorderWidth = 1;
        trTc.Cells.Add(tcTc2);

        tbl.Rows.Add(trTc);
        
        TableRow trTotalInvoice = new TableRow();
        TableCell tcTotalInvoiceA = new TableCell();
        tcTotalInvoiceA.ColumnSpan = 13;
        tcTotalInvoiceA.HorizontalAlign = HorizontalAlign.Center;
        tcTotalInvoiceA.BorderWidth = 1;
        tcTotalInvoiceA.Text = "Total Invoice Value ";
        trTotalInvoice.Cells.Add(tcTotalInvoiceA);

        TableCell tcTotalInvoiceB = new TableCell();
        tcTotalInvoiceB.ColumnSpan = 2;
        tcTotalInvoiceB.HorizontalAlign = HorizontalAlign.Left;
        tcTotalInvoiceB.Text = @"<strong>" + lblTotalInvoice.Text + @"</strong>";
        tcTotalInvoiceB.BorderWidth = 1;
        trTotalInvoice.Cells.Add(tcTotalInvoiceB);
        tbl.Rows.Add(trTotalInvoice);

		TableRow trInvInWords = new TableRow();
        TableCell tcInvInWords = new TableCell();
        tcInvInWords.ColumnSpan = 15;
        tcInvInWords.HorizontalAlign = HorizontalAlign.Center;
        tcInvInWords.BorderWidth = 1;
        tcInvInWords.Text = "In Words : " + ConvertNumbertoWords(long.Parse(lblTotalInvoice.Text));
        trInvInWords.Cells.Add(tcInvInWords);
        tbl.Rows.Add(trInvInWords);
		
        TableRow tr15 = new TableRow();
        TableCell tc15 = new TableCell();
        tc15.ColumnSpan = 15; 
        tc15.HorizontalAlign = HorizontalAlign.Left;
        tc15.BorderWidth = 1;
        tc15.Text = "Term & Conditions : ";
        tr15.Cells.Add(tc15);
        tbl.Rows.Add(tr15);

        TableRow tr16 = new TableRow();
        TableCell tc16 = new TableCell();
        tc16.ColumnSpan = 15; 
        tc16.HorizontalAlign = HorizontalAlign.Left;
        tc16.BorderWidth = 0;
        tc16.Text = "Udyog Aadhaar Registration Certificate : UDYAM-MH-26-0074541 Dated 05-02-2021"; 
        tr16.Cells.Add(tc16);
        tbl.Rows.Add(tr16);

        TableRow tr17 = new TableRow();
        TableCell tc17 = new TableCell();
        tc17.ColumnSpan = 15;
        tc17.HorizontalAlign = HorizontalAlign.Left;
        tc17.BorderWidth = 0; 
        tc17.Text = "Please pay the payment on or before due date given in this Bill";
        tr17.Cells.Add(tc17);
        tbl.Rows.Add(tr17);

        TableRow tr18 = new TableRow();
        TableCell tc18 = new TableCell();
        tc18.ColumnSpan = 15;
        tc18.HorizontalAlign = HorizontalAlign.Left;
        tc18.BorderWidth = 0;
        tc18.Text = "Please pay by cheque or draft in favour of <strong>DEXTERS LOGISTICS PRIVATE LIMITED</strong>";
        tr18.Cells.Add(tc18);
        tbl.Rows.Add(tr18);

        TableRow tr19 = new TableRow();
        TableCell tc19 = new TableCell();
        tc19.ColumnSpan = 15;
        tc19.HorizontalAlign = HorizontalAlign.Left;
        tc19.BorderWidth = 0;
        tc19.Text = "Request you to please pay on time to avoid discruption in service / late payment fees";
        tr19.Cells.Add(tc19);
        tbl.Rows.Add(tr19);        

        TableRow tr20 = new TableRow();
        TableCell tc20 = new TableCell();
        tc20.ColumnSpan = 15;
        tc20.HorizontalAlign = HorizontalAlign.Left;
        tc20.BorderWidth = 0;
        tc20.Text = "If any complain or discripancy please inform within three days from date receipt of bill.";
        tr20.Cells.Add(tc20);
        tbl.Rows.Add(tr20);

        TableRow tr21 = new TableRow();
        TableCell tc21 = new TableCell();
        tc21.ColumnSpan = 15;
        tc21.HorizontalAlign = HorizontalAlign.Left;
        tc21.BorderWidth = 0;
        tc21.Text = "           All disputes are subject to Pune jurisdiction ";
        tr21.Cells.Add(tc21);
        tbl.Rows.Add(tr21);

        TableRow tr22 = new TableRow();
        TableCell tc22 = new TableCell();
        tc22.ColumnSpan = 15;
        tc22.HorizontalAlign = HorizontalAlign.Right;
        tc22.BorderWidth = 0;
        tc22.Text = "           For <strong>DEXTERS LOGISTICS PRIVATE LIMITED</strong>";
        tr22.Cells.Add(tc22);
        tbl.Rows.Add(tr22);

        TableRow tr23 = new TableRow();
        TableCell tc23 = new TableCell();
        tc23.ColumnSpan = 15;
        tc23.HorizontalAlign = HorizontalAlign.Left;
        tc23.BorderWidth = 0;
        tc23.Text = "";
        tr23.Cells.Add(tc23);
        tbl.Rows.Add(tr23);

        TableRow tr24 = new TableRow();
        TableCell tc24 = new TableCell();
        tc24.ColumnSpan = 15;
        tc24.HorizontalAlign = HorizontalAlign.Right;
        tc24.BorderWidth = 0;
        tc24.Text = "Authorised Signatory";
        tr24.Cells.Add(tc24);
        tbl.Rows.Add(tr24);

        for(int iBlank = 0; iBlank <= 20; iBlank++)
        {
            TableRow trBlank = new TableRow();
            tbl.Rows.Add(trBlank);
        }


        Response.ContentType = "application/x-msexcel";
        Response.AddHeader("Content-Disposition", "attachment;filename = " + Txt_SearchCustName.Text.Substring(0, 10).Trim() + ".xls");
        Response.ContentEncoding = Encoding.UTF8;
        StringWriter tw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        tbl.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();
        /*Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);
        tbl.RenderControl(htmlTextWriter);
        StringReader stringReader = new StringReader(stringWriter.ToString());
        Document Doc = new Document(PageSize.A4, 10f, 10f, 100f, 10f);
        HTMLWorker htmlparser = new HTMLWorker(Doc);
               
        
        PdfWriter.GetInstance(Doc, Response.OutputStream);
        Doc.Open();
        htmlparser.Parse(stringReader);
        Doc.Close();
        Response.Write(Doc);
        Response.End();*/
    }

    protected void btnInvoiceWaybill_Click(object sender, EventArgs e)
    {
        Table tbl = new Table();

        TableRow tr12 = new TableRow();
        TableCell tc12A = new TableCell(), tc12B = new TableCell(), tc12C = new TableCell(), tc12D = new TableCell(), tc12E = new TableCell(), tc12F = new TableCell(), tc12G = new TableCell(), tc12H = new TableCell(), tc12I = new TableCell(), tc12J = new TableCell(), tc12K = new TableCell(), tc12L = new TableCell(), tc12M = new TableCell(), tc12N = new TableCell(), tc12O = new TableCell(), tcDist = new TableCell();
        tc12A.BorderWidth = 1; tc12B.BorderWidth = 1; tc12C.BorderWidth = 1; tc12D.BorderWidth = 1; tc12E.BorderWidth = 1; tc12F.BorderWidth = 1; tc12G.BorderWidth = 1; tc12H.BorderWidth = 1; tc12I.BorderWidth = 1; tc12J.BorderWidth = 1; tc12K.BorderWidth = 1; tc12L.BorderWidth = 1; tc12M.BorderWidth = 1; tc12N.BorderWidth = 1; tc12O.BorderWidth = 1;
        tc12A.Text = "SR.No."; tc12B.Text = "Way Bill No."; tc12C.Text = "Date"; tc12D.Text = "Station"; 
	if (hfSearchCustName.Value.ToString() == "99" || hfSearchCustName.Value.ToString() == "13") { tc12E.Text = "Inner Qty"; } else tc12E.Text = "Weight"; 
	tc12F.Text = "No of PCS"; tc12G.Text = "Rate"; tc12H.Text = "Basic Frt."; tc12I.Text = "Labour"; tc12J.Text = "Other"; tc12K.Text = "fov"; tc12L.Text = "Docket Ch"; tc12M.Text = "ODA"; tc12N.Text = "DSC"; tc12O.Text = "Total Freight"; tcDist.Text = "Distance"; 
        tr12.Cells.Add(tc12A); tr12.Cells.Add(tc12B); tr12.Cells.Add(tc12C); tr12.Cells.Add(tc12D); tr12.Cells.Add(tcDist); tr12.Cells.Add(tc12E); tr12.Cells.Add(tc12F); tr12.Cells.Add(tc12G); tr12.Cells.Add(tc12H); tr12.Cells.Add(tc12I); tr12.Cells.Add(tc12J); tr12.Cells.Add(tc12K); tr12.Cells.Add(tc12L); tr12.Cells.Add(tc12M); tr12.Cells.Add(tc12N); tr12.Cells.Add(tc12O);
        tbl.Rows.Add(tr12);

        foreach (GridViewRow grvRow in gvFirstGrid.Rows)
        {
            TableRow trGrid = new TableRow();
            for (int iCell = 0; iCell <= grvRow.Cells.Count; iCell++)
            {
                //if (iCell == 2 || iCell == 3 || iCell == 4 || iCell == 10 || iCell == 11 || iCell == 14 || iCell == 15 || iCell == 16 || iCell == 17 || iCell == 18 || iCell == 19 || iCell == 20 || iCell == 21 || iCell == 22)
                //if (iCell == 3 || iCell == 4 || iCell == 5 || iCell == 11 || iCell == 12 || iCell == 15 || iCell == 16 || iCell == 17 || iCell == 18 || iCell == 19 || iCell == 20 || iCell == 21 || iCell == 22 || iCell == 23)
                if (iCell == 3  || iCell == 4  || iCell == 5 || iCell == 10 || 
                    iCell == 12 || iCell == 13 || iCell == 16 || iCell == 17 || iCell == 18 || iCell == 19 || iCell == 20 || iCell == 21 || iCell == 22 || iCell == 23 || iCell == 24) 
                {
                    TableCell tcGrid = new TableCell();
                    tcGrid.Text = grvRow.Cells[iCell].Text;
                    tcGrid.BorderWidth = 1;
                    trGrid.Cells.Add(tcGrid);
                }
                if (iCell == 8)
                {
                    TableCell tcGrid = new TableCell();
                    if (grvRow.Cells[8].Text == grvRow.Cells[9].Text)
                        tcGrid.Text = grvRow.Cells[8].Text;
                    else
                        tcGrid.Text = grvRow.Cells[8].Text + ", " + grvRow.Cells[9].Text;

                    //tcGrid.Text = tcGrid.Text + ", " + grvRow.Cells[9].Text;
                    tcGrid.BorderWidth = 1;
                    trGrid.Cells.Add(tcGrid);
                }
            }
            tbl.Rows.Add(trGrid);
        }

        Response.ContentType = "application/x-msexcel";
        Response.AddHeader("Content-Disposition", "attachment;filename = " + Txt_SearchCustName.Text.Substring(0, 10).Trim() + ".xls");
        Response.ContentEncoding = Encoding.UTF8;
        StringWriter tw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(tw);
        tbl.RenderControl(hw);
        Response.Write(tw.ToString());
        Response.End();
        /*Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter stringWriter = new StringWriter();
        HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);
        tbl.RenderControl(htmlTextWriter);
        StringReader stringReader = new StringReader(stringWriter.ToString());
        Document Doc = new Document(PageSize.A4, 10f, 10f, 100f, 10f);
        HTMLWorker htmlparser = new HTMLWorker(Doc);
               
        
        PdfWriter.GetInstance(Doc, Response.OutputStream);
        Doc.Open();
        htmlparser.Parse(stringReader);
        Doc.Close();
        Response.Write(Doc);
        Response.End();*/
    }


    protected void gvFirstGrid_DataBound(object sender, EventArgs e)
    {
    }

    public string ConvertNumbertoWords(long number)
    {
        if (number == 0) return "ZERO";
        if (number < 0) return "minus " + ConvertNumbertoWords(Math.Abs(number));
        string words = "";
        if ((number / 1000000) > 0)
        {
            words += ConvertNumbertoWords(number / 100000) + " LAKHS ";
            number %= 1000000;
        }
        if ((number / 1000) > 0)
        {
            words += ConvertNumbertoWords(number / 1000) + " THOUSAND ";
            number %= 1000;
        }
        if ((number / 100) > 0)
        {
            words += ConvertNumbertoWords(number / 100) + " HUNDRED ";
            number %= 100;
        }
        //if ((number / 10) > 0)  
        //{  
        // words += ConvertNumbertoWords(number / 10) + " RUPEES ";  
        // number %= 10;  
        //}  
        if (number > 0)
        {
            if (words != "") words += "AND ";
            var unitsMap = new[]
            {
            "ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN", "NINETEEN"
        };
            var tensMap = new[]
            {
            "ZERO", "TEN", "TWENTY", "THIRTY", "FORTY", "FIFTY", "SIXTY", "SEVENTY", "EIGHTY", "NINETY"
        };
            if (number < 20) words += unitsMap[number];
            else
            {
                words += tensMap[number / 10];
                if ((number % 10) > 0) words += " " + unitsMap[number % 10];
            }
        }
        return words;
    }
}