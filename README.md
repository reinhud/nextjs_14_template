# Next.js App Template 🚀

This repository contains a Next.js application template designed for both development and production environments. It utilizes TypeScript 📚 and is configured with ESLint and Prettier ✨ for code quality and formatting. The project is set up to be developed inside a DevContainer 📦, ensuring a consistent and isolated development environment.

## Features 🌟

- **TypeScript**: Strongly typed language that builds on JavaScript, giving you better tooling at any scale.
- **ESLint with Prettier**: Linting and code formatting are set up to maintain code quality and consistency.
- **DevContainer**: Containerized development environment for consistent setup and configurations.
- **Next.js**: A powerful React framework that enables functionality such as server-side rendering and generating static websites.

## Getting Started 🚀

### Prerequisites 📋

Ensure you have the following installed:
- Docker 
- Visual Studio Code 
- Remote - Containers extension for VS Code

### Setting Up the Development Environment 🛠️

1. **Open the project in VS Code**: 
   Open the root directory of the project in Visual Studio Code.

2. **Start the DevContainer**:
   Use the Remote - Containers extension in VS Code to reopen the project inside the DevContainer. This will create an isolated development environment with all necessary dependencies.

3. **Developing inside the container**:
   Once the container is running, you can start the development server with the following command:

    ```bash
    cd /workspace/next-app && pnpm dev
    ```

   This command is also set as the `postCreateCommand` in the `.devcontainer.json`, so it runs automatically when the container starts.

### Building and Running for Production 🏗️

#### Building the Application:
To build the application for production, run:

    ```bash
    docker build -t <your-image-name> .
    ```

   This command compiles your Next.js application and prepares it for deployment.

#### Starting the Application:
After building, you can start your application in production mode with:
    
    ```bash
    docker run -p <host-port>:<container-port> <your-image-name>

    # Example
    docker run -p 3000:3000 prod-test
    ```

   This starts the Next.js server on the specified port (default: 3000).

## Scripts 📜

- `pnpm dev`: Starts the development server.
- `pnpm build`: Builds the application for production.
- `pnpm start`: Runs the built app in production mode.
- `pnpm lint`: Runs ESLint for code quality checks.
- `pnpm prettier-format`: Formats code using Prettier.

## Contributing 🤝

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting pull requests.

## License 📄

This project is licensed under the [MIT License](LICENSE).
