using System;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Text;

/// <summary>
/// Summary description for 
/// </summary>
public class SendMail
{
    public SendMail()
    {
        //
        // TODO: Add constructor logic here
        //
    }

     public void AreaSalesReport()
    {
        StringBuilder strBody;
        string strDateTime = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
        IDataReader dr = (new DashBoard()).ReportAreaBookings(strDateTime);

        while (dr.Read())
        {
            strBody = new StringBuilder();
            strBody.Append(@"<html><body><Table border=1>
            <tr>
                <td colspan=2>Sales Report for the Region
                </td> 
                <td colspan=5> 
                    " + dr["Area"].ToString() + @"
                </td>  
            </tr> 
            <tr> 
                <td colspan=2>Sales Target for the Month 
                </td> 
                <td> 
                    " + dr["Target"].ToString() + @" 
                </td> 
                <td colspan=2>Cumulative date Target 
                </td> 
                <td> 
                    " + dr["Target Till Date"].ToString() + @" 
                </td>
                <td>&nbsp;</td> 
            </tr> 
            <tr> 
                <td colspan=2>Report Date 
                </td> 
                <td colspan=5> 
                    " + DateTime.Now.ToString("dd/MM/yyyy") + @" 
                </td> 
            </tr> 
            <tr> 
                <td colspan=3>Booking for " + strDateTime + @" 
                </td> 
                <td colspan=3>Cumulative Booking till " + strDateTime + @" 
                </td> 
                <td>&nbsp;</td> 
            </tr> 
            <tr> 
                <td> 
                    Tonnage
                </td> 
                <td> 
                    Packages 
                </td> 
                <td>
                    Freight
                </td> 
                <td> 
                    Tonnage 
                </td> 
                <td> 
                    Packages 
                </td> 
                <td>
                    Freight
                </td> 
                <td>
                    Variance
                </td> 
            </tr> 
            <tr> 
                <td> 
                    " + dr["Weight Yesterday"].ToString() + @" 
                </td> 
                <td> 
                    " + dr["Packages Yesterday"].ToString() + @" 
                </td> 
                <td>
                    " + dr["Freight Yesterday"].ToString() + @"  
                </td> 
                <td> 
                    " + dr["Weight"].ToString() + @" 
                </td> 
                <td> 
                    " + dr["Packages"].ToString() + @" 
                </td> 
                <td>
                    " + dr["Freight"].ToString() + @"  
                </td> 
                <td>
                    " + dr["Variance"].ToString() + @"  
                </td> 
            </tr> 
            </Table>
            &nbsp; &nbsp; Data May not be Accurate 
            </body></html>");
            //MailExecute(strBody.ToString(), "ithead@dexters.co.in");
            MailExecute(strBody.ToString(), dr["EMailAddress"].ToString());
        }

    }

    public void BranchSalesReport()
    {
        StringBuilder strBody, strBranchBody;
        double dPaidWayBillCount = 0, dPaidNoOfPkg = 0, dPaidActualWgt = 0, dPaidChargedWt = 0, dPaidFreight = 0;
        double dToPayWayBillCount = 0, dToPayNoOfPkg = 0, dToPayActualWgt = 0, dToPayChargedWt = 0, dToPayFreight = 0;

        string strDateTime = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy"), strTable = "";
        strBody = new StringBuilder();
        strBranchBody = new StringBuilder();
        strBody.Append(@"<!DOCTYPE html>
                    <html>
                    <style>
                        table, th, td {
                            border: 1px solid black;
                            font-family: Calibri;
                            border-collapse: collapse;
                            padding: 4px;
                            font-size: 14px;
                            text-justify: inter-word;
                        }
                    </style>
                    <body>
                    <Table border=0><tr><td>
                    <table><tr><td>Branches Sales Report</td></tr>
                    <tr><td>Report for the Date : " + DateTime.Now.ToString("dd/MM/yyyy") + @"</td></tr></table> 
                    </td></tr>
                    <tr><td>
                    <table><tr>");

        IDataReader dr = (new DashBoard()).ReportBranchBookings(strDateTime);

        strBody.Append(@"<th>Branch</th>");
        strBody.Append(@"<th>Customer</th>");
        strBody.Append(@"<th>WayBill Count</th>");
        strBody.Append(@"<th>No of Package</th>");
        strBody.Append(@"<th>Actual Weight</th>");
        strBody.Append(@"<th>Charged Weight</th>");
        strBody.Append(@"<th>Freight</th>");

        strBranchBody.Append(strBody.ToString()); 

        while (dr.Read())
        {
            /*strBody.Append(@"<tr>");
            strBody.Append(@"<td>" + dr["Branch"] + @"</td>"); 
            strBody.Append(@"<td>" + dr["Customer"] + @"</td>"); 
            strBody.Append(@"<td>" + dr["WayBill Count"] + @"</td>"); 
            strBody.Append(@"<td>" + dr["Packages"] + @"</td>"); 
            strBody.Append(@"<td>" + dr["Actual Weight"] + @"</td>"); 
            strBody.Append(@"<td>" + dr["Charged Weight"] + @"</td>"); 
            strBody.Append(@"<td>" + dr["Freight"] + @"</td>");
            strBody.Append(@"</tr>");*/
            strTable = "<tr>" + @"<td>" + dr["Branch"] + @"</td>" +
                @"<td style='word-wrap: break-word; '>" + dr["Customer"] + @"</td>" + 
                @"<td style='text-align:right'>" + dr["WayBill Count"] + @"</td>" + 
                @"<td style='text-align:right'>" + dr["Packages"] + @"</td>" + 
                @"<td style='text-align:right'>" + dr["Actual Weight"] + @"</td>" + 
                @"<td style='text-align:right'>" + dr["Charged Weight"] + @"</td>" + 
                @"<td style='text-align:right'>" + dr["Freight"] + @"</td></tr>"; 
            strBody.Append(strTable); 
            if(dr["Branch"].ToString().Trim() != "")
            {
                strBranchBody.Append(strTable); 
            }
            if(dr["Customer"].ToString() == "PAID")
            {
                dPaidWayBillCount += Convert.ToDouble(dr["WayBill Count"]);
                dPaidNoOfPkg += Convert.ToDouble(dr["Packages"]);
                dPaidActualWgt += Convert.ToDouble(dr["Actual Weight"]);
                dPaidChargedWt += Convert.ToDouble(dr["Charged Weight"]);
                dPaidFreight += Convert.ToDouble(dr["Freight"]);
            }
            if (dr["Customer"].ToString() == "TO PAY")
            {
                dToPayWayBillCount += Convert.ToDouble(dr["WayBill Count"]);
                dToPayNoOfPkg += Convert.ToDouble(dr["Packages"]);
                dToPayActualWgt += Convert.ToDouble(dr["Actual Weight"]);
                dToPayChargedWt += Convert.ToDouble(dr["Charged Weight"]);
                dToPayFreight += Convert.ToDouble(dr["Freight"]);
            }
        }

        strBody.Append(@" </td> </tr> </table> 
            </td> </tr> </Table> 
            &nbsp; &nbsp; Data May not be Accurate 
            </body> </html>");

        strBranchBody.Append(@"<tr>" + @"<td>Total</td>" +
                @"<td>PAID</td>" +
                @"<td style='text-align:right'>" + dPaidWayBillCount + @"</td>" +
                @"<td style='text-align:right'>" + dPaidNoOfPkg + @"</td>" +
                @"<td style='text-align:right'>" + dPaidActualWgt + @"</td>" +
                @"<td style='text-align:right'>" + dPaidChargedWt + @"</td>" +
                @"<td style='text-align:right'>" + dPaidFreight + @"</td></tr>" +
                @"<tr>" + @"<td>Total</td>" +
                @"<td>TO PAY</td>" +
                @"<td style='text-align:right'>" + dToPayWayBillCount + @"</td>" +
                @"<td style='text-align:right'>" + dToPayNoOfPkg + @"</td>" +
                @"<td style='text-align:right'>" + dToPayActualWgt + @"</td>" +
                @"<td style='text-align:right'>" + dToPayChargedWt + @"</td>" +
                @"<td style='text-align:right'>" + dToPayFreight + @"</td></tr>");
        strBranchBody.Append(@" </td> </tr> </table> 
            </td> </tr> </Table> 
            &nbsp; &nbsp; Data May not be Accurate 
            </body> </html>");

        MailExecute(strBranchBody.ToString(), "ithead@dexters.co.in, sudip.sinha@dexters.co.in");
        MailExecute(strBody.ToString(), "ithead@dexters.co.in, sudip.sinha@dexters.co.in");
        MailExecute(strBranchBody.ToString(), "dinesh.singh@dexters.co.in");
        MailExecute(strBody.ToString(), "dinesh.singh@dexters.co.in");
    }

    public void WayBillMissingReport()
    {
        StringBuilder strBody;
        string strFromDate = @"01/" + DateTime.Now.AddMonths(-1).ToString("MM") + @"/" + DateTime.Now.AddMonths(-1).ToString("yyyy");
        string strDateTime = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy"), strTable = "";
        string strBranchId = "", strBranchName = "", strBranchEMailId = "";
        bool bAvailable = false; 
        
        IDataReader drBranch = (new DashBoard()).getBranchEmailList();
        while (drBranch.Read())
        {
            strBranchId = drBranch["BranchId"].ToString();
            strBranchName = drBranch["BranchName"].ToString();
            strBranchEMailId = drBranch["BranchEMail"].ToString(); ;
            IDataReader dr = (new DashBoard()).getStationaryDates(strBranchId, strFromDate, strDateTime);

            strBody = new StringBuilder();
            strBody.Append(@"<!DOCTYPE html>
                    <html>
                    <style>
                        table, th, td {
                            border: 1px solid black;
                            font-family: Calibri;
                            border-collapse: collapse;
                            padding: 4px;
                            font-size: 14px;
                            text-justify: inter-word;
                        }
                    </style>
                    <body>
                    <Table border=0><tr><td>
                    <table><tr><td>Missing WayBill List</td></tr>
                    <tr><td>&nbsp;</td></tr></table> 
                    </td></tr>
                    <tr><td>
                    <table><tr>");

            strBody.Append(@"<th>Starting No</th>");
            strBody.Append(@"<th>Ending no</th>");
            strBody.Append(@"<th>Unused</th>");

            while (dr.Read())
            {
                if (dr["Unused"].ToString() != "")
                {
                    bAvailable = true;
                    strTable = "<tr>" +
                        @"<td style='text-align:right'>" + dr["StartingNo"].ToString() + @"</td>" +
                        @"<td style='text-align:right'>" + dr["EndingNo"] + @"</td>" +
                        @"<td style='text-align:right'>" + dr["Unused"] + @"</td>" +
                        "</tr>";
                    strBody.Append(strTable);
                }
            }

            strBody.Append(@" </td> </tr> </table> 
                        <br /> 
                        &nbsp; &nbsp; &nbsp; &nbsp; Please check the Unused Waybills list and reply back to concerned email id's.
                        </td> </tr> </Table> 
                        </body> </html>");

            if(bAvailable)
                MailExecute(strBody.ToString(), strBranchEMailId, null, "Missing Waybill Report for Date : " + strDateTime + @" for Branch: " + strBranchName); 
            bAvailable = false; 
        }
    }
    public void MailExecuteNew(string sBody, string sTo, string fileName = null, string strSubject = null)
    {
        using (var message = new MailMessage("noreply@dexters.co.in", sTo))
        //using (var message = new MailMessage("noreply@dexters.co.in", "ithead@dexters.co.in"))
        {
            if (strSubject == null) message.Subject = "Daily Sales Report";
            else message.Subject = strSubject;
            message.Body = sBody;
            message.IsBodyHtml = true;

            if (fileName != null)
            {
                Attachment attach = new Attachment(fileName);
                message.Attachments.Insert(0, attach);
            }
            using (SmtpClient client = new SmtpClient
            {
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                EnableSsl = true,
                //EnableTtl = true, 

                //UseTls = ClientTlsMode.Explicit, 

                //Gmail Settings 
                //Host = "smtp.gmail.com",
                //Port = 587,

                //Zoho Mail Settings 
                Host = "smtp.zoho.in",
                Port = 587,

                Credentials = new NetworkCredential("noreply@dexters.co.in", "NoReply@@123#")
            })
            {
                client.Send(message);
            }
        }
    }

    public void MailExecute(string sBody, string sTo, string fileName = null, string strSubject= null)
    {
        using (var message = new MailMessage("noreply@dexters.co.in", sTo))
	    //using (var message = new MailMessage("noreply@dexters.co.in", "ithead@dexters.co.in"))
        {   
            if (strSubject == null) message.Subject = "Daily Sales Report";
            else message.Subject = strSubject; 
            message.Body = sBody;
            message.IsBodyHtml = true;

            if (fileName != null)
            {
                Attachment attach = new Attachment(fileName);
                message.Attachments.Insert(0, attach);
            }
            using (SmtpClient client = new SmtpClient
            {
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                EnableSsl = true,
                //EnableTtl = true, 

                //UseTls = ClientTlsMode.Explicit, 

                //Gmail Settings 
                //Host = "smtp.gmail.com",
                //Port = 587,

                //Zoho Mail Settings 
                Host = "smtp.zoho.in",
                Port = 587,

                Credentials = new NetworkCredential("noreply@dexters.co.in", "NoReply@@123#")
            })
            {
                client.Send(message);
            }
        }
    }

    public void MailExecuteOld(string sBody, string sTo)
    {
        //using (var message = new MailMessage("noreplydexters@gmail.com", sTo))
        //using (var message = new MailMessage("noreply@dexters.co.in", sTo))
        using (var message = new MailMessage("noreply@dexters.co.in", "ithead@dexters.co.in"))
        {
            message.Subject = "Daily Sales Report";
            message.Body = sBody;
            message.IsBodyHtml = true;

            using (SmtpClient client = new SmtpClient
            {
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                //EnableSsl = true,
                //EnableTtl = true, 
                
                //UseTls = ClientTlsMode.Explicit, 

                //Gmail Settings 
                //Host = "smtp.gmail.com",
                //Port = 587,

                //Zoho Mail Settings 
                //Host = "smtp.zoho.in",
                //Port = 587,
		Host = "relay-hosting.secureserver.net:25",
		//Port = 25,
                Credentials = new NetworkCredential("noreply@dexters.co.in", "NoReply@@123#")
            })
            {
                client.Send(message);
            }
        }
    }
}