using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

namespace asp_identity.Models;

public class User : IdentityUser<uint>
{
    [Column(TypeName = "varchar(100)")]
    [MaxLength(100)]
    public string? FirstName { get; set; }

    [Column(TypeName = "varchar(100)")]
    [MaxLength(100)]
    public string? LastName { get; set; }

    public bool IsActive { get; set; } = true;
    public DateTime CreatedOn { get; set; }
    public DateTime? ModifiedOn { get; set; }
    public DateTime? InactiveDateTime { get; set; }
}

public class UserLogin : IdentityUserLogin<uint>
{
}

public class UserRole : IdentityUserRole<uint>
{
}

public class UserClaim : IdentityUserClaim<uint>
{
}

public class Role : IdentityRole<uint>
{
}

public class RoleClaim : IdentityRoleClaim<uint>
{
}

public class UserToken : IdentityUserToken<uint>
{
}