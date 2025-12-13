using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;
using EventDeneme.Models;
using System.Data.Entity;

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
            
            ViewBag.Title = "Events";
            var events = db.events
                .Include("categories")
                .Include("organizers")
                .OrderByDescending(e => e.created_at)
                .ToList();
            
            return View(events);
        }

        // Add Event
        public ActionResult AddEvent()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            ViewBag.Title = "Add Event";
            ViewBag.Categories = db.categories.ToList();
            ViewBag.Organizers = db.organizers
                .Select(o => new { 
                    id = o.id, 
                    name = !string.IsNullOrEmpty(o.brand_name) ? o.brand_name : o.legal_name 
                })
                .ToList();
            
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddEvent(events newEvent)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            if (ModelState.IsValid)
            {
                newEvent.created_at = DateTime.Now;
                newEvent.updated_at = DateTime.Now;
                if (string.IsNullOrEmpty(newEvent.status))
                    newEvent.status = "pending";
                
                db.events.Add(newEvent);
                db.SaveChanges();
                
                TempData["Success"] = "Etkinlik başarıyla eklendi.";
                return RedirectToAction("Events");
            }
            
            ViewBag.Title = "Add Event";
            ViewBag.Categories = db.categories.ToList();
            ViewBag.Organizers = db.organizers
                .Select(o => new { 
                    id = o.id, 
                    name = !string.IsNullOrEmpty(o.brand_name) ? o.brand_name : o.legal_name 
                })
                .ToList();
            ViewBag.Error = "Lütfen tüm gerekli alanları doldurun.";
            
            return View(newEvent);
        }

        // Edit Event
        public ActionResult EditEvent(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var eventItem = db.events.Find(id);
            if (eventItem == null)
            {
                TempData["Error"] = "Etkinlik bulunamadı.";
                return RedirectToAction("Events");
            }
            
            ViewBag.Title = "Edit Event";
            ViewBag.Categories = db.categories.ToList();
            ViewBag.Organizers = db.organizers
                .Select(o => new { 
                    id = o.id, 
                    name = !string.IsNullOrEmpty(o.brand_name) ? o.brand_name : o.legal_name 
                })
                .ToList();
            
            return View(eventItem);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditEvent(events updatedEvent)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            if (ModelState.IsValid)
            {
                var eventItem = db.events.Find(updatedEvent.id);
                if (eventItem == null)
                {
                    TempData["Error"] = "Etkinlik bulunamadı.";
                    return RedirectToAction("Events");
                }
                
                eventItem.title = updatedEvent.title;
                eventItem.description = updatedEvent.description;
                eventItem.category_id = updatedEvent.category_id;
                eventItem.organizer_id = updatedEvent.organizer_id;
                eventItem.language = updatedEvent.language;
                eventItem.age_limit = updatedEvent.age_limit;
                eventItem.poster_url = updatedEvent.poster_url;
                eventItem.status = updatedEvent.status;
                eventItem.updated_at = DateTime.Now;
                
                db.SaveChanges();
                
                TempData["Success"] = "Etkinlik başarıyla güncellendi.";
                return RedirectToAction("Events");
            }
            
            ViewBag.Title = "Edit Event";
            ViewBag.Categories = db.categories.ToList();
            ViewBag.Organizers = db.organizers
                .Select(o => new { 
                    id = o.id, 
                    name = !string.IsNullOrEmpty(o.brand_name) ? o.brand_name : o.legal_name 
                })
                .ToList();
            ViewBag.Error = "Lütfen tüm gerekli alanları doldurun.";
            
            return View(updatedEvent);
        }

        // Delete Event
        [HttpPost]
        public ActionResult DeleteEvent(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var eventItem = db.events.Find(id);
            if (eventItem == null)
            {
                TempData["Error"] = "Etkinlik bulunamadı.";
                return RedirectToAction("Events");
            }
            
            // Performansları kontrol et
            if (eventItem.performances != null && eventItem.performances.Any())
            {
                TempData["Error"] = "Bu etkinliğe ait performanslar bulunduğu için silinemez. Önce performansları silin.";
                return RedirectToAction("Events");
            }
            
            db.events.Remove(eventItem);
            db.SaveChanges();
            
            TempData["Success"] = "Etkinlik başarıyla silindi.";
            return RedirectToAction("Events");
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

