<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminBookInventory.aspx.cs" Inherits="LibraryManager.AdminBookInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        // jQuery code from DataTables which allows us to have a search bar in the GridView:
        $(document).ready(function () {
            $('.table').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });


        // Allowing the user to preview the book image which they selected:
        function readURL(input) {
            if (input.files && input.files[0]) {
                let reader = new FileReader();

                reader.onload = function (e) {
                    $('#imgView').attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Book Details</h4>
                            </div>
                        </div>

                        <!-- Books icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img id="imgView" src="resources/imgs/imgs/books.png" width="100" />
                            </div>
                        </div>

                        <hr>

                        <div class="row mb-2">
                            <div class="col">
                                <asp:FileUpload onchange="readURL(this);" class="form-control" ID="fBookImg" runat="server" />
                            </div>
                        </div>

                        <!-- Book ID and title:-->
                        <div class="row mb-2">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="bold-text">Book ID:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="tbBookID" runat="server" CssClass="form-control" placeholder="ID" TextMode="Number" />
                                        <asp:Button ID="btnGO" runat="server" Text="GO" CssClass="btn btn-secondary" OnClick="BtnGO_Click" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8">
                                <div class="form-group">
                                    <label class="bold-text">Title:</label>
                                    <asp:TextBox ID="tbBookTitle" runat="server" CssClass="form-control" placeholder="Title" />
                                </div>
                            </div>
                        </div>

                        <!-- Book details: language, author, genre, as well as publisher name and date -->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Language:</label>
                                    <asp:DropDownList class="form-control" ID="ddLanguage" runat="server">
                                        <asp:ListItem Text="Select..." />
                                        <asp:ListItem Text="English" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group mb-2">
                                    <label class="bold-text">Publisher:</label>
                                    <asp:DropDownList class="form-control" ID="ddPublisherName" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Author:</label>
                                    <asp:DropDownList class="form-control" ID="ddAuthorName" runat="server">
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group mb-2">
                                    <label class="bold-text">Published Date:</label>
                                    <asp:TextBox ID="tbPublishedDate" runat="server" CssClass="form-control" placeholder="Last name" TextMode="Date" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Genre:</label>
                                    <asp:ListBox class="form-control" ID="lGenre" runat="server" SelectionMode="Multiple">
                                        <asp:ListItem Text="Action" Value="Action" />
                                        <asp:ListItem Text="Classics" Value="Classics" />
                                        <asp:ListItem Text="Comic" Value="Comic" />
                                        <asp:ListItem Text="Fantasy" Value="Fantasy" />
                                        <asp:ListItem Text="Historical" Value="Historical" />
                                        <asp:ListItem Text="Horror" Value="Horror" />
                                        <asp:ListItem Text="Literary" Value="Literary" />
                                    </asp:ListBox>
                                </div>
                            </div>
                        </div>


                        <!-- Book edition, cost, and the number of pages:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Edition:</label>
                                    <asp:TextBox ID="tbEdition" runat="server" CssClass="form-control" placeholder="Edition" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Cost:</label>
                                    <asp:TextBox ID="tbCost" runat="server" CssClass="form-control" placeholder="Cost" TextMode="Number" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Pages:</label>
                                    <asp:TextBox ID="tbPages" runat="server" CssClass="form-control" placeholder="Pages" TextMode="Number" />
                                </div>
                            </div>
                        </div>


                        <!-- Book availability statuses:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">In-stock Copies:</label>
                                    <asp:TextBox ID="tbInstockCopies" runat="server" CssClass="form-control" placeholder="Actual stock" TextMode="Number" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Currently Available:</label>
                                    <asp:TextBox ID="tbCurrAvailable" runat="server" CssClass="form-control" placeholder="Current stock" ReadOnly="true" TextMode="Number" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Issued Books:</label>
                                    <asp:TextBox ID="tbIssuedBook" runat="server" CssClass="form-control" placeholder="Issued books" ReadOnly="true" TextMode="Number" />
                                </div>
                            </div>
                        </div>

                        <!-- Book description:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label class="bold-text">Description:</label>
                                    <asp:TextBox ID="tbBookDesc" runat="server" CssClass="form-control" placeholder="Description" TextMode="MultiLine" />
                                </div>
                            </div>
                        </div>

                        <!-- Modify buttons:-->
                        <div class="row">
                            <div class="col-4">
                                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success btn-default" OnClick="BtnAdd_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary btn-default" OnClick="BtnUpdate_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-default" OnClick="BtnDelete_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Books Inventory List: -->
            <div class="col-md-6">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Books Inventory List:</h4>
                            </div>
                        </div>

                        <hr>

                        <div class="row text-center">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libraryDBConnectionString %>" SelectCommand="SELECT * FROM [book_main_tbl]"></asp:SqlDataSource>

                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="book_id" DataSourceID="SqlDataSource1">
                                    <Columns>
                                        <asp:BoundField ItemStyle-CssClass="bold-text" ItemStyle-Font-Size="X-Large" DataField="book_id" HeaderText="Book ID" ReadOnly="True" SortExpression="book_id" />


                                        <asp:TemplateField HeaderText="Book Details">
                                            <ItemTemplate>

                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-lg-8">

                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <asp:Label ID="lTitle" runat="server" Text='<%# Eval("title") %>' Font-Bold="true" Font-Size="Large"></asp:Label>
                                                                </div>
                                                            </div>

                                                            <div class="row">
                                                                <div class="col mb-3">
                                                                    <p class="pBookDetails">
                                                                        Author: 
                                                                        <asp:Label ID="lAuthor" runat="server" Text='<%# Eval("author_full_name") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        Genre: 
                                                                        <asp:Label ID="lGenre" runat="server" Text='<%# Eval("genre") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        Language: 
                                                                        <asp:Label ID="lLanguage" runat="server" Text='<%# Eval("language") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                </div>

                                                                <hr />

                                                                <div class="col mb-3">
                                                                    <p class="pBookDetails">
                                                                        Publisher: 
                                                                        <asp:Label ID="lPublisher" runat="server" Text='<%# Eval("publisher_name") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        Published Date: 
                                                                        <asp:Label ID="lPublishedDate" runat="server" Text='<%# Eval("published_date") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        Pages: 
                                                                        <asp:Label ID="lPages" runat="server" Text='<%# Eval("num_of_pages") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        Edition: 
                                                                        <asp:Label ID="lEdition" runat="server" Text='<%# Eval("edition") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                </div>

                                                                <hr />

                                                                <div class="col mb-3">
                                                                    <p class="pBookDetails">
                                                                        Cost: <span id="priceSignBooksInventory">$</span>
                                                                        <asp:Label ID="lCost" runat="server" Text='<%# Eval("book_cost") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        In-stock Copies: 
                                                                        <asp:Label ID="lInstockCopies" runat="server" Text='<%# Eval("actual_stock") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                    <p class="pBookDetails">
                                                                        Currently Available:
                                                                        <asp:Label ID="lCurrAvailable" runat="server" Text='<%# Eval("current_in_stock") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                </div>

                                                                <hr />

                                                                <div class="col mb-3">
                                                                    <p class="pBookDetails">
                                                                        Description:
                                                                        <asp:Label ID="lDesc" runat="server" Text='<%# Eval("book_desc") %>' Font-Bold="true"></asp:Label>
                                                                    </p>
                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="col-lg-4">
                                                            <asp:Image class="img-fluid imgBook" ID="imgBook" runat="server" ImageUrl='<%# Eval("book_img_link") %>' />
                                                        </div>
                                                    </div>
                                                </div>

                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
