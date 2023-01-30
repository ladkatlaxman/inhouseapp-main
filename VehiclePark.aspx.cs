using System;
using System.Collections.Generic;
using BLFunctions;
using BLProperties;
using System.Web.UI.WebControls;

public partial class VehiclePark : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                openPage();
            }
            else
                Response.Redirect("Login.aspx");
        }
    }
    public void openPage()
    {
        string strGetType = Request["Type"].ToString();
        switch (strGetType)
        {
            case "PickDel":
                HeaderName.InnerText = "PARK VEHICLE (PICKUP/DELIVERY)";
                List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 3, "PD");
                GV_VehiclePark.DataSource = ViewList;
                GV_VehiclePark.DataBind();
                GV_VehiclePark.Columns[4].Visible = false;
                break;
            case "Tranship":
                HeaderName.InnerText = "PARK VEHICLE (TRANSHIPMENT)";
                FillGrid();
                break;

            default:
                break;
        }
    }
    /*----------------Fill Data in Gridview Code with sorting--------------------*/
    private void FillGrid()
    {
	//if(1==2)
	{
        try
        {
            List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleParkData(Convert.ToInt32(Session["BranchId"]));
            // List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 3, "");
            GV_VehiclePark.DataSource = ViewList;
            GV_VehiclePark.DataBind();
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message.ToString();
        }
	}
    }
   
    protected void GV_VehiclePark_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName == "PARK")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GV_VehiclePark.Rows[rowIndex];
            VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
            vehicleReq.VehicleRequestID = Convert.ToInt32(row.Cells[2].Text);
            vehicleReq.StatusID = 4;
            string Km = (row.FindControl("Txt_Km") as TextBox).Text;
            if (Km != "")
            {
                vehicleReq.KMS = Convert.ToDecimal(Km);
                vehicleReq.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                vehicleReq.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
                vehicleReq.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
                vehicleReq.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
                bool alertMsg = (new VehicleRequestFunction()).SaveVehicleRequestLHSStatus(vehicleReq);
                if (alertMsg)
                    (new CFunctions()).showalert("VehicleNo", "PARKED_SUCCESSFULLY", this);
                FillGrid();
            }
           else
            {
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter KM')", true);
            }
        }
    }
}