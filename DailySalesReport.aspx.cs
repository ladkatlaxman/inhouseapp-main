using System;
using System.Data; 
using System.Net; 
using System.Net.Mail;
using System.Text;

public partial class DailySalesReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        (new SendMail()).AreaSalesReport(); 
        //(new SendMail()).BranchSalesReport(); 
        (new SendMail()).WayBillMissingReport(); 
        #region AreaSales Report
        /*        StringBuilder strBody;
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
                        <td colspan=3>Cumulative Booking till " + strDateTime  + @" 
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
                    MailExecute(strBody.ToString(), dr["EMailAddress"].ToString());*/
        #endregion
    }

    public void MailExecute(string sBody, string sTo)
    {
        using (var message = new MailMessage("noreplydexters@gmail.com", sTo))
        {
            message.Subject = "Daily Sales Report"; 
            message.Body = sBody;
            message.IsBodyHtml = true;

            using (SmtpClient client = new SmtpClient
            {
                DeliveryMethod = SmtpDeliveryMethod.Network, 
                UseDefaultCredentials = false, 
                EnableSsl = true, 
                //EnableTtl = true, 
                //UseTls = ClientTlsMode.Explicit, 
                Host = "smtp.gmail.com", 
                Port = 587, 
                Credentials =  new  NetworkCredential("noreplydexters@gmail.com", "NoReply!123") 
            })
            {
                client.Send(message);
            }
        }
    }
}