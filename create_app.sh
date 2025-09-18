#!/bin/bash

echo "🖱️ Mouse Control - Manual App Builder"
echo "======================================"

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

APP_NAME="MouseControl"
VERSION="1.0"
APP_BUNDLE="$APP_NAME.app"
DMG_NAME="$APP_NAME-$VERSION.dmg"

echo -e "${BLUE}📦 Swift binary derleniyoran...${NC}"

# Swift binary derle
if swift build -c release; then
    echo -e "${GREEN}✅ Swift derleme başarılı!${NC}"
else
    echo -e "${RED}❌ Swift derleme başarısız!${NC}"
    exit 1
fi

echo -e "${BLUE}📁 App bundle oluşturuluyor...${NC}"

# Eski app bundle'ı sil
rm -rf "$APP_BUNDLE"

# App bundle yapısı oluştur
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# Executable'ı kopyala
cp .build/release/MouseControl "$APP_BUNDLE/Contents/MacOS/"
chmod +x "$APP_BUNDLE/Contents/MacOS/MouseControl"

# Info.plist'i kopyala
cp MouseControl/Info.plist "$APP_BUNDLE/Contents/"

# PkgInfo dosyası oluştur
echo -n "APPL????" > "$APP_BUNDLE/Contents/PkgInfo"

echo -e "${GREEN}✅ App bundle oluşturuldu: $APP_BUNDLE${NC}"

echo -e "${BLUE}🎨 Basit bir ikon oluşturuluyor...${NC}"

# Basit bir ikon oluştur (SF Symbols kullanarak)
cat > create_icon.py << 'EOF'
import os
from PIL import Image, ImageDraw

def create_mouse_icon(size):
    # Basit fare ikonu oluştur
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Fare gövdesi
    margin = size // 8
    draw.ellipse([margin, margin*2, size-margin, size-margin], 
                fill=(100, 100, 100, 255), outline=(50, 50, 50, 255), width=2)
    
    # Sol tık butonu
    draw.arc([margin, margin*2, size//2, size//2 + margin], 
             start=180, end=0, fill=(70, 70, 70, 255), width=2)
    
    # Sağ tık butonu  
    draw.arc([size//2, margin*2, size-margin, size//2 + margin], 
             start=180, end=0, fill=(70, 70, 70, 255), width=2)
    
    # Orta çizgi
    draw.line([size//2, margin*2, size//2, size//2 + margin], 
              fill=(50, 50, 50, 255), width=2)
    
    return img

# Icon boyutları
sizes = [16, 32, 128, 256, 512]
for size in sizes:
    icon = create_mouse_icon(size)
    icon.save(f'icon_{size}x{size}.png')
    print(f"Created icon_{size}x{size}.png")
EOF

# Python varsa ikon oluştur
if command -v python3 >/dev/null 2>&1; then
    python3 -c "
try:
    from PIL import Image, ImageDraw
    exec(open('create_icon.py').read())
except ImportError:
    print('PIL not available, skipping icon creation')
" 2>/dev/null || echo "İkon oluşturulamadı, PIL bulunamadı"
    rm -f create_icon.py
fi

echo -e "${BLUE}📦 DMG dosyası oluşturuluyor...${NC}"

# Geçici dizin oluştur
TEMP_DIR="dmg_temp"
rm -rf "$TEMP_DIR"
mkdir "$TEMP_DIR"

# App'i geçici dizine kopyala
cp -R "$APP_BUNDLE" "$TEMP_DIR/"

# Applications klasörüne symlink oluştur
ln -s /Applications "$TEMP_DIR/Applications"

# DMG oluştur
rm -f "$DMG_NAME"
hdiutil create -volname "$APP_NAME" \
               -srcfolder "$TEMP_DIR" \
               -ov \
               -format UDZO \
               "$DMG_NAME"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ DMG dosyası başarıyla oluşturuldu: $DMG_NAME${NC}"
    echo ""
    echo -e "${YELLOW}📋 Kurulum talimatları:${NC}"
    echo "1. $DMG_NAME dosyasını çift tıklayın"
    echo "2. MouseControl.app'i Applications klasörüne sürükleyin"
    echo "3. Applications klasöründen MouseControl'ü çalıştırın"
    echo "4. Accessibility izni verin"
    echo ""
    echo -e "${BLUE}💡 DMG Dosyası:${NC}"
    ls -la "$DMG_NAME"
    
    # Dosya boyutunu göster
    SIZE=$(du -h "$DMG_NAME" | cut -f1)
    echo -e "${GREEN}📦 Dosya boyutu: $SIZE${NC}"
    
else
    echo -e "${RED}❌ DMG oluşturma başarısız!${NC}"
    exit 1
fi

# Temizlik
rm -rf "$TEMP_DIR"

echo -e "${GREEN}🎉 Mouse Control uygulaması hazır!${NC}"
echo ""
echo -e "${BLUE}📱 Test etmek için:${NC}"
echo "open $DMG_NAME" 