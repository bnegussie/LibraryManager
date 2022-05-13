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

                    // Caturing the user's name:
                    foreach (DataRow dataRow in dt.Rows)
                    {
                        string userName = dataRow.ItemArray[0].ToString();
                        Session["fName"] = userName;

                        string accountStatus = dataRow.ItemArray[1].ToString();
                        Session["accountStatus"] = accountStatus;
                        break;
                    }
                    Session["userType"] = "member";
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