using NameSpaceConnection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WBEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lnkEditData_Click(object sender, EventArgs e)
    {
        if(Txt_WayBillNo.Text.Equals(""))
        {
            return;
        }
        IDataReader dr = GetWaybillHeaderData(Txt_WayBillNo.Text);
        while (dr.Read())
        {
            hfWayBillId.Value = dr["WayBillId"].ToString(); 
            Txt_CustName.Text = dr["customerName"].ToString();
            txtWayBillDate.Text = dr["wayBillDate"].ToString();
            txtConsigneeName.Text = dr["ConsigneeName"].ToString();
            txtPINCode.Text = dr["DelPincode"].ToString() ;
            txtAddress.Text = dr["consigneeAddress"].ToString();
            hfAreaId.Value = dr["consigneeAddress"].ToString();
            txtArea.Text = dr["DelArea"].ToString();
        }
        IDataReader drItems = GetWaybillDetailsData(Txt_WayBillNo.Text);
        gvmaterial.DataSource = drItems; 
        gvmaterial.DataBind();
    }

    public IDataReader GetWaybillHeaderData(string WaybillNo)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillNo", WaybillNo.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillHeaderDataForEdit", paramList);
        return Reader;
    }
    public IDataReader GetWaybillDetailsData(string WaybillNo)
    {
        List<Parameters> paramList = new List<Parameters>();
        paramList.Add(new Parameters("@WaybillNo", WaybillNo.ToString()));
        IDataReader Reader = (new Connection()).ReadSp("ssp_GetWaybillDetailsDataForEdit", paramList);
        return Reader; 
    }

}