import vertexai

from vertexai.generative_models import GenerativeModel, Part

vertexai.init(project="PROJECT-ID", location="us-central1")

model = GenerativeModel(model_name="gemini-1.0-pro")

prompt = """
tell me a joke
"""

response = model.generate_content(
    [
        prompt
    ]
)

print(response.text)