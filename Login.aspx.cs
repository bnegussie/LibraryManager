using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManager
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userType"] != null)
            {
                // The user has already logged in so they should not be on this page:
                Response.Redirect("HomePage.aspx");
                return;
            }
        }
    }
}