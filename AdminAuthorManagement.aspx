<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminAuthorManagement.aspx.cs" Inherits="LibraryManager.AdminAuthorManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- jQuery code from DataTables which allows us to have a search bar in the GridView: --%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.table').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-5">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Author Details</h4>
                            </div>
                        </div>

                        <!-- Icon: -->
                        <div class="row">
                            <div class="col text-center">
                                <img src="resources/imgs/imgs/writer.png" width="100" />
                            </div>
                        </div>

                        <hr>

                        <!-- Author ID and name:-->
                        <div class="row">
                            <div class="col-md-5">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Author ID:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="tbAuthorID" runat="server" CssClass="form-control" placeholder="ID" TextMode="Number" />
                                        <asp:Button ID="btnGO" runat="server" Text="GO" CssClass="btn btn-secondary" OnClick="btnGO_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Author Name:</label>
                                    <asp:TextBox ID="tbAuthorName" runat="server" CssClass="form-control" placeholder="Author Name"/>
                                </div>
                            </div>
                        </div>


                        <!-- Modify buttons:-->
                        <div class="row">
                            <div class="col-4">
                                <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success btn-default" OnClick="btnAdd_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-warning btn-default" OnClick="btnUpdate_Click" />
                            </div>
                            <div class="col-4">
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-default" OnClick="btnDelete_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- Author List: -->
            <div class="col-md-7">

                <div class="card mb-1">
                    <div class="card-body">

                        <div class="row text-center">
                            <div class="col">
                                <h4>Author List:</h4>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libraryDBConnectionString %>" SelectCommand="SELECT * FROM [author_main_tbl]"></asp:SqlDataSource>

                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="author_id" DataSourceID="SqlDataSource1">
                                    <Columns>
                                        <asp:BoundField DataField="author_id" HeaderText="Author ID" ReadOnly="True" SortExpression="author_id" />
                                        <asp:BoundField DataField="author_full_name" HeaderText="Author Name" SortExpression="author_full_name" />
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
