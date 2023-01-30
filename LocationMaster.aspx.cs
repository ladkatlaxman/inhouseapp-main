using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLFunctions;
using BLProperties;
using System.Data;
using System.IO;
public partial class LocationMaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userName"] != null)
            {
                new CFunctions().dropdwnlist(null, RadioButtonList_SearchPincode, null, Txt_SearchPincode, "Pincode", "PincodeId", new CommFunctions().getLocationPincode(Txt_SearchPincode_Search.Text.ToString()));
                new CFunctions().dropdwnlist(null, RadioButtonList_SearchCity, null, Txt_SearchCity, "City", "CityId", new CommFunctions().getCity(Txt_SearchCity_Search.Text.ToString()));
                new CFunctions().dropdwnlist(null, RadioButtonList_SearchDistrict, null, Txt_SearchDistrict, "District", "DistrictId", new CommFunctions().getDistrict(Txt_SearchDistrict_Search.Text.ToString()));
                new CFunctions().dropdwnlist(null, RadioButtonList_SearchState, null, Txt_SearchState, "State", "StateId", new CommFunctions().getState(Txt_SearchState_Search.Text.ToString()));
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
           
        }
    }
    /*----------------Fill Data in Gridview Code with sorting--------------------*/
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    public void searchingDataInGridView(string sortExpression = null)
    {
        if (Txt_SearchPincode.Text.ToString() != "SELECT")
        {
            Location loc = new Location();            
            loc.PincodeId = Convert.ToInt32(RadioButtonList_SearchPincode.SelectedValue);
            DataTable dt = (new CommFunctions()).ViewLocationMasterPincodeWise(loc, RadioButtonList_SearchPincode.SelectedValue);
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewLocationMaster.DataSource = dv;
                GV_Export.DataSource = dv;                                      /*Export GV*/
            }
            else
            {
                gridViewLocationMaster.DataSource = dt;
                GV_Export.DataSource = dt;                                  /*Export GV*/
            }
            gridViewLocationMaster.DataBind();
            GV_Export.DataBind();
        }
        else if (Txt_SearchCity.Text.ToString() != "SELECT")
        {
            Location loc = new Location();           
            loc.CityId = Convert.ToInt32(RadioButtonList_SearchCity.SelectedValue);           
            DataTable dt = (new CommFunctions()).ViewLocationMasterCityWise(loc, RadioButtonList_SearchCity.SelectedValue);
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewLocationMaster.DataSource = dv;
                GV_Export.DataSource = dv;                                      /*Export GV*/
            }
            else
            {
                gridViewLocationMaster.DataSource = dt;
                GV_Export.DataSource = dt;                                  /*Export GV*/
            }
            gridViewLocationMaster.DataBind();
            GV_Export.DataBind();
        }
        else if (Txt_SearchDistrict.Text.ToString() != "SELECT")
        {
            Location loc = new Location();
            loc.DistrictId = Convert.ToInt32(RadioButtonList_SearchDistrict.SelectedValue);
            DataTable dt = (new CommFunctions()).ViewLocationMasterDistrictWise(loc, RadioButtonList_SearchDistrict.SelectedValue);
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewLocationMaster.DataSource = dv;
                GV_Export.DataSource = dv;                                      /*Export GV*/
            }
            else
            {
                gridViewLocationMaster.DataSource = dt;
                GV_Export.DataSource = dt;                                  /*Export GV*/
            }
            gridViewLocationMaster.DataBind();
            GV_Export.DataBind();
        }
        else if (Txt_SearchState.Text.ToString() != "SELECT")
        {
            Location loc = new Location();
            loc.StateId = Convert.ToInt32(RadioButtonList_SearchState.SelectedValue);
            DataTable dt = (new CommFunctions()).ViewLocationMasterStateWise(loc, RadioButtonList_SearchState.SelectedValue);
            if (sortExpression != null)
            {
                DataView dv = dt.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                gridViewLocationMaster.DataSource = dv;
                GV_Export.DataSource = dv;                                      /*Export GV*/
            }
            else
            {
                gridViewLocationMaster.DataSource = dt;
                GV_Export.DataSource = dt;                                  /*Export GV*/
            }
            gridViewLocationMaster.DataBind();
            GV_Export.DataBind();
        }
        else
        {
            (new CFunctions()).showalert("Button_Submit1", "NORECORD", this);
        }
    }
    protected void Txt_SearchPincode_Search_TextChanged(object sender, EventArgs e)
    {
        if(HiddenField_Txt_SearchPincode_Search.Value=="1")
        {
            new CFunctions().dropdwnlist(null, RadioButtonList_SearchPincode, null, Txt_SearchPincode, "Pincode", "Id", new CommFunctions().getLocationPincode(Txt_SearchPincode_Search.Text.ToString()));
            HiddenField_Txt_SearchPincode_Search.Value = "";
        }
    }

    protected void RadioButtonList_SearchPincode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(HiddenField_RadioButtonList_SearchPincode.Value=="1")
        {
            (new CFunctions()).DataList_SelectedIndexChanging(RadioButtonList_SearchPincode, Txt_SearchPincode);
            PopupControlExtender_SearchPincode.Commit(RadioButtonList_SearchPincode.SelectedItem.Text);
            HiddenField_RadioButtonList_SearchPincode.Value = "";
        }
    }

    protected void Txt_SearchCity_Search_TextChanged(object sender, EventArgs e)
    {
        if(HiddenField_Txt_SearchCity_Search.Value=="1")
        {
            new CFunctions().dropdwnlist(null, RadioButtonList_SearchCity, null, Txt_SearchCity, "City", "Id", new CommFunctions().getCity(Txt_SearchCity_Search.Text.ToString()));
            HiddenField_Txt_SearchCity_Search.Value = "";
        }
    }

    protected void RadioButtonList_SearchCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(HiddenField_RadioButtonList_SearchCity.Value=="1")
        {
            (new CFunctions()).DataList_SelectedIndexChanging(RadioButtonList_SearchCity, Txt_SearchCity);
            PopupControlExtender_SearchCity.Commit(RadioButtonList_SearchCity.SelectedItem.Text);
            HiddenField_RadioButtonList_SearchCity.Value = "";
        }
    }

    protected void Txt_SearchDistrict_Search_TextChanged(object sender, EventArgs e)
    {
        if(HiddenField_Txt_SearchDistrict_Search.Value=="1")
        {
            new CFunctions().dropdwnlist(null, RadioButtonList_SearchDistrict, null, Txt_SearchDistrict, "District", "Id", new CommFunctions().getDistrict(Txt_SearchDistrict_Search.Text.ToString()));
            HiddenField_Txt_SearchDistrict_Search.Value = "";
        }
    }

    protected void RadioButtonList_SearchDistrict_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(HiddenField_RadioButtonList_SearchDistrict.Value=="1")
        {
            (new CFunctions()).DataList_SelectedIndexChanging(RadioButtonList_SearchDistrict, Txt_SearchDistrict);
            PopupControlExtender_SearchDistrict.Commit(RadioButtonList_SearchDistrict.SelectedItem.Text);
            HiddenField_RadioButtonList_SearchDistrict.Value = "";
        }
    }

    protected void Txt_SearchState_Search_TextChanged(object sender, EventArgs e)
    {
        if(HiddenField_Txt_SearchState_Search.Value=="1")
        {
            new CFunctions().dropdwnlist(null, RadioButtonList_SearchState, null, Txt_SearchState, "State", "Id", new CommFunctions().getState(Txt_SearchState_Search.Text.ToString()));
            HiddenField_Txt_SearchState_Search.Value = "";
        }
    }

    protected void RadioButtonList_SearchState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(HiddenField_RadioButtonList_SearchState.Value=="1")
        {
            (new CFunctions()).DataList_SelectedIndexChanging(RadioButtonList_SearchState, Txt_SearchState);
            PopupControlExtender_SearchState.Commit(RadioButtonList_SearchState.SelectedItem.Text);
            HiddenField_RadioButtonList_SearchState.Value = "";
        }
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        if(HiddenField_Btn_Search.Value=="1")
        {
            gridViewLocationMaster.DataSource = null;
            gridViewLocationMaster.DataBind();
            searchingDataInGridView();
            searchLocationMaster.Visible = true;
            HiddenField_Btn_Search.Value = "";
        }
    }
    protected void gridViewLocationMaster_Sorting(object sender, GridViewSortEventArgs e)
    {
        searchingDataInGridView(e.SortExpression);
    }
    protected void gridViewLocationMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridViewLocationMaster.PageIndex = e.NewPageIndex;
        searchingDataInGridView();
    }

    /* Export To Excel Start */
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btn_ExporttoExcel_Click(object sender, EventArgs e)
    {
        string CurrentDateTime = new CFunctions().CurrentDateTime();

        GV_Export.Visible = true;
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Location Details" + CurrentDateTime + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GV_Export.GridLines = GridLines.Both;
        GV_Export.HeaderStyle.Font.Bold = true;
        GV_Export.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();
        GV_Export.Visible = false;
    }
    /* Export To Excel End */

}