<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminPublisherManagement.aspx.cs" Inherits="LibraryManager.AdminPublisherManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-5">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Publisher Details</h4>
                            </div>
                        </div>

                        <!-- Icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/publisher.png" width="100" />
                            </div>
                        </div>

                        <hr>

                        <!-- Publisher ID and name:-->
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Publisher ID:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" placeholder="ID" TextMode="Number" />
                                        <asp:Button ID="Button2" runat="server" Text="GO" CssClass="btn btn-secondary" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Publisher Name:</label>
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" placeholder="Publisher Name"/>
                                </div>
                            </div>
                        </div>


                        <!-- Modify buttons:-->
                        <div class="row">
                            <div class="col-4">
                                <asp:Button ID="Button1" runat="server" Text="Add" CssClass="btn btn-success btn-default" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="Button3" runat="server" Text="Update" CssClass="btn btn-warning btn-default" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="Button4" runat="server" Text="Delete" CssClass="btn btn-danger btn-default" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Publisher List: -->
            <div class="col-md-7">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Publisher List:</h4>
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
