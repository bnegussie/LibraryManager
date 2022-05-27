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
    public partial class AdminLogin : System.Web.UI.Page
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

            tbAminID.Focus();
        }

        protected void Login_Button_Click(object sender, EventArgs e)
        {
            if (IsValidLogin())
            {
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                Response.Write("<script> alert('The admin ID or password is invalid.') </script>");
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
                    "SELECT first_name FROM admin_login_tbl WHERE admin_id='" + tbAminID.Text.Trim() + "' AND pwd='" + tbPwd.Text.Trim() + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);


                if (dt.Rows.Count == 1)
                {
                    // The login credentials are valid:

                    // Caturing the user's name:
                    foreach (DataRow dataRow in dt.Rows)
                    {
                        string userName = dataRow.ItemArray[0].ToString();
                        Session["fName"] = userName;
                        break;
                    }
                    Session["userType"] = "admin";
                }

                sqlCon.Close();

                return dt.Rows.Count == 1;

            }
            catch (Exception ex)
            {
                if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                {
                    sqlCon.Close();
                }
                Response.Write("<script>alert('An error occurred.');</script>");

                return false;
            }
        }
    }
}