# FlashEdu
FlashEdu – União entre FLASH (“Fun Learning And Study Hub”), e educação, enfatizando um espaço de estudo dinâmico.


# Objetivo Geral:
Desenvolver um aplicativo móvel de perguntas e respostas (trivia) que promova a educação de qualidade, alinhado ao ODS 4: Educação de Qualidade. O app utilizará a Open Trivia Database API para fornecer questões personalizadas e interativas, estimulando o aprendizado de forma divertida e dinâmica.


# Definição do Problema
Apesar do crescente acesso à tecnologia, muitos estudantes ainda enfrentam dificuldades em manter o interesse e a retenção do conteúdo escolar. A falta de interatividade nos métodos tradicionais de ensino pode contribuir para a desmotivação.


## Problema a ser resolvido:
Criar uma solução que torne o processo de aprendizagem mais interativo e engajador, permitindo que os usuários aprendam por meio de jogos de trivia e flashcards, reforçando o conhecimento de forma lúdica.

## Solução Proposta:
Um aplicativo móvel com funcionalidades de trivia (perguntas e respostas) e um módulo para criação e revisão de flashcards.

**Front-end:** Interface intuitiva e interativa para o usuário.

**Back-end:** Integração com a Open Trivia Database API para obter as questões, gerenciamento de usuários, pontuações e flashcards (armazenados localmente ou por meio de um serviço em nuvem gratuito, como o Firebase).

# Requisitos da Aplicação
## Requisitos Funcionais

** Autenticação e Gerenciamento de Perfil: **

> Cadastro, login e edição de perfil do usuário.

** Módulo Trivia: **
> Consumir a Open Trivia Database API (https://opentdb.com/api_config.php) para exibir perguntas em múltipla escolha, verdadeiro ou falso, etc.

> Exibir feedback imediato sobre respostas corretas ou incorretas.

> Registrar a pontuação e atualizar um ranking/leaderboard.

** Módulo Flashcards: **

> Permitir que os usuários criem, editem e revisem flashcards para reforçar o aprendizado.

** Interface Interativa: **

> Interface responsiva e de fácil navegação entre as seções de trivia e flashcards.

** Configurações e Preferências: **

> Permitir ao usuário escolher categorias e níveis de dificuldade para os quizzes.

# Requisitos Não Funcionais
** Desempenho: **

> As requisições à API devem retornar em, no máximo, 3 segundos.

** Usabilidade: **

> A interface deve ser intuitiva, acessível e adaptada para dispositivos móveis.

** Segurança: **

> Os dados dos usuários (login, progresso, flashcards) devem ser protegidos, utilizando, por exemplo, autenticação segura.

** Confiabilidade:**

> Garantir uma disponibilidade de 99% durante os períodos de uso ativo.
