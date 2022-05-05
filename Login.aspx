<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LibraryManager.SignIn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="text-center page mb-2">
        <h1>
            Login
        </h1>

        <br />

        <div class="row">
            <div class="col-md-6">
                <h3>Personal</h3>
                <div>
                    <a href="MemberLogin.aspx">
                        <button type="button" class="btn btn-primary">
                           Memeber log in
                        </button>
                    </a>
                </div>
            </div>


            <div class="col-md-6">
                <h3>Employee</h3>
                <div>
                    <a href="AdminLogin.aspx">
                        <button type="button" class="btn btn-primary">
                            Administrator log in
                        </button>
                    </a>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
