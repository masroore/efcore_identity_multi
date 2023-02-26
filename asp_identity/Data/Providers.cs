namespace asp_identity.Data;

public record Providers(string Name, string ConnectionStringName)
{
    public static readonly Providers SqliteProvider = new("sqlite", "sqlite");
    public static readonly Providers MySqlProvider = new("mysql", "mysql");
    public static readonly Providers PostgresProvider = new("pgsql", "pgsql");
    public static readonly Providers SqlServerProvider = new("mssql", "mssql");
}