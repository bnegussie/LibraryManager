<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="MemberLogin.aspx.cs" Inherits="LibraryManager.MemberSignIn" %>
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
                                <img src="resources/imgs/imgs/generaluser.png" width="150" />
                            </div>
                        </div>

                        <div class="row text-center">
                            <h3>Member Login</h3>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member ID:</label>
                                    <asp:TextBox ID="tbMemberID" runat="server" CssClass="form-control" placeholder="Member ID"/>
                                </div>

                                <div class="form-group mb-2">
                                    <label class="bold-text">Password:</label>
                                    <asp:TextBox ID="tbPwd" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"/>
                                </div>

                                <div class="form-group">
                                    <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="btn btn-success btn-block btn-lg btn-default" OnClick="Login_Button_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
