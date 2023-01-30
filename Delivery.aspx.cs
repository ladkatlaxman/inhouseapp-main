using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Delivery : System.Web.UI.Page
{
    public static string itemQty = null, waybillNo = null, date = null, deliveryBranch = null, pickupBranch = null, materialName = null, packageName = null, valueActualWeight = null, loadedQty = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)                                                                                  
            {
                GetDeliveryVehicleList();             
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
    public void GetDeliveryVehicleList()
    {
        List<VehicleRequestProperties> var = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 3, "PD");
        var.AddRange((new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 4, "PD")); 
        Ddl_SelectVehicle.DataSource = var;
        Ddl_SelectVehicle.DataTextField = "VehicleNo";
        Ddl_SelectVehicle.DataValueField = "VehicleRequestID";
        Ddl_SelectVehicle.DataBind();
        Ddl_SelectVehicle.Items.Insert(0, "SELECT");
    }
    protected void btnGetDetails_Click(object sender, EventArgs e)
    {
        if (Ddl_SelectVehicle.SelectedItem.Text != "SELECT")
        {
	        lblDRSNo.Text = "DELIVERY RUN SHEET";	
            string strPickDel = "D" + (Convert.ToInt32(Ddl_SelectVehicle.SelectedValue) + 100000000).ToString().Substring(1);	
            lblDRSNo.Text = strPickDel;
            //gvwDeliveryWaybills.DataSource = (new LoadingUnloadingFunctions()).GetFinalDeliveryUnloadWayBillDetails(Ddl_SelectVehicle.SelectedValue,Session["BranchId"].ToString());
            //gvwDeliveryWaybills.DataBind();

            List<WayBillDetails> DeliveryWayBill = (new LoadingUnloadingFunctions()).GetFinalDeliveryUnloadWayBillDetails(Ddl_SelectVehicle.SelectedValue, Session["BranchId"].ToString());
            gvwDeliveryWaybills.DataSource = DeliveryWayBill;
            gvwDeliveryWaybills.DataBind();
            Lbl_TotalQty.Text = (DeliveryWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
            Lbl_TotalWeight.Text = (DeliveryWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();


            DeliveredItems.Visible = true;
            DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_SelectVehicle.SelectedValue), 8, Session["branchId"].ToString());
            Int32 intDeliveryQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
            decimal dblDeliveryWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
            Lbl_TotalLoadedQty.Text = intDeliveryQty.ToString();
            Lbl_TotalLoadedWeight.Text = dblDeliveryWT.ToString();
            GV_DeliveredWaybillItems.DataSource = dt;
            GV_DeliveredWaybillItems.DataBind();
            ViewState["DeliveredData"] = dt;
        }
        else
        {
            gvwDeliveryWaybills.DataSource = null;
            gvwDeliveryWaybills.DataBind();
            GV_DeliveredWaybillItems.DataSource = null;
            GV_DeliveredWaybillItems.DataBind();
        }
    }
    private void BindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("wayBillNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("WaybillDate", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("materialName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("typeOfPackage", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("valueActualWt", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Qty", typeof(String)));

        if (ViewState["DeliveredData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["DeliveredData"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = waybillNo;
            dr[1] = date;
            dr[2] = materialName;
            dr[3] = packageName;
            dr[4] = valueActualWeight;
            dr[5] = loadedQty;
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = waybillNo;
            dr[1] = date;
            dr[2] = materialName;
            dr[3] = packageName;
            dr[4] = valueActualWeight;
            dr[5] = loadedQty;
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["DeliveredData"] != null)
        {
            GV_DeliveredWaybillItems.DataSource = (DataTable)ViewState["DeliveredData"];
            GV_DeliveredWaybillItems.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_DeliveredWaybillItems.DataSource = dt;
            GV_DeliveredWaybillItems.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["DeliveredData"] = dt;
    }
    protected void gvwDeliveryWaybills_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DELIVERY")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvwDeliveryWaybills.Rows[rowIndex];
            string payment = row.Cells[6].Text.ToString();
            if (payment != "TOPAY")
            {
                WaybillItemStatus wb = new WaybillItemStatus();
                wb.WayBillItemId = Convert.ToInt32(row.Cells[1].Text);
                wb.statusID = 8;
                string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
                wb.itemQty = Convert.ToInt32(qty);
                wb.createdDateTime = new CFunctions().CurrentDateTime();
                wb.branchID = Convert.ToInt32(Session["branchId"]);
                wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue.ToString());
                wb.userID = Convert.ToInt32(Session["userID"]);
                wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                wb.Reason = ""; 
                string remQty = row.Cells[12].Text;
                Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

                if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
                {
                    Lblerror.Text = "Enter correct Qty";
                }
                else
                {
                    bool alertMsg = (new LoadingUnloadingFunctions()).changeUnloadStatus(wb);
                    if (alertMsg)
                    {
                        waybillNo = row.Cells[3].Text.ToString();
                        date = row.Cells[5].Text.ToString();
                        materialName = row.Cells[7].Text.ToString();
                        packageName = row.Cells[8].Text.ToString();
                        valueActualWeight = row.Cells[10].Text.ToString();
                        loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                        if (ViewState["DeliveredData"] != null)
                        {
                            DataTable dt = (DataTable)ViewState["DeliveredData"];
                            int count = dt.Rows.Count;
                            BindGrid(count);
                        }
                        else
                        {
                            BindGrid(1);
                        }

                        waybillNo = null;
                        date = null;
                        materialName = null;
                        packageName = null;
                        valueActualWeight = null;
                        itemQty = null;
                        loadedQty = null;
                       
                    }
                    btnGetDetails_Click(sender, e);
                }
            }
            else
            {
                string ToPayReceived = null;
                int WayBillItemId = Convert.ToInt32(row.Cells[1].Text);
                IDataReader reader = (new LoadingUnloadingFunctions()).CheckToPayStatus(WayBillItemId);
                while (reader.Read())
                {
                     ToPayReceived = reader["isToPayReceived"].ToString(); 
                }
                if(ToPayReceived == "YES")
                {
                    WaybillItemStatus wb = new WaybillItemStatus();
                    wb.WayBillItemId = Convert.ToInt32(row.Cells[1].Text);
                    wb.statusID = 8;
                    string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
                    wb.itemQty = Convert.ToInt32(qty);
                    wb.createdDateTime = new CFunctions().CurrentDateTime();
                    wb.branchID = Convert.ToInt32(Session["branchId"]);
                    wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue.ToString());
                    wb.userID = Convert.ToInt32(Session["userID"]);
                    wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
	            wb.Reason = ""; 
                    string remQty = row.Cells[12].Text;
                    Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);
                    //------------ Deps Entry------------------
                    DEPSDetail deps = new DEPSDetail();
                    deps.depsType = (row.FindControl("Ddl_DepsType") as DropDownList).SelectedValue;
                    string depsqty = (row.FindControl("DEPSQty") as TextBox).Text;
                    if (depsqty != "")
                    {
                        deps.itemQty = Convert.ToInt32(depsqty);
                    }
                    if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
                    {
                        Lblerror.Text = "Enter correct Qty";
                    }
                    else
                    {
                        bool alertMsg = (new LoadingUnloadingFunctions()).changeUnloadStatus(wb);
                        if (alertMsg)
                        {
                            waybillNo = row.Cells[3].Text.ToString();
                            date = row.Cells[5].Text.ToString();
                            materialName = row.Cells[7].Text.ToString();
                            packageName = row.Cells[8].Text.ToString();
                            valueActualWeight = row.Cells[10].Text.ToString();
                            loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                            if (ViewState["DeliveredData"] != null)
                            {
                                DataTable dt = (DataTable)ViewState["DeliveredData"];
                                int count = dt.Rows.Count;
                                BindGrid(count);
                            }
                            else
                            {
                                BindGrid(1);
                            }

                            waybillNo = null;
                            date = null;
                            materialName = null;
                            packageName = null;
                            valueActualWeight = null;
                            itemQty = null;
                            loadedQty = null;
                            if (depsqty != "")
                            {
                                bool depsMsg = (new PickReqFunctions()).SaveDeps(wb, deps);
                            }
                        }
                        btnGetDetails_Click(sender, e);
                    }
                }
                else
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "msg", "alert('To Pay Amount not Received')", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage", "alert('To Pay Amount not Received');", true);
                }
            }
        }
        if (e.CommandName == "ToPay")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvwDeliveryWaybills.Rows[rowIndex];
            PickReq pr = new PickReq();
            string payment = row.Cells[6].Text.ToString();
            if(payment == "TOPAY")
            {
                int WayBillItemId = Convert.ToInt32(row.Cells[1].Text);
                bool alertMsg = (new LoadingUnloadingFunctions()).ToPayPaymentReceived(WayBillItemId);
                if(alertMsg)
                {
                    (new CFunctions()).showalert("Button_Tab1Save", "RECEIVED", this);
                }
            }
        }
    }

    protected void gvwDeliveryWaybills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell qty = e.Row.Cells[4];
            Label lbl = (Label)e.Row.FindControl("Lbl_Unloaded");
            LinkButton btn = (LinkButton)e.Row.FindControl("Btn_Unload");
            if (qty.Text == "0")
            {
                lbl.Text = "DELIVERED";
                btn.Visible = false;
            }
            TableCell payment = e.Row.Cells[15];
            if(payment.Text != "TOPAY")
            {
                LinkButton btn_Payment = (LinkButton)e.Row.FindControl("Btn_Payment");
                btn_Payment.ForeColor = System.Drawing.Color.Black;
               
            }
        }
    }

		
    protected void btnPrintDRS_Click(object sender, EventArgs e)	
    {	
        string strType = "DRS";	
        string strPopup = "<script language='javascript' ID='printScript'>"	
        // Passing intId to popup window.	
        + "var w = window.open('PrintScreen.aspx?Type=" + strType + "&Value=" + Ddl_SelectVehicle.SelectedValue.ToString()	
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "	
        + "w.window.print();"	
        + "</script>";	
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);	
    }

    //protected void Btn_VehicleClose_Click(object sender, EventArgs e)
    //{
    //    #region
    //    //http://122.170.111.196:2020/PODSCANNING///2294536.JPG
    //    ////***********************************************************************************************************************************************
    //    //var str= "http://122.170.111.196:2020/PODSCANNING///";
    //    //var url = str + "2294536" + (".JPG");
    //    //var str = "http://192.168.1.84:2727/images/";
    //    //var url = str + "dexterLogo" + ".png";
    //    //HttpWebResponse response = null;
    //    //var request = (HttpWebRequest)WebRequest.Create(url);
    //    //request.Method = "HEAD";
    //    //try
    //    //{
    //    //    response = (HttpWebResponse)request.GetResponse();
    //    //    HttpStatusCode status = response.StatusCode;
    //    //    lblMsg.Text = "File Already Exist";
    //    //}
    //    //catch (WebException ex)
    //    //{
    //    //    /* A WebException will be thrown if the status of the response is not `200 OK` */
    //    //    lblMsg.Text = "File Does not Exist";
    //    //}
    //    //finally
    //    //{
    //    //    // Don't forget to close your response.
    //    //    if (response != null)
    //    //    {
    //    //        response.Close();
    //    //    }
    //    //}
    //    #endregion
    //    if(Ddl_SelectVehicle.SelectedItem.Text!="SELECT")
    //    {
    //        List<PickReq> pr = new List<PickReq>();
    //        pr = (new LoadingUnloadingFunctions()).GetWaybillListForPOD(Convert.ToInt32(Ddl_SelectVehicle.SelectedValue)); //
    //        int waybillCount = pr.Count;
    //        for (int i = 0; i < waybillCount; i++)
    //        {
    //            int waybillNo = pr[i].WaybillNo;

    //            var str = "http://192.168.1.84:2727/images/";
    //            var url = str + waybillNo + ".png";
    //            HttpWebResponse response = null;
    //            var request = (HttpWebRequest)WebRequest.Create(url);
    //            request.Method = "HEAD";
    //            try
    //            {
    //                response = (HttpWebResponse)request.GetResponse();
    //                HttpStatusCode status = response.StatusCode;
    //                if (i == waybillCount)
    //                {
    //                    VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
    //                    int intResult = new LoadingUnloadingFunctions().SetVehicleClose(Ddl_SelectVehicle.SelectedValue, Session["userID"].ToString(),
    //                                                    Session["BranchId"].ToString(), (new CFunctions()).CurrentDateTime().ToUpper());
    //                    if (intResult == 1)
    //                    {
    //                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vehicle Has been closed.')", true);
    //                    }
    //                }
    //                continue;
    //            }
    //            catch (WebException ex)
    //            {
    //                /* A WebException will be thrown if the status of the response is not `200 OK` */
    //                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('First Upload POD')", true);
    //                //    lblMsg.Text = "First Upload POD";
    //                break;
    //            }
    //            finally
    //            {
    //                // Don't forget to close your response.
    //                if (response != null)
    //                {
    //                    response.Close();
    //                }
    //            }

    //        }
    //    }
    //}
}