using System.Configuration;
using Microsoft.EntityFrameworkCore;

namespace asp_identity.Data;

using static Providers;

public static class ProviderExtensions
{
    public static void AddDatabaseProvider<TContext>(this WebApplicationBuilder builder) where TContext : DbContext
    {
        var config = builder.Configuration;

        var provider = config.GetValue("DatabaseProvider", SqliteProvider.Name)!.ToLowerInvariant();
        
        if (provider == SqliteProvider.Name)
        {
            builder.Services.AddDbContext<TContext>(options =>
                options.UseSqlite(config.GetConnectionString(SqliteProvider.ConnectionStringName)!));
        }
        else if (provider == MySqlProvider.Name)
        {
            builder.Services.AddDbContext<TContext>(options =>
                options.UseMySQL(config.GetConnectionString(MySqlProvider.ConnectionStringName)!));
        }
        else if (provider == PostgresProvider.Name)
        {
            builder.Services.AddDbContext<TContext>(options =>
                options.UseNpgsql(config.GetConnectionString(PostgresProvider.ConnectionStringName)!));
        }
        else if (provider == SqlServerProvider.Name)
        {
            builder.Services.AddDbContext<TContext>(options =>
                options.UseSqlServer(config.GetConnectionString(SqlServerProvider.ConnectionStringName)!));
        }
        else
        {
            throw new ConfigurationErrorsException($"Invalid database provider: {provider}");
        }
    }
}