workspace "LeaderTask Dynamic Diagram" "Dynamic diagram for project creation scenario" {
    model {
        user = person "Project Manager" "Initiates project creation"

        leaderTask = softwareSystem "LeaderTask" "Task management platform" {
            webInterface = container "Web Interface" "Provides UI for users" "React/TypeScript"
            apiGateway = container "API Gateway" "Routes requests from the web interface to services" "HTTPS/JSON"
            projectService = container "Project Container" "Manages projects and their parameters" "REST/JSON"
            database = container "Database" "Stores project, task, and user data" "SQL/ORM"
            notificationService = container "Notification Container" "Processes notifications and dispatches events" "AMQP, WebSockets"
        }

        user -> webInterface "Opens 'Projects' section and starts a new project"
        webInterface -> apiGateway "Sends a request to create a project"
        apiGateway -> projectService "Routes the request to the project management service"
        projectService -> database "Saves project data"
        projectService -> notificationService "Sends notification about the new project"
        notificationService -> webInterface "Push notification: new project created"
    }

    views {
        dynamic leaderTask "create_project" {
            //title "Scenario: Creating a new project by the Project Manager"
            title "Сценарий"

            user -> webInterface "Opens 'Projects' section and starts a new project"
            webInterface -> apiGateway "Sends a request to create a project"
            apiGateway -> projectService "Routes the request to the project management service"
            projectService -> database "Saves project data"
            projectService -> notificationService "Sends notification about the new project"
            notificationService -> webInterface "Push notification: new project created"
        }
    }
}
