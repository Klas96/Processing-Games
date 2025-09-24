from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn
import re
import os
import google.generativeai as genai

app = FastAPI()

class Game(BaseModel):
    game_name: str
    game_script_content: str

class GamePrompt(BaseModel):
    prompt: str

def sanitize_filename(name: str) -> str:
    """Sanitizes a string to be used as a filename."""
    if not name:
        return "new_game.html"
    # Replace spaces with underscores
    name = name.replace(" ", "_")
    # Remove non-alphanumeric characters except underscores and hyphens
    name = re.sub(r"[^\w\s-]", "", name)
    # Ensure it's not empty after sanitization
    if not name:
        name = "untitled_game"
    return name + ".html"

@app.post("/generate_game")
async def generate_game_endpoint(prompt_data: GamePrompt):
    try:
        # Configure the generative AI model
        genai.configure(api_key=os.environ["GEMINI_API_KEY"])
        model = genai.GenerativeModel('gemini-1.5-flash')

        # Generate game code
        response = model.generate_content(f"Generate a simple game in Processing.js based on the following prompt: {prompt_data.prompt}")
        game_code = response.text

        # Extract game name from the prompt
        game_name = " ".join(prompt_data.prompt.split()[:3]) # Use first 3 words of prompt as name
        filename = sanitize_filename(game_name)

        if os.path.exists(filename):
            raise HTTPException(status_code=409, detail=f"File '{filename}' already exists.")

        html_content = f"""<!DOCTYPE html>
<html>
<head>
    <title>{game_name}</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/processing.js/1.6.0/processing.min.js"></script>
    <link href="style.css" rel="stylesheet">
</head>
<body>
    <h1>{game_name}</h1>
    <script type="application/processing">
    {game_code}
    </script>
    <canvas></canvas>
</body>
</html>"""

        with open(filename, "w") as f:
            f.write(html_content)
        return {"message": f"Game '{game_name}' created successfully as '{filename}'", "file_path": filename}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/add_game")
async def add_game_endpoint(game: Game):
    if not game.game_name:
        pass # Handled by sanitize_filename default

    filename = sanitize_filename(game.game_name)

    if os.path.exists(filename):
        raise HTTPException(status_code=409, detail=f"File '{filename}' already exists.")

    html_content = f"""<!DOCTYPE html>
<html>
<head>
    <title>{game.game_name}</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/processing.js/1.6.0/processing.min.js"></script>
    <link href="style.css" rel="stylesheet">
</head>
<body>
    <h1>{game.game_name}</h1>
    <script type="application/processing">
    {game.game_script_content}
    </script>
    <canvas></canvas>
</body>
</html>"""

    try:
        with open(filename, "w") as f:
            f.write(html_content)
        return {"message": f"Game '{game.game_name}' created successfully as '{filename}'", "file_path": filename}
    except IOError:
        raise HTTPException(status_code=500, detail="Could not create game file.")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
