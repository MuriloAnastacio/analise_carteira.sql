# Score de Risco de Crédito - Exemplo
# Autor: Murilo Machado
# Simulação de cálculo de risco para concessão de crédito

import pandas as pd

# Base de clientes simulada
dados = {
    "cliente": ["A", "B", "C", "D", "E"],
    "idade": [25, 40, 35, 50, 28],
    "renda": [2000, 5000, 3500, 8000, 2200],
    "atrasos": [2, 0, 1, 0, 3],
    "divida": [1000, 2000, 1500, 1000, 1200]
}

df = pd.DataFrame(dados)

# Função de cálculo de score
def calcular_score(row):
    score = 1000
    
    # Penalidade por atrasos
    score -= row["atrasos"] * 100
    
    # Penalidade por dívida alta
    if row["divida"] > 1500:
        score -= 50
        
    # Bônus por renda alta
    if row["renda"] > 4000:
        score += 50
        
    return score

df["score"] = df.apply(calcular_score, axis=1)

# Classificação de risco
def classificar(score):
    if score >= 900:
        return "Baixo Risco"
    elif score >= 700:
        return "Médio Risco"
    else:
        return "Alto Risco"

df["risco"] = df["score"].apply(classificar)

print(df)

# Salvar resultado
df.to_csv("resultado_score.csv", index=False)
