workspace {
    name "LeaderTask Container Diagram"
    description "Контейнерная диаграмма системы управления задачами LeaderTask.ru"

    model {
        # Основная система
        leaderTask = softwareSystem "LeaderTask" "Система управления задачами и командного взаимодействия" {
            # Контейнеры
            userContainer = container "User Container" "Управление пользователями, профилями, ролями" "Java, Spring Boot" {
                tags "Microservice"
            }
            
            taskContainer = container "Task Container" "Управление задачами, статусами, приоритетами" "Node.js, Express" {
                tags "Microservice"
            }
            
            projectContainer = container "Project Container" "Управление проектами, этапами, сроками" "Python, Django" {
                tags "Microservice"
            }
            
            notificationContainer = container "Notification Container" "Обработка уведомлений" "Go" {
                tags "Microservice"
            }
            
            fileContainer = container "File Container" "Управление документами и вложениями" ".NET Core" {
                tags "Microservice"
            }
            
            analyticsContainer = container "Analytics Container" "Сбор метрик, формирование отчетов" "Python, Pandas" {
                tags "Microservice"
            }
            
            webInterface = container "Web Interface" "Веб-интерфейс для пользователей" "React, TypeScript" {
                tags "Frontend"
            }
            
            apiGateway = container "API Gateway" "Единая точка входа для API" "Node.js, Express Gateway" {
                tags "Infrastructure"
            }
            
            database = container "Database" "Хранение данных системы" "PostgreSQL" {
                tags "Database"
            }
            
            messageQueue = container "Message Queue" "Асинхронный обмен сообщениями" "RabbitMQ" {
                tags "Infrastructure"
            }
            
            cache = container "Cache" "Кэширование данных" "Redis" {
                tags "Infrastructure"
            }
        }
        
        # Взаимодействие веб-интерфейса с API
        webInterface -> apiGateway "Отправляет запросы" "HTTPS/JSON"
        
        # Взаимодействие API Gateway с микросервисами
        apiGateway -> userContainer "Маршрутизирует запросы" "REST/JSON"
        apiGateway -> taskContainer "Маршрутизирует запросы" "REST/JSON"
        apiGateway -> projectContainer "Маршрутизирует запросы" "REST/JSON"
        apiGateway -> fileContainer "Маршрутизирует запросы" "REST/JSON"
        apiGateway -> analyticsContainer "Маршрутизирует запросы" "REST/JSON"
        
        # Взаимодействие между контейнерами
        userContainer -> taskContainer "Передает информацию о пользователе" "REST/JSON"
        userContainer -> projectContainer "Авторизует доступ к проектам" "REST/JSON"
        taskContainer -> projectContainer "Обновляет статус проекта" "Async/MessageQueue"
        taskContainer -> notificationContainer "Отправляет уведомления" "Async/MessageQueue"
        projectContainer -> notificationContainer "Отправляет уведомления" "Async/MessageQueue"
        fileContainer -> taskContainer "Прикрепляет файлы к задачам" "REST/JSON"
        analyticsContainer -> projectContainer "Собирает метрики" "Batch Processing"
        analyticsContainer -> taskContainer "Анализирует выполнение" "Batch Processing"
        notificationContainer -> userContainer "Доставляет уведомления" "WebSockets"
        
        # Взаимодействие с базой данных и кэшем
        userContainer -> database "Читает/пишет данные" "JDBC/SQL"
        taskContainer -> database "Читает/пишет данные" "ORM/SQL"
        projectContainer -> database "Читает/пишет данные" "ORM/SQL"
        fileContainer -> database "Читает/пишет метаданные" "ORM/SQL"
        analyticsContainer -> database "Читает данные" "SQL/Batch Queries"
        
        taskContainer -> cache "Кэширует часто запрашиваемые данные" "Redis Protocol"
        userContainer -> cache "Кэширует сессии" "Redis Protocol"
        
        # Взаимодействие с очередью сообщений
        taskContainer -> messageQueue "Публикует события" "AMQP"
        projectContainer -> messageQueue "Публикует события" "AMQP"
        notificationContainer -> messageQueue "Подписывается на события" "AMQP"
    }

    views {
        container leaderTask {
            include *
            autoLayout
            title "Контейнерная диаграмма LeaderTask"
            description "Детализирует внутреннюю архитектуру системы LeaderTask"
        }
        
        theme default
    }
}