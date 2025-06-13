from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn
import re
import os

app = FastAPI()

class Game(BaseModel):
    game_name: str
    game_script_content: str

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

@app.post("/add_game")
async def add_game_endpoint(game: Game):
    if not game.game_name:
        # Return an error or use a default name if game_name is not provided
        # For this implementation, let's use a default name via sanitize_filename
        # Or, alternatively, raise an HTTPException:
        # raise HTTPException(status_code=400, detail="Game name is required.")
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
