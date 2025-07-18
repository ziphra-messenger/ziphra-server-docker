version: "3.9"
services:
  appserver:
    image: ziphramessenger/ziphra-server-appserver:latest
    ports:
      - "8080:8080"
      MODULE_IDSPROVIDER__PORT: ${MODULE_IDSPROVIDER__PORT}

  messaging:
    image: ziphramessenger/ziphra-server-messaging:latest
      MODULE_APPSERVER__PORT: ${MODULE_APPSERVER__PORT}
      MODULE_IDSPROVIDER: ${MODULE_IDSPROVIDER}
      MODULE_SESSIONMANAGER: ${MODULE_SESSIONMANAGER}
      MODULE_REQUESTID: ${MODULE_REQUESTID}
      MODULE_MESSAGING: ${MODULE_MESSAGING}

  idsprovider:
    image: ziphramessenger/ziphra-server-idsprovider:latest
      MODULE_MESSAGING__PORT: ${MODULE_MESSAGING__PORT}
      MODULE_SESSIONMANAGER: ${MODULE_SESSIONMANAGER}


  sessionmanager:
    image: ziphramessenger/ziphra-server-sessionmanager:latest
    environment:
      MODULE_SESSIONMANAGER__PORT: ${MODULE_SESSIONMANAGER__PORT}
      MODULE_SESSIONMANAGER__JWT: ${MODULE_SESSIONMANAGER__JWT}
  mongo:
    image: mongo:6.0

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: sec
