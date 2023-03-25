# https://platform.openai.com/docs/quickstart/build-your-application
# https://platform.openai.com/docs/guides/chat
from dotenv.main import load_dotenv
import os
import openai
from itertools import islice
import pysrt

load_dotenv()
os.environ["http_proxy"] = os.environ["PROXY_PORT2"]
os.environ["https_proxy"] = os.environ["PROXY_PORT2"]
openai.api_key = os.environ["OPENAI_API_KEY1"]

# if txt
# with open('./Learn Blockchain, Solidity, and Full Stack Web3 Development with JavaScript – 32-Hour Course - 英语.txt', 'r') as f:
#     lines = [line.strip() for line in islice(f, 0, 50) if line.strip()]

# if srt
subs = pysrt.open('./test.srt')
lines = [str(sub) for sub in subs]
example_subs = pysrt.open('./example.srt')
example_lines = [str(sub) for sub in example_subs]

example = ''.join(example_lines)
prompt = ''.join(lines[0:30])

response = openai.ChatCompletion.create(
    model = "gpt-3.5-turbo",
    messages = [
        {"role": "system", "content": "你是一个 AI 智能语音翻译助手，通过接收已经识别好的英语语音字幕文本，给出相应的汉语翻译，\
         注意以下几点：\
         第一，这些文本都是人说的话而非文章所以风格会略微口语化一些。\
         第二，这些字幕文本来自于一个关于区块链和智能合约编程的教程，这就是这些文本的话题背景。\
         第三，识别可能存在错误，你可以根据上下文以及其话题背景进行合理且适当的推测和修改。\
         这是一个已经完成翻译的字幕文件，你可以参考一下：\n{}\
         ".format(example)},
        {"role": "user", "content": "帮我把这一段字幕文件翻译成中文：\n" + prompt}
    ]
)

result = ''
for choice in response.choices:
    result += choice.message.content
print(response.usage)
# print(result)

result = result.replace("。", "。\n")
with open('./Output.txt', 'a', encoding='utf-8') as f:
    f.write(result + '\n')

with open('./log.txt', 'a', encoding='utf-8') as f:
    print(response.usage, file=f)