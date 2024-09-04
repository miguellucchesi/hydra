import subprocess

def set_timezone(timezone):
    try:
        subprocess.run(["tzutil", "/s", timezone], check=True)
        print(f"Fuso horário definido para {timezone}.")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao definir o fuso horário: {e}")

def configure_time_server():
    try:
        subprocess.run(["w32tm", "/config", "/manualpeerlist:time.windows.com", "/syncfromflags:manual", "/reliable:YES", "/update"], check=True)
        print("Servidor de tempo configurado para time.windows.com.")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao configurar o servidor de tempo: {e}")

def resync_time():
    try:
        subprocess.run(["w32tm", "/resync"], check=True)
        print("Horário sincronizado com sucesso.")
    except subprocess.CalledProcessError as e:
        print(f"Erro ao sincronizar o horário: {e}")

def select_timezone(options, region_name):
    print(f"Escolha o fuso horário de {region_name}:")
    for i, (name, tz) in enumerate(options.items(), 1):
        print(f"{i}. {name}")

    choice = int(input("Digite o número da opção desejada: "))
    while choice < 1 or choice > len(options):
        print("Opção inválida. Tente novamente.")
        choice = int(input("Digite o número da opção desejada: "))

    timezone = list(options.values())[choice - 1]
    return timezone

def main():
    brasil_options = {
        "Horário de Brasília (BRT)": "E. South America Standard Time",
        "Horário de Fernando de Noronha (FNT)": "UTC-02",  # Ajuste conforme o nome válido
        "Horário do Acre (ACT)": "SA Pacific Standard Time"
    }

    us_options = {
        "Eastern Time (ET)": "Eastern Standard Time",
        "Central Time (CT)": "Central Standard Time",
        "Mountain Time (MT)": "Mountain Standard Time",
        "Pacific Time (PT)": "Pacific Standard Time"
    }

    br_timezone = select_timezone(brasil_options, "Brasil")
    set_timezone(br_timezone)
    configure_time_server()
    resync_time()
    print("Fuso horário do Brasil definido e horário sincronizado.\n")

    input("Pressione Enter para continuar para o fuso horário dos Estados Unidos...")

    us_timezone = select_timezone(us_options, "Estados Unidos")
    set_timezone(us_timezone)
    configure_time_server()
    resync_time()
    print("Fuso horário dos Estados Unidos definido e horário sincronizado.")

if __name__ == "__main__":
    main()
