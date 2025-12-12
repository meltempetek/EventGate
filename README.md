# EventGate - Projeyi Localhost'ta Çalıştırma Kılavuzu

## Gereksinimler
- Visual Studio 2017 veya üzeri
- .NET Framework 4.8
- SQL Server LocalDB (MSSQLLocalDB)
- IIS Express (Visual Studio ile birlikte gelir)

## Kurulum Adımları

### 1. Visual Studio ile Projeyi Açma
1. `EventDeneme.sln` dosyasını Visual Studio ile açın
2. Visual Studio projeyi otomatik olarak yükleyecektir

### 2. NuGet Paketlerini Geri Yükleme
1. Visual Studio'da **Tools** > **NuGet Package Manager** > **Package Manager Console** açın
2. Şu komutu çalıştırın:
   ```
   Update-Package -reinstall
   ```
   Veya Solution Explorer'da projeye sağ tıklayıp **Restore NuGet Packages** seçeneğini kullanın

### 3. Veritabanını Hazırlama
Proje LocalDB kullanıyor. Veritabanını oluşturmak için:

**Seçenek A: SQL Script ile (Önerilen)**
1. SQL Server Management Studio (SSMS) veya Visual Studio'dan SQL Server Object Explorer'ı açın
2. `(localdb)\MSSQLLocalDB` sunucusuna bağlanın
3. `EventDeneme\Models\pr2.edmx.sql` dosyasını açın ve çalıştırın
4. Bu script `pr2` veritabanını oluşturacaktır

**Seçenek B: Entity Framework ile**
- Proje ilk çalıştırıldığında Entity Framework otomatik olarak veritabanını oluşturabilir (eğer Code First yaklaşımı kullanılıyorsa)

### 4. Projeyi Çalıştırma

**Visual Studio'dan:**
1. Visual Studio'da **F5** tuşuna basın veya
2. Toolbar'dan **Start Debugging** (yeşil play butonu) butonuna tıklayın
3. Proje otomatik olarak IIS Express'te başlayacak
4. Tarayıcı otomatik olarak açılacak (genellikle `http://localhost:60053/`)

**Not:** İlk çalıştırmada Visual Studio port numarasını değiştirebilir. Tarayıcıda görünen URL'yi kullanın.

### 5. Veritabanı Bağlantı Sorunları

Eğer veritabanı bağlantı hatası alırsanız:

1. **LocalDB'nin çalıştığını kontrol edin:**
   ```powershell
   sqllocaldb info MSSQLLocalDB
   ```

2. **Web.config dosyasındaki connection string'i kontrol edin:**
   - `EventDeneme\Web.config` dosyasında `connectionStrings` bölümünü kontrol edin
   - Varsayılan bağlantı: `(localdb)\MSSQLLocalDB`

3. **Veritabanını manuel oluşturun:**
   - SQL Server Object Explorer'dan `(localdb)\MSSQLLocalDB` sunucusuna bağlanın
   - Yeni veritabanı oluşturun: `pr2`
   - `pr2.edmx.sql` scriptini çalıştırın

## Proje Yapısı

- **Controllers/**: MVC Controller'ları
- **Views/**: Razor view dosyaları (.cshtml)
- **Models/**: Entity Framework modelleri ve veritabanı context'i
- **Content/**: CSS dosyaları
- **Scripts/**: JavaScript dosyaları
- **images/**: Görsel dosyalar

## Varsayılan Port

Proje varsayılan olarak `http://localhost:60053/` adresinde çalışır. Port numarası Visual Studio tarafından otomatik atanır ve değişebilir.

## Sorun Giderme

### "Cannot connect to database" hatası
- LocalDB servisinin çalıştığından emin olun
- Connection string'i kontrol edin
- Veritabanının oluşturulduğundan emin olun

### "Package restore failed" hatası
- NuGet paketlerini manuel olarak geri yükleyin
- Internet bağlantınızı kontrol edin

### Port zaten kullanımda hatası
- Visual Studio proje ayarlarından farklı bir port seçin
- Veya o portu kullanan uygulamayı kapatın

## İletişim

Sorun yaşarsanız, proje dosyalarını ve hata mesajlarını kontrol edin.

