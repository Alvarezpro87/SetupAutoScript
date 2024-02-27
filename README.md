# Configuração do Servidor Web Automatizado

Este repositório contém um script de shell para automatizar a configuração de um servidor web usando `httpd` e `PHP` no CentOS 7. O script configura o servidor, cria um Virtual Host, e copia o conteúdo da landing page do diretório `/etc/content` para o servidor web.

## Pré-requisitos

Antes de executar o script, certifique-se de que:

1. Você está executando o script em um sistema CentOS 7.
2. Você tem permissões de superusuário (root) para executar comandos que requerem `sudo`.
3. A pasta `/etc/content` existe e contém os arquivos da sua landing page. Caso a pasta não exista, você pode criá-la usando o seguinte comando:


```bash
sudo mkdir -p /etc/content
```

Copie sua landing page para dentro desta pasta.

## Como usar

1. Clone este repositório.

2. Navegue até o diretório do repositório clonado.

3. Torne o script executável com o seguinte comando:

```bash
chmod +x setup_server.sh
```


4. Execute o script com privilégios de superusuário:

```bash
sudo ./setup_server.sh
```

5. Após a execução, o servidor web deverá estar configurado, e a landing page disponível no endereço configurado no script.

## Funcionalidades do Script

O script realiza as seguintes ações:

- Espera 10 segundos para garantir que a rede esteja completamente inicializada.
- Atualiza os pacotes do sistema.
- Instala o `httpd` e o `PHP`.
- Habilita e inicia o serviço `httpd`.
- Cria um diretório para o site e ajusta as permissões.
- Copia o conteúdo da landing page do diretório `/etc/content` para o diretório do site.
- Configura um Virtual Host para o site.
- Configura o firewall para permitir tráfego HTTP.
- Atualiza o arquivo `/etc/hosts` para incluir o mapeamento do hostname para o IP da máquina.
- Reinicia o serviço `httpd` para aplicar as configurações.

## Notas Adicionais

- Certifique-se de que a porta 80 esteja aberta para permitir o tráfego HTTP para o seu servidor.

