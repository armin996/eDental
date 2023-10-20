using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace DentalOffice.Entities.Migrations
{
    /// <inheritdoc />
    public partial class newMig : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CardNumber",
                table: "Payments");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CardNumber",
                table: "Payments",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 1,
                column: "CardNumber",
                value: "1293810284902028");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 2,
                column: "CardNumber",
                value: "1293810254132028");

            migrationBuilder.UpdateData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 3,
                column: "CardNumber",
                value: "1293810254132028");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "XkZ21Ztm+PfvzKPXQkei8DJPwdk=", "4dyfgblPuF1s79sPYeBmbg==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "If1RYS6HTHMGaTOsyG2Aor674oU=", "+Wglz2MJUWQjKaqd3YoaVQ==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "v/IG2csQ+hjldtDgGlfbbahm+AE=", "UA/ItD5hKjPQfkUUW0nEpw==" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "WG39BE5ZQykYaCuUfQh312qnQZA=", "FmUOuMvqs2WHctYnIepwlg==" });
        }
    }
}
