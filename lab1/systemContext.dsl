workspace {
    name "LeaderTask Architecture"
    description "Архитектура системы управления задачами LeaderTask.ru"

    model {
        # People/Actors (updated to match readme roles)
        sysadmin = person "Системный администратор" "Управление конфигурацией системы, контроль доступа, мониторинг производительности"
        projectManager = person "Руководитель проекта" "Создание и управление проектами, назначение задач, контроль выполнения"
        teamMember = person "Участник команды" "Выполнение задач, обновление статусов, взаимодействие с командой"
        client = person "Клиент" "Просмотр прогресса проекта, доступ к документам, коммуникация с командой"
        
        # External Systems (expanded based on readme)
        authSystem = softwareSystem "Система аутентификации" "Обработка аутентификации, управление сессиями, интеграция с SSO"
        fileStorage = softwareSystem "Система хранения файлов" "Хранение документов и вложений, управление версиями"
        notificationSystem = softwareSystem "Система уведомлений" "Отправка email и push-уведомлений, управление оповещениями"
        analyticsSystem = softwareSystem "Система аналитики" "Сбор метрик производительности, формирование отчетов"
        
        # LeaderTask System (updated description)
        leaderTask = softwareSystem "LeaderTask" "Платформа для управления задачами и командного взаимодействия с функциями управления проектами, контроля версий и аналитикой" {
            # Containers (aligned with readme architecture)
            webInterface = container "Веб-интерфейс" "Адаптивный веб-интерфейс с обновлениями в реальном времени" "React, TypeScript"
            mobileApp = container "Мобильное приложение" "Кроссплатформенное мобильное приложение" "Flutter"
            apiGateway = container "API Gateway" "Единая точка входа для всех API-запросов" "Node.js"
            taskService = container "Сервис задач" "Управление жизненным циклом задач и проектов" "Java, Spring Boot"
            authService = container "Сервис аутентификации" "Управление пользователями и правами доступа" "Go"
            analyticsService = container "Сервис аналитики" "Генерация отчетов и метрик производительности" "Python"
            database = container "База данных" "Хранение данных о проектах, задачах и пользователях" "PostgreSQL"
        }

        # Relationships (updated based on readme flows)
        sysadmin -> leaderTask "Конфигурирует и мониторит"
        projectManager -> leaderTask "Управляет проектами"
        teamMember -> leaderTask "Выполняет задачи"
        client -> leaderTask "Получает обновления"
        
        webInterface -> apiGateway "HTTPS"
        mobileApp -> apiGateway "HTTPS"
        apiGateway -> taskService "gRPC"
        apiGateway -> authService "gRPC"
        apiGateway -> analyticsService "gRPC"
        taskService -> database "JDBC"
        authService -> authSystem "OAuth 2.0"
        taskService -> fileStorage "REST API"
        analyticsService -> analyticsSystem "Data Export"
        taskService -> notificationSystem "События задач"
    }

    views {
        systemContext leaderTask {
            include *
            autoLayout
            title "Контекстная диаграмма LeaderTask"
            description "Отображает ключевые роли, внешние системы и основные компоненты платформы"
        }
        theme default
    }
}