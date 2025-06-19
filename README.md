# MeuTempero

## 📖 Sobre o Projeto

O **MeuTempero** é um aplicativo de receitas culinárias desenvolvido em Flutter, pensado para ser seu assistente pessoal na cozinha. O objetivo é facilitar o acesso a receitas, tornando o preparo de refeições uma experiência mais prática, organizada e divertida.

Com ele, você pode explorar centenas de receitas completas, navegar por categorias e até marcar os ingredientes que já separou, tudo em uma interface limpa e moderna que funciona em qualquer lugar, na palma da sua mão.

## 📸 Telas do App

| Tela Inicial | Lista de Receitas | Detalhes da Receita |
| :---: | :---: | :---: |
| ![image](https://github.com/user-attachments/assets/e184543c-7b43-4297-b64f-24e300c1f853) | ![image](https://github.com/user-attachments/assets/676c9c06-51dc-4da9-b936-3f36587246bb) | ![image](https://github.com/user-attachments/assets/a4b813a5-1856-4f4c-89d5-c8578e845fef)

## ✨ Funcionalidades Principais

-   **Navegação por Categorias:** Encontre facilmente o prato perfeito para a ocasião, seja um bolo, uma massa ou uma bebida.
-   **Detalhes Completos da Receita:** Acesse a lista de ingredientes, o modo de preparo passo a passo e o nome da imagem associada.
-   **Checklist de Ingredientes Interativo:** Marque os ingredientes (`checkbox`) conforme os separa. Seu progresso fica salvo no dispositivo, mesmo que você feche o app!
-   **Base de Dados Local:** Mais de 100 receitas disponíveis offline, carregadas a partir de um arquivo CSV incluído no projeto.
-   **Design Moderno e Responsivo:** Interface amigável e adaptável a diferentes tamanhos de tela, com transições suaves entre as páginas.

## 🛠️ Tecnologias e Pacotes

Este projeto foi construído utilizando as seguintes tecnologias:

-   **Flutter:** Framework principal para o desenvolvimento de aplicativos multiplataforma.
-   **Linguagem Dart:** Linguagem de programação base do Flutter.
-   **Pacotes Chave:**
    -   `shared_preferences`: Para salvar o estado dos checkboxes dos ingredientes de forma persistente no dispositivo.
    -   `csv`: Para ler e analisar a base de dados de receitas a partir do arquivo CSV local.

## 🚀 Como Executar o Projeto

Para rodar este projeto localmente, siga os passos abaixo.

### Pré-requisitos

-   Você precisa ter o **[Flutter SDK](https://docs.flutter.dev/get-started/install)** instalado na sua máquina.
-   Um emulador Android/iOS configurado, ou um dispositivo físico conectado.

### Instalação e Execução

1.  **Clone o repositório:**
    ```sh
    git clone https://github.com/jlxmns/MeuTempero.git
    ```
2.  **Navegue até o diretório do projeto:**
    ```sh
    cd MeuTempero
    ```
3.  **Instale as dependências do projeto:**
    ```sh
    flutter pub get
    ```
4.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```
Pronto! O aplicativo deve iniciar no seu emulador ou dispositivo conectado.

## 📂 Estrutura de Pastas

O projeto está organizado da seguinte forma para facilitar a manutenção e escalabilidade:

```
MeuTempero/
├── lib/
│   ├── data/              # Responsável pela leitura de dados (CSV)
│   ├── models/            # Classes e modelos de dados
│   ├── pages/             # Widgets que representam cada tela do app
│   ├── utils/             # Classes de utilidade (cores, etc.)
│   └── main.dart          # Ponto de entrada da aplicação
├── assets/
│   ├── data/              # Arquivo .csv com as receitas
│   └── images/            # Imagens utilizadas nas receitas
└── pubspec.yaml           # Definições e dependências do projeto
```

## 🤝 Como Contribuir

Contribuições são o que tornam a comunidade de código aberto um lugar incrível para aprender, inspirar e criar. Qualquer contribuição que você fizer será **muito bem-vinda**.

1.  Faça um *Fork* do projeto
2.  Crie uma *Branch* para sua modificação (`git checkout -b feature/sua-feature`)
3.  Faça o *Commit* (`git commit -m 'Adicionando sua-feature'`)
4.  Faça o *Push* (`git push origin feature/sua-feature`)
5.  Abra um *Pull Request*
6.  
---
