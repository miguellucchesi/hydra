import tkinter as tk
from tkinter import messagebox
import subprocess
import tempfile
import os

def execute_hwid(submenu):
    try:
        subprocess.run(['cmd', '/c', 'echo Ativação HWID... && echo. && cscript //nologo %systemdrive%\\Windows\\System32\\slmgr.vbs /ipk N9J9Q-Q7MMP-XDDM6-63KKP-76FPM && cscript //nologo %systemdrive%\\Windows\\System32\\slmgr.vbs /skms kms.chinancce.com && cscript //nologo %systemdrive%\\Windows\\System32\\slmgr.vbs /ato && pause && exit'], capture_output=True, check=True, shell=True)
        messagebox.showinfo("Sucesso", "A ativação HWID foi concluída com sucesso!")
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Erro", f"Ocorreu um erro durante a ativação HWID: {e.stderr}")
    finally:
        submenu.destroy()

def execute_ohook(submenu):
    try:
        subprocess.run(['cmd', '/c', 'echo Ativação Ohook... && echo. && cscript //nologo %systemdrive%\\Windows\\System32\\slmgr.vbs /ipk 6D8G9-M22KF-R6TR4-JD8XR-JTQJY && cscript //nologo %systemdrive%\\Windows\\System32\\slmgr.vbs /skms kms.chinancce.com && cscript //nologo %systemdrive%\\Windows\\System32\\slmgr.vbs /ato && pause && exit'], capture_output=True, check=True, shell=True)
        messagebox.showinfo("Sucesso", "A ativação Ohook foi concluída com sucesso!")
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Erro", f"Ocorreu um erro durante a ativação Ohook: {e.stderr}")
    finally:
        submenu.destroy()

def execute_office_update_script():
    try:
        script_content = r'"C:\Program Files\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe" /update user updatetoversion=16.0.13801.20266'
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.bat') as batch_file:
            batch_file.write(script_content)
            batch_file_path = batch_file.name

        subprocess.run([batch_file_path], capture_output=True, check=True, shell=True)
    except subprocess.CalledProcessError as e:
        messagebox.showerror("Erro", f"Erro ao atualizar o Office: {e.stderr}")
    except Exception as ex:
        messagebox.showerror("Erro", f"Erro ao executar o script: {ex}")
    finally:
        # Excluir o arquivo batch temporário
        os.remove(batch_file_path)

def confirm_execute(script_name):
    if script_name == "Ativador Windows/Office":
        # Se a opção "Ativador Windows/Office" for selecionada, abrir submenu
        submenu = tk.Toplevel()
        submenu.title("Submenu de Ativação")
        submenu.configure(bg="black")
        submenu.geometry("500x200")  # Defina o tamanho do submenu

        submenu_label = tk.Label(submenu, text="Escolha um método de ativação:", font=("Helvetica", 14), bg="black", fg="white")
        submenu_label.pack(pady=10)

        hwid_button = tk.Button(submenu, text="Ativação HWID", command=execute_hwid, font=("Helvetica", 12), bg="black", fg="white", relief=tk.GROOVE, padx=10, pady=5, width=40)
        hwid_button.pack(pady=5)

        ohook_button = tk.Button(submenu, text="Ativação Ohook", command=execute_ohook, font=("Helvetica", 12), bg="black", fg="white", relief=tk.GROOVE, padx=10, pady=5, width=40)
        ohook_button.pack(pady=5)

    elif script_name == "Remover mensagem de ativação do Office":
        execute_office_update_script()
    elif script_name == "Limpeza de temporários":
        # Coloque aqui o código para a opção "Limpeza de temporários" se necessário
        pass
    # Adicione o código para outras opções aqui

def create_gui():
    root = tk.Tk()
    root.title("Menu Simplificado")
    root.configure(bg="black")
    
    # Maximizar a janela
    root.state('zoomed')

    options = [
        "Ativador Windows/Office",
        "Remover mensagem de ativação do Office",
        "Limpeza de temporários",
        "Resolver problemas com HD",
        "Resolver problemas com internet",
        "Resolver problemas com impressoras",
        "Resolver problemas com Windows",
        "Corrigir atualização do Windows",
        "Atualizar todos os programas",
        "Otimizar o Windows",
        "Modo mais desempenho",
        "Excluir certificados vencidos",
        "Backup de arquivos",
        "Organizar Área de trabalho e Downloads",
        "Sincronizar Relógio",
        "Corrigir problemas do Java",
        "Buscar arquivos de IRPF"
    ]

    root_label = tk.Label(root, text="Bem-vindo ao menu simplificado!", font=("Helvetica", 16), bg="black", fg="white")
    root_label.pack(pady=10)

    # Criar um frame para conter os botões
    button_frame = tk.Frame(root, bg="black")
    button_frame.pack(pady=10, padx=10)

    # Criar os botões e adicioná-los ao frame
    for option in options:
        button = tk.Button(button_frame, text=option, command=lambda option=option: confirm_execute(option), font=("Helvetica", 12), bg="black", fg="white", relief=tk.GROOVE, padx=10, pady=5, width=40)
        button.pack(pady=5, fill=tk.X)

    root.mainloop()

if __name__ == "__main__":
    create_gui()
