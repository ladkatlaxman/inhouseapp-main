using BLFunctions;
using BLProperties;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

public partial class VehicleDispatch : System.Web.UI.Page
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
                HeaderName.InnerText = "DISPATCH VEHICLE (PICKUP/DELIVERY)";
                List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 2, "PD");
                GV_VehicleDispatch.DataSource = ViewList;
                GV_VehicleDispatch.DataBind();
                GV_VehicleDispatch.Columns[4].Visible = false;
                GV_VehicleDispatch.Columns[5].Visible = false;
                break;
            case "Tranship":
                HeaderName.InnerText = "DISPATCH VEHICLE (TRANSHIPMENT)";
                List<VehicleRequestProperties> ViewList1 = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 4, "RT");
                ViewList1.AddRange((new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 2, "RT"));
                ViewList1.RemoveAll(dt => dt.toBranchId == Session["BranchId"].ToString());
                //Remove the Vehicles which are at destination 
                GV_VehicleDispatch.DataSource = ViewList1;
                GV_VehicleDispatch.DataBind();
                break;

            default:
                break;
        }
    }
    /*----------------Fill Data in Gridview Code with sorting--------------------*/
    private void FillGrid()
    {
       // List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleDispatchData(Convert.ToInt32(Session["BranchId"]));
        List<VehicleRequestProperties> ViewList = (new VehicleRequestFunction()).ViewVehicleList(Convert.ToInt32(Session["BranchId"].ToString()), 2, "PD");
        GV_VehicleDispatch.DataSource = ViewList;
        GV_VehicleDispatch.DataBind();
    } 
  protected void GV_VehicleDispatch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DISPATCH")
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GV_VehicleDispatch.Rows[rowIndex];
            if (HeaderName.InnerText == "DISPATCH VEHICLE (PICKUP/DELIVERY)")
            {
                VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
                vehicleReq.VehicleRequestID = Convert.ToInt32(row.Cells[2].Text);
                vehicleReq.StatusID = 3;
                string Km = (row.FindControl("Txt_Km") as TextBox).Text;
                vehicleReq.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                vehicleReq.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
                vehicleReq.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
                vehicleReq.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
                  if (Km != "")
                {
                    vehicleReq.KMS = Convert.ToDecimal(Km);
                    bool alertMsg = (new VehicleRequestFunction()).SaveVehicleRequestLHSStatus(vehicleReq);
                    if (alertMsg)
                        (new CFunctions()).showalert("VehicleNo", "DISPATCHED_SUCCESSFULLY", this);
                    openPage();
                }
                else
                {
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter KM')", true);
                }
            }
            else
            {
                VehicleRequestProperties vehicleReq = new VehicleRequestProperties();
                vehicleReq.VehicleRequestID = Convert.ToInt32(row.Cells[2].Text);
                int waybillItemsCount = (new LoadingUnloadingFunctions()).GetCountOfWaybillItemsForDispatch(vehicleReq.VehicleRequestID, Convert.ToInt32(Session                ["BranchId"].ToString()));
                if (waybillItemsCount == 0)
                {
                    vehicleReq.StatusID = 3;
                    string Km = (row.FindControl("Txt_Km") as TextBox).Text; 
                    vehicleReq.Remark = (row.FindControl("Txt_Remark") as TextBox).Text.ToUpper();
                    vehicleReq.sealNo = (row.FindControl("sealNo") as TextBox).Text.ToUpper();                   
                    vehicleReq.sessionDetail.UserID = Convert.ToInt32(Session["userID"]);
                    vehicleReq.sessionDetail.BranchID = Convert.ToInt32(Session["BranchId"]);
                    vehicleReq.sessionDetail.CreationDateTime = (new CFunctions()).CurrentDateTime().ToUpper();
                    if(vehicleReq.sealNo!="")
                    {
                        if (Km != "")
                        {
                            vehicleReq.KMS = Convert.ToDecimal(Km);
                            bool alertMsg = (new VehicleRequestFunction()).SaveVehicleRequestLHSStatus(vehicleReq);
                            if (alertMsg)
                                (new CFunctions()).showalert("VehicleNo", "DISPATCHED_SUCCESSFULLY", this);
                            openPage();
                        }
                        else
                        {
                            System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter KM')", true);
                        }
                    }
                    else
                    {
                        System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Enter Seal No')", true);                 
                    }
                }
                else
                {
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please Unload All Waybills before Dispatch')", true);
                }
            }

        }
    }
}