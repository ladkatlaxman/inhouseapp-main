using System;
using System.Web.UI.WebControls;
using BLFunctions;
using System.Web; 
using System.Web.UI;
using BLProperties;
using System.Collections.Generic;
using System.Net;
using System.Data;
using System.Web.Services;
using System.Linq;

public partial class PickUPUnload : System.Web.UI.Page
{
    public static string itemQty = null, waybillNo = null, date = null,deliveryBranch=null,pickupBranch=null, materialName = null, packageName = null, valueActualWeight = null, loadedQty = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                openPage();               
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
        (new CFunctions()).GetJavascriptFunction(this, "Txt_UnLoadingWaybillNo", "hfUnLoadingWaybillNo", "Loading.aspx/getWayBillNo", "GetData", "});");
        (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchWaybillNo", "hfWaybillID", "Loading.aspx/getWayBillNo", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);
    }

    [WebMethod]
    public static string[] getWayBillNo(string searchPrefixText, string data = null)
    {
        return (new PickReqFunctions()).getWaybillNo(searchPrefixText, data);
    }
    public void openPage()
    {
        string strGetType = Request["Type"].ToString();
        switch (strGetType)
        {
            case "PickDel":
                idTranship.Visible = false;
                idPickUP.Visible = true;

                tl.Attributes.Add("class", "nav-link tabfont");
                pdl.Attributes.Add("class", "nav-link active tabfont");

                PickupDelDetails.Attributes.Add("class", "tab-pane active");
                Transhipment.Attributes.Add("class", "tab-pane");
                Lbl_TotalQty.Text = "0";
                Lbl_TotalWeight.Text = "0";
                Lbl_TotalUnLoadedQty.Text = "0";
                Lbl_TotalUnLoadedWeight.Text = "0";
                Lbl_TotalTranshipQty.Text = "0";
                Lbl_TotalTranshipWeight.Text = "0";
                Lbl_TotalTranshipUnLoadedQty.Text = "0";
                Lbl_TotalTranshipUnLoadedWeight.Text = "0";

                GetPickupVehicleList();
                break;
            case "Tranship":
                idTranship.Visible = true;
                idPickUP.Visible = false;

                tl.Attributes.Add("class", "nav-link active tabfont");
                pdl.Attributes.Add("class", "nav-link tabfont");

                PickupDelDetails.Attributes.Add("class", "tab-pane");
                Transhipment.Attributes.Add("class", "tab-pane active");
                Lbl_TotalQty.Text = "0";
                Lbl_TotalWeight.Text = "0";
                Lbl_TotalUnLoadedQty.Text = "0";
                Lbl_TotalUnLoadedWeight.Text = "0";
                Lbl_TotalTranshipQty.Text = "0";
                Lbl_TotalTranshipWeight.Text = "0";
                Lbl_TotalTranshipUnLoadedQty.Text = "0";
                Lbl_TotalTranshipUnLoadedWeight.Text = "0";

                GetTranshipmentVehicleList();
                break;

            default:
                break;
        }
    }

    //Get Vehicle in Dropdown List
    //[WebMethod]
    //public static List<pickUpVehicle> getVehicleList(int branchId)
    //{
    //    return (new PickDelLHSFunctions()).GetOpenPickUpVehicles(branchId);
    //}
    //[WebMethod]
    //public static List<WayBillDetails> GetWayBillDetails(string pickUpLHSId)
    //{
    //    return (new PickDelLHSFunctions()).GetWayBillDetails(pickUpLHSId);

    //}

    public void GetPickupVehicleList()
    {
        Ddl_SelectVehicle.DataSource = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 4, "PD");
        //Ddl_SelectVehicle.DataSource = (new LoadingUnloadingFunctions()).GetPickupUnloadingVehicles(Convert.ToInt32(Session["BranchId"].ToString()));
        Ddl_SelectVehicle.DataTextField = "vehicleNo";
        Ddl_SelectVehicle.DataValueField = "VehicleRequestID";
        Ddl_SelectVehicle.DataBind();
        Ddl_SelectVehicle.Items.Insert(0, "SELECT");
    }

    public void GetTranshipmentVehicleList()
    {
        ddlTranshipmentVehicle.DataSource = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 4, "RT");
        //ddlTranshipmentVehicle.DataSource = (new LoadingUnloadingFunctions()).GetOpenTranshipmentVehicles(Convert.ToInt32(Session["BranchId"].ToString()));
        ddlTranshipmentVehicle.DataTextField = "vehicleNo";
        ddlTranshipmentVehicle.DataValueField = "VehicleRequestID";
        ddlTranshipmentVehicle.DataBind();
        ddlTranshipmentVehicle.Items.Insert(0, "SELECT");
    }

 
    protected void btnGetDetails_Click(object sender, EventArgs e)
    {
        if(Ddl_UnLoading.SelectedItem.Text=="PICKUP")
        {
            if (Ddl_SelectVehicle.SelectedItem.Text != "SELECT")
            {
                //gvwPickUpWayBills.DataSource = (new PickDelLHSFunctions()).GetWayBillDetails(hfDdlVehicle.Value, "2", Session["branchId"].ToString());
                gvwDeliveryWaybills.DataSource = null;
                gvwDeliveryWaybills.DataBind(); 
                //gvwPickUpWayBills.DataSource = (new LoadingUnloadingFunctions()).GetPickUnloadWayBillDetails(Ddl_SelectVehicle.SelectedValue, Session["branchId"].ToString(),Txt_UnLoadingWaybillNo.Text.ToString()); 
                //gvwPickUpWayBills.DataBind();

                List<WayBillDetails> PickUnLoadingWayBill = (new LoadingUnloadingFunctions()).GetPickUnloadWayBillDetails(Ddl_SelectVehicle.SelectedValue, Session["branchId"].ToString(), Txt_UnLoadingWaybillNo.Text.ToString());
                gvwPickUpWayBills.DataSource = PickUnLoadingWayBill;
                gvwPickUpWayBills.DataBind();
                Lbl_TotalQty.Text = (PickUnLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                Lbl_TotalWeight.Text = (PickUnLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
                if (Lbl_TotalQty.Text != "0")
                {
                    PickDelSubmit.Visible = true;
                }
else{ PickDelSubmit.Visible = false;}

                UnloadedWaybillItems.Visible = true;
                PickDelPrint.Visible = true;
                DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_SelectVehicle.SelectedValue), 3, Session["branchId"].ToString());
                Int32 intUnLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
                decimal dblUnLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
                Lbl_TotalUnLoadedQty.Text = intUnLoadedQty.ToString();
                Lbl_TotalUnLoadedWeight.Text = dblUnLoadedWT.ToString();
                GV_ReceivedWaybillItems.DataSource = dt;
                GV_ReceivedWaybillItems.DataBind();
                ViewState["ReceivedData"] = dt;

                CloseVehicle.Visible = true;
            }
            else
            {
                //gvwPickUpWayBills.DataSource = (new PickDelLHSFunctions()).GetWayBillDetails(hfDdlVehicle.Value, "2", Session["branchId"].ToString());
                gvwPickUpWayBills.DataSource = null;
                gvwPickUpWayBills.DataBind();

                CloseVehicle.Visible = false;
            }

        }
        else if(Ddl_UnLoading.SelectedItem.Text == "DELIVERY")
        {
            if (Ddl_SelectVehicle.SelectedItem.Text != "SELECT")
            {
                gvwPickUpWayBills.DataSource = null;
                gvwPickUpWayBills.DataBind();
                //gvwDeliveryWaybills.DataSource = (new LoadingUnloadingFunctions()).GetDeliveryUnloadWayBillDetails(Ddl_SelectVehicle.SelectedValue,Txt_UnLoadingWaybillNo.Text.ToString());
                //gvwDeliveryWaybills.DataBind();

                List<WayBillDetails> DelUnLoadingWayBill = (new LoadingUnloadingFunctions()).GetDeliveryUnloadWayBillDetails(Ddl_SelectVehicle.SelectedValue, Txt_UnLoadingWaybillNo.Text.ToString());
                gvwDeliveryWaybills.DataSource = DelUnLoadingWayBill;
                gvwDeliveryWaybills.DataBind();
                Lbl_TotalQty.Text = (DelUnLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                Lbl_TotalWeight.Text = (DelUnLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
                if (Lbl_TotalQty.Text != "0")
                {
                    PickDelSubmit.Visible = true;
                }
else{ PickDelSubmit.Visible = false;}
                UnloadedWaybillItems.Visible = true;
                PickDelPrint.Visible = true;
                DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_SelectVehicle.SelectedValue), 7,Session["branchId"].ToString());
                Int32 intUnLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
                decimal dblUnLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
                Lbl_TotalUnLoadedQty.Text = intUnLoadedQty.ToString();
                Lbl_TotalUnLoadedWeight.Text = dblUnLoadedWT.ToString();
                GV_ReceivedWaybillItems.DataSource = dt;
                GV_ReceivedWaybillItems.DataBind();
                ViewState["ReceivedData"] = dt;

                CloseVehicle.Visible = true;
            }
            else
            {              
                gvwDeliveryWaybills.DataSource = null;
                gvwDeliveryWaybills.DataBind();

                CloseVehicle.Visible = false;
            }
        }
        
    }

    protected void btnGetTranshipmentDetails_Click(object sender, EventArgs e)
    {
        if(ddlTranshipmentVehicle.SelectedItem.Text!="SELECT")
        {
            grdTranshipmentWayBills.Visible = true;
            GV_TranshipReceivedWaybillItems.Visible = true;
            //gvwPickUpWayBills.DataSource = (new PickDelLHSFunctions()).GetWayBillDetails(hfDdlVehicle.Value, "2", Session["branchId"].ToString());
            //grdTranshipmentWayBills.DataSource = (new LoadingUnloadingFunctions()).GetTranshipUnloadWayBillDetails(ddlTranshipmentVehicle.SelectedValue, Session["branchId"].ToString(),Txt_SearchWaybillNo.Text.ToString());
            //grdTranshipmentWayBills.DataBind();

            List<WayBillDetails> TranshipUnLoadingWayBill = (new LoadingUnloadingFunctions()).GetTranshipUnloadWayBillDetails(ddlTranshipmentVehicle.SelectedValue, Session["branchId"].ToString(), Txt_SearchWaybillNo.Text.ToString());
            grdTranshipmentWayBills.DataSource = TranshipUnLoadingWayBill;
            grdTranshipmentWayBills.DataBind();
            Lbl_TotalTranshipQty.Text = (TranshipUnLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
            Lbl_TotalTranshipWeight.Text = (TranshipUnLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
            if (Lbl_TotalTranshipQty.Text != "0")
            {
                TranshipSubmit.Visible = true;
            }
 else
            {
                TranshipSubmit.Visible = false;
            }
            TranshipUnloadedItems.Visible = true;
            TranshipPrint.Visible = true;
            DataTable dt = new VehicleRequestFunction().GetReceivedItemList(Convert.ToInt32(ddlTranshipmentVehicle.SelectedValue), 5, Convert.ToInt32(Session["branchId"].ToString()));
            Int32 intUnLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
            decimal dblUnLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
            Lbl_TotalTranshipUnLoadedQty.Text = intUnLoadedQty.ToString();
            Lbl_TotalTranshipUnLoadedWeight.Text = dblUnLoadedWT.ToString();
            GV_TranshipReceivedWaybillItems.DataSource = dt;
            GV_TranshipReceivedWaybillItems.DataBind();
            ViewState["TranshipReceivedData"] = dt;

            pickUpVehicle veh = new pickUpVehicle();
            veh=(new LoadingUnloadingFunctions()).GetLastBranchInRoute(Convert.ToInt32(ddlTranshipmentVehicle.SelectedValue));                  
            if(veh.branchID == Convert.ToInt32(Session["branchId"]))
            {
                BtnClose.Visible = true;
            }
            else
            {
                BtnClose.Visible = false;
            }
             TranshipPrint.Visible = true;
            Div1.Visible = true;
            TranshipUnloadedItems.Visible = true;   
        }

        else
        {
            grdTranshipmentWayBills.DataSource = null;
            grdTranshipmentWayBills.DataBind();

            BtnClose.Visible = false;
        }

    }

    //protected void Btn_Unload_Click(object sender, EventArgs e)
    //{

    //    //WayBillDetails wb = new WayBillDetails();
    //    //wb.tblWayBillItemId = (sender as LinkButton).CommandArgument;

    //    String ID= (sender as LinkButton).CommandArgument;

    //    bool alertMsg = (new PickDelLHSFunctions()).changeUnloadStatus(ID);

    //    if (alertMsg)
    //    {
    //        (new CFunctions()).showalert("Button_Tab1Save", "UPDATE", this);

    //        for (int i = 0; i < gvwPickUpWayBills.Rows.Count; i++)
    //        {
    //            LinkButton btn_upload = (LinkButton)gvwPickUpWayBills.Rows[i].FindControl("Btn_Unload");
    //            string cellValue = btn_upload.CommandArgument.ToString();
    //            if (cellValue == ID)
    //            {
    //                btn_upload.Text = "UNLOADED";
    //            }

    //            else
    //            {
    //                btn_upload.Text = "UNLOAD";
    //            }

    //        }
    //    }

    //}
    //****************************************Function For Data Table Generation**********************************************************
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

        if (ViewState["ReceivedData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["ReceivedData"];
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
        if (ViewState["ReceivedData"] != null)
        {
            GV_ReceivedWaybillItems.DataSource = (DataTable)ViewState["ReceivedData"];
            GV_ReceivedWaybillItems.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable
            GV_ReceivedWaybillItems.DataSource = dt;
            GV_ReceivedWaybillItems.DataBind();
        }
        // Store the DataTable in ViewState to retain the values
        ViewState["ReceivedData"] = dt;
    }
    protected void gvwPickUpWayBills_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UNLOAD")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            GridViewRow row = gvwPickUpWayBills.Rows[rowIndex];
            WaybillItemStatus wb = new WaybillItemStatus();
            wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
            wb.statusID = 3;
            string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
            wb.itemQty = Convert.ToInt32(qty);
            wb.createdDateTime = new CFunctions().CurrentDateTime();
            wb.branchID = Convert.ToInt32(Session["branchId"]);
            wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue.ToString());
            wb.userID = Convert.ToInt32(Session["userID"]);
            wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
	    wb.Reason = ""; 
            string remQty = row.Cells[11].Text;
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
                    waybillNo = row.Cells[4].Text.ToString();
                    date = row.Cells[5].Text.ToString();
                    materialName = row.Cells[6].Text.ToString();
                    packageName = row.Cells[7].Text.ToString();
                    valueActualWeight = row.Cells[9].Text.ToString();
                    loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                    if (ViewState["ReceivedData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["ReceivedData"];
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
    }
    private void TranshipBindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("wayBillNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("WaybillDate", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("pickUpBranchName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("materialName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("typeOfPackage", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("valueActualWt", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Qty", typeof(String)));

        if (ViewState["TranshipReceivedData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["TranshipReceivedData"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = waybillNo;
            dr[1] = date;
            dr[2] = pickupBranch;
            dr[3] = materialName;
            dr[4] = packageName;
            dr[5] = valueActualWeight;
            dr[6] = loadedQty;
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = waybillNo;
            dr[1] = date;
            dr[2] = pickupBranch;
            dr[3] = materialName;
            dr[4] = packageName;
            dr[5] = valueActualWeight;
            dr[6] = loadedQty;
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["TranshipReceivedData"] != null)
        {
            GV_TranshipReceivedWaybillItems.DataSource = (DataTable)ViewState["TranshipReceivedData"];
            GV_TranshipReceivedWaybillItems.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_TranshipReceivedWaybillItems.DataSource = dt;
            GV_TranshipReceivedWaybillItems.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["TranshipReceivedData"] = dt;
    }
    protected void grdTranshipmentWayBills_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UNLOAD")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            GridViewRow row = grdTranshipmentWayBills.Rows[rowIndex];
            WaybillItemStatus wb = new WaybillItemStatus();
            wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
            wb.statusID = 5;
            string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
            wb.itemQty = Convert.ToInt32(qty);
            wb.createdDateTime = new CFunctions().CurrentDateTime();
            wb.branchID = Convert.ToInt32(Session["branchId"]);
            wb.vehicleRequestId = Convert.ToInt32(ddlTranshipmentVehicle.SelectedValue.ToString());
            wb.userID = Convert.ToInt32(Session["userID"]);
            wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
	    wb.Reason = ""; 
            string remQty = row.Cells[13].Text;
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
                    waybillNo = row.Cells[4].Text.ToString();
                    date = row.Cells[6].Text.ToString();
                    pickupBranch = row.Cells[7].Text.ToString();
                    materialName = row.Cells[8].Text.ToString();
                    packageName = row.Cells[9].Text.ToString();
                    valueActualWeight = row.Cells[11].Text.ToString();
                    loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                    if (ViewState["TranshipReceivedData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["TranshipReceivedData"];
                        int count = dt.Rows.Count;
                        TranshipBindGrid(count);
                    }
                    else
                    {
                        TranshipBindGrid(1);
                    }

                    waybillNo = null;
                    date = null;
                    pickupBranch = null;
                    materialName = null;
                    packageName = null;
                    valueActualWeight = null;
                    itemQty = null;
                    loadedQty = null;

                }
                btnGetTranshipmentDetails_Click(sender, e);
            }

        }
    }
    protected void gvwDeliveryWaybills_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UNLOAD")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvwDeliveryWaybills.Rows[rowIndex];
            WaybillItemStatus wb = new WaybillItemStatus();
            wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
            wb.statusID = 7;
            string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
            wb.itemQty = Convert.ToInt32(qty);
            wb.createdDateTime = new CFunctions().CurrentDateTime();
            wb.branchID = Convert.ToInt32(Session["branchId"]);
            wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue.ToString());
            wb.userID = Convert.ToInt32(Session["userID"]);
            wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
	    wb.Reason = (row.FindControl("ddlUndeliveryReason") as DropDownList).SelectedValue.ToString();
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
                    waybillNo = row.Cells[4].Text.ToString();
                    date = row.Cells[5].Text.ToString();
                    materialName = row.Cells[7].Text.ToString();
                    packageName = row.Cells[8].Text.ToString();
                    valueActualWeight = row.Cells[10].Text.ToString();
                    loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                    if (ViewState["ReceivedData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["ReceivedData"];
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
    }


    protected void grdTranshipmentWayBills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell qty = e.Row.Cells[5];
            Label lbl = (Label)e.Row.FindControl("Lbl_Unloaded");
            LinkButton btn = (LinkButton)e.Row.FindControl("Btn_Unload");
            if (qty.Text == "0")
            {
                lbl.Text = "UNLOADED";
                btn.Visible = false;
            }

        }
    }

    protected void gvwPickUpWayBills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell qty = e.Row.Cells[5];
            Label lbl = (Label)e.Row.FindControl("Lbl_Unloaded");
            LinkButton btn = (LinkButton)e.Row.FindControl("Btn_Unload");
            if (qty.Text == "0")
            {
                lbl.Text = "UNLOADED";
                btn.Visible = false;
            }
        }
    }
    protected void gvwDeliveryWaybills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell qty = e.Row.Cells[5];
            Label lbl = (Label)e.Row.FindControl("Lbl_Unloaded");
            LinkButton btn = (LinkButton)e.Row.FindControl("Btn_Unload");
            if (qty.Text == "0")
            {
                lbl.Text = "UNLOADED";
                btn.Visible = false;
            }
        }
    }


    protected void CloseVehicle_Click(object sender, EventArgs e)
    {
        if (Ddl_UnLoading.SelectedItem.Text == "PICKUP")
        {
            if (Ddl_SelectVehicle.SelectedItem.Text != "SELECT")
            {
                VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
                //int count = new LoadingUnloadingFunctions().GetPickNotUnloadWayBillList(Ddl_SelectVehicle.SelectedValue);
               int intResult = new LoadingUnloadingFunctions().SetVehicleClose(Ddl_SelectVehicle.SelectedValue, Session["userID"].ToString(),
                                                Session["BranchId"].ToString(), (new CFunctions()).CurrentDateTime().ToUpper(),Txt_PickDelClosingRemark.Text.ToString().ToUpper());
                if (intResult == 1)
                {
                    Ddl_UnLoading.SelectedIndex = 0;
                    GetPickupVehicleList();
                    gvwPickUpWayBills.Visible = false;
                    GV_ReceivedWaybillItems.Visible = false;
                    CloseVehicle.Visible = false;
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vehicle Has been closed.')", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Unload All Waybills to Close')", true);
                }
            }
        }
        else if (Ddl_UnLoading.SelectedItem.Text == "DELIVERY")
        {
            if (Ddl_SelectVehicle.SelectedItem.Text != "SELECT")
            {
                List<PickReq> pr = new List<PickReq>();
                pr = (new LoadingUnloadingFunctions()).GetWaybillListForPOD(Convert.ToInt32(Ddl_SelectVehicle.SelectedValue)); //
                bool bPOD = false; string strWayBillsPOD = "";
                int waybillCount = pr.Count;
                for (int i = 0; i < waybillCount; i++)
                {
                     #region
                    var str = ""; var str1 = "";
                    str = "http://www.dexters.co.in/pod/";
                    str1 = "http://122.170.111.196:2020/PODSCANNING//";
                    waybillNo = pr[i].WaybillNo.ToString();
                    var url0 = str + waybillNo + ".png";
                    var url1 = str + waybillNo + ".jpg";
                    var url2 = str + waybillNo + ".pdf";
                    var url3 = str + waybillNo + ".jpeg";

                    var url4 = str1 + waybillNo + ".png";
                    var url5 = str1 + waybillNo + ".jpg";
                    var url6 = str1 + waybillNo + ".pdf";
                    var url7 = str1 + waybillNo + ".jpeg";

                    HttpWebResponse response = null;
                    var request0 = (HttpWebRequest)WebRequest.Create(url0);
                    var request1 = (HttpWebRequest)WebRequest.Create(url1);
                    var request2 = (HttpWebRequest)WebRequest.Create(url2);
                    var request3 = (HttpWebRequest)WebRequest.Create(url3);

                    var request4 = (HttpWebRequest)WebRequest.Create(url4);
                    var request5 = (HttpWebRequest)WebRequest.Create(url5);
                    var request6 = (HttpWebRequest)WebRequest.Create(url6);
                    var request7 = (HttpWebRequest)WebRequest.Create(url7);

                    request0.Method = "HEAD";
                    request1.Method = "HEAD";
                    request2.Method = "HEAD";
                    request3.Method = "HEAD";

                    request4.Method = "HEAD";
                    request5.Method = "HEAD";
                    request6.Method = "HEAD";
                    request7.Method = "HEAD";

                    /* A WebException will be thrown if the status of the response is not `200 OK` */
                    // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('POD's Not Uploaded')", true);
                    /*try  
                    {
                        response = (HttpWebResponse)request0.GetResponse();
                        HttpStatusCode status0 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request1.GetResponse();
                        HttpStatusCode status1 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request2.GetResponse();
                        HttpStatusCode status2 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) {response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request3.GetResponse();
                        HttpStatusCode status3 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request4.GetResponse();
                        HttpStatusCode status4 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request5.GetResponse();
                        HttpStatusCode status5 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request6.GetResponse();
                        HttpStatusCode status6 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }
                    try
                    {
                        response = (HttpWebResponse)request7.GetResponse();
                        HttpStatusCode status7 = response.StatusCode;
                        bPOD = true;
                    }
                    catch (WebException ex)
                    {
                        if (response != null) { response.Close(); }
                    }*/
                    if (bPOD == false)
                    {
                        strWayBillsPOD += waybillNo.ToString() + ", ";
                    }
                    bPOD = false;
                    #endregion                
                }
                if (strWayBillsPOD == "" || Session["BranchId"].ToString() == "48") 
                {
                        //Close the vehicle Here. 
                        VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
                         
                    int intResult = new LoadingUnloadingFunctions().SetVehicleClose(Ddl_SelectVehicle.SelectedValue, Session["userID"].ToString(),
                                                        Session["BranchId"].ToString(), (new CFunctions()).CurrentDateTime().ToUpper(), Txt_PickDelClosingRemark.Text.ToString().ToUpper());

                    if (intResult == 1)
                    {
                        Ddl_UnLoading.SelectedIndex = 0;
                        GetPickupVehicleList();
                        //gvwDeliveryWaybills.Visible = false;
                        //GV_ReceivedWaybillItems.Visible = false;
                        CloseVehicle.Visible = false;
                        lblMsg.Text = ""; 
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vehicle Has been closed.')", true);
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Unload All Waybills to Close')", true);
                    }
                }
                else
                {
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('POD's not uploaded for " + strWayBillsPOD + "')", true);
                    lblMsg.Text = strWayBillsPOD + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "POD's Not Uploaded";
                }
            }
        }
    }


    protected void Btn_TranshipCloseVehicle_Click(object sender, EventArgs e)
    {
        if(ddlTranshipmentVehicle.SelectedItem.Text!="SELECT")
        {
            VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
            //int count = new LoadingUnloadingFunctions().GetPickNotUnloadWayBillList(Ddl_SelectVehicle.SelectedValue);
            int intResult = new LoadingUnloadingFunctions().SetVehicleClose(ddlTranshipmentVehicle.SelectedValue, Session["userID"].ToString(),
                                            Session["BranchId"].ToString(), (new CFunctions()).CurrentDateTime().ToUpper(), Txt_TranshipClosingRemark.Text.ToString().ToUpper());
            if (intResult == 1)
            {
                GetTranshipmentVehicleList();
                //grdTranshipmentWayBills.Visible = false;
                //GV_TranshipReceivedWaybillItems.Visible = false;
                BtnClose.Visible = false;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vehicle Has been closed.')", true);            
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Unload All Waybills to Close')", true);
            }
           
        }        
    }

    protected void Ddl_UnLoading_SelectedIndexChanged(object sender, EventArgs e)
    {
       gvwDeliveryWaybills.DataSource = null;
       gvwDeliveryWaybills.DataBind();       
       gvwPickUpWayBills.DataSource = null;
       gvwPickUpWayBills.DataBind();
       GV_ReceivedWaybillItems.DataSource = null;
       GV_ReceivedWaybillItems.DataBind();
       PickDelSubmit.Visible = false;
       //UnloadedWaybillItems.Visible = false;
       lblMsg.Text = "";
       Lbl_TotalQty.Text = "0";
       Lbl_TotalWeight.Text = "0";
       Ddl_SelectVehicle.SelectedIndex = 0;
    }

    protected void Button_PickDelSubmit_Click(object sender, EventArgs e)
    {
        if (Ddl_UnLoading.SelectedItem.ToString() == "PICKUP")
        {
            foreach (GridViewRow row in gvwPickUpWayBills.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chk_select");
                if (chk.Checked == true)
                {                    
                    WaybillItemStatus wb = new WaybillItemStatus();
                    wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                    wb.statusID = 3;
                    string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
                    wb.itemQty = Convert.ToInt32(qty);
                    wb.createdDateTime = new CFunctions().CurrentDateTime();
                    wb.branchID = Convert.ToInt32(Session["branchId"]);
                    wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue.ToString());
                    wb.userID = Convert.ToInt32(Session["userID"]);
                    wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
		    wb.Reason = ""; 
                    string remQty = row.Cells[11].Text;
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
                            waybillNo = row.Cells[4].Text.ToString();
                            date = row.Cells[5].Text.ToString();
                            materialName = row.Cells[6].Text.ToString();
                            packageName = row.Cells[7].Text.ToString();
                            valueActualWeight = row.Cells[9].Text.ToString();
                            loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                            if (ViewState["ReceivedData"] != null)
                            {
                                DataTable dt = (DataTable)ViewState["ReceivedData"];
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
            }
        }
        else
        {
            foreach (GridViewRow row in gvwDeliveryWaybills.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chk_select");
                if (chk.Checked == true)
                {
                    WaybillItemStatus wb = new WaybillItemStatus();
                    wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                    wb.statusID = 7;
                    string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
                    wb.itemQty = Convert.ToInt32(qty);
                    wb.createdDateTime = new CFunctions().CurrentDateTime();
                    wb.branchID = Convert.ToInt32(Session["branchId"]);
                    wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue.ToString());
                    wb.userID = Convert.ToInt32(Session["userID"]);
                    wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
		    wb.Reason = (row.FindControl("ddlUndeliveryReason") as DropDownList).SelectedValue.ToString();
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
                            waybillNo = row.Cells[4].Text.ToString();
                            date = row.Cells[5].Text.ToString();
                            materialName = row.Cells[7].Text.ToString();
                            packageName = row.Cells[8].Text.ToString();
                            valueActualWeight = row.Cells[10].Text.ToString();
                            loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                            if (ViewState["ReceivedData"] != null)
                            {
                                DataTable dt = (DataTable)ViewState["ReceivedData"];
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
            }
        }
    }

    protected void Btn_PickDelReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void Btn_TranshipSubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in grdTranshipmentWayBills.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chk_select");
            if (chk.Checked == true)
            {
                WaybillItemStatus wb = new WaybillItemStatus();           
                wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                wb.statusID = 5;
                string qty = (row.FindControl("receivedItemQty") as TextBox).Text;
                wb.itemQty = Convert.ToInt32(qty);
                wb.createdDateTime = new CFunctions().CurrentDateTime();
                wb.branchID = Convert.ToInt32(Session["branchId"]);
                wb.vehicleRequestId = Convert.ToInt32(ddlTranshipmentVehicle.SelectedValue.ToString());
                wb.userID = Convert.ToInt32(Session["userID"]);
                wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
		wb.Reason = ""; 
                string remQty = row.Cells[13].Text;
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
                        waybillNo = row.Cells[4].Text.ToString();
                        date = row.Cells[6].Text.ToString();
                        pickupBranch = row.Cells[7].Text.ToString();
                        materialName = row.Cells[8].Text.ToString();
                        packageName = row.Cells[9].Text.ToString();
                        valueActualWeight = row.Cells[11].Text.ToString();
                        loadedQty = (row.FindControl("receivedItemQty") as TextBox).Text;

                        if (ViewState["TranshipReceivedData"] != null)
                        {
                            DataTable dt = (DataTable)ViewState["TranshipReceivedData"];
                            int count = dt.Rows.Count;
                            TranshipBindGrid(count);
                        }
                        else
                        {
                            TranshipBindGrid(1);
                        }

                        waybillNo = null;
                        date = null;
                        pickupBranch = null;
                        materialName = null;
                        packageName = null;
                        valueActualWeight = null;
                        itemQty = null;
                        loadedQty = null;

                    }
                    btnGetTranshipmentDetails_Click(sender, e);
                }
             }
           }
        }

	protected void btnPrintUnloading_Click(object sender, EventArgs e)
    {
        string strType = "", strrequestId = "";
        string strGetType = "";

        if (Ddl_UnLoading.SelectedItem.Text == "PICKUP")
        {
            strType = "PICKUNLOAD";
            strrequestId = Ddl_SelectVehicle.SelectedValue.ToString();
        }
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintScreen.aspx?Type=" + strType + "&Value=" + strrequestId
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }
	
	protected void btnPrintManifest_Click(object sender, EventArgs e)
    {
        string strType = "", strRequestId = "";
        string strGetType = Request["Type"].ToString();

        if (strGetType == "Tranship")
        {
            strType = "TSUNLOAD";
            strRequestId = ddlTranshipmentVehicle.SelectedValue.ToString();
        }
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintScreen.aspx?Type=" + strType + "&Value=" + strRequestId
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }


    protected void Btn_TranshipReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
 protected void Ddl_SelectVehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvwDeliveryWaybills.DataSource = null;
        gvwDeliveryWaybills.DataBind();
        gvwPickUpWayBills.DataSource = null;
        gvwPickUpWayBills.DataBind();
        GV_ReceivedWaybillItems.DataSource = null;
        GV_ReceivedWaybillItems.DataBind();
        PickDelSubmit.Visible = false;
        //UnloadedWaybillItems.Visible = false;
        lblMsg.Text = "";
        Lbl_TotalQty.Text = "0";
        Lbl_TotalWeight.Text = "0";
    }
 protected void ddlTranshipmentVehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblManifestNo.Text = "";
        TranshipPrint.Visible = false;
        Div1.Visible = false;
        //TranshipUnloadedItems.Visible = false;
        Lbl_TotalTranshipQty.Text = "";
        Lbl_TotalTranshipWeight.Text = "";
    }
}