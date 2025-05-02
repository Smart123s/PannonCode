using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace halado_prog2.Migrations
{
    /// <inheritdoc />
    public partial class ReintroduceStoredCurrentPrice : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<decimal>(
                name: "CurrentPrice",
                table: "Cryptocurrencies",
                type: "decimal(18,8)",
                nullable: false,
                defaultValue: 0m);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CurrentPrice",
                table: "Cryptocurrencies");
        }
    }
}
