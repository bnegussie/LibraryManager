<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminMemberManagement.aspx.cs" Inherits="LibraryManager.AdminMemberManagement" %>
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
                                <h4>Member Details</h4>
                            </div>
                        </div>

                        <!-- User icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/generaluser.png" width="100" />
                            </div>
                        </div>

                        <hr>

                        <!-- Member ID and account status:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member ID:</label>
                                    
                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="ID" />
                                        <asp:Button ID="Button2" runat="server" Text="GO" CssClass="btn btn-secondary" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Account Status:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" placeholder="Status" ReadOnly="true" />

                                        <asp:LinkButton CssClass="btn btn-success ms-1 rounded" ID="LinkButton1" runat="server">
                                            <i class="fa-solid fa-circle-check" ></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton CssClass="btn btn-warning ms-1 rounded" ID="LinkButton2" runat="server">
                                            <i class="fa-solid fa-circle-xmark"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton CssClass="btn btn-danger ms-1 rounded" ID="LinkButton3" runat="server">
                                            <i class="fa-solid fa-circle-xmark"></i>
                                        </asp:LinkButton>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- First and last name:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">First name:</label>
                                    <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" placeholder="First name" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Last name:</label>
                                    <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control" placeholder="Last name" ReadOnly="true" />
                                </div>
                            </div>
                        </div>


                        <!-- Date of birth and email address:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Date of birth:</label>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" TextMode="Date" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Email address:</label>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email address" ReadOnly="true" />
                                </div>
                            </div>
                        </div>


                         <!-- State, city, and zip code:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">State:</label>
                                    <asp:TextBox ID="TextBox9" runat="server" CssClass="form-control" placeholder="State" ReadOnly="true" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">City:</label>
                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" placeholder="City" ReadOnly="true" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Zip code:</label>
                                    <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" placeholder="Zip code" TextMode="Number" ReadOnly="true" />
                                </div>
                            </div>
                        </div>

                        <!-- Full address:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label class="bold-text">Full address:</label>
                                    <asp:TextBox ID="TextBox10" runat="server" CssClass="form-control" placeholder="Full address" ReadOnly="true" />
                                </div>
                            </div>
                        </div>

                        <!-- Delete member button:-->
                        <div class="row">
                            <div class="col">
                                <asp:Button ID="Button1" runat="server" Text="Delete Member Permanently" CssClass="btn btn-danger btn-default" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Members List: -->
            <div class="col-md-7">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Members List:</h4>
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
