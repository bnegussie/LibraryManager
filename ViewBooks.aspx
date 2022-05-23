<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="ViewBooks.aspx.cs" Inherits="LibraryManager.ViewBooks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        // jQuery code from DataTables which allows us to have a search bar in the GridView:
        $(document).ready(function () {
            $('.table').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            
            <!-- Books Inventory List: -->
            <div class="col-md-8 mx-auto">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h2>View Books:</h2>
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
                                                                        Cost: <span id="priceSignViewBooks">$</span>
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
