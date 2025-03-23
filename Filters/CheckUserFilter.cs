// Filters/CheckUserFilter.cs
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Task4.Models;

namespace Task4.Filters
{
    public class CheckUserFilter : IAsyncActionFilter
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;

        public CheckUserFilter(UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
        }

        public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
        {
            // Skip this filter for Login and Register actions
            var actionName = context.ActionDescriptor.DisplayName;
            if (actionName.Contains("Login") || actionName.Contains("Register"))
            {
                await next();
                return;
            }

            if (context.HttpContext.User.Identity?.IsAuthenticated == true)
            {
                var user = await _userManager.GetUserAsync(context.HttpContext.User);
                if (user == null || user.IsBlocked)
                {
                    await _signInManager.SignOutAsync();
                    context.Result = new RedirectToActionResult("Login", "Account", null);
                    return;
                }
            }
            await next();
        }
    }
}