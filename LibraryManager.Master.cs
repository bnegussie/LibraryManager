using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManager
{
    public partial class LibraryManager : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["userType"] == null)
                {
                    btnLogin.Visible = true;
                    btnSignUp.Visible = true;

                    ddMemberOptions.Visible = false;
                    ddAdminOptions.Visible = false;
                }
                else
                {
                    btnLogin.Visible = false;
                    btnSignUp.Visible = false;

                    if (Session["userType"].Equals("member"))
                    {
                        // The current user is a member:
                        ddMemberOptions.Visible = true;
                        memberName.Text = Session["fName"].ToString();

                        ddAdminOptions.Visible = false;
                    }
                    else if (Session["userType"].Equals("admin"))
                    {
                        // The current user is an admin:
                        ddAdminOptions.Visible = true;
                        adminName.Text = Session["fName"].ToString();

                        ddMemberOptions.Visible = false;
                    }
                }

            }
            catch
            {
                Response.Write("<script>alert('An error occurred.');</script>");
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void SignUpButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("MemberSignUp.aspx");
        }

        protected void Logout(object sender, EventArgs e)
        {
            if (Session["fName"] == null || Session["fName"].Equals(""))
            {
                ddAdminOptions.Visible = false;
                ddMemberOptions.Visible = false;
            }
            else if (Session["userType"].Equals("member"))
            {
                // The current user is a member:
                ddMemberOptions.Visible = false;
                memberName.Text = null;
            }
            else
            {
                // The current user is an admin:
                ddAdminOptions.Visible = false;
                adminName.Text = null;
            }


            btnLogin.Visible = true;
            btnSignUp.Visible = true;

            Session["userType"] = null;
            Session["fName"] = null;
            Session["accountStatus"] = null;

            Response.Redirect("HomePage.aspx");
        }


        protected void DDMemberOptions_Change(Object sender, EventArgs e)
        {
            if (ddMemberList.SelectedItem.Value.Equals(Session["fName"]))
            {
                return;
            }

            if (ddMemberList.SelectedItem.Value.Equals("Logout"))
            {
                Logout(sender, e);
            }
            else
            {
                Response.Redirect(ddMemberList.SelectedItem.Value);
            }
        }

        protected void DDAdminOptions_Change(Object sender, EventArgs e)
        {
            if (ddAdminList.SelectedItem.Value.Equals(Session["fName"]))
            {
                return;
            }

            if (ddAdminList.SelectedItem.Value.Equals("Logout") )
            {
                Logout(sender, e);
            } 
            else
            {
                Response.Redirect(ddAdminList.SelectedItem.Value);
            }
        }

        protected void ViewBooksBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewBooks.aspx");
        }
    }
}