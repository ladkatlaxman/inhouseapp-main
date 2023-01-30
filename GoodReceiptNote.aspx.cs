using System;
using BLFunctions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLProperties;

public partial class GoodReceiptNote : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {

            }
            else
                Response.Redirect("Login.aspx");
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    protected void Button_Submit_Click(object sender, EventArgs e)
    {
        GoodsReceiptNote grn = new GoodsReceiptNote();
        grn.grnNo = Txt_GrnNo.Text.ToString().ToUpper();
        grn.MaterialName = Txt_MaterialName.Text.ToString().ToUpper();
        grn.PoNo = Txt_PoNo.Text.ToString().ToUpper();
        grn.Qty = Convert.ToInt32(Txt_Qty.Text);
        grn.UOM = Ddl_Unit.SelectedItem.Text.ToString().ToUpper();
        bool alert = new MasterFormFunctions().SaveGoodsReceiptNote(grn);
        if (alert)
        {
            (new CFunctions()).showalert("Button_Submit1", "SAVE", this);
            Txt_GrnNo.Text = "";
            Txt_Qty.Text = "";
            Txt_MaterialName.Text = "";
            Ddl_Unit.SelectedIndex = 0;
            Txt_PoNo.Text = "";
        }
    }
}