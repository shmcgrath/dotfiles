import datetime

def GetTodayString():
    today = datetime.datetime.now().strftime('%Y-%m-%d %H.%M')
    today = str(today)
    return today
