# Список транзакций, полученных от платежного шлюза
raw_transactions = ["SUCCESS:100", "FAILED:50", "SUCCESS:-10", "SUCCESS:0", "SUCCESS:250", "ERROR:200"]
# Реализация фильтрации в одну строку с помощью List Comprehension
# Требуется написать однострочное выражение (генератор списка), которое:
# 1. Отсеивает все транзакции, не имеющие статус SUCCESS.
# 2. Извлекает числовое значение суммы платежа.
# 3. Исключает аномальные транзакции с неположительной суммой (меньше или равной нулю).
# 4. Преобразует корректные суммы в целочисленный тип данных (int).
# Ожидаемый результат - Очищенные транзакции: [100, 250]
cleaned_transactions = [int(value) for status_value in raw_transactions
                        if status_value.startswith("SUCCESS:")
                        and (value := status_value.split(":")[1])
                        and int(value) > 0]

print(f"Очищенные транзакции: {cleaned_transactions}")