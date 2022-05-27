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
    public partial class UserProfile : System.Web.UI.Page
    {
        // DB connection string:
        private readonly string _conStr = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        private static string memberPwd;
        private static string memberID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userType"] == null || !Session["userType"].Equals("member"))
            {
                // Only members, who are currently logged in, can access this page:
                Response.Redirect("HomePage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                memberID = Session["memberID"].ToString().Trim();

                GetIssuedBooks();
                GetUserData();
            }
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            if (!AllRequiredValuesProvided())
            {
                return;
            }

            if (UpdateUserData())
            {
                Response.Write("<script>alert('Your Profile has been updated successfully.');</script>");
                ClearForm();
                GetUserData();
            }
        }

        private bool UpdateUserData()
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE member_main_tbl SET first_name=@first_name, last_name=@last_name, dob=@dob, email=@email, state=@state, city=@city, zipcode=@zipcode, full_address=@full_address, pwd=@pwd WHERE member_id=@member_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@member_id", memberID);
                cmd.Parameters.AddWithValue("@first_name", tbFName.Text.Trim());
                cmd.Parameters.AddWithValue("@last_name", tbLName.Text.Trim());

                cmd.Parameters.AddWithValue("@dob", tbDOB.Text.Trim());
                cmd.Parameters.AddWithValue("@email", tbEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@state", ddState.SelectedItem.Value);

                cmd.Parameters.AddWithValue("@city", tbCity.Text.Trim());
                cmd.Parameters.AddWithValue("@zipcode", tbZipCode.Text.Trim());
                cmd.Parameters.AddWithValue("@full_address", tbAddress.Text.Trim());

                cmd.Parameters.AddWithValue("@pwd", memberPwd);


                // Executing SQL command:
                int rowAffected = cmd.ExecuteNonQuery();

                return rowAffected == 1;

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
            finally
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
            }
        }

        private bool IsNewPwdValid()
        {
            const int minPwdLength = 4;

            string oldPwd = tbOldPwd.Text.Trim();
            string newPwd = tbNewPwd.Text.Trim();
            string newPwdConfirmation = tbNewPwdConfirmation.Text.Trim();

            if (!newPwd.Equals(newPwdConfirmation))
            {
                Response.Write("<script>alert('The new password and confirmation password have to match.');</script>");
                return false;
            }
            else if (newPwd.Length < minPwdLength)
            {
                Response.Write("<script>alert('The New Password length has to be at least " + minPwdLength.ToString() + " long.');</script>");
                return false;
            }
            else if (!oldPwd.Equals(memberPwd))
            {
                Response.Write("<script>alert('The provided Old Password is incorrect.');</script>");
                return false;
            }

            memberPwd = newPwd;

            return true;
        }

        private bool AllRequiredValuesProvided()
        {
            bool allProvided = true;

            if (ddState.SelectedIndex == 0)
            {
                Response.Write("<script>alert('Please select your state of residency.');</script>");
                allProvided = false;
            }
            else if (string.IsNullOrEmpty(tbFName.Text.Trim()) ||
            string.IsNullOrEmpty(tbLName.Text.Trim()) ||
            string.IsNullOrEmpty(tbDOB.Text.Trim()) ||
            string.IsNullOrEmpty(tbEmail.Text.Trim()) ||
            string.IsNullOrEmpty(tbCity.Text.Trim()) ||
            string.IsNullOrEmpty(tbZipCode.Text.Trim()) ||
            string.IsNullOrEmpty(tbAddress.Text.Trim()))
            {
                Response.Write("<script>alert('Please fill out all of the text boxes.');</script>");
                allProvided = false;
            }
            else if (!string.IsNullOrEmpty(tbOldPwd.Text.Trim()) ||
                !string.IsNullOrEmpty(tbNewPwd.Text.Trim()) ||
                !string.IsNullOrEmpty(tbNewPwdConfirmation.Text.Trim()))
            {
                // At least one of the text boxes is filled out.
                
                if (string.IsNullOrEmpty(tbOldPwd.Text.Trim()) ||
                string.IsNullOrEmpty(tbNewPwd.Text.Trim()) ||
                string.IsNullOrEmpty(tbNewPwdConfirmation.Text.Trim()))
                {
                    // All of the text boxes need to be filled out:
                    Response.Write("<script>alert('If you would like to change your password, please fill out all three of the text boxes.');</script>");
                    allProvided = false;
                }
                else if (!IsNewPwdValid())
                {
                    allProvided = false;
                }
            }

            return allProvided;
        }

        private void GetIssuedBooks()
        {
            if (string.IsNullOrEmpty(memberID))
            {
                return;
            }


            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT book_id AS [Book ID:], book_title AS [Title:], issued_date AS [Issued Date:], due_date AS [Due Date:] FROM book_issue_tbl WHERE member_id = '" + memberID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count >= 1)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    // The current user currently does not have books checked out:
                    return;
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "'); </script>");
            }
            finally
            {
                if (sqlCon != null && sqlCon.State == System.Data.ConnectionState.Open)
                {
                    sqlCon.Close();
                }
            }
        }

        private bool GetUserData()
        {
            if (string.IsNullOrEmpty(memberID))
            {
                return false;
            }

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM member_main_tbl WHERE member_id = '" + memberID + "';",
                    sqlCon
                );


                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count == 1)
                {
                    tbFName.Text = dt.Rows[0]["first_name"].ToString().Trim();
                    tbLName.Text = dt.Rows[0]["last_name"].ToString().Trim();
                    tbDOB.Text = dt.Rows[0]["dob"].ToString().Trim();

                    tbEmail.Text = dt.Rows[0]["email"].ToString().Trim();
                    ddState.Text = dt.Rows[0]["state"].ToString().Trim();
                    tbCity.Text = dt.Rows[0]["city"].ToString().Trim();

                    tbZipCode.Text = dt.Rows[0]["zipcode"].ToString().Trim();
                    tbAddress.Text = dt.Rows[0]["full_address"].ToString().Trim();
                    tbMemberID.Text = dt.Rows[0]["member_id"].ToString().Trim();

                    memberPwd = dt.Rows[0]["pwd"].ToString().Trim();

                    // Assigning the member's Account Status and the color which goes with it:
                    string memberAccountStatus = dt.Rows[0]["account_status"].ToString().Trim();

                    lAccountStatus.Text = memberAccountStatus;

                    if (memberAccountStatus.Equals("active"))
                    {
                        lAccountStatus.Attributes.Add("class", "badge rounded-pill btn-success");
                    }
                    else if (memberAccountStatus.Equals("pending"))
                    {
                        lAccountStatus.Attributes.Add("class", "badge rounded-pill btn-warning");
                        lAccountStatus.ForeColor = System.Drawing.Color.Black;
                    }
                    else if (memberAccountStatus.Equals("deactivated"))
                    {
                        lAccountStatus.Attributes.Add("class", "badge rounded-pill btn-danger");
                    }
                    // FINISHED: Assigning the member's Account Status and color.--------

                }
                else
                {
                    // It should never enter here:
                    Response.Write("<script> alert('Please provide a valid Member ID:'); </script>");
                }

                return dt.Rows.Count == 1;

            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "'); </script>");
                return false;
            }
            finally
            {
                if (sqlCon != null && sqlCon.State == System.Data.ConnectionState.Open)
                {
                    sqlCon.Close();
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Simply highlighting, in red, the books which are currently
            // overdue, by the current user:
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DateTime dueDate = Convert.ToDateTime(e.Row.Cells[3].Text);
                    DateTime now = DateTime.Today;

                    if (dueDate < now)
                    {
                        e.Row.BackColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "'); </script>");
            }
        }

        private void ClearForm()
        {
            tbOldPwd.Text = string.Empty;
            tbNewPwd.Text = string.Empty;
            tbNewPwdConfirmation.Text = string.Empty;
        }
    }
}