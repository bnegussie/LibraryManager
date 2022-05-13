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
    public partial class MemberSignUp : System.Web.UI.Page
    {

        private readonly string _conStr = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            tbFName.Focus();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Handling the "Sign up" button click event:

            if (CheckMemberExists())
            {
                Response.Write("<script>alert('A member with this Member ID already exists.');</script>");
            }
            else
            {
                AddNewMember();
            }
        }

        private void AddNewMember()
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO member_main_tbl (member_id, first_name, last_name, dob, email, state, city, zipcode, full_address, pwd, account_status) VALUES (@member_id, @first_name, @last_name, @dob, @email, @state, @city, @zipcode, @full_address, @pwd, @account_status)",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@member_id", tbMemberID.Text.Trim());
                cmd.Parameters.AddWithValue("@first_name", tbFName.Text.Trim());
                cmd.Parameters.AddWithValue("@last_name", tbLName.Text.Trim());

                cmd.Parameters.AddWithValue("@dob", tbDOB.Text.Trim());
                cmd.Parameters.AddWithValue("@email", tbEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@state", ddState.SelectedItem.Value);

                cmd.Parameters.AddWithValue("@city", tbCity.Text.Trim());
                cmd.Parameters.AddWithValue("@zipcode", tbZipCode.Text.Trim());
                cmd.Parameters.AddWithValue("@full_address", tbAddress.Text.Trim());

                cmd.Parameters.AddWithValue("@pwd", tbPwd.Text.Trim());
                cmd.Parameters.AddWithValue("@account_status", "pending");


                // Executing SQL command:
                cmd.ExecuteNonQuery();
                sqlCon.Close();

                Response.Redirect("Login.aspx");

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('An error occurred');</script>");
            }
        }

        private bool CheckMemberExists()
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM member_main_tbl WHERE member_id='" + tbMemberID.Text.Trim() + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                return dt.Rows.Count > 0;

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('An error occurred');</script>");

                return false;
            }
        }
    }
}