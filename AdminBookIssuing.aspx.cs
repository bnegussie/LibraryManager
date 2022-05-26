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
    public partial class AdminBookIssuing : System.Web.UI.Page
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
            // Input validation:
            if (!AllRequiredValuesProvided())
            {
                return;
            }

            if (GetNames(tbMemberID.Text.Trim(), tbBookID.Text.Trim()))
            {
                DateTime now = DateTime.Now;
                tbStartDate.Text = now.ToString("yyyy-MM-dd");
                tbEndDate.Text = now.AddDays(30).ToString("yyyy-MM-dd");
            }
            else
            {
                ClearForm();
            }
        }

        protected void BtnIssue_Click(object sender, EventArgs e)
        {
            // Input validation:
            if (!AllRequiredValuesProvided())
            {
                return;
            }

            string memberID = tbMemberID.Text.Trim();
            string bookID = tbBookID.Text.Trim();

            if (!IsValidMemberID(memberID))
            {
                return;
            }

            int currCopiesAvailable = NumOfBookCopiesAvailable(bookID);

            if (currCopiesAvailable < 1)
            {
                if (currCopiesAvailable == -1)
                {
                    return;
                }
                
                Response.Write("<script>alert('There are not anymore currently available copies at the moment.');</script>");
                ClearForm();
                return;
            }
            else if (!IsUniqueBookIssuing(memberID, bookID))
            {
                return;
            }
            // FINISHED: Input validation:-------------------------------------



            if (IssueBook(memberID, bookID))
            {
                Response.Write("<script> alert('Book issued successfully.'); </script>");
                ClearForm();
                tbMemberID.Text = string.Empty;
                tbBookID.Text = string.Empty;
                GridView1.DataBind();
            }
        }

        protected void BtnReturn_Click(object sender, EventArgs e)
        {
            // Input validation:
            if (!AllRequiredValuesProvided())
            {
                return;
            }

            string memberID = tbMemberID.Text.Trim();
            string bookID = tbBookID.Text.Trim();

            if (DoesMemberHaveThisBookCurrentlyIssued(memberID, bookID))
            {
                if (ReturnBook(memberID, bookID))
                {
                    Response.Write("<script> alert('Book returned successfully.'); </script>");
                    ClearForm();
                    tbMemberID.Text = string.Empty;
                    tbBookID.Text = string.Empty;
                    GridView1.DataBind();
                }
                else
                {
                    Response.Write("<script> alert('Something went wrong.'); </script>");
                }
            }
            else
            {
                Response.Write("<script> alert('Invalid Member ID or Book ID.'); </script>");
                ClearForm();
            }
        }

        private bool AllRequiredValuesProvided()
        {
            bool allProvided = true;

            if (string.IsNullOrEmpty(tbMemberID.Text.Trim()))
            {
                Response.Write("<script>alert('Please proivide a valid Member ID.');</script>");
                ClearForm();
                allProvided = false;
            }
            else if (string.IsNullOrEmpty(tbBookID.Text.Trim()))
            {
                Response.Write("<script>alert('Please proivide a valid Book ID.');</script>");
                ClearForm();
                allProvided = false;
            }
            return allProvided;
        }

        private bool GetNames(string memberID, string bookID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand memberCmd = new SqlCommand(
                    "SELECT first_name, last_name FROM member_main_tbl WHERE member_id = '" + memberID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(memberCmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count == 1)
                {
                    tbMemberName.Text = dt.Rows[0]["first_name"].ToString().Trim() + " " + dt.Rows[0]["last_name"].ToString().Trim();
                }
                else
                {
                    Response.Write("<script>alert('The provided Member ID does not exist.');</script>");
                    return false;
                }



                SqlCommand bookCmd = new SqlCommand(
                    "SELECT title FROM book_main_tbl WHERE book_id = '" + bookID + "';",
                    sqlCon
                );

                SqlDataAdapter adapter = new SqlDataAdapter(bookCmd);
                DataTable dTable = new DataTable();
                adapter.Fill(dTable);

                if (dTable.Rows.Count == 1)
                {
                    tbBookName.Text = dTable.Rows[0]["title"].ToString().Trim();
                }
                else
                {
                    Response.Write("<script>alert('The provided Book ID does not exist.');</script>");
                    return false;
                }

                return true;

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

        private int NumOfBookCopiesAvailable(string bookID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT current_in_stock FROM book_main_tbl WHERE book_id = '" + bookID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count != 1)
                {
                    Response.Write("<script>alert('Please proivide a valid Book ID.');</script>");
                    ClearForm();
                    return -1;
                }
                
                return int.Parse(dt.Rows[0]["current_in_stock"].ToString().Trim());

            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('" + ex.Message + "'); </script>");
                return -1;
            }
            finally
            {
                if (sqlCon != null && sqlCon.State == System.Data.ConnectionState.Open)
                {
                    sqlCon.Close();
                }
            }
        }

        private bool IsValidMemberID(string memberID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT first_name FROM member_main_tbl WHERE member_id = '" + memberID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count != 1)
                {
                    Response.Write("<script>alert('Please proivide a valid Member ID.');</script>");
                    ClearForm();
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

        /// <summary>
        /// Making sure that the same user (a.k.a member) is not allowed to check
        /// out more than one copy of a book at any given time.
        /// </summary>
        /// <returns>
        /// True if this user does not currently have a copy
        /// of this book already checkout.
        /// </returns>
        private bool IsUniqueBookIssuing(string memberID, string bookID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT book_issue_id FROM book_issue_tbl WHERE book_id = @book_id AND member_id = @member_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@book_id", bookID);
                cmd.Parameters.AddWithValue("@member_id", memberID);

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    Response.Write("<script> alert('This member already a copy of this book checked out.'); </script>");
                }

                return dt.Rows.Count == 0;

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

        private bool IssueBook(string memberID, string bookID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                string title, fName, lName;
                int currInStock;

                sqlCon.Open();

                SqlCommand memberCmd = new SqlCommand(
                    "SELECT first_name, last_name FROM member_main_tbl WHERE member_id = '" + memberID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(memberCmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                if (dt.Rows.Count == 1)
                {
                    fName = dt.Rows[0]["first_name"].ToString().Trim();
                    lName = dt.Rows[0]["last_name"].ToString().Trim();
                }
                else
                {
                    Response.Write("<script>alert('The provided Member ID does not exist.');</script>");
                    return false;
                }



                SqlCommand bookCmd = new SqlCommand(
                    "SELECT title, current_in_stock FROM book_main_tbl WHERE book_id = '" + bookID + "';",
                    sqlCon
                );

                SqlDataAdapter adapter = new SqlDataAdapter(bookCmd);
                DataTable dTable = new DataTable();
                adapter.Fill(dTable);

                
                if (dTable.Rows.Count == 1)
                {
                    title = dTable.Rows[0]["title"].ToString().Trim();
                    currInStock = int.Parse(dTable.Rows[0]["current_in_stock"].ToString().Trim());
                }
                else
                {
                    Response.Write("<script>alert('The provided Book ID does not exist.');</script>");
                    return false;
                }
                // Now we have all the data we need and we just need to place a new
                // entry into the table and return.



                // Reducing the currently available count:
                SqlCommand currInStockCmd = new SqlCommand(
                    "UPDATE book_main_tbl SET current_in_stock = @current_in_stock WHERE book_id = @book_id;",
                    sqlCon
                );

                currInStockCmd.Parameters.AddWithValue("@book_id", bookID);
                currInStockCmd.Parameters.AddWithValue("@current_in_stock", (currInStock - 1));

                // Executing SQL command:
                int rowAffected = currInStockCmd.ExecuteNonQuery();

                if (rowAffected != 1)
                {
                    Response.Write("<script> alert('Something went wrong.'); </script>");
                    return false;
                }



                SqlCommand issueBookCmd = new SqlCommand(
                    "INSERT INTO book_issue_tbl (book_id, book_title, member_id, member_first_name, member_last_name, issued_date, due_date) VALUES (@book_id, @book_title, @member_id, @member_first_name, @member_last_name, @issued_date, @due_date);",
                    sqlCon
                );

                issueBookCmd.Parameters.AddWithValue("@book_id", bookID);
                issueBookCmd.Parameters.AddWithValue("@book_title", title);
                issueBookCmd.Parameters.AddWithValue("@member_id", memberID);

                issueBookCmd.Parameters.AddWithValue("@member_first_name", fName);
                issueBookCmd.Parameters.AddWithValue("@member_last_name", lName);

                DateTime now = DateTime.Now;
                issueBookCmd.Parameters.AddWithValue("@issued_date", now.ToString("yyyy-MM-dd"));
                issueBookCmd.Parameters.AddWithValue("@due_date", now.AddDays(30).ToString("yyyy-MM-dd"));


                // Executing SQL command:
                rowAffected = issueBookCmd.ExecuteNonQuery();

                return rowAffected == 1;

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

        private bool DoesMemberHaveThisBookCurrentlyIssued(string memberID, string bookID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT book_issue_id FROM book_issue_tbl WHERE book_id = @book_id AND member_id = @member_id;",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@book_id", bookID);
                cmd.Parameters.AddWithValue("@member_id", memberID);

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

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

        private bool ReturnBook(string memberID, string bookID)
        {
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                // Removing book issuing entry:
                SqlCommand returnBookCmd = new SqlCommand(
                    "DELETE FROM book_issue_tbl WHERE book_id = @book_id AND member_id = @member_id;",
                    sqlCon
                );

                returnBookCmd.Parameters.AddWithValue("@book_id", bookID);
                returnBookCmd.Parameters.AddWithValue("@member_id", memberID);

                int rowAffected = returnBookCmd.ExecuteNonQuery();

                if (rowAffected != 1)
                {
                    Response.Write("<script> alert('Something went wrong.'); </script>");
                    return false;
                }


                int currCopiesAvailable = NumOfBookCopiesAvailable(bookID);
                if (currCopiesAvailable == -1)
                {
                    return false;
                }


                // Increasing the number of copies, of the current book, by one:
                SqlCommand updateCurrAvailableCmd = new SqlCommand(
                    "UPDATE book_main_tbl SET current_in_stock = @current_in_stock WHERE book_id = @book_id;",
                    sqlCon
                );

                updateCurrAvailableCmd.Parameters.AddWithValue("@book_id", bookID);
                updateCurrAvailableCmd.Parameters.AddWithValue("@current_in_stock", (currCopiesAvailable + 1));


                rowAffected = updateCurrAvailableCmd.ExecuteNonQuery();

                if (rowAffected != 1)
                {
                    Response.Write("<script> alert('Something went wrong.'); </script>");
                    return false;
                }


                // Should return true since it made it this far:
                return rowAffected == 1;

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

        private void ClearForm()
        {
            tbMemberName.Text = string.Empty;
            tbBookName.Text = string.Empty;
            tbStartDate = null;
            tbEndDate = null;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Simply highlighting, in red, the users who
            // have not returned their books before the due date:
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DateTime dueDate = Convert.ToDateTime(e.Row.Cells[5].Text);
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
    }
}