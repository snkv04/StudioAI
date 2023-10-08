from flask import Flask, request, jsonify
import time

app = Flask(__name__)

if __name__ == "__main__":
    app.run()

# @app.route("/")
# def hello_world():
#     return "Hello, world!"

@app.route("/api/generate_image", methods=["POST"])
def fetch_image():
    data = request.get_json()
    text = data.get("text")

    if text:
        return jsonify({"imageURL" : generate_image(text)})
    else:
        return jsonify({"error": "Prompt text cannot be empty."}), 400
    
pregenerated_images = {
    "green plants on mars" : "https://i.imgur.com/KTyytF6.png",
    "flying giraffe" : "https://i.imgur.com/ltzPt9T.png",
    "alan turing" : "https://i.imgur.com/Lf4iaVa.png",
    "lions in a savannah" : "https://i.imgur.com/QcjYOqz.png",
    "technologically futuristic city" : "https://i.imgur.com/qirietx.png",
    "random" : "https://i.imgur.com/uciYqr1.png",
    "autumn forest landscape" : "https://i.imgur.com/8evaUhU.png",
    "futuristic city" : "https://i.imgur.com/9P5AeBZ.png",
}
    
def generate_image(prompt):
    # infeasible to access actual third-party image generation software, unfortunately
    # code would go here
    time.sleep(6)
    if (prompt in pregenerated_images):
        return pregenerated_images[prompt]
    else:
        return pregenerated_images["random"]