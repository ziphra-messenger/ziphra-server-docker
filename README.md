# 🐳 Ziphra Messenger - Server Docker Setup

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

## 🔗 Reference Files

You can find examples of the key files used in this project here:

* [startup.bat (Windows)](https://github.com/ziphra-messenger/ziphra-server-docker/blob/main/startup.bat)
* [startup.sh (Linux/macOS)](https://github.com/ziphra-messenger/ziphra-server-docker/blob/main/startup.sh)
* [docker-compose.yml](https://github.com/ziphra-messenger/ziphra-server-docker/blob/main/docker-compose.yml)

These files contain the full configuration and environment setup required to run the system locally.

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

## ⚖️ Docker Compose Overview

The `docker-compose.yml` file defines all required services and their dependencies:

### Core Services

* **MySQL** (`ziphra-mysql`) - database service
* **MongoDB** (`ziphra-mongo`) - NoSQL document store

> ⚠️ **Note**: These databases are only accessible from within the Docker network. They cannot be accessed externally for security reasons.

### Ziphra Modules

* **App Server** (`ziphra-appserver`)
* **Messaging** (`ziphra-messaging`)
* **Session Manager** (`ziphra-sessionmanager`)
* **IDS Provider** (`ziphra-idsprovider`)

All modules share common environment variables for database access and internal communication.

### Shared Settings

* MySQL root password: `root`
* MySQL database: `sec`
* MongoDB root username/password: `root`
* All services are connected via the custom Docker network `ziphra-net`.
* Data is persisted via Docker volumes `mysql_data` and `mongo_data`.

Make sure to review port mappings inside each service definition and adjust them to avoid conflicts.

---

## 👏 Tips

* Ensure that the required ports are free on your machine.
* Run `docker-compose down -v` to clear volumes if you need a fresh start.
* Use `docker-compose logs -f` to view live logs from all services.

---

## 🧑‍💻 Contributions

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or a pull request.

---

## 📄 License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
