from langchain_ollama.llms import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate
from vector import retriever

model = OllamaLLM(model="llama3.2:1b")

template = """
You are an expert at calculating the protein, carbohydrate, and fat content of meals. Here is some relevent data: {data}
Here is the question to answer: {question}
"""

prompt = ChatPromptTemplate.from_template(template)
chain = prompt | model

while True: 
    print("\n\n--------------------------")
    question = input("Describe your meal. (q to quit):")
    print("\n\n")
    if question == "q":
        break

    data = retriever.invoke(question)
    result = chain.invoke({"data": data, "question": question})
    print(result)