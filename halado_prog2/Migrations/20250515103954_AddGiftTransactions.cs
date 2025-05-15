using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace halado_prog2.Migrations
{
    /// <inheritdoc />
    public partial class AddGiftTransactions : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "GiftTransactions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SenderUserId = table.Column<int>(type: "int", nullable: false),
                    ReceiverUserId = table.Column<int>(type: "int", nullable: false),
                    CryptoId = table.Column<int>(type: "int", nullable: false),
                    Quantity = table.Column<decimal>(type: "decimal(18,8)", nullable: false),
                    PriceAtGifting = table.Column<decimal>(type: "decimal(18,8)", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ResolvedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GiftTransactions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_GiftTransactions_Cryptocurrencies_CryptoId",
                        column: x => x.CryptoId,
                        principalTable: "Cryptocurrencies",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_GiftTransactions_Users_ReceiverUserId",
                        column: x => x.ReceiverUserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_GiftTransactions_Users_SenderUserId",
                        column: x => x.SenderUserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_GiftTransactions_CryptoId",
                table: "GiftTransactions",
                column: "CryptoId");

            migrationBuilder.CreateIndex(
                name: "IX_GiftTransactions_ReceiverUserId",
                table: "GiftTransactions",
                column: "ReceiverUserId");

            migrationBuilder.CreateIndex(
                name: "IX_GiftTransactions_SenderUserId",
                table: "GiftTransactions",
                column: "SenderUserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "GiftTransactions");
        }
    }
}
