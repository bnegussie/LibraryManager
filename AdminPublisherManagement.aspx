<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminPublisherManagement.aspx.cs" Inherits="LibraryManager.AdminPublisherManagement" %>
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
                                        <asp:TextBox ID="tbPublisherID" runat="server" CssClass="form-control" placeholder="ID" TextMode="Number" />
                                        <asp:Button ID="btnGO" runat="server" Text="GO" CssClass="btn btn-secondary" OnClick="btnGO_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Publisher Name:</label>
                                    <asp:TextBox ID="tbPublisherName" runat="server" CssClass="form-control" placeholder="Publisher Name"/>
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
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libraryDBConnectionString %>" SelectCommand="SELECT * FROM [publisher_main_tbl]"></asp:SqlDataSource>

                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="publisher_id" DataSourceID="SqlDataSource1">
                                    <Columns>
                                        <asp:BoundField DataField="publisher_id" HeaderText="Publisher ID" ReadOnly="True" SortExpression="publisher_id" />
                                        <asp:BoundField DataField="publisher_name" HeaderText="Publisher Name" SortExpression="publisher_name" />
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
