<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="LibraryManager.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">

                <div class="card mb-1">
                    <div class="card-body">

                        <!-- User icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/adminuser.png" width="150" />
                            </div>
                        </div>

                        <div class="row text-center">
                            <h3>Administrator Login</h3>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Admin ID:</label>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Admin ID"/>
                                </div>

                                <div class="form-group mb-2">
                                    <label class="bold-text">Password:</label>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"/>
                                </div>

                                <div class="form-group">
                                    <asp:Button ID="Button1" runat="server" Text="Log in" CssClass="btn btn-success btn-block btn-lg btn-default" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
