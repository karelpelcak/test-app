# Použij oficiální Node.js image
FROM node:20-alpine AS builder

# Nastavení pracovního adresáře
WORKDIR /app

# Zkopírování package.json a package-lock.json
COPY package*.json ./

# Instalace dependencies
RUN npm install

# Zkopírování celého projektu
COPY . .

# Build Next.js aplikace
RUN npm run build