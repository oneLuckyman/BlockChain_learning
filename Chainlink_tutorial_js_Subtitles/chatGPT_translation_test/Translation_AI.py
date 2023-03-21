# https://platform.openai.com/docs/quickstart/build-your-application
from dotenv.main import load_dotenv
import openai
import os

load_dotenv()
os.environ["http_proxy"] = os.environ["PROXY_PORT1"]
os.environ["https_proxy"] = os.environ["PROXY_PORT1"]
openai.api_key = os.environ["OPENAI_API_KEY1"]


question = "Now, there's a couple other tasks that are really helpful.\
You'll see before I went ahead and just\
deleted artifacts and deleted the cache manually. Well, to do\
that yourself, you can also just run yarn Hardhead, clean. And\
that'll delete the artifacts folder and clear out your cache."

response = openai.ChatCompletion.create(
    model = "gpt-3.5-turbo",
    messages = [
        {"role": "system", "content": "你是一个 AI 语音翻译助手，通过接收已经识别好的语音材料文本，给出相应的翻译。注意，识别可能存在错误，你可以根据上下文进行合理的推测和修改。"},
        {"role": "user", "content": "帮我把这一段字幕文件翻译成中文" + question}
    ]
)

result = ''
for choice in response.choices:
    result += choice.message.content
print(result)