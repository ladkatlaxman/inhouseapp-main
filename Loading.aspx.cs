using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using System.Web.Services;
using System.Data;
using BLProperties;
using System.Collections.Generic;
using System.Linq;

public partial class TranshipmentLoading : System.Web.UI.Page
{
    CFunctions cmf = new CFunctions();
    public static string itemQty=null, waybillNo=null, date = null,deliveryBranch=null,pickupBranch=null, materialName=null, packageName=null, valueActualWeight=null, loadedQty=null;

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

                Loading.Attributes.Add("class", "tab-pane active");
                TranshipmentLoadingDetails.Attributes.Add("class", "tab-pane");
                Lbl_TotalQty.Text = "0";
                Lbl_TotalWeight.Text = "0";
                Lbl_TotalLoadedQty.Text = "0";
                Lbl_TotalLoadedWeight.Text = "0";
                Lbl_TotalTranshipQty.Text = "0";
                Lbl_TotalTranshipWeight.Text = "0";
                Lbl_TotalTranshipLoadedQty.Text = "0";
                Lbl_TotalTranshipLoadedWeight.Text = "0";
                break;
            case "Tranship":
                idTranship.Visible = true;
                idPickUP.Visible = false;              
              
                tl.Attributes.Add("class", "nav-link active tabfont");
                pdl.Attributes.Add("class", "nav-link tabfont");

                Loading.Attributes.Add("class", "tab-pane");
                TranshipmentLoadingDetails.Attributes.Add("class", "tab-pane active");
                Lbl_TotalQty.Text = "0";
                Lbl_TotalWeight.Text = "0";
                Lbl_TotalLoadedQty.Text = "0";
                Lbl_TotalLoadedWeight.Text = "0";
                Lbl_TotalTranshipQty.Text = "0";
                Lbl_TotalTranshipWeight.Text = "0";
                Lbl_TotalTranshipLoadedQty.Text = "0";
                Lbl_TotalTranshipLoadedWeight.Text = "0";

                GetTranshipVehicleList();
                break;
            default:
                break;
        }
    }
    //Pickup
    public void GetPickupVehicleList() 
    {
        Ddl_PickupVehicle.DataSource = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 3,"PD"); 
        Ddl_PickupVehicle.DataTextField = "VehicleNo"; 
        Ddl_PickupVehicle.DataValueField = "VehicleRequestID"; 
        Ddl_PickupVehicle.DataBind(); 
        Ddl_PickupVehicle.Items.Insert(0, "SELECT"); 
    }
    //Delivery
    public void GetDeliveryVehicleList()
    {
        Ddl_PickupVehicle.DataSource = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 2,"PD");
        Ddl_PickupVehicle.DataTextField = "VehicleNo";
        Ddl_PickupVehicle.DataValueField = "VehicleRequestID";
        Ddl_PickupVehicle.DataBind();
        Ddl_PickupVehicle.Items.Insert(0, "SELECT");
    }

    protected void btn_PickupLoadingList_Click(object sender, EventArgs e) 
    { 
        lblPickDelHeader.Text = "";    
        if (Ddl_Loading.SelectedItem.Text == "PICKUP")
        {
            if(Ddl_PickupVehicle.SelectedItem.ToString()!="SELECT")
            {
                gvDeliveryLoadingDetails.DataSource = null;
                gvDeliveryLoadingDetails.DataBind();
                 List<WayBillDetails> PickLoadingWayBill = (new LoadingUnloadingFunctions()).GetPickLoadingWayBillDetails(Convert.ToInt32(Session["BranchId"].ToString()));
                gvPickupLoadingDetails.DataSource = PickLoadingWayBill;
                gvPickupLoadingDetails.DataBind();
                Lbl_TotalQty.Text = (PickLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                Lbl_TotalWeight.Text = (PickLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
                 if(Lbl_TotalQty.Text != "0")
                {
                    PickDelSubmit.Visible = true;
                }
 else
                {
                    PickDelSubmit.Visible = false;
                }
                loadedItems.Visible = true;
                 PickDelPrint.Visible = true;
                // DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_PickupVehicle.SelectedValue), 2);

		lblPickDelHeader.Text = "PICK UP LOAD LIST";	
                string strPickDel = "P" + (Convert.ToInt32(Ddl_PickupVehicle.SelectedValue) + 100000000).ToString().Substring(1);	
                lblPickDelNo.Text = strPickDel;

                DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_PickupVehicle.SelectedValue), 2);
                Int32 intLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
                decimal dblLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
                Lbl_TotalLoadedQty.Text = intLoadedQty.ToString();
                Lbl_TotalLoadedWeight.Text = dblLoadedWT.ToString();              
                GV_LoadedWaybillItems.DataSource = dt;
                GV_LoadedWaybillItems.DataBind();
                ViewState["LoadingData"] = dt;  
            }
        }
        else if (Ddl_Loading.SelectedItem.Text == "DELIVERY")
        {
            if(Ddl_PickupVehicle.SelectedItem.ToString()!="SELECT")
            {
                gvPickupLoadingDetails.DataSource = null;
                gvPickupLoadingDetails.DataBind();

                string strBranchId = "", strDeliveryBranchId = "";
                strBranchId = Session["BranchId"].ToString();

		//Lbl_TotalQty.Text = Ddl_DeliveryBranch.SelectedIndex.ToString(); 
                if(Ddl_DeliveryBranch.SelectedIndex != 0)
                {
                    strDeliveryBranchId = Ddl_DeliveryBranch.SelectedValue.ToString();
                    /*List<WayBillDetails> DelLoadingWayBill = (new LoadingUnloadingFunctions()).GetDeliveryLoadingWayBillDetails(Convert.ToInt32(Ddl_DeliveryBranch.SelectedValue));
                    gvDeliveryLoadingDetails.DataSource = DelLoadingWayBill;
                    gvDeliveryLoadingDetails.DataBind();
                    Lbl_TotalQty.Text = (DelLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                    Lbl_TotalWeight.Text = (DelLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();*/
 		    Lbl_TotalQty.Text = Ddl_DeliveryBranch.SelectedValue.ToString(); 
                }
                else
                {
                    /*List<WayBillDetails> DelLoadingWayBill = (new LoadingUnloadingFunctions()).GetDeliveryLoadingWayBillDetails(Convert.ToInt32(Session["BranchId"].ToString()));
                    gvDeliveryLoadingDetails.DataSource = DelLoadingWayBill;
                    gvDeliveryLoadingDetails.DataBind();
                    Lbl_TotalQty.Text = (DelLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                    Lbl_TotalWeight.Text = (DelLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();*/
                }
                List<WayBillDetails> DelLoadingWayBill = (new LoadingUnloadingFunctions()).GetDeliveryLoadingWayBillDetailsNew(strBranchId, strDeliveryBranchId);
                gvDeliveryLoadingDetails.DataSource = DelLoadingWayBill;
                gvDeliveryLoadingDetails.DataBind();
                Lbl_TotalQty.Text = (DelLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                Lbl_TotalWeight.Text = (DelLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();

	        lblPickDelHeader.Text = "DELIVERY RUN SHEET";
                string strPickDel = "D" + (Convert.ToInt32(Ddl_PickupVehicle.SelectedValue) + 100000000).ToString().Substring(1);
                lblPickDelNo.Text = strPickDel;
                 if (Lbl_TotalQty.Text != "0")
                {
                    PickDelSubmit.Visible = true;
                }
		else
                {
                    PickDelSubmit.Visible = false;
                }
               loadedItems.Visible = true;
               PickDelPrint.Visible = true;
                DataTable dt = new VehicleRequestFunction().GetLoadedItemList(Convert.ToInt32(Ddl_PickupVehicle.SelectedValue), 6);              
                Int32 intLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
                decimal dblLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
                Lbl_TotalLoadedQty.Text = intLoadedQty.ToString();
                Lbl_TotalLoadedWeight.Text = dblLoadedWT.ToString();
                GV_LoadedWaybillItems.DataSource = dt;
                GV_LoadedWaybillItems.DataBind();
                ViewState["LoadingData"] = dt;
            }                  
        }
        else
        {
            gvPickupLoadingDetails.DataSource = null;
            gvPickupLoadingDetails.DataBind();
            gvDeliveryLoadingDetails.DataSource = null;
            gvDeliveryLoadingDetails.DataBind();
        }

    }
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

        if (ViewState["LoadingData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["LoadingData"];
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
        if (ViewState["LoadingData"] != null)
        {
            GV_LoadedWaybillItems.DataSource = (DataTable)ViewState["LoadingData"];
            GV_LoadedWaybillItems.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_LoadedWaybillItems.DataSource = dt;
            GV_LoadedWaybillItems.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["LoadingData"] = dt;
    }
    protected void gvPickupLoadingDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "LOAD")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvPickupLoadingDetails.Rows[rowIndex];
            WaybillItemStatus wb = new WaybillItemStatus();
            wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
            wb.statusID = 2;
            string qty = (row.FindControl("LoadedItemQty") as TextBox).Text;
            wb.itemQty = Convert.ToInt32(qty);
            wb.createdDateTime = new CFunctions().CurrentDateTime();
            wb.branchID = Convert.ToInt32(Session["BranchId"]);
            wb.vehicleRequestId = Convert.ToInt32(Ddl_PickupVehicle.SelectedValue);
            wb.userID = Convert.ToInt32(Session["userID"]);
            wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
            string remQty = row.Cells[12].Text;
            Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

            if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
            {
                Lblerror.Text = "Enter correct Qty";
            }
            else
            {
                bool alertMsg = (new LoadingUnloadingFunctions()).changeTranshipLoadStatus(wb);

                if (alertMsg)
                {
                    waybillNo = row.Cells[4].Text.ToString();
                    date = row.Cells[6].Text.ToString();
                    materialName = row.Cells[8].Text.ToString();
                    packageName = row.Cells[9].Text.ToString();
                    valueActualWeight = row.Cells[10].Text.ToString();
                    loadedQty = (row.FindControl("LoadedItemQty") as TextBox).Text;

                    if (ViewState["LoadingData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["LoadingData"];
                        int count = dt.Rows.Count;
                        //BindGrid(count);
                    }
                    else
                    {
                        //BindGrid(1);
                    }

                    waybillNo = null;
                    date = null;
                    materialName = null;
                    packageName = null;
                    valueActualWeight = null;
                    itemQty = null;
                    loadedQty = null;
                }
            }
        } 
        btn_PickupLoadingList_Click(sender, e);
    }
    // Transhipment
    public void GetTranshipVehicleList()
    {

        Ddl_SelectVehicle.DataSource =(new VehicleRequestFunction()).ViewTranshipVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), "RT");
        Ddl_SelectVehicle.DataTextField = "vehicleNo";
        Ddl_SelectVehicle.DataValueField = "VehicleRequestID";
        Ddl_SelectVehicle.DataBind();
        Ddl_SelectVehicle.Items.Insert(0, "SELECT");

    }
    protected void btnGetDetails_Click(object sender, EventArgs e)
    {
        if(Ddl_SelectVehicle.SelectedItem.Text!="SELECT")
        {
            if (Ddl_ManifestBranch.SelectedItem.Text != "SELECT")
            {
                //gvwLoadingDetails.DataSource = (new LoadingUnloadingFunctions()).GetLoadingWayBillDetails(Ddl_SelectVehicle.SelectedValue.ToString(), Session["BranchId"].ToString(), Ddl_ManifestBranch.SelectedValue.ToString(),Txt_SearchWaybillNo.Text.ToString());
                //gvwLoadingDetails.DataBind();

                List<WayBillDetails> TranshipLoadingWayBill = (new LoadingUnloadingFunctions()).GetLoadingWayBillDetails(Ddl_SelectVehicle.SelectedValue.ToString(), Session["BranchId"].ToString(), Ddl_ManifestBranch.SelectedValue.ToString(), null);
                gvwLoadingDetails.DataSource = TranshipLoadingWayBill;
                gvwLoadingDetails.DataBind();
                Lbl_TotalTranshipQty.Text = (TranshipLoadingWayBill.Sum(item => (Convert.ToInt32(item.remQty)))).ToString();
                Lbl_TotalTranshipWeight.Text = (TranshipLoadingWayBill.Sum(item => (Convert.ToDouble(item.valueActualWt)))).ToString();
            }
              if (Lbl_TotalTranshipQty.Text != "0")
            {
                TranshipSubmit.Visible = true;
            }
else
            {
                TranshipSubmit.Visible = false;
            }
            TranshipLoadedItems.Visible = true;
            TranshipPrint.Visible = true;
            DataTable dt = new VehicleRequestFunction().GetReceivedItemList(Convert.ToInt32(Ddl_SelectVehicle.SelectedValue), 4, Convert.ToInt32(Session["branchId"].ToString()));
            Int32 intLoadedQty = dt.AsEnumerable().Sum(myRow => myRow.Field<int>("Qty"));
            decimal dblLoadedWT = dt.AsEnumerable().Sum(myRow => myRow.Field<decimal>("valueActualWt"));
            Lbl_TotalTranshipLoadedQty.Text = intLoadedQty.ToString();
            Lbl_TotalTranshipLoadedWeight.Text = dblLoadedWT.ToString();
            GV_TranshipLoadedWaybillItems.DataSource = dt;
            GV_TranshipLoadedWaybillItems.DataBind();
            ViewState["TranshipLoadingData"] = dt;

            String strAdded = "**"; ddlManifest.Items.Clear(); 
            string strItem; 
            ddlManifest.Items.Add("All"); 

            foreach (DataRow dr in dt.Rows) 
            {
                strItem = dr["ManifestBranch"].ToString(); 
                if (strAdded.IndexOf("**" + strItem + "**") < 0) 
                {
                    ddlManifest.Items.Add(strItem);
                    strAdded += "**" + strItem + "**";
                }
            }
        }
       else
        {
            gvwLoadingDetails.DataSource = null;
            gvwLoadingDetails.DataBind();
        }
    }

    private void TranshipBindGrid(int rowcount)
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new System.Data.DataColumn("wayBillNo", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("WaybillDate", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("DeliveryBranchName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("pickUpBranchName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("materialName", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("typeOfPackage", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("valueActualWt", typeof(String)));
        dt.Columns.Add(new System.Data.DataColumn("Qty", typeof(String)));

        if (ViewState["TranshipLoadingData"] != null)
        {
            for (int i = 0; i < rowcount + 1; i++)
            {
                dt = (DataTable)ViewState["TranshipLoadingData"];
                if (dt.Rows.Count > 0)
                {
                    dr = dt.NewRow();
                    dr[0] = dt.Rows[0][0].ToString();
                }
            }
            dr = dt.NewRow();
            dr[0] = waybillNo;
            dr[1] = date;
            dr[2] = deliveryBranch;
            dr[3] = pickupBranch;
            dr[4] = materialName;
            dr[5] = packageName;
            dr[6] = valueActualWeight;
            dr[7] = loadedQty;
            dt.Rows.Add(dr);

        }
        else
        {
            dr = dt.NewRow();
            dr[0] = waybillNo;
            dr[1] = date;
            dr[2] = deliveryBranch;
            dr[3] = pickupBranch;
            dr[4] = materialName;
            dr[5] = packageName;
            dr[6] = valueActualWeight;
            dr[7] = loadedQty;
            dt.Rows.Add(dr);
        }
        // If ViewState has a data then use the value as the DataSource
        if (ViewState["TranshipLoadingData"] != null)
        {
            GV_TranshipLoadedWaybillItems.DataSource = (DataTable)ViewState["TranshipLoadingData"];
            GV_TranshipLoadedWaybillItems.DataBind();
        }
        else
        {
            // Bind GridView with the initial data assocaited in the DataTable

            GV_TranshipLoadedWaybillItems.DataSource = dt;
            GV_TranshipLoadedWaybillItems.DataBind();

        }
        // Store the DataTable in ViewState to retain the values
        ViewState["TranshipLoadingData"] = dt;
    }

     protected void gvwLoadingDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "LOAD")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvwLoadingDetails.Rows[rowIndex];
            WaybillItemStatus wb = new WaybillItemStatus();
            wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
            wb.statusID = 4;
            string qty = (row.FindControl("LoadedItemQty") as TextBox).Text;
            wb.itemQty = Convert.ToInt32(qty);
            wb.createdDateTime = new CFunctions().CurrentDateTime();
            wb.branchID = Convert.ToInt32(Session["BranchId"]);
            wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue);
            wb.userID = Convert.ToInt32(Session["userID"]);
            wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
            string remQty = row.Cells[14].Text;
            Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

            if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
            {
                Lblerror.Text = "Enter correct Qty";
            }
            else
            {
                bool alertMsg = (new LoadingUnloadingFunctions()).changeTranshipLoadStatus(wb);

                if (alertMsg)
                {
                    waybillNo = row.Cells[4].Text.ToString();
                    date = row.Cells[6].Text.ToString();
                    pickupBranch = row.Cells[8].Text.ToString();
                    deliveryBranch = row.Cells[9].Text.ToString();
                    materialName = row.Cells[10].Text.ToString();
                    packageName = row.Cells[11].Text.ToString();
                    valueActualWeight = row.Cells[12].Text.ToString();
                    loadedQty = (row.FindControl("LoadedItemQty") as TextBox).Text;

                    if (ViewState["TranshipLoadingData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["TranshipLoadingData"];
                        int count = dt.Rows.Count;
                        TranshipBindGrid(count);
                    }
                    else
                    {
                        TranshipBindGrid(1);
                    }

                    waybillNo = null;
                    date = null;
                    deliveryBranch = null;
                    pickupBranch = null;
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


    [WebMethod]
    public static string[] GetRouteHeaderData(int vehicleRequestId)
    {
        return (new LoadingUnloadingFunctions()).LoadRouteHeaderData(vehicleRequestId);
    }
    [WebMethod]
    public static string[] GetRouteDetailsData(int vehicleRequestId)
    {
        return (new LoadingUnloadingFunctions()).LoadRouteDetailsData(vehicleRequestId);
    }


     protected void gvDeliveryLoadingDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "LOAD")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvDeliveryLoadingDetails.Rows[rowIndex];
            WaybillItemStatus wb = new WaybillItemStatus();
            wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
            wb.statusID = 6;
            string qty = (row.FindControl("LoadedItemQty") as TextBox).Text;
            wb.itemQty = Convert.ToInt32(qty);
            wb.createdDateTime = new CFunctions().CurrentDateTime();
            wb.branchID = Convert.ToInt32(Session["BranchId"]);
            wb.vehicleRequestId = Convert.ToInt32(Ddl_PickupVehicle.SelectedValue);
            wb.userID = Convert.ToInt32(Session["userID"]);
            wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
            string remQty = row.Cells[13].Text;
            Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

            if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
            {
                Lblerror.Text = "Enter correct Qty";
            }
            else
            {
                bool alertMsg = (new LoadingUnloadingFunctions()).changeTranshipLoadStatus(wb);

                if (alertMsg)
                {
                    waybillNo = row.Cells[4].Text.ToString();
                    date = row.Cells[6].Text.ToString();
                    materialName = row.Cells[9].Text.ToString();
                    packageName = row.Cells[10].Text.ToString();
                    valueActualWeight = row.Cells[11].Text.ToString();
                    loadedQty = (row.FindControl("LoadedItemQty") as TextBox).Text;

                    if (ViewState["LoadingData"] != null)
                    {
                        DataTable dt = (DataTable)ViewState["LoadingData"];
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
                btn_PickupLoadingList_Click(sender, e);
            }

        }
    }

    protected void Ddl_Loading_SelectedIndexChanged(object sender, EventArgs e)
    {
        Lbl_TotalQty.Text = "0";
        Lbl_TotalWeight.Text = "0";
        Lbl_TotalLoadedQty.Text = "0";
        Lbl_TotalLoadedWeight.Text = "0";
        lblPickDelNo.Text = "0";
        lblPickDelHeader.Text = "0";
        gvDeliveryLoadingDetails.DataSource = null;
        gvDeliveryLoadingDetails.DataBind();
        gvPickupLoadingDetails.DataSource = null;
        gvPickupLoadingDetails.DataBind();
        PickDelSubmit.Visible = false;
        loadedItems.Visible = false;
        GV_LoadedWaybillItems.DataSource = null;
        GV_LoadedWaybillItems.DataBind();
       
        if (Ddl_Loading.SelectedItem.Text == "PICKUP")
        {
            divBranch.Visible = false;
            GetPickupVehicleList();
        }
        else
        {
            divBranch.Visible = true;
            GetDeliveryVehicleList();
            (new CFunctions()).dropdwnlist(null, null, Ddl_DeliveryBranch, null, "branchName", "branchId", (new CommFunctions().GetBranch()));
        }
    }

    protected void Ddl_SelectVehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        routeDiv.Visible = true;
        gvwLoadingDetails.DataSource = null;
        gvwLoadingDetails.DataBind();
         List<WayBillDetails> ManifestDetails = (new LoadingUnloadingFunctions()).GetManifestBranch(Ddl_SelectVehicle.SelectedValue.ToString(), Session["BranchId"].ToString());
        Ddl_ManifestBranch.DataSource = ManifestDetails;
        Ddl_ManifestBranch.DataTextField = "ManifestBranch";
        Ddl_ManifestBranch.DataValueField = "toBranchId";
        foreach(WayBillDetails wb in ManifestDetails)
        {
            Txt_RouteName.Text = wb.routeName;
            break; 
        }
        Ddl_ManifestBranch.DataBind();
        Ddl_ManifestBranch.Items.Insert(0, "SELECT");
		
        lblManifestNo.Text = "MANIFEST No : " + "M" + (Convert.ToInt32(Ddl_SelectVehicle.SelectedValue) + 100000000).ToString().Substring(1);
        Session["ManifestNo"] = lblManifestNo.Text;
    }
     protected void btnPrintToDo_Click(object sender, EventArgs e)
    {
        string strType = "", strrequestId = "";
        string strGetType = Request["Type"].ToString();
        if (strGetType == "Tranship")
        {
            strType = "TSLOAD";
            strrequestId = Ddl_SelectVehicle.SelectedValue.ToString();          
        }
        else
        {
            if (Ddl_Loading.SelectedValue.ToString() == "DELIVERY")
            {
                strType = "DELIVERYLOAD";
            }
	    if (Ddl_Loading.SelectedValue.ToString() == "PICKUP")	
            {	
                strType = "PICKUP";	
            }
        }
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintScreen.aspx?Type=" + strType + "&Value=" + strrequestId 
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }
	
     protected void btnPrintDRS_Click(object sender, EventArgs e)
    {
        string strType = "", strrequestId = "", strBranch = "";
        string strGetType = Request["Type"].ToString();
        if (strGetType == "Tranship")
        {
            strType = "TSLOADED";
            strrequestId = Ddl_SelectVehicle.SelectedValue.ToString();
            strBranch    = ddlManifest.SelectedValue.ToString(); 
        }
        else
        {
            if (Ddl_Loading.SelectedValue.ToString() == "DELIVERY")
            {
                strType = "DRS";
            }
	    if (Ddl_Loading.SelectedValue.ToString() == "PICKUP")	
            {	
                strType = "PICKUPMEMO";	
            }	
            strrequestId = Ddl_PickupVehicle.SelectedValue.ToString();
        }
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintScreen.aspx?Type=" + strType + "&Value=" + strrequestId + "&branch=" + strBranch 
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }
    protected void Btn_PickDelReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    protected void Btn_TranshipReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    protected void Button_PickDelSubmit_Click(object sender, EventArgs e)
    {
        if(Ddl_Loading.SelectedItem.ToString() == "PICKUP")
        {
            foreach (GridViewRow row in gvPickupLoadingDetails.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chk_select");
                if (chk.Checked == true)
                {
                    WaybillItemStatus wb = new WaybillItemStatus();
                    wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                    wb.statusID = 2;
                    string qty = (row.FindControl("LoadedItemQty") as TextBox).Text;
                    wb.itemQty = Convert.ToInt32(qty);
                    wb.createdDateTime = new CFunctions().CurrentDateTime();
                    wb.branchID = Convert.ToInt32(Session["BranchId"]);
                    wb.vehicleRequestId = Convert.ToInt32(Ddl_PickupVehicle.SelectedValue);
                    wb.userID = Convert.ToInt32(Session["userID"]);
                    wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                    string remQty = row.Cells[12].Text;
                    Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

                    if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
                    {
                        Lblerror.Text = "Enter correct Qty";
                    }
                    else
                    {
                        bool alertMsg = (new LoadingUnloadingFunctions()).changeTranshipLoadStatus(wb);

                        if (alertMsg)
                        {
                            waybillNo = row.Cells[4].Text.ToString();
                            date = row.Cells[6].Text.ToString();
                            materialName = row.Cells[8].Text.ToString();
                            packageName = row.Cells[9].Text.ToString();
                            valueActualWeight = row.Cells[10].Text.ToString();
                            loadedQty = (row.FindControl("LoadedItemQty") as TextBox).Text;

                            if (ViewState["LoadingData"] != null)
                            {
                                DataTable dt = (DataTable)ViewState["LoadingData"];
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
                        btn_PickupLoadingList_Click(sender, e);

                    }
                }
            }
        }
        else
        {
            foreach (GridViewRow row in gvDeliveryLoadingDetails.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chk_select");
                if (chk.Checked == true)
                {
                    WaybillItemStatus wb = new WaybillItemStatus();
                    wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                    wb.statusID = 6;
                    string qty = (row.FindControl("LoadedItemQty") as TextBox).Text;
                    wb.itemQty = Convert.ToInt32(qty);
                    wb.createdDateTime = new CFunctions().CurrentDateTime();
                    wb.branchID = Convert.ToInt32(Session["BranchId"]);
                    wb.vehicleRequestId = Convert.ToInt32(Ddl_PickupVehicle.SelectedValue);
                    wb.userID = Convert.ToInt32(Session["userID"]);
                    wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                    string remQty = row.Cells[13].Text;
                    Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

                    if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
                    {
                        Lblerror.Text = "Enter correct Qty";
                    }
                    else
                    {
                        bool alertMsg = (new LoadingUnloadingFunctions()).changeTranshipLoadStatus(wb);

                        if (alertMsg)
                        {
                            waybillNo = row.Cells[4].Text.ToString();
                            date = row.Cells[6].Text.ToString();
                            materialName = row.Cells[9].Text.ToString();
                            packageName = row.Cells[10].Text.ToString();
                            valueActualWeight = row.Cells[11].Text.ToString();
                            loadedQty = (row.FindControl("LoadedItemQty") as TextBox).Text;

                            if (ViewState["LoadingData"] != null)
                            {
                                DataTable dt = (DataTable)ViewState["LoadingData"];
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
                        btn_PickupLoadingList_Click(sender, e);
                    }

                }
            }
        }
    }
    protected void Btn_TranshipSubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvwLoadingDetails.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chk_select");
            if (chk.Checked == true)
            {
                WaybillItemStatus wb = new WaybillItemStatus();
                wb.WayBillItemId = Convert.ToInt32(row.Cells[2].Text);
                wb.statusID = 4;
                string qty = (row.FindControl("LoadedItemQty") as TextBox).Text;
                wb.itemQty = Convert.ToInt32(qty);
                wb.createdDateTime = new CFunctions().CurrentDateTime();
                wb.branchID = Convert.ToInt32(Session["BranchId"]);
                wb.vehicleRequestId = Convert.ToInt32(Ddl_SelectVehicle.SelectedValue);
                wb.userID = Convert.ToInt32(Session["userID"]);
                wb.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                string remQty = row.Cells[14].Text;
                Label Lblerror = (row.FindControl("Lbl_QtyError") as Label);

                if (Convert.ToInt32(qty) > Convert.ToInt32(remQty))
                {
                    Lblerror.Text = "Enter correct Qty";
                }
                else
                {
                    bool alertMsg = (new LoadingUnloadingFunctions()).changeTranshipLoadStatus(wb);

                    if (alertMsg)
                    {
                        waybillNo = row.Cells[4].Text.ToString();
                        date = row.Cells[6].Text.ToString();
                        pickupBranch = row.Cells[8].Text.ToString();
                        deliveryBranch = row.Cells[9].Text.ToString();
                        materialName = row.Cells[10].Text.ToString();
                        packageName = row.Cells[11].Text.ToString();
                        valueActualWeight = row.Cells[12].Text.ToString();
                        loadedQty = (row.FindControl("LoadedItemQty") as TextBox).Text;

                        if (ViewState["TranshipLoadingData"] != null)
                        {
                            DataTable dt = (DataTable)ViewState["TranshipLoadingData"];
                            int count = dt.Rows.Count;
                            TranshipBindGrid(count);
                        }
                        else
                        {
                            TranshipBindGrid(1);
                        }

                        waybillNo = null;
                        date = null;
                        deliveryBranch = null;
                        pickupBranch = null;
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
    protected void btnPrintLHS_Click(object sender, EventArgs e)
    {
        string strrequestId = "", strBranch = "";
        string strGetType = "LHS";
        //strType = "LHS";
        strrequestId = Ddl_SelectVehicle.SelectedValue.ToString();
        //strBranch = ddlManifest.SelectedValue.ToString();
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintLHS.aspx?Value=" + strrequestId + "&branch=" + strBranch
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }
}
