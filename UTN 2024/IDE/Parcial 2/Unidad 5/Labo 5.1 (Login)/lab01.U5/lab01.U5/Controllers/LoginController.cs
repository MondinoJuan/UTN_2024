using Microsoft.AspNetCore.Mvc;

namespace lab01.U5.Controllers
{
    public class LoginController : Controller
    {
        [HttpGet]
        public IActionResult Login()
        {
            ViewBag.Message = "No se ingresó nada";
            return View();
        }

        [HttpPost]
        public IActionResult Login(string username, string password)
        {
            if (username.ToLower() == "admin" && password == "admin")
            {
                ViewBag.Message = "Login exitoso";

                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Message = "Usuario o contraseña incorrectos";
                return View();
            }
        }

        [HttpGet]
        public IActionResult RecordarClave()
        {
            ViewBag.Message = "Es Ud. un usuario muy descuidado, haga memoria!";
            return View();
        }
    }
}
