# FlashEdu
 FlashEdu – União entre FLASH (“Fun Learning And Study Hub”), e educação, enfatizando um espaço de estudo dinâmico.
 
 
 ## Objetivo Geral:
 Desenvolver um aplicativo móvel de perguntas e respostas (trivia) que promova a educação de qualidade, alinhado ao ODS 4: Educação de Qualidade. O app utilizará a Open Trivia Database API para fornecer questões personalizadas e interativas, estimulando o aprendizado de forma divertida e dinâmica.
 
 
 ## Definição do Problema
 Apesar do crescente acesso à tecnologia, muitos estudantes ainda enfrentam dificuldades em manter o interesse e a retenção do conteúdo escolar. A falta de interatividade nos métodos tradicionais de ensino pode contribuir para a desmotivação.
 
 
 ### Problema a ser resolvido:
 Criar uma solução que torne o processo de aprendizagem mais interativo e engajador, permitindo que os usuários aprendam por meio de jogos de trivia e flashcards, reforçando o conhecimento de forma lúdica.
 
 ### Solução Proposta:
 Um aplicativo móvel com funcionalidades de trivia (perguntas e respostas) e um módulo para criação e revisão de flashcards.
 
 **Front-end:** Interface intuitiva e interativa para o usuário.
 
 **Back-end:** Integração com a Open Trivia Database API para obter as questões, gerenciamento de pontuações, progresso e flashcards (armazenados localmente ou por meio de um serviço em nuvem gratuito, como o Firebase).
 
 # Requisitos da Aplicação
 ### Requisitos Funcionais
 
 **Gerenciamento de Perfil:**
 
 > Edição de perfil e preferencias do usuário.
 
 **Módulo Trivia:**
 > Consumir a Open Trivia Database API (https://opentdb.com/api_config.php) para exibir perguntas em múltipla escolha, verdadeiro ou falso, etc.
 > Consumir a Open Trivia Database API (https://opentdb.com/api_config.php) para exibir perguntas em múltipla escolha.
 
 > Exibir feedback imediato sobre respostas corretas ou incorretas.
 
 > Registrar a pontuação e atualizar um progresso.
 
 **Módulo Flashcards:**
 
 > Permitir que os usuários criem, editem e revisem flashcards para reforçar o aprendizado.
 
 **Interface Interativa:**
 
 > Interface responsiva e de fácil navegação entre as seções de trivia e flashcards.
 
 **Configurações e Preferências:**
 
 > Permitir ao usuário escolher categorias e níveis de dificuldade para os quizzes.
 
 ### Requisitos Não Funcionais
 
 **Usabilidade:**
 
 > A interface deve ser intuitiva, acessível e adaptada para dispositivos móveis.
 
 **Confiabilidade:**
 
 > Garantir disponibilidade nos períodos de uso ativo.
 
 ## Estrutura do Repositório
 
 ```bash

│   README.md
│
├───Arquitetura
│       Components.jpg
│       Containers.jpg
│       Context.jpg
│       README.md
│
├───FlashEdu (Componentes do aplicativo + testes de software)
│   └───flashedu
│       │   pubspec.lock
│       │   pubspec.yaml
│       │
│       ├── assets (imagens)
│       │   │   logo.png
│       │
│       ├───lib
│       │   │   AboutTheApp.dart
│       │   │   home_page.dart
│       │   │   main.dart
│       │   │
│       │   ├───Flashcards
│       │   │       db_helper.dart
│       │   │       flashcard_page.dart
│       │   │       folder_list_page.dart
│       │   │
│       │   ├───models
│       │   │       flashcard.dart
│       │   │       folder.dart
│       │   │
│       │   ├───Settings
│       │   │       config_page.dart
│       │   │       userPreferencesService.dart
│       │   │
│       │   └───Trivia
│       │           scoreTracker.dart
│       │           trivia_page.dart
│       │
│       └───test
│               AboutTheApp_test.dart
│               Flashcards_test.dart
│
├───Testes_de_software
│       README.md
│
└───Videos  (Contém os vídeos de detalhes do projeto.)
    │   Desenvolvimento_1.mp4
    │   README.md
    │
    └───gif
            emptyfolder.gif
            flashcard_roxo.gif
            flashcard_vermelho.gif
            multiple_flashcards.gif
            multiple_folders.gif
            newfolder.gif
            new_flashcards.gif
            theme.gif
            trivia_correct.gif
            trivia_wrong.gif
```
