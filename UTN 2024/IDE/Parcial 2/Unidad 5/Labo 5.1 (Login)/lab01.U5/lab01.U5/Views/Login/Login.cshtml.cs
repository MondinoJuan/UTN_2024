using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;

namespace lab01.U5.Views.Login
{
    public class LoginModel : PageModel
    {
        [BindProperty]
        public string Username { get; set; }

        [BindProperty]
        public string Password { get; set; }

        public string Message { get; set; }

        public void OnGet()
        {
            Message = "No se ingreso nada";
        }

        public IActionResult OnPostIngresar()
        {
            if (Username.ToLower() == "admin" && Password == "admin")
            {
                Message = "Ingreso OK.";
            }
            else
            {
                Message = "Usuario y/o contraseña incorrectos.";
            }

            // Devuelve la misma página con el mensaje de resultado
            return Page();
        }
    }
}
