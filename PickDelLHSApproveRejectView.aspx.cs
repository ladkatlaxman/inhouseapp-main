using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

public partial class PickDelLHSApproveRejectView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                FillGrid();
                //VehicleStatusCheck();
            }
            else
                Response.Redirect("Login.aspx");
        }

    }

    /*----------------Fill Data in Gridview Code with sorting--------------------*/
    private void FillGrid()
    {
        List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleCreatedData(Convert.ToInt32(Session["BranchId"]));
        GV_PickDelApprovedRejectView.DataSource = ViewList;
        GV_PickDelApprovedRejectView.DataBind();
    }
    protected void VehicleStatusCheck()
    {
        foreach (GridViewRow row in GV_PickDelApprovedRejectView.Rows)
        {
            Table Approved = row.FindControl("TableApproved") as Table;
            Table rejected = row.FindControl("TableRejected") as Table;

            VehicleRequestProperties VehicleReq = new VehicleRequestProperties();
            VehicleReq.VehicleRequestID = Convert.ToInt32(row.Cells[4].Text);
            VehicleRequestProperties VehicleStatus = (new VehicleRequestFunction()).CheckVehicleNoStatus(VehicleReq.VehicleRequestID);
            if (VehicleStatus.Status == "DISPATCHED" || VehicleStatus.Status == "CLOSED" || VehicleStatus.Status == "REJECTED")
            {
                Approved.Enabled = false;
                rejected.Enabled = false;

            }
        }
    }
    protected void Approved_Click(object sender, EventArgs e)
    {
        VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
        string[] commandArgs = Convert.ToString((sender as LinkButton).CommandArgument).ToString().Split(new char[] { ',' });
        vehicleReq.VehicleRequestID = Convert.ToInt32(commandArgs[0]);
        vehicleReq.VehicleID = Convert.ToInt32(commandArgs[1]);
        //vehicleReq.VehicleRequestID = Convert.ToInt32(Convert.ToString((sender as LinkButton).CommandArgument));
        VehicleRequestProperties VehicleStatus = (new VehicleRequestFunction()).CheckVehicleNoStatus(vehicleReq.VehicleID);
        if (VehicleStatus.Status == "CREATED")
        {
            vehicleReq.StatusID = 2;
            vehicleReq.Remark = "";
            vehicleReq.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
            vehicleReq.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
            vehicleReq.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
            bool alertMsg = (new VehicleRequestFunction()).SaveVehicleRequestLHSStatus(vehicleReq);
            if (alertMsg)
                (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
        }
        //else if (VehicleStatus.Status == "DISPATCHED")
        //    (new CFunctions()).showalert("VehicleNo", "DISPATCHED", this);
        //else if (VehicleStatus.Status == "PARKED")
        //    (new CFunctions()).showalert("VehicleNo", "PARKED", this);
        //else if (VehicleStatus.Status == "CLOSED")
        //    (new CFunctions()).showalert("VehicleNo", "CLOSED", this);
        //else if (VehicleStatus.Status == "REJECTED")
        //    (new CFunctions()).showalert("VehicleNo", "REJECTED", this);
        //else
        //    (new CFunctions()).showalert("VehicleNo", "APPROVED", this);
        FillGrid();
       // VehicleStatusCheck();
    }

    protected void Rejected_Click(object sender, EventArgs e)
    {

        VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
        string[] commandArgs = Convert.ToString((sender as LinkButton).CommandArgument).ToString().Split(new char[] { ',' });
        vehicleReq.VehicleRequestID = Convert.ToInt32(commandArgs[0]);
        vehicleReq.VehicleID = Convert.ToInt32(commandArgs[1]);
        //vehicleReq.VehicleRequestID = Convert.ToInt32(Convert.ToString((sender as LinkButton).CommandArgument));
        VehicleRequestProperties VehicleStatus = (new VehicleRequestFunction()).CheckVehicleNoStatus(vehicleReq.VehicleID);
        if (VehicleStatus.Status == "CREATED")
        {
            foreach (GridViewRow row in GV_PickDelApprovedRejectView.Rows)
            {
                LinkButton lk_Reject = row.FindControl("Rejected") as LinkButton;
                lk_Reject.OnClientClick = "return alert();";

                vehicleReq.StatusID = 6;
                vehicleReq.Remark = "";
                vehicleReq.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
                vehicleReq.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
                vehicleReq.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
                bool alertMsg = (new VehicleRequestFunction()).SaveVehicleRequestLHSStatus(vehicleReq);
                if (alertMsg)
                    (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
            }

        }
        //else if (VehicleStatus.Status == "DISPATCHED")
        //    (new CFunctions()).showalert("VehicleNo", "DISPATCHED", this);
        //else if (VehicleStatus.Status == "PARKED")
        //    (new CFunctions()).showalert("VehicleNo", "PARKED", this);
        //else if (VehicleStatus.Status == "CLOSED")
        //    (new CFunctions()).showalert("VehicleNo", "CLOSED", this);
        //else
        //    (new CFunctions()).showalert("VehicleNo", "REJECTED", this);
        FillGrid();
       // VehicleStatusCheck();
    }



    protected void GV_PickDelApprovedRejectView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //con.Open();
            GridView gv = (GridView)e.Row.FindControl("gridViewAccountDetail");
            int vehicleRequestID = Convert.ToInt32(e.Row.Cells[2].Text.ToString());
            List<AccountDetail> ViewList = (new VehicleRequestFunction()).ViewAccountDetailOnVehicle(vehicleRequestID);
            gv.DataSource = ViewList;
            gv.DataBind();
            gv.Attributes.Remove("CssClass");
        }
    }
}