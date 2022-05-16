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
    public partial class AdminAuthorManagement : System.Web.UI.Page
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
            if (string.IsNullOrEmpty(tbAuthorID.Text.Trim()) ||
                string.IsNullOrEmpty(tbAuthorName.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Author ID and name.');</script>");
                return;
            }

            // Checking if the new ID provided is already being used:
            if (IsIDUnique(tbAuthorID.Text.Trim()))
            {
                if (AddNewAuthor(tbAuthorID.Text.Trim(), tbAuthorName.Text.Trim()))
                {
                    Response.Write("<script>alert('Author added successfully.');</script>");
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
            if (string.IsNullOrEmpty(tbAuthorID.Text.Trim()) || 
                string.IsNullOrEmpty(tbAuthorName.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Author ID and name.');</script>");
                return;
            }

            if (UpdateAuthorName(tbAuthorID.Text.Trim(), tbAuthorName.Text.Trim()))
            {
                Response.Write("<script>alert('Update completed successfully.');</script>");
                ClearForm();
                GridView1.DataBind();
            }
            else
            {
                Response.Write("<script>alert('The provided Author ID does not exist.');</script>");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbAuthorID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Author ID.');</script>");
                return;
            }

            if (DeleteAuthor(tbAuthorID.Text.Trim()))
            {
                Response.Write("<script>alert('Author deleted successfully.');</script>");
                ClearForm();
                GridView1.DataBind();
            }
            else
            {
                Response.Write("<script>alert('The provided Author ID does not exist.');</script>");
            }
        }

        protected void btnGO_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbAuthorID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Author ID.');</script>");
                return;
            }

            // Capturing the specified author:

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT author_full_name FROM author_main_tbl WHERE author_id = '" + tbAuthorID.Text.Trim() + "';",
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
                        tbAuthorName.Text = dataRow.ItemArray[0].ToString();
                        break;
                    }
                }
                else
                {
                    Response.Write("<script>alert('The provided Author ID does not exist.');</script>");
                    tbAuthorName.Text = string.Empty;
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

        private bool DeleteAuthor(String authorID)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM author_main_tbl WHERE author_id = @author_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@author_id", authorID);


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

        private bool UpdateAuthorName(String authorID, string newAuthorName)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE author_main_tbl SET author_full_name = @author_full_name WHERE author_id = @author_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@author_id", authorID);
                cmd.Parameters.AddWithValue("@author_full_name", newAuthorName);


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

        private bool AddNewAuthor(String authorID, string authorName)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO author_main_tbl (author_id, author_full_name) VALUES (@author_id, @author_full_name);",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@author_id", authorID);
                cmd.Parameters.AddWithValue("@author_full_name", authorName);


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

        private bool IsIDUnique(string authorID)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);

            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT author_id FROM author_main_tbl WHERE author_id='" + authorID + "';",
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

        private void ClearForm()
        {
            tbAuthorID.Text = string.Empty;
            tbAuthorName.Text = string.Empty;
        }
    }
}