# 🐳 Ziphra Project - Docker Setup

This repository contains all the services required to run the Ziphra system using Docker containers. Two startup scripts are included: `startup.bat` (for Windows) and `startup.sh` (for Linux/macOS), which are responsible for loading the necessary environment variables.

---

## 📦 Requirements

* Docker ([https://www.docker.com/](https://www.docker.com/))
* Docker Compose
* Git (optional, to clone the repository)

---

## ⚙️ Environment Variables Configuration

Before running the services, you must define a series of environment variables. These variables are used by each module to configure their ports and base URLs.

### Required variables:

| Variable                      | Description                             |
| ----------------------------- | --------------------------------------- |
| `MODULE_IDSPROVIDER__PORT`    | Port for the IDS Provider module        |
| `MODULE_SESSIONMANAGER__PORT` | Port for the Session Manager module     |
| `MODULE_REQUESTID__PORT`      | Port for the Request ID module          |
| `MODULE_MESSAGING__PORT`      | Port for the Messaging module           |
| `MODULE_APPSERVER__PORT`      | Port for the App Server module          |
| `MODULE_IDSPROVIDER`          | Base URL for the IDS Provider module    |
| `MODULE_SESSIONMANAGER`       | Base URL for the Session Manager module |
| `MODULE_REQUESTID`            | Base URL for the Request ID module      |
| `MODULE_MESSAGING`            | Base URL for the Messaging module       |
| `MODULE_SESSIONMANAGER__JWT`  | JWT secret key for the Session Manager  |

These variables are set inside the startup scripts (`startup.bat` or `startup.sh`).

---

## 📝 Editing Startup Scripts

### On Windows

1. Open the `startup.bat` file.
2. Edit the variable definitions, for example:

```bat
set MODULE_IDSPROVIDER__PORT=8081
set MODULE_IDSPROVIDER=http://localhost:8081
...
```

3. Save the file.

### On Linux/macOS

1. Open the `startup.sh` file.
2. Edit the variable exports, for example:

```sh
export MODULE_IDSPROVIDER__PORT=8081
export MODULE_IDSPROVIDER=http://localhost:8081
...
```

3. Save the file and make it executable if necessary:

```sh
chmod +x startup.sh
```

---

## ▶️ Running the System

### On Windows

```cmd
startup.bat
docker-compose up
```

### On Linux/macOS

```bash
./startup.sh
docker-compose up
```

This will launch all the containers defined in the Docker configuration, using the environment variables loaded by the startup script.

---

## 🛑 Stopping the Services

To stop all running containers, use:

```bash
docker-compose down
```

---

## 🧩 Notes

* Make sure the ports defined in your environment variables are not in use by other services on your machine.
* If you only want to run a specific module, you can modify the `docker-compose.yml` file or use `docker run` with the required variables manually.
* You can check if the variables were correctly loaded by running `env` (Linux/macOS) or `set` (Windows) before executing Docker commands.

---

## 🧑‍💻 Contributions

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or a pull request.

---

## 📄 License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
