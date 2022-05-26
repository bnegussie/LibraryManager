<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminBookIssuing.aspx.cs" Inherits="LibraryManager.AdminBookIssuing" %>
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
                                    <asp:TextBox ID="tbMemberID" runat="server" CssClass="form-control" placeholder="Member ID" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Book ID:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="tbBookID" runat="server" CssClass="form-control" placeholder="Book ID" TextMode="Number" />
                                        <asp:Button ID="btnGO" runat="server" Text="GO" CssClass="btn btn-secondary" OnClick="BtnGO_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- Member name and book name:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Member name:</label>
                                    <asp:TextBox ID="tbMemberName" runat="server" CssClass="form-control" placeholder="Member name" ReadOnly="True" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Book name:</label>
                                    <asp:TextBox ID="tbBookName" runat="server" CssClass="form-control" placeholder="Book name" ReadOnly="True" />
                                </div>
                            </div>
                        </div>


                        <!-- Start and due date:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Start date:</label>
                                    <asp:TextBox ID="tbStartDate" runat="server" CssClass="form-control" TextMode="Date" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Due date:</label>
                                    <asp:TextBox ID="tbEndDate" runat="server" CssClass="form-control" TextMode="Date" ReadOnly="true" />
                                </div>
                            </div>
                        </div>

                        <!-- Modify buttons:-->
                        <div class="row">
                            <div class="col-6">
                                <asp:Button ID="btnIssue" runat="server" Text="Issue" CssClass="btn btn-primary btn-default" OnClick="BtnIssue_Click" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnReturn" runat="server" Text="Return" CssClass="btn btn-success btn-default" OnClick="BtnReturn_Click" />
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
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libraryDBConnectionString %>" SelectCommand="SELECT * FROM [book_issue_tbl] ORDER BY book_id"></asp:SqlDataSource>

                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="book_issue_id" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                        <asp:BoundField DataField="book_id" HeaderText="Book ID:" SortExpression="book_id" />
                                        <asp:BoundField DataField="book_title" HeaderText="Title:" SortExpression="book_title" />
                                        <asp:BoundField DataField="member_id" HeaderText="Member ID:" SortExpression="member_id" />
                                        <asp:BoundField DataField="member_first_name" HeaderText="Member First Name:" SortExpression="member_first_name" />
                                        <asp:BoundField DataField="member_last_name" HeaderText="Member Last Name:" SortExpression="member_last_name" />
                                        <asp:BoundField DataField="due_date" HeaderText="Due Date:" SortExpression="due_date" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
