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

        }

        protected void Login_Button_Click(object sender, EventArgs e)
        {
            if (isValidLogin())
            {
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                Response.Write("<script> alert('The email or password is invalid.') </script>");
            }
        }

        private bool isValidLogin()
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);

            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT member_id FROM member_main_tbl WHERE member_id='" +  tbMemberID.Text.Trim() + "' AND pwd='" + tbPwd.Text.Trim() + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

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