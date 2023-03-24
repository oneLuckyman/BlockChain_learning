# https://platform.openai.com/docs/quickstart/build-your-application
# https://platform.openai.com/docs/guides/chat
from dotenv.main import load_dotenv
import os
import openai
from itertools import islice
import pysrt

load_dotenv()
os.environ["http_proxy"] = os.environ["PROXY_PORT1"]
os.environ["https_proxy"] = os.environ["PROXY_PORT1"]
openai.api_key = os.environ["OPENAI_API_KEY1"]

# if txt
# with open('./Learn Blockchain, Solidity, and Full Stack Web3 Development with JavaScript – 32-Hour Course - 英语.txt', 'r') as f:
#     lines = [line.strip() for line in islice(f, 0, 50) if line.strip()]

# if srt
subs = pysrt.open('./P75_6-12.srt')
lines = [sub.text for sub in subs]

prompt = ''.join(lines[:30])

response = openai.ChatCompletion.create(
    model = "gpt-3.5-turbo",
    messages = [
        {"role": "system", "content": "你是一个 AI 语音翻译助手，通过接收已经识别好的语音材料文本，给出相应的翻译。注意，识别可能存在错误，你可以根据上下文进行合理的推测和修改。"},
        {"role": "user", "content": "帮我把这一段字幕文件翻译成中文" + prompt}
    ]
)

result = ''
for choice in response.choices:
    result += choice.message.content
print(response.usage)
# print(result)

result = result.replace("。", "。\n")
with open('./Output.txt', 'w', encoding='utf-8') as f:
    f.write(result)