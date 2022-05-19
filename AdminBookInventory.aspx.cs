﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManager
{
    public partial class AdminBookInventory : System.Web.UI.Page
    {
        // DB connection string:
        private readonly string _conStr = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        private HashSet<String> authorsSet = new HashSet<String>();
        private HashSet<String> publishersSet = new HashSet<String>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userType"] == null || !Session["userType"].Equals("admin"))
            {
                // This page requires admin credentials:
                Response.Redirect("HomePage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // We only want these methods to be called initially when the page is loaded:
                GetAllAuthors();
                GetAllPublishers();
            }

            GridView1.DataBind();
        }

        protected void BtnGO_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbBookID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Book ID.');</script>");
                ClearForm();
                return;
            }

            GetSelectedBookData();
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbBookID.Text.Trim()))
            {
                // Invalid input:
                Response.Write("<script>alert('Please proivide a valid Book ID.');</script>");
                return;
            }

            // Checking if the new ID provided is already being used:
            if (IsIDUnique(tbBookID.Text.Trim()))
            {
                if (AddNewBook())
                {
                    Response.Write("<script>alert('The book has been added successfully.');</script>");
                    ClearForm();
                    GridView1.DataBind();
                }
            }
            else
            {
                Response.Write("<script>alert('This Book ID is already being used.');</script>");
            }
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {

        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {

        }

        private void GetSelectedBookData()
        {
            // Clearing out contents:
            string memberIDEntered = tbBookID.Text.Trim();
            ClearForm();
            tbBookID.Text = memberIDEntered;


            // Capturing the specified book data:

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT book_img_link, book_id, title, language, publisher_name, author_full_name, published_date, genre, edition, book_cost, num_of_pages, actual_stock, current_in_stock, book_desc FROM book_main_tbl WHERE book_id = '" + tbBookID.Text.Trim() + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                if (dt.Rows.Count == 1)
                {
                    tbBookID.Text = dt.Rows[0]["book_id"].ToString().Trim();
                    tbBookTitle.Text = dt.Rows[0]["title"].ToString().Trim();

                    ddLanguage.SelectedValue = dt.Rows[0]["language"].ToString().Trim();

                    SelectSpecifiedDropDownValue(authorsSet, ddAuthorName, dt.Rows[0]["author_full_name"].ToString().Trim());

                    SelectSpecifiedDropDownValue(publishersSet, ddPublisherName, dt.Rows[0]["publisher_name"].ToString().Trim());

                    tbPublishedDate.Text = dt.Rows[0]["published_date"].ToString().Trim();

                    tbEdition.Text = dt.Rows[0]["edition"].ToString().Trim();
                    tbCost.Text = dt.Rows[0]["book_cost"].ToString().Trim();
                    tbPages.Text = dt.Rows[0]["num_of_pages"].ToString().Trim();

                    tbInstockCopies.Text = dt.Rows[0]["actual_stock"].ToString().Trim();
                    tbCurrAvailable.Text = dt.Rows[0]["current_in_stock"].ToString().Trim();

                    int currIssuedBooks = int.Parse(tbInstockCopies.Text) - int.Parse(tbCurrAvailable.Text);
                    tbIssuedBook.Text = currIssuedBooks.ToString();


                    tbBookDesc.Text = dt.Rows[0]["book_desc"].ToString().Trim();

                    MultiSelectListSelection(lGenre, dt.Rows[0]["genre"].ToString().Trim().Split(','));

                    fBookImg = null;

                }
                else
                {
                    Response.Write("<script>alert('The provided Book ID does not exist.');</script>");
                    memberIDEntered = tbBookID.Text.Trim();
                    ClearForm();
                    tbBookID.Text = memberIDEntered;
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

        private void SelectSpecifiedDropDownValue(HashSet<String> currSet, DropDownList currDDList,
            string selectedValue)
        {
            // Safety check: or else if the provided name is not present in our DD-list
            // the server to client side upload will crash (will not properly complete):
            if (currSet.Contains(selectedValue))
            {
                currDDList.SelectedValue = selectedValue;
            }
        }

        private void MultiSelectListSelection(ListBox currList, string[] selectedListArr)
        {
            HashSet<string> selectedListSet = new HashSet<string>(selectedListArr);
            int selectedValsFound = 0;

            for (int i = 0; i < currList.Items.Count && selectedValsFound < selectedListSet.Count; i++)
            {
                if (selectedListSet.Contains(currList.Items[i].ToString()))
                {
                    currList.Items[i].Selected = true;
                    selectedValsFound++;
                }
            }
        }

        private void ClearForm()
        {
            fBookImg = null;

            tbBookID.Text = string.Empty;
            tbBookTitle.Text = string.Empty;
            ddLanguage.ClearSelection();

            GetAllPublishers();
            GetAllAuthors();

            tbPublishedDate.Text = string.Empty;
            lGenre.ClearSelection();

            tbEdition.Text = string.Empty;
            tbCost.Text = string.Empty;
            tbPages.Text = string.Empty;

            tbInstockCopies.Text = string.Empty;
            tbCurrAvailable.Text = string.Empty;
            tbIssuedBook.Text = string.Empty;

            tbBookDesc.Text = string.Empty;
        }

        private void GetAllAuthors()
        {
            ddAuthorName.Items.Clear();

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT author_full_name FROM author_main_tbl ORDER BY author_full_name ASC;",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                ddAuthorName.Items.Add(new ListItem("Select..."));
                foreach (DataRow dataRow in dt.Rows)
                {
                    ddAuthorName.Items.Add(new ListItem(dataRow.ItemArray[0].ToString().Trim()));

                    authorsSet.Add(dataRow.ItemArray[0].ToString().Trim());
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

        private void GetAllPublishers()
        {
            ddPublisherName.Items.Clear();

            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT publisher_name FROM publisher_main_tbl ORDER BY publisher_name ASC;",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                ddPublisherName.Items.Add(new ListItem("Select..."));
                foreach (DataRow dataRow in dt.Rows)
                {
                    ddPublisherName.Items.Add(new ListItem(dataRow.ItemArray[0].ToString().Trim()));

                    publishersSet.Add(dataRow.ItemArray[0].ToString().Trim());
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

        private bool IsIDUnique(string bookID)
        {
            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);

            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT book_id FROM book_main_tbl WHERE book_id = '" + bookID + "';",
                    sqlCon
                );

                SqlDataAdapter dAdapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                dAdapter.Fill(dt);

                sqlCon.Close();

                return dt.Rows.Count == 0;

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

        private bool AddNewBook()
        {
            // Input validations:
            if (ddAuthorName.SelectedIndex == 0)
            {
                Response.Write("<script>alert('Please select an author.');</script>");
                return false;
            }
            else if (ddPublisherName.SelectedIndex == 0)
            {
                Response.Write("<script>alert('Please select a publisher.');</script>");
                return false;
            }
            else if (lGenre.GetSelectedIndices().Length == 0)
            {
                Response.Write("<script>alert('Please select at least one genre.');</script>");
                return false;
            }
            else if (!fBookImg.HasFile)
            {
                Response.Write("<script>alert('Please upload an image for the book.');</script>");
                return false;
            }
            else if (ddLanguage.SelectedIndex == 0)
            {
                Response.Write("<script>alert('Please specify the language.');</script>");
                return false;
            }
            else if (string.IsNullOrEmpty(tbBookTitle.Text) ||
                string.IsNullOrEmpty(tbPublishedDate.Text) ||
                string.IsNullOrEmpty(tbCost.Text) ||
                string.IsNullOrEmpty(tbPages.Text) ||
                string.IsNullOrEmpty(tbBookDesc.Text) ||
                string.IsNullOrEmpty(tbInstockCopies.Text)
                )
            {
                Response.Write("<script>alert('Please fill out all of the text boxes.');</script>");
                return false;
            }
            // FINISHED: Input validations.

            // Preprocessing data:

            // START: Genre
            // Capturing the specified genre(s) this book is placed in:
            string multiGenre = "";
            foreach (int i in lGenre.GetSelectedIndices())
            {
                multiGenre += lGenre.Items[i] + ",";
            }
            multiGenre = multiGenre.Remove(multiGenre.Length - 1);
            // End of genre.


            // Book image upload:
            fBookImg.SaveAs(Server.MapPath("uploads/book_inventory/" + fBookImg.PostedFile.FileName));
            string filePath = "~upload/book_inventory/" + fBookImg.PostedFile.FileName;
            // FINISHED:Book image upload.


            // FINISHED: Preprocessing data.


            // Connecting to DB:
            SqlConnection sqlCon = new SqlConnection(_conStr);
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO book_main_tbl (book_id, title, author_full_name, language, genre, publisher_name, published_date, edition, book_cost, num_of_pages, book_desc, actual_stock, current_in_stock, book_img_link) VALUES (@book_id, @title, @author_full_name, @language, @genre, @publisher_name, @published_date, @edition, @book_cost, @num_of_pages, @book_desc, @actual_stock, @current_in_stock, @book_img_link);",
                    sqlCon
                );

                cmd.Parameters.AddWithValue("@book_id", tbBookID.Text.Trim());
                cmd.Parameters.AddWithValue("@title", tbBookTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@author_full_name", ddAuthorName.SelectedItem.Text);

                cmd.Parameters.AddWithValue("@language", ddLanguage.SelectedItem.ToString());
                cmd.Parameters.AddWithValue("@publisher_name", ddPublisherName.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@genre", multiGenre);
                
                cmd.Parameters.AddWithValue("@published_date", tbPublishedDate.Text.Trim());
                cmd.Parameters.AddWithValue("@edition", tbEdition.Text.Trim());
                cmd.Parameters.AddWithValue("@book_cost", tbCost.Text.Trim());

                cmd.Parameters.AddWithValue("@num_of_pages", tbPages.Text.Trim());
                cmd.Parameters.AddWithValue("@book_desc", tbBookDesc.Text.Trim());
                cmd.Parameters.AddWithValue("@actual_stock", tbInstockCopies.Text.Trim());

                cmd.Parameters.AddWithValue("@current_in_stock", tbInstockCopies.Text.Trim());
                cmd.Parameters.AddWithValue("@book_img_link", filePath);


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
    }
}