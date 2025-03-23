using Microsoft.AspNetCore.Identity;
using System.Reflection.Emit;

namespace  Task4.Models
{
    public class ApplicationUser : IdentityUser
    {
        public DateTime? RegistrationTime { get; set; }
        public DateTime? LastLoginTime { get; set; }
        public bool IsBlocked { get; set; }
    }

}
