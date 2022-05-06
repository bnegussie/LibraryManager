<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="MemberSignUp.aspx.cs" Inherits="LibraryManager.MemberSignUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto">

                <div class="card mb-1">
                    <div class="card-body">

                        <!-- User icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/generaluser.png" width="100" />
                            </div>
                        </div>

                        <div class="row text-center">
                            <h4>Member Sign Up</h4>
                        </div>

                        <hr>

                        <!-- First and last name:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">First name:</label>
                                    <asp:TextBox ID="tbFName" runat="server" CssClass="form-control" placeholder="First name"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Last name:</label>
                                    <asp:TextBox ID="tbLName" runat="server" CssClass="form-control" placeholder="Last name"/>
                                </div>
                            </div>
                        </div>

                        <!-- Date of birth and email address:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Date of birth:</label>
                                    <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Email address:</label>
                                    <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email address"/>
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
                                    <label class="bold-text">Zip code:</label>
                                    <asp:TextBox ID="tbZipCode" runat="server" CssClass="form-control" placeholder="Zip code" TextMode="Number" />
                                </div>
                            </div>
                        </div>

                        <!-- Full address:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group mb-5">
                                    <label class="bold-text">Full address:</label>
                                    <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control" placeholder="Full address"/>
                                </div>
                            </div>
                        </div>

                        <!-- New member ID:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group mb-2">
                                    <label class="bold-text"> Member ID </label>
                                    <span>(Choose a unique user ID):</span>
                                    <asp:TextBox ID="tbMemberID" runat="server" CssClass="form-control" placeholder="Member ID"/>
                                </div>
                            </div>
                        </div>

                        <!-- Password and confirm password:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Password:</label>
                                    <asp:TextBox ID="tbPwd" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Confirm password:</label>
                                    <asp:TextBox ID="tbConfirmPwd" runat="server" CssClass="form-control" placeholder="Confirm password" TextMode="Password"/>
                                </div>
                            </div>
                        </div>

                        <!-- Submit button:-->
                        <div class="form-group">
                            <asp:Button ID="btnSignUp" runat="server" Text="Sign up" CssClass="btn btn-primary btn-block btn-lg btn-default" OnClick="Button1_Click" />
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
