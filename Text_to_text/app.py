import torch
from flask import Flask, request, jsonify
from transformers import AutoModelForSeq2SeqLM, AutoTokenizer
from IndicTransToolkit.processor import IndicProcessor

app = Flask(__name__)

# Load the model and tokenizer
model_name = "ai4bharat/indictrans2-indic-en-dist-200M"
tokenizer = AutoTokenizer.from_pretrained(model_name, trust_remote_code=True)
model = AutoModelForSeq2SeqLM.from_pretrained(model_name, trust_remote_code=True)

# Initialize the IndicProcessor for preprocessing and postprocessing
ip = IndicProcessor(inference=True)

# Supported languages
supported_languages = {
    "Hindi": "hin_Deva",
    "Tamil": "tam_Taml",
    "Malayalam": "mal_Mlym",
    # Add more languages as needed
}

# Function to dynamically choose the source language and translate
def translate_sentences(input_sentences, src_lang_name):
    src_lang = supported_languages.get(src_lang_name)
    if not src_lang:
        return {"error": f"Language {src_lang_name} is not supported."}
    
    tgt_lang = "eng_Latn"  # Translate to English
    
    # Preprocess the input sentences
    batch = ip.preprocess_batch(input_sentences, src_lang=src_lang, tgt_lang=tgt_lang)
    
    DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
    
    # Tokenize the sentences and generate input encodings
    inputs = tokenizer(batch, truncation=True, padding="longest", return_tensors="pt").to(DEVICE)
    
    # Generate translations using the model
    with torch.no_grad():
        generated_tokens = model.generate(
            **inputs, use_cache=True, min_length=0, max_length=256, num_beams=5, num_return_sequences=1
        )
    
    # Decode the generated tokens into text
    with tokenizer.as_target_tokenizer():
        generated_tokens = tokenizer.batch_decode(
            generated_tokens.detach().cpu().tolist(), skip_special_tokens=True, clean_up_tokenization_spaces=True
        )
    
    # Postprocess the translations
    translations = ip.postprocess_batch(generated_tokens, lang=tgt_lang)
    
    return translations

# API endpoint to handle POST requests
@app.route("/translate", methods=["POST"])
def translate():
    data = request.json
    input_text = data.get("text")
    language = data.get("language")
    
    if not input_text or not language:
        return jsonify({"error": "Missing text or language in the request."}), 400
    
    # Translate the input text
    translation = translate_sentences([input_text], language)
    
    # Check for language support error
    if isinstance(translation, dict) and "error" in translation:
        return jsonify(translation), 400
    
    # Return the translation
    return jsonify({"original_text": input_text, "translated_text": translation[0], "language": language})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
