using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using BLFunctions;
using BLProperties;

public partial class ReportDataOne : System.Web.UI.Page
{
    public static string fromfinalDate = string.Empty;
    public static string tofinalDate = string.Empty;
    string strGetType;
    string strVehicleRequestId = "";
    int strManifestColumnNo = 0, strDRSNo = 0, bstrDone = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str = "";
        lblError.Visible = false;
        HeaderDetails.Visible = false;
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                HttpContext.Current.Application["AllCustName"] = null;
                DataTable dt = new DataTable();
                dt = new CommFunctions().getUserAccessAllReport(Session["userName"].ToString());
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["username"].ToString() == Session["userName"].ToString())
                    {
                        AllBranchesReport.Visible = true;
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", new Date());" + "\n" +
                    "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", new Date());";
            CFunctions.setjavascript(CFunctions.javascript + str);

        }
        if (Txt_FromDate.Text.ToString().Trim() == "") fromfinalDate = "new Date()"; else fromfinalDate = "'" + Txt_FromDate.Text.ToString() + "'";
        if (Txt_ToDate.Text.ToString().Trim() == "") tofinalDate = "new Date()"; else tofinalDate = "'" + Txt_ToDate.Text.ToString() + "'";

        str = "$(\"[id$= Txt_FromDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", " + fromfinalDate + ");" + "\n" +
              "$(\"[id$= Txt_ToDate]\").datepicker({ dateFormat: 'dd/mm/yy'}).datepicker(\"setDate\", " + tofinalDate + ");";
        CFunctions.setjavascript(CFunctions.javascript + str);

        (new CFunctions()).GetJavascriptFunction(this, "Txt_SearchCustName", "hfSearchCustName", "ReportData.aspx/getCustomerName", "GetData", "});});");
        (new CFunctions()).GetJavascript(CFunctions.javascript, this);

        HeaderDetails.Visible = false;
        //gvSecondGrid.Visible = false;

        try { strVehicleRequestId = Request["VehicleRequestId"].ToString(); } catch { };

        strGetType = Ddl_Select.SelectedValue.ToString();

        if (strGetType == "")
        {
            try { strGetType = Request["value"].ToString(); } catch { };
            try { strVehicleRequestId = Request["VehicleRequestId"].ToString(); } catch { };
            if (strVehicleRequestId != "") strGetType = "VEHICLEREQUESTMATERIAL";
            Ddl_Select.SelectedValue = strGetType.ToString().ToUpper(); ;
        }

        if (strVehicleRequestId != "" | strGetType != "")
        {
            if (IsPostBack) return;
            //Ddl_Select.SelectedValue = "VEHICLEREQUESTMATERIAL";
            fillGrid();
        }
    }
    [WebMethod]
    public static string[] getCustomerName(string searchPrefixText, string data)
    {
        return (new PartyCustomerFunctions()).getAllCustName(searchPrefixText, data);
    }
    public void ConvertDate()
    {
        String fromdate = Txt_FromDate.Text.ToString().Trim();
        fromdate = fromdate == "" ? "SELECT" : Txt_FromDate.Text.ToString().Trim();
        string[] fromdateFormat = fromdate.Split('-');
        fromfinalDate = null;
        for (int i = fromdateFormat.Count() - 1; i >= 0; i--)
        {
            if (i == 0)
            {
                fromfinalDate += fromdateFormat[i].ToString();
            }
            else
            {
                fromfinalDate += fromdateFormat[i].ToString() + "/";
            }
        }

        String todate = Txt_ToDate.Text.ToString().Trim();
        todate = todate == "" ? "SELECT" : Txt_ToDate.Text.ToString().Trim();
        string[] todateFormat = todate.Split('-');
        tofinalDate = null;
        for (int i = todateFormat.Count() - 1; i >= 0; i--)
        {
            if (i == 0)
            {
                tofinalDate += todateFormat[i].ToString();
            }
            else
            {
                tofinalDate += todateFormat[i].ToString() + "/";
            }
        }
    }
    public void fillGrid()
    {
        //ConvertDate();
        // string strGetType = Request["Type"].ToString();
        //string strVehicleRequestId = "";
        //string strSelectReport = "";

        gvFirstGrid.DataSource = null;
        gvFirstGrid.DataBind();
        //GV_ExportFirstGrid.DataSource = null;
        //GV_ExportFirstGrid.DataBind();
        gvFirstGrid.DataSource = null;
        gvFirstGrid.DataBind();
        //GV_ExportSecondGrid.DataSource = null;
        //GV_ExportSecondGrid.DataBind();
        gvSecondGrid.DataSource = null;
        gvSecondGrid.DataBind();
        divManifest.Visible = false;
        divDRS.Visible = false;

        DataTable dt = null;
        switch (strGetType.ToUpper())
        {
            case "WAYBILLS":
                HeaderName.InnerText = "WAY BILLS CREATED";
                dt = (new CommFunctions()).ViewWayBillsCreated(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "BOOKINGWAYBILL":
                HeaderName.InnerText = "WAYBILL BOOKING REPORT";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewWayBillBookingReport(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewWayBillBookingReport(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "BOOKINGWAYBILLPAID":
                HeaderName.InnerText = "WAYBILL BOOKING REPORT (PAID / TO PAY) ";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewWayBillBookingReport(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), "NOTCREDIT");
                else
                    dt = (new CommFunctions()).ViewWayBillBookingReport(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), "NOTCREDIT");
                break;
            case "BOOKINGWAYBILLDELIVERY":
                HeaderName.InnerText = "WAYBILL BOOKING REPORT (DELIVERY BRANCH)";
                dt = (new ReportFunctions()).ViewWayBillBookingReportDeliveryBranch(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;

            case "BOOKINGITEMS":
                HeaderName.InnerText = "WAYBILL ITEMS BOOKING REPORT";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewBookingReport(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewBookingReport(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "BOOKING":
                HeaderName.InnerText = "BOOKING REPORT";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewBookingReport(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewBookingReport(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "MATERIALFORWARDING":
                HeaderName.InnerText = "MATERIAL FORWARDING REPORT";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewForwardingReport(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewForwardingReport(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "DRSREGISTER":
                HeaderName.InnerText = "DRS Register";
                if (chkALLBranches.Checked)
                {
                    if (Txt_SearchCustName.Text != "" && Ddl_PodUploaded.SelectedValue == "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), hfSearchCustName.Value);
                    }
                    else if (Txt_SearchCustName.Text == "" && Ddl_PodUploaded.SelectedValue != "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), null, Ddl_PodUploaded.SelectedValue);
                    }
                    else if (Txt_SearchCustName.Text == "" && Ddl_PodUploaded.SelectedValue == "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                    }
                    else if (Txt_SearchCustName.Text != "" && Ddl_PodUploaded.SelectedValue != "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), hfSearchCustName.Value, Ddl_PodUploaded.SelectedValue);
                    }
                }
                else
                {
                    if (Txt_SearchCustName.Text != "" && Ddl_PodUploaded.SelectedValue == "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), hfSearchCustName.Value);
                    }
                    else if (Txt_SearchCustName.Text == "" && Ddl_PodUploaded.SelectedValue != "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), null, Ddl_PodUploaded.SelectedValue);
                    }
                    else if (Txt_SearchCustName.Text == "" && Ddl_PodUploaded.SelectedValue == "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                    }
                    else if (Txt_SearchCustName.Text != "" && Ddl_PodUploaded.SelectedValue != "ALL")
                    {
                        dt = (new CommFunctions()).ViewDRSRegister(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), hfSearchCustName.Value, Ddl_PodUploaded.SelectedValue);
                    }
                }
                break;
            case "PICKUPS":
                HeaderName.InnerText = "PICK UPS CREATED";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewAllPickups(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString()); 
                else
                    dt = (new CommFunctions()).ViewAllPickups(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "ALLOPENPICKUPS":
                HeaderName.InnerText = "ALL OPEN PICKUPS";
                dt = (new CommFunctions()).ViewAllOpenPickups(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "BOOKINGWAYBILLS":
                HeaderName.InnerText = "BOOKED WAYBILLS";
                dt = (new CommFunctions()).ViewWayBillsBranchStatus(Convert.ToInt32(Session["branchID"].ToString()), 1);
                break;
            case "TOBRANCHSTOCK":
                HeaderName.InnerText = "TO BRANCH STOCK";
                dt = (new CommFunctions()).ViewWayBillsBranchStock(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "TOROUTESTOCK":
                HeaderName.InnerText = "WAYBILLS FOR THE ROUTES";
                dt = (new CommFunctions()).ViewWayBillsRouteStock(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "LOADEDWAYBILLS":
                HeaderName.InnerText = "LOADED WAYBILLS";
                dt = (new CommFunctions()).ViewWayBillsBranchStatus(Convert.ToInt32(Session["branchID"].ToString()), 2);
                break;
            case "BRANCHVEHICLES":
                HeaderName.InnerText = "BRANCH VEHICLES";
                dt = (new CommFunctions()).ViewBranchVehicles(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "VEHICLEREQUESTS":
                HeaderName.InnerText = "VEHICLE REQUESTS";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewVehiclesRequests(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewVehiclesRequests(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "VEHICLEINTRIP":
                HeaderName.InnerText = "VEHICLES IN TRIP";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewVehiclesInTrip(0);
                else
                    dt = (new CommFunctions()).ViewVehiclesInTrip(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "VEHICLEREQUESTMATERIAL":
                HeaderName.InnerText = "VEHICLE REQUEST MATERIAL";
                dt = (new CommFunctions()).ViewRequestsMaterial(strVehicleRequestId);
                break;
            case "BRANCHSTOCK":
                HeaderName.InnerText = "WAYBILL STOCK AT BRANCH";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewBranchStockMaterial(0);
                else
                    dt = (new CommFunctions()).ViewBranchStockMaterial(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "TRANSHIPMENTSTOCK":
                HeaderName.InnerText = "WAYBILL STOCK AT BRANCH - FOR TRANSSHIPMENT";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewBranchTranshipmentStockMaterial(0);
                else
                    dt = (new CommFunctions()).ViewBranchTranshipmentStockMaterial(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "DELIVERYBRANCHSTOCK":
                HeaderName.InnerText = "WAYBILL STOCK AT BRANCH - FOR DELIVERY";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewBranchDeliveryStockMaterial(0);
                else
                    dt = (new CommFunctions()).ViewBranchDeliveryStockMaterial(Convert.ToInt32(Session["branchID"].ToString()));
                break;
            case "VEHICLEMOVEMENT":
                HeaderName.InnerText = "VEHICLE MOVEMENTS";
                dt = (new CommFunctions()).ViewVehicleMovements("", Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "BRANCHLOCATIONS":
                HeaderName.InnerText = "BRANCH LOCATIONS";
                dt = (new CommFunctions()).ViewBranchLocations(Session["branchID"].ToString());
                break;
            case "CUSTOMERS":
                HeaderName.InnerText = "CONSIGNOR LIST";
                dt = (new CommFunctions()).ViewCustomerList(Convert.ToInt32(Session["branchID"].ToString()));
                dt.Columns.Remove("branchID");
                dt.Columns["customerID"].ColumnName = "SR.NO";
                dt.Columns["customerName"].ColumnName = "CUSTOMER NAME";
                dt.Columns["ContactNo"].ColumnName = "CONTACT NO";
                dt.Columns["locPincode"].ColumnName = "PINCODE";
                dt.Columns["areaName"].ColumnName = "AREA";
                dt.Columns["Address"].ColumnName = "ADDRESS";
                dt.Columns["cityName"].ColumnName = "CITY";
                int counter2 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter2++).ToString();
                }
                break;
            case "CONSIGNORS":
                HeaderName.InnerText = "WALKIN CONSIGNOR LIST";
                dt = (new CommFunctions()).ViewWalkinCustomerList(Convert.ToInt32(Session["branchID"].ToString()));
                dt.Columns.Remove("branchId");
                dt.Columns["ConsignorId"].ColumnName = "SR.NO";
                dt.Columns["customerName"].ColumnName = "CUSTOMER NAME";
                dt.Columns["ContactNo"].ColumnName = "CONTACT NO";
                dt.Columns["locPincode"].ColumnName = "PINCODE";
                dt.Columns["areaName"].ColumnName = "AREA";
                dt.Columns["Address"].ColumnName = "ADDRESS";
                dt.Columns["cityName"].ColumnName = "CITY";
                int counter3 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter3++).ToString();
                }
                break;
            case "CONSIGNEE":
                HeaderName.InnerText = "CONSIGNEE LIST";
                dt = (new CommFunctions()).ViewConsigneeList(Convert.ToInt32(Session["branchID"].ToString()));
                dt.Columns.Remove("branchId");
                dt.Columns["ConsigneeId"].ColumnName = "SR.NO";
                dt.Columns["customerName"].ColumnName = "CUSTOMER NAME";
                dt.Columns["ContactNo"].ColumnName = "CONTACT NO";
                dt.Columns["locPincode"].ColumnName = "PINCODE";
                dt.Columns["areaName"].ColumnName = "AREA";
                dt.Columns["Address"].ColumnName = "ADDRESS";
                dt.Columns["cityName"].ColumnName = "CITY";
                int counter4 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter4++).ToString();
                }
                break;
            case "BILLINGPARTY":
                HeaderName.InnerText = "BILLING PARTY LIST";
                dt = (new CommFunctions()).ViewBillingParty();
                dt.Columns["customerID"].ColumnName = "SR.NO";
                dt.Columns["customerName"].ColumnName = "CUSTOMER NAME";
                dt.Columns["ContactNo"].ColumnName = "CONTACT NO";
                dt.Columns["locPincode"].ColumnName = "PINCODE";
                dt.Columns["areaName"].ColumnName = "AREA";
                dt.Columns["Address"].ColumnName = "ADDRESS";
                dt.Columns["cityName"].ColumnName = "CITY";
                int counter5 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter5++).ToString();
                }
                break;
            case "WAYBILLMOVEMENT":
                HeaderName.InnerText = "WAY BILL MOVEMENTS";
                if(chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewWayBillMovement("", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewWayBillMovement(Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "CUSTOMERCONTRACTS":
                HeaderName.InnerText = "CUSTOMER CONTRACTS";
                dt = (new CommFunctions()).ViewCustomerContracts("");
                break;
            case "MATERIAL":
                HeaderName.InnerText = "MATERIAL TYPE";
                dt = (new CommFunctions()).ViewMaterialList();
                //    dt.Columns.Remove("materialID");             
                dt.Columns["materialID"].ColumnName = "SR.NO";
                dt.Columns["materialName"].ColumnName = "MATERIAL TYPE";
                int counter = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter++).ToString();
                }
                break;
            case "PACKAGE":
                HeaderName.InnerText = "PACKAGE TYPE";
                dt = (new CommFunctions()).ViewPackageList();
                // dt.Columns.Remove("packID");
                dt.Columns["packID"].ColumnName = "SR.NO";
                dt.Columns["typeOfPackage"].ColumnName = "PACKAGE TYPE";
                int counter1 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter1++).ToString();
                }
                break;
            case "VEHICLERATETYPE":
                HeaderName.InnerText = "RATE TYPE";
                dt = (new CommFunctions()).ViewVehicleRateTypeList();
                // dt.Columns.Remove("packID");
                dt.Columns["RateTypeId"].ColumnName = "SR.NO";
                dt.Columns["RateTypeName"].ColumnName = "RATE TYPE";
                int counter7 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter7++).ToString();
                }
                break;
            case "WAYBILLRATETYPE":
                HeaderName.InnerText = "RATE TYPE";
                dt = (new CommFunctions()).ViewWaybillRateTypeList();
                // dt.Columns.Remove("packID");
                dt.Columns["RateTypeId"].ColumnName = "SR.NO";
                dt.Columns["RateTypeName"].ColumnName = "RATE TYPE";
                int counter8 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter8++).ToString();
                }
                break;
            case "SUMMARY":
                HeaderName.InnerText = "MONTHLY SUMMARY";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewWayBillSummary("", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewWayBillSummary(Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "DRS":
                string strDRSNo = ""; int iDRSNo = 0;
                strDRSNo = txtWayBillNo.Text;
                if (strDRSNo == "")
                {
                    try { strDRSNo = Request["identity"].ToString(); } catch { };
                    Int32.TryParse(strDRSNo, out iDRSNo);
                    txtWayBillNo.Text = "D" + (1000000 + iDRSNo).ToString().Substring(1);
                }
                if (txtWayBillNo.Text != "")
                {
                    if (txtWayBillNo.Text.Substring(0, 1) == "D")
                    {
                        strDRSNo = txtWayBillNo.Text.Substring(1);
                    }
                    dt = (new CommFunctions()).GetDeliveryLoadedWayBills(strDRSNo, Session["branchID"].ToString());
                    divDRS.Visible = true;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Messagebox", "alert('Please Enter DRS No');", true);
                    txtWayBillNo.Focus();
                }
                break;
            case "LHS":
                string strManifestNo = ""; int iManifestNo = 0;
                strManifestNo = txtWayBillNo.Text;
                if (strManifestNo == "")
                {
                    try { strManifestNo = Request["identity"].ToString(); } catch { };
                    Int32.TryParse(strManifestNo, out iManifestNo);
                    txtWayBillNo.Text = "M" + (1000000 + iManifestNo).ToString().Substring(1);
                }
                if (strManifestNo.Length > 0)
                {

                    if (strManifestNo.Substring(0, 1) == "M")
                    {
                        strManifestNo = strManifestNo.Substring(1);
                    }
                    dt = (new CommFunctions()).GetManifestdWayBills(strManifestNo);
                }
                break;
            case "MANIFEST":
                HeaderName.InnerText = "MANIFESTS";
                if (txtWayBillNo.Text != "")
                    dt = (new CommFunctions()).ViewManifestWaybills(txtWayBillNo.Text, "", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "MANIFESTSUMMARY":
                HeaderName.InnerText = "MANIFESTS SUMMARY";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewManifestList("", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).ViewManifestList(Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "PICKUPLOADED":
                string strPickUPLoadedNo = "";
                strPickUPLoadedNo = txtWayBillNo.Text;
                if (strPickUPLoadedNo.Substring(0, 1).ToUpper() == "P")
                {
                    strPickUPLoadedNo = strPickUPLoadedNo.Substring(1);
                }
                dt = (new CommFunctions()).GetPickupLoadedWayBills(strPickUPLoadedNo, Session["branchID"].ToString());
                break;
            case "ROUTES":
                dt = (new CommFunctions()).GetRoutes();
                dt.Columns["routeID"].ColumnName = "SR.NO";
                dt.Columns["routeName"].ColumnName = "ROUTE NAME";
                int counter9 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter9++).ToString();
                }
                break;
            case "WAYBILLSTATIONARY":
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).getStationaryDates("", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).getStationaryDates(Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                dt.Columns["WayBillStationaryId"].ColumnName = "SR.NO";
                dt.Columns.Remove("currentNo");
                dt.Columns.Remove("Status");
                dt.Columns["startingNo"].ColumnName = "START";
                dt.Columns["endingNo"].ColumnName = "END";
                dt.Columns["Utilisation"].ColumnName = "UTILISATION";
                dt.Columns["Unused"].ColumnName = "UNUSED WAYBILLS";
                int counter10 = 1;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SR.NO"] = (counter10++).ToString();
                }
                break;
            case "PENDINGPOD":
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).getPendingPODs("");
                else
                    dt = (new CommFunctions()).getPendingPODs(Session["branchID"].ToString());
                break;
            case "WAYBILLMOBILE":
                dt = (new CommFunctions()).ViewMobileWayBill(Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "TRANSHIPWEIGHT":
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).getTranshipWeight("", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new CommFunctions()).getTranshipWeight(Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "PICKDELWEIGHT":
                if (chkALLBranches.Checked)
                    dt = (new ReportFunctions()).getPickDelWeight("", Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new ReportFunctions()).getPickDelWeight(Session["branchID"].ToString(), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "VEHICLEWAYBILLEXECDATE":
                HeaderName.InnerText = "Waybills Movement in Vehicles (Between Execution Dates)";
                dt = (new ReportFunctions()).ReportViewVehicleWaybillExecDate(Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "VEHICLEWAYBILLWAYBILLDATE":
                HeaderName.InnerText = "Waybills Movement in Vehicles (Between Waybill Dates)";
                dt = (new ReportFunctions()).ReportViewVehicleWaybillWayBillDate(Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "VEHICLECONTRACTCONDITION":
                HeaderName.InnerText = "Vehicle Contract Conditions";
                dt = (new ReportFunctions()).ReportViewVehicleContractConditions();
                break;
            case "MOVINGVEHICLE":
                HeaderName.InnerText = "Material in Transit";
                dt = (new ReportFunctions()).ReportMovingVehicleData(Session["branchId"].ToString());
                break;
            case "BRANCHLOAD":
                HeaderName.InnerText = "BRANCH LOAD";
                dt = (new ReportFunctions()).getBranchLoad(Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "WAYBILLTRANSITIONDELIVERY":
                HeaderName.InnerText = "WAYBILL DELIVERY MOVEMENT DATES";
                if (chkALLBranches.Checked) 
                    dt = (new ReportFunctions()).ViewWayTransition(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), "D"); 
                else 
                    dt = (new ReportFunctions()).ViewWayTransition(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), "D"); 
                break;
            case "WAYBILLTRANSITIONTRANSHIPMENT":
                HeaderName.InnerText = "WAYBILL TRANSHIPMENT MOVEMENT DATES";
                if (chkALLBranches.Checked)
                    dt = (new ReportFunctions()).ViewWayTransition(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), "T");
                else
                    dt = (new ReportFunctions()).ViewWayTransition(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), "T"); 
                break;
            case "MOVEMENTSUMMARY":
                HeaderName.InnerText = "WAYBILL MOVEMENT SUMMARY";
                if (chkALLBranches.Checked)
                    dt = (new ReportFunctions()).ViewWayBillMovementSummary(0, Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                else
                    dt = (new ReportFunctions()).ViewWayBillMovementSummary(Convert.ToInt32(Session["branchID"].ToString()), Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString());
                break;
            case "MIS":
                HeaderName.InnerText = "MIS REPORT";
                if (chkALLBranches.Checked)
                    dt = (new CommFunctions()).ViewMISdt(Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), null, "");
                else
                    dt = (new CommFunctions()).ViewMISdt(Txt_FromDate.Text.ToString(), Txt_ToDate.Text.ToString(), null, Session["branchID"].ToString());
                break;
            case "PENDDEL": 
                HeaderName.InnerText = "PENDING DELIVERIES"; 
                if (chkALLBranches.Checked) 
                    dt = (new ReportFunctions()).DashBoardPendingDeliveries(""); 
                else 
                    dt = (new ReportFunctions()).DashBoardPendingDeliveries(Session["branchID"].ToString()); 
                break; 
            case "PENDTRANS":
                HeaderName.InnerText = "PENDING TRANSHIPMENT"; 
                if (chkALLBranches.Checked) 
                    dt = (new ReportFunctions()).DashBoardPendingTranshipmentDetails(""); 
                else 
                    dt = (new ReportFunctions()).DashBoardPendingTranshipmentDetails(Session["branchID"].ToString()); 
                break; 
            default: 
                dt = null;
                break;
        }
        gvFirstGrid.DataSource = dt;
        gvFirstGrid.DataBind();
        //GV_ExportFirstGrid.DataSource = dt;
        //GV_ExportFirstGrid.DataBind();

        //Get the list of Branches in the Manifest 	
        if (strGetType == "LHS")
        {
            divManifest.Visible = true;
            String strAdded = "**"; ddlManifest.Items.Clear();
            string strItem;
            ddlManifest.Items.Add("All");

            if (dt != null)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    strItem = dr["Manifest Branch"].ToString();
                    if (strAdded.IndexOf("**" + strItem + "**") < 0)
                    {
                        ddlManifest.Items.Add(strItem);
                        strAdded += "**" + strItem + "**";
                    }
                }
            }
        }

        DataTableCollection dtMultiple;
        //if (strGetType.Equals("WAYBILLTRACKINGSUM")) strGetType = "WAYBILLTRACKING"; 
        switch (strGetType.ToUpper()) 
        { 
            case "WAYBILLTRACKING":
                if (txtWayBillNo.Text == "")
                {
                    break;
                }
                HeaderName.InnerText = "Way Bill Status";
                HeaderDetails.Visible = true;
                dtMultiple = (new CommFunctions()).ViewWayBillTracking(txtWayBillNo.Text);
                if (dtMultiple[0].Rows.Count > 0)
                {
                    Lbl_WaybillNo.Text = dtMultiple[0].Rows[0]["waybillNo"].ToString();
                    Lbl_ConsignorName.Text = dtMultiple[0].Rows[0]["CustomerName"].ToString();
                    Lbl_ConsigneeName.Text = dtMultiple[0].Rows[0]["consigneeName"].ToString();
                    Lbl_PickupBranch.Text = dtMultiple[0].Rows[0]["pickUpBranchName"].ToString();
                    Lbl_DeliveryBranch.Text = dtMultiple[0].Rows[0]["DeliveryBranchName"].ToString();
                    lblPickUpArea.Text = dtMultiple[0].Rows[0]["PickupArea"].ToString();
                    lblDeliveryArea.Text = dtMultiple[0].Rows[0]["DelArea"].ToString();
                    lblPickUpPIN.Text = dtMultiple[0].Rows[0]["PickupPincode"].ToString();
                    lblDeliveryPIN.Text = dtMultiple[0].Rows[0]["DelPincode"].ToString();
                    lblWayBillDate.Text = dtMultiple[0].Rows[0]["WayBillDate"].ToString();
                    Lbl_PaymentMode.Text = dtMultiple[0].Rows[0]["paymentMode"].ToString();
                    lblUser.Text = dtMultiple[0].Rows[0]["username"].ToString();
                    try
                    {
                        if (dtMultiple[0].Rows[0]["consignorName"].ToString() != "")
                            Lbl_ConsignorName.Text = dtMultiple[0].Rows[0]["consignorName"].ToString();
                    }
                    catch { }

                    /*GV_ExportFirstGrid.DataSource = dtMultiple[0];
                    GV_ExportFirstGrid.DataBind();*/
                    gvSecondGrid.Visible = true;
                    gvSecondGrid.DataSource = dtMultiple[1];
                    gvSecondGrid.DataBind();
                    //GV_ExportSecondGrid.DataSource = dtMultiple[1];
                    //GV_ExportSecondGrid.DataBind();
                }
                else
                {
                    HeaderDetails.Visible = false;
                    lblError.Visible = true;
                    lblError.Text = "Waybill not available in system.";
                }
                break;
            case "WAYBILLTRACKINGSUM":
                if (txtWayBillNo.Text == "")
                {
                    break;
                }
                HeaderName.InnerText = "Way Bill Status";
                HeaderDetails.Visible = true;
                dtMultiple = (new CommFunctions()).ViewWayBillTrackingSum(txtWayBillNo.Text);
                if (dtMultiple[0].Rows.Count > 0)
                {
                    Lbl_WaybillNo.Text = dtMultiple[0].Rows[0]["waybillNo"].ToString();
                    Lbl_ConsignorName.Text = dtMultiple[0].Rows[0]["CustomerName"].ToString();
                    Lbl_ConsigneeName.Text = dtMultiple[0].Rows[0]["consigneeName"].ToString();
                    Lbl_PickupBranch.Text = dtMultiple[0].Rows[0]["pickUpBranchName"].ToString();
                    Lbl_DeliveryBranch.Text = dtMultiple[0].Rows[0]["DeliveryBranchName"].ToString();
                    lblPickUpArea.Text = dtMultiple[0].Rows[0]["PickupArea"].ToString();
                    lblDeliveryArea.Text = dtMultiple[0].Rows[0]["DelArea"].ToString();
                    lblPickUpPIN.Text = dtMultiple[0].Rows[0]["PickupPincode"].ToString();
                    lblDeliveryPIN.Text = dtMultiple[0].Rows[0]["DelPincode"].ToString();
                    lblWayBillDate.Text = dtMultiple[0].Rows[0]["WayBillDate"].ToString();
                    Lbl_PaymentMode.Text = dtMultiple[0].Rows[0]["paymentMode"].ToString();
                    lblUser.Text = dtMultiple[0].Rows[0]["username"].ToString();
                    try
                    {
                        if (dtMultiple[0].Rows[0]["consignorName"].ToString() != "")
                            Lbl_ConsignorName.Text = dtMultiple[0].Rows[0]["consignorName"].ToString();
                    }
                    catch { }
                    gvSecondGrid.Visible = true;
                    gvSecondGrid.DataSource = dtMultiple[1];
                    gvSecondGrid.DataBind();
                }
                else
                {
                    HeaderDetails.Visible = false;
                    lblError.Visible = true;
                    lblError.Text = "Waybill not available in system.";
                }
                break;
        }
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        fillGrid();
    }
    protected void GV_CustomerList_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (strGetType.ToUpper() == "MOVINGVEHICLE")
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[strManifestColumnNo].Text != "" & e.Row.Cells[strManifestColumnNo].Text != "&nbsp;")
                {
                    strManifestColumnNo = 10;
                    HyperLink txtManifest = new HyperLink();
                    txtManifest.NavigateUrl = "ReportDataOne.aspx?value=LHS&identity=" + e.Row.Cells[10].Text;
                    txtManifest.Text = "M" + (10000 + (e.Row.Cells[10].Text).ToString()).Substring(1);
                    e.Row.Cells[strManifestColumnNo].Controls.Add(txtManifest);
                }
            }
        }

        if (strGetType.ToUpper() == "VEHICLEREQUESTS" || strGetType == "VEHICLEMOVEMENT" || strGetType == "VEHICLEINTRIP")
        {
            int gridViewCellCount = e.Row.Cells.Count; // GV_ExportFirstGrid.Rows[0].Cells.Count;
                                                       // string array to hold grid view column names.
            string[] columnNames = new string[gridViewCellCount];

            if (bstrDone == 0)
            {
                for (int i = 0; i < gridViewCellCount; i++)
                {
                    if (((DataControlFieldCell)(e.Row.Cells[i])).ContainingField.HeaderText == "LHS No")
                    {
                        strManifestColumnNo = i;
                    }
                    if (((DataControlFieldCell)(e.Row.Cells[i])).ContainingField.HeaderText == "DRS No")
                    {
                        strDRSNo = i;
                    }
                }
            }
            bstrDone = 1;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                /*HyperLink txt = new HyperLink();
                txt.NavigateUrl = "ReportDataOne.aspx?VehicleRequestId=" + e.Row.Cells[0].Text;
                txt.Text = "Get Vehicle Details";
                e.Row.Cells[0].Controls.Add(txt);*/

                if (e.Row.Cells[strManifestColumnNo].Text != "" & e.Row.Cells[strManifestColumnNo].Text != "&nbsp;")
                {
                    HyperLink txtManifest = new HyperLink();
                    txtManifest.NavigateUrl = "ReportDataOne.aspx?value=LHS&identity=" + e.Row.Cells[1].Text;
                    txtManifest.Text = "M" + (10000 + (e.Row.Cells[1].Text).ToString()).Substring(1);
                    e.Row.Cells[strManifestColumnNo].Controls.Add(txtManifest);
                }
                if (e.Row.Cells[strDRSNo].Text != "" & e.Row.Cells[strDRSNo].Text != "&nbsp;")
                {
                    HyperLink txtDRS = new HyperLink();
                    txtDRS.NavigateUrl = "ReportDataOne.aspx?value=DRS&identity=" + e.Row.Cells[1].Text;
                    txtDRS.Text = "D" + (10000 + (e.Row.Cells[1].Text).ToString()).Substring(1);
                    e.Row.Cells[strDRSNo].Controls.Add(txtDRS);
                }
            }
        }
    }
    /* Export To Excel Start */
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = new CFunctions().CurrentDateTime();
        string ReportName = HeaderName.InnerText;
        //GV_ExportFirstGrid.Visible = true;
        //GV_ExportSecondGrid.Visible = true;
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Report_" + ReportName + CurrentDateTime + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);

        /*GV_ExportFirstGrid.GridLines = GridLines.Both;
        GV_ExportFirstGrid.HeaderStyle.Font.Bold = true;
        GV_ExportFirstGrid.RenderControl(htmltextwrtter);
        GV_ExportSecondGrid.GridLines = GridLines.Both;
        GV_ExportSecondGrid.HeaderStyle.Font.Bold = true;
        GV_ExportSecondGrid.RenderControl(htmltextwrtter);*/

        gvFirstGrid.GridLines = GridLines.Both;
        gvFirstGrid.HeaderStyle.Font.Bold = true;
        gvFirstGrid.RenderControl(htmltextwrtter);

        Response.Write(strwritter.ToString());
        Response.End();
        //GV_ExportFirstGrid.Visible = false;
        //GV_ExportSecondGrid.Visible = false;
    }

    protected void btnExportInPDF_Click(object sender, EventArgs e)
    {
        //    Response.ContentType = "application/pdf";
        //    Response.AddHeader("content-disposition", "attachment;filename=TestPage.pdf");
        //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    StringWriter sw = new StringWriter();
        //    HtmlTextWriter hw = new HtmlTextWriter(sw);
        //  //  this.Page.RenderControl(hw);
        //    StringReader sr = new StringReader(sw.ToString());

        //        //XDocument pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        //        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //        //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //        //pdfDoc.Open();
        //        //htmlparser.Parse(sr);
        //        //pdfDoc.Close();
        //        //Response.Write(pdfDoc);
        //    Response.End();


        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //gvFirstGrid.AllowPaging = false;
        //gvFirstGrid.DataBind();
        //gvFirstGrid.RenderControl(hw);
        //StringReader sr = new StringReader(sw.ToString());
        ////Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        ////HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        ////PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        ////pdfDoc.Open();
        ////htmlparser.Parse(sr);
        ////pdfDoc.Close();
        ////Response.Write(pdfDoc);
        //Response.End();


        /*LocalReport report = new LocalReport();
        report.ReportPath = "Report1.rdlc";
        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";//This refers to the dataset name in the RDLC file
        rds.Value = (new CommFunctions()).ViewWayBillsBranchStatus(Convert.ToInt32(Session["branchID"].ToString()), 1);
        report.DataSources.Add(rds);
        //  Byte[] mybytes = report.Render("WORD");
        Byte[] mybytes = report.Render("PDF"); //for exporting to PDF
        using (FileStream fs = File.Create(@"D:\SalSlip.doc"))
        {
            fs.Write(mybytes, 0, mybytes.Length);
        }*/

    }
    protected void gvFirstGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvFirstGrid.PageIndex = e.NewPageIndex;
        fillGrid();
    }

    protected void gvSecondGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gvSecondGrid.PageIndex = e.NewPageIndex;
        fillGrid();
    }
    protected void btnPrintScreen_Click(object sender, EventArgs e)
    {
        string strType = "", strrequestId = "", strBranch = "";
        //string strGetType = Request["Value"].ToString();
        strGetType = Ddl_Select.SelectedValue;
        if (strGetType == "LHS")
        {
            strType = "TSLOADED";
            //strrequestId = Request["identity"].ToString();
            strBranch = ddlManifest.SelectedValue.ToString();
        }
        else if (strGetType == "DRS")
        {
            strType = "DRS";
            //strrequestId = Request["identity"].ToString();
        }
        strrequestId = txtWayBillNo.Text; //Request["Value"].ToString(); 
        if (strrequestId == "All") strrequestId = "";
        if (strrequestId != "")
        {
            strrequestId = strrequestId.Substring(1).TrimStart("0".ToCharArray());
        }
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintScreen.aspx?Type=" + strType + "&Value=" + strrequestId + "&branch=" + strBranch
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }

    protected void btnPrintLHS_Click(object sender, EventArgs e)
    {
        string strrequestId = "", strBranch = "";
        string strGetType = Request["Value"].ToString();
        //strType = "LHS";
        //strrequestId = Request["identity"].ToString();
        strrequestId = ddlManifest.SelectedValue.ToString();
        strBranch = ddlManifest.SelectedValue.ToString();
        string strPopup = "<script language='javascript' ID='printScript'>"
        // Passing intId to popup window.
        + "var w = window.open('PrintLHS.aspx?Value=" + strrequestId + "&branch=" + strBranch
        + "','new window', 'top=90, left=200, width=300, height=100, dependant=no, location=0, alwaysRaised=no, menubar=no, resizeable=no, scrollbars=n, toolbar=no, status=no, center=yes'); "
        + "w.window.print();"
        + "</script>";
        ScriptManager.RegisterStartupScript((Page)HttpContext.Current.Handler, typeof(Page), "Script1", strPopup, false);
    }
    protected void Ddl_Select_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (AllBranchesReport.Visible == true)
        {
            if (Ddl_Select.SelectedValue == "DRSREGISTER")
            {
                SearchingParam.Visible = true;
            }
            else { SearchingParam.Visible = false; }
        }
    }

    protected void lnkDirectDownload_Click(object sender, EventArgs e)
    {
        Btn_Search_Click(sender, e);
        btnExport_Click(sender, e); 
    }
}