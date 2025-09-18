# 🎨 Assets

Bu klasör Mouse Control projesinin görsel materyallerini içerir.

## 📁 İçerik

### İkonlar
- `icon-16.png` - 16x16 sistem tray ikonu
- `icon-32.png` - 32x32 uygulama ikonu
- `icon-128.png` - 128x128 uygulama ikonu
- `icon-256.png` - 256x256 uygulama ikonu
- `icon-512.png` - 512x512 uygulama ikonu

### Ekran Görüntüleri
- `screenshot-menubar.png` - Sistem trayindeki ikon
- `screenshot-accessibility.png` - Accessibility izin ekranı
- `screenshot-spaces.png` - Space'ler arası geçiş
- `screenshot-settings.png` - Sistem ayarları

### Demo Materyalleri
- `demo.gif` - Uygulamanın çalışmasını gösteren GIF
- `demo-video.mp4` - Detaylı demo videosu

### Logo ve Branding
- `logo.png` - Ana logo
- `logo-dark.png` - Karanlık tema logo
- `banner.png` - GitHub banner
- `social-preview.png` - Sosyal medya önizleme

## 📝 Kullanım

Bu görseller aşağıdaki yerlerde kullanılabilir:

- GitHub README
- Proje dokümantasyonu  
- Sosyal medya paylaşımları
- App Store (gelecekte)
- Web sitesi (gelecekte)

## 📏 Boyutlar

### İkonlar
- **16x16**: Sistem tray
- **32x32**: Küçük uygulama ikonu
- **128x128**: Orta uygulama ikonu
- **256x256**: Büyük uygulama ikonu
- **512x512**: Retina ekranlar

### Ekran Görüntüleri
- **Standart**: 1440x900 (MacBook Air)
- **Retina**: 2880x1800 (MacBook Pro)
- **Mobil**: 375x812 (iPhone boyutu README için)

## 🎨 Stil Kılavuzu

### Renkler
- **Ana Renk**: #007AFF (Mavi)
- **İkincil**: #34C759 (Yeşil)
- **Arkaplan**: #F2F2F7 (Açık gri)
- **Metin**: #1C1C1E (Koyu gri)

### Tipografi
- **Ana Font**: SF Pro Display
- **Kod Font**: SF Mono
- **Boyutlar**: 12pt, 14pt, 16pt, 20pt

## 📸 Ekran Görüntüsü Çekme

macOS'ta ekran görüntüsü çekmek için:

```bash
# Tam ekran
screencapture -x screenshot.png

# Belirli pencere
screencapture -w screenshot.png

# Belirli alan
screencapture -s screenshot.png

# Gecikme ile (5 saniye)
screencapture -T 5 screenshot.png
```

## 🎬 GIF Oluşturma

Demo GIF oluşturmak için:

1. **QuickTime** ile ekran kaydı yapın
2. **GIPHY Capture** veya **Kap** kullanın
3. **FFmpeg** ile dönüştürün:

```bash
ffmpeg -i demo.mov -vf "fps=10,scale=800:-1:flags=lanczos" demo.gif
```

## ✅ Kontrol Listesi

Yeni görsel eklerken kontrol edin:

- [ ] Dosya boyutu optimize edilmiş
- [ ] Doğru format kullanılmış (PNG, GIF, JPG)
- [ ] Telif hakkı sorunu yok
- [ ] Retina ekranlar için 2x versiyonu var
- [ ] README'de referans verilmiş
- [ ] Alt text eklenmiş (accessibility)

## 📄 Lisans

Tüm görseller MIT lisansı altında yayınlanır.
