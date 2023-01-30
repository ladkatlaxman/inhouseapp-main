//using Global;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using BLFunctions;
using BLProperties;

public partial class DieselRateMaster : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)

        {
            fillState();          
        }
    }
    //public void API()
    //{
    //    var client = new RestClient("https://newsrain-petrol-diesel-prices-india-v1.p.rapidapi.com/state?state=Delhi");
    //    var request = new RestRequest(Method.GET);
    //    request.AddHeader("x-rapidapi-host", "newsrain-petrol-diesel-prices-india-v1.p.rapidapi.com");
    //    request.AddHeader("x-rapidapi-key", "401ca88701mshd22e35298159d6dp1a8136jsn20f6f323d077");
    //    IRestResponse response = client.Execute(request);
    //}
    public void fillState()
    {
        Ddl_State.DataSource = (new CommFunctions()).GetState();
        Ddl_State.DataTextField = "State";
        Ddl_State.DataValueField = "StateId";
        Ddl_State.DataBind();
        Ddl_State.Items.Insert(0, "SELECT");

        Ddl_SearchState.DataSource = (new CommFunctions()).GetState();
        Ddl_SearchState.DataTextField = "State";
        Ddl_SearchState.DataValueField = "StateId";
        Ddl_SearchState.DataBind();
        Ddl_SearchState.Items.Insert(0, "SELECT");
    }
   
    void clear()
    {     
        Ddl_State.SelectedIndex = 0;
        Ddl_District.Items.Clear();
        Ddl_FuelType.SelectedIndex = 0;
        Txt_FuelDate.Text = "";
        Txt_FuelPrice.Text = "";
        Btn_Reset.Enabled = true;
        Btn_Reset.Style.Remove("opacity");
        Button_Submit1.Text = "SUBMIT <i class='fa fa-save'></i>";
    }
    protected void Button_Submit1_Click(object sender, EventArgs e)
    {
        FuelPrice fuel = new FuelPrice();
        fuel.fuelType = Ddl_FuelType.SelectedItem.Text.ToString();
        fuel.fuelDate = Txt_FuelDate.Text.ToString();
        fuel.DistrictId = Convert.ToInt32(Ddl_District.SelectedValue);
        fuel.fuelPrice = Convert.ToDecimal(Txt_FuelPrice.Text);

        bool alertMsg = (new CommFunctions()).SaveFuel(fuel);

        if (alertMsg)
        {
            (new CFunctions()).showalert("Button_Tab1Save", "SAVE", this);
            Ddl_State.SelectedIndex = 0;
            Ddl_District.Items.Clear(); 
            Ddl_FuelType.SelectedIndex = 0;
            Txt_FuelDate.Text = "";
            Txt_FuelPrice.Text = "";
        }
    }

    protected void Btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }
    protected void Ddl_State_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(Ddl_State.SelectedItem.Text!="SELECT")
        {
            Ddl_District.DataSource = (new CommFunctions()).GetDistrictOnState(Convert.ToInt32(Ddl_State.SelectedValue));
            Ddl_District.DataTextField = "District";
            Ddl_District.DataValueField = "DistrictId";
            Ddl_District.DataBind();
            Ddl_District.Items.Insert(0, "SELECT");
        }
    }

    protected void GV_FuelPrice_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        GV_FuelPrice.PageIndex = e.NewPageIndex;
        SearchData();
    }

    protected void GV_FuelPrice_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        SearchData(e.SortExpression);
    }

    protected void Ddl_SearchState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Ddl_SearchState.SelectedItem.Text != "SELECT")
        {
            Ddl_SearchDistrict.DataSource = (new CommFunctions()).GetDistrictOnState(Convert.ToInt32(Ddl_SearchState.SelectedValue));
            Ddl_SearchDistrict.DataTextField = "District";
            Ddl_SearchDistrict.DataValueField = "DistrictId";
            Ddl_SearchDistrict.DataBind();
            Ddl_SearchDistrict.Items.Insert(0, "SELECT");
        }
    }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        SearchData();
    }
    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }
    public void SearchData(string sortExpression = null)
    {
        String districtName = Ddl_SearchDistrict.SelectedItem.ToString() == "SELECT" ? null : Ddl_SearchDistrict.SelectedValue.ToString();
        String date = Txt_SearchFuelDate.Text.ToString() == "" ? null : Txt_SearchFuelDate.Text.ToString();

        if ((districtName != null) || (date != null))
        {

            con.Open();
            SqlDataAdapter sqlda = new SqlDataAdapter("ssp_ViewFuelPrice", con);
            sqlda.SelectCommand.Parameters.AddWithValue("@districtID", districtName);
            sqlda.SelectCommand.Parameters.AddWithValue("@fuelDate", date);
            sqlda.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlda.Fill(dtbl);
            if (sortExpression != null)
            {
                DataView dv = dtbl.AsDataView();
                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                dv.Sort = sortExpression + " " + this.SortDirection;
                GV_FuelPrice.DataSource = dv;
            }
            else
            {
                GV_FuelPrice.DataSource = dtbl;
            }
            GV_FuelPrice.DataBind();
            con.Close();
        }
    }
}