dotnet ef migrations add --context asp_identity.Data.ApplicationDbContext identity --output-dir Migrations
dotnet ef migrations script -o Migrations/ddl.sql