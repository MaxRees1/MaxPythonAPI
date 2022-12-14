
from asyncio import constants
from hashlib import new
import json, uuid

from random import randint
from flask import Flask, jsonify, request
#import pandas as pd
from azure.cosmos import CosmosClient

import os

main = Flask(__name__)




#games = [{'playerid': "1",
 #        'name': "Ola",
  #       'level': "10"},
   #     {'Playerid': "2",
    #     'name': "Ilyas",
     #    'level': "15"},
      #  {'Playerid': "3",
       #  'name': "Max",
        # 'level': "20"}
       # ]


@main.route('/')
def index():
    return "Welcome to the API"

@main.route("/players", methods=['GET'])
def get ():
    players = []

    results = container.query_items('SELECT * FROM c', enable_cross_partition_query=True)

    for doc in results:

            print (doc)

            player = {

                'playerid': doc['id'],

                 'name': doc['name'],

                 'level': doc['level']

                 

            }

            players.append(player)

            


    return jsonify({'players': players})

@main.route("/players", methods=['POST'])

def create():

    req_data = request.get_json()

    new_results = {

        'id': req_data['playerid'],

        'name': req_data['name'],

        'level': req_data['level'],

        

    }

    document_id = container.create_item(new_results, populate_query_metrics=True)

    return str(document_id)

if __name__ == "__main__":

    config = {
            'PRIMARYKEY': os.environ['primarykey'],
            'ENDPOINT': os.environ['cosmosurl'],
            'DATABASE': 'maxdb',
            'CONTAINER': 'Items'
    }

    client = CosmosClient(url=config['ENDPOINT'], credential=config['PRIMARYKEY'])

    db = client.get_database_client(config['DATABASE'])
    container = db.get_container_client(config['CONTAINER'])

    main.run(host='0.0.0.0',debug=True,port='8000')

