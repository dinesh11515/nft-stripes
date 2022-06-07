import json
IMAGES_BASE_URL = "ipfs://QmNcr1ZQ5e7MEwQKNpNBqWyjp5rUkFUWTJ8YB3AbAvG5hE/"
PROJECT_NAME = "STRIPES"
for i in range(1,31):
    data = {
        "image": IMAGES_BASE_URL + str(i) + '.jpg',
        "tokenId": i,
        "name": PROJECT_NAME + ' ' + str(i),
        "attributes": []
    }
    
    with open(str(i) + ".json", 'w') as outfile:
        json.dump(data,outfile)