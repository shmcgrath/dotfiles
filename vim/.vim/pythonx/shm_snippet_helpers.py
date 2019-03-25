import datetime

def GetTodayString():
    today = datetime.datetime.now().strftime('%Y-%m-%d %H.%M')
    today = str(today)
    return today


def HighPlusDifference(low, high):
    difference = high - low
    total = high + difference
    return total
