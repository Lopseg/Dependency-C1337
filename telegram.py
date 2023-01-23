#!/usr/bin/python3
import requests
import sys

def telegram_bot_sendtext(bot_message):
    bot_token = '780751235:AAHXpnznL1qQaeU0H8EknZXmfQ8zFjVPK0Q'
    bot_chatID = '797658717'
    send_text = 'https://api.telegram.org/bot' + bot_token + '/sendMessage?chat_id=' + bot_chatID + '&parse_mode=Markdown&text=' + bot_message

    response = requests.get(send_text)
    return response.json()
    

test = telegram_bot_sendtext(sys.argv[1])
