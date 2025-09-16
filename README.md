# 📱 Aplicativo Flutter - Consulta e Gerenciamento de CEPs  

Este projeto é um aplicativo desenvolvido em **Flutter** que permite pesquisar informações de **CEPs** (Códigos de Endereçamento Postal), salvar as consultas em um banco de dados e gerenciar os CEPs armazenados.  

O app utiliza as seguintes tecnologias:  
- 📡 [Dio](https://pub.dev/packages/dio) para requisições HTTP.  
- 🔐 [Dotenv](https://pub.dev/packages/flutter_dotenv) para gerenciar variáveis de ambiente de forma segura.  
- ☁️ [Back4App](https://www.back4app.com/) como banco de dados backend (Parse Server).  

---

## 🚀 Funcionalidades  
- 🔍 **Pesquisar CEP**: insira um CEP e visualize seus dados (endereço, bairro, cidade, estado, etc).  
- 💾 **Salvar CEP**: armazene o resultado da pesquisa no banco de dados do Back4App.  
- 📂 **Listar CEPs Salvos**: consulte todos os CEPs que já foram salvos em uma tela dedicada.  
- ❌ **Excluir CEPs**: remova do banco de dados os CEPs que não deseja manter.  

---

## 🛠️ Tecnologias Utilizadas  
- **Flutter** (SDK cross-platform)  
- **Dart** (linguagem de programação)  
- **Dio** (requisições HTTP)  
- **Dotenv** (variáveis de ambiente)  
- **Back4App / Parse Server** (backend e banco de dados)  

----

## ⚙️ Configuração  
1. Clonar o repositório
2. Instalar dependências
```bash
flutter pub get
```

3. Configurar variáveis de ambiente
Crie um arquivo .env na raiz do projeto com as seguintes informações (adaptando para suas chaves do Back4App):

```
# .ENV-EXAMPLE
API_URL=back4app-url
API_CLIENT_KEY=back4app-client-key
API_ID=back4app-id
VIACEP_URL=https://viacep.com.br/ws
```

4. Rodar o projeto
```bash
flutter run
```

## Screenshots
<img width="190" height="500" alt="Simulator Screenshot - iPhone 14 Pro Max - 2025-09-16 at 13 35 27" src="https://github.com/user-attachments/assets/fda490bb-c8c4-4278-b845-09ad0779a45a" />
<img width="190" height="500" alt="Simulator Screenshot - iPhone 14 Pro Max - 2025-09-16 at 13 36 45" src="https://github.com/user-attachments/assets/70660b94-98c4-4b46-8bfa-2c4506f79ab8" />
<img width="190" height="500" alt="Simulator Screenshot - iPhone 14 Pro Max - 2025-09-16 at 13 36 55" src="https://github.com/user-attachments/assets/bac1fbb2-6896-400b-9893-ac30034d0f84" />
<img width="190" height="500" alt="Simulator Screenshot - iPhone 14 Pro Max - 2025-09-16 at 13 36 48" src="https://github.com/user-attachments/assets/066e21bd-d84e-4d06-9af8-e57b6b3a13a0" />
<img width="190" height="500" alt="Simulator Screenshot - iPhone 14 Pro Max - 2025-09-16 at 13 39 50" src="https://github.com/user-attachments/assets/b5d56c5c-b00e-488c-9d95-885eb01fe26a" />


