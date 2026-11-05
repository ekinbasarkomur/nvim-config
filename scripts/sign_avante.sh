#!/usr/bin/env bash
# Avante build sonrası .so dosyalarını imzalar (macOS Gatekeeper için)
# Lazy build komutu plugin dizininden çalıştırır, dolayısıyla pwd = avante dizini
for f in lua/*.so; do
  [ -f "$f" ] || continue
  codesign --force --sign - "$f" 2>/dev/null && echo "signed: $(basename "$f")"
done
