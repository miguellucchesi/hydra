import os
import shutil

def organizar_arquivos(pasta_origem):
    try:
        # Lista todos os arquivos na pasta de origem
        arquivos = os.listdir(pasta_origem)
        
        # Cria uma pasta com o nome da pasta pai
        pasta_pai = os.path.basename(os.path.abspath(pasta_origem))
        nova_pasta = os.path.join(pasta_origem, pasta_pai)
        os.makedirs(nova_pasta, exist_ok=True)
        
        # Mapeia as extensões de arquivo para as pastas de destino
        extensoes = {}
        for arquivo in arquivos:
            nome, extensao = os.path.splitext(arquivo)
            extensao = extensao[1:]  # Remove o ponto inicial
            if extensao:
                extensoes.setdefault(extensao, []).append(arquivo)
        
        # Cria subpastas para cada extensão e move os arquivos correspondentes
        for extensao, arquivos in extensoes.items():
            pasta_extensao = os.path.join(nova_pasta, extensao)
            os.makedirs(pasta_extensao, exist_ok=True)
            for arquivo in arquivos:
                caminho_origem = os.path.join(pasta_origem, arquivo)
                caminho_destino = os.path.join(pasta_extensao, arquivo)
                shutil.move(caminho_origem, caminho_destino)
    except Exception as e:
        print(f"Erro ao organizar arquivos na pasta {pasta_origem}: {e}")

def submenu():
    print("Escolha as pastas para organizar (use espaço para múltiplas escolhas Ex:1 2 3):")
    print("1. Downloads")
    print("2. Documentos")
    print("3. Desktop")
    opcoes = input("Digite os números das opções desejadas: ").split()

    opcoes_validas = {"1", "2", "3"}
    for opcao in opcoes:
        if opcao not in opcoes_validas:
            print(f"Opção inválida: {opcao}. Tente novamente.")
            return
    
    for opcao in opcoes:
        if opcao == "1":
            pasta_origem = os.path.join(os.environ['USERPROFILE'], "Downloads")
            organizar_arquivos(pasta_origem)
        elif opcao == "2":
            pasta_origem = os.path.join(os.environ['USERPROFILE'], "Documents")
            organizar_arquivos(pasta_origem)
        elif opcao == "3":
            pasta_origem = os.path.join(os.environ['USERPROFILE'], "Desktop")
            organizar_arquivos(pasta_origem)

# Chamando o submenu
submenu()