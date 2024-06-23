import string
import random


def random_token(count):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=count))
