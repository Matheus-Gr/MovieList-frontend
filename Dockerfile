# Use uma imagem de Node.js como base
FROM node:21.6.2-alpine3.19

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o arquivo package.json e o arquivo package-lock.json (se estiver presente) para o diretório de trabalho
COPY package*.json ./

# Instale as dependências do projeto
RUN npm install

# Copie todo o código fonte para o diretório de trabalho
COPY . .

# Compile a aplicação Vue.js para produção
RUN npm run build

# Exponha a porta 80 para acessar a aplicação
EXPOSE 8080

# Comando a ser executado quando o contêiner for iniciado
CMD ["npm", "run", "serve"]
