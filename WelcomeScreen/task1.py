# Исходная необработанная строка из источника данных
raw_user_record = " 10827 ; aLeXanDer_vLaDimiRov ; mInSk ; ACTIVE "
# Для решения необходимо использовать строковые методы .split(), .strip(), .replace(), .title(), .upper(), .lower(), .join() и f-строки.
# 1. Разбить строку на отдельные элементы, используя точку с запятой (;) в качестве разделителя.
parts = raw_user_record.split(";")
print(parts)
# 2. Очистить каждый полученный элемент от ведущих и замыкающих пробельных символов.
cleaned_parts = []
for part in parts:
    cleaned_parts.append(part.strip())
print(cleaned_parts)
# 3. Применить к идентификатору пользователя (первый элемент) префикс UID-, используя форматирование строк.
uid = f"UID-{cleaned_parts[0]}"
print(uid)
# 4. Преобразовать имя пользователя (второй элемент), заменив символ нижнего подчеркивания ( _ ) на пробел,
# и привести слова к правильному регистру (каждое слово с заглавной буквы).
user_name = cleaned_parts[1].replace("_", " ").title()
print(user_name)
# 5. Привести название города (третий элемент) к верхнему регистру.
city = cleaned_parts[2].upper()
print(city)
# 6. Статус пользователя (четвертый элемент) перевести в нижний регистр.
status = cleaned_parts[3].lower()
print(status)
# 7. Объединить обработанные элементы в одну строку с разделителем | и вывести результат на экран.
refined_user_record = " | ".join([uid, user_name, city, status])
# Нормализованная запись: UID-10827 | Alexander Vladimirov | MINSK | active
print(refined_user_record)
