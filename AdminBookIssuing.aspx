<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminBookIssuing.aspx.cs" Inherits="LibraryManager.AdminBookIssuing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Book Issuing</h4>
                            </div>
                        </div>

                        <!-- Books icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/books.png" width="100" />
                            </div>
                        </div>

                        <hr>

                        <!-- Member ID and book ID:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member ID:</label>
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="Member ID" TextMode="Number" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Book ID:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Book ID" TextMode="Number" />
                                        <asp:Button ID="Button5" runat="server" Text="GO" CssClass="btn btn-secondary" />
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- Member name and book name:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member name:</label>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Member name" ReadOnly="True" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Book name:</label>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="Book name" ReadOnly="True" />
                                </div>
                            </div>
                        </div>


                        <!-- Start and end date:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Start date:</label>
                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">End date:</label>
                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                            </div>
                        </div>

                        <!-- Modify buttons:-->
                        <div class="row">
                            <div class="col-6">
                                <asp:Button ID="Button1" runat="server" Text="Issue" CssClass="btn btn-primary btn-default" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="Button3" runat="server" Text="Return" CssClass="btn btn-success btn-default" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Issued Books List: -->
            <div class="col-md-7">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Issued Books List:</h4>
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
