# TODO: Перехід з Docker/OrbStack на Podman (назавжди)

## Мета
Podman — єдиний контейнерний рушій на macOS. Команди `docker ...` працюють на
Podman engine через docker socket (podman-mac-helper). Docker Desktop і OrbStack
видалені.

## Статус кроків

- [x] 1. Podman machine
  - [!] Стара VM-машина була зламана (диск 35GiB .raw та SSH-ключ зникли, ймовірно при апдейті podman/чистці)
  - [x] Створена заново: `podman machine init --cpus 4 --memory 8192 --disk-size 35 --rootful` + start
- [x] 2. Docker-сумісність вже була ввімкнена у Podman Desktop (podman-mac-helper): `/var/run/docker.sock` → podman.sock
- [x] 3. `docker context` переключено на `default`; `docker info` показує ServerVersion=6.1.0 (podman)
- [x] 4. Встановлено brew: docker 29.7.2, docker-compose 5.5.0, docker-credential-helper
  - compose-плагін: симлінк `/opt/homebrew/bin/docker-compose` → `~/.docker/cli-plugins/docker-compose`
  - прибрані мертві симлінки cli-plugins (вказували на OrbStack/Docker Desktop)
- [x] 5. Smoke-tests:
  - `docker run hello-world` — ок
  - `docker compose up -d` (nginx + redis) → HTTP 200 на порту 8080, down -v чистка — ок
- [x] 6. Docker Desktop видалено (app вже був знесений) + залишки в ~/Library, ~/.docker, контекст desktop-linux
- [x] 7. OrbStack видалено: app, ~/.orbstack, симлінки в ~/.local/bin
  - kubectl тепер з brew kubernetes-cli (1.36.3), контекст orbstack видалено
- [x] 8. Оновлено dotfiles: packages/bundle (docker, docker-compose, docker-credential-helper) + довідка dot CLI
- [x] 9. Автозапуск podman machine: LaunchAgent io.podman.machine-start (у ~/Library/LaunchAgents, версіонується в dotfiles: home/Library/LaunchAgents/)

- [x] 10. Alias docker=podman у .bashrc (для інтерактивного shell; інструменти поза shell ідуть через socket-міст)

## Підсумок
- docker CLI → Podman engine: працює
- docker compose → Podman: працює (nginx/redis smoke-test)
- kubectl/lazydocker: працюють через docker socket (lazydocker потребує інтерактивного терміналу)
- OrbStack і Docker Desktop: видалені
- Повернення до Docker можливе: встановити Docker Desktop/OrbStack і змінити контекст, проте socket symlink /var/run/docker.sock перекриватиме — треба відключити Docker Compatibility у Podman Desktop

## Нотатки
- `stop_docker` скрипт у dotfiles працює з віддаленим сервером (ssh ds@ds) — не чіпати
- .bashrc.local: лише TF_VAR_dockerhub_* — не чіпати
- ~/.docker/cli-plugins: лишився тільки docker-compose (симлінк на brew)