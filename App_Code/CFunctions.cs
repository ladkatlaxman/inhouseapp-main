using System;
using NameSpaceConnection;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Text;

/// <summary>
/// Summary description for Functions
/// </summary>
public class CFunctions
{
    Connection con = new Connection();
    static CFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
        form = 0;
        ID = 0;
        tab = 0;
        tabstatus = 0;
        blackdata = "";
        //temp variable
        javascript = "";
    }
    public static int ID { get; set; }
    public static int form { get; set; }
    public static int tab { get; set; }
    public static int tabstatus { get; set; }
    public static string blackdata { get; set; }

    public static void setID(int newID)
    { ID = newID; }
    //start temp
    public static string javascript { get; set; }
    public static void setjavascript(string newjavascript)
    { javascript = newjavascript; }
    //end temp
    public static void setform(int newform)
    { form = newform; }
    public static void setTab(int newtab)
    { tab = newtab; }
    public static void setTabStatus(int newstatus)
    { tabstatus = newstatus; }
    public static void setblackdata(string newblankData)
    { blackdata = newblankData; }


    public void GetJavascriptFunction(Page page, string text, string textid, string path, string data, string last)
    {
        CFunctions.setjavascript(CFunctions.javascript + "$(\"[id$='" + text + "']\").autocomplete({" + "\n" +
                                                         "source: function(request, response) {" + "\n" +
                                                         "console.log(request.term.length);" + "\n" +
                                                         "$.ajax({" + "\n" +
                                                         "url: '" + page.ResolveUrl(path) + "'," + "\n" +
                                                         "data: \"{ 'searchPrefixText': '\" + request.term + \"','data':'" + data + "'}\"," + "\n" +
                                                         "dataType: \"json\"," + "\n" +
                                                         "type: \"POST\"," + "\n" +
                                                         "contentType: \"application/json; charset=utf-8\"," + "\n" +
                                                         "success: function(data) {" + "\n" +
                                                                                    "response($.map(data.d, function(item) {" + "\n" +
                                                                                     "return {" + "\n" +
                                                                                                "label: item.split('ʭ')[0]," + "\n" +
                                                                                                "val: item.split('ʭ')[1]" + "\n" +
                                                                                            "}" + "\n" +
                                                                                        "}))" + "\n" +
                                                         "}," + "\n" +
                                                         "error: function(response) {" + "\n" +
                                                                                    "alert(response.responseText);" + "\n" +
                                                          "}," + "\n" +
                                                         "failure: function(response) {" + "\n" +
                                                                                        "alert(response.responseText);" + "\n" +
                                                                                     "}" + "\n" +
                                                         "});" + "\n" +
                                                         "}," + "\n" +
                                                         "select: function(e, i) {" + "\n" +
                                                         "$(\"[id$='" + textid + "']\").val(i.item.val);" +
                                                         "}," + "\n" +
                                                         "minLength: 3" + "\n" +
                                                         last + "\n");
    }
    public void GetJavascriptTwoParameter(Page page, string text1, string textid1, string text2, string textid2, string path, string data, string last)
    {
        CFunctions.setjavascript(CFunctions.javascript + "$(\"[id$='" + text1 + "']\").autocomplete({" + "\n" +
                                                         "source: function(request, response) {" + "\n" +
                                                         "console.log(request.term.length);" + "\n" +
                                                         "$.ajax({" + "\n" +
                                                         "url: '" + page.ResolveUrl(path) + "'," + "\n" +
                                                         "data: \"{ 'searchPrefixText': '\" + request.term + \"','data':'" + data + "','data2':'\" + $(\"[id*='" + text2 + "']\").val() + \"'}\"," + "\n" +
                                                         "dataType: \"json\"," + "\n" +
                                                         "type: \"POST\"," + "\n" +
                                                         "contentType: \"application/json; charset=utf-8\"," + "\n" +
                                                         "success: function(data) {" + "\n" +
                                                                                    "response($.map(data.d, function(item) {" + "\n" +
                                                                                     "return {" + "\n" +
                                                                                                "label: item.split('ʭ')[0]," + "\n" +
                                                                                                "val: item.split('ʭ')[1]" + "\n" +
                                                                                            "}" + "\n" +
                                                                                        "}))" + "\n" +
                                                         "}," + "\n" +
                                                         "error: function(response) {" + "\n" +
                                                                                    "alert(response.responseText);" + "\n" +
                                                          "}," + "\n" +
                                                         "failure: function(response) {" + "\n" +
                                                                                        "alert(response.responseText);" + "\n" +
                                                                                     "}" + "\n" +
                                                         "});" + "\n" +
                                                         "}," + "\n" +
                                                         "select: function(e, i) {" + "\n" +
                                                         "$(\"[id$='" + textid1 + "']\").val(i.item.val);" +
                                                         "}," + "\n" +
                                                         "minLength: 3" + "\n" +
                                                         last + "\n");
    }
    /*----------------------Call JavaScript Function*/
    public void GetJavascript(string javascript, Page Currentpage)
    {
        StringBuilder sb = new StringBuilder();
        //sb.Append(@"<script language='javascript'>");
        sb.Append(javascript);
        //sb.Append(@"</script>");
        ScriptManager.RegisterStartupScript(Currentpage, Currentpage.GetType(), "JCall1", sb.ToString(), true);
    }


    /*-----------------------Show Alert Massage--------------------*/
    public void showalert(string id, string data, Page Currentpage)
    {
        string a = id;
        string b = data;
        ScriptManager.RegisterStartupScript(Currentpage, Currentpage.GetType(), "Messagebox", "newFunction('" + a + "','" + b + "');", true);
    }
   /*-----------------------Show Alert Massage--------------------*/
    public void showalert1(string id, string data,string currentbranch, Page Currentpage)
    {
        string a = id;
        string b = data;
        string c = currentbranch;
        ScriptManager.RegisterStartupScript(Currentpage, Currentpage.GetType(), "Messagebox", "newFunction1('" + a + "','" + b + "','" + c + "');", true);
    }
    /*----------------------CurrentDateTime----------------------------*/
    public string CurrentDateTime()
    {
        TimeZoneInfo tmz;
        DateTimeOffset dt;
        tmz = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
        DateTimeOffset local = DateTimeOffset.Now;
        dt = TimeZoneInfo.ConvertTime(local, tmz);
        string Day = dt.ToString("dd");
        string Month = dt.ToString("MM");
        string Year = dt.ToString("yyyy");

        string Hour = dt.ToString("HH");
        string Minute = dt.ToString("mm");
        string Seconds = dt.ToString("ss");
        return Day + "/" + Month + "/" + Year + " " + Hour + ":" + Minute + ":" + Seconds;
    }
    /*----------------------CurrentDateTime----------------------------*/
    public string CurrentDate()
    {
        TimeZoneInfo tmz;
        DateTimeOffset dt;
        tmz = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
        DateTimeOffset local = DateTimeOffset.Now;
        dt = TimeZoneInfo.ConvertTime(local, tmz);
        string Day = dt.Day.ToString();
        string Month = dt.ToString("MM");
        string Year = dt.ToString("yyyy");
        return Day + "/" + Month + "/" + Year;
    }
    /*----------------------Button opacity Hide/Show---------------------*/
    public void ButtonopacityHideShow(int i, string value, LinkButton btn)
    {
        if (i == 0)
        {
            btn.Enabled = false;
            if (value == "SAVE")
            {
                btn.Text = "SAVE <i class='fa fa-save'></i>";
            }
            else if (value == "SUBMIT")
            {
                btn.Text = "SUBMIT <i class='fa fa-save'></i>";
            }
            else if (value == "UPDATE")
            {
                btn.Text = "UPDATE <i class='fa fa-save'></i>";
            }
            else if (value == "NEXT")
            {
                btn.Text = "NEXT <i class='fa fa-arrow-circle-right'></i>";
            }
            else if (value == "RESET")
            {
                btn.Text = "RESET <i class='fa fa-refresh'></i>";
            }
            else if (value == "PRINT")
            {
                btn.Text = "PRINT <i class='fa fa-print'></i>";
            }
            btn.CssClass = "btn btn-info largeButtonStyle";
            btn.Style.Add("opacity", ".3");
        }
        else if (i == 1)
        {
            btn.Enabled = true;
            if (value == "SAVE")
            {
                btn.Text = "SAVE <i class='fa fa-save'></i>";
            }
            else if (value == "SUBMIT")
            {
                btn.Text = "SUBMIT <i class='fa fa-save'></i>";
            }
            else if (value == "UPDATE")
            {
                btn.Text = "UPDATE <i class='fa fa-save'></i>";
            }
            else if (value == "NEXT")
            {
                btn.Text = "NEXT <i class='fa fa-arrow-circle-right'></i>";
            }
            else if (value == "RESET")
            {
                btn.Text = "RESET <i class='fa fa-refresh'></i>";
            }
            else if (value == "PRINT")
            {
                btn.Text = "PRINT <i class='fa fa-print'></i>";
            }
            if (value == "NEXT")
            {
                btn.CssClass = "btn btn-info next-step largeButtonStyle";
            }
            else
            {
                btn.CssClass = "btn btn-info largeButtonStyle";
            }
            btn.Style.Remove("opacity");
        }
    }


    /*----------------------Get DropDownList----------------------------*/

    //Dropdownlist in 0 position
    public void SelectDropdownList(TextBox searchabletext, TextBox text, RadioButtonList rdbl)
    {
        searchabletext.Text = "";
        text.Text = "SELECT";
        rdbl.SelectedIndex = 0;
    }
    //Clear DropDownList Code
    public void clearDropdownList(TextBox searchabletext, TextBox text, RadioButtonList rdbl)
    {
        searchabletext.Text = "";
        text.Text = "SELECT";
        rdbl.Items.Clear();
        rdbl.Items.Insert(0, "SELECT");
        rdbl.SelectedIndex = 0;

    }
    //DropDownList SelectedIndexChanged Code
    public void DataList_SelectedIndexChanging(RadioButtonList rdbl, TextBox txt)
    {
        if (rdbl != null)
        {
            for (int i = 0; i < rdbl.Items.Count; i++)
            {
                if (rdbl.Items[i].Selected)
                {
                    txt.Text = rdbl.Items[i].Text;
                    break;
                }
            }
        }
    }

    //Select Radiobutton list value using textbox value
    public void SelectDataUsingTextbox(RadioButtonList rdbl, TextBox text)
    {
        for (int i = 0; i < rdbl.Items.Count; i++)
        {
            if (rdbl.Items[i].ToString() == text.Text.ToString())
            {
                rdbl.Items[i].Selected = true;
                break;
            }
        }
    }

    //BindData in DropDown
    public void dropdwnlist(string upperCase = null, RadioButtonList rdbl = null, DropDownList ddl = null, TextBox txt = null, string dataText = null, string dataValue = null, object fun = null)
    {
        if (rdbl != null)
        {
            rdbl.DataTextField = dataText;
            rdbl.DataValueField = dataValue;
            rdbl.DataSource = fun;
            rdbl.DataBind();
            foreach (ListItem item in rdbl.Items)
            {
                if (item.Text == "SELECT")
                {
                    break;
                }
                else
                {
                    rdbl.Items.Insert(0, "SELECT");
                    break;
                }
            }
            if (rdbl.Items.Count == 0)
            {
                txt.Text = "SELECT";
                rdbl.Items.Insert(0, "SELECT");
            }

            if (upperCase != null)
            {
                foreach (ListItem t in rdbl.Items)
                {
                    t.Text = t.Text.ToUpper();
                }
            }
            if (txt.Text == "SELECT")
            {
                rdbl.SelectedIndex = 0;
            }
            else
            {
                SelectDataUsingTextbox(rdbl, txt);
            }
        }
        else if (ddl != null)
        {
            ddl.DataValueField = dataValue;
            ddl.DataTextField = dataText;
            ddl.DataSource = fun;
            ddl.DataBind();
            ddl.Items.Insert(0, "SELECT");
        }
    }


    //Search Data
    public void SearchData(GridView GV1, GridView GV2, string SPName, string parametername1, object eventname1, string parametername2, object eventname2, string parametername3, object eventname3, string parametername4, object eventname4, string parametername5, object eventname5, string parametername6, object eventname6)
    {
        if (con.State == ConnectionState.Closed)
        {
            con.open();
        }
        con.cmd = new SqlCommand(SPName, con.con);
        con.cmd.CommandType = CommandType.StoredProcedure;
        if (parametername1 != "" && eventname1 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername1, eventname1);
        }
        if (parametername2 != "" && eventname2 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername2, eventname2);
        }
        if (parametername3 != "" && eventname3 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername3, eventname3);
        }
        if (parametername4 != "" && eventname4 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername4, eventname4);
        }
        if (parametername5 != "" && eventname5 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername5, eventname5);
        }
        if (parametername6 != "" && eventname6 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername6, eventname6);
        }
        con.DA = new SqlDataAdapter(con.cmd);
        con.Dt = new DataTable();
        con.DA.Fill(con.Dt);
        GV1.DataSource = con.Dt;
        GV1.DataBind();
        GV2.DataSource = con.Dt;
        GV2.DataBind();
    }

    //Delete Data
    public void DeleteData(string SPName, string parametername1, object eventname1, string parametername2, object eventname2)
    {
        if (con.State == ConnectionState.Closed)
        {
            con.open();
        }
        con.cmd = new SqlCommand(SPName, con.con);
        con.cmd.CommandType = CommandType.StoredProcedure;
        if (parametername1 != "" && eventname1 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername1, eventname1);
        }
        if (parametername2 != "" && eventname2 != null)
        {
            con.cmd.Parameters.AddWithValue(parametername2, eventname2);
        }
        con.cmd.ExecuteNonQuery();
    }
}