# Empire 1.0

Слои: Kernel → Math → Platform → Graphics → Engine → Runtime, а также Tools и Tests.

Сборка идёт в `Empire.Build/Build.<Платформа>.<Режим>/Build.<Слой>/`
(`Empire.Engine` → `Build.Engine`), режимы друг с другом не смешиваются.

## Runtime

Точки входа (исполняемые файлы), общий код в `Runtime.Shared`:

| Цель | Папка | Что это |
|---|---|---|
| `Empire.Game` | `Runtime.Game` | основная точка входа игры |
| `Empire.Client` | `Runtime.Client` | клиент: окно, рендер, звук, UI, сеть |
| `Empire.Server` | `Runtime.Server` | выделенный сервер без окна, рендера и звука |
| `Empire.Standalone` | `Runtime.Standalone` | клиент и сервер в одном процессе (peer-to-peer, client-host), режим задаётся аргументами |
| `Empire.Editor` | `Runtime.Editor` | редактор (`--editor=n` отключает), подпапки `Editor.*` собираются в один файл |

## Сборка

```
xmake f -c -m release            # Release, без тестов (по умолчанию)
xmake f -c -m debug --tests=y    # Debug вместе с Empire.Tests
xmake f -c -m release --editor=n --tools=n   # без редактора и утилит
xmake
```

Опции: `--tests=y|n` (по умолчанию n), `--editor=y|n` (y), `--tools=y|n` (y).
Режим задаётся через `-m debug|release`. После смены опций или режима запускай `xmake f -c`.

## Запуск

```
xmake run Empire.Release         # Release-сборка и запуск Empire.Game
xmake run Empire.Debug           # Debug-сборка и запуск Empire.Game под отладчиком
xmake run Empire.Game            # запуск в текущем режиме
xmake run Empire.Client
xmake run Empire.Server
xmake run Empire.Standalone --host      # аргументы после имени цели
xmake run Empire.Editor

xmake run Empire.Test            # Unit и Integration (нужен --tests=y)
xmake run Empire.Bench           # бенчмарки (нужен --tests=y)
xmake run Empire.Tests.Unit      # отдельный тест
```
