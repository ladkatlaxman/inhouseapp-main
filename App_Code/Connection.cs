using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for Connection
/// </summary>
/// 

namespace NameSpaceConnection
{
    public class Connection
    {
        public SqlConnection con = new SqlConnection();
        public SqlCommand cmd;
        public SqlDataReader DR;
        public SqlDataAdapter DA;
        //public DataSet Ds;
        public DataTable Dt;

        //public List<Parameters> SPParameters { get; set; }
        public ConnectionState State { get; internal set; }

        public Connection()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public void open()
        {
            try
            {
                String constr = ConfigurationManager.ConnectionStrings["InHouseConnectionString"].ConnectionString;
                con = new SqlConnection(constr);
                con.Open();
            }
            catch (Exception e)
            {

            }
        }
        public void close()
        {
            con.Close();
        }

        public int ExecuteSp(string spName, List<Parameters> paramList)
        {
            int i = 0;
            try
            {
                if (State == ConnectionState.Closed)
                {
                    open();
                }
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                foreach (var item in paramList)
                {
                    cmd.Parameters.Add(new SqlParameter(item.ParamName, item.ParamValue));
                }
                i = cmd.ExecuteNonQuery();
                //SqlConnection.ClearAllPools();
            }
            catch (Exception e)
            {
            
            }
            return i;
        }

        public IDataReader ExecuteSpIS(string spName, List<Parameters> paramList)
        {
            IDataReader reader = null;
            try
            {
                if (State == ConnectionState.Closed)
                {
                    open();
                }
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                foreach (var item in paramList)
                {
                    cmd.Parameters.Add(new SqlParameter(item.ParamName, item.ParamValue));
                }
                reader = cmd.ExecuteReader();
                //SqlConnection.ClearAllPools();
            }
            catch (Exception e)
            {

            }
            return reader;
        }

        public IDataReader ReadSp(string spName, List<Parameters> paramList)
        {
            try
            {
                if (State == ConnectionState.Closed)
                {
                    open();
                }
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                foreach (var item in paramList)
                {
                    cmd.Parameters.Add(new SqlParameter(item.ParamName, item.ParamValue));
                }
                //SqlConnection.ClearAllPools();
                DR = cmd.ExecuteReader();
            }
            catch (Exception e)
                {

            }
            return DR;
        }

        public DataSet FillDataSetSP(string spName, List<Parameters> paramList)
        {
            DataSet ds = new DataSet();
            try
            {
                if (State == ConnectionState.Closed)
                {
                    open();
                }
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                foreach (var item in paramList)
                {
                    cmd.Parameters.Add(new SqlParameter(item.ParamName, item.ParamValue));
                }
                DA = new SqlDataAdapter(cmd);
                DA.Fill(ds);
                //SqlConnection.ClearAllPools();
            }
            catch {}
            return ds;
        }

    public DataTable Fillsp(string spName, List<Parameters> paramList)
        {
            try
            {
                if (State == ConnectionState.Closed)
                {
                    open();
                }
                cmd = con.CreateCommand();
		cmd.CommandTimeout = 60;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = spName;
                foreach (var item in paramList)
                {
                    cmd.Parameters.Add(new SqlParameter(item.ParamName, item.ParamValue));
                }
                DA = new SqlDataAdapter(cmd);
                Dt = new DataTable();
                DA.Fill(Dt);
                //SqlConnection.ClearAllPools();
            }
            catch (Exception e)
            {

            }
            return Dt;
        }
    }

    public class Parameters
    {
        public Parameters(string paramName, string paramValue)
       {
            this.ParamName = paramName;
            this.ParamValue = paramValue;
        }
        public string ParamName { get; set; }
        public string ParamValue { get; set; }
    }
}