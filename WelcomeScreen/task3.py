# Написать программу для анализа конфигурации базы данных:
db_config = {
    "connection": {
        "host": "production-db.internal",
        "port": 5432,
        "user": "postgres"
    }
}
# Присваиваем вложенный словарь connection
connection = db_config["connection"]
# 1. Извлечь значения host и port из вложенного словаря connection.
host = connection.get("host")
port = connection.get("port")
print(host, port)
# 2. Безопасно проверить наличие ключа ssl_settings.
ssl_settings = db_config.get("ssl_settings", {})
print(ssl_settings)
# Если этот ключ или вложенный в него параметр ssl_mode отсутствуют, переменная должна принять дефолтное значение verify-full.
ssl_mode = ssl_settings.get("ssl_mode", "verify-full")
print(ssl_mode)
# 3. Изменить значение пользователя (user) во вложенном словаре на admin.
connection["user"] = "admin"
print(connection["user"])
# 4. Добавить новый параметр max_connections со значением 100 непосредственно во вложенный словарь connection.
connection["max_connections"] = 100
print(connection["max_connections"])
# 5. Вывести обновленное содержимое конфигурации connection, используя итерацию по парам ключ-значение.
for k, v in connection.items():
    print(f"* {k}: {v}")
# Конфигурационный словарь, полученный от сервиса инициализации
print(f"SSL Mode: {ssl_mode}")
print("Параметры соединения:")
for k, v in connection.items():
    print(f"* {k}: {v}")