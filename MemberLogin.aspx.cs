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
    public partial class MemberSignIn : System.Web.UI.Page
    {
        // DB connection string:
        private readonly string _conStr = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userType"] != null)
            {
                // The user has already logged in so they should not be on this page:
                Response.Redirect("HomePage.aspx");
                return;
            }

            tbMemberID.Focus();
        }

        protected void Login_Button_Click(object sender, EventArgs e)
        {
            if (IsValidLogin())
            {
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                Response.Write("<script> alert('The member ID or password is invalid.') </script>");
            }
        }

        private bool IsValidLogin()
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT first_name, account_status FROM member_main_tbl WHERE member_id='" +  tbMemberID.Text.Trim() + "' AND pwd='" + tbPwd.Text.Trim() + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);


                if (dt.Rows.Count == 1)
                {
                    // The login credentials are valid:

                    // Caching the user's info:

                    Session["fName"] = dt.Rows[0]["first_name"].ToString().Trim();
                    Session["accountStatus"] = dt.Rows[0]["account_status"].ToString().Trim();

                    Session["memberID"] = tbMemberID.Text.Trim();
                    Session["userType"] = "member";
                }

                return dt.Rows.Count == 1;

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
    }
}