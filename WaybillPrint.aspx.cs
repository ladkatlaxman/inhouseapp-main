using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.xml.simpleparser;
using BLFunctions;
using BLProperties;
using iTextSharp.tool.xml;
using System.Data;
using QRCoder;
using System.Drawing;
//using Barcodes;
//using iTextSharp.tool.xml;

public partial class WaybillPrint : System.Web.UI.Page
{
    string filepath = String.Empty, filename = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Redirect(@"http://45.250.248.130:40/WayBillPrint.aspx");
        lblError.Text = "";
        try
        {
            if (Request["WayBillNo"] != null)
            {
                txtWayBillNo.Text = Request["WayBillNo"].ToString();
                Btn_Print_Click(sender, e);
            }
            else
            {
                Response.Redirect(@"http://45.250.248.130:40/WayBillPrint.aspx");
            }
        }
        catch
        { }
    }
    protected void Btn_Print_Click(object sender, EventArgs e)
    {
        if (txtWayBillNo.Text.Trim() == "")
        {
            lblError.Text = "No WayBill no Specified.";
            return;
        }
        string strWaybillId;
        strWaybillId = (new clsWayBillPrint()).getWayBillId(txtWayBillNo.Text.ToString());
        if (strWaybillId.Trim() == "")
        {
            lblError.Text = "WayBill no Specified is Invalid.";
            return;
        }
        //(new BarCode()).CreateBarCode(txtWayBillNo.Text.ToString());
        Response.ContentType = "image/jpeg";
        createPdf(strWaybillId);
        ShowPdf(filename, filepath);

        /*string[] strArr = strWaybillId.Split(',');
        for (int i = 0; i <= strArr.Length - 1; i++)
        {
        }*/
        //GenerateWayBill(); 
        //Btn_PrintPDF_Click(sender, e); 
        //GenerateReport(sender, e); 
    }
    protected void lnkSendEmail_Click(object sender, EventArgs e)
    {
        if (txtWayBillNo.Text.Trim() == "")
        {
            lblError.Text = "No WayBill no Specified.";
            return;
        }
        if (txtEmailId.Text.Trim() == "")
        {
            lblError.Text = "EMail ID is not Specified.";
            return;
        }
        string strWaybillId = String.Empty;
        strWaybillId = (new clsWayBillPrint()).getWayBillId(txtWayBillNo.Text.ToString());
        if (strWaybillId.Equals(String.Empty))
        {
            lblError.Text = "Invalid WayBill provided.";
            return;
        }

        PickReq pq = (new MasterFormFunctions()).getWaybillHeaderDetails(strWaybillId);
        createPdf(strWaybillId);

        string strBody = "Details For : <br>";
        strBody += "Waybill No : " + pq.WaybillNo + " for : " + pq.ConsigneeName + " at " + pq.DelCity + "<br>";

        //(new SendMail()).MailExecute(strBody.ToString(), txtEmailId.Text, HttpContext.Current.Server.MapPath("WayBillPDF/" + filename), "WayBills Created by Dexters logistic Pvt Ltd. ");
        (new SendMail()).MailExecute(strBody.ToString(), txtEmailId.Text, HttpContext.Current.Server.MapPath(filename), "WayBills Created by Dexters logistic Pvt Ltd. ");
        lblError.Text = "Email has been send to " + txtEmailId.Text;
    }

    public void createPdf(string WaybillId) //String file)
    {
        string HTML = getHTMLString(WaybillId);
        {
            filepath = HttpContext.Current.Server.MapPath("Waybill.pdf");
            filename = @"/WayBillPDF/WayBillList" + DateTime.Now.ToString().Replace(" ", "_").Replace(":", ".").Replace(@"/", "") + ".pdf"; //"Waybill.pdf"; 
            System.IO.File.Copy(filepath, filepath.Replace("Waybill.pdf", filename), true);
            Document document = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(filepath.Replace("Waybill.pdf", filename), FileMode.Create));
            document.Open();

            StringReader sr = new StringReader(HTML);
            XMLWorkerHelper.GetInstance().ParseXHtml(writer, document, sr);
            PdfAction action = new PdfAction(PdfAction.PRINTDIALOG);
            document.Close();
        }
    }

    private string getHTMLString(string WayBillId)
    {

        string imageURL = Server.MapPath(".") + "/.jpg";

        PickReq wbHeader = new PickReq();
        wbHeader = (new MasterFormFunctions()).getWaybillHeaderDetails(WayBillId);

        //iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(imageURL);
        string strPath = HttpContext.Current.Server.MapPath("/WaybillPrint.html"); 
        QRCodeGenerator qrGenerator = new QRCodeGenerator();
        QRCodeData qrCodeData = qrGenerator.CreateQrCode(wbHeader.WaybillNo.ToString(), QRCodeGenerator.ECCLevel.Q); 
        QRCode qrCode = new QRCode(qrCodeData); 
        Bitmap qrCodeImage = qrCode.GetGraphic(20); 
        qrCodeImage.Save(HttpContext.Current.Server.MapPath("") + @"/WayBillPDF/QR" + wbHeader.WaybillNo.ToString() + ".jpg");

        string strHTML = System.IO.File.ReadAllText(strPath); 
        strHTML = strHTML.Replace("@@logoimage@@", HttpContext.Current.Server.MapPath("") + "/images/dexterLogo.png"); 
        strHTML = strHTML.Replace("@@imgQRCode@@", HttpContext.Current.Server.MapPath("") + @"/WayBillPDF/QR" + wbHeader.WaybillNo.ToString() + ".jpg"); 
        strHTML = strHTML.Replace("@@PickUpLocation@@", wbHeader.PickupBranch); 
        strHTML = strHTML.Replace("@@WayBillNo@@", wbHeader.WaybillNo.ToString()); 
        strHTML = strHTML.Replace("@@DeliveryLocation@@", wbHeader.DeliveryBranch); 
        strHTML = strHTML.Replace("@@WaybillDate@@", wbHeader.WaybillDate); 
        strHTML = strHTML.Replace("@@ConsignorName@@", wbHeader.CustName); 
        strHTML = strHTML.Replace("@@ConsigneeName@@", wbHeader.ConsigneeName); 
        strHTML = strHTML.Replace("@@ConsignorAddress@@", wbHeader.CustAddress + "<br />" + wbHeader.CustArea + "<br />" + wbHeader.CustPINCode); 
        strHTML = strHTML.Replace("@@ConsigneeAddress@@", wbHeader.DelAddress + "<br />" + wbHeader.DelCity + "<br />" + wbHeader.DelArea + "<br />" + wbHeader.DelPINCode); 
        strHTML = strHTML.Replace("@@ConsginorContact@@", wbHeader.CustContactNo); 
        strHTML = strHTML.Replace("@@ConsigneeContact@@", wbHeader.ConsigneeContactNo); 


        string strMaterialDetail = "<table><tr><th>Sr</th><th>Invoice No</th><th>Date</th><th>Value</th><th>Material</th><th>Package</th><th>Qty</th><th>Actual Wt</th><th>Charged Wt</th></tr>";

        List<PickReqDetail> pickReqDetails = (new MasterFormFunctions()).getWaybillDetails(WayBillId.ToString());
        int iGinti = 0;
        foreach (PickReqDetail pDetail in pickReqDetails)
        {
            iGinti++;

            strMaterialDetail += "<tr><td>" + iGinti.ToString() + "</td>";
            strMaterialDetail += "<td>" + pDetail.InvoiceNo + "</td>";
            strMaterialDetail += "<td>" + pDetail.InvoiceDate + "</td>";
            strMaterialDetail += "<td>" + pDetail.InvoiceValue + "</td>";
            strMaterialDetail += "<td style=\"display: inline-block; \">" + pDetail.MaterialType + "</td>";
            strMaterialDetail += "<td>" + pDetail.PackageType + "</td>";
            strMaterialDetail += "<td>" + pDetail.NoOfPackage.ToString() + "</td>";
            strMaterialDetail += "<td>" + pDetail.ActualWeight + "</td>";
            strMaterialDetail += "<td>" + pDetail.ChargeWeight + "</td>";
            strMaterialDetail += "</tr>";
        }
        strMaterialDetail += "</table>";
        strHTML = strHTML.Replace("@@MaterialTable@@", strMaterialDetail);

        return strHTML;
    }

    // function to show on page
    private void ShowPdf(string filename, string filePath)
    {
        Response.ClearContent();
        Response.ClearHeaders();
        Response.ContentType = "application/pdf";
        Response.BufferOutput = true;
        //string FilePath = HttpContext.Current.Server.MapPath(@"WayBillPDF/" + filename); //HttpContext.Current.Server.MapPath(filename)+ @"\WayBillPDF";
        string FilePath = HttpContext.Current.Server.MapPath(filename);
        Response.WriteFile(FilePath);
        Response.End();
    }

    public void GenerateWayBill()
    {
        Document document = new Document(PageSize.A4, 88f, 88f, 10f, 10f);
        iTextSharp.text.Font NormalFont = FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.NORMAL, BaseColor.BLACK);
        using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
        {
            PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);

            document.Open();

            PdfPTable table = getWayBIllTable("29945");

            document.Add(table);
            document.Close();
            byte[] bytes = memoryStream.ToArray();
            memoryStream.Close();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "attachment; filename=WayBill.pdf");
            Response.Buffer = true;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(bytes);
            Response.End();
            Response.Close();
        }
    }
    public PdfPTable getWayBIllTable(string WayBillId)
    {
        PdfPTable pWayBillTable = new PdfPTable(8);
        Phrase phrase = null;
        PickReq wbHeader = new PickReq();
        wbHeader = (new MasterFormFunctions()).getWaybillHeaderDetails(WayBillId);

        #region Waybill Header - Company Name 
        PdfPCell pBlank = new PdfPCell();
        //pBlank.Rowspan = 1;
        phrase = new Phrase();
        phrase.Add(new Chunk(" - ", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
        pBlank = PhraseCell(phrase, PdfPCell.ALIGN_CENTER);
        pBlank.Colspan = 4;
        pWayBillTable.AddCell(pBlank);

        PdfPCell dexLogo = new PdfPCell();
        phrase = new Phrase();
        phrase.Add(new Chunk("Logo for Dexters Logistics.", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
        dexLogo = PhraseCell(phrase, PdfPCell.ALIGN_CENTER);
        dexLogo.Colspan = 2;
        dexLogo.Rowspan = 4;
        pWayBillTable.AddCell(dexLogo);

        PdfPCell dexName = new PdfPCell();
        phrase = new Phrase();
        phrase.Add(new Chunk("Dexters Logistics Pvt Ltd", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
        dexName = PhraseCell(phrase, PdfPCell.ALIGN_CENTER);
        dexName.Colspan = 2;
        pWayBillTable.AddCell(dexName);

        PdfPCell dexAdrress = new PdfPCell();
        phrase = new Phrase();
        phrase.Add(new Chunk("401, Kumar Business Center \n Bund Garden Road, Pune - 411001", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
        dexAdrress = PhraseCell(phrase, PdfPCell.ALIGN_CENTER);
        dexAdrress.Colspan = 2;
        dexAdrress.Rowspan = 3;
        #endregion

        pWayBillTable.AddCell(dexAdrress);

        return pWayBillTable;
    }
    protected void Btn_PrintPDF_Click(object sender, EventArgs e)
    {
        string waybillID = "29945";
        PickReq wbHeader = new PickReq();
        wbHeader = (new MasterFormFunctions()).getWaybillHeaderDetails(waybillID);

        Document document = new Document(PageSize.A4, 88f, 88f, 10f, 10f);
        document.Open();
        System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
        PdfPTable pdfPTable = new PdfPTable(2);

        Table tbl = new Table();
        tbl.BorderWidth = 1;
        // row1
        #region         
        TableRow tr1 = new TableRow();

        TableCell tc1 = new TableCell();
        tc1.ColumnSpan = 4;
        tc1.RowSpan = 2;
        tc1.HorizontalAlign = HorizontalAlign.Center;
        tc1.Text = "Dexters Logistics Pvt Ltd"; // <br> 401, Kumar Business Center <br> Bund Garden Road, <br> Pune - 411001 ";//string.Format("<img src='images/dexterLogo.png' />") +
        tr1.Cells.Add(tc1);
        //tbl.Rows.Add(tr1);
        PdfPCell pdfHeaderCell = new PdfPCell(new Phrase("Dexters Logistics Pvt Ltd"));
        pdfHeaderCell.Colspan = 2;
        pdfHeaderCell.HorizontalAlignment = 1; //Center
        pdfHeaderCell.BorderWidth = 1;
        //PdfPRow = new PdfPRow({ { pdfHeaderCell }; ); 
        pdfPTable.AddCell(pdfHeaderCell);

        TableCell tc2 = new TableCell();
        tc2.HorizontalAlign = HorizontalAlign.Center;
        tc2.Text = "From:";
        tr1.Cells.Add(tc2);
        //tbl.Rows.Add(tr1);
        PdfPCell pdFromCell = new PdfPCell(new Phrase("From : "));
        pdFromCell.HorizontalAlignment = 1; //Center
        pdFromCell.BorderWidth = 1;
        pdfPTable.AddCell(pdFromCell);

        PdfPCell pdFromNameCell = new PdfPCell(new Phrase("Dexter's Logistics Pvt Ltd: "));
        pdFromNameCell.HorizontalAlignment = 1; //Center
        pdFromNameCell.BorderWidth = 1;
        pdfPTable.AddCell(pdFromNameCell);

        TableCell tc3 = new TableCell();
        tc3.HorizontalAlign = HorizontalAlign.Center;
        tc3.Text = wbHeader.PickupBranch;
        tc3.BorderWidth = 1;
        tr1.Cells.Add(tc3);
        //tbl.Rows.Add(tr1);

        TableCell tc4 = new TableCell();
        tc4.HorizontalAlign = HorizontalAlign.Center;
        tc4.Text = "Waybill No:";
        tr1.Cells.Add(tc4);
        //tbl.Rows.Add(tr1);

        TableCell tc5 = new TableCell();
        tc5.HorizontalAlign = HorizontalAlign.Center;
        tc5.Text = wbHeader.WaybillNo.ToString();
        tr1.Cells.Add(tc5);
        tbl.Rows.Add(tr1);
        #endregion
        //row2
        #region

        TableRow tr2 = new TableRow();
        TableCell tc6 = new TableCell();
        tc6.HorizontalAlign = HorizontalAlign.Center;
        tc6.Text = "To:";
        tr2.Cells.Add(tc6);
        // tbl.Rows.Add(tr2);

        TableCell tc7 = new TableCell();
        tc7.HorizontalAlign = HorizontalAlign.Center;
        tc7.Text = wbHeader.DeliveryBranch;
        tr2.Cells.Add(tc7);
        // tbl.Rows.Add(tr2);

        TableCell tc8 = new TableCell();
        tc8.HorizontalAlign = HorizontalAlign.Center;
        tc8.Text = "Waybill Date:";
        tr2.Cells.Add(tc8);
        //  tbl.Rows.Add(tr2);

        TableCell tc9 = new TableCell();
        tc9.HorizontalAlign = HorizontalAlign.Center;
        tc9.Text = wbHeader.WaybillDate;
        tr2.Cells.Add(tc9);
        tbl.Rows.Add(tr2);
        #endregion
        //row3
        #region
        TableRow tr3 = new TableRow();
        TableCell tc10 = new TableCell();
        tc10.ColumnSpan = 2;
        tc10.HorizontalAlign = HorizontalAlign.Center;
        tc10.Text = "Consignor:";
        tr3.Cells.Add(tc10);
        //tbl.Rows.Add(tr3);

        TableCell tc11 = new TableCell();
        tc11.ColumnSpan = 2;
        tc11.HorizontalAlign = HorizontalAlign.Center;
        tc11.Text = wbHeader.CustName;
        tr3.Cells.Add(tc11);
        //tbl.Rows.Add(tr3);

        TableCell tc12 = new TableCell();
        tc12.ColumnSpan = 2;
        tc12.HorizontalAlign = HorizontalAlign.Center;
        tc12.Text = "Consignee:";
        tr3.Cells.Add(tc12);
        //tbl.Rows.Add(tr3);

        TableCell tc13 = new TableCell();
        tc13.ColumnSpan = 2;
        tc13.HorizontalAlign = HorizontalAlign.Center;
        tc13.Text = wbHeader.ConsigneeName;
        tr3.Cells.Add(tc13);
        tbl.Rows.Add(tr3);
        #endregion
        //row4
        #region
        TableRow tr4 = new TableRow();
        TableCell tc14 = new TableCell();
        tc14.ColumnSpan = 2;
        tc14.RowSpan = 3;
        tc14.HorizontalAlign = HorizontalAlign.Center;
        tc14.Text = "Address:";
        tr4.Cells.Add(tc14);
        //tbl.Rows.Add(tr4);

        TableCell tc15 = new TableCell();
        tc15.ColumnSpan = 2;
        tc15.HorizontalAlign = HorizontalAlign.Center;
        tc15.Text = wbHeader.PickAddress;
        tr4.Cells.Add(tc15);
        //tbl.Rows.Add(tr4);

        TableCell tc16 = new TableCell();
        tc16.ColumnSpan = 2;
        tc16.RowSpan = 3;
        tc16.HorizontalAlign = HorizontalAlign.Center;
        tc16.Text = "Address:";
        tr4.Cells.Add(tc16);
        // tbl.Rows.Add(tr4);

        TableCell tc17 = new TableCell();
        tc17.ColumnSpan = 2;
        tc17.HorizontalAlign = HorizontalAlign.Center;
        tc17.Text = wbHeader.DelAddress;
        tr4.Cells.Add(tc17);
        tbl.Rows.Add(tr4);
        #endregion
        //row5
        #region
        TableRow tr5 = new TableRow();
        TableCell tc18 = new TableCell();
        tc18.ColumnSpan = 2;
        tc18.HorizontalAlign = HorizontalAlign.Center;
        tc18.Text = wbHeader.PickArea;
        tr5.Cells.Add(tc18);
        // tbl.Rows.Add(tr5);

        TableCell tc19 = new TableCell();
        tc19.ColumnSpan = 2;
        tc19.HorizontalAlign = HorizontalAlign.Center;
        tc19.Text = wbHeader.DelArea;
        tr5.Cells.Add(tc19);
        tbl.Rows.Add(tr5);
        #endregion
        //row6
        #region
        TableRow tr6 = new TableRow();
        TableCell tc20 = new TableCell();
        tc20.ColumnSpan = 2;
        tc20.HorizontalAlign = HorizontalAlign.Center;
        tc20.Text = wbHeader.PickPINCode;
        tr6.Cells.Add(tc20);
        // tbl.Rows.Add(tr6);

        TableCell tc21 = new TableCell();
        tc21.ColumnSpan = 2;
        tc21.HorizontalAlign = HorizontalAlign.Center;
        tc21.Text = wbHeader.DelPINCode;
        tr6.Cells.Add(tc21);
        tbl.Rows.Add(tr6);
        #endregion
        //row7
        #region
        TableRow tr7 = new TableRow();
        TableCell tc22 = new TableCell();
        tc22.ColumnSpan = 2;
        tc22.HorizontalAlign = HorizontalAlign.Center;
        tc22.Text = "Contact Person:";
        tr7.Cells.Add(tc22);
        // tbl.Rows.Add(tr7);

        TableCell tc23 = new TableCell();
        tc23.ColumnSpan = 2;
        tc23.HorizontalAlign = HorizontalAlign.Center;
        tc23.Text = "";
        tr7.Cells.Add(tc23);
        // tbl.Rows.Add(tr7);

        TableCell tc24 = new TableCell();
        tc24.ColumnSpan = 2;
        tc24.HorizontalAlign = HorizontalAlign.Center;
        tc24.Text = "Contact Person:";
        tr7.Cells.Add(tc24);
        //tbl.Rows.Add(tr7);

        TableCell tc25 = new TableCell();
        tc25.ColumnSpan = 2;
        tc25.HorizontalAlign = HorizontalAlign.Center;
        tc25.Text = "";
        tr7.Cells.Add(tc25);
        tbl.Rows.Add(tr7);
        #endregion
        //row8
        #region
        TableRow tr8 = new TableRow();
        TableCell tc26 = new TableCell();
        tc26.ColumnSpan = 2;
        tc26.HorizontalAlign = HorizontalAlign.Center;
        tc26.Text = "Phone:";
        tr8.Cells.Add(tc26);
        //tbl.Rows.Add(tr8);

        TableCell tc27 = new TableCell();
        tc27.ColumnSpan = 2;
        tc27.HorizontalAlign = HorizontalAlign.Center;
        tc27.Text = "";
        tr8.Cells.Add(tc27);
        // tbl.Rows.Add(tr8);

        TableCell tc28 = new TableCell();
        tc28.ColumnSpan = 2;
        tc28.HorizontalAlign = HorizontalAlign.Center;
        tc28.Text = "Phone:";
        tr8.Cells.Add(tc28);
        // tbl.Rows.Add(tr8);

        TableCell tc29 = new TableCell();
        tc29.ColumnSpan = 2;
        tc29.HorizontalAlign = HorizontalAlign.Center;
        tc29.Text = "";
        tr8.Cells.Add(tc29);
        tbl.Rows.Add(tr8);
        #endregion
        //row9
        #region
        TableRow tr9 = new TableRow();
        TableCell tc30 = new TableCell();
        tc30.ColumnSpan = 8;
        tc30.HorizontalAlign = HorizontalAlign.Center;
        tc30.Text = "";
        tr9.Cells.Add(tc30);
        tbl.Rows.Add(tr9);
        #endregion
        //row10
        #region
        TableRow tr10 = new TableRow();
        TableCell tc31 = new TableCell();
        tc31.ColumnSpan = 8;
        tc31.HorizontalAlign = HorizontalAlign.Center;
        tc31.Text = "Material Information:";
        tr10.Cells.Add(tc31);
        tbl.Rows.Add(tr10);
        #endregion
        //row11
        #region
        TableRow tr11 = new TableRow();
        TableCell tc32A = new TableCell(), tc32B = new TableCell(), tc32C = new TableCell(), tc32D = new TableCell(), tc32E = new TableCell(), tc32F = new TableCell(), tc32G = new TableCell(), tc32H = new TableCell();
        tc32A.Text = "SR.No."; tc32B.Text = "Invoice No"; tc32C.Text = "Invoice Date"; tc32D.Text = "Invoice Value"; tc32E.Text = "Material"; tc32F.Text = "Qty"; tc32G.Text = "Actual Weight"; tc32H.Text = "Charge Weight";
        tr11.Cells.Add(tc32A); tr11.Cells.Add(tc32B); tr11.Cells.Add(tc32C); tr11.Cells.Add(tc32D); tr11.Cells.Add(tc32E); tr11.Cells.Add(tc32F); tr11.Cells.Add(tc32G); tr11.Cells.Add(tc32H);
        tbl.Rows.Add(tr11);

        /*foreach (GridViewRow grvRow in gvFirstGrid.Rows)
        {
            TableRow trGrid = new TableRow();
            for (int iCell = 1; iCell <= grvRow.Cells.Count; iCell++)
            {
                if (iCell == 0 || iCell == 1 || iCell == 2 || iCell == 3 || iCell == 4 || iCell == 5 || iCell == 6 || iCell == 7)
                {
                    TableCell tcGrid = new TableCell();
                    tcGrid.Text = grvRow.Cells[iCell].Text;
                    trGrid.Cells.Add(tcGrid);
                }
            }
            tbl.Rows.Add(trGrid);
        }*/
        #endregion
        //row12
        #region
        TableRow tr12 = new TableRow();
        TableCell tc33 = new TableCell();
        tc33.ColumnSpan = 8;
        tc33.HorizontalAlign = HorizontalAlign.Center;
        tc33.Text = "";
        tr12.Cells.Add(tc33);
        tbl.Rows.Add(tr12);
        #endregion
        //row13
        #region
        TableRow tr13 = new TableRow();
        TableCell tc34 = new TableCell();
        tc34.ColumnSpan = 4;
        tc34.HorizontalAlign = HorizontalAlign.Center;
        tc34.Text = "";
        tr13.Cells.Add(tc34);
        // tbl.Rows.Add(tr13);

        TableCell tc35 = new TableCell();
        tc35.ColumnSpan = 2;
        tc35.HorizontalAlign = HorizontalAlign.Center;
        tc35.Text = "Mode of Transport:";
        tr13.Cells.Add(tc35);
        //tbl.Rows.Add(tr13);

        TableCell tc36 = new TableCell();
        tc36.ColumnSpan = 2;
        tc36.HorizontalAlign = HorizontalAlign.Center;
        tc36.Text = "";
        tr13.Cells.Add(tc36);
        tbl.Rows.Add(tr13);
        #endregion
        //row14
        #region
        TableRow tr14 = new TableRow();
        TableCell tc37 = new TableCell();
        tc37.ColumnSpan = 8;
        tc37.HorizontalAlign = HorizontalAlign.Center;
        tc37.Text = "";
        tr14.Cells.Add(tc37);
        tbl.Rows.Add(tr14);
        #endregion
        //row15
        #region
        TableRow tr15 = new TableRow();
        TableCell tc38 = new TableCell();
        tc38.ColumnSpan = 2;
        tc38.HorizontalAlign = HorizontalAlign.Center;
        tc38.Text = "Declaration:";
        tr15.Cells.Add(tc38);
        //tbl.Rows.Add(tr15);

        TableCell tc39 = new TableCell();
        tc39.ColumnSpan = 6;
        tc39.HorizontalAlign = HorizontalAlign.Center;
        tc39.Text = "";
        tr15.Cells.Add(tc39);
        tbl.Rows.Add(tr15);
        #endregion


        document.Add(pdfPTable);
        document.Close();
        byte[] bytes = memoryStream.ToArray();
        memoryStream.Close();
        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", "attachment; filename=WayBill.pdf");
        Response.ContentType = "application/pdf";
        Response.Buffer = true;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.BinaryWrite(bytes);
        Response.End();
        Response.Close();


        //// PDF Print
        /*        System.IO.MemoryStream memoryStream = new System.IO.MemoryStream(); 
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=Panel1.pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                StringWriter stringWriter = new StringWriter();
                HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);
                tbl.RenderControl(htmlTextWriter);
                StringReader stringReader = new StringReader(stringWriter.ToString());
                Document Doc = new Document(PageSize.A4, 10f, 10f, 100f, 10f);
                //HTMLWorker htmlparser = new HTMLWorker(Doc);
                Doc.Open();
                Doc.Add(pdfPTable);
                //htmlparser.Parse(stringReader);
                Doc.Close();

                //PdfWriter.GetInstance(Doc, Response.OutputStream);
                PdfWriter writer = PdfWriter.GetInstance(Doc, memoryStream);
                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();
                Response.Buffer = true;

                //Response.Write(Doc);
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "myscript", "window.open('Panel.pdf','MyPDFDocument','toolbar=1,location=1,status=1,scrollbars=1,menubar=1,resizable=1,left=10,top=10,width=860,height=640');", true);
                Response.BinaryWrite(bytes);
                Response.End();*/
    }
    protected void GenerateReport(object sender, EventArgs e)
    {
        //DataRow dr = GetData("SELECT * FROM Employees where EmployeeId = " + ddlEmployees.SelectedItem.Value).Rows[0]; ;
        Document document = new Document(PageSize.A4, 88f, 88f, 10f, 10f);
        iTextSharp.text.Font NormalFont = FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.NORMAL, BaseColor.BLACK);
        using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
        {
            PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
            Phrase phrase = null;
            PdfPCell cell = null;
            PdfPTable table = null;
            BaseColor color = null;

            document.Open();

            //Header Table
            table = new PdfPTable(2);
            table.TotalWidth = 500f;
            table.LockedWidth = true;
            table.SetWidths(new float[] { 0.3f, 0.7f });

            //Company Logo
            //cell = null;// ImageCell("~/images/northwindlogo.gif", 30f, PdfPCell.ALIGN_CENTER);
            //table.AddCell(cell);

            //Company Name and Address
            phrase = new Phrase();
            phrase.Add(new Chunk("Microsoft Northwind Traders Company\n\n", FontFactory.GetFont("Arial", 16, iTextSharp.text.Font.BOLD, BaseColor.RED)));
            phrase.Add(new Chunk("107, Park site,\n", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
            phrase.Add(new Chunk("Salt Lake Road,\n", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
            phrase.Add(new Chunk("Seattle, USA", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL, BaseColor.BLACK)));
            cell = PhraseCell(phrase, PdfPCell.ALIGN_LEFT);
            cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
            table.AddCell(cell);

            //Separater Line
            color = new BaseColor(Convert.ToInt32(System.Drawing.ColorTranslator.FromHtml("#A9A9A9")));
            //color = System.Drawing.ColorTranslator.FromHtml("#A9A9A9"); 
            DrawLine(writer, 25f, document.Top - 79f, document.PageSize.Width - 25f, document.Top - 79f, color);
            DrawLine(writer, 25f, document.Top - 80f, document.PageSize.Width - 25f, document.Top - 80f, color);
            document.Add(table);

            table = new PdfPTable(2);
            table.HorizontalAlignment = Element.ALIGN_LEFT;
            table.SetWidths(new float[] { 0.3f, 1f });
            table.SpacingBefore = 20f;

            //Employee Details
            cell = PhraseCell(new Phrase("Employee Record", FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.UNDERLINE, BaseColor.BLACK)), PdfPCell.ALIGN_CENTER);
            cell.Colspan = 2;
            table.AddCell(cell);
            cell = PhraseCell(new Phrase(), PdfPCell.ALIGN_CENTER);
            cell.Colspan = 2;
            cell.PaddingBottom = 30f;
            table.AddCell(cell);

            //Photo
            //cell = null;  //ImageCell(string.Format("~/photos/{0}.jpg", "1422"), 25f, PdfPCell.ALIGN_CENTER);
            //table.AddCell(cell);

            //Name
            phrase = new Phrase();
            phrase.Add(new Chunk("Mr" + " " + "Dushyant" + " " + "Totlani" + "\n", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.BOLD, BaseColor.BLACK)));
            phrase.Add(new Chunk("(" + "AGM" + ")", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.BOLD, BaseColor.BLACK)));
            cell = PhraseCell(phrase, PdfPCell.ALIGN_LEFT);
            cell.VerticalAlignment = PdfPCell.ALIGN_MIDDLE;
            table.AddCell(cell);
            document.Add(table);

            DrawLine(writer, 160f, 80f, 160f, 690f, color);
            DrawLine(writer, 115f, document.Top - 200f, document.PageSize.Width - 100f, document.Top - 200f, color);

            table = new PdfPTable(2);
            table.SetWidths(new float[] { 0.5f, 2f });
            table.TotalWidth = 340f;
            table.LockedWidth = true;
            table.SpacingBefore = 20f;
            table.HorizontalAlignment = Element.ALIGN_RIGHT;

            //Employee Id
            /*table.AddCell(PhraseCell(new Phrase("Employee code:", FontFactory.GetFont("Arial", 8, Font.BOLD, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            table.AddCell(PhraseCell(new Phrase("000" + dr["EmployeeId"], FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            cell = PhraseCell(new Phrase(), PdfPCell.ALIGN_CENTER);
            cell.Colspan = 2;
            cell.PaddingBottom = 10f;
            table.AddCell(cell);


            //Address
            table.AddCell(PhraseCell(new Phrase("Address:", FontFactory.GetFont("Arial", 8, Font.BOLD, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            phrase = new Phrase(new Chunk(dr["Address"] + "\n", FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)));
            phrase.Add(new Chunk(dr["City"] + "\n", FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)));
            phrase.Add(new Chunk(dr["Region"] + " " + dr["Country"] + " " + dr["PostalCode"], FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)));
            table.AddCell(PhraseCell(phrase, PdfPCell.ALIGN_LEFT));
            cell = PhraseCell(new Phrase(), PdfPCell.ALIGN_CENTER);
            cell.Colspan = 2;
            cell.PaddingBottom = 10f;
            table.AddCell(cell);

            //Date of Birth
            table.AddCell(PhraseCell(new Phrase("Date of Birth:", FontFactory.GetFont("Arial", 8, Font.BOLD, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            table.AddCell(PhraseCell(new Phrase(Convert.ToDateTime(dr["BirthDate"]).ToString("dd MMMM, yyyy"), FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            cell = PhraseCell(new Phrase(), PdfPCell.ALIGN_CENTER);
            cell.Colspan = 2;
            cell.PaddingBottom = 10f;
            table.AddCell(cell);

            //Phone
            table.AddCell(PhraseCell(new Phrase("Phone Number:", FontFactory.GetFont("Arial", 8, Font.BOLD, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            table.AddCell(PhraseCell(new Phrase(dr["HomePhone"] + " Ext: " + dr["Extension"], FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            cell = PhraseCell(new Phrase(), PdfPCell.ALIGN_CENTER);
            cell.Colspan = 2;
            cell.PaddingBottom = 10f;
            table.AddCell(cell);

            //Addtional Information
            table.AddCell(PhraseCell(new Phrase("Addtional Information:", FontFactory.GetFont("Arial", 8, Font.BOLD, Color.BLACK)), PdfPCell.ALIGN_LEFT));
            table.AddCell(PhraseCell(new Phrase(dr["Notes"].ToString(), FontFactory.GetFont("Arial", 8, Font.NORMAL, Color.BLACK)), PdfPCell.ALIGN_JUSTIFIED));
            */
            document.Add(table);
            document.Close();
            byte[] bytes = memoryStream.ToArray();
            memoryStream.Close();
            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "attachment; filename=Employee.pdf");
            Response.ContentType = "application/pdf";
            Response.Buffer = true;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(bytes);
            Response.End();
            Response.Close();
        }
    }
    private static void DrawLine(PdfWriter writer, float x1, float y1, float x2, float y2, BaseColor color)
    {
        PdfContentByte contentByte = writer.DirectContent;
        contentByte.SetColorStroke(color);
        contentByte.MoveTo(x1, y1);
        contentByte.LineTo(x2, y2);
        contentByte.Stroke();
    }
    private static PdfPCell PhraseCell(Phrase phrase, int align)
    {
        PdfPCell cell = new PdfPCell(phrase);
        cell.BorderColor = BaseColor.WHITE;
        cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
        cell.HorizontalAlignment = align;
        cell.PaddingBottom = 2f;
        cell.PaddingTop = 0f;
        return cell;
    }
    private static PdfPCell ImageCell(string path, float scale, int align)
    {
        iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath(path));
        image.ScalePercent(scale);
        PdfPCell cell = new PdfPCell(image);
        cell.BorderColor = BaseColor.WHITE;
        cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
        cell.HorizontalAlignment = align;
        cell.PaddingBottom = 0f;
        cell.PaddingTop = 0f;
        return cell;
    }

}