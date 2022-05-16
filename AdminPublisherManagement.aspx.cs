using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManager
{
    public partial class AdminPublisherManagement : System.Web.UI.Page
    {
        // DB connection string:
        private readonly string _conStr = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userType"] == null || !Session["userType"].Equals("admin"))
            {
                // This page requires admin credentials:
                Response.Redirect("HomePage.aspx");
                return;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbPublisherID.Text.Trim()) ||
                string.IsNullOrEmpty(tbPublisherName.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Publisher ID and name.');</script>");
                return;
            }

            // Checking if the new ID provided is already being used:
            if (IsIDUnique(tbPublisherID.Text.Trim()))
            {
                if (AddNewPublisher(tbPublisherID.Text.Trim(), tbPublisherName.Text.Trim()))
                {
                    Response.Write("<script>alert('Publisher added successfully.');</script>");
                    ClearForm();
                    GridView1.DataBind();
                }
                else
                {
                    Response.Write("<script>alert('Something went wrong.');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('This ID is already being used.');</script>");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbPublisherID.Text.Trim()) ||
                string.IsNullOrEmpty(tbPublisherName.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Publisher ID and name.');</script>");
                return;
            }

            if (UpdatePublisherName(tbPublisherID.Text.Trim(), tbPublisherName.Text.Trim()))
            {
                Response.Write("<script>alert('Update completed successfully.');</script>");
                ClearForm();
                GridView1.DataBind();
            }
            else
            {
                Response.Write("<script>alert('The provided Publisher ID does not exist.');</script>");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbPublisherID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Publisher ID.');</script>");
                return;
            }

            if (DeletePublisher(tbPublisherID.Text.Trim()))
            {
                Response.Write("<script>alert('Publisher deleted successfully.');</script>");
                ClearForm();
                GridView1.DataBind();
            }
            else
            {
                Response.Write("<script>alert('The provided Publisher ID does not exist.');</script>");
            }
        }

        protected void btnGO_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbPublisherID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Publisher ID.');</script>");
                return;
            }

            // Capturing the specified author:

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT publisher_name FROM publisher_main_tbl WHERE publisher_id = '" + tbPublisherID.Text.Trim() + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                if (dt.Rows.Count == 1)
                {
                    foreach (DataRow dataRow in dt.Rows)
                    {
                        tbPublisherName.Text = dataRow.ItemArray[0].ToString();
                        break;
                    }
                }
                else
                {
                    Response.Write("<script>alert('The provided Publisher ID does not exist.');</script>");
                    tbPublisherName.Text = string.Empty;
                }

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        private bool IsIDUnique(string publisherID)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);

            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT publisher_id FROM publisher_main_tbl WHERE publisher_id = '" + publisherID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                return dt.Rows.Count == 0;

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        private bool AddNewPublisher(String publisherID, string publisherName)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO publisher_main_tbl (publisher_id, publisher_name) VALUES (@publisher_id, @publisher_name);",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@publisher_id", publisherID);
                cmd.Parameters.AddWithValue("@publisher_name", publisherName);


                // Executing SQL command:
                int rowAffected = cmd.ExecuteNonQuery();
                sqlCon.Close();

                return rowAffected == 1;

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        private bool UpdatePublisherName(String publisherID, string newPublisherName)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE publisher_main_tbl SET publisher_name = @publisher_name WHERE publisher_id = @publisher_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@publisher_id", publisherID);
                cmd.Parameters.AddWithValue("@publisher_name", newPublisherName);


                // Executing SQL command:
                int rowAffected = cmd.ExecuteNonQuery();
                sqlCon.Close();

                return rowAffected == 1;

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        private bool DeletePublisher(String publisherID)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM publisher_main_tbl WHERE publisher_id = @publisher_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@publisher_id", publisherID);


                // Executing SQL command:
                int rowAffected = cmd.ExecuteNonQuery();
                sqlCon.Close();

                return rowAffected == 1;

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        private void ClearForm()
        {
            tbPublisherID.Text = string.Empty;
            tbPublisherName.Text = string.Empty;
        }
    }
}