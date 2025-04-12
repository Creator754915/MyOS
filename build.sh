#!/bin/bash

nasm -f bin bootloader.asm -o boot.img

size=$(stat -c %s boot.img)

if [ "$size" -ne 512 ]; then
  echo "❌ Error : boot.img ne fait pas 512 octets ($size octets)"
  exit 1
fi

echo "✅ Image compilée avec succès (512 octets)"
qemu-system-x86_64 -drive format=raw,file=boot.img
