using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Construction.Migrations
{
    /// <inheritdoc />
    public partial class MyTotalContractCost : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<decimal>(
                name: "MyTotalContractCost",
                table: "ConstructionSites",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "MyTotalContractCost",
                table: "ConstructionSites");
        }
    }
}
