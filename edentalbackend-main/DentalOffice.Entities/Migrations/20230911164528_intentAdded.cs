using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DentalOffice.Entities.Migrations
{
    /// <inheritdoc />
    public partial class intentAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 1,
                column: "PaymentIntent",
                value: "pi_das3142352dsa");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 2,
                column: "PaymentIntent",
                value: "pi_s3d42fgdw3rfs");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 3,
                column: "PaymentIntent",
                value: "pi_vvc343737vcjsjds");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "9SgDtwiPZBRWc7e/lTEkdbSb1t4=", "H7RiExkVBi1rFxv2dWewxg==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M6TO59PZMWxdNSJFEiKfcM42ys0=", "BNPyfPBK8amveJoyKYQuJQ==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "JotO38nG5qyDci4vxwARaFNZ9Gs=", "NvhYTRRRmivDoGt6jRtFUg==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "f12aYlY6Sd9uM4MNDVJ/BeR+Cck=", "8bOpX1HA5cYK1U8Mh8LktQ==" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 1,
                column: "PaymentIntent",
                value: "");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 2,
                column: "PaymentIntent",
                value: "");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 3,
                column: "PaymentIntent",
                value: "");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "Q4W0XRNneTDjOhoTZZ7DOff6ShI=", "2iBL6d5Stdzwe9ewpw1xdA==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "A5AILs45tvgKeNQSNvd0RKjrZFI=", "pQEFAgC7PBCzTknRnuM/Tg==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "jy+OKOA452qn3/v7owabAav5zy0=", "trDTOuskQLT8ApaOBpPjcQ==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "hHjkubGZ/5jYzlfDntKH43u72BU=", "+VtqXxBJVr18wxikotB0TA==" });
        }
    }
}
