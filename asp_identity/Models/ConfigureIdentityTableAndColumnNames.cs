using Microsoft.EntityFrameworkCore;

namespace asp_identity.Models;

public static class ConfigureIdentityTableAndColumnNames
{
    public static void ConvertIdentityToPostgresSQLNamingConventions(this ModelBuilder builder)
    {
        builder.Entity<User>(entity => { entity.ToTable("users"); });

        builder.Entity<Role>(entity => { entity.ToTable("roles"); });

        builder.Entity<UserRole>(entity => { entity.ToTable("user_roles"); });

        builder.Entity<UserToken>(entity => { entity.ToTable("user_tokens"); });

        builder.Entity<UserLogin>(entity => { entity.ToTable("user_logins"); });

        builder.Entity<RoleClaim>(entity => { entity.ToTable("role_claims"); });

        builder.Entity<UserClaim>(entity => { entity.ToTable("user_claims"); });
    }
}