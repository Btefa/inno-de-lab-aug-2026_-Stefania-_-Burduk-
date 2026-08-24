first_number = float(input("Введите первое число: "))
second_number = float(input("Введите второе число: "))
arithmetic_operation = input("Выберите оператор (+, -, *, /): ")

if arithmetic_operation == "+":
    result = first_number + second_number
    print(f"Результат: {result}")

elif arithmetic_operation == "-":
    result = first_number - second_number
    print(f"Результат: {result}")

elif arithmetic_operation == "*":
    result = first_number * second_number
    print(f"Результат: {result}")

elif arithmetic_operation == "/":
    if second_number == 0:
        print("Ошибка: деление на ноль невозможно")
    else:
        result = first_number / second_number
        print(f"Результат: {result}")

else:
    print("Ошибка: неверно выбранная операция. Используйте +, -, *, /")