<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManager.Master" AutoEventWireup="true" CodeBehind="AdminMemberManagement.aspx.cs" Inherits="LibraryManager.AdminMemberManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- jQuery code from DataTables which allows us to have a search bar in the GridView: --%>
    <script type="text/javascript">
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
                                        <asp:TextBox ID="tbMemberID" runat="server" CssClass="form-control" placeholder="ID" />
                                        <asp:Button ID="btnGO" runat="server" Text="GO" CssClass="btn btn-secondary" OnClick="BtnGO_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Account Status:</label>

                                    <div class="input-group">
                                        <asp:TextBox ID="tbMemberStatus" runat="server" CssClass="form-control" placeholder="Status" ReadOnly="true" />

                                        <asp:LinkButton CssClass="btn btn-success ms-1 rounded" ID="btnActive" runat="server" OnClick="BtnActiveStatus_Click">
                                            <i class="fa-solid fa-circle-check" ></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton CssClass="btn btn-warning ms-1 rounded" ID="btnPending" runat="server" OnClick="BtnPendingStatus_Click">
                                            <i class="fa-solid fa-circle-xmark"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton CssClass="btn btn-danger ms-1 rounded" ID="btnDeactivated" runat="server" OnClick="BtnDeactivetedStatus_Click">
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
                                    <asp:TextBox ID="tbFName" runat="server" CssClass="form-control" placeholder="First name" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Last name:</label>
                                    <asp:TextBox ID="tbLName" runat="server" CssClass="form-control" placeholder="Last name" ReadOnly="true" />
                                </div>
                            </div>
                        </div>


                        <!-- Date of birth and email address:-->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Date of birth:</label>
                                    <asp:TextBox ID="tbDOB" runat="server" CssClass="form-control" TextMode="Date" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Email address:</label>
                                    <asp:TextBox ID="tbEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email address" ReadOnly="true" />
                                </div>
                            </div>
                        </div>


                         <!-- State, city, and zip code:-->
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">State:</label>
                                    <asp:TextBox ID="tbState" runat="server" CssClass="form-control" placeholder="State" ReadOnly="true" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">City:</label>
                                    <asp:TextBox ID="tbCity" runat="server" CssClass="form-control" placeholder="City" ReadOnly="true" />
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group mb-2">
                                    <label class="bold-text">Zip Code:</label>
                                    <asp:TextBox ID="tbZipCode" runat="server" CssClass="form-control" placeholder="Zip Code" ReadOnly="true" />
                                </div>
                            </div>
                        </div>

                        <!-- Full address:-->
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label class="bold-text">Full address:</label>
                                    <asp:TextBox ID="tbFullAddress" runat="server" CssClass="form-control" placeholder="Full address" ReadOnly="true" />
                                </div>
                            </div>
                        </div>

                        <!-- Delete member button:-->
                        <div class="row">
                            <div class="col">
                                <asp:Button ID="btnDeleteAccount" runat="server" Text="Delete Member Permanently" CssClass="btn btn-danger btn-default" OnClick="BtnDeleteAccount_Click" />
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
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:libraryDBConnectionString %>" SelectCommand="SELECT member_id, first_name, last_name, dob, email, state, city, zipcode, full_address, account_status FROM [member_main_tbl]"></asp:SqlDataSource>

                            <div class="col">
                                <asp:GridView class="table table-striped table-boardered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="member_id" DataSourceID="SqlDataSource1">
                                    <Columns>
                                        <asp:BoundField DataField="member_id" HeaderText="Member ID" ReadOnly="True" SortExpression="member_id" />
                                        <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name" />
                                        <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name" />
                                        <asp:BoundField DataField="dob" HeaderText="Date of Birth" SortExpression="dob" />
                                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                                        <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" />
                                        <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                                        <asp:BoundField DataField="zipcode" HeaderText="Zip Code" SortExpression="zipcode" />
                                        <asp:BoundField DataField="full_address" HeaderText="Full Address" SortExpression="full_address" />
                                        <asp:BoundField DataField="account_status" HeaderText="Account Status" SortExpression="account_status" />
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
