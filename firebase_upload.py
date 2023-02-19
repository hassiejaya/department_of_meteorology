import datetime
import time
import pyrebase

firebaseConfig = {
    "apiKey": "AIzaSyDFlxcRFrKaG1C-yDFDrSAnphJspqe1pTY",
    "authDomain": "dept-of-met.firebaseapp.com",
    "databaseURL": "https://dept-of-met-default-rtdb.asia-southeast1.firebasedatabase.app",
    "projectId": "dept-of-met",
    "storageBucket": "dept-of-met.appspot.com",
    "messagingSenderId": "319565145442",
    "appId": "1:319565145442:web:bbc58914d17a32800d383b"
}

firebase = pyrebase.initialize_app(firebaseConfig)
db = firebase.database()


def get_time():
    current_time = str(time.localtime().tm_year) + ' ' + str(time.localtime().tm_mon) + ' ' + str(
        time.localtime().tm_mday) + '    ' + str(time.localtime().tm_hour) + ':' + str(time.localtime().tm_min)
    return current_time


def set_temp(temperature):
    try:
        db.child("envData").update(
            {"temp": "{}".format(temperature), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)


def set_humidity(_humidity):
    try:
        db.child("envData").update(
            {"humidity": "{}".format(_humidity), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)


def set_rainfall(_rainfall):
    try:
        db.child("envData").update(
            {"rainfall": "{}".format(_rainfall), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)


def set_solar_irradiation(_solar_irradiation):
    try:
        db.child("envData").update(
            {"solar-irradiation": "{}".format(_solar_irradiation), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)


def set_light_intensity(_light_intensity):
    try:
        db.child("envData").update(
            {"light-intensity": "{}".format(_light_intensity), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)


def set_wind_speed(_wind_speed):
    try:
        db.child("envData").update(
            {"wind-speed": "{}".format(_wind_speed), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)


def set_wind_direction(_wind_direction):
    try:
        db.child("envData").update(
            {"wind-direction": "{}".format(_wind_direction), "date-time": "{}".format(get_time())}
        )
    except Exception:
        print(Exception)

