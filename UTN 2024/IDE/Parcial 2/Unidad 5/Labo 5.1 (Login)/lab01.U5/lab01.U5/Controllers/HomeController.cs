using lab01.U5.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace lab01.U5.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
            //return RedirectToAction("Login");
        }

        public IActionResult Privacy()
        {
            return View();
        }
        
        public IActionResult Login()
        {
            //return View("Login");
            //return View();
            return View("/Views/Login/Login.cshtml");
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
