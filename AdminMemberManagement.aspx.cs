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
    public partial class AdminMemberManagement : System.Web.UI.Page
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

        protected void BtnGO_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbMemberID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Member ID.');</script>");
                ClearForm();
                return;
            }

            PopulateUserData();
        }

        protected void BtnDeleteAccount_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbMemberID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Member ID.');</script>");
                ClearForm();
                return;
            }

            if (DeleteMember(tbMemberID.Text.Trim()))
            {
                Response.Write("<script>alert('The Member has been deleted successfully.');</script>");
                ClearForm();
                GridView1.DataBind();
            }
            else
            {
                Response.Write("<script>alert('The provided Member ID does not exist.');</script>");
                string memberIDEntered = tbMemberID.Text.Trim();
                ClearForm();
                tbMemberID.Text = memberIDEntered;
            }
        }

        protected void BtnActiveStatus_Click(object sender, EventArgs e)
        {
            if (UpdateStatus("active"))
            {
                Response.Write("<script>alert('The Member account has been Activated.');</script>");
                PopulateUserData();
                GridView1.DataBind();
            }
        }

        protected void BtnPendingStatus_Click(object sender, EventArgs e)
        {
            if (UpdateStatus("pending"))
            {
                Response.Write("<script>alert('The Member account has been marked as Pending.');</script>");
                PopulateUserData();
                GridView1.DataBind();
            }
        }

        protected void BtnDeactivetedStatus_Click(object sender, EventArgs e)
        {
            if (UpdateStatus("deactivated"))
            {
                Response.Write("<script>alert('The Member account has been Deactivated.');</script>");
                PopulateUserData();
                GridView1.DataBind();
            }
        }

        private void PopulateUserData()
        {
            // Capturing the user's data :

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT member_id, first_name, last_name, dob, email, state, city, zipcode, full_address, account_status FROM member_main_tbl WHERE member_id = '" + tbMemberID.Text.Trim() + "';",
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
                        tbMemberID.Text = dataRow.ItemArray[0].ToString();

                        tbFName.Text = dataRow.ItemArray[1].ToString();
                        tbLName.Text = dataRow.ItemArray[2].ToString();

                        tbDOB.Text = dataRow.ItemArray[3].ToString();
                        tbEmail.Text = dataRow.ItemArray[4].ToString();

                        tbState.Text = dataRow.ItemArray[5].ToString();
                        tbCity.Text = dataRow.ItemArray[6].ToString();
                        tbZipCode.Text = dataRow.ItemArray[7].ToString();

                        tbFullAddress.Text = dataRow.ItemArray[8].ToString();

                        tbMemberStatus.Text = dataRow.ItemArray[9].ToString();

                        break;
                    }
                }
                else
                {
                    Response.Write("<script>alert('The provided Member ID does not exist.');</script>");
                    string memberIDEntered = tbMemberID.Text.Trim();
                    ClearForm();
                    tbMemberID.Text = memberIDEntered;
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

        private bool UpdateStatus(string newStatus)
        {
            if (string.IsNullOrEmpty(tbMemberID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Member ID.');</script>");
                ClearForm();
                return false;
            }

            // Updating the user's account status:

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE member_main_tbl SET account_status = @account_status WHERE member_id = @member_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@member_id", tbMemberID.Text.Trim());
                cmd.Parameters.AddWithValue("@account_status", newStatus);


                // Executing SQL command:
                int rowAffected = cmd.ExecuteNonQuery();
                sqlCon.Close();

                if (rowAffected == 0)
                {
                    Response.Write("<script>alert('The provided Member ID does not exist.');</script>");
                    string memberIDEntered = tbMemberID.Text.Trim();
                    ClearForm();
                    tbMemberID.Text = memberIDEntered;
                }

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

        private bool DeleteMember(string memberID)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM member_main_tbl WHERE member_id = @member_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@member_id", memberID);


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
            tbMemberID.Text = string.Empty;
            tbMemberStatus.Text = string.Empty;

            tbFName.Text = string.Empty;
            tbLName.Text = string.Empty;

            tbDOB.Text = string.Empty;
            tbEmail.Text = string.Empty;

            tbState.Text = string.Empty;
            tbCity.Text = string.Empty;
            tbZipCode.Text = string.Empty;

            tbFullAddress.Text = string.Empty;
        }
    }
}