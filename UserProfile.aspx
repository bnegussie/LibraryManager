<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="LibraryManager.UserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5">

                <div class="card mb-1">
                    <div class="card-body">

                        <!-- User icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/generaluser.png" width="100" />
                            </div>
                        </div>

                        <div class="row text-center">
                            <div class="col">
                                <h4>Your Profile</h4>
                                <span>Account status - </span>
                                <asp:Label class="badge rounded-pill bg-success" ID="Label1" runat="server" Text="Your status"></asp:Label>
                            </div>
                        </div>

                        <hr>

                        <!-- First and last name:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">First name:</label>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="First name"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Last name:</label>
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="Last name"/>
                                </div>
                            </div>
                        </div>

                        <!-- Date of birth and email address:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Date of birth:</label>
                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Email address:</label>
                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email address"/>
                                </div>
                            </div>
                        </div>

                        <!-- State, city, and zip code:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">State:</label>
                                    <asp:DropDownList class="form-control" ID="DropDownList1" runat="server">
                                        <asp:ListItem Text="Select" Value="select" />
                                        <asp:ListItem Text="Washington" Value="Washington" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">City:</label>
                                    <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control" placeholder="City"/>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Zip code:</label>
                                    <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" placeholder="Zip code" TextMode="Number" />
                                </div>
                            </div>
                        </div>

                        <!-- Full address:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group mb-5">
                                    <label class="bold-text">Full address:</label>
                                    <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control" placeholder="Full address"/>
                                </div>
                            </div>
                        </div>

                        <!-- User's current member ID:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member ID:</label>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Member ID" ReadOnly="True" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Old password:</label>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Old password" TextMode="Password"/>
                                </div>
                            </div>
                        </div>

                        <!-- New password section:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">New password:</label>
                                    <asp:TextBox ID="TextBox10" runat="server" CssClass="form-control" placeholder="New password" TextMode="Password"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Confirm new password:</label>
                                    <asp:TextBox ID="TextBox11" runat="server" CssClass="form-control" placeholder="Confirm new password" TextMode="Password"/>
                                </div>
                            </div>
                        </div>

                        <!-- Submit button:-->
                        <div class="form-group">
                            <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btn btn-success btn-block btn-lg btn-default" />
                        </div>

                    </div>
                </div>

            </div>


            <!-- User issued books: -->
            <div class="col-md-7">

                <div class="card mb-1">
                    <div class="card-body">

                        <!-- Books icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/books.png" width="100" />
                            </div>
                        </div>

                        <div class="row text-center">
                            <div class="col">
                                <h4>Your Issued Books:</h4>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col">
                                <asp:GridView class="tab;e table-striped table-boardered" ID="GridView1" runat="server"></asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
