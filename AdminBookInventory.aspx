<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminBookInventory.aspx.cs" Inherits="LibraryManager.AdminBookInventory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
                                <img src="resources/imgs/imgs/books.png" width="100" />
                            </div>
                        </div>

                        <hr>

                        <div class="row mb-2">
                            <div class="col">
                                <asp:FileUpload class="form-control" ID="FileUpload1" runat="server" />
                            </div>
                        </div>

                        <!-- Book ID and title:-->
                        <div class="row mb-2">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="bold-text">Book ID:</label>
                                    
                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="ID" />
                                        <asp:Button ID="Button2" runat="server" Text="GO" CssClass="btn btn-secondary" />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-8">
                                <div class="form-group">
                                    <label class="bold-text">Book title:</label>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Title" />
                                </div>
                            </div>
                        </div>

                        <!-- Book details: language, author, genre, as well as publisher name and date -->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Language:</label>
                                    <asp:DropDownList class="form-control" ID="DropDownList4" runat="server">
                                        <asp:ListItem Text="Select" Value="select" />
                                        <asp:ListItem Text="English" Value="English" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group mb-2">
                                    <label class="bold-text">Publisher name:</label>
                                    <asp:DropDownList class="form-control" ID="DropDownList5" runat="server">
                                        <asp:ListItem Text="Select" Value="select" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Author name:</label>
                                    <asp:DropDownList class="form-control" ID="DropDownList6" runat="server">
                                        <asp:ListItem Text="Select" Value="select" />
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group mb-2">
                                    <label class="bold-text">Published date:</label>
                                    <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" placeholder="Last name" TextMode="Date" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Genre:</label>
                                    <asp:ListBox class="form-control" ID="ListBox2" runat="server" SelectionMode="Multiple">
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
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Edition" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Cost:</label>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="Cost" TextMode="Number" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Pages:</label>
                                    <asp:TextBox ID="TextBox14" runat="server" CssClass="form-control" placeholder="Pages" TextMode="Number" />
                                </div>
                            </div>
                        </div>


                        <!-- Book availability statuses:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Actual stock:</label>
                                    <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control" placeholder="Actual stock" TextMode="Number" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Current stock:</label>
                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" placeholder="Current stock" ReadOnly="true" TextMode="Number" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Issued books:</label>
                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" placeholder="Issued books" ReadOnly="true" TextMode="Number" />
                                </div>
                            </div>
                        </div>

                        <!-- Book description:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label class="bold-text">Book description:</label>
                                    <asp:TextBox ID="TextBox10" runat="server" CssClass="form-control" placeholder="Description" TextMode="MultiLine"/>
                                </div>
                            </div>
                        </div>

                        <!-- Modify buttons:-->
                        <div class="row">
                            <div class="col-4">
                                <asp:Button ID="Button1" runat="server" Text="Add" CssClass="btn btn-success btn-default" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="Button3" runat="server" Text="Update" CssClass="btn btn-primary btn-default" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="Button4" runat="server" Text="Delete" CssClass="btn btn-danger btn-default" />
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

                        <div class="row">
                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server"></asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
