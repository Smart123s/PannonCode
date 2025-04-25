using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FishingShop.Migrations
{
    /// <inheritdoc />
    public partial class CustomersTotalOrders : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "TotalOrders",
                table: "Customers",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "TotalOrders",
                table: "Customers");
        }
    }
}
