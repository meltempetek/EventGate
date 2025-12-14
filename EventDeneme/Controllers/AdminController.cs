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
            
            ViewBag.Title = "Venues";
            var venues = db.venues
                .Include("cities")
                .OrderBy(v => v.name)
                .ToList();
            
            return View(venues);
        }

        // Add Venue
        public ActionResult AddVenue()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            ViewBag.Title = "Add Venue";
            ViewBag.Cities = db.cities.OrderBy(c => c.name).ToList();
            
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddVenue(venues newVenue)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            if (ModelState.IsValid)
            {
                db.venues.Add(newVenue);
                db.SaveChanges();
                
                TempData["Success"] = "Mekan başarıyla eklendi.";
                return RedirectToAction("Venues");
            }
            
            ViewBag.Title = "Add Venue";
            ViewBag.Cities = db.cities.OrderBy(c => c.name).ToList();
            ViewBag.Error = "Lütfen tüm gerekli alanları doldurun.";
            
            return View(newVenue);
        }

        // Edit Venue
        public ActionResult EditVenue(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var venue = db.venues.Find(id);
            if (venue == null)
            {
                TempData["Error"] = "Mekan bulunamadı.";
                return RedirectToAction("Venues");
            }
            
            ViewBag.Title = "Edit Venue";
            ViewBag.Cities = db.cities.OrderBy(c => c.name).ToList();
            
            return View(venue);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditVenue(venues updatedVenue)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            if (ModelState.IsValid)
            {
                var venue = db.venues.Find(updatedVenue.id);
                if (venue == null)
                {
                    TempData["Error"] = "Mekan bulunamadı.";
                    return RedirectToAction("Venues");
                }
                
                venue.name = updatedVenue.name;
                venue.city_id = updatedVenue.city_id;
                venue.address = updatedVenue.address;
                venue.latitude = updatedVenue.latitude;
                venue.longitude = updatedVenue.longitude;
                venue.has_seating = updatedVenue.has_seating;
                
                db.SaveChanges();
                
                TempData["Success"] = "Mekan başarıyla güncellendi.";
                return RedirectToAction("Venues");
            }
            
            ViewBag.Title = "Edit Venue";
            ViewBag.Cities = db.cities.OrderBy(c => c.name).ToList();
            ViewBag.Error = "Lütfen tüm gerekli alanları doldurun.";
            
            return View(updatedVenue);
        }

        // Delete Venue
        [HttpPost]
        public ActionResult DeleteVenue(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var venue = db.venues.Find(id);
            if (venue == null)
            {
                TempData["Error"] = "Mekan bulunamadı.";
                return RedirectToAction("Venues");
            }
            
            // Performansları kontrol et
            if (venue.performances != null && venue.performances.Any())
            {
                TempData["Error"] = "Bu mekana ait performanslar bulunduğu için silinemez. Önce performansları silin.";
                return RedirectToAction("Venues");
            }
            
            // Seatmaps ve seats kontrolü
            if ((venue.seatmaps != null && venue.seatmaps.Any()) || 
                (venue.seats != null && venue.seats.Any()))
            {
                TempData["Error"] = "Bu mekana ait koltuk haritaları veya koltuklar bulunduğu için silinemez. Önce bunları silin.";
                return RedirectToAction("Venues");
            }
            
            db.venues.Remove(venue);
            db.SaveChanges();
            
            TempData["Success"] = "Mekan başarıyla silindi.";
            return RedirectToAction("Venues");
        }

        // 5. Users Management (admin-users.html)
        public ActionResult Users()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            ViewBag.Title = "Users";
            var users = db.users
                .OrderByDescending(u => u.created_at)
                .ToList();
            
            return View(users);
        }

        // Edit User
        public ActionResult EditUser(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var user = db.users.Find(id);
            if (user == null)
            {
                TempData["Error"] = "Kullanıcı bulunamadı.";
                return RedirectToAction("Users");
            }
            
            ViewBag.Title = "Edit User";
            
            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditUser(users updatedUser, string newPassword)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            if (ModelState.IsValid)
            {
                var user = db.users.Find(updatedUser.id);
                if (user == null)
                {
                    TempData["Error"] = "Kullanıcı bulunamadı.";
                    return RedirectToAction("Users");
                }
                
                user.name = updatedUser.name;
                user.surname = updatedUser.surname;
                user.email = updatedUser.email;
                user.phone = updatedUser.phone;
                
                // Şifre değiştirilmek isteniyorsa
                if (!string.IsNullOrEmpty(newPassword))
                {
                    user.password_hash = HashPassword(newPassword);
                }
                
                user.updated_at = DateTime.Now;
                
                db.SaveChanges();
                
                TempData["Success"] = "Kullanıcı başarıyla güncellendi.";
                return RedirectToAction("Users");
            }
            
            ViewBag.Title = "Edit User";
            ViewBag.Error = "Lütfen tüm gerekli alanları doldurun.";
            
            return View(updatedUser);
        }

        // Delete User
        [HttpPost]
        public ActionResult DeleteUser(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var user = db.users.Find(id);
            if (user == null)
            {
                TempData["Error"] = "Kullanıcı bulunamadı.";
                return RedirectToAction("Users");
            }
            
            // İlişkili kayıtları kontrol et
            if ((user.carts != null && user.carts.Any()) ||
                (user.orders != null && user.orders.Any()) ||
                (user.sessions != null && user.sessions.Any()) ||
                (user.user_payment_methods != null && user.user_payment_methods.Any()))
            {
                TempData["Error"] = "Bu kullanıcıya ait sepet, sipariş, oturum veya ödeme yöntemi kayıtları bulunduğu için silinemez.";
                return RedirectToAction("Users");
            }
            
            db.users.Remove(user);
            db.SaveChanges();
            
            TempData["Success"] = "Kullanıcı başarıyla silindi.";
            return RedirectToAction("Users");
        }

        // 6. Tickets Management (admin-tickets.html)
        public ActionResult Tickets()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            ViewBag.Title = "Tickets";
            var tickets = db.tickets
                .Include("order_items")
                .Include("order_items.orders")
                .Include("order_items.orders.users")
                .OrderByDescending(t => t.issued_at)
                .ToList();
            
            return View(tickets);
        }

        // Update Ticket Status
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UpdateTicketStatus(long id, string status)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var ticket = db.tickets.Find(id);
            if (ticket == null)
            {
                TempData["Error"] = "Bilet bulunamadı.";
                return RedirectToAction("Tickets");
            }
            
            ticket.status = status;
            db.SaveChanges();
            
            TempData["Success"] = "Bilet durumu başarıyla güncellendi.";
            return RedirectToAction("Tickets");
        }

        // 7. Refunds Management (admin-refunds.html)
        public ActionResult Refunds()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            ViewBag.Title = "Refunds";
            var refunds = db.refunds
                .Include("payments")
                .Include("payments.orders")
                .Include("payments.orders.users")
                .OrderByDescending(r => r.id)
                .ToList();
            
            return View(refunds);
        }

        // Process Refund (Approve)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ProcessRefund(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var refund = db.refunds.Find(id);
            if (refund == null)
            {
                TempData["Error"] = "İade talebi bulunamadı.";
                return RedirectToAction("Refunds");
            }
            
            if (refund.status.ToLower() != "pending")
            {
                TempData["Error"] = "Bu iade talebi zaten işlenmiş.";
                return RedirectToAction("Refunds");
            }
            
            refund.status = "processed";
            refund.processed_at = DateTime.Now;
            db.SaveChanges();
            
            TempData["Success"] = "İade talebi başarıyla onaylandı ve işlendi.";
            return RedirectToAction("Refunds");
        }

        // Reject Refund
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RejectRefund(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var refund = db.refunds.Find(id);
            if (refund == null)
            {
                TempData["Error"] = "İade talebi bulunamadı.";
                return RedirectToAction("Refunds");
            }
            
            if (refund.status.ToLower() != "pending")
            {
                TempData["Error"] = "Bu iade talebi zaten işlenmiş.";
                return RedirectToAction("Refunds");
            }
            
            refund.status = "rejected";
            refund.processed_at = DateTime.Now;
            db.SaveChanges();
            
            TempData["Success"] = "İade talebi reddedildi.";
            return RedirectToAction("Refunds");
        }

        // 8. Organizers Management (admin-organizers.html)
        public ActionResult Organizers()
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            ViewBag.Title = "Organizers";
            var applications = db.organizer_applications
                .Include("admins")
                .Include("organizers")
                .OrderByDescending(a => a.submitted_at)
                .ToList();
            
            return View(applications);
        }

        // Organizer Application Detail
        public ActionResult OrganizerApplicationDetail(long id)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var application = db.organizer_applications
                .Include("admins")
                .Include("organizers")
                .FirstOrDefault(a => a.id == id);
            
            if (application == null)
            {
                TempData["Error"] = "Başvuru bulunamadı.";
                return RedirectToAction("Organizers");
            }
            
            ViewBag.Title = "Organizer Application Detail";
            
            // Başvuruya ait belgeleri getir
            var documents = db.organizer_documents
                .Where(d => d.application_id == id)
                .ToList();
            
            ViewBag.Documents = documents;
            
            return View(application);
        }

        // Accept Organizer Application
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AcceptOrganizerApplication(long id, string reviewNotes)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var application = db.organizer_applications.Find(id);
            if (application == null)
            {
                TempData["Error"] = "Başvuru bulunamadı.";
                return RedirectToAction("Organizers");
            }
            
            if (application.status.ToLower() != "pending")
            {
                TempData["Error"] = "Bu başvuru zaten işlenmiş.";
                return RedirectToAction("Organizers");
            }
            
            // Yeni organizer kaydı oluştur
            var organizer = new organizers
            {
                legal_name = application.org_name,
                brand_name = application.org_name,
                contact_email = application.contact_email,
                status = "active",
                created_at = DateTime.Now
            };
            
            db.organizers.Add(organizer);
            db.SaveChanges();
            
            // Başvuruyu güncelle
            application.status = "approved";
            application.organizer_id = organizer.id;
            application.reviewed_by_admin_id = (long)Session["AdminID"];
            application.review_notes = reviewNotes;
            application.decided_at = DateTime.Now;
            
            db.SaveChanges();
            
            TempData["Success"] = "Organizatör başvurusu başarıyla onaylandı.";
            return RedirectToAction("Organizers");
        }

        // Reject Organizer Application
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RejectOrganizerApplication(long id, string reviewNotes)
        {
            if (!IsAdminLoggedIn()) return RedirectToAction("Login");
            
            var application = db.organizer_applications.Find(id);
            if (application == null)
            {
                TempData["Error"] = "Başvuru bulunamadı.";
                return RedirectToAction("Organizers");
            }
            
            if (application.status.ToLower() != "pending")
            {
                TempData["Error"] = "Bu başvuru zaten işlenmiş.";
                return RedirectToAction("Organizers");
            }
            
            // Başvuruyu reddet
            application.status = "rejected";
            application.reviewed_by_admin_id = (long)Session["AdminID"];
            application.review_notes = reviewNotes;
            application.decided_at = DateTime.Now;
            
            db.SaveChanges();
            
            TempData["Success"] = "Organizatör başvurusu reddedildi.";
            return RedirectToAction("Organizers");
        }

    }
}

