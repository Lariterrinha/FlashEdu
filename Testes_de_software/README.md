# 📋 Plano de Testes – Aplicativo de Trivia

Este documento apresenta os casos de teste elaborados para os principais casos de uso do aplicativo de Trivia.

## Snapshots dos testes

[▶️ Ir para pagina com Snapshots](https://github.com/Lariterrinha/FlashEdu/blob/main/Videos/README.md)
---

"Status": `Aprovado ✅`, `Reprovado ❌`, `Não testado ⏳`.

---

---

## 🎯 Caso de Uso 1: Responder pergunta de trivia

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC1.1 | Usuário seleciona a resposta correta de primeira | Resposta correta | Pontuação computada corretamente | Aprovado ✅ |
| TC1.2 | Usuário seleciona a resposta errada | Resposta errada | Nenhuma pontuação atribuída | Aprovado ✅ |

---

## 🧠 Caso de Uso 2: Escolher dificuldade nas configurações e na tela da trivia

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC2.1 | Selecionar dificuldade "Fácil" | Botão "Fácil" | Apenas perguntas fáceis são carregadas | Aprovado ✅ |
| TC2.2 | Selecionar dificuldade "Médio" | Botão "Médio" | Apenas perguntas médias são carregadas | Aprovado ✅ |
| TC2.3 | Alterar dificuldade durante o uso | Fácil → Difícil | Quiz é recarregado conforme nova dificuldade | Aprovado ✅ |

---

## 📚 Caso de Uso 3: Escolher categoria nas configurações

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC3.1 | Selecionar categoria "Conhecimentos Gerais" | Dropdown de categorias | Apenas perguntas da categoria selecionada aparecem | Aprovado ✅ |
| TC3.3 | Sem categoria selecionada (modo aleatório) | Dropdown de categorias "Any Category" | Perguntas de várias categorias são sorteadas | Aprovado ✅ |

---

## ⚙️ Caso de Uso 4: Configurações de Tema

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC4.1 | Selecionar tema (cores) | Botão de Cores na tela configurações muda barra inderior e superior | Aplicativo muda para tema  escolhido | Aprovado ✅ |
| TC4.2 | Selecionar tema  | Botão de Cores (configurações) muda a cor dos flashcards | Aplicativo muda para escolhido | Aprovado ✅ |
| TC4.3 | Preferência salva no banco | Troca de tema | Preferência registrada no SQLite | Aprovado ✅ |

---

## 🧪 Caso de Uso 5: Tela "Sobre o App"

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC5.1 | Acessar carrossel informativo | Abertura da tela Sobre o App | Exibe 3 páginas informativas | Aprovado ✅ |
| TC5.2 | Navegar entre páginas do carrossel | Swipe | Avança e retorna entre as páginas corretamente | Aprovado ✅ |
| TC5.3 | Botão "Continue" | Clique no botão na última página | Navega para a tela principal `/tela_principal` | Aprovado ✅ |

---

## 📁 Caso de Uso 6: Manipulação de pastas

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC6.1 | Se não houver pastas exibe a mengagem de que não há | Tela com mensagem padrão | Exibir tela no caso inicial | Aprovado ✅ |
| TC6.2 | Adicionar pasta | Clicar no botão de adicionar pastas | Redirecionado para a pagina de criar pastas | Aprovado ✅ |
