<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="MemberProfile.aspx.cs" Inherits="LibraryManager.UserProfile" %>
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
                                <span>Account Status - </span>
                                <asp:Label class="badge rounded-pill btn-secondary" ID="lAccountStatus" runat="server" Text="Your status"></asp:Label>
                            </div>
                        </div>

                        <hr>

                        <!-- First and last name:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">First Name:</label>
                                    <asp:TextBox ID="tbFName" runat="server" CssClass="form-control" placeholder="First Name"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Last Name:</label>
                                    <asp:TextBox ID="tbLName" runat="server" CssClass="form-control" placeholder="Last Name"/>
                                </div>
                            </div>
                        </div>

                        <!-- Date of birth and email address:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Date of Birth:</label>
                                    <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Email Address:</label>
                                    <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email Address"/>
                                </div>
                            </div>
                        </div>

                        <!-- State, city, and zip code:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">State:</label>
                                    <asp:DropDownList class="form-control" ID="ddState" runat="server">
                                        <asp:ListItem Text="Select" Value="select" />
                                        <asp:ListItem Text="Washington" Value="Washington" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">City:</label>
                                    <asp:TextBox ID="tbCity" runat="server" CssClass="form-control" placeholder="City"/>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Zip Code:</label>
                                    <asp:TextBox ID="tbZipCode" runat="server" CssClass="form-control" placeholder="Zip Code" TextMode="Number" />
                                </div>
                            </div>
                        </div>

                        <!-- Full address:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group mb-5">
                                    <label class="bold-text">Full Address:</label>
                                    <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control" placeholder="Full Address"/>
                                </div>
                            </div>
                        </div>

                        <!-- User's current member ID:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member ID:</label>
                                    <asp:TextBox ID="tbMemberID" runat="server" CssClass="form-control" placeholder="Member ID" ReadOnly="True" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Old Password:</label>
                                    <asp:TextBox ID="tbOldPwd" runat="server" CssClass="form-control" placeholder="Old Password" TextMode="Password"/>
                                </div>
                            </div>
                        </div>

                        <!-- New password section:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">New Password:</label>
                                    <asp:TextBox ID="tbNewPwd" runat="server" CssClass="form-control" placeholder="New Password" TextMode="Password"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Confirm New Password:</label>
                                    <asp:TextBox ID="tbNewPwdConfirmation" runat="server" CssClass="form-control" placeholder="Confirm New Password" TextMode="Password"/>
                                </div>
                            </div>
                        </div>

                        <!-- Submit button:-->
                        <div class="form-group">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-block btn-lg btn-default" OnClick="BtnUpdate_Click" />
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

                        <div class="row text-center">
                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound"></asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
