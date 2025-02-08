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

# ========== Runtime fáze ==========
FROM node:20-alpine AS runner
WORKDIR /app

# Zkopírování důležitých souborů z build fáze
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

# Exponování portu 5173
EXPOSE 5173

# Spuštění aplikace na portu 5173
CMD ["npm", "run", "start", "--", "-p", "5173"]
