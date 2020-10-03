https://laradock.io/documentation/

### Список текущих запущенных контейнеров:
> ocker ps  
docker-compose ps

### Закройте все работающие контейнеры:
> docker-compose stop

### Удалить все существующие контейнеры:
> docker rm -f $(docker ps -a -q)  
> docker-compose down

### Удалить все существующие образы:
> docker rmi $(docker images -a -q)

### Построиить:
> docker-compose build --no-cache

### Построиить и запустить:
> docker-compose up -d --build apache2 mysql phpmyadmin workspace 

### Войти в контейнер:
1. Сначала перечислите текущие запущенные контейнеры с docker ps  
2. Войдите в любой контейнер, используя:  

> docker-compose exec {container-name} bash  
> docker-compose exec mysql bash   
> docker-compose exec mysql mysql -udefault -psecret  

1. Чтобы выйти из контейнера, введите exit

### Просмотр файлов журнала:
> docker-compose logs {container-name}  
> docker-compose logs -f {container-name}

### Права:
> ls -l -a  
> sudo chown -R aleksey:aleksey .data  
sudo chmod 777 -R .data

### Ставим и юзаем Zip / Unzip
> sudo apt-get update  
> sudo apt install zip  
sudo apt install unzip

> zip -v  
unzip -v

> unzip public_html.zip -d  ~/projects/stilfort_com
> zip -r -9 public_html.zip ~/projects/stilfort_com

### host
%windir%\system32\drivers\etc\hosts