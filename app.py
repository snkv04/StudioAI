from flask import Flask, request, jsonify

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
    print(f"the text from the python backend is: {text}")

    if text:
        return jsonify({"imageURL": text})
    else:
        return jsonify({"error": "Prompt text cannot be empty."}), 400