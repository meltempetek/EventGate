using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using EventDeneme.Models;

namespace EventDeneme.Controllers
{
    public class AdminController : Controller
    {
        private pr2Entities1 db = new pr2Entities1();

        // Admin route - /admin URL'ini Login'e yönlendir
        public ActionResult Index()
        {
            if (IsAdminLoggedIn()) return RedirectToAction("Dashboard");
            return RedirectToAction("Login");
        }

        // Admin Auth Helper
        private bool IsAdminLoggedIn()
        {
            return Session["AdminID"] != null;
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        private bool VerifyPassword(string hashedPassword, string providedPassword)
        {
            if (string.IsNullOrEmpty(hashedPassword) || string.IsNullOrEmpty(providedPassword))
                return false;

            // SHA256 hash formatı için (proje standardı)
            return HashPassword(providedPassword) == hashedPassword;
        }

        // 1. Admin Login (admin-login.html)
        public ActionResult Login()
        {
            if (IsAdminLoggedIn()) return RedirectToAction("Dashboard");
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string password)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ViewBag.Error = "Username and password are required";
                return View();
            }

            var admin = db.admins.FirstOrDefault(a => a.username == username);

            if (admin != null && VerifyPassword(admin.password_hash, password))
            {
                Session["AdminID"] = admin.id;
                Session["AdminRole"] = admin.role;
                Session["AdminName"] = admin.username;
                return RedirectToAction("Dashboard");
            }

            ViewBag.Error = "Invalid credentials";
            return View();
        }

        public ActionResult Logout()
        {
            Session.Remove("AdminID");
            Session.Remove("AdminRole");
            Session.Remove("AdminName");
            return RedirectToAction("Login");
        }

        // 2. Dashboard (admin-dashboard.html)
        public ActionResult Dashboard()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");

            ViewBag.Title = "Dashboard";
            
            // Temel İstatistikler
            ViewBag.TotalEvents = db.events.Count();
            ViewBag.TotalUsers = db.users.Count();
            ViewBag.TotalOrganizers = db.organizers.Count();
            ViewBag.TotalVenues = db.venues.Count();
            ViewBag.TotalTickets = db.tickets.Count();
            ViewBag.TotalOrders = db.orders.Count();
            
            // Finansal İstatistikler
            ViewBag.TotalRevenue = db.orders
                .Where(o => o.status == "completed" || o.status == "paid")
                .Sum(o => (decimal?)o.total_amount) ?? 0;
            
            ViewBag.PendingOrders = db.orders
                .Count(o => o.status == "pending" || o.status == "processing");
            
            // İade İstatistikleri
            ViewBag.PendingRefunds = db.refunds
                .Count(r => r.status == "pending");
            
            ViewBag.TotalRefunds = db.refunds.Count();
            ViewBag.TotalRefundAmount = db.refunds
                .Where(r => r.status == "processed" || r.status == "completed")
                .Sum(r => (decimal?)r.amount) ?? 0;
            
            // Son 7 gün içinde yeni kayıtlar
            DateTime lastWeek = DateTime.Now.AddDays(-7);
            ViewBag.NewUsersThisWeek = db.users
                .Count(u => u.created_at.HasValue && u.created_at.Value >= lastWeek);
            
            ViewBag.NewEventsThisWeek = db.events
                .Count(e => e.created_at.HasValue && e.created_at.Value >= lastWeek);
            
            ViewBag.NewOrdersThisWeek = db.orders
                .Count(o => o.created_at.HasValue && o.created_at.Value >= lastWeek);
            
            return View();
        }

        // 3. Events Management (admin-events.html)
        public ActionResult Events()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            return View(db.events.ToList());
        }

        // 4. Venues Management (admin-venues.html)
        public ActionResult Venues()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            return View(db.venues.ToList());
        }

        // 5. Users Management (admin-users.html)
        public ActionResult Users()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            return View(db.users.ToList());
        }

        // 6. Tickets Management (admin-tickets.html)
        public ActionResult Tickets()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            return View(db.tickets.ToList());
        }

        // 7. Refunds Management (admin-refunds.html)
        public ActionResult Refunds()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            return View(db.refunds.ToList());
        }

        // 8. Organizers Management (admin-organizers.html)
        public ActionResult Organizers()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            return View(db.organizers.ToList());
        }

    }
}

