using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

public partial class ERP_Folder_AdminMasterPage : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    SqlCommand cmd = null;
    SqlDataReader dr = null;
    protected void Page_Load(object sender, EventArgs e)
    {
	lnkInvoicing.Visible = false; 
        CFunctions.setjavascript("$(document).ready(function() { " + "\n" +
                 " $('.dropdown-submenu a.test').on(\"click\", function(e) { " + "\n" +
                 "    $(this).next('ul').toggle(); " + "\n" +
                 " e.stopPropagation(); " + "\n" +
                 " e.preventDefault(); " + "\n" +
                 " });" + "\n" +
                  "$('ul.dropdown-menu[data-toggle=dropdown]').on('click', function(event) {" + "\n" +
                  "event.preventDefault();" + "\n" +
                  "event.stopPropagation();" + "\n" +
                  "$(this).parent().siblings().removeClass('open');" + "\n" +
                  "$(this).parent().toggleClass('open');" + "\n" +
                  "});" + "\n");
        if (Session["userBranch"] != null)
        {
            lblBranch.Text = "Branch : " + Session["userBranch"].ToString();
            con.Open();

            //if (Session["userID"].ToString() == "5" || Session["userID"].ToString() == "109" || Session["userID"].ToString() == "119" || Session["userID"].ToString() == "188") lnkInvoicing.Visible = true; 

            cmd = new SqlCommand("ssp_GetAccessPageListByUserID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@userID", Session["userID"].ToString());

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            //int i = cmd.ExecuteNonQuery();
            con.Close();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["AccessMenuName"].Equals("Booking"))
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    booking.Controls.Add(li);

                    HtmlGenericControl anchor = new HtmlGenericControl("a");
                    anchor.Attributes.Add("href", dt.Rows[i]["AccessPage"].ToString());
                    anchor.InnerText = dt.Rows[i]["AccessName"].ToString();

                    li.Controls.Add(anchor);
                }
                else if (dt.Rows[i]["AccessMenuName"].Equals("PickUp/Delivery"))
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    pick_del.Controls.Add(li);

                    HtmlGenericControl anchor = new HtmlGenericControl("a");
                    anchor.Attributes.Add("href", dt.Rows[i]["AccessPage"].ToString());
                    anchor.InnerText = dt.Rows[i]["AccessName"].ToString();

                    li.Controls.Add(anchor);
                }
                else if (dt.Rows[i]["AccessMenuName"].Equals("Transhipment"))
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    transhipment.Controls.Add(li);

                    HtmlGenericControl anchor = new HtmlGenericControl("a");
                    anchor.Attributes.Add("href", dt.Rows[i]["AccessPage"].ToString());
                    anchor.InnerText = dt.Rows[i]["AccessName"].ToString();

                    li.Controls.Add(anchor);
                }
                else if (dt.Rows[i]["AccessMenuName"].Equals("Masters"))
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    masters.Controls.Add(li);

                    HtmlGenericControl anchor = new HtmlGenericControl("a");
                    anchor.Attributes.Add("href", dt.Rows[i]["AccessPage"].ToString());
                    anchor.InnerText = dt.Rows[i]["AccessName"].ToString();

                    li.Controls.Add(anchor);
                }
                else if (dt.Rows[i]["AccessMenuName"].Equals("Admin"))
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    admin.Controls.Add(li);

                    HtmlGenericControl anchor = new HtmlGenericControl("a");
                    anchor.Attributes.Add("href", dt.Rows[i]["AccessPage"].ToString());
                    anchor.InnerText = dt.Rows[i]["AccessName"].ToString();

                    li.Controls.Add(anchor);
                }
                else if (dt.Rows[i]["AccessMenuName"].Equals("Invoicing"))
                {
		    lnkInvoicing.Visible = true;
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    Invoicing.Controls.Add(li);
                    
                    HtmlGenericControl anchor = new HtmlGenericControl("a");
                    anchor.Attributes.Add("href", dt.Rows[i]["AccessPage"].ToString());
                    anchor.InnerText = dt.Rows[i]["AccessName"].ToString();

                    li.Controls.Add(anchor);
                }
            }
        }
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
        if (Session["userBranch"] != null) lblBranch.Text = "Branch : " + Session["userBranch"].ToString();
    }
    protected void lblWayBillLink_Click(object sender, EventArgs e)
    {
        Server.Transfer("ReportDataOne.aspx?value=WAYBILLTRACKING"); 
    }
}
