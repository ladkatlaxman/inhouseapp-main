using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using BLFunctions; 

public partial class WayBillImport : System.Web.UI.Page
{
    List<paramField> listFields;
    Dictionary<string, bool> dictFields;
    int intSystemUpload = 0;
    protected void Page_Load(object sender, EventArgs e) 
    { 
        string FolderPath = ConfigurationManager.AppSettings["FolderPath"]; 
        string FileName = Path.GetFileName("BookingRegister.csv"); 
        string FilePath = Server.MapPath(FolderPath + FileName);
        //FilePath = @"D:\httpdocs\files\BookingRegister.csv";

        List<WayBillDetails> wayBillDetails; 
        IDataReader drCsvFile =  (new BLFunctions.CommFunctions()).ReadCSV(FilePath, out wayBillDetails);
        List<WayBillDetails> wayBills = new List<WayBillDetails>();
        //IDataReader drCsvFileCopy = new drCsvFile(); 

        gvFirstGrid.DataSource = drCsvFile; // wayBills; 
        gvFirstGrid.DataBind(); 

        listFields = new List<paramField>(); 
        dictFields = new Dictionary<string, bool>();
    }

    protected void Page_Unload(object sender, EventArgs e)
    {
    }

    protected void Page_LoadOld(object sender, EventArgs e)
    {
        string conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;

        string FolderPath = ConfigurationManager.AppSettings["FolderPath"];
        //string FileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
        string FileName = Path.GetFileName("BookingReport.xlsx"); 
        string FilePath = Server.MapPath(FolderPath + FileName);

        conStr = String.Format(conStr, FilePath, "Yes");
        OleDbConnection connExcel = new OleDbConnection(conStr);
        OleDbCommand cmdExcel = new OleDbCommand();
        OleDbDataAdapter oda = new OleDbDataAdapter();
        DataTable dt = new DataTable();
        cmdExcel.Connection = connExcel;

        //Get the name of First Sheet
        connExcel.Open();
        DataTable dtExcelSchema;
        dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
        string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
        connExcel.Close();

        //Read Data from First Sheet
        connExcel.Open();
        cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
        oda.SelectCommand = cmdExcel;
        oda.Fill(dt);
        connExcel.Close();
        
        gvFirstGrid.DataSource = dt;
        gvFirstGrid.DataBind();
    }
    protected void Btn_Search_Click(object sender, EventArgs e)
    {

    }
    protected void gvFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //e.Row.Cells[e.Row.Cells.Count - 1].Text = false.ToString();
        //Check for Each column for which the 
        foreach (DataGridColumn dgCol in gvFirstGrid.Columns)
        {
            //Take the First Row which has column Names 
            if (dgCol.HeaderText.Replace(" ", "").ToLower() == "waybillno")
            {
                //Check if Waybill number is already available. 
                dictFields["wayBillNo"] = true; 
            } 
            if (dgCol.HeaderText.Replace(" ", "").ToLower() == "consignername" |
                dgCol.HeaderText.Replace(" ", "").ToLower() == "consignorname" |
                dgCol.HeaderText.Replace(" ", "").ToLower() == "customername")
            {
                //Check the Database for Customer Name and Get Customer Id 
                dictFields["customerName"] = true;
            }

        }
    }
    protected void GV_ExportFirstGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    class paramField 
    { 
        public paramField(string fieldValue, bool isAvailable) 
        {
            FieldValue = fieldValue; 
            IsAvailable = isAvailable; 
        } 
        public string FieldValue { get; set; } 
        public bool IsAvailable { get; set; } 
    } 
    
    private void addAllFieldNames()
    { 
        listFields.Add(new paramField("wayBillNo", false));
        listFields.Add(new paramField("branchId", false));
        listFields.Add(new paramField("customerId", false));
        listFields.Add(new paramField("customerType", false));
        listFields.Add(new paramField("contactNo", false));
        listFields.Add(new paramField("emailId", false));
        listFields.Add(new paramField("customerAddress", false));
        listFields.Add(new paramField("telephoneNo", false));
        listFields.Add(new paramField("customerLocId", false));
        listFields.Add(new paramField("customerAreaId", false));
        listFields.Add(new paramField("paymentMode", false));
        listFields.Add(new paramField("PickUpLocId", false));
        listFields.Add(new paramField("pickUpAreaId", false));
        listFields.Add(new paramField("pickupType", false));
        listFields.Add(new paramField("pickupAddress", false));
        listFields.Add(new paramField("walkinCustId", false));
        listFields.Add(new paramField("consigneeId", false));
        listFields.Add(new paramField("consigneeContactNo", false));
        listFields.Add(new paramField("deliveryLocId", false));
        listFields.Add(new paramField("deliveryAreaId", false));
        listFields.Add(new paramField("consigneeAddress", false));
        listFields.Add(new paramField("pickUpBranchId", false));
        listFields.Add(new paramField("userId", false));
        listFields.Add(new paramField("creationDateTime", false));
    
        dictFields.Add("wayBillNo", false);
        dictFields.Add("branchId", false);
        dictFields.Add("customerId", false);
        dictFields.Add("customerType", false);
        dictFields.Add("contactNo", false);
        dictFields.Add("emailId", false);
        dictFields.Add("customerAddress", false);
        dictFields.Add("telephoneNo", false);
        dictFields.Add("customerLocId", false);
        dictFields.Add("emailId", false);
        dictFields.Add("customerAreaId", false);

    }

    /*  List of Fields 
    @wayBillNo varchar(50), yes 
    @PickUpId INT = NULL,  NA 
    @branchId int = null ,  Yes 
    @customerID int = null,  
    @customerType varchar(20) = null, 
    @contactNo varchar(20) = null, 
    @emailID varchar(20) = null, 
    @customerAddress varchar(255) = null, 
    @telephoneNo VARCHAR(30) = null ,
    @customerLocID int = null, 
    @customerAreaID int = null, 
    @paymentMode varchar(30),   
    @pickUPLocId int,           	
    @pickupAreaId int = null,              
    @pickupType varchar(20) = null, 
    @pickupAddress varchar(255) = null, 
    @walkinCustId int = null, 
    @consigneeID int = null,           
    @consigneeContactNo varchar(20) = null, 
    @deliveryLocID int, 
    @deliveryAreaID int = null,   
    @consigneeAddress varchar(400) = null, 
    @pickupBranchID int = null, 
    @IP_Address VARCHAR(40) = null, 
    @distance decimal(10, 2) = null,   
    @mapDistance decimal(10, 2) = null,    
    @TotalPrice float = null,          
    @userId int, 
    @createdDateTime varchar(30), */

}