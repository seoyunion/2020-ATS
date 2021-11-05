## examples from: 파이썬 코딩 도장(publisher: 길벗)


def number_generator():
    yield 0  # return 0 to outside of the function,
    yield 1           ## and yield the execution of function to the outside of the function
    yield 2
#generator는 return 대신에 yield 사용
#yield: 계산한 값을 return 하는 것이 아니라, 이 계산들을 함수 밖에서 계산하도록 양보하겠다는 뜻

g = number_generator()
for i in g:
    print(i) #g에 있는 것 하나씩 출력 -> 0,1,2 순서로 출력

print(next(g))  # get yielded value through next function


def number_generator(): #for문을 이용한 더 효율적인 방식
    x = [1, 2, 3]
    for i in x:
        yield i


for i in number_generator():
    print(i)


def number_generator():
    x = [1, 2, 3]
    yield from x  # 리스트에 들어있는 요소를 한 개씩 바깥으로 전달


for i in number_generator():
    print(i)





