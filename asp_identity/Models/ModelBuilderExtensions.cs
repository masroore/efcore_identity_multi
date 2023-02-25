using System.Text.RegularExpressions;
using Humanizer;
using Microsoft.EntityFrameworkCore;

namespace asp_identity.Models;

public static class ModelBuilderExtensions
{
    private static readonly Regex RegexKeys = new("^(PK|FK|IX)_", RegexOptions.Compiled);

    public static void UseSnakeCaseNames(this ModelBuilder modelBuilder)
    {
        foreach (var table in modelBuilder.Model.GetEntityTypes())
        {
            var name = ConvertGeneralToSnake(table.GetTableName());
            if (name.StartsWith("asp_net_")) name = name.Replace("asp_net_", string.Empty);
            // table.SetSchema("identity");
            table.SetTableName(name);

            foreach (var property in table.GetProperties())
                property.SetColumnName(ConvertGeneralToSnake(property.GetColumnName()));

            foreach (var primaryKey in table.GetKeys()) primaryKey.SetName(ConvertKeyToSnake(primaryKey.GetName()));

            foreach (var foreignKey in table.GetForeignKeys())
                foreignKey.SetConstraintName(ConvertKeyToSnake(foreignKey.GetConstraintName()));

            foreach (var indexKey in table.GetIndexes())
            {
                var s = indexKey.Name;
                if (string.IsNullOrEmpty(s))
                {
                    s = string.Join('_', new List<string>
                    {
                        indexKey.IsUnique ? "AK" : "IX",
                        indexKey.DeclaringEntityType.Name.Split('.').Last().Pluralize(),
                        indexKey.Properties.First().GetColumnName()
                    });
                }

                indexKey.SetDatabaseName(ConvertKeyToSnake(s));
            }
        }
    }

    private static string ConvertKeyToSnake(string? keyName)
    {
        return ConvertGeneralToSnake(RegexKeys.Replace(keyName ?? "", match => match.Value.ToLower()));
    }

    private static string ConvertGeneralToSnake(string? entityName)
    {
        return SnakeCaseNameConverter.Convert(entityName ?? "");
    }
}