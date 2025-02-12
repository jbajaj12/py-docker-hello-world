import os  # Import OS module to access environment variables  
from flask import Flask, jsonify  # Import Flask framework and JSON response helper  

# Create a Flask web application  
app = Flask(__name__)  

@app.route("/")  
def home():  
    # Return a JSON response  
    return jsonify(msg="Hello world!")  

if __name__ == "__main__":  
    # Run the app on all network interfaces (0.0.0.0)  
    # Use the PORT environment variable, defaulting to 8080 if not set  
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)), debug=True)