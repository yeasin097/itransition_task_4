// Controllers/AdminController.cs
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Task4.Models;


namespace Task4.Controllers
{
    [Authorize]
    public class AdminController : Controller
    {
        private readonly UserManager<ApplicationUser> _userManager;

        public AdminController(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }

        public async Task<IActionResult> Index()
        {
            var users = await _userManager.Users
                .OrderByDescending(u => u.LastLoginTime.HasValue ? u.LastLoginTime : DateTime.MinValue) // Requirement 3: Sort by LastLoginTime
                .ToListAsync();
            return View(users);
        }

        [HttpPost]
        public async Task<IActionResult> BlockUsers(List<string> selectedUsers)
        {
            foreach (var userId in selectedUsers)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    user.IsBlocked = true;
                    await _userManager.UpdateAsync(user);
                }
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<IActionResult> UnblockUsers(List<string> selectedUsers)
        {
            foreach (var userId in selectedUsers)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    user.IsBlocked = false;
                    await _userManager.UpdateAsync(user);
                }
            }
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<IActionResult> DeleteUsers(List<string> selectedUsers)
        {
            foreach (var userId in selectedUsers)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    await _userManager.DeleteAsync(user);
                }
            }
            return RedirectToAction("Index");
        }
    }
}