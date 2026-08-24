import random

secret_number = random.randint(1, 20)
attempts = 5

print("Я загадал рандомное число от 1 до 20, и у тебя есть 5 попыток его отгадать!")

while attempts > 0:

    attempts -= 1
    entered_number = int(input("Введите число: "))

    if entered_number > secret_number:
        print("Слишком много!")
    elif entered_number < secret_number:
        print("Слишком мало!")
    else:
        print("Ты угадал! Отличная работа!")
        break

    if attempts == 0:
        print("Ты израсходовал все попытки. Загаданное число было:", secret_number)
    else:
        print(f"Осталось попыток: {attempts}")