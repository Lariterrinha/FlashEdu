# 📋 Plano de Testes – Aplicativo de Trivia

Este documento apresenta os casos de teste elaborados para os principais casos de uso do aplicativo de Trivia.

---

"Status": `Aprovado ✅`, `Reprovado ❌`, `Não testado ⏳`.

---

---

## 🎯 Caso de Uso 1: Responder pergunta de trivia

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC1.1 | Usuário seleciona a resposta correta de primeira | Resposta correta | Pontuação computada corretamente | Não testado |
| TC1.2 | Usuário seleciona a resposta errada | Resposta errada | Nenhuma pontuação atribuída | Não testado |

---

## 🧠 Caso de Uso 2: Escolher dificuldade nas configurações e na tela da trivia

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC2.1 | Selecionar dificuldade "Fácil" | Botão "Fácil" | Apenas perguntas fáceis são carregadas | Aprovado ✅ |
| TC2.2 | Selecionar dificuldade "Médio" | Botão "Médio" | Apenas perguntas médias são carregadas | Não testado |
| TC2.3 | Alterar dificuldade durante o uso | Fácil → Difícil | Quiz é recarregado conforme nova dificuldade | Não testado |

---

## 📚 Caso de Uso 3: Escolher categoria nas configurações

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC3.1 | Selecionar categoria "Conhecimentos Gerais" | Dropdown de categorias | Apenas perguntas da categoria selecionada aparecem | Não testado |
| TC3.3 | Sem categoria selecionada (modo aleatório) | Dropdown de categorias "Any Category" | Perguntas de várias categorias são sorteadas | Não testado |

---

## ⚙️ Caso de Uso 4: Configurações de Tema

| ID do Teste | Descrição | Entrada | Resultado Esperado | Status |
|-------------|-----------|---------|---------------------|--------|
| TC4.1 | Selecionar tema (cores) | Botão de Cores na tela configurações muda barra inderior e superior | Aplicativo muda para tema  escolhido | Aprovado ✅ |
| TC4.2 | Selecionar tema  | Botão de Cores (configurações) muda a cor dos flashcards | Aplicativo muda para escolhido | Aprovado ✅ |
| TC4.3 | Preferência salva no banco | Troca de tema | Preferência registrada no SQLite | Não testado |


